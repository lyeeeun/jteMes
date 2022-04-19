package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.cform.basMgt.operMgt.compMgt.ZinixCompMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/operMgt/mtrlInfo")
public class ZinixMtrlInfoController extends BaseController {

	@Autowired
	ZinixMtrlInfoService zinixMtrlInfoService;
	
	
	@RequestMapping("getMtrlInfoList")
	public ModelMap getMtrlInfoList(ModelMap model, @ModelAttribute("mtrlInfoDto") ZinixMtrlInfoDto mtrlInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlInfoDto.getPage())));
		pageRequestVo.setRows(mtrlInfoDto.getRows());
		try {
			setModelWithkendoList(model, zinixMtrlInfoService.getMtrlInfoList(mtrlInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	//자재 상세조회(mtrl-child)
	@RequestMapping("getMtrlPop")
	public ModelMap getMtrlPop(ModelMap model, @ModelAttribute("mtrlInfoDto") ZinixMtrlInfoDto mtrlInfoDto) {
		try {
			model.addAttribute("rows", zinixMtrlInfoService.getMtrlPop(mtrlInfoDto)); 
		}catch(Exception ex) {
			throw new BusinessException("자재 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlInfoSave")
	@ResponseBody
	public String setMtrlInfoSave(@RequestBody ZinixMtrlInfoDto mtrlInfoDto) {
		return zinixMtrlInfoService.setMtrlInfoSave(mtrlInfoDto);
	}
	
	@RequestMapping("/setMtrlInfoDelete")
	@ResponseBody
	public int setMtrlInfoDelete(ModelMap model, @RequestBody List<ZinixMtrlInfoDto> mtrlInfoList) {
		return zinixMtrlInfoService.setMtrlInfoDelete(mtrlInfoList);
	}
	
	@RequestMapping("getMtrlRtlCompList")
	public ModelMap getMtrlRtlCompList(ModelMap model, @ModelAttribute("compMgtDto") ZinixCompMgtDto compMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(compMgtDto.getPage())));
		pageRequestVo.setRows(compMgtDto.getRows());
		try {
			setModelWithkendoList(model, zinixMtrlInfoService.getMtrlRtlCompList(compMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	/*
	@RequestMapping("/setMtrlRtlCompSave")
	@ResponseBody
	public String setMtrlRtlCompSave(@RequestBody ZinixCompMgtDto compDto) {
		return zinixMtrlInfoService.setMtrlRtlCompSave(compDto);
	}
	
	@RequestMapping("/setMtrlRtlCompDelete")
	@ResponseBody
	public int setMtrlRtlCompDelete(ModelMap model, @RequestBody List<ZinixCompMgtDto> compList) {
		return zinixMtrlInfoService.setMtrlRtlCompDelete(compList);
	}
	*/
//	
//	@RequestMapping("/minOutOfStockAlarm")
//	public void minOutOfStockAlarm(String mtrlMgtId) {
//		zinixMtrlInfoService.minOutOfStockAlarm(mtrlMgtId);
//	}
	

}
