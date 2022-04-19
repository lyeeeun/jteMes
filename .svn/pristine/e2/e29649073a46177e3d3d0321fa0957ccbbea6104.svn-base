package jin.mes.cform.basMgt.bom.bomMgt;

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
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/bom/bomMgt")
public class ZinixBomMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ZinixBomMgtController.class);

	@Resource
	protected ZinixBomMgtService zinixBomMgtService;

	@RequestMapping("/getBomList")
	public ModelMap getBomList(@ModelAttribute("bomMgtDto") ZinixBomMgtDto bomMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", zinixBomMgtService.getBomList(bomMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러  : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getBomTree")
	public ResponseEntity<Object> getBomTree(@ModelAttribute("bomMgtDto") ZinixBomMgtDto bomMgtDto) {
		return new ResponseEntity<Object>(zinixBomMgtService.getBomTree(bomMgtDto), HttpStatus.OK);
	}
	
	@RequestMapping("/setBom")
	@ResponseBody
	public void setBom(@RequestBody ZinixBomMgtDto bomMgtDto) {
		zinixBomMgtService.setBom(bomMgtDto); 
	}
	
	@RequestMapping("/updateBom")
	@ResponseBody
	public void updateBom(@RequestBody ZinixBomMgtDto bomMgtDto) {
		zinixBomMgtService.updateBom(bomMgtDto); 
	}
	
	@RequestMapping("/deleteBom")
	@ResponseBody
	public void deleteBom(@RequestBody ZinixBomMgtDto bomMgtDto) {
		zinixBomMgtService.deleteBom(bomMgtDto); 
	}
}
