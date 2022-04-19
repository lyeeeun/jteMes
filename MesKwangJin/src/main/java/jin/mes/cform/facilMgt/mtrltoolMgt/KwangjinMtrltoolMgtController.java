package jin.mes.cform.facilMgt.mtrltoolMgt;

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
@RequestMapping("/cform/facilMgt/mtrltoolMgt")
public class KwangjinMtrltoolMgtController extends BaseController {

	@Autowired
	KwangjinMtrltoolMgtService kwangjinMtrltoolMgtService;
	
	//공구 목록 조회
	@RequestMapping("/getToolInfoList")
	public ModelMap getMtrlRecevingMgtList(ModelMap model, @ModelAttribute("kwangjinMtrltoolMgtDto") KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrltoolMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrltoolMgtDto.getRows());
		pageRequestVo.setPagingYN(kwangjinMtrltoolMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinMtrltoolMgtService.getToolInfoList(kwangjinMtrltoolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 목록 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 수량 정보 조회
	@RequestMapping("/getToolRecevingHisList")
	public ModelMap getMtrlRecevingHisList(ModelMap model, @ModelAttribute("kwangjinMtrltoolMgtDto") KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrltoolMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrltoolMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinMtrltoolMgtService.getToolRecevingHisList(kwangjinMtrltoolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 사용 히스토리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구상세 조회
	@RequestMapping("getToolMgtList")
	public ModelMap getToolMgtList(ModelMap model, @ModelAttribute("kwangjinMtrltoolMgtDto") KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrltoolMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrltoolMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinMtrltoolMgtService.getToolMgtList(kwangjinMtrltoolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구상세 입력/수정
	@RequestMapping("/setToolMgtSave")
	@ResponseBody
	public String setToolMgtSave(@RequestBody KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto) {
		return kwangjinMtrltoolMgtService.setToolMgtSave(kwangjinMtrltoolMgtDto);
	}
	
	//공구상세 삭제
	@RequestMapping("/setToolMgtDelete")
	@ResponseBody
	public int setToolMgtDelete(ModelMap model, @RequestBody List<KwangjinMtrltoolMgtDto> toolMgtList) {
		return kwangjinMtrltoolMgtService.setToolMgtDelete(toolMgtList);
	}
	
	/* 
	 * 
	 * 
	 * 
	 * 기존 공구 상세 정보
	 * 
	 * 
	 * 
	 * 
	 * */
	
	//공구 정비이력 조회
	@RequestMapping("getToolMtncList")
	public ModelMap getToolMtncList(ModelMap model, @ModelAttribute("kwangjinMtrltoolMgtDto") KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrltoolMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrltoolMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinMtrltoolMgtService.getToolMtncList(kwangjinMtrltoolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 정비이력 입력/수정
	@RequestMapping("/setToolMtncSave")
	@ResponseBody
	public String setToolMtncSave(@RequestBody KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto) {
		return kwangjinMtrltoolMgtService.setToolMtncSave(kwangjinMtrltoolMgtDto);
	}
	
	//공구 정비이력 삭제
	@RequestMapping("/setToolMtncDelete")
	@ResponseBody
	public int setToolMtncDelete(ModelMap model, @RequestBody List<KwangjinMtrltoolMgtDto> toolMtncList) {
		return kwangjinMtrltoolMgtService.setToolMtncDelete(toolMtncList);
	}
	
	
	//공구 사용정보 조회
	@RequestMapping("getToolUseList")
	public ModelMap getToolUseList(ModelMap model, @ModelAttribute("kwangjinMtrltoolMgtDto") KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrltoolMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrltoolMgtDto.getRows());
		pageRequestVo.setPagingYN(kwangjinMtrltoolMgtDto.getPagingYN());
		
		try {
			setModelWithkendoList(model, kwangjinMtrltoolMgtService.getToolUseList(kwangjinMtrltoolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구  사용정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
