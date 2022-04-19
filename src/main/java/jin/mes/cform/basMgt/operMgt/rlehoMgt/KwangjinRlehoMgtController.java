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
public class KwangjinRlehoMgtController extends BaseController {

	@Autowired
	KwangjinRlehoMgtService kwangjinRlehoMgtService;
	
	@RequestMapping("getPlaceTree")
	public ResponseEntity<Object> getPlaceTree(@ModelAttribute("kwangjinRlehoMgtDto") KwangjinRlehoMgtDto kwangjinRlehoMgtDto) {
		return new ResponseEntity<Object>(kwangjinRlehoMgtService.getPlaceTree(kwangjinRlehoMgtDto), HttpStatus.OK);
	}
	
	@RequestMapping("getPlaceList")
	public ModelMap getPlaceList(ModelMap model, @ModelAttribute("kwangjinRlehoMgtDto") KwangjinRlehoMgtDto kwangjinRlehoMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinRlehoMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinRlehoMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, kwangjinRlehoMgtService.getPlaceList(kwangjinRlehoMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("위치 조회 에러"); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
		}
		return model;
	}
	
	@RequestMapping("/setPlaceSave")
	@ResponseBody
	public String setPlaceSave(@RequestBody KwangjinRlehoMgtDto kwangjinRlehoMgtDto) {
		return kwangjinRlehoMgtService.setPlaceSave(kwangjinRlehoMgtDto);
	}
	
	@RequestMapping("/setPlaceDelete")
	@ResponseBody
	public int setPlaceDelete(@RequestBody List<KwangjinRlehoMgtDto> placeList) {
		return kwangjinRlehoMgtService.setPlaceDelete(placeList);
	}
}
