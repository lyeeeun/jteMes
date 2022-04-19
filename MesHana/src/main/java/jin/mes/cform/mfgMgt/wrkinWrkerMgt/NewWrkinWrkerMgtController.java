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
	public ModelMap getProdWorkList(ModelMap model, @ModelAttribute("newAsgnDto") NewWrkinTeamMgtDto newAsgnDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newAsgnDto.getPage())));
		pageRequestVo.setRows(newAsgnDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(newAsgnDto.getPagingYN());
		try {
			
			setModelWithkendoList(model, newProdWorkService.getProdWorkList(newAsgnDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("작업정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkPop")
	public ModelMap getProdWorkPop(ModelMap model, @ModelAttribute("newAsgnDto") NewWrkinTeamMgtDto newAsgnDto) {
		try {
			model.addAttribute("rows", newProdWorkService.getProdWorkPop(newAsgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업정보 팝업 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkSave")
	@ResponseBody
	public String setProdWorkSave(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newProdWorkService.setProdWorkSave(newAsgnDto);
	}
	
	@RequestMapping("/setProdWorkDelete")
	@ResponseBody
	public int setProdWorkDelete(ModelMap model, @RequestBody List<NewWrkinTeamMgtDto> mtrlOrderList) {
		return newProdWorkService.setProdWorkDelete(mtrlOrderList);
	}
	
	@RequestMapping("/getProdMtrlChkList")
	public ModelMap getProdMtrlChkList(ModelMap model, @ModelAttribute("newAsgnDto") NewWrkinTeamMgtDto newAsgnDto) {
		try {
			model.addAttribute("rows", newProdWorkService.getProdMtrlChkList(newAsgnDto));
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
	public String setProdWorkStartSave(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newProdWorkService.setProdWorkStartSave(newAsgnDto);
	}
	
	@RequestMapping("/getMtrlUseList")
	public ModelMap getMtrlUseList(ModelMap model, @ModelAttribute("newMtrlUseDto") NewMtrlUseDto newMtrlUseDto) {
		try {
			model.addAttribute("rows", newProdWorkService.getMtrlUseList(newMtrlUseDto));
		}catch(Exception ex) {
			throw new BusinessException("자재투입현황 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlUseSave")
	@ResponseBody
	public String setMtrlUseSave(@RequestBody NewMtrlUseDto newMtrlUseDto) {
		return newProdWorkService.setMtrlUseSave(newMtrlUseDto);
	}
	
	@RequestMapping("/setMtrlUseDelete")
	@ResponseBody
	public int setMtrlUseDelete(ModelMap model, @RequestBody List<NewMtrlUseDto> mtrlUseList) {
		return newProdWorkService.setMtrlUseDelete(mtrlUseList);
	}
	
	@RequestMapping("/setProdWorkEndSave")
	@ResponseBody
	public String setProdWorkEndSave(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newProdWorkService.setProdWorkEndSave(newAsgnDto);
	}
	
	@RequestMapping("/setProdWorkEndPgSave")
	@ResponseBody
	public String setProdWorkEndPgSave(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newProdWorkService.setProdWorkEndPgSave(newAsgnDto);
	}
	
	@RequestMapping("/setProdWorkAdminSave")
	@ResponseBody
	public String setProdWorkAdminSave(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newProdWorkService.setProdWorkAdminSave(newAsgnDto);
	}
	
	@RequestMapping("/setProdWorkAdminInsert")
	@ResponseBody
	public int setProdWorkAdminInsert(ModelMap model, @RequestBody List<NewMtrltoolMgtDto> toolMgtList) {
		return newProdWorkService.setWorkToolAdminInsert(toolMgtList);
	}
	
	@RequestMapping("/setProdWorkAdminUpdate")
	@ResponseBody
	public int setProdWorkAdminUpdate(ModelMap model, @RequestBody NewMtrltoolMgtDto newToolMgtDto) {
		return newProdWorkService.setWorkToolAdminUpdate(newToolMgtDto);
	}
	
	@RequestMapping("/setProdWorkAdminDelete")
	@ResponseBody
	public int setProdWorkAdminDelete(ModelMap model, @RequestBody List<NewMtrltoolMgtDto> toolMgtList) {
		return newProdWorkService.setWorkToolAdminDelete(toolMgtList);
	}
}
