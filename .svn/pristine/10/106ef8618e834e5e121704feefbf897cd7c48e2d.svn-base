package jin.mes.form.techMgt.techDocMgt;

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

import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/techMgt/techDocMgt")
public class TechDocMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(TechDocMgtController.class);

	@Resource
	protected TechDocMgtService techDocMgtService;
	
	@RequestMapping("/selectTechDocInfo")
	public ModelMap getTechDocInfo(@ModelAttribute("techDocMgtDto") TechDocMgtDto techDocMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(techDocMgtDto.getPage())));
		pageRequestVo.setRows(techDocMgtDto.getRows());

		setModelWithkendoList(model, techDocMgtService.selectTechDocInfo(techDocMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectTechDocGroup")
	public ResponseEntity<Object> selectTechDocGroup(@ModelAttribute("techDocMgtDto") TechDocMgtDto techDocMgtDto) {
		return new ResponseEntity<Object>(techDocMgtService.selectTechDocGroup(techDocMgtDto), HttpStatus.OK);
	}
	
	@RequestMapping("/selectTechDocRtlItem")
	public ModelMap selectTechDocRtlItem(@ModelAttribute("techDocMgtDto") TechDocMgtDto techDocMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(techDocMgtDto.getPage())));
		pageRequestVo.setRows(techDocMgtDto.getRows());

		setModelWithkendoList(model, techDocMgtService.selectTechDocRtlItem(techDocMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/saveTechDocRtlItem")
	@ResponseBody
	public void saveTechDocRtlItem(ModelMap model, @RequestBody TechDocMgtDto techDocMgtDto) {
		techDocMgtService.saveTechDocRtlItem(techDocMgtDto);
	}
	
	@RequestMapping("/saveTechDocInfo")
	@ResponseBody
	public void saveTechDocInfo(ModelMap model, @RequestBody TechDocMgtDto techDocMgtDto) {
		techDocMgtService.saveTechDocInfo(techDocMgtDto);
	}
}
 