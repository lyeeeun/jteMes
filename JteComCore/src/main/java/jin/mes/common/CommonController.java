package jin.mes.common;

import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import jin.mes.common.cache.CacheUtil;
import jin.mes.common.msg.MsgViewService;
import kr.co.itcall.jte.common.code.ComnCodeService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;
import kr.co.itcall.jte.spring.user.JteUserUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * <b>jin.mes.common</b>
 * <b>CommonController.java</b>
 * <p>Descriptions : Ajax 호출 테스트 </p>
 *  // 화면에서 호출 테스트 for Ajax.Call
	$.ajax({
		url:"/common/myInfo"
		, data:{codeId:"sys.flag", msgId:"login.error.user.delete", msgParams:["테스트용 사용자"]} // {lang:"en"}
	//	, data:JSON.stringify({codeId:"sys.flag", msgId:"login.error.user.delete", msgParams:["테스트용 사용자"]}) // {lang:"en"}
		, type:"POST"
		, traditional : true
		, dataType: 'json'
		, sussess:function(data){
			console.log(JSON.stringify(data));
		}, error:function(XMLHttpRequest, textStatus, errorThrown){
			console.log("argument textStatus : ", JSON.stringify(textStatus));
			console.log("argument errorThrown : ", JSON.stringify(errorThrown));
			console.log("argument XMLHttpRequest : ", JSON.stringify(XMLHttpRequest));
		}
	});
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 12. 5.
 * @Version :
 */
@Controller
@RequestMapping("/common")
@Slf4j
public class CommonController extends BaseController {

	private static final int DEF_SESSION_LIMIT_SECONDS = 3600; // 기본 세션 유지기간 3600초 (1시간)
	private static final int DEF_SESSION_LIMIT_MINIMIZE_SECONDS = 180; // 세션 유지기간은 최소 180초(3분) 이하로 설정할 수 없다.

	@Value("#{biz['session.timeout']?:"+DEF_SESSION_LIMIT_SECONDS+"}") // 세션 타임아웃 초단위
	private int sessionLimitSeconds;
	@Value("${session.timeout:0}")
	private int sessionLimitSecondsByCmd;
	
	@Autowired
	private MsgViewService msgViewService;
	@Autowired
	private ComnCodeService codeService;
	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	@Autowired
	private MessageSource messageSource;
	
	@RequestMapping("/popup/comPopup")
	public String getComPopup(ModelMap model){
		/******************************
		 * 공통팝에서 사용될 Object를 전달한다.
		 ******************************/
		return "/form/common/popup/comPopup"; // for JSP
//		return "tlf/form/common/popup/comPopup"; // for ThyemLeaf
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = {"/myInfo"}, method = RequestMethod.POST , produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Object> myInfo(Locale locale, String codeId, String msgId, String[] msgParams, HttpServletRequest request, ModelMap model) {
		return new ResponseEntity<Object>(getMySessionInfo(), HttpStatus.OK);
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = {"/myInfoMap"}, method = RequestMethod.POST , produces = {MediaType.APPLICATION_JSON_VALUE})
	public Map<String, Object> myInfoMap(Locale locale, String codeId, String msgId, String[] msgParams, HttpServletRequest request, ModelMap model) {
		return getMySessionInfo(codeId, msgId, msgParams);
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = {"/myInfoModelMap"}, method = RequestMethod.POST , produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap myInfoModelMap(Locale locale, String codeId, String msgId, String[] msgParams, HttpServletRequest request, ModelMap modelMap) {
		return modelMap.addAllAttributes(getMySessionInfo(codeId, msgId, msgParams));
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = {"/myInfoModel"}, method = RequestMethod.POST , produces = {MediaType.APPLICATION_JSON_VALUE})
	public Model myInfoModel(Locale locale, String codeId, String msgId, String[] msgParams, HttpServletRequest request, Model model) {
		return model.addAllAttributes(getMySessionInfo());
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = {"/myInfoModelView"}, method = RequestMethod.POST , produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelAndView myInfoModelView(Locale locale, String codeId, String msgId, String[] msgParams, HttpServletRequest request, ModelAndView view) {
//		view.setStatus(HttpStatus.OK); // HTTP 코드를 지정할 수 있다.
//		view.setViewName(toJsonView()); // viewName을 지정할 수 있다. 기본값은 "jsonView"로 정의됨.
		return view.addAllObjects(getMySessionInfo());
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = {"/myInfoJson"}, method = RequestMethod.POST , produces = {MediaType.APPLICATION_JSON_VALUE})
	public String myInfoJson(Locale locale, String codeId, String msgId, String[] msgParams, HttpServletRequest request, Model model) {
		model.addAllAttributes(getMySessionInfo());
		return toJsonView();
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = {"/myInfoJson2"}, method = RequestMethod.POST , produces = {MediaType.APPLICATION_JSON_VALUE})
	public String myInfoJson2(Locale locale, String codeId, String msgId, String[] msgParams, HttpServletRequest request, ModelMap modelMap) {
		modelMap.addAllAttributes(getMySessionInfo(codeId, msgId, msgParams));
		return toJsonView();
	}

	private Map<String, Object> getMySessionInfo(String codeId, String msgId, String[] msgParams){
		Map<String,Object> result = new HashMap<String,Object>();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserSessionInfoVo userSessionInfoVo = (UserSessionInfoVo)authentication.getPrincipal();
		HttpServletRequest request = JteUtils.getMyRequest();
		result.put("Date", new Date());
		result.put("locale", JteUtils.getMyLocale());
		result.put("myIpAddr", JteUtils.getClientIp());
		result.put("myAuthIds", JteUtils.getMyAuthIds());
		result.put("userId", JteUtils.getUserId());
		result.put("userInfo", JteUserUtil.getUserInfo().getUserInfo());
		result.put("myMenu", userSessionInfoVo.getMyMenuVos());
		result.put("moreInfo", userSessionInfoVo.getIsMoreInfos());
		result.put("sessionUserInfo", userSessionInfoVo);
		result.put("msgView", messageSourceAccessor.getMessage(msgId, msgParams, "해당 메시지를 찾을 수 없습니다.(messageSourceAccessor 이용)", JteUtils.getMyLocale()));
		result.put("msgViewAccessor", messageSource.getMessage(msgId, msgParams, "해당 메시지를 찾을 수 없습니다.(messageSource 이용)", JteUtils.getMyLocale()));
		result.put("msgViewFromDb", msgViewService.getMsgView(msgId, JteUtils.getMyLocale()));
		result.put("msgViewAll", msgViewService.getMsgView(msgId));
		result.put("CacheCodeUtil.getCode('" + codeId + "')", CacheUtil.getCode(codeId, "코드 기본값을 찾을 수 없습니다."));
//		result.put("codeInfo", codeService.getComnCode(codeId));
//		result.put("codeLikeList", codeService.getComnCodeList(codeId));
//		result.put("codeRootList", codeService.getComnCodeRootList());
		log.debug("myInfo Search[{}]", result);
		return result;
	}

	private Map<String, Object> getMySessionInfo(){
		Map<String,Object> result = new HashMap<String,Object>();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserSessionInfoVo userSessionInfoVo = (UserSessionInfoVo)authentication.getPrincipal();
		HttpServletRequest request = JteUtils.getMyRequest();
		result.put("Date", new Date());
		result.put("locale", JteUtils.getMyLocale());
		result.put("myIpAddr", JteUtils.getClientIp());
		result.put("userId", JteUtils.getUserId());
		result.put("userInfo", JteUserUtil.getUserInfo().getUserInfo());
		result.put("myAuthIds", userSessionInfoVo.getAuthInfoIds());
		result.put("myMenu", userSessionInfoVo.getMyMenuVos());
		result.put("moreInfo", userSessionInfoVo.getIsMoreInfos());
		//result.put("sessionUserInfo", userSessionInfoVo);
		return result;
	}
	
	@RequestMapping(value = {"/session/time"}, method = RequestMethod.POST)
	public Model sessionTime(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		model.addAttribute("sessionId", session.getAttribute("session_id"));
		model.addAttribute("lastTime", session.getLastAccessedTime());
		model.addAttribute("maxTime", session.getMaxInactiveInterval());
		return model;
	}
	@RequestMapping(value = {"/session/reset"}, method = RequestMethod.POST)
	public Model sessionReset(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		
		int sessionLimitTime = this.sessionLimitSecondsByCmd >= DEF_SESSION_LIMIT_MINIMIZE_SECONDS?this.sessionLimitSecondsByCmd:this.sessionLimitSeconds;
		session.setMaxInactiveInterval(sessionLimitTime);
		
		model.addAttribute("sessionId", session.getAttribute("session_id"));
		model.addAttribute("lastTime", session.getLastAccessedTime());
		model.addAttribute("maxTime", session.getMaxInactiveInterval());
		return model;
	}
}
