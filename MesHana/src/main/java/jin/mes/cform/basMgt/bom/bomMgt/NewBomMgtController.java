package jin.mes.cform.basMgt.bom.bomMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/bom/bomMgt")
public class NewBomMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewBomMgtController.class);

	@Resource
	protected NewBomMgtService newBomMgtService;

	@RequestMapping("/getBomList")
	public ModelMap getBomList(@ModelAttribute("newBomMgtDto") NewBomMgtDto newBomMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", newBomMgtService.getBomList(newBomMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러  : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setBom")
	@ResponseBody
	public void setBom(@RequestBody NewBomMgtDto newBomMgtDto) {
		newBomMgtService.setBom(newBomMgtDto); 
	}
	
	@RequestMapping("/updateBom")
	@ResponseBody
	public void updateBom(@RequestBody NewBomMgtDto newBomMgtDto) {
		newBomMgtService.updateBom(newBomMgtDto); 
	}
	
	@RequestMapping("/deleteBom")
	@ResponseBody
	public void deleteBom(@RequestBody NewBomMgtDto newBomMgtDto) {
		newBomMgtService.deleteBom(newBomMgtDto); 
	}
	
	/*
	 * @RequestMapping("/getBomListAll") public ModelMap getBomListAll(@ModelAttribute("newBomMgtDto") BomMgtDto newBomMgtDto, ModelMap model) { try { model.addAttribute("result", newBomMgtService.getBomListAll(newBomMgtDto)); }catch(Exception ex) { throw new BusinessException("BomList 조회 에러"); } return model; }
	 */
	
	
	
	/**
	 * 코드 그룹 리스트를 가지고 온다.
	 * 
	 * @param map - 리스트 조회 조건
	 * 
	 * @return String - viewName / 코드 그룹 리스트
	 */
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
//	@RequestMapping("/getGrpCode")
//	public ModelMap getGrpCode(@ModelAttribute("newBomMgtDto") BomMgtDto newBomMgtDto, ModelMap model) {
//		PageRequestVo pageRequestVo = new PageRequestVo();
//		pageRequestVo.setPage(getCurrentPage(Integer.toString(newBomMgtDto.getPage())));
//		pageRequestVo.setRows(newBomMgtDto.getRows());
//
//		setModelWithkendoList(model, newBomMgtService.getbomList(newBomMgtDto, pageRequestVo));
//
//		return model;
//	}

	/**
	 * 코드 리스트를 가지고 온다.
	 * 
	 * @param map - 리스트 조회 조건
	 * 
	 * @return String - viewName / 코드 리스트
	 */
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
//	@RequestMapping("/getCode")
//	public ModelMap getCode(@ModelAttribute("codeDto") CodeDto codeDto, ModelMap model) {
//		PageRequestVo pageRequestVo = new PageRequestVo();
//		pageRequestVo.setPage(getCurrentPage(Integer.toString(codeDto.getPage())));
//		pageRequestVo.setRows(codeDto.getRows());
//
//		setModelWithkendoList(model, codeMgtService.readCode(codeDto, pageRequestVo));
//
//		return model;
//	}

	/**
	 * 코드 그룹을 변경 한다.
	 * 
	 * @param CodeGroupDto - 변경 할 코드 그룹의 DTO
	 * 
	 * @return String - viewName
	 */
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud')"))
//	@RequestMapping("/setGrpCode")
//	public ModelMap setGrpCode(@ModelAttribute CodeGroupDto codeGroupDto, ModelMap model) {
//		logger.debug("GROUP iD ===> " + codeGroupDto.getCdGroupId());
//
//		model.addAttribute("result", codeMgtService.groupUpdate(codeGroupDto));
//
//		return model;
//	}

	/**
	 * 코드를 변경 한다.
	 * 
	 * @param CodeDto - 변경 할 코드의 DTO
	 * 
	 * @return String - viewName
	 */
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud')"))
//	@RequestMapping("/setCode")
//	public ModelMap setCode(@ModelAttribute CodeDto codeDto, ModelMap model) {
//		model.addAttribute("result", codeMgtService.codeUpdate(codeDto));
//		return model;
//	}

	/**
	 * 코드 그룹을 추가 한다.
	 * 
	 * @param codeGroupDto - 추가 될 코드 그룹의 DTO
	 * 
	 * @return String - viewName
	 */
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud.denied')"))
//	@RequestMapping("/addGrpCode")
//	public ModelMap addGrpCode(@ModelAttribute CodeGroupDto codeGroupDto, ModelMap model) {
//		model.addAttribute("result", codeMgtService.groupAdd(codeGroupDto));
//
//		return model;
//	}

	/**
	 * 코드를 추가 한다.
	 * 
	 * @param codeDto - 추가 될 코드의 DTO
	 * 
	 * @return String - viewName
	 */ 
	/*@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud.denied')"))*/
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud')"))
//	@RequestMapping("/addCode")
//	public ModelMap addCode(@ModelAttribute CodeDto codeDto, ModelMap model) {
//		model.addAttribute("result", codeMgtService.codeAdd(codeDto));
//
//		return model;
//	}

	/**
	 * 코드 그룹을 삭제 한다.
	 * 
	 * @param cdGroupId - 삭제 될 코드 그룹의 ID
	 * 
	 * @return String - viewName
	 */
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud')"))
//	@RequestMapping("/delGrpCode")
//	public ModelMap delGrpCode(@RequestParam("cdGroupId") String cdGroupId, ModelMap model) {
//		model.addAttribute("result", codeMgtService.codeGroupDelete(cdGroupId));
//
//		return model;
//	}

	/**
	 * 코드를 삭제 한다.
	 * 
	 * @param cdGroupId - 삭제 될 코드의 그룹 ID, cdId - 삭제 될 코드의 ID
	 * 
	 * @return String - viewName
	 */
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.cud')"))
//	@RequestMapping("/delCode")
//	public ModelMap delCode(@RequestParam("cdId") String cdId, ModelMap model) {
//		model.addAttribute("result", codeMgtService.codeDelete(cdId));
//
//		return model;
//	}
	/**
	 * 코드 리스트를 가지고 온다.
	 * 
	 * @param map - 리스트 조회 조건
	 * 
	 * @return String - viewName / 코드 리스트
	 */
	// @PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
//	@RequestMapping("/getCodeByGroupId")
//	public ModelMap getCodeByGroupId(@ModelAttribute("codeDto") CodeDto codeDto, ModelMap model) {
//		model.addAttribute("result", codeMgtService.getCodeByGroupId(codeDto));
//
//		return model;
//	}

}
