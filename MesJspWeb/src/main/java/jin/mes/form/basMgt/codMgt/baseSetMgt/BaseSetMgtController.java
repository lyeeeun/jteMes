package jin.mes.form.basMgt.codMgt.baseSetMgt;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/basMgt/codMgt/baseSetMgt")
public class BaseSetMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(BaseSetMgtController.class);

	/**
	 * BaseCode와 DTO, MAPPER, SERVICE 공유.
	 */
	
	@Resource
	protected BaseCodeMgtService baseSetMgtService;

	/**
	 * 코드 리스트를 가지고 온다.
	 * 
	 * @param map - 리스트 조회 조건
	 * 
	 * @return String - viewName / 코드 리스트
	 */
	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
	@RequestMapping("/getBaseSet")
	public ModelMap getCode(@ModelAttribute("codeDto") BaseCodeMgtDto baseSetMgtDto, ModelMap model) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(baseSetMgtDto.getPage())));
		pageRequestVo.setRows(baseSetMgtDto.getRows());

		setModelWithkendoList(model, baseSetMgtService.readCode(baseSetMgtDto, pageRequestVo));

		return model;
	}

	/**
	 * 코드를 변경 한다.
	 * 
	 * @param BaseSetMgtDto - 변경 할 코드의 DTO
	 * 
	 * @return String - viewName
	 */
	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud')"))
	@RequestMapping("/setBaseSet")
	public ModelMap setCode(@ModelAttribute BaseCodeMgtDto baseSetMgtDto, ModelMap model) {
		model.addAttribute("result", baseSetMgtService.codeUpdate(baseSetMgtDto));
		return model;
	}

	/**
	 * 코드를 추가 한다.
	 * 
	 * @param codeDto - 추가 될 코드의 DTO
	 * 
	 * @return String - viewName
	 */ 
	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud')"))
	@RequestMapping("/addBaseSet")
	public ModelMap addCode(@ModelAttribute BaseCodeMgtDto baseSetMgtDto, ModelMap model) {
		model.addAttribute("result", baseSetMgtService.codeAdd(baseSetMgtDto));

		return model;
	}

	/**
	 * 코드를 삭제 한다.
	 * 
	 * @param cdGroupId - 삭제 될 코드의 그룹 ID, cdId - 삭제 될 코드의 ID
	 * 
	 * @return String - viewName
	 */
	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud')"))
	@RequestMapping("/delBaseSet")
	public ModelMap delCode(@RequestBody List<BaseCodeMgtDto> baseCodeList, ModelMap model) {
	
		model.addAttribute("result", baseSetMgtService.codeDelete(baseCodeList));

		return model;
	}
	
}
