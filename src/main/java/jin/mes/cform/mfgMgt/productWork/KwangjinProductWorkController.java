package jin.mes.cform.mfgMgt.productWork;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.KwangjinLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.KwangjinInfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/productWork")
public class KwangjinProductWorkController extends BaseController {
	@Autowired
	KwangjinProductWorkService kwangjinProductWorkService;
	
	@RequestMapping("/getProductWorkLotList")
	public ModelMap getProductWorkLotList(ModelMap model, @ModelAttribute("kwangjinLotInfoDto") KwangjinLotInfoDto kwangjinLotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinLotInfoDto.getPage())));
		pageRequestVo.setRows(kwangjinLotInfoDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(kwangjinLotInfoDto.getPagingYN());
		try {
			
			setModelWithkendoList(model, kwangjinProductWorkService.getProductWorkLotList(kwangjinLotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 - LOT 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkAsgnList")
	public ModelMap getProdWorkAsgnList(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") WrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", kwangjinProductWorkService.getProdWorkAsgnList(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getProdWorkAsgnDetail")
	public ModelMap getProdWorkAsgnDetail(ModelMap model, @ModelAttribute("asgnDto") WrkinTeamMgtDto asgnDto) {
		try {
			model.addAttribute("rows", kwangjinProductWorkService.getProdWorkAsgnDetail(asgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 상세 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkAsgnSave")
	@ResponseBody
	public String setProdWorkAsgnSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return kwangjinProductWorkService.setProdWorkAsgnSave(asgnDto);
	}
	
	@RequestMapping("/setProdWorkAsgnDelete")
	@ResponseBody
	public String setProdWorkAsgnDelete(ModelMap model, @RequestBody List<WrkinTeamMgtDto> mtrlOrderList) {
		return kwangjinProductWorkService.setProdWorkAsgnDelete(mtrlOrderList);
	}
	
	@RequestMapping("/getProdWorkRoutSheetList")
	public ModelMap getProdWorkRoutSheetList(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") WrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", kwangjinProductWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("라우팅시트  조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkRoutSheetSave")
	@ResponseBody
	public String setProdWorkRoutSheetSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return kwangjinProductWorkService.setProdWorkRoutSheetSave(asgnDto);
	}
	
	@RequestMapping("/getProdWorkEqmtChangeList")
	public ModelMap getProdWorkEqmtChangeList(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") WrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", kwangjinProductWorkService.getProdWorkEqmtChangeList(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("설비 변경 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getBomDetailInfo")
	public ModelMap getBomDetailInfo(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") WrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", kwangjinProductWorkService.getBomDetailInfo(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("사용될 자재 조회에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setProdWorkStart")
	@ResponseBody
	public String setProdWorkStart(@RequestBody WrkinTeamMgtDto asgnDto) {
		return kwangjinProductWorkService.setProdWorkStart(asgnDto);
	}
	
	@RequestMapping("/setProdWorkCount")
	@ResponseBody
	public String setProdWorkCount(@RequestBody WrkinTeamMgtDto asgnDto) {
		return kwangjinProductWorkService.setProdWorkCount(asgnDto);
	}
	
	@RequestMapping("/setProdWorkEnd")
	@ResponseBody
	public String setProdWorkEnd(@RequestBody WrkinTeamMgtDto asgnDto) {
		return kwangjinProductWorkService.setProdWorkEnd(asgnDto);
	}
	
	@RequestMapping("/setProdWorkStop")
	@ResponseBody
	public String setProdWorkStop(@RequestBody WrkinTeamMgtDto asgnDto) {
		return kwangjinProductWorkService.setProdWorkStop(asgnDto);
	}
	
	@RequestMapping("/getBomMtrlList")
	public ModelMap getBomMtrlList(ModelMap model, @ModelAttribute("kwangjinBomMtrlDto") KwangjinBomMtrlDto kwangjinBomMtrlDto) {
			model.addAttribute("rows", kwangjinProductWorkService.getBomMtrlList(kwangjinBomMtrlDto));
		return model;
	}
	
	@RequestMapping("/getBomMtrlDetail")
	public ModelMap getBomMtrlDetail(ModelMap model, @ModelAttribute("kwangjinBomMtrlDto") KwangjinBomMtrlDto kwangjinBomMtrlDto) {
			model.addAttribute("rows", kwangjinProductWorkService.getBomMtrlDetail(kwangjinBomMtrlDto));
		return model;
	}
	
	
	@RequestMapping("/getMtrlBadInfo")
	public ModelMap getMtrlBadInfo(ModelMap model, @ModelAttribute("mtrlBadDto") KwangjinInfergodsMgtDto mtrlBadDto) {
			model.addAttribute("rows", kwangjinProductWorkService.getMtrlBadInfo(mtrlBadDto));
		return model;
	}
	
	@RequestMapping("/setMtrlBadSave")
	@ResponseBody
	public String setMtrlBadSave(@RequestBody KwangjinInfergodsMgtDto badDto) {
		return kwangjinProductWorkService.setMtrlBadSave(badDto);
	}
}
