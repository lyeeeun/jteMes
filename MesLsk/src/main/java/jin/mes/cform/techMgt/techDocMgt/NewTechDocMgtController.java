package jin.mes.cform.techMgt.techDocMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

@Controller
@RequestMapping("/cform/techMgt/techDocMgt")
public class NewTechDocMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(NewTechDocMgtController.class);

	@Resource
	protected NewTechDocMgtService newTechDocMgtService;
	
	@RequestMapping("/selectTechDocInfo")
	public ModelMap getTechDocInfo(@ModelAttribute("techDocMgtDto") NewTechDocMgtDto techDocMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(techDocMgtDto.getPage())));
		pageRequestVo.setRows(techDocMgtDto.getRows());

		setModelWithkendoList(model, newTechDocMgtService.selectTechDocInfo(techDocMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectTechDocGroup")
	public ResponseEntity<Object> selectTechDocGroup(@ModelAttribute("techDocMgtDto") NewTechDocMgtDto techDocMgtDto) {
		return new ResponseEntity<Object>(newTechDocMgtService.selectTechDocGroup(techDocMgtDto), HttpStatus.OK);
	}
	
	@RequestMapping("/selectTechDocRtlItem")
	public ModelMap selectTechDocRtlItem(@ModelAttribute("techDocMgtDto") NewTechDocMgtDto techDocMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(techDocMgtDto.getPage())));
		pageRequestVo.setRows(techDocMgtDto.getRows());

		setModelWithkendoList(model, newTechDocMgtService.selectTechDocRtlItem(techDocMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/saveTechDocRtlItem")
	@ResponseBody
	public void saveTechDocRtlItem(ModelMap model, @RequestBody NewTechDocMgtDto techDocMgtDto) {
		newTechDocMgtService.saveTechDocRtlItem(techDocMgtDto);
	}
	
	@RequestMapping("/saveTechDocInfo")
	@ResponseBody
	public void saveTechDocInfo(ModelMap model, @RequestBody NewTechDocMgtDto techDocMgtDto) {
		newTechDocMgtService.saveTechDocInfo(techDocMgtDto);
	}
}
 