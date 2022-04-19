package jin.mes.cform.qualMgt.qualPec.finalQualMgt;


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

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/qualMgt/qualPec/finalQualMgt")
public class ZinixFinalQualMgtController extends BaseController {

	@Autowired
	ZinixFinalQualMgtService zinixFinalQualMgtService;
	
	//입고검사 조회
	@RequestMapping("/getPlcEqmtLogList")
	public ModelMap getPlcEqmtLogList(ModelMap model, @ModelAttribute("zinixFinalQualMgtDto") ZinixFinalQualMgtDto zinixFinalQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixFinalQualMgtDto.getPage())));
		pageRequestVo.setRows(zinixFinalQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, zinixFinalQualMgtService.getPlcEqmtLogList(zinixFinalQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("최종검사 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//plc 데이터 - 대기 > 완료 저장
	@RequestMapping("/setEqmtLogUpdate")
	@ResponseBody
	public String setEqmtLogUpdate(@RequestBody ZinixFinalQualMgtDto zinixFinalQualMgtDto) {
		return zinixFinalQualMgtService.setEqmtLogUpdate(zinixFinalQualMgtDto);
	}
	
	//최종검사 불합격 조치이력 저장
	@RequestMapping("/setMeasureChange")
	@ResponseBody
	public ResponseEntity<Object> setMeasureChange(@RequestBody List<ZinixFinalQualMgtDto> zinixFinalQualMgtList) {
		return new ResponseEntity<Object>(zinixFinalQualMgtService.setMeasureChange(zinixFinalQualMgtList), HttpStatus.OK);
	}
}
