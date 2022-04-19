package jin.mes.cform.qualMgt.inputQualMgt;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/qualMgt/inputQualMgt")
public class KwangjinInputQualMgtController extends BaseController {

	@Autowired
	KwangjinInputQualMgtService kwangjinInputQualMgtService;
	
	@RequestMapping("getMtrlBadList")
	public ModelMap getMtrlBadList(ModelMap model, @ModelAttribute("kwangjinInputQualMgtDto") KwangjinInputQualMgtDto kwangjinInputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinInputQualMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinInputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinInputQualMgtService.getMtrlBadList(kwangjinInputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlBadSave")
	@ResponseBody
	public String setMtrlBadSave(@RequestBody KwangjinInputQualMgtDto kwangjinInputQualMgtDto) {
		return kwangjinInputQualMgtService.setMtrlBadSave(kwangjinInputQualMgtDto);
	}
	
	@RequestMapping("/setMtrlBadDelete")
	@ResponseBody
	public int setMtrlBadDelete(ModelMap model, @RequestBody List<KwangjinInputQualMgtDto> mtrlBadList) {
		return kwangjinInputQualMgtService.setMtrlBadDelete(mtrlBadList);
	}
	
	@RequestMapping("getMtrlMgtHisList")
	public ModelMap getMtrlMgtHisList(ModelMap model, @ModelAttribute("kwangjinInputQualMgtDto") KwangjinInputQualMgtDto kwangjinInputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinInputQualMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinInputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinInputQualMgtService.getMtrlMgtHisList(kwangjinInputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getMtrlMgtList")
	public ModelMap getMtrlMgtList(ModelMap model, @ModelAttribute("kwangjinInputQualMgtDto") KwangjinInputQualMgtDto kwangjinInputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinInputQualMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinInputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinInputQualMgtService.getMtrlMgtList(kwangjinInputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
