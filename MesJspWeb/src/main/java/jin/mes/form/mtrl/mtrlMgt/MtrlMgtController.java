package jin.mes.form.mtrl.mtrlMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.mtrlInfo.MtrlInfoDto;
import jin.mes.form.basMgt.operMgt.mtrlInfo.MtrlInfoService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mtrl/mtrlMgt")
public class MtrlMgtController extends BaseController {

	@Autowired
	MtrlInfoService mtrlInfoService;
	
	@Autowired
	MtrlMgtService mtrlMgtService;
	
	@RequestMapping("/getMtrlInfoList")
	public ModelMap getMtrlInfoList(ModelMap model, @ModelAttribute("mtrlInfoDto") MtrlInfoDto mtrlInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlInfoDto.getPage())));
		pageRequestVo.setRows(mtrlInfoDto.getRows());
		try {
			setModelWithkendoList(model, mtrlInfoService.getMtrlInfoList(mtrlInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getMtrlMgtList")
	public ModelMap getMtrlMgtList(ModelMap model, @ModelAttribute("mtrlMgtDto") MtrlMgtDto mtrlMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlMgtDto.getPage())));
		pageRequestVo.setRows(mtrlMgtDto.getRows());
		pageRequestVo.setPagingYN(mtrlMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, mtrlMgtService.getMtrlMgtList(mtrlMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlMgtSave")
	@ResponseBody
	public String setMtrlMgtSave(@RequestBody MtrlMgtDto mtrlMgtDto) {
		return mtrlMgtService.setMtrlMgtSave(mtrlMgtDto);
	}
	
	@RequestMapping("/setMtrlMgtDelete")
	@ResponseBody
	public int setMtrlMgtDelete(ModelMap model, @RequestBody List<MtrlMgtDto> mtrlMgtList) {
		return mtrlMgtService.setMtrlMgtDelete(mtrlMgtList);
	}
	
	@RequestMapping("/getMtrlHistoryList")
	public ModelMap getMtrlHistoryList(ModelMap model, @ModelAttribute("mtrlHisDto") MtrlHistoryDto mtrlHisDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlHisDto.getPage())));
		pageRequestVo.setRows(mtrlHisDto.getRows());
		try {
			setModelWithkendoList(model, mtrlMgtService.getMtrlHistoryList(mtrlHisDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlManualSave")
	@ResponseBody
	public String setMtrlManualSave(@RequestBody MtrlHistoryDto mtrlHisDto) {
		return mtrlMgtService.setMtrlManualSave(mtrlHisDto);
	}
	
	@RequestMapping("/setMtrlManualDelete")
	@ResponseBody
	public int setMtrlManualDelete(ModelMap model, @RequestBody List<MtrlHistoryDto> mtrlHisList) {
		return mtrlMgtService.setMtrlManualDelete(mtrlHisList);
	}
}
