package jin.mes.form.mfgMgt.productWork;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mfgMgt/productWork")
public class ProductWorkController extends BaseController {
	@Autowired
	ProductWorkService productWorkService;
	
	@RequestMapping("/getProductWorkLotList")
	public ModelMap getProductWorkLotList(ModelMap model, @ModelAttribute("lotInfoDto") LotInfoDto lotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(lotInfoDto.getPage())));
		pageRequestVo.setRows(lotInfoDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(lotInfoDto.getPagingYN());
		try {
			
			setModelWithkendoList(model, productWorkService.getProductWorkLotList(lotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 - LOT 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkAsgnList")
	public ModelMap getProdWorkAsgnList(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") WrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", productWorkService.getProdWorkAsgnList(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkAsgnDetail")
	public ModelMap getProdWorkAsgnDetail(ModelMap model, @ModelAttribute("asgnDto") WrkinTeamMgtDto asgnDto) {
		try {
			model.addAttribute("rows", productWorkService.getProdWorkAsgnDetail(asgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 상세 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkAsgnSave")
	@ResponseBody
	public String setProdWorkAsgnSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkAsgnSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkAsgnDelete")
	@ResponseBody
	public String setProdWorkAsgnDelete(ModelMap model, @RequestBody List<WrkinTeamMgtDto> mtrlOrderList) {
		return productWorkService.setProdWorkAsgnDelete(mtrlOrderList);
	}
	
	@RequestMapping("/getProdWorkRoutSheetList")
	public ModelMap getProdWorkRoutSheetList(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") WrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", productWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("라우팅시트  조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkRoutSheetSave")
	@ResponseBody
	public String setProdWorkRoutSheetSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkRoutSheetSave(asgnDto);
	}
	
	@RequestMapping("/getProdWorkEqmtChangeList")
	public ModelMap getProdWorkEqmtChangeList(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") WrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", productWorkService.getProdWorkEqmtChangeList(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("설비 변경 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkEqmtToolList")
	public ModelMap getProdWorkEqmtToolList(ModelMap model, @ModelAttribute("eqmtToolDto") FacilToolMgtDto eqmtToolDto) {
		try {
			model.addAttribute("rows", productWorkService.getProdWorkEqmtToolList(eqmtToolDto));
		}catch(Exception ex) {
			throw new BusinessException("현재 장착된 공구 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkToolUseableList")
	public ModelMap getProdWorkToolUseableList(ModelMap model, @ModelAttribute("eqmtToolDto") FacilToolMgtDto eqmtToolDto) {
		try {
			model.addAttribute("rows", productWorkService.getProdWorkToolUseableList(eqmtToolDto));
		}catch(Exception ex) {
			throw new BusinessException("장착가능한 공구 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkEqmtTool")
	@ResponseBody
	public String setProdWorkEqmtTool(@RequestBody List<FacilToolMgtDto> eqmtToolList) {
		return productWorkService.setProdWorkEqmtTool(eqmtToolList);
	}
	
	@RequestMapping("/setProdWorkEqmtToolDel")
	@ResponseBody
	public String setProdWorkEqmtToolDel(@RequestBody List<FacilToolMgtDto> eqmtToolList) {
		return productWorkService.setProdWorkEqmtToolDel(eqmtToolList);
	}
	
//	@RequestMapping("/setProdWorkAsgnDelete")
//	@ResponseBody
//	public int setProdWorkAsgnDelete(ModelMap model, @RequestBody List<WrkinTeamMgtDto> mtrlOrderList) {
//		return productWorkService.setProdWorkAsgnDelete(mtrlOrderList);
//	}
	@RequestMapping("/getBomDetailInfo")
	public ModelMap getBomDetailInfo(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") WrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", productWorkService.getBomDetailInfo(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("사용될 자재 조회에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkStart")
	@ResponseBody
	public String setProdWorkStart(@RequestBody WrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkStart(asgnDto);
	}
	
	@RequestMapping("/setProdWorkCount")
	@ResponseBody
	public String setProdWorkCount(@RequestBody WrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkCount(asgnDto);
	}
	
	@RequestMapping("/setProdWorkEnd")
	@ResponseBody
	public String setProdWorkEnd(@RequestBody WrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkEnd(asgnDto);
	}
	
	@RequestMapping("/getBomMtrlList")
	public ModelMap getBomMtrlList(ModelMap model, @ModelAttribute("bomMtrlDto") BomMtrlDto bomMtrlDto) {
			model.addAttribute("rows", productWorkService.getBomMtrlList(bomMtrlDto));
		return model;
	}
	
	@RequestMapping("/getBomMtrlDetail")
	public ModelMap getBomMtrlDetail(ModelMap model, @ModelAttribute("bomMtrlDto") BomMtrlDto bomMtrlDto) {
			model.addAttribute("rows", productWorkService.getBomMtrlDetail(bomMtrlDto));
		return model;
	}
	
	
	@RequestMapping("/getMtrlBadInfo")
	public ModelMap getMtrlBadInfo(ModelMap model, @ModelAttribute("mtrlBadDto") InfergodsMgtDto mtrlBadDto) {
			model.addAttribute("rows", productWorkService.getMtrlBadInfo(mtrlBadDto));
		return model;
	}
	
	@RequestMapping("/setMtrlBadSave")
	@ResponseBody
	public String setMtrlBadSave(@RequestBody InfergodsMgtDto badDto) {
		return productWorkService.setMtrlBadSave(badDto);
	}
}
