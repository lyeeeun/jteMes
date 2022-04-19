package jin.mes.cform.mfgMgt.productWork;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.ZinixInfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/productWork")
public class ZinixProductWorkController extends BaseController {
	@Autowired
	ZinixProductWorkService productWorkService;
	
	@RequestMapping("/getProductWorkLotList")
	public ModelMap getProductWorkLotList(ModelMap model, @ModelAttribute("lotInfoDto") ZinixLotInfoDto lotInfoDto) {
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
	public ModelMap getProdWorkAsgnList(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") ZinixWrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", productWorkService.getProdWorkAsgnList(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkAsgnDetail")
	public ModelMap getProdWorkAsgnDetail(ModelMap model, @ModelAttribute("asgnDto") ZinixWrkinTeamMgtDto asgnDto) {
		try {
			model.addAttribute("rows", productWorkService.getProdWorkAsgnDetail(asgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 상세 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkAsgnSave")
	@ResponseBody
	public String setProdWorkAsgnSave(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkAsgnSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkAsgnDelete")
	@ResponseBody
	public String setProdWorkAsgnDelete(ModelMap model, @RequestBody List<ZinixWrkinTeamMgtDto> mtrlOrderList) {
		return productWorkService.setProdWorkAsgnDelete(mtrlOrderList);
	}
	
	@RequestMapping("/getProdWorkRoutSheetList")
	public ModelMap getProdWorkRoutSheetList(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") ZinixWrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", productWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("라우팅시트  조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkRoutSheetSave")
	@ResponseBody
	public String setProdWorkRoutSheetSave(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkRoutSheetSave(asgnDto);
	}
	
//	@RequestMapping("/setProdWorkAsgnDelete")
//	@ResponseBody
//	public int setProdWorkAsgnDelete(ModelMap model, @RequestBody List<ZinixWrkinTeamMgtDto> mtrlOrderList) {
//		return productWorkService.setProdWorkAsgnDelete(mtrlOrderList);
//	}
	@RequestMapping("/getBomDetailInfo")
	public ModelMap getBomDetailInfo(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") ZinixWrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", productWorkService.getBomDetailInfo(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("사용될 자재 조회에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkStart")
	@ResponseBody
	public String setProdWorkStart(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkStart(asgnDto);
	}
	
	@RequestMapping("/setProdWorkCount")
	@ResponseBody
	public String setProdWorkCount(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkCount(asgnDto);
	}
	
	@RequestMapping("/setProdWorkEnd")
	@ResponseBody
	public String setProdWorkEnd(@RequestBody ZinixWrkinTeamMgtDto asgnDto) {
		return productWorkService.setProdWorkEnd(asgnDto);
	}
	
	@RequestMapping("/getBomMtrlList")
	public ModelMap getBomMtrlList(ModelMap model, @ModelAttribute("zinixBomMtrlDto") ZinixBomMtrlDto zinixBomMtrlDto) {
			model.addAttribute("rows", productWorkService.getBomMtrlList(zinixBomMtrlDto));
		return model;
	}
	
	@RequestMapping("/getBomMtrlDetail")
	public ModelMap getBomMtrlDetail(ModelMap model, @ModelAttribute("zinixBomMtrlDto") ZinixBomMtrlDto zinixBomMtrlDto) {
			model.addAttribute("rows", productWorkService.getBomMtrlDetail(zinixBomMtrlDto));
		return model;
	}
	
	
	@RequestMapping("/getMtrlBadInfo")
	public ModelMap getMtrlBadInfo(ModelMap model, @ModelAttribute("mtrlBadDto") ZinixInfergodsMgtDto mtrlBadDto) {
			model.addAttribute("rows", productWorkService.getMtrlBadInfo(mtrlBadDto));
		return model;
	}
	
	@RequestMapping("/setMtrlBadSave")
	@ResponseBody
	public String setMtrlBadSave(@RequestBody ZinixInfergodsMgtDto badDto) {
		return productWorkService.setMtrlBadSave(badDto);
	}
}
