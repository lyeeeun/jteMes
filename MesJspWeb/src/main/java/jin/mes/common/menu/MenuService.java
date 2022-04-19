package jin.mes.common.menu;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import jin.mes.common.msg.MsgViewRepository;
import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;
import kr.co.itcall.jte.spring.user.JteUserUtil;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MenuService {

//	private final String searchMenuFromRoles = "SELECT view.view_id, view.up_view_id, view.menu_cd, view.lvl, view.id_path, view.menu_id, view.menu_seq, view.dupl_yn, view.msg_id, view.msg_id_path, menu.svc_url, menu.view_url, msg.lang_cd, msg_view\r\n" + 
//			"FROM (\r\n" + 
//			"	-- 특정권한에 대한 소속메뉴 VIEW 출력하기(DEPTH구조로)\r\n" + 
//			"	WITH RECURSIVE menu_view AS \r\n" + 
//			"	( \r\n" + 
//			"		SELECT view_id, menu_cd, up_view_id, 0 AS lvl, CAST(view_id AS CHAR(100) CHARACTER SET utf8) id_path, menu_id, menu_seq, dupl_yn, msg_id, CAST('' AS CHAR(500) CHARACTER SET utf8) msg_id_path \r\n" + 
//			"			FROM cw_menu_view WHERE up_view_id IS NULL AND is_lock = FALSE AND role_id IN :roles\r\n" + 
//			"		UNION ALL \r\n" + 
//			"		SELECT p.view_id, p.menu_cd, p.up_view_id, 1+lvl AS lvl, CONCAT(menu_view.id_path, ',', p.view_id) id_path, p.menu_id, p.menu_seq, p.dupl_yn, p.msg_id, CONCAT(menu_view.msg_id_path, ',', p.msg_id) msg_id_path FROM cw_menu_view p \r\n" + 
//			"		INNER JOIN menu_view ON p.up_view_id = menu_view.view_id AND is_lock = FALSE AND role_id IN :roles\r\n" + 
//			"	) \r\n" + 
//			"	SELECT DISTINCT view_id, up_view_id,menu_cd, lvl, id_path, menu_id, menu_seq, dupl_yn, msg_id, RIGHT(msg_id_path, LENGTH(msg_id_path)-1) msg_id_path FROM menu_view\r\n" + 
//			") VIEW LEFT JOIN cw_menu_bas menu ON view.menu_id = menu.menu_id AND menu.is_lock = FALSE AND menu.is_del = FALSE\r\n" + 
//			"		LEFT JOIN cw_msg_view msg ON view.msg_id = msg.msg_id AND msg.lang_cd = :langCd\r\n" + 
//			"ORDER BY view.id_path, view.menu_seq";
	
	private final String searchMenuFromRoles = "WITH RECURSIVE menu_view AS ( \r\n"+
			"SELECT root.menu_id, root.up_menu_id, CAST(root.menu_seq AS CHAR(100) CHARACTER SET utf8) AS menu_path, IFNULL(rMsg.msg_view, root.menu_nm) AS menu_nm, root.svc_url, root.view_url, root.DESCRIPTION, root.dupl_yn, root.menu_cd \r\n"+ 
			"FROM cw_menu_bas root \r\n"+
			"LEFT OUTER JOIN cw_msg_view rMsg ON root.msg_id = rMsg.msg_id AND rMsg.lang_cd = :langCd \r\n"+
			"WHERE root.menu_id = 'root' \r\n"+
			"UNION ALL \r\n"+
			"SELECT menu.menu_id, menu.up_menu_id, CONCAT(mView.menu_path,';',menu.menu_seq) AS menu_path, IFNULL(bMsg.msg_view, menu.menu_nm)AS menu_nm, menu.svc_url, menu.view_url, menu.DESCRIPTION, menu.dupl_yn, menu.menu_cd \r\n"+ 
			"FROM cw_menu_bas menu \r\n"+
			"INNER JOIN cw_menu_view rtl ON menu.menu_id = rtl.menu_id AND rtl.role_id IN :roles AND menu.is_del = FALSE AND menu.is_lock = FALSE \r\n"+
			"LEFT OUTER JOIN cw_msg_view bMsg ON menu.msg_id = bMsg.msg_id AND bMsg.lang_cd = :langCd \r\n"+
			"INNER JOIN menu_view mView ON menu.up_menu_id = mView.menu_id \r\n"+
		")SELECT DISTINCT * FROM menu_view ORDER BY menu_path; ";
	
	@Autowired
	private EntityManagerFactory entityManagerFactory;

	@Autowired
	private MsgViewRepository msgViewRepository;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;

	public List<MyMenuVo> getMyMenuList() {
		UserSessionInfoVo userSessionInfoVo = JteUserUtil.getUserInfo();
		if(!StringUtils.isEmpty(userSessionInfoVo)) {
			return getMyMenuList(userSessionInfoVo.getUserInfo());
		}
		log.warn("Cannot found Session info with UserInfo [{}]", userSessionInfoVo);
		return null;
	}
	public List<MyMenuVo> getMyMenuList( UserInfoVo userInfoVo ) {
		
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		Query query = entityManager.createNativeQuery(searchMenuFromRoles, MyMenuVo.class);
		if(!StringUtils.isEmpty(userInfoVo)) {
			List<String> roles = new ArrayList<String>();
			userInfoVo.getRoles().stream().forEach(r-> roles.add(r.getRoleId()));
			log.debug("roles[{}]", roles);
			query.setParameter("roles", roles);
			query.setParameter("langCd", userInfoVo.getLangCd());
			List<MyMenuVo> menuList = query.getResultList();
			// getResultStream();
//			menuList.parallelStream().filter(m-> !StringUtils.isEmpty(m.getMenuId())).forEach(m-> {
//					m.setMsgViews(msgViewRepository.findByMsgViewPkMsgId(m.getMsgId()));
//					Arrays.stream(m.getMsgIdPath().split(",")).filter(p-> !StringUtils.isEmpty(p)).forEach(p-> m.setMsgViewPath((StringUtils.isEmpty(m.getMsgViewPath())?"":m.getMsgViewPath()+" > ") + messageSourceAccessor.getMessage(p, userInfoVo.getLangCd())));
//			});
			entityManager.close();
			return menuList;
		}
		return null;
	}

}
