package jin.mes.form.basMgt.belngMgt.divInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.basMgt.authMgt.authInfo.AuthInfoModel;
import jin.mes.form.basMgt.authMgt.authInfo.AuthInfoServiceImpl;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import kr.co.itcall.jte.spring.user.model.DeptInfoVo;

@Controller
@RequestMapping("/form/basMgt/belngMgt/divInfo")
public class DivInfoController extends BaseController {

	@Autowired
	DivInfoService divInfoService;
	
	@RequestMapping("/getDeptList")
	public ModelMap getDeptList(ModelMap model, @ModelAttribute("PageVO") KendoPageVO pageVO) {
		try {
//			final JPQLQuery<Account> query;
			setModelWithkendoList(model,divInfoService.getDeptList(pageVO));
		}catch(Exception ex) {
			//throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.format.invalid", new Object[] {filename, uploadExtAllowedPattern})); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
			throw new BusinessException("조회에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setDeptSave")
	public ModelMap setDeptSave(ModelMap model, @RequestBody DeptInfoVo deptInfoVo) {
		try {
			if(deptInfoVo.isUse()) {
				deptInfoVo.setUse(true);
			}
			
			divInfoService.setDeptSave(deptInfoVo);
		}catch(Exception ex) {
			throw new BusinessException("저장 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setDeptDelete")
	public ModelMap setDeptDelete(ModelMap model, @RequestBody List<DeptInfoVo> deptInfoList) {
		try {
			divInfoService.setDeptDelete(deptInfoList);
		}catch(Exception ex) {
			throw new BusinessException("삭제 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setDeptUseUpdate")
	public ModelMap setDeptUseUpdate(ModelMap model, @RequestBody DeptInfoVo deptInfoVo) {
		try {
			divInfoService.setDeptUseUpdate(deptInfoVo);
		}catch(Exception ex) {
			throw new BusinessException("사용유무 저장 에러입니다 . : "+ex.getMessage());
		}
		return model;
	}

}
