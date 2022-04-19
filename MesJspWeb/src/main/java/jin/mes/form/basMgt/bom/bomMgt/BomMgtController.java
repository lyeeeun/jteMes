package jin.mes.form.basMgt.bom.bomMgt;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/basMgt/bom/bomMgt")
public class BomMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(BomMgtController.class);

	@Resource
	protected BomMgtService bomMgtService;

	@RequestMapping("/getBomList")
	public ModelMap getBomList(@ModelAttribute("bomMgtDto") BomMgtDto bomMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", bomMgtService.getBomList(bomMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러  : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setBom")
	@ResponseBody
	public void setBom(@RequestBody BomMgtDto bomMgtDto) {
		bomMgtService.setBom(bomMgtDto); 
	}
	
	@RequestMapping("/updateBom")
	@ResponseBody
	public void updateBom(@RequestBody BomMgtDto bomMgtDto) {
		bomMgtService.updateBom(bomMgtDto); 
	}
	
	@RequestMapping("/deleteBom")
	@ResponseBody
	public void deleteBom(@RequestBody BomMgtDto bomMgtDto) {
		bomMgtService.deleteBom(bomMgtDto); 
	}
	
	/*
	 * @RequestMapping("/getBomListAll") public ModelMap getBomListAll(@ModelAttribute("bomMgtDto") BomMgtDto bomMgtDto, ModelMap model) { try { model.addAttribute("result", bomMgtService.getBomListAll(bomMgtDto)); }catch(Exception ex) { throw new BusinessException("BomList 조회 에러"); } return model; }
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
//	public ModelMap getGrpCode(@ModelAttribute("bomMgtDto") BomMgtDto bomMgtDto, ModelMap model) {
//		PageRequestVo pageRequestVo = new PageRequestVo();
//		pageRequestVo.setPage(getCurrentPage(Integer.toString(bomMgtDto.getPage())));
//		pageRequestVo.setRows(bomMgtDto.getRows());
//
//		setModelWithkendoList(model, bomMgtService.getbomList(bomMgtDto, pageRequestVo));
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
