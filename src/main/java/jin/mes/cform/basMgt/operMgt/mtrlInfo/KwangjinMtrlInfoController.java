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
import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/operMgt/mtrlInfo")
public class KwangjinMtrlInfoController extends BaseController {

	@Autowired
	KwangjinMtrlInfoService kwangjinMtrlInfoService;
	
	
	@RequestMapping("getMtrlInfoList")
	public ModelMap getMtrlInfoList(ModelMap model, @ModelAttribute("kwangjinMtrlInfoDto") KwangjinMtrlInfoDto kwangjinMtrlInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrlInfoDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrlInfoDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinMtrlInfoService.getMtrlInfoList(kwangjinMtrlInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	//자재 상세조회(mtrl-child)
	@RequestMapping("getMtrlPop")
	public ModelMap getMtrlPop(ModelMap model, @ModelAttribute("kwangjinMtrlInfoDto") KwangjinMtrlInfoDto kwangjinMtrlInfoDto) {
		try {
			model.addAttribute("rows", kwangjinMtrlInfoService.getMtrlPop(kwangjinMtrlInfoDto)); 
		}catch(Exception ex) {
			throw new BusinessException("자재 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlInfoSave")
	@ResponseBody
	public String setMtrlInfoSave(@RequestBody KwangjinMtrlInfoDto kwangjinMtrlInfoDto) {
		return kwangjinMtrlInfoService.setMtrlInfoSave(kwangjinMtrlInfoDto);
	}
	
	@RequestMapping("/setMtrlInfoDelete")
	@ResponseBody
	public int setMtrlInfoDelete(ModelMap model, @RequestBody List<KwangjinMtrlInfoDto> mtrlInfoList) {
		return kwangjinMtrlInfoService.setMtrlInfoDelete(mtrlInfoList);
	}
	
	@RequestMapping("getMtrlRtlCompList")
	public ModelMap getMtrlRtlCompList(ModelMap model, @ModelAttribute("kwangjinCompMgtDto") KwangjinCompMgtDto kwangjinCompMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinCompMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinCompMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinMtrlInfoService.getMtrlRtlCompList(kwangjinCompMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	/*
	@RequestMapping("/setMtrlRtlCompSave")
	@ResponseBody
	public String setMtrlRtlCompSave(@RequestBody KwangjinCompMgtDto compDto) {
		return kwangjinMtrlInfoService.setMtrlRtlCompSave(compDto);
	}
	
	@RequestMapping("/setMtrlRtlCompDelete")
	@ResponseBody
	public int setMtrlRtlCompDelete(ModelMap model, @RequestBody List<KwangjinCompMgtDto> compList) {
		return kwangjinMtrlInfoService.setMtrlRtlCompDelete(compList);
	}
	*/
//	
//	@RequestMapping("/minOutOfStockAlarm")
//	public void minOutOfStockAlarm(String mtrlMgtId) {
//		kwangjinMtrlInfoService.minOutOfStockAlarm(mtrlMgtId);
//	}
	

}
