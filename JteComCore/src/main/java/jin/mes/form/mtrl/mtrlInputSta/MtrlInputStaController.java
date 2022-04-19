package jin.mes.form.mtrl.mtrlInputSta;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mtrl/mtrlInputSta")
public class MtrlInputStaController extends BaseController {
	@Autowired
	MtrlInputStaService mtrlInputStaService;
	

	@Autowired
	MtrlOdplanMgtService mtrlOrderService;
	
	@RequestMapping("getLotList")
	public ModelMap getCompList(ModelMap model, @ModelAttribute("mtrlInputStaDto") MtrlInputStaDto mtrlInputStaDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlInputStaDto.getPage())));
		pageRequestVo.setRows(mtrlInputStaDto.getRows());
		try {
			setModelWithkendoList(model, mtrlInputStaService.getLotList(mtrlInputStaDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("lot 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getMtrlInputList")
	public ModelMap getMrpMtlList(ModelMap model, @ModelAttribute("mtrlInputStaDto") MtrlInputStaDto mtrlInputStaDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlInputStaDto.getPage())));
		pageRequestVo.setRows(mtrlInputStaDto.getRows());
		try {
			setModelWithkendoList(model, mtrlInputStaService.getMrpMtlList(mtrlInputStaDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("mrp mtl 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
}
