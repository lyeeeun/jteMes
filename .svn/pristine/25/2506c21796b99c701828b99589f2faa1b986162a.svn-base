package jin.mes.cform.mtrl.toolVerifMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mtrl.mtrltoolMgt.ZinixMtrltoolMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mtrl/toolVerifMgt")
public class ZinixToolVerifController extends BaseController {

	@Autowired
	ZinixToolVerifService toolVerifService;
	
	//공구상세 조회
	@RequestMapping("getToolMgtList")
	public ModelMap getToolMgtList(ModelMap model, @ModelAttribute("toolMgtDto") ZinixMtrltoolMgtDto toolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolMgtDto.getPage())));
		pageRequestVo.setRows(toolMgtDto.getRows());
		try {
			setModelWithkendoList(model, toolVerifService.getToolMgtList(toolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 정비이력 조회
	@RequestMapping("getToolMtncList")
	public ModelMap getToolMtncList(ModelMap model, @ModelAttribute("toolMgtDto") ZinixMtrltoolMgtDto toolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolMgtDto.getPage())));
		pageRequestVo.setRows(toolMgtDto.getRows());
		try {
			setModelWithkendoList(model, toolVerifService.getToolMtncList(toolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 정비이력 입력/수정
	@RequestMapping("/setToolMtncSave")
	@ResponseBody
	public String setToolMtncSave(@RequestBody ZinixMtrltoolMgtDto toolMgtDto) {
		return toolVerifService.setToolMtncSave(toolMgtDto);
	}
	
	//공구 정비이력 삭제
	@RequestMapping("/setToolMtncDelete")
	@ResponseBody
	public int setToolMtncDelete(ModelMap model, @RequestBody List<ZinixMtrltoolMgtDto> toolMtncList) {
		return toolVerifService.setToolMtncDelete(toolMtncList);
	}
	
}
