package jin.mes.cform.mtrl.itemShipMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mtrl.itemShipMgt.KwangjinItemShipHisDto;
import jin.mes.cform.mtrl.itemShipMgt.KwangjinItemShipMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Controller
@RequestMapping("/cform/mtrl/itemShipMgt")
public class KwangjinItemShipMgtController extends BaseController {

	@Autowired
	KwangjinItemShipMgtService kwangjinItemShipMgtService;
	
	@RequestMapping("/getItemShipMgtList")
	public ModelMap getItemShipMgtList(ModelMap model, @ModelAttribute("kwangjinItemShipMgtDto") KwangjinItemShipMgtDto kwangjinItemShipMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinItemShipMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinItemShipMgtDto.getRows());
		pageRequestVo.setPagingYN(kwangjinItemShipMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinItemShipMgtService.getItemShipMgtList(kwangjinItemShipMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setItemShipMgtSave")
	@ResponseBody
	public String setItemShipMgtSave(@RequestBody KwangjinItemShipMgtDto kwangjinItemShipMgtDto) {
		return kwangjinItemShipMgtService.setItemShipMgtSave(kwangjinItemShipMgtDto);
	}
	
	@RequestMapping("/getItemShipHisList")
	public ModelMap getItemShipHisList(ModelMap model, @ModelAttribute("kwangjinItemShipHisDto") KwangjinItemShipHisDto kwangjinItemShipHisDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinItemShipHisDto.getPage())));
		pageRequestVo.setRows(kwangjinItemShipHisDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinItemShipMgtService.getItemShipHisList(kwangjinItemShipHisDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setItemManualSave")
	@ResponseBody
	public String setItemManualSave(@RequestBody KwangjinItemShipHisDto kwangjinItemShipHisDto) {
		return kwangjinItemShipMgtService.setItemManualSave(kwangjinItemShipHisDto);
	}
	
	@RequestMapping("/setItemManualDelete")
	@ResponseBody
	public int setItemManualDelete(ModelMap model, @RequestBody List<KwangjinItemShipHisDto> itemShipHisList) {
		return kwangjinItemShipMgtService.setItemManualDelete(itemShipHisList);
	}
}
