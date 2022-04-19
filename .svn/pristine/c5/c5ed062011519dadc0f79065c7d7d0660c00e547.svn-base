package jin.mes.cform.mtrl.mtrltoolMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mtrl.mtrltoolMgt.ZinixMtrltoolMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mtrl/mtrltoolMgt")
public class ZinixMtrltoolMgtController extends BaseController {

	@Autowired
	ZinixMtrltoolMgtService mtrltoolMgtService;
	
	//공구상세 조회
	@RequestMapping("getToolMgtList")
	public ModelMap getToolMgtList(ModelMap model, @ModelAttribute("toolMgtDto") ZinixMtrltoolMgtDto zinixToolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixToolMgtDto.getPage())));
		pageRequestVo.setRows(zinixToolMgtDto.getRows());
		try {
			setModelWithkendoList(model, mtrltoolMgtService.getToolMgtList(zinixToolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구상세 입력/수정
	@RequestMapping("/setToolMgtSave")
	@ResponseBody
	public String setToolMgtSave(@RequestBody ZinixMtrltoolMgtDto zinixToolMgtDto) {
		return mtrltoolMgtService.setToolMgtSave(zinixToolMgtDto);
	}
	
	//공구상세 삭제
	@RequestMapping("/setToolMgtDelete")
	@ResponseBody
	public int setToolMgtDelete(ModelMap model, @RequestBody List<ZinixMtrltoolMgtDto> toolMgtList) {
		return mtrltoolMgtService.setToolMgtDelete(toolMgtList);
	}
	
	//공구 정비이력 조회
	@RequestMapping("getToolMtncList")
	public ModelMap getToolMtncList(ModelMap model, @ModelAttribute("zinixToolMgtDto") ZinixMtrltoolMgtDto zinixToolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixToolMgtDto.getPage())));
		pageRequestVo.setRows(zinixToolMgtDto.getRows());
		try {
			setModelWithkendoList(model, mtrltoolMgtService.getToolMtncList(zinixToolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 정비이력 입력/수정
	@RequestMapping("/setToolMtncSave")
	@ResponseBody
	public String setToolMtncSave(@RequestBody ZinixMtrltoolMgtDto zinixToolMgtDto) {
		return mtrltoolMgtService.setToolMtncSave(zinixToolMgtDto);
	}
	
	//공구 정비이력 삭제
	@RequestMapping("/setToolMtncDelete")
	@ResponseBody
	public int setToolMtncDelete(ModelMap model, @RequestBody List<ZinixMtrltoolMgtDto> toolMtncList) {
		return mtrltoolMgtService.setToolMtncDelete(toolMtncList);
	}
	//공구 사용정보 조회
	@RequestMapping("getToolUseList")
	public ModelMap getToolUseList(ModelMap model, @ModelAttribute("zinixToolMgtDto") ZinixMtrltoolMgtDto zinixToolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixToolMgtDto.getPage())));
		pageRequestVo.setRows(zinixToolMgtDto.getRows());
		pageRequestVo.setPagingYN(zinixToolMgtDto.getPagingYN());
		
		try {
			setModelWithkendoList(model, mtrltoolMgtService.getToolUseList(zinixToolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구  사용정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
