package jin.mes.cform.mfgMgt.productWork;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.facilMgt.facilToolMgt.NewFacilToolMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mfgMgt.wrkinWrkerMgt.NewMtrlUseDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/productWork")
public class NewProductWorkController extends BaseController {
	@Autowired
	NewProductWorkService newProductWorkService;
	
	@RequestMapping("/getProductWorkLotList")
	public ModelMap getProductWorkLotList(ModelMap model, @ModelAttribute("newLotInfoDto") NewLotInfoDto newLotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newLotInfoDto.getPage())));
		pageRequestVo.setRows(newLotInfoDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(newLotInfoDto.getPagingYN());
		try {
			
			setModelWithkendoList(model, newProductWorkService.getProductWorkLotList(newLotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 - LOT 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkAsgnList")
	public ModelMap getProdWorkAsgnList(ModelMap model, @ModelAttribute("newWrkinTeamMgtDto") NewWrkinTeamMgtDto newWrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", newProductWorkService.getProdWorkAsgnList(newWrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkAsgnDetail")
	public ModelMap getProdWorkAsgnDetail(ModelMap model, @ModelAttribute("newAsgnDto") NewWrkinTeamMgtDto newAsgnDto) {
		try {
			model.addAttribute("rows", newProductWorkService.getProdWorkAsgnDetail(newAsgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 상세 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkAsgnSave")
	@ResponseBody
	public String setProdWorkAsgnSave(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newProductWorkService.setProdWorkAsgnSave(newAsgnDto);
	}
	
	@RequestMapping("/setProdWorkAsgnDelete")
	@ResponseBody
	public int setProdWorkAsgnDelete(ModelMap model, @RequestBody List<NewWrkinTeamMgtDto> mtrlOrderList) {
		return newProductWorkService.setProdWorkAsgnDelete(mtrlOrderList);
	}
	
	@RequestMapping("/getProdWorkRoutSheetList")
	public ModelMap getProdWorkRoutSheetList(ModelMap model, @ModelAttribute("newWrkinTeamMgtDto") NewWrkinTeamMgtDto newWrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", newProductWorkService.getProdWorkRoutSheetList(newWrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("라우팅시트  조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkRoutSheetSave")
	@ResponseBody
	public String setProdWorkRoutSheetSave(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newProductWorkService.setProdWorkRoutSheetSave(newAsgnDto);
	}
	
	@RequestMapping("/getProdWorkEqmtChangeList")
	public ModelMap getProdWorkEqmtChangeList(ModelMap model, @ModelAttribute("newWrkinTeamMgtDto") NewWrkinTeamMgtDto newWrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", newProductWorkService.getProdWorkEqmtChangeList(newWrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("설비 변경 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkRoutSheetStart")
	@ResponseBody
	public String setProdWorkRoutSheetStart(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newProductWorkService.setProdWorkRoutSheetStart(newAsgnDto);
	}
	
	@RequestMapping("/setProdWorkRoutSheetEnd")
	@ResponseBody
	public String setProdWorkRoutSheetEnd(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newProductWorkService.setProdWorkRoutSheetEnd(newAsgnDto);
	}
	
	@RequestMapping("/getProdWorkEqmtToolList")
	public ModelMap getProdWorkEqmtToolList(ModelMap model, @ModelAttribute("newEqmtToolDto") NewFacilToolMgtDto newEqmtToolDto) {
		try {
			model.addAttribute("rows", newProductWorkService.getProdWorkEqmtToolList(newEqmtToolDto));
		}catch(Exception ex) {
			throw new BusinessException("현재 장착된 공구 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkToolUseableList")
	public ModelMap getProdWorkToolUseableList(ModelMap model, @ModelAttribute("newEqmtToolDto") NewFacilToolMgtDto newEqmtToolDto) {
		try {
			model.addAttribute("rows", newProductWorkService.getProdWorkToolUseableList(newEqmtToolDto));
		}catch(Exception ex) {
			throw new BusinessException("장착가능한 공구 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkEqmtTool")
	@ResponseBody
	public String setProdWorkEqmtTool(@RequestBody List<NewFacilToolMgtDto> eqmtToolList) {
		return newProductWorkService.setProdWorkEqmtTool(eqmtToolList);
	}
	
	@RequestMapping("/setProdWorkEqmtToolDel")
	@ResponseBody
	public String setProdWorkEqmtToolDel(@RequestBody List<NewFacilToolMgtDto> eqmtToolList) {
		return newProductWorkService.setProdWorkEqmtToolDel(eqmtToolList);
	}
	
	@RequestMapping("/getProdWorkMtrl")
	public ModelMap getProdWorkMtrl(ModelMap model, @ModelAttribute("newMtrlUseDto") NewMtrlUseDto newMtrlUseDto) {
		try {
			model.addAttribute("rows", newProductWorkService.getProdWorkMtrl(newMtrlUseDto));
		}catch(Exception ex) {
			throw new BusinessException("자재투입현황 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkMtrlSave")
	@ResponseBody
	public String setProdWorkMtrlSave(@RequestBody NewMtrlUseDto newMtrlUseDto) {
		return newProductWorkService.setProdWorkMtrlSave(newMtrlUseDto);
	}
	
	@RequestMapping("/setProdWorkMtrlDelete")
	@ResponseBody
	public int setProdWorkMtrlDelete(@RequestBody List<NewMtrlUseDto> mtrlUseList) {
		return newProductWorkService.setProdWorkMtrlDelete(mtrlUseList);
	}
	
	@RequestMapping("/getProdWorkItemBadList")
	public ModelMap getProdWorkItemBadList(ModelMap model, @ModelAttribute("newItemBadDto") NewInfergodsMgtDto newItemBadDto) {
		try {
			model.addAttribute("rows", newProductWorkService.getProdWorkItemBadList(newItemBadDto));
		}catch(Exception ex) {
			throw new BusinessException("품목불량 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}

	@RequestMapping("/setProdWorkItemBadSave")
	@ResponseBody
	public String setProdWorkItemBadSave(@RequestBody NewInfergodsMgtDto newItemBadDto) {
		return newProductWorkService.setProdWorkItemBadSave(newItemBadDto);
	}
}
