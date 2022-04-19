package kr.co.itcall.jte.spring.config.web.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import kr.co.itcall.jte.common.util.JteUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@WebListener
public class JteSessionListener implements HttpSessionListener {
	
	private static final int DEF_SESSION_LIMIT_SECONDS = 3600; // 기본 세션 유지기간 3600초 (1시간)
	private static final int DEF_SESSION_LIMIT_MINIMIZE_SECONDS = 180; // 세션 유지기간은 최소 180초(3분) 이하로 설정할 수 없다.

	@Value("#{biz['session.timeout']?:"+DEF_SESSION_LIMIT_SECONDS+"}") // 세션 타임아웃 초단위
	private int sessionLimitSeconds;
	@Value("${session.timeout:0}")
	private int sessionLimitSecondsByCmd;

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		HttpSessionListener.super.sessionCreated(event);
		int sessionLimitTime = this.sessionLimitSecondsByCmd>=DEF_SESSION_LIMIT_MINIMIZE_SECONDS?this.sessionLimitSecondsByCmd:this.sessionLimitSeconds;
		event.getSession().setMaxInactiveInterval(sessionLimitTime); // 초단위이며, 요청발생할 때마다 갱신해준다.
		log.debug("=== Session is created for setMaxInactiveInterval([{}]seconds) === [{}]", sessionLimitTime, event.getSession());
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSessionListener.super.sessionDestroyed(event);
		
		log.debug("=== Session is destroyed === [{}]", JteUtils.getUserId() + event.getSession());
	}

}
