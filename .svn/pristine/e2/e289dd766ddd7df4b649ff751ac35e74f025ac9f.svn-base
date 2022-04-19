package jin.mes.cform.mfgMgt.mfgplanMgt.mrplanMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.NewMtrlOdplanMgtDto;
import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.NewMtrlOdplanMgtService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/mfgplanMgt/mrplanMgt")
public class NewMrplanMgtController extends BaseController {
	
	@Autowired
	NewMrplanMgtService newMrplanMgtService;
	

	@Autowired
	NewMtrlOdplanMgtService newMtrlOrderService;
	
	@RequestMapping("getLotList")
	public ModelMap getCompList(ModelMap model, @ModelAttribute("newMrplanMgtDto") NewMrplanMgtDto newMrplanMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newMrplanMgtDto.getPage())));
		pageRequestVo.setRows(newMrplanMgtDto.getRows());
		try {
			setModelWithkendoList(model, newMrplanMgtService.getLotList(newMrplanMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("lot 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getMrpMtlList")
	public ModelMap getMrpMtlList(ModelMap model, @ModelAttribute("newMrplanMgtDto") NewMrplanMgtDto newMrplanMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newMrplanMgtDto.getPage())));
		pageRequestVo.setRows(newMrplanMgtDto.getRows());
		try {
			setModelWithkendoList(model, newMrplanMgtService.getMrpMtlList(newMrplanMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("mrp mtl 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlOrderSave")
	@ResponseBody
	public String setEqmtMgtSave(@RequestBody NewMtrlOdplanMgtDto newMtrlOrderDto) {
		return newMtrlOrderService.setMtrlOrderSave(newMtrlOrderDto);
	}
	
	
	@RequestMapping("/getAllLotList")
	public ModelMap getAllLotList (@ModelAttribute NewMrplanMgtDto newMrplanMgtDto, ModelMap model ) {
		try {
			model.addAttribute("result", newMrplanMgtService.getAllLotList(newMrplanMgtDto));
		} catch (Exception ex) {
			throw new BusinessException ("lot 전체 목록 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
}
