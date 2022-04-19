package jin.mes.form.facilMgt.facilMountTool;

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
@RequestMapping("/form/facilMgt/facilMountTool")
public class FacilMountToolController extends BaseController {
		
	@Autowired
	FacilMountToolService facilMountToolService;
	
	//설비 조회
	@RequestMapping("/getEqmtToolRtlList")
	public ModelMap getEqmtToolRtlList(@ModelAttribute("facilMountToolDto") FacilMountToolDto facilMountToolDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(facilMountToolDto.getPage())));
		pageRequestVo.setRows(facilMountToolDto.getRows());

		setModelWithkendoList(model, facilMountToolService.getEqmtToolRtlList(facilMountToolDto, pageRequestVo));

		return model;
	}
	
	//설비-공구 매핑
	@RequestMapping("/getEqmtToolPop")
	public ModelMap getEqmtToolPop(@ModelAttribute("facilMountToolDto") FacilMountToolDto facilMountToolDto, ModelMap model) {
		model.addAttribute("rows", facilMountToolService.getEqmtToolPop(facilMountToolDto));

		return model;
	}

	//설비-공구 등록&삭제
	@RequestMapping("/setEqmtTool")
	@ResponseBody
	public String setEqmtTool(@RequestBody FacilMountToolDto facilMountToolDto) {
		return facilMountToolService.setEqmtTool(facilMountToolDto);
	}
	
	//설비-공구에 매핑된 개별공구 조회
	@RequestMapping("/getToolEqipList")
	public ModelMap getToolEqipList(@ModelAttribute("eqipToolDto") EqipToolDto eqipToolDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(eqipToolDto.getPage())));
		pageRequestVo.setRows(eqipToolDto.getRows());

		setModelWithkendoList(model, facilMountToolService.getToolEqipList(eqipToolDto, pageRequestVo));

		return model;
	}
	
	//개별공구 조회
	@RequestMapping("getToolMgtMountList")
	public ModelMap getToolMgtMountList(ModelMap model, @ModelAttribute("eqipToolDto") EqipToolDto eqipToolDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(eqipToolDto.getPage())));
		pageRequestVo.setRows(eqipToolDto.getRows());
		try {
			setModelWithkendoList(model, facilMountToolService.getToolMgtMountList(eqipToolDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//설비-공구에 매핑된 개별공구 등록
	@RequestMapping("/setToolMgtRtl")
	@ResponseBody
	public String setToolMgtRtl(@RequestBody EqipToolDto eqipToolDto) {
		return facilMountToolService.setToolMgtRtl(eqipToolDto);
	}
	
	//설비-공구에 매핑된 개별공구 등록
	
	@RequestMapping("/delUpdateTool")
	@ResponseBody
	public int delUpdateTool(ModelMap model, @RequestBody List<EqipToolDto> toolMgtList) {
		return facilMountToolService.delUpdateTool(toolMgtList);
	}
}
