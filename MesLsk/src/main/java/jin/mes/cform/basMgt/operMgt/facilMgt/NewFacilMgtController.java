package jin.mes.cform.basMgt.operMgt.facilMgt;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/operMgt/facilMgt")
public class NewFacilMgtController extends BaseController {

	@Autowired
	NewFacilMgtService newEqmtMgtService;
	
	//설비상세 조회
		@RequestMapping("getEqmtMgtList")
		public ModelMap getEqmtMgtList(ModelMap model, @ModelAttribute("newEqmtMgtDto") NewFacilMgtDto newEqmtMgtDto) {
			PageRequestVo pageRequestVo = new PageRequestVo();
			pageRequestVo.setPage(getCurrentPage(Integer.toString(newEqmtMgtDto.getPage())));
			pageRequestVo.setRows(newEqmtMgtDto.getRows());
			try {
				setModelWithkendoList(model, newEqmtMgtService.getEqmtMgtList(newEqmtMgtDto,pageRequestVo));
			}catch(Exception ex) {
				throw new BusinessException("설비 상세 조회 에러  : " + ex.getMessage());
			}
			return model;
		}
		
		//설비상세 전체조회
		@RequestMapping("getEqmtMgtListAll")
		public ModelMap getEqmtMgtListAll(ModelMap model, @ModelAttribute("newEqmtMgtDto") NewFacilMgtDto newEqmtMgtDto) {
			try {
				model.addAttribute("result", newEqmtMgtService.getEqmtMgtListAll(newEqmtMgtDto));
			}catch(Exception ex) {
				throw new BusinessException("설비 상세 조회 에러(ALL) : " + ex.getMessage());
			}
			return model;
		}
		
		//설비상세 입력/수정
		@RequestMapping("/setEqmtMgtSave")
		@ResponseBody
		public String setEqmtMgtSave(@RequestBody NewFacilMgtDto newEqmtMgtDto) {
			return newEqmtMgtService.setEqmtMgtSave(newEqmtMgtDto);
		}
		
		//설비상세 삭제
		@RequestMapping("/setEqmtMgtDelete")
		@ResponseBody
		public int setEqmtMgtDelete(ModelMap model, @RequestBody List<NewFacilMgtDto> eqmtMgtList) {
			return newEqmtMgtService.setEqmtMgtDelete(eqmtMgtList);
		}
}