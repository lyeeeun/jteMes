package jin.mes.cform.basMgt.operMgt.facilMgt;

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
@RequestMapping("/cform/basMgt/operMgt/facilMgt")
public class KwangjinFacilMgtController extends BaseController {

	@Autowired
	KwangjinFacilMgtService kwangjinFacilMgtService;
	
	//설비상세 조회
		@RequestMapping("getEqmtMgtList")
		public ModelMap getEqmtMgtList(ModelMap model, @ModelAttribute("kwangjinFacilMgtDto") KwangjinFacilMgtDto kwangjinFacilMgtDto) {
			PageRequestVo pageRequestVo = new PageRequestVo();
			pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinFacilMgtDto.getPage())));
			pageRequestVo.setRows(kwangjinFacilMgtDto.getRows());
			try {
				setModelWithkendoList(model, kwangjinFacilMgtService.getEqmtMgtList(kwangjinFacilMgtDto,pageRequestVo));
			}catch(Exception ex) {
				throw new BusinessException("설비 상세 조회 에러  : " + ex.getMessage());
			}
			return model;
		}
		
		//설비상세 전체조회
		@RequestMapping("getEqmtMgtListAll")
		public ModelMap getEqmtMgtListAll(ModelMap model, @ModelAttribute("kwangjinFacilMgtDto") KwangjinFacilMgtDto kwangjinFacilMgtDto) {
			try {
				model.addAttribute("result", kwangjinFacilMgtService.getEqmtMgtListAll(kwangjinFacilMgtDto));
			}catch(Exception ex) {
				throw new BusinessException("설비 상세 조회 에러(ALL) : " + ex.getMessage());
			}
			return model;
		}
		
		//설비상세 입력/수정
		@RequestMapping("/setEqmtMgtSave")
		@ResponseBody
		public String setEqmtMgtSave(@RequestBody KwangjinFacilMgtDto kwangjinFacilMgtDto) {
			return kwangjinFacilMgtService.setEqmtMgtSave(kwangjinFacilMgtDto);
		}
		
		//설비상세 삭제
		@RequestMapping("/setEqmtMgtDelete")
		@ResponseBody
		public int setEqmtMgtDelete(ModelMap model, @RequestBody List<KwangjinFacilMgtDto> eqmtMgtList) {
			return kwangjinFacilMgtService.setEqmtMgtDelete(eqmtMgtList);
		}
}