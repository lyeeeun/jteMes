package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.operMgt.compMgt.NewCompMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/operMgt/mtrlInfo")
public class NewMtrlInfoController extends BaseController {

	@Autowired
	NewMtrlInfoService newMtrlInfoService;
	
	
	@RequestMapping("getMtrlInfoList")
	public ModelMap getMtrlInfoList(ModelMap model, @ModelAttribute("newMtrlInfoDto") NewMtrlInfoDto newMtrlInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newMtrlInfoDto.getPage())));
		pageRequestVo.setRows(newMtrlInfoDto.getRows());
		try {
			setModelWithkendoList(model, newMtrlInfoService.getMtrlInfoList(newMtrlInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlInfoSave")
	@ResponseBody
	public String setMtrlInfoSave(@RequestBody NewMtrlInfoDto newMtrlInfoDto) {
		return newMtrlInfoService.setMtrlInfoSave(newMtrlInfoDto);
	}
	
	@RequestMapping("/setMtrlInfoDelete")
	@ResponseBody
	public int setMtrlInfoDelete(ModelMap model, @RequestBody List<NewMtrlInfoDto> mtrlInfoList) {
		return newMtrlInfoService.setMtrlInfoDelete(mtrlInfoList);
	}
	
	@RequestMapping("getMtrlRtlCompList")
	public ModelMap getMtrlRtlCompList(ModelMap model, @ModelAttribute("newCompMgtDto") NewCompMgtDto newCompMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newCompMgtDto.getPage())));
		pageRequestVo.setRows(newCompMgtDto.getRows());
		try {
			setModelWithkendoList(model, newMtrlInfoService.getMtrlRtlCompList(newCompMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlRtlCompSave")
	@ResponseBody
	public String setMtrlRtlCompSave(@RequestBody NewCompMgtDto newCompDto) {
		return newMtrlInfoService.setMtrlRtlCompSave(newCompDto);
	}
	
	@RequestMapping("/setMtrlRtlCompDelete")
	@ResponseBody
	public int setMtrlRtlCompDelete(ModelMap model, @RequestBody List<NewCompMgtDto> compList) {
		return newMtrlInfoService.setMtrlRtlCompDelete(compList);
	}
	
}
