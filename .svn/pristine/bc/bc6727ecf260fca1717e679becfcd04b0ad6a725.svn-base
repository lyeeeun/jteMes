package jin.mes.form.qualMgt.qualPec.finalQualMgt;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/qualMgt/qualPec/finalQualMgt")
public class FinalQualMgtController extends BaseController {

	@Autowired
	FinalQualMgtService finalQualMgtService;
	
	//입고검사 조회
	@RequestMapping("/getPlcEqmtLogList")
	public ModelMap getPlcEqmtLogList(ModelMap model, @ModelAttribute("finalQualMgtDto") FinalQualMgtDto finalQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(finalQualMgtDto.getPage())));
		pageRequestVo.setRows(finalQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, finalQualMgtService.getPlcEqmtLogList(finalQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("최종검사 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//plc 데이터 - 대기 > 완료 저장
	@RequestMapping("/setEqmtLogUpdate")
	@ResponseBody
	public String setEqmtLogUpdate(@RequestBody FinalQualMgtDto finalQualMgtDto) {
		return finalQualMgtService.setEqmtLogUpdate(finalQualMgtDto);
	}
	
	//최종검사 불합격 조치이력 저장
	@RequestMapping("/setMeasureChange")
	@ResponseBody
	public ResponseEntity<Object> setMeasureChange(@RequestBody List<FinalQualMgtDto> finalQualMgtList) {
		return new ResponseEntity<Object>(finalQualMgtService.setMeasureChange(finalQualMgtList), HttpStatus.OK);
	}
}
