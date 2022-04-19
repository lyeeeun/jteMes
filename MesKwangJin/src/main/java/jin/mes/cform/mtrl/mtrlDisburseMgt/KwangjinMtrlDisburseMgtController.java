package jin.mes.cform.mtrl.mtrlDisburseMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mtrl.mtrlDisburseMgt.KwangjinMtrlDisburseHisDto;
import jin.mes.cform.mtrl.mtrlDisburseMgt.KwangjinMtrlDisburseMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Controller
@RequestMapping("/cform/mtrl/mtrlDisburseMgt")
public class KwangjinMtrlDisburseMgtController extends BaseController {

	@Autowired
	KwangjinMtrlDisburseMgtService kwangjinMtrlDisburseMgtService;
	
	@RequestMapping("/getMtrlDisburseMgtList")
	public ModelMap getMtrlDisburseMgtList(ModelMap model, @ModelAttribute("kwangjinMtrlDisburseMgtDto") KwangjinMtrlDisburseMgtDto kwangjinMtrlDisburseMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrlDisburseMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrlDisburseMgtDto.getRows());
		pageRequestVo.setPagingYN(kwangjinMtrlDisburseMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinMtrlDisburseMgtService.getMtrlDisburseMgtList(kwangjinMtrlDisburseMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlDisburseMgtSave")
	@ResponseBody
	public String setMtrlDisburseMgtSave(@RequestBody KwangjinMtrlDisburseMgtDto kwangjinMtrlDisburseMgtDto) {
		return kwangjinMtrlDisburseMgtService.setMtrlDisburseMgtSave(kwangjinMtrlDisburseMgtDto);
	}
	
	@RequestMapping("/getMtrlDisburseHisList")
	public ModelMap getMtrlDisburseHisList(ModelMap model, @ModelAttribute("kwangjinMtrlDisburseHisDto") KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrlDisburseHisDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrlDisburseHisDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinMtrlDisburseMgtService.getMtrlDisburseHisList(kwangjinMtrlDisburseHisDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlManualSave")
	@ResponseBody
	public String setMtrlManualSave(@RequestBody KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto) {
		return kwangjinMtrlDisburseMgtService.setMtrlManualSave(kwangjinMtrlDisburseHisDto);
	}
	
	@RequestMapping("/setMtrlManualDelete")
	@ResponseBody
	public int setMtrlManualDelete(ModelMap model, @RequestBody List<KwangjinMtrlDisburseHisDto> mtrlHisList) {
		return kwangjinMtrlDisburseMgtService.setMtrlManualDelete(mtrlHisList);
	}
}
