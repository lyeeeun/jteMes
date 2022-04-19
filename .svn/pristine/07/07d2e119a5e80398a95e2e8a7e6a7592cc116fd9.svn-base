package jin.mes.form.mfgMgt.wrkinWrkerMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.tool.mtrltoolMgt.MtrltoolMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mfgMgt/wrkinWrkerMgt")
public class WrkinWrkerMgtController extends BaseController {
	@Autowired
	WrkinWrkerMgtService prodWorkService;
	
	@RequestMapping("/getProdWorkList")
	public ModelMap getProdWorkList(ModelMap model, @ModelAttribute("asgnDto") WrkinTeamMgtDto asgnDto) {
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
	public ModelMap getProdWorkPop(ModelMap model, @ModelAttribute("asgnDto") WrkinTeamMgtDto asgnDto) {
		try {
			model.addAttribute("rows", prodWorkService.getProdWorkPop(asgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업정보 팝업 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkSave")
	@ResponseBody
	public String setProdWorkSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkDelete")
	@ResponseBody
	public int setProdWorkDelete(ModelMap model, @RequestBody List<WrkinTeamMgtDto> mtrlOrderList) {
		return prodWorkService.setProdWorkDelete(mtrlOrderList);
	}
	
	@RequestMapping("/getProdMtrlChkList")
	public ModelMap getProdMtrlChkList(ModelMap model, @ModelAttribute("asgnDto") WrkinTeamMgtDto asgnDto) {
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
	public String setEqmtToolDelete(@RequestBody List<FacilToolMgtDto> eqmtToolList) {
		return prodWorkService.setEqmtToolDelete(eqmtToolList);
	}
	
	@RequestMapping("/setProdWorkStartSave")
	@ResponseBody
	public String setProdWorkStartSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkStartSave(asgnDto);
	}
	
	@RequestMapping("/getMtrlUseList")
	public ModelMap getMtrlUseList(ModelMap model, @ModelAttribute("mtrlUseDto") MtrlUseDto mtrlUseDto) {
		try {
			model.addAttribute("rows", prodWorkService.getMtrlUseList(mtrlUseDto));
		}catch(Exception ex) {
			throw new BusinessException("자재투입현황 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlUseSave")
	@ResponseBody
	public String setMtrlUseSave(@RequestBody MtrlUseDto mtrlUseDto) {
		return prodWorkService.setMtrlUseSave(mtrlUseDto);
	}
	
	@RequestMapping("/setMtrlUseDelete")
	@ResponseBody
	public int setMtrlUseDelete(ModelMap model, @RequestBody List<MtrlUseDto> mtrlUseList) {
		return prodWorkService.setMtrlUseDelete(mtrlUseList);
	}
	
	@RequestMapping("/setProdWorkEndSave")
	@ResponseBody
	public String setProdWorkEndSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkEndSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkEndPgSave")
	@ResponseBody
	public String setProdWorkEndPgSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkEndPgSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkAdminSave")
	@ResponseBody
	public String setProdWorkAdminSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return prodWorkService.setProdWorkAdminSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkAdminInsert")
	@ResponseBody
	public int setProdWorkAdminInsert(ModelMap model, @RequestBody List<MtrltoolMgtDto> toolMgtList) {
		return prodWorkService.setWorkToolAdminInsert(toolMgtList);
	}
	
	@RequestMapping("/setProdWorkAdminUpdate")
	@ResponseBody
	public int setProdWorkAdminUpdate(ModelMap model, @RequestBody MtrltoolMgtDto toolMgtDto) {
		return prodWorkService.setWorkToolAdminUpdate(toolMgtDto);
	}
	
	@RequestMapping("/setProdWorkAdminDelete")
	@ResponseBody
	public int setProdWorkAdminDelete(ModelMap model, @RequestBody List<MtrltoolMgtDto> toolMgtList) {
		return prodWorkService.setWorkToolAdminDelete(toolMgtList);
	}
}
