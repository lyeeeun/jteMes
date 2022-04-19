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

import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/techMgt/techDocMgt")
public class ZinixTechDocMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(ZinixTechDocMgtController.class);

	@Resource
	protected ZinixTechDocMgtService zinixTechDocMgtService;
	
	@RequestMapping("/selectTechDocInfo")
	public ModelMap getTechDocInfo(@ModelAttribute("techDocMgtDto") ZinixTechDocMgtDto techDocMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(techDocMgtDto.getPage())));
		pageRequestVo.setRows(techDocMgtDto.getRows());

		setModelWithkendoList(model, zinixTechDocMgtService.selectTechDocInfo(techDocMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectTechDocGroup")
	public ResponseEntity<Object> selectTechDocGroup(@ModelAttribute("techDocMgtDto") ZinixTechDocMgtDto techDocMgtDto) {
		return new ResponseEntity<Object>(zinixTechDocMgtService.selectTechDocGroup(techDocMgtDto), HttpStatus.OK);
	}
	
	@RequestMapping("/selectTechDocRtlItem")
	public ModelMap selectTechDocRtlItem(@ModelAttribute("techDocMgtDto") ZinixTechDocMgtDto techDocMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(techDocMgtDto.getPage())));
		pageRequestVo.setRows(techDocMgtDto.getRows());

		setModelWithkendoList(model, zinixTechDocMgtService.selectTechDocRtlItem(techDocMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/saveTechDocRtlItem")
	@ResponseBody
	public void saveTechDocRtlItem(ModelMap model, @RequestBody ZinixTechDocMgtDto techDocMgtDto) {
		zinixTechDocMgtService.saveTechDocRtlItem(techDocMgtDto);
	}
	
	@RequestMapping("/saveTechDocInfo")
	@ResponseBody
	public void saveTechDocInfo(ModelMap model, @RequestBody ZinixTechDocMgtDto techDocMgtDto) {
		zinixTechDocMgtService.saveTechDocInfo(techDocMgtDto);
	}
}
 