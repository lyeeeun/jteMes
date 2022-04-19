package jin.mes.form.mfgMgt.mfgplanMgt.mrplanMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtDto;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mfgMgt/mfgplanMgt/mrplanMgt")
public class MrplanMgtController extends BaseController {
	
	@Autowired
	MrplanMgtService mrplanMgtService;
	

	@Autowired
	MtrlOdplanMgtService mtrlOrderService;
	
	@RequestMapping("getLotList")
	public ModelMap getCompList(ModelMap model, @ModelAttribute("mrplanMgtDto") MrplanMgtDto mrplanMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mrplanMgtDto.getPage())));
		pageRequestVo.setRows(mrplanMgtDto.getRows());
		try {
			setModelWithkendoList(model, mrplanMgtService.getLotList(mrplanMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("lot 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getMrpMtlList")
	public ModelMap getMrpMtlList(ModelMap model, @ModelAttribute("mrplanMgtDto") MrplanMgtDto mrplanMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mrplanMgtDto.getPage())));
		pageRequestVo.setRows(mrplanMgtDto.getRows());
		try {
			setModelWithkendoList(model, mrplanMgtService.getMrpMtlList(mrplanMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("mrp mtl 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlOrderSave")
	@ResponseBody
	public String setEqmtMgtSave(@RequestBody MtrlOdplanMgtDto mtrlOrderDto) {
		return mtrlOrderService.setMtrlOrderSave(mtrlOrderDto);
	}
	
	
	@RequestMapping("/getAllLotList")
	public ModelMap getAllLotList (@ModelAttribute MrplanMgtDto mrplanMgtDto, ModelMap model ) {
		try {
			model.addAttribute("result", mrplanMgtService.getAllLotList(mrplanMgtDto));
		} catch (Exception ex) {
			throw new BusinessException ("lot 전체 목록 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
}
