package jin.mes.form.basMgt.belngMgt.posInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.basMgt.belngMgt.posInfo.PosInfoService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import kr.co.itcall.jte.spring.user.model.PositionInfoVo;

@Controller
@RequestMapping("/form/basMgt/belngMgt/posInfo")
public class PosInfoController extends BaseController {

	@Autowired
	PosInfoService posInfoService;
	
	@RequestMapping("/getPositionList")
	public ModelMap getPositionList(ModelMap model, @ModelAttribute("PageVO") KendoPageVO pageVO) {
		try {
//			final JPQLQuery<Account> query;
			setModelWithkendoList(model,posInfoService.getPositionList(pageVO));
		}catch(Exception ex) {
			//throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.format.invalid", new Object[] {filename, uploadExtAllowedPattern})); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
			throw new BusinessException("조회에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setPositionSave")
	public ModelMap setPositionSave(ModelMap model, @RequestBody PositionInfoVo positionInfoVo) {
		try {
			if(positionInfoVo.isUse()) {
				positionInfoVo.setUse(true);
			}
			
			posInfoService.setPositionSave(positionInfoVo);
		}catch(Exception ex) {
			throw new BusinessException("저장 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setPositionDelete")
	public ModelMap setPositionDelete(ModelMap model, @RequestBody List<PositionInfoVo> positionInfoVo) {
		try {
			posInfoService.setPositionDelete(positionInfoVo);
		}catch(Exception ex) {
			throw new BusinessException("삭제 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setPositionUseUpdate")
	public ModelMap setPositionUseUpdate(ModelMap model, @RequestBody PositionInfoVo positionInfoVo) {
		try {
			posInfoService.setPositionUseUpdate(positionInfoVo);
		}catch(Exception ex) {
			throw new BusinessException("사용유무 저장 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
}
