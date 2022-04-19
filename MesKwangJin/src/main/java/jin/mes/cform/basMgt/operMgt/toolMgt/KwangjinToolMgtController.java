package jin.mes.cform.basMgt.operMgt.toolMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/operMgt/toolMgt")
public class KwangjinToolMgtController extends BaseController {

	@Autowired
	KwangjinToolMgtService kwangjinToolMgtService;
	
	
	//수주 상세조회(order-child)
	@RequestMapping("getOrderPop")
	public ModelMap getOrderPop(ModelMap model, @ModelAttribute("kwangjinToolMgtDto") KwangjinToolMgtDto kwangjinToolMgtDto) {

		try {
			model.addAttribute("rows",kwangjinToolMgtService.getOrderPop(kwangjinToolMgtDto)); 
		}catch(Exception ex) {
			throw new BusinessException("수주 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("getToolInfoList")
	public ModelMap getToolInfoList(ModelMap model, @ModelAttribute("kwangjinToolMgtDto") KwangjinToolMgtDto kwangjinToolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinToolMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinToolMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinToolMgtService.getToolInfoList(kwangjinToolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setToolInfoSave")
	@ResponseBody
	public String setToolInfoSave(@RequestBody KwangjinToolMgtDto kwangjinToolMgtDto) {
		return kwangjinToolMgtService.setToolInfoSave(kwangjinToolMgtDto);
	}
	
	@RequestMapping("/setToolInfoDelete")
	@ResponseBody
	public int setToolInfoDelete(ModelMap model, @RequestBody List<KwangjinToolMgtDto> facilMgtList) {
		return kwangjinToolMgtService.setToolInfoDelete(facilMgtList);
	}
	
	@RequestMapping("/getMtrlRtlCompList")
	public ModelMap getMtrlRtlCompList(ModelMap model, @ModelAttribute("kwangjinCompMgtDto") KwangjinCompMgtDto kwangjinCompMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinCompMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinCompMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinToolMgtService.getToolRtlCompList(kwangjinCompMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구구매 업체 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlRtlCompSave")
	@ResponseBody
	public String setMtrlRtlCompSave(@RequestBody KwangjinToolMgtDto kwangjinToolMgtDto) {
		return kwangjinToolMgtService.setToolRtlCompSave(kwangjinToolMgtDto);
	}
	
	@RequestMapping("/setMtrlRtlCompDelete")
	@ResponseBody
	public int setMtrlRtlCompDelete(ModelMap model, @RequestBody List<KwangjinCompMgtDto> compList) {
		return kwangjinToolMgtService.setToolRtlCompDelete(compList);
	}
	
	@RequestMapping("/getAllToolInfoList")
	public ModelMap getAllToolInfoList(ModelMap model, @ModelAttribute("kwangjinToolMgtDto") KwangjinToolMgtDto kwangjinToolMgtDto) {
		try {
			model.addAttribute("result", kwangjinToolMgtService.getAllToolInfoList(kwangjinToolMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("공구 전체 목록 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
