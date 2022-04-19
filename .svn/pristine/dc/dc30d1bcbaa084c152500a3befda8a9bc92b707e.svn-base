package jin.mes.cform.mfgMgt.wrkinWrkerMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.facilMgt.facilToolMgt.ZinixFacilToolMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtDto;
import jin.mes.cform.mtrl.mtrltoolMgt.ZinixMtrltoolMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/wrkinWrkerMgt")
public class ZinixWrkinWrkerMgtController extends BaseController {
	@Autowired
	ZinixWrkinWrkerMgtService prodWorkService;
	
	@RequestMapping("/getProdWorkList")
	public ModelMap getProdWorkList(ModelMap model, @ModelAttribute("asgnDto") ZinixWrkinTeamMgtDto asgnDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(asgnDto.getPage())));
		pageRequestVo.setRows(asgnDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(asgnDto.getPagingYN());
		try {
			
			setModelWithkendoList(model, prodWorkService.getProdWorkList(asgnDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("작업정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkPop")
	public ModelMap getProdWorkPop(ModelMap model, @ModelAttribute("asgnDto") ZinixWrkinTeamMgtDto asgnDto) {
		try {
			model.addAttribute("rows", prodWorkService.getProdWorkPop(asgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업정보 팝업 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkSave")
	@ResponseBody
	public String setProdWorkSave(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkDelete")
	@ResponseBody
	public int setProdWorkDelete(ModelMap model, @RequestBody List<ZinixWrkinTeamMgtDto> mtrlOrderList) {
		return prodWorkService.setProdWorkDelete(mtrlOrderList);
	}
	
	@RequestMapping("/getProdMtrlChkList")
	public ModelMap getProdMtrlChkList(ModelMap model, @ModelAttribute("asgnDto") ZinixWrkinTeamMgtDto asgnDto) {
		try {
			model.addAttribute("rows", prodWorkService.getProdMtrlChkList(asgnDto));
		}catch(Exception ex) {
			throw new BusinessException("자재점검 리스트 조회 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 설비 장착정보 입력/수정
	@RequestMapping("/setEqmtToolDelete")
	@ResponseBody
	public String setEqmtToolDelete(@RequestBody List<ZinixFacilToolMgtDto> eqmtToolList) {
		return prodWorkService.setEqmtToolDelete(eqmtToolList);
	}
	
	@RequestMapping("/setProdWorkStartSave")
	@ResponseBody
	public String setProdWorkStartSave(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkStartSave(asgnDto);
	}
	
	@RequestMapping("/getMtrlUseList")
	public ModelMap getMtrlUseList(ModelMap model, @ModelAttribute("mtrlUseDto") ZinixMtrlUseDto mtrlUseDto) {
		try {
			model.addAttribute("rows", prodWorkService.getMtrlUseList(mtrlUseDto));
		}catch(Exception ex) {
			throw new BusinessException("자재투입현황 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlUseSave")
	@ResponseBody
	public String setMtrlUseSave(@RequestBody ZinixMtrlUseDto mtrlUseDto) {
		return prodWorkService.setMtrlUseSave(mtrlUseDto);
	}
	
	@RequestMapping("/setMtrlUseDelete")
	@ResponseBody
	public int setMtrlUseDelete(ModelMap model, @RequestBody List<ZinixMtrlUseDto> mtrlUseList) {
		return prodWorkService.setMtrlUseDelete(mtrlUseList);
	}
	
	@RequestMapping("/setProdWorkEndSave")
	@ResponseBody
	public String setProdWorkEndSave(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkEndSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkEndPgSave")
	@ResponseBody
	public String setProdWorkEndPgSave(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkEndPgSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkAdminSave")
	@ResponseBody
	public String setProdWorkAdminSave(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkAdminSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkAdminInsert")
	@ResponseBody
	public int setProdWorkAdminInsert(ModelMap model, @RequestBody List<ZinixMtrltoolMgtDto> toolMgtList) {
		return prodWorkService.setWorkToolAdminInsert(toolMgtList);
	}
	
	@RequestMapping("/setProdWorkAdminUpdate")
	@ResponseBody
	public int setProdWorkAdminUpdate(ModelMap model, @RequestBody ZinixMtrltoolMgtDto toolMgtDto) {
		return prodWorkService.setWorkToolAdminUpdate(toolMgtDto);
	}
	
	@RequestMapping("/setProdWorkAdminDelete")
	@ResponseBody
	public int setProdWorkAdminDelete(ModelMap model, @RequestBody List<ZinixMtrltoolMgtDto> toolMgtList) {
		return prodWorkService.setWorkToolAdminDelete(toolMgtList);
	}
}
