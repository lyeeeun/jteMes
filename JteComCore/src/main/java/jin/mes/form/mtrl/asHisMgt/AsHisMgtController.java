package jin.mes.form.mtrl.asHisMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.ship.shipMgt.ShipMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mtrl/asHisMgt")
public class AsHisMgtController extends BaseController {

	@Autowired
	AsHisMgtService asHisMgtService;
	
	@RequestMapping("/getSerialList")
	public ModelMap getSerialList(ModelMap model, @ModelAttribute("asHisMgtDto") AsHisMgtDto asHisMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(asHisMgtDto.getPage())));
		pageRequestVo.setRows(asHisMgtDto.getRows());
		pageRequestVo.setPagingYN(asHisMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, asHisMgtService.getSerialList(asHisMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getAsHisMgtList")
	public ModelMap getAsHisMgtList(ModelMap model, @ModelAttribute("asHisMgtDto") AsHisMgtDto asHisMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(asHisMgtDto.getPage())));
		pageRequestVo.setRows(asHisMgtDto.getRows());
		pageRequestVo.setPagingYN(asHisMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, asHisMgtService.getAsHisMgtList(asHisMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setAsHisMgtSave")
	@ResponseBody
	public String setAsHisMgtSave(@RequestBody AsHisMgtDto asHisMgtDto) {
		return asHisMgtService.setAsHisMgtSave(asHisMgtDto);
	}
	
	@RequestMapping("/setAsHisMgtDelete")
	@ResponseBody
	public int setAsHisMgtDelete(ModelMap model, @RequestBody List<AsHisMgtDto> ashisMgtList) {
		return asHisMgtService.setAsHisMgtDelete(ashisMgtList);
	}

}
