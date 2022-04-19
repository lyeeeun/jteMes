package jin.mes.form.basMgt.authMgt.grpAuth;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import kr.co.itcall.jte.spring.user.model.RoleInfoVo;
import lombok.extern.slf4j.Slf4j;


/**<pre>
 * <b>jin.mes.form.operMgt.roleMgt</b>
 * <b>RoleMgtController.java</b>
 * <p>Descriptions : </p>
 * </pre>
 * 
 * @author  : jkkim@jintech2ng.co.kr
 * @Date    : 2019. 12. 17.
 * @Version : 
 */
@Controller
@Slf4j
@RequestMapping("/form/basMgt/authMgt/grpAuth")
public class RoleMgtController extends BaseController{
	
	@Resource(name="messageSourceAccessor")
	protected MessageSourceAccessor messageSourceAccessor;
	
	@Autowired
	RoleMgtServiceImpl roleMgtService;
	
//	@PreAuthorize("rnjsgkszhem")
	/**<pre>
	 * 1. 개요 : 권한그룹 전체리스트를 조회한다.(사용자 메뉴)
	 * 2. 처리내용 : JPA로  
	 * </pre>
	 * @Method : getRoleGrp
	 * @param model
	 * @param codeGroupDto
	 * @return
	 */
	@RequestMapping("/getRoleGrp")
	public ModelMap getRoleGrp(ModelMap model, @ModelAttribute KendoPageVO pageVO) {
		try {
//			final JPQLQuery<Account> query;

			setModelWithkendoList(model,roleMgtService.getRoleGrp(pageVO));
		}catch(Exception ex) {
			//throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.format.invalid", new Object[] {filename, uploadExtAllowedPattern})); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
			throw new BusinessException("조회에러입니다.: "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setRoleGrpInsert")
	public ModelMap setRoleGrpInsert(ModelMap model, @ModelAttribute("roleInfoVo") RoleInfoVo roleInfoVo) {
		try {
			roleMgtService.setRoleGrpInsert(roleInfoVo);
		}catch(Exception ex) {
			throw new BusinessException("insert 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setRoleGrpUpdate")
	public ModelMap setRoleGrpUpdate(ModelMap model, @ModelAttribute("roleInfoVo") RoleInfoVo roleInfoVo) {
		try {
			roleMgtService.setRoleGrpUpdate(roleInfoVo);
		}catch(Exception ex) {
			throw new BusinessException("modify 에러입니다.: "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setRoleGrpDelete")
	public ModelMap setRoleGrpDelete(ModelMap model,  @RequestParam(value="roleIds[]") List<String> roleIds) {
		try {
			System.out.println(roleIds);
			roleMgtService.setRoleGrpDelete(roleIds);
		}catch(Exception ex) {
			throw new BusinessException("delete 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
}
