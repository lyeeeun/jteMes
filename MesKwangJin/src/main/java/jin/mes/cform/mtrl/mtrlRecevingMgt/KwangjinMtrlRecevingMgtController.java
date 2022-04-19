package jin.mes.cform.mtrl.mtrlRecevingMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingHisDto;
import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Controller
@RequestMapping("/cform/mtrl/mtrlRecevingMgt")
public class KwangjinMtrlRecevingMgtController extends BaseController {

	@Autowired
	KwangjinMtrlRecevingMgtService kwangjinMtrlRecevingMgtService;
	
	@RequestMapping("/getMtrlRecevingMgtList")
	public ModelMap getMtrlRecevingMgtList(ModelMap model, @ModelAttribute("kwangjinMtrlRecevingMgtDto") KwangjinMtrlRecevingMgtDto kwangjinMtrlRecevingMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrlRecevingMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrlRecevingMgtDto.getRows());
		pageRequestVo.setPagingYN(kwangjinMtrlRecevingMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinMtrlRecevingMgtService.getMtrlRecevingMgtList(kwangjinMtrlRecevingMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlRecevingMgtSave")
	@ResponseBody
	public String setMtrlRecevingMgtSave(@RequestBody KwangjinMtrlRecevingMgtDto kwangjinMtrlRecevingMgtDto) {
		return kwangjinMtrlRecevingMgtService.setMtrlRecevingMgtSave(kwangjinMtrlRecevingMgtDto);
	}
	
	@RequestMapping("/getMtrlRecevingHisList")
	public ModelMap getMtrlRecevingHisList(ModelMap model, @ModelAttribute("kwangjinMtrlRecevingHisDto") KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrlRecevingHisDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrlRecevingHisDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinMtrlRecevingMgtService.getMtrlRecevingHisList(kwangjinMtrlRecevingHisDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlManualSave")
	@ResponseBody
	public String setMtrlManualSave(@RequestBody KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto) {
		return kwangjinMtrlRecevingMgtService.setMtrlManualSave(kwangjinMtrlRecevingHisDto);
	}
	
	@RequestMapping("/setMtrlManualDelete")
	@ResponseBody
	public int setMtrlManualDelete(ModelMap model, @RequestBody List<KwangjinMtrlRecevingHisDto> mtrlHisList) {
		return kwangjinMtrlRecevingMgtService.setMtrlManualDelete(mtrlHisList);
	}
}
