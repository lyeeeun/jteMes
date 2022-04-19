package jin.mes.cform.facilMgt.facilCorMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/facilMgt/facilCorMgt")
public class NewFacilCorMgtController extends BaseController {

	@Autowired
	NewFacilCorMgtService newFacilCorMgtService;
	
	//설비 정비이력 조회
	@RequestMapping("getEqmtMtncList")
	public ModelMap getEqmtMtncList(ModelMap model, @ModelAttribute("mtrlMgtDto") NewFacilCorMgtDto eqmtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(eqmtDto.getPage())));
		pageRequestVo.setRows(eqmtDto.getRows());
		try {
			setModelWithkendoList(model, newFacilCorMgtService.getEqmtMtncList(eqmtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("설비 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//설비 정비이력 입력/수정
	@RequestMapping("/setEqmtMtncSave")
	@ResponseBody
	public String setEqmtMtncSave(@RequestBody NewFacilCorMgtDto eqmtDto) {
		return newFacilCorMgtService.setEqmtMtncSave(eqmtDto);
	}
	
	//설비 정비이력 삭제
	@RequestMapping("/setEqmtMtncDelete")
	@ResponseBody
	public int setEqmtMtncDelete(ModelMap model, @RequestBody List<NewFacilCorMgtDto> EqmtMtncList) {
		return newFacilCorMgtService.setEqmtMtncDelete(EqmtMtncList);
	}
	
	
	//설비 가동시간 조회
	@RequestMapping("getEqmtWorkList")
	public ModelMap getEqmtWorkList(ModelMap model, @ModelAttribute("mtrlMgtDto") NewFacilCorMgtDto eqmtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(eqmtDto.getPage())));
		pageRequestVo.setRows(eqmtDto.getRows());
		pageRequestVo.setPagingYN(eqmtDto.getPagingYN());
		try {
			setModelWithkendoList(model, newFacilCorMgtService.getEqmtWorkList(eqmtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("설비  가동시간 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//설비종합효율 조회
	@RequestMapping("getEqmtOverall")
	public ModelMap getEqmtOverall(ModelMap model, @ModelAttribute("mtrlMgtDto") NewFacilCorMgtDto eqmtDto) {
		try {
			model.addAttribute("rows", newFacilCorMgtService.getEqmtOverall(eqmtDto));
		}catch(Exception ex) {
			throw new BusinessException("설비종합효율 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
}
