package jin.mes.cform.qualMgt.smplPectMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.qualMgt.infergodsMgt.KwangjinInfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/qualMgt/smplPectMgt")
public class KwangjinSmplPectMgtController extends BaseController {

	@Autowired
	KwangjinSmplPectMgtService kwangjinSmplPectMgtService;
	
	@RequestMapping("getProdAsgnList")
	public ModelMap getProdAsgnList(ModelMap model, @ModelAttribute("kwangjinSmplPectMgtDto") KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinSmplPectMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinSmplPectMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinSmplPectMgtService.getProdAsgnList(kwangjinSmplPectMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getLotList")
	public ModelMap getLotList(ModelMap model, @ModelAttribute("kwangjinSmplPectMgtDto") KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinSmplPectMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinSmplPectMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinSmplPectMgtService.getLotList(kwangjinSmplPectMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getRoutWorkList")
	public ModelMap getRoutWorkList(ModelMap model, @ModelAttribute("kwangjinSmplPectMgtDto") KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinSmplPectMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinSmplPectMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinSmplPectMgtService.getRoutWorkList(kwangjinSmplPectMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getItemBadList")
	public ModelMap getItemBadList(ModelMap model, @ModelAttribute("kwangjinSmplPectMgtDto") KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinSmplPectMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinSmplPectMgtDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(kwangjinSmplPectMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinSmplPectMgtService.getItemBadList(kwangjinSmplPectMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setItemBadSave")
	@ResponseBody
	public String setItemBadSave(@RequestBody KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto) {
		return kwangjinSmplPectMgtService.setItemBadSave(kwangjinSmplPectMgtDto);
	}
	
	@RequestMapping("/setItemBadDelete")
	@ResponseBody
	public int setItemBadDelete(@RequestBody List<KwangjinSmplPectMgtDto> kwangjinSmplPectMgtDto) {
		return kwangjinSmplPectMgtService.setItemBadDelete(kwangjinSmplPectMgtDto);
	}
}
