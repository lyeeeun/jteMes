package jin.mes.cform.mtrl.mtrlMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.operMgt.mtrlInfo.ZinixMtrlInfoDto;
import jin.mes.cform.basMgt.operMgt.mtrlInfo.ZinixMtrlInfoService;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mtrl/mtrlMgt")
public class ZinixMtrlMgtController extends BaseController {

	@Autowired
	ZinixMtrlInfoService zinixMtrlInfoService;
	
	@Autowired
	ZinixMtrlMgtService zinixMtrlMgtService;
	
	@RequestMapping("/getMtrlInfoList")
	public ModelMap getMtrlInfoList(ModelMap model, @ModelAttribute("mtrlInfoDto") ZinixMtrlInfoDto mtrlInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlInfoDto.getPage())));
		pageRequestVo.setRows(mtrlInfoDto.getRows());
		try {
			setModelWithkendoList(model, zinixMtrlInfoService.getMtrlInfoList(mtrlInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getMtrlMgtList")
	public ModelMap getMtrlMgtList(ModelMap model, @ModelAttribute("mtrlMgtDto") ZinixMtrlMgtDto mtrlMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlMgtDto.getPage())));
		pageRequestVo.setRows(mtrlMgtDto.getRows());
		pageRequestVo.setPagingYN(mtrlMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, zinixMtrlMgtService.getMtrlMgtList(mtrlMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlMgtSave")
	@ResponseBody
	public String setMtrlMgtSave(@RequestBody ZinixMtrlMgtDto mtrlMgtDto) {
		return zinixMtrlMgtService.setMtrlMgtSave(mtrlMgtDto);
	}
	
	@RequestMapping("/setMtrlMgtDelete")
	@ResponseBody
	public int setMtrlMgtDelete(ModelMap model, @RequestBody List<ZinixMtrlMgtDto> mtrlMgtList) {
		return zinixMtrlMgtService.setMtrlMgtDelete(mtrlMgtList);
	}
	
	@RequestMapping("/getMtrlHistoryList")
	public ModelMap getMtrlHistoryList(ModelMap model, @ModelAttribute("mtrlHisDto") ZinixMtrlHistoryDto mtrlHisDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlHisDto.getPage())));
		pageRequestVo.setRows(mtrlHisDto.getRows());
		try {
			setModelWithkendoList(model, zinixMtrlMgtService.getMtrlHistoryList(mtrlHisDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlManualSave")
	@ResponseBody
	public String setMtrlManualSave(@RequestBody ZinixMtrlHistoryDto mtrlHisDto) {
		return zinixMtrlMgtService.setMtrlManualSave(mtrlHisDto);
	}
	
	@RequestMapping("/setMtrlManualDelete")
	@ResponseBody
	public int setMtrlManualDelete(ModelMap model, @RequestBody List<ZinixMtrlHistoryDto> mtrlHisList) {
		return zinixMtrlMgtService.setMtrlManualDelete(mtrlHisList);
	}
}
