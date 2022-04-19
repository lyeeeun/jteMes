package jin.mes.form.basMgt.operMgt.facilMgt;

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
@RequestMapping("/form/basMgt/operMgt/facilMgt")
public class FacilMgtController extends BaseController {

	@Autowired
	FacilMgtService eqmtMgtService;
	
	//설비상세 조회
		@RequestMapping("getEqmtMgtList")
		public ModelMap getEqmtMgtList(ModelMap model, @ModelAttribute("eqmtMgtDto") FacilMgtDto eqmtMgtDto) {
			PageRequestVo pageRequestVo = new PageRequestVo();
			pageRequestVo.setPage(getCurrentPage(Integer.toString(eqmtMgtDto.getPage())));
			pageRequestVo.setRows(eqmtMgtDto.getRows());
			try {
				setModelWithkendoList(model, eqmtMgtService.getEqmtMgtList(eqmtMgtDto,pageRequestVo));
			}catch(Exception ex) {
				throw new BusinessException("설비 상세 조회 에러  : " + ex.getMessage());
			}
			return model;
		}
		
		//설비상세 전체조회
		@RequestMapping("getEqmtMgtListAll")
		public ModelMap getEqmtMgtListAll(ModelMap model, @ModelAttribute("eqmtMgtDto") FacilMgtDto eqmtMgtDto) {
			try {
				model.addAttribute("result", eqmtMgtService.getEqmtMgtListAll(eqmtMgtDto));
			}catch(Exception ex) {
				throw new BusinessException("설비 상세 조회 에러(ALL) : " + ex.getMessage());
			}
			return model;
		}
		
		//설비상세 입력/수정
		@RequestMapping("/setEqmtMgtSave")
		@ResponseBody
		public String setEqmtMgtSave(@RequestBody FacilMgtDto eqmtMgtDto) {
			return eqmtMgtService.setEqmtMgtSave(eqmtMgtDto);
		}
		
		//설비상세 삭제
		@RequestMapping("/setEqmtMgtDelete")
		@ResponseBody
		public int setEqmtMgtDelete(ModelMap model, @RequestBody List<FacilMgtDto> eqmtMgtList) {
			return eqmtMgtService.setEqmtMgtDelete(eqmtMgtList);
		}
}