package jin.mes.form.basMgt.operMgt.rlehoMgt;

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
@RequestMapping("/form/basMgt/operMgt/rlehoMgt")
public class RlehoMgtController extends BaseController {

	@Autowired
	RlehoMgtService placeService;
	
	@RequestMapping("getPlaceTree")
	public ResponseEntity<Object> getPlaceTree(@ModelAttribute("placeDto") RlehoMgtDto placeDto) {
		return new ResponseEntity<Object>(placeService.getPlaceTree(placeDto), HttpStatus.OK);
	}
	
	@RequestMapping("getPlaceList")
	public ModelMap getPlaceList(ModelMap model, @ModelAttribute("placeDto") RlehoMgtDto placeDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(placeDto.getPage())));
		pageRequestVo.setRows(placeDto.getRows());
		
		try {
			setModelWithkendoList(model, placeService.getPlaceList(placeDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("위치 조회 에러"); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
		}
		return model;
	}
	
	@RequestMapping("/setPlaceSave")
	@ResponseBody
	public int setPlaceSave(@RequestBody RlehoMgtDto placeDto) {
		return placeService.setPlaceSave(placeDto);
	}
	
	@RequestMapping("/setPlaceDelete")
	@ResponseBody
	public int setPlaceDelete(@RequestBody List<RlehoMgtDto> placeList) {
		return placeService.setPlaceDelete(placeList);
	}
}
