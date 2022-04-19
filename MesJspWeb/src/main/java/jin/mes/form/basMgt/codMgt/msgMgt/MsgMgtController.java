package jin.mes.form.basMgt.codMgt.msgMgt;

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

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/basMgt/codMgt/msgMgt")
public class MsgMgtController extends BaseController {
	@Autowired
	MsgMgtServiceImpl msgMgtService;
	
	@RequestMapping("/getMsgList")
	public ModelMap getMsgList(ModelMap model, @ModelAttribute("PageVO") KendoPageVO pageVO) {
		try {
			setModelWithkendoList(model, msgMgtService.getMsgList(pageVO));
		}catch(Exception ex) {
			throw new BusinessException("조회 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/saveMsg")
	public ModelMap saveMsg(ModelMap model, @ModelAttribute("msgViewModel") MsgViewModel msgViewModel) {
		try {
			msgMgtService.saveMsg(msgViewModel);
		}catch(Exception ex) {
			throw new BusinessException("저장 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/updateMsg")
	@ResponseBody
	public int updateMsg(ModelMap model, @RequestBody List<MsgViewModel> msgModel) {
		int resultInt = -1;
		try {
			resultInt = msgMgtService.updateMsg(msgModel);
		}catch(Exception ex) {
			throw new BusinessException("저장 에러입니다. : "+ex.getMessage());
		}
		return resultInt;
	}
	
	@RequestMapping("/deleteMsg")
	@ResponseBody
	public int deleteMsg(ModelMap model, @RequestBody List<MsgMgtDto> msgMgtDto) {
		int resultInt = 0;
		try {
			resultInt = msgMgtService.deleteMsg(msgMgtDto);
		}catch(Exception ex) {
			resultInt = -1;
			throw new BusinessException("삭제 에러입니다. : "+ex.getMessage());
		}
		return resultInt;
	}
	
	@RequestMapping("getMsgMergeList")
	public ModelMap getMsgMergeList(ModelMap model, @ModelAttribute("msgMgtDto") MsgMgtDto msgMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(msgMgtDto.getPage())));
		pageRequestVo.setRows(msgMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, msgMgtService.getMsgMergeList(msgMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("다국어 조회 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getMsgMergeOne")
	public ResponseEntity<Object> getMenuTree(@ModelAttribute("msgMgtDto") MsgMgtDto msgMgtDto) {
		return new ResponseEntity<Object>(msgMgtService.getMsgMergeOne(msgMgtDto), HttpStatus.OK);
	}
}
