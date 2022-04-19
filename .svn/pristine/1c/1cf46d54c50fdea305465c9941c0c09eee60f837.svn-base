package jin.mes.form.basMgt.codMgt.baseCodeMgt;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/basMgt/codMgt/baseCodeMgt")
public class BaseCodeMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(BaseCodeMgtController.class);

	@Resource
	protected BaseCodeMgtService baseCodeMgtService;

	/**
	 * 코드 리스트를 가지고 온다.
	 * 
	 * @param map - 리스트 조회 조건
	 * 
	 * @return String - viewName / 코드 리스트
	 */
	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
	@RequestMapping("/getCode")
	public ModelMap getCode(@ModelAttribute("BaseCodeMgtDto") BaseCodeMgtDto baseCodeMgtDto, ModelMap model) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(baseCodeMgtDto.getPage())));
		pageRequestVo.setRows(baseCodeMgtDto.getRows());

		setModelWithkendoList(model, baseCodeMgtService.readCode(baseCodeMgtDto, pageRequestVo));

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
	@RequestMapping("/setCode")
	public ModelMap setCode(@RequestBody BaseCodeMgtDto baseCodeMgtDto, ModelMap model) {
		model.addAttribute("result", baseCodeMgtService.codeUpdate(baseCodeMgtDto));
		return model;
	}

	/**
	 * 코드를 추가 한다.
	 * 
	 * @param codeDto - 추가 될 코드의 DTO
	 * 
	 * @return String - viewName
	 */ 
	/*@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud.denied')"))*/
	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud')"))
	@RequestMapping("/addCode")
	public ModelMap addCode(@RequestBody BaseCodeMgtDto baseCodeMgtDto, ModelMap model) {
		model.addAttribute("result", baseCodeMgtService.codeAdd(baseCodeMgtDto));

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
	@RequestMapping("/delCode")
	public ModelMap delCode(@RequestBody List<BaseCodeMgtDto> baseCodeList, ModelMap model) {
	
		model.addAttribute("result", baseCodeMgtService.codeDelete(baseCodeList));

		return model;
	}
	
}
