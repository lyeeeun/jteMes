package jin.mes.form.basMgt.altBoard;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;
import kr.co.itcall.jte.spring.user.JteUserUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/form/basMgt/altBoard")
@Slf4j
public class AltBoardController extends BaseController {
	
	@Resource(name="altBoardService")
	protected AltBoardService altBoardService;
	
	@PreAuthorize("hasAuthority('auth.operMgt.altBoard.bas')")
	@RequestMapping("/getPopBoardList")
	public ModelMap getPopBoardList(SecurityContextHolderAwareRequestWrapper requestWrapper, @ModelAttribute("altBoardDto") AltBoardDto altBoardDto, ModelMap model){
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(altBoardDto.getPage())));
		pageRequestVo.setRows(altBoardDto.getRows());
		altBoardDto.setOperAuth(false); // 게시글에 대한 관리권한이 있는 경우에도 로그인 시에는 허용된 알림만 가져온다.
		setLoginUserInfo(altBoardDto);
		setModelWithkendoList(model, altBoardService.getBoardList(altBoardDto, pageRequestVo));
		return model;
	}

	@PreAuthorize("hasAuthority('auth.operMgt.altBoard.bas')")
	@RequestMapping("/getBoardList")
	public ModelMap getBoardList(SecurityContextHolderAwareRequestWrapper requestWrapper, @ModelAttribute("altBoardDto") AltBoardDto altBoardDto, ModelMap model){
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(altBoardDto.getPage())));
		pageRequestVo.setRows(altBoardDto.getRows());
		altBoardDto.setOperAuth(JteUtils.hasAuth("auth.operMgt.altBoard.cud"));

		setLoginUserInfo(altBoardDto);

		setModelWithkendoList(model, altBoardService.getBoardList(altBoardDto, pageRequestVo));

		return model;
	}

	@PreAuthorize("hasAuthority('auth.operMgt.altBoard.bas')") // @PreAuthorize("isAuthenticated()")
	@RequestMapping("/getBoardInfo")
	public ModelMap getBoardInfo(@ModelAttribute AltBoardDto altBoardDto, ModelMap model){

		setLoginUserInfo(altBoardDto);

		model.addAttribute("result", altBoardService.getBoard(altBoardDto.getBdSeq()));
		return model;
	}
	

	@PreAuthorize(("hasAuthority('auth.operMgt.altBoard.cud')"))
	@RequestMapping("/addBoard")
	public ModelMap addBoard(@ModelAttribute AltBoardDto altBoardDto, MultipartHttpServletRequest multipartHttpServletRequest, BindingResult bindingResult, ModelMap model) throws IllegalStateException, IOException{
		int result = 0;
		log.debug("boardInfo = 【{}】", altBoardDto);
		result = altBoardService.addBoard(altBoardDto, multipartHttpServletRequest);
		model.addAttribute("result", result);
		return model;
	}
	
	@PreAuthorize(("hasAuthority('auth.operMgt.altBoard.cud')"))
	@RequestMapping("/setBoard")
	public ModelMap setBoard(@ModelAttribute AltBoardDto altBoardDto, MultipartHttpServletRequest multipartHttpServletRequest, BindingResult bindingResult, ModelMap model) throws IllegalStateException, IOException{
		int result = 0;
		model.addAttribute("bdSeq", altBoardDto.getBdSeq());
		// altBoardDto.setBdUseYn("Y"); // 게시 중지된 게시물을 수정하면 자동으로 다시 게시됩니다.
		altBoardDto = setEditorInfo(altBoardDto);
		result = altBoardService.setBoard(altBoardDto, multipartHttpServletRequest);
		model.addAttribute("result", result);
		return model;
	}

	@PreAuthorize(("hasAuthority('auth.operMgt.altBoard.cud')"))
	@RequestMapping("/resetBoard")
	public ModelMap resetBoard(@ModelAttribute AltBoardDto altBoardDto, MultipartHttpServletRequest multipartHttpServletRequest, BindingResult bindingResult, ModelMap model){
		int result = 0;
		model.addAttribute("bdSeq", altBoardDto.getBdSeq());
		result = altBoardService.resetBoard(altBoardDto, multipartHttpServletRequest);
		model.addAttribute("result", result);
		return model;
	}

	@PreAuthorize(("hasAuthority('auth.operMgt.altBoard.cud')"))
	@RequestMapping("/removeBoard")
	public ModelMap removeBoard(@RequestParam("bdSeq") long bdSeq, ModelMap model) throws IllegalStateException, IOException{
		AltBoardDto altBoardDto = altBoardService.getBoard(bdSeq);
		if(altBoardDto!=null) {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			UserSessionInfoVo user = (UserSessionInfoVo)authentication.getPrincipal();
			if(altBoardDto.getFirstCretTrtrId().equals(user.getUsername())) {
				altBoardService.removeBoard(bdSeq);
				model.addAttribute("result", bdSeq+"번 게시글이 삭제되었습니다.");
			} else {
				altBoardDto = new AltBoardDto();
				altBoardDto.setBdSeq(bdSeq);
				altBoardDto.setBdUseYn("N");
				// altBoardDto = setEditorInfo(altBoardDto);
				altBoardService.setBoard(altBoardDto);
				model.addAttribute("result", bdSeq+"번 게시글이 게시중지 되었습니다.\n(생성자만 삭제할 수 있습니다.)");
			}
		}else {
			model.addAttribute("result", bdSeq+"번 게시글이 존재하지 않습니다.\n확인 후 다시 시도해 주십시오.");
		}
		model.addAttribute("bdSeq", bdSeq);
		return model;
	}

	@RequestMapping("/file/download/check")
	public ModelMap download(@RequestParam("bdSeq") long bdSeq, @RequestParam("filePath") String filePath, ModelMap model) {
		model.addAttribute("bdSeq", bdSeq);
		model.addAttribute("filePath", filePath);
		model.addAttribute("result", altBoardService.fileDownloadCheck(bdSeq, filePath, model));
		return model;
	}
		
	@RequestMapping("/file/download")
	public ModelAndView download(@RequestParam("bdSeq") long bdSeq, @RequestParam("fileNm") String fileNm, @RequestParam("filePath") String filePath) {
		ModelAndView modelAndView = new ModelAndView();
		return altBoardService.fileDownload(bdSeq, filePath, modelAndView);
	}

	private AltBoardDto setEditorInfo(AltBoardDto altBoardDto) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserSessionInfoVo user = (UserSessionInfoVo)authentication.getPrincipal();
		altBoardDto.setLastChgTrtrId(user.getUsername());
		altBoardDto.setBdEditorNm(user.getUserInfo().getUserNm());
		if(altBoardDto.getEfctFnsDt()==null) {
			/** 게시 만료일이 셋팅되지 않았으면 수정할 때마다 게시기간이 기본 1년으로 늘어나게 한다. **/
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			cal.add(Calendar.YEAR, 1);
			altBoardDto.setEfctFnsDt(cal.getTime());
		}
		return altBoardDto;
	}

	/**
	 * 로그인 한 사용자의 조건으로 기본조회정보를 셋팅한다.(사용자ID, 소속권한그룹)
	 * @param altBoardDto
	 */
	private void setLoginUserInfo(AltBoardDto altBoardDto) {
		try {
			UserSessionInfoVo user = (UserSessionInfoVo)JteUserUtil.getUserInfo();
			List<String> roleGrps = new ArrayList<String>();
			user.getUserInfo().getRoles().forEach(r->roleGrps.add(r.getRoleId()));
			altBoardDto.setSearchAuthId(String.join(",", roleGrps.toArray(new String[roleGrps.size()])));
			altBoardDto.setSearchAuthId(roleGrps.stream().collect(Collectors.joining(",")));
			altBoardDto.setSearchAuthId(user.getUserInfo().getRoles().stream().map(r-> r.getRoleId()).collect(Collectors.joining(",")));
		} catch (Exception e) {
			log.error("Login user info not found : [{}]", e.getMessage());
		}
	}

}
