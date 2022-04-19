package jin.mes.cform.mtrl.asHisMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.ship.shipMgt.ZinixShipMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mtrl/asHisMgt")
public class ZinixAsHisMgtController extends BaseController {

	@Autowired
	ZinixAsHisMgtService zinixAsHisMgtService;
	
	@RequestMapping("/getSerialList")
	public ModelMap getSerialList(ModelMap model, @ModelAttribute("zinixAsHisMgtDto") ZinixAsHisMgtDto zinixAsHisMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixAsHisMgtDto.getPage())));
		pageRequestVo.setRows(zinixAsHisMgtDto.getRows());
		pageRequestVo.setPagingYN(zinixAsHisMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, zinixAsHisMgtService.getSerialList(zinixAsHisMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getAsHisMgtList")
	public ModelMap getAsHisMgtList(ModelMap model, @ModelAttribute("zinixAsHisMgtDto") ZinixAsHisMgtDto zinixAsHisMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixAsHisMgtDto.getPage())));
		pageRequestVo.setRows(zinixAsHisMgtDto.getRows());
		pageRequestVo.setPagingYN(zinixAsHisMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, zinixAsHisMgtService.getAsHisMgtList(zinixAsHisMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setAsHisMgtSave")
	@ResponseBody
	public String setAsHisMgtSave(@RequestBody ZinixAsHisMgtDto zinixAsHisMgtDto) {
		return zinixAsHisMgtService.setAsHisMgtSave(zinixAsHisMgtDto);
	}
	
	@RequestMapping("/setAsHisMgtDelete")
	@ResponseBody
	public int setAsHisMgtDelete(ModelMap model, @RequestBody List<ZinixAsHisMgtDto> ashisMgtList) {
		return zinixAsHisMgtService.setAsHisMgtDelete(ashisMgtList);
	}

}
