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
public class KwangjinBomMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(KwangjinBomMgtController.class);

	@Resource
	protected KwangjinBomMgtService kwangjinBomMgtService;

	@RequestMapping("/getBomList")
	public ModelMap getBomList(@ModelAttribute("kwangjinBomMgtDto") KwangjinBomMgtDto kwangjinBomMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", kwangjinBomMgtService.getBomList(kwangjinBomMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러  : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getBomTree")
	public ResponseEntity<Object> getBomTree(@ModelAttribute("kwangjinBomMgtDto") KwangjinBomMgtDto kwangjinBomMgtDto) {
		return new ResponseEntity<Object>(kwangjinBomMgtService.getBomTree(kwangjinBomMgtDto), HttpStatus.OK);
	}
	
	@RequestMapping("/setBom")
	@ResponseBody
	public void setBom(@RequestBody KwangjinBomMgtDto kwangjinBomMgtDto) {
		kwangjinBomMgtService.setBom(kwangjinBomMgtDto); 
	}
	
	@RequestMapping("/updateBom")
	@ResponseBody
	public void updateBom(@RequestBody KwangjinBomMgtDto kwangjinBomMgtDto) {
		kwangjinBomMgtService.updateBom(kwangjinBomMgtDto); 
	}
	
	@RequestMapping("/deleteBom")
	@ResponseBody
	public void deleteBom(@RequestBody KwangjinBomMgtDto kwangjinBomMgtDto) {
		kwangjinBomMgtService.deleteBom(kwangjinBomMgtDto); 
	}
}
