package jin.mes.common.attach;

import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/attach")
public class AttachMgtController extends BaseController {

	@Autowired
	AttachMgtService attachMgtService;
	
	//첨부파일 조회
	@RequestMapping(value="/getAttachFiles")
	@ResponseBody
	public ModelMap getAttachFiles(ModelMap model, @ModelAttribute AttachMgtDto attachMgtDto) {
		try {
			model.addAttribute("result", attachMgtService.getAttachFiles(attachMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("첨부파일 조회 에러(Controller) : " + ex.getMessage());
		}
		return model;
	}
	
	//첨부파일 조회(Page)
	@RequestMapping("/getAttachFilesPage")
	public ModelMap getAttachFilesPage(@ModelAttribute("attachMgtDto") AttachMgtDto attachMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(attachMgtDto.getPage())));
		pageRequestVo.setRows(attachMgtDto.getRows());

		setModelWithkendoList(model, attachMgtService.getAttachFilesPage(attachMgtDto, pageRequestVo));

		return model;
	}
	
	//첨부파일 임시공간 저장
	@RequestMapping(value="/attachFilesTempSave" , produces="application/json" )
	@ResponseBody
	public HashMap<String, List> attachFilesTemp(ModelMap model,MultipartHttpServletRequest attachfiles) {
		return attachMgtService.attachFilesTempSave(attachfiles);
	}
	
	//첨부파일 임시공간 삭제
	@RequestMapping(value = "/attachFilesTempDelete" , produces = "application/json")
	@ResponseBody
	public HashMap<String, AttachMgtDto> attachFilesDelete(ModelMap model, @ModelAttribute AttachMgtDto attachMgtDto){
		return attachMgtService.attachFilesTempDelete(attachMgtDto);
	}
	
	//첨부파일 다운로드 체크
	@RequestMapping("/attachFilesDownloadCheck")
	public ModelMap attachFilesDownloadCheck(ModelMap model, @ModelAttribute AttachMgtDto attachMgtDto) {
		model.addAttribute("result", attachMgtService.attachFilesDownloadCheck(attachMgtDto));
		return model;
	}

	//첨부파일 다운로드
	@RequestMapping("/attachFilesDownload")
	public void attachFilesDownload(@ModelAttribute AttachMgtDto attachMgtDto,  HttpServletResponse response) {
		try {
			AttachMgtDto rtnAttachDto = attachMgtService.attachFilesDownload(attachMgtDto);
			response.setContentType("application/octet-stream");
			String orgname = new String(rtnAttachDto.getAttachOrigin().getBytes("UTF-8"), "iso-8859-1");
			response.setHeader("Content-Disposition", "attachment; filename=\""+orgname+"\"");
			OutputStream os = response.getOutputStream();
			FileInputStream fis = new FileInputStream(rtnAttachDto.getAttachPath()+rtnAttachDto.getAttachFilename());
			int n = 0;
			byte[] b = new byte[512];
			while((n = fis.read(b)) != -1 ) {
				
				os.write(b, 0, n);
			}
			fis.close();
			os.close();
		} catch (Exception e) {
			throw new BusinessException("첨부파일 다운로드 에러(Controller) : " + e.getMessage());
		}
	}
}