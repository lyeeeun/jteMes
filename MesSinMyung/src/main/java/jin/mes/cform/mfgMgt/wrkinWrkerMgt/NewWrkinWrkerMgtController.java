package jin.mes.cform.mfgMgt.wrkinWrkerMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.facilMgt.facilToolMgt.NewFacilToolMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mtrl.mtrltoolMgt.NewMtrltoolMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/wrkinWrkerMgt")
public class NewWrkinWrkerMgtController extends BaseController {
	@Autowired
	NewWrkinWrkerMgtService newProdWorkService;
	
	@RequestMapping("/getProdWorkList")
	public ModelMap getProdWorkList(ModelMap model, @ModelAttribute("asgnDto") NewWrkinTeamMgtDto asgnDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(asgnDto.getPage())));
		pageRequestVo.setRows(asgnDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(asgnDto.getPagingYN());
		try {
			
			setModelWithkendoList(model, newProdWorkService.getProdWorkList(asgnDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("작업정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkPop")
	public ModelMap getProdWorkPop(ModelMap model, @ModelAttribute("asgnDto") NewWrkinTeamMgtDto asgnDto) {
		try {
			model.addAttribute("rows", newProdWorkService.getProdWorkPop(asgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업정보 팝업 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkSave")
	@ResponseBody
	public String setProdWorkSave(@RequestBody NewWrkinTeamMgtDto asgnDto) {
		return newProdWorkService.setProdWorkSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkDelete")
	@ResponseBody
	public int setProdWorkDelete(ModelMap model, @RequestBody List<NewWrkinTeamMgtDto> mtrlOrderList) {
		return newProdWorkService.setProdWorkDelete(mtrlOrderList);
	}
	
	@RequestMapping("/getProdMtrlChkList")
	public ModelMap getProdMtrlChkList(ModelMap model, @ModelAttribute("asgnDto") NewWrkinTeamMgtDto asgnDto) {
		try {
			model.addAttribute("rows", newProdWorkService.getProdMtrlChkList(asgnDto));
		}catch(Exception ex) {
			throw new BusinessException("자재점검 리스트 조회 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 설비 장착정보 입력/수정
	@RequestMapping("/setEqmtToolDelete")
	@ResponseBody
	public String setEqmtToolDelete(@RequestBody List<NewFacilToolMgtDto> eqmtToolList) {
		return newProdWorkService.setEqmtToolDelete(eqmtToolList);
	}
	
	@RequestMapping("/setProdWorkStartSave")
	@ResponseBody
	public String setProdWorkStartSave(@RequestBody NewWrkinTeamMgtDto asgnDto) {
		return newProdWorkService.setProdWorkStartSave(asgnDto);
	}
	
	@RequestMapping("/getMtrlUseList")
	public ModelMap getMtrlUseList(ModelMap model, @ModelAttribute("mtrlUseDto") NewMtrlUseDto mtrlUseDto) {
		try {
			model.addAttribute("rows", newProdWorkService.getMtrlUseList(mtrlUseDto));
		}catch(Exception ex) {
			throw new BusinessException("자재투입현황 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlUseSave")
	@ResponseBody
	public String setMtrlUseSave(@RequestBody NewMtrlUseDto mtrlUseDto) {
		return newProdWorkService.setMtrlUseSave(mtrlUseDto);
	}
	
	@RequestMapping("/setMtrlUseDelete")
	@ResponseBody
	public int setMtrlUseDelete(ModelMap model, @RequestBody List<NewMtrlUseDto> mtrlUseList) {
		return newProdWorkService.setMtrlUseDelete(mtrlUseList);
	}
	
	@RequestMapping("/setProdWorkEndSave")
	@ResponseBody
	public String setProdWorkEndSave(@RequestBody NewWrkinTeamMgtDto asgnDto) {
		return newProdWorkService.setProdWorkEndSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkEndPgSave")
	@ResponseBody
	public String setProdWorkEndPgSave(@RequestBody NewWrkinTeamMgtDto asgnDto) {
		return newProdWorkService.setProdWorkEndPgSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkAdminSave")
	@ResponseBody
	public String setProdWorkAdminSave(@RequestBody NewWrkinTeamMgtDto asgnDto) {
		return newProdWorkService.setProdWorkAdminSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkAdminInsert")
	@ResponseBody
	public int setProdWorkAdminInsert(ModelMap model, @RequestBody List<NewMtrltoolMgtDto> toolMgtList) {
		return newProdWorkService.setWorkToolAdminInsert(toolMgtList);
	}
	
	@RequestMapping("/setProdWorkAdminUpdate")
	@ResponseBody
	public int setProdWorkAdminUpdate(ModelMap model, @RequestBody NewMtrltoolMgtDto toolMgtDto) {
		return newProdWorkService.setWorkToolAdminUpdate(toolMgtDto);
	}
	
	@RequestMapping("/setProdWorkAdminDelete")
	@ResponseBody
	public int setProdWorkAdminDelete(ModelMap model, @RequestBody List<NewMtrltoolMgtDto> toolMgtList) {
		return newProdWorkService.setWorkToolAdminDelete(toolMgtList);
	}
}
