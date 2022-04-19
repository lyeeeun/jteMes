package jin.mes.cform.basMgt.operMgt.compMgt;

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
@RequestMapping("/cform/basMgt/operMgt/compMgt")
public class KwangjinCompMgtController extends BaseController {

	@Autowired
	KwangjinCompMgtService kwangjinCompMgtService;
	
	
	@RequestMapping("getCompList")
	public ModelMap getCompList(ModelMap model, @ModelAttribute("kwangjinCompMgtDto") KwangjinCompMgtDto kwangjinCompMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinCompMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinCompMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinCompMgtService.getCompList(kwangjinCompMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("업체 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getCompPop")
	public ModelMap getCompPop(ModelMap model, @ModelAttribute("kwangjinCompMgtDto") KwangjinCompMgtDto kwangjinCompMgtDto) {
		try {
			model.addAttribute("rows", kwangjinCompMgtService.getCompPop(kwangjinCompMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("업체 팝업 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setCompSave")
	@ResponseBody
	public String setCompSave(@RequestBody KwangjinCompMgtDto kwangjinCompMgtDto) {
		return kwangjinCompMgtService.setCompSave(kwangjinCompMgtDto);
	}
	
	@RequestMapping("/setCompDelete")
	@ResponseBody
	public int setCompDelete(ModelMap model, @RequestBody List<KwangjinCompMgtDto> compList) {
		return kwangjinCompMgtService.setCompDelete(compList);
	}
	
	@RequestMapping("getCompAddrList")
	public ModelMap getCompAddrList(ModelMap model, @ModelAttribute("kwangjinCompAddrDto") KwangjinCompAddrDto kwangjinCompAddrDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinCompAddrDto.getPage())));
		pageRequestVo.setRows(kwangjinCompAddrDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinCompMgtService.getCompAddrList(kwangjinCompAddrDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("업체 조회 에러  : " + ex.getMessage());
		}
		return model;
	}

	@RequestMapping("/setCompAddrSave")
	@ResponseBody
	public String setCompAddrSave(@RequestBody KwangjinCompAddrDto kwangjinCompAddrDto) {
		return kwangjinCompMgtService.setCompAddrSave(kwangjinCompAddrDto);
	}

	@RequestMapping("/setCompAddrDelete")
	@ResponseBody
	public int setCompAddrDelete(ModelMap model, @RequestBody List<KwangjinCompAddrDto> compAddrList) {
		return kwangjinCompMgtService.setCompAddrDelete(compAddrList);
	}

	@RequestMapping("/getAllCompList")
	public ModelMap getAllCompList(@ModelAttribute KwangjinCompMgtDto kwangjinCompMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", kwangjinCompMgtService.getAllCompList(kwangjinCompMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("업체 전체 목록 조회 에러  : " + ex.getMessage());
		}
		return model;
	}



}
