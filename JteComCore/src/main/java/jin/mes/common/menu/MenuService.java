package jin.mes.common.menu;

import java.util.ArrayList;
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

	//root
	private final String searchMenuFromRoles = 
		"WITH RECURSIVE menu_view AS ( \r\n"
		+ "SELECT \r\n"
		+ "root.menu_id, \r\n"
		+ "root.up_menu_id, \r\n"
				+ "1 lvl, \r\n"
				+ "0 parent_seq, \r\n"		
				+ "root.menu_seq, \r\n"
				+ "CAST(root.menu_seq AS CHAR(100) CHARACTER SET utf8) AS menu_path, \r\n" 
				+ "IFNULL(rMsg.msg_view, root.menu_nm) AS menu_nm, \r\n"
				+ "root.svc_url, \r\n"
				+ "root.view_url, \r\n"
				+ "root.DESCRIPTION, \r\n"
				+ "root.dupl_yn, \r\n"
				+ "root.menu_cd, \r\n"
				+ "root.menu_std01, \r\n"
				+ "root.menu_std02, \r\n"
				+ "root.menu_std03, \r\n"
				+ "root.menu_std04, \r\n"
				+ "root.menu_std05, \r\n"
				+ "root.menu_std_str01, \r\n"
				+ "root.menu_std_str02, \r\n"
				+ "root.menu_std_str03, \r\n"
				+ "root.menu_std_str04, \r\n"
				+ "root.menu_std_str05 \r\n"
			+ "FROM cw_menu_bas root \r\n"
			+ "LEFT OUTER JOIN cw_msg_view rMsg ON CONCAT('mn_', root.menu_id) = rMsg.msg_id AND rMsg.lang_cd = :langCd \r\n"
			+ "WHERE root.menu_id = 'root' \r\n"
			+ "UNION ALL \r\n"
			+ "SELECT \r\n"
				+ "menu.menu_id, \r\n" 
				+ "menu.up_menu_id, \r\n"
				+ "mView.lvl +1 lvl, \r\n"
				+ "mView.menu_seq parent_seq, \r\n"
				+ "menu.menu_seq, \r\n"
				+ "CONCAT(mView.menu_path,';',menu.menu_seq) AS menu_path, \r\n" 
				+ "IFNULL(bMsg.msg_view, menu.menu_nm)AS menu_nm,  \r\n"
				+ "menu.svc_url, \r\n"
				+ "menu.view_url, \r\n"
				+ "menu.DESCRIPTION, \r\n"
				+ "menu.dupl_yn, \r\n"
				+ "menu.menu_cd, \r\n"
				+ "menu.menu_std01, \r\n"
				+ "menu.menu_std02, \r\n"
				+ "menu.menu_std03, \r\n"
				+ "menu.menu_std04, \r\n"
				+ "menu.menu_std05, \r\n"
				+ "menu.menu_std_str01, \r\n"
				+ "menu.menu_std_str02, \r\n"
				+ "menu.menu_std_str03, \r\n"
				+ "menu.menu_std_str04, \r\n"
				+ "menu.menu_std_str05 \r\n"
			+ "FROM cw_menu_bas menu \r\n"
			+ "INNER JOIN cw_menu_view rtl ON menu.menu_id = rtl.menu_id AND rtl.role_id IN :roles AND menu.is_del = FALSE AND menu.is_lock = FALSE \r\n" 
			+ "LEFT OUTER JOIN cw_msg_view bMsg ON CONCAT('mn_', menu.menu_id) = bMsg.msg_id AND bMsg.lang_cd = :langCd \r\n"
			+ "INNER JOIN menu_view mView ON menu.up_menu_id = mView.menu_id \r\n"
		+ ")SELECT DISTINCT * FROM menu_view  ORDER BY  lvl, parent_seq, menu_seq;";
	
	//admin
	private final String selectAdminMenu = 
		"WITH RECURSIVE menu_view AS ( \r\n" 
			+ "SELECT \r\n"
			+ "root.menu_id, \r\n"
			+ "root.up_menu_id, \r\n"
			+ "1 lvl, \r\n"
			+ "0 parent_seq, \r\n"		
			+ "root.menu_seq, \r\n"
			+ "CAST(root.menu_seq AS CHAR(100) CHARACTER SET utf8) AS menu_path, \r\n" 
			+ "IFNULL(rMsg.msg_view, root.menu_nm) AS menu_nm, \r\n"
			+ "root.svc_url, \r\n"
			+ "root.view_url, \r\n"
			+ "root.DESCRIPTION, \r\n"
			+ "root.dupl_yn, \r\n"
			+ "root.menu_cd, \r\n"
			+ "root.menu_std01, \r\n"
			+ "root.menu_std02, \r\n"
			+ "root.menu_std03, \r\n"
			+ "root.menu_std04, \r\n"
			+ "root.menu_std05, \r\n"
			+ "root.menu_std_str01, \r\n"
			+ "root.menu_std_str02, \r\n"
			+ "root.menu_std_str03, \r\n"
			+ "root.menu_std_str04, \r\n"
			+ "root.menu_std_str05 \r\n"
		+ "FROM cw_menu_bas_back root \r\n"
		+ "LEFT OUTER JOIN cw_msg_view rMsg ON CONCAT('mn_', root.menu_id) = rMsg.msg_id AND rMsg.lang_cd = 'ko' \r\n"
		+ "WHERE root.menu_id = 'admin' AND root.is_del = FALSE AND root.is_lock = FALSE \r\n"
		+ "UNION ALL \r\n"
		+ "SELECT \r\n"
			+ "menu.menu_id, \r\n" 
			+ "menu.up_menu_id, \r\n"
			+ "mView.lvl +1 lvl, \r\n"
			+ "mView.menu_seq parent_seq, \r\n"
			+ "menu.menu_seq, \r\n"
			+ "CONCAT(mView.menu_path,';',menu.menu_seq) AS menu_path, \r\n" 
			+ "IFNULL(bMsg.msg_view, menu.menu_nm)AS menu_nm,  \r\n"
			+ "menu.svc_url, \r\n"
			+ "menu.view_url, \r\n"
			+ "menu.DESCRIPTION, \r\n"
			+ "menu.dupl_yn, \r\n"
			+ "menu.menu_cd, \r\n"
			+ "menu.menu_std01, \r\n"
			+ "menu.menu_std02, \r\n"
			+ "menu.menu_std03, \r\n"
			+ "menu.menu_std04, \r\n"
			+ "menu.menu_std05, \r\n"
			+ "menu.menu_std_str01, \r\n"
			+ "menu.menu_std_str02, \r\n"
			+ "menu.menu_std_str03, \r\n"
			+ "menu.menu_std_str04, \r\n"
			+ "menu.menu_std_str05 \r\n"
		+ "FROM cw_menu_bas_back menu \r\n"
		+ "LEFT OUTER JOIN cw_msg_view bMsg ON CONCAT('mn_', menu.menu_id) = bMsg.msg_id AND bMsg.lang_cd = 'ko' \r\n"
		+ "INNER JOIN menu_view mView ON menu.up_menu_id = mView.menu_id \r\n"
		+ "WHERE menu.is_del = FALSE AND menu.is_lock = FALSE \r\n"
	+ ")SELECT  \r\n"
		+ "mv.*, \r\n"
		+ "GROUP_CONCAT(';',rtl.role_id,';' SEPARATOR ',')AS roleId, \r\n"
		+ "IF((SELECT COUNT(1)FROM cw_menu_bas_back child  WHERE child.up_menu_id = mv.menu_id) > 0 ,TRUE,FALSE) AS expanded \r\n"
	+ "FROM menu_view mv \r\n"
	+ "INNER JOIN cw_menu_view rtl ON mv.menu_id = rtl.menu_id \r\n"
	+ "GROUP BY menu_id \r\n"
	+ "ORDER BY  lvl, parent_seq, menu_seq;";
	
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

	public List<MyMenuVo> getAdminMenu() {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		Query query = entityManager.createNativeQuery(selectAdminMenu, MyMenuVo.class);
			
		//List<String> roles = new ArrayList<String>();

		//query.setParameter("langCd", JteUserUtil.getMyLocale().getLanguage());
		
		List<MyMenuVo> menuList = query.getResultList();
		entityManager.close();
		
		return menuList;
	}
	
}
