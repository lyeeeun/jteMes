package jin.mes.cform.mtrl.invenMgt;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.mtrl.invenMgt.KwangjinInvenHisDto;
import jin.mes.cform.mtrl.invenMgt.KwangjinInvenMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Controller
@RequestMapping("/cform/mtrl/invenMgt")
public class KwangjinInvenMgtController extends BaseController {

	@Autowired
	KwangjinInvenMgtService kwangjinInvenMgtService;
	
	@RequestMapping("/getInvenMgtList")
	public ModelMap getInvenMgtList(ModelMap model, @ModelAttribute("kwangjinInvenMgtDto") KwangjinInvenMgtDto kwangjinInvenMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinInvenMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinInvenMgtDto.getRows());
		pageRequestVo.setPagingYN(kwangjinInvenMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinInvenMgtService.getInvenMgtList(kwangjinInvenMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("제품 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getItemHisList")
	public ModelMap getItemHisList(ModelMap model, @ModelAttribute("kwangjinInvenHisDto") KwangjinInvenHisDto kwangjinInvenHisDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinInvenHisDto.getPage())));
		pageRequestVo.setRows(kwangjinInvenHisDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinInvenMgtService.getItemHisList(kwangjinInvenHisDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("제품 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getMtrlHisList")
	public ModelMap getMtrlHisList(ModelMap model, @ModelAttribute("kwangjinInvenHisDto") KwangjinInvenHisDto kwangjinInvenHisDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinInvenHisDto.getPage())));
		pageRequestVo.setRows(kwangjinInvenHisDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinInvenMgtService.getMtrlHisList(kwangjinInvenHisDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("제품 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
