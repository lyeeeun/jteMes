package kr.co.itcall.jte.spring.config.security.handler;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Service;

import jin.mes.form.devtol.userConn.UserConnDto;
import jin.mes.form.devtol.userConn.UserConnService;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.security.LoginUserService;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class JteLogoutSuccessHandler implements LogoutSuccessHandler {

	@Resource
	private LoginUserService loginUserService;

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		if (authentication != null && authentication.getDetails() != null) {
			try {
				request.getSession().invalidate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		response.setStatus(HttpServletResponse.SC_OK);
//		response.setContentType("text/html; charset=UTF-8");
//		response.setHeader("sessionLogout", "OK");
		
		if(!StringUtils.isEmpty(request.getParameter("session"))&&request.getParameter("session").equals("out")){
			request.getSession().setAttribute("loginMsg", "사용시간 만료로 인해 로그아웃 되었습니다. \n 다시 로그인해주세요.");
		}else {
			request.getSession().setAttribute("loginMsg", "로그아웃 되었습니다.");
		}
		
		response.sendRedirect("/");
		// 접속종료 등의 히스토리성 처리와 위치이동을 처리한다.
//		String ajaxHeader = request.getHeader("X-Requested-With")==null?"":request.getHeader("X-Requested-With");
//		
//		if(authentication != null){
//			ConnectionLogDto connectionLogDto = new ConnectionLogDto();
//			UserInfo user = (UserInfo)authentication.getPrincipal();
//			connectionLogDto.setUserId(user.getUsername());
//			connectionLogDto.setConnDivCd("02");
//			connectionLogDto.setUseSysDivCd("ONM");
//			connectionLogDto.setUserIp(BizUtil.getClientIp());
//			connectionLogService.add(connectionLogDto);
//		}
//		
//		if("XMLHttpRequest".equals(ajaxHeader)){
//			response.setStatus(HttpStatus.SC_UNAUTHORIZED);
//			response.setCharacterEncoding("utf-8");
//			response.setContentType("application/json");
//			Map<String,String> jsonBean = new HashMap<String,String>();
//			ObjectMapper mapper = new ObjectMapper();
//			response.getWriter().write(mapper.writeValueAsString(jsonBean));
//		}else{
//			setDefaultTargetUrl("/login");
//
//	        super.onLogoutSuccess(request, response, authentication);       
//		}
	}

}
