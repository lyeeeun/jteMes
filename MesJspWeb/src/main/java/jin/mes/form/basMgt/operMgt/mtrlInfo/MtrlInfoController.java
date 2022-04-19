package jin.mes.form.basMgt.operMgt.mtrlInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/basMgt/operMgt/mtrlInfo")
public class MtrlInfoController extends BaseController {

	@Autowired
	MtrlInfoService mtrlInfoService;
	
	
	@RequestMapping("getMtrlInfoList")
	public ModelMap getMtrlInfoList(ModelMap model, @ModelAttribute("mtrlInfoDto") MtrlInfoDto mtrlInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlInfoDto.getPage())));
		pageRequestVo.setRows(mtrlInfoDto.getRows());
		try {
			setModelWithkendoList(model, mtrlInfoService.getMtrlInfoList(mtrlInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlInfoSave")
	@ResponseBody
	public String setMtrlInfoSave(@RequestBody MtrlInfoDto mtrlInfoDto) {
		return mtrlInfoService.setMtrlInfoSave(mtrlInfoDto);
	}
	
	@RequestMapping("/setMtrlInfoDelete")
	@ResponseBody
	public int setMtrlInfoDelete(ModelMap model, @RequestBody List<MtrlInfoDto> mtrlInfoList) {
		return mtrlInfoService.setMtrlInfoDelete(mtrlInfoList);
	}
	
	@RequestMapping("getMtrlRtlCompList")
	public ModelMap getMtrlRtlCompList(ModelMap model, @ModelAttribute("compMgtDto") CompMgtDto compMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(compMgtDto.getPage())));
		pageRequestVo.setRows(compMgtDto.getRows());
		try {
			setModelWithkendoList(model, mtrlInfoService.getMtrlRtlCompList(compMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlRtlCompSave")
	@ResponseBody
	public String setMtrlRtlCompSave(@RequestBody CompMgtDto compDto) {
		return mtrlInfoService.setMtrlRtlCompSave(compDto);
	}
	
	@RequestMapping("/setMtrlRtlCompDelete")
	@ResponseBody
	public int setMtrlRtlCompDelete(ModelMap model, @RequestBody List<CompMgtDto> compList) {
		return mtrlInfoService.setMtrlRtlCompDelete(compList);
	}
	
}
