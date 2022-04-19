package jin.mes.cform.mtrl.mtrlMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.operMgt.mtrlInfo.NewMtrlInfoDto;
import jin.mes.cform.basMgt.operMgt.mtrlInfo.NewMtrlInfoService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mtrl/mtrlMgt")
public class NewMtrlMgtController extends BaseController {

	@Autowired
	NewMtrlInfoService newMtrlInfoService;
	
	@Autowired
	NewMtrlMgtService newMtrlMgtService;
	
	@RequestMapping("/getMtrlInfoList")
	public ModelMap getMtrlInfoList(ModelMap model, @ModelAttribute("mtrlInfoDto") NewMtrlInfoDto mtrlInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlInfoDto.getPage())));
		pageRequestVo.setRows(mtrlInfoDto.getRows());
		try {
			setModelWithkendoList(model, newMtrlInfoService.getMtrlInfoList(mtrlInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getMtrlMgtList")
	public ModelMap getMtrlMgtList(ModelMap model, @ModelAttribute("mtrlMgtDto") NewMtrlMgtDto mtrlMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlMgtDto.getPage())));
		pageRequestVo.setRows(mtrlMgtDto.getRows());
		pageRequestVo.setPagingYN(mtrlMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, newMtrlMgtService.getMtrlMgtList(mtrlMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlMgtSave")
	@ResponseBody
	public String setMtrlMgtSave(@RequestBody NewMtrlMgtDto mtrlMgtDto) {
		return newMtrlMgtService.setMtrlMgtSave(mtrlMgtDto);
	}
	
	@RequestMapping("/setMtrlMgtDelete")
	@ResponseBody
	public int setMtrlMgtDelete(ModelMap model, @RequestBody List<NewMtrlMgtDto> mtrlMgtList) {
		return newMtrlMgtService.setMtrlMgtDelete(mtrlMgtList);
	}
	
	@RequestMapping("/getMtrlHistoryList")
	public ModelMap getMtrlHistoryList(ModelMap model, @ModelAttribute("mtrlHisDto") NewMtrlHistoryDto mtrlHisDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlHisDto.getPage())));
		pageRequestVo.setRows(mtrlHisDto.getRows());
		try {
			setModelWithkendoList(model, newMtrlMgtService.getMtrlHistoryList(mtrlHisDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlManualSave")
	@ResponseBody
	public String setMtrlManualSave(@RequestBody NewMtrlHistoryDto mtrlHisDto) {
		return newMtrlMgtService.setMtrlManualSave(mtrlHisDto);
	}
	
	@RequestMapping("/setMtrlManualDelete")
	@ResponseBody
	public int setMtrlManualDelete(ModelMap model, @RequestBody List<NewMtrlHistoryDto> mtrlHisList) {
		return newMtrlMgtService.setMtrlManualDelete(mtrlHisList);
	}
}
