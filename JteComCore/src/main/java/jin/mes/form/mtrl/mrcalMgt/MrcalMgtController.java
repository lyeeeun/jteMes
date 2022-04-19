package jin.mes.form.mtrl.mrcalMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtDto;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mtrl/mrcalMgt")
public class MrcalMgtController extends BaseController {

	@Autowired
	MrcalMgtService mrcalMgtService;
	

	@Autowired
	MtrlOdplanMgtService mtrlOrderService;
	
	@RequestMapping("getLotList")
	public ModelMap getCompList(ModelMap model, @ModelAttribute("mrcalMgtDto") MrcalMgtDto mrcalMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mrcalMgtDto.getPage())));
		pageRequestVo.setRows(mrcalMgtDto.getRows());
		try {
			setModelWithkendoList(model, mrcalMgtService.getLotList(mrcalMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("lot 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getMrpMtlList")
	public ModelMap getMrpMtlList(ModelMap model, @ModelAttribute("mrcalMgtDto") MrcalMgtDto mrcalMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mrcalMgtDto.getPage())));
		pageRequestVo.setRows(mrcalMgtDto.getRows());
		try {
			setModelWithkendoList(model, mrcalMgtService.getMrpMtlList(mrcalMgtDto,pageRequestVo));
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
	public ModelMap getAllLotList (@ModelAttribute MrcalMgtDto mrcalMgtDto, ModelMap model ) {
		try {
			model.addAttribute("result", mrcalMgtService.getAllLotList(mrcalMgtDto));
		} catch (Exception ex) {
			throw new BusinessException ("lot 전체 목록 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
