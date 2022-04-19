package jin.mes.cform.basMgt.operMgt.rlehoMgt;

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
@RequestMapping("/cform/basMgt/operMgt/rlehoMgt")
public class NewRlehoMgtController extends BaseController {

	@Autowired
	NewRlehoMgtService newPlaceService;
	
	@RequestMapping("getPlaceTree")
	public ResponseEntity<Object> getPlaceTree(@ModelAttribute("placeDto") NewRlehoMgtDto placeDto) {
		return new ResponseEntity<Object>(newPlaceService.getPlaceTree(placeDto), HttpStatus.OK);
	}
	
	@RequestMapping("getPlaceList")
	public ModelMap getPlaceList(ModelMap model, @ModelAttribute("placeDto") NewRlehoMgtDto placeDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(placeDto.getPage())));
		pageRequestVo.setRows(placeDto.getRows());
		
		try {
			setModelWithkendoList(model, newPlaceService.getPlaceList(placeDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("위치 조회 에러"); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
		}
		return model;
	}
	
	@RequestMapping("/setPlaceSave")
	@ResponseBody
	public int setPlaceSave(@RequestBody NewRlehoMgtDto placeDto) {
		return newPlaceService.setPlaceSave(placeDto);
	}
	
	@RequestMapping("/setPlaceDelete")
	@ResponseBody
	public int setPlaceDelete(@RequestBody List<NewRlehoMgtDto> placeList) {
		return newPlaceService.setPlaceDelete(placeList);
	}
}
