package jin.mes.cform.facilMgt.facilToolMgt;

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
@RequestMapping("/cform/facilMgt/facilToolMgt")
public class NewFacilToolMgtController extends BaseController {
	@Autowired
	NewFacilToolMgtService newEqmtToolService;
	
	//공구 설비 장착정보 조회
	@RequestMapping("getEqmtToolList")
	public ModelMap getEqmtToolList(ModelMap model, @ModelAttribute("newEqmtToolDto") NewFacilToolMgtDto newEqmtToolDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newEqmtToolDto.getPage())));
		pageRequestVo.setRows(newEqmtToolDto.getRows());
		try {
			setModelWithkendoList(model, newEqmtToolService.getEqmtToolList(newEqmtToolDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("설비공구 장착 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 설비 장착정보 전체조회
	@RequestMapping("getEqmtToolListAll")
	public ModelMap getEqmtToolListAll(ModelMap model, @ModelAttribute("newEqmtToolDto") NewFacilToolMgtDto newEqmtToolDto) {
		try {
			model.addAttribute("result", newEqmtToolService.getEqmtToolListAll(newEqmtToolDto));
		}catch(Exception ex) {
			throw new BusinessException("설비 상세 조회 에러(ALL) : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 설비 장착정보 입력/수정
	@RequestMapping("/setEqmtToolSave")
	@ResponseBody
	public String setEqmtToolSave(@RequestBody List<NewFacilToolMgtDto> eqmtToolList) {
		return newEqmtToolService.setEqmtToolSave(eqmtToolList);
	}
	
	//공구 설비 장착정보 삭제
	@RequestMapping("/setEqmtToolDelete")
	@ResponseBody
	public int setEqmtToolDelete(ModelMap model, @RequestBody List<NewFacilToolMgtDto> newEqmtToolDto) {
		return newEqmtToolService.setEqmtToolDelete(newEqmtToolDto);
	}
	
	//설비에서 제작가능한 아이템 조회
	@RequestMapping("getEqmtToolItemList")
	public ModelMap getEqmtToolItemList(ModelMap model, @RequestBody NewFacilToolMgtDto eqmtToolList) {
		try {
			model.addAttribute("rows", newEqmtToolService.getEqmtToolItemList(eqmtToolList));
		}catch(Exception ex) {
			throw new BusinessException("설비-아이템 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	//설비에서 제작가능한 라우팅 조회
	@RequestMapping("getEqmtToolRoutingList")
	public ModelMap getEqmtToolRoutingList(ModelMap model, @RequestBody NewFacilToolMgtDto eqmtToolList) {
		try {
			model.addAttribute("rows", newEqmtToolService.getEqmtToolRoutingList(eqmtToolList));
		}catch(Exception ex) {
			throw new BusinessException("설비-아이템 -라우팅 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//장착가능 공구 조회
	@RequestMapping("getEqmtToolPosList")
	public ModelMap getEqmtToolPosList(ModelMap model, @ModelAttribute("newEqmtToolDto") NewFacilToolMgtDto newEqmtToolDto) {
		try {
			model.addAttribute("rows", newEqmtToolService.getEqmtToolPosList(newEqmtToolDto));
		}catch(Exception ex) {
			throw new BusinessException("장착가능 공구 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 설비 장착정보 조회
	@RequestMapping("getRoutingToolCurList")
	public ModelMap getRoutingToolCurList(ModelMap model, @ModelAttribute("newEqmtToolDto") NewFacilToolMgtDto newEqmtToolDto) {
		try {
			model.addAttribute("rows", newEqmtToolService.getRoutingToolCurList(newEqmtToolDto));
		}catch(Exception ex) {
			throw new BusinessException("장착가능 공구 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//사용했던 공구 조회(관리자 조회용)
	@RequestMapping("getWorkToolAdminList")
	public ModelMap getWorkToolAdminList(ModelMap model, @ModelAttribute("newEqmtToolDto") NewFacilToolMgtDto newEqmtToolDto) {
		try {
			model.addAttribute("rows", newEqmtToolService.getWorkToolAdminList(newEqmtToolDto));
		}catch(Exception ex) {
			throw new BusinessException("사용했던 공구 조회 에러: " + ex.getMessage());
		}
		return model;
	}
	
	//사용했던 공구 조회(관리자 조회용)
	@RequestMapping("getWorkToolAdminPosList")
	public ModelMap getWorkToolAdminPosList(ModelMap model, @ModelAttribute("newEqmtToolDto") NewFacilToolMgtDto newEqmtToolDto) {
		try {
			model.addAttribute("rows", newEqmtToolService.getWorkToolAdminPosList(newEqmtToolDto));
		}catch(Exception ex) {
			throw new BusinessException("작업정보 관리자용 사용가능 공구 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
