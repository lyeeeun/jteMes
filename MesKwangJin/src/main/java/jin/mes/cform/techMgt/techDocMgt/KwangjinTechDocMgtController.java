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
public class KwangjinTechDocMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(KwangjinTechDocMgtController.class);

	@Resource
	protected KwangjinTechDocMgtService kwangjinTechDocMgtService;
	
	@RequestMapping("/selectTechDocInfo")
	public ModelMap getTechDocInfo(@ModelAttribute("kwangjinTechDocMgtDto") KwangjinTechDocMgtDto kwangjinTechDocMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinTechDocMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinTechDocMgtDto.getRows());

		setModelWithkendoList(model, kwangjinTechDocMgtService.selectTechDocInfo(kwangjinTechDocMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectTechDocGroup")
	public ResponseEntity<Object> selectTechDocGroup(@ModelAttribute("kwangjinTechDocMgtDto") KwangjinTechDocMgtDto kwangjinTechDocMgtDto) {
		return new ResponseEntity<Object>(kwangjinTechDocMgtService.selectTechDocGroup(kwangjinTechDocMgtDto), HttpStatus.OK);
	}
	
	@RequestMapping("/selectTechDocRtlItem")
	public ModelMap selectTechDocRtlItem(@ModelAttribute("kwangjinTechDocMgtDto") KwangjinTechDocMgtDto kwangjinTechDocMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinTechDocMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinTechDocMgtDto.getRows());

		setModelWithkendoList(model, kwangjinTechDocMgtService.selectTechDocRtlItem(kwangjinTechDocMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/saveTechDocRtlItem")
	@ResponseBody
	public void saveTechDocRtlItem(ModelMap model, @RequestBody KwangjinTechDocMgtDto kwangjinTechDocMgtDto) {
		kwangjinTechDocMgtService.saveTechDocRtlItem(kwangjinTechDocMgtDto);
	}
	
	@RequestMapping("/saveTechDocInfo")
	@ResponseBody
	public void saveTechDocInfo(ModelMap model, @RequestBody KwangjinTechDocMgtDto kwangjinTechDocMgtDto) {
		kwangjinTechDocMgtService.saveTechDocInfo(kwangjinTechDocMgtDto);
	}
}
 