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
public class ZinixCompMgtController extends BaseController {

	@Autowired
	ZinixCompMgtService zinixCompMgtService;
	
	
	@RequestMapping("getCompList")
	public ModelMap getCompList(ModelMap model, @ModelAttribute("compMgtDto") ZinixCompMgtDto compMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(compMgtDto.getPage())));
		pageRequestVo.setRows(compMgtDto.getRows());
		try {
			setModelWithkendoList(model, zinixCompMgtService.getCompList(compMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("업체 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getCompPop")
	public ModelMap getCompPop(ModelMap model, @ModelAttribute("compMgtDto") ZinixCompMgtDto compMgtDto) {
		try {
			model.addAttribute("rows", zinixCompMgtService.getCompPop(compMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("업체 팝업 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setCompSave")
	@ResponseBody
	public String setCompSave(@RequestBody ZinixCompMgtDto compDto) {
		return zinixCompMgtService.setCompSave(compDto);
	}
	
	@RequestMapping("/setCompDelete")
	@ResponseBody
	public int setCompDelete(ModelMap model, @RequestBody List<ZinixCompMgtDto> compList) {
		return zinixCompMgtService.setCompDelete(compList);
	}
	
	@RequestMapping("getCompAddrList")
	public ModelMap getCompAddrList(ModelMap model, @ModelAttribute("compAddrDto") ZinixCompAddrDto compAddrDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(compAddrDto.getPage())));
		pageRequestVo.setRows(compAddrDto.getRows());
		try {
			setModelWithkendoList(model, zinixCompMgtService.getCompAddrList(compAddrDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("업체 조회 에러  : " + ex.getMessage());
		}
		return model;
	}

	@RequestMapping("/setCompAddrSave")
	@ResponseBody
	public String setCompAddrSave(@RequestBody ZinixCompAddrDto compAddrDto) {
		return zinixCompMgtService.setCompAddrSave(compAddrDto);
	}

	@RequestMapping("/setCompAddrDelete")
	@ResponseBody
	public int setCompAddrDelete(ModelMap model, @RequestBody List<ZinixCompAddrDto> compAddrList) {
		return zinixCompMgtService.setCompAddrDelete(compAddrList);
	}

	@RequestMapping("/getAllCompList")
	public ModelMap getAllCompList(@ModelAttribute ZinixCompMgtDto compMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", zinixCompMgtService.getAllCompList(compMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("업체 전체 목록 조회 에러  : " + ex.getMessage());
		}
		return model;
	}



}
