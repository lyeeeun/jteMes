package kr.co.itcall.jte.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpRequest;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class RestTemplateLoggerInterceptor implements ClientHttpRequestInterceptor {

	private static final Logger LOG = LoggerFactory.getLogger(RestTemplateLoggerInterceptor.class);
	private static final String SECURE_API_KEY_NAME = "authorization";
	private static final String HEADER_GUID_NAME = "guId";
	private static final int HEADER_GUID_LENGTH = 20;
	private static final String REST_CLIENT_TIME = "JTE_RESTFUL_TIME";
	private static final String GLOVAL_NO_KEY_NAME_PREFIX = "JTE_";
	private static final String USER_ID_KEY_NAME = null;
	private static final String USER_IP_KEY_NAME = null;
	private static final String USER_SVR_KEY_NAME = null;
	private String apiAuthKey;

	public RestTemplateLoggerInterceptor(String apiAuthKey) {
		this.apiAuthKey = apiAuthKey;
	}

	@SuppressWarnings("unused")
	@Override
	public ClientHttpResponse intercept(HttpRequest request, byte[] body, ClientHttpRequestExecution execution) throws IOException {
		try {
			LOG.info("start RestCall intercept headers[{}]", request.getHeaders());
			String clientIpAddr = NetUtil.getClientIp();
			String serverIpAddr = NetUtil.getMyIpAddr();
			RequestAttributes requestAttributes = NetUtil.getRequestAttributes();
			if(requestAttributes != null) {
				String guid = (String) ((ServletRequestAttributes)requestAttributes).getRequest().getAttribute(HEADER_GUID_NAME);
				String username = (String) ((ServletRequestAttributes)requestAttributes).getRequest().getAttribute(USER_ID_KEY_NAME);
				request.getHeaders().add(HEADER_GUID_NAME, guid); // GLOVAL_KEY 생성.셋팅.
				request.getHeaders().add(USER_ID_KEY_NAME, username); // 사용자관련 키 셋팅.
				request.getHeaders().add(USER_IP_KEY_NAME, clientIpAddr); // 사용자 접속IP 키 셋팅.
				request.getHeaders().add(USER_SVR_KEY_NAME, serverIpAddr); // 서버관련 키 셋팅.
			}
			if(request.getHeaders().get(USER_ID_KEY_NAME) == null) {
				request.getHeaders().add(USER_ID_KEY_NAME, "NONE"); // 사용자관련 키 셋팅.
			}
			if(request.getHeaders().get(USER_IP_KEY_NAME) == null) {
				request.getHeaders().add(USER_IP_KEY_NAME, "NONE"); // 사용자 접속IP 키 셋팅.
			}
			if(request.getHeaders().get(USER_SVR_KEY_NAME) == null) {
				request.getHeaders().add(USER_SVR_KEY_NAME, "NONE"); // 서버관련 키 셋팅.
			}
			if(request.getHeaders().get(SECURE_API_KEY_NAME) == null) {
				request.getHeaders().add(SECURE_API_KEY_NAME, apiAuthKey) ;
			}
			if(request.getHeaders().get(HEADER_GUID_NAME) == null) { // GLOVAL_KEY 생성.셋팅.
				request.getHeaders().add(HEADER_GUID_NAME, 
						StringUtils.rightPad(GLOVAL_NO_KEY_NAME_PREFIX + UUID.randomUUID().toString(), HEADER_GUID_LENGTH, "0"));
			}
		} catch (Exception e) {
			LOG.error("ApiCall without request none UserInfomation[{}]",e.getMessage());
		}

		LOG.info("RestCall intercept headers[{}]", request.getHeaders());
		
		ClientHttpResponse response = null;
		String respBody = null;
		try {
			traceRequest(request, body); // 호출 전 LOGGING 처리.
			response = execution.execute(request, body);
			respBody = traceResponse(response); // 호출 후 LOGGING 처리.
		} finally {
			
			String uuid = request.getHeaders().getFirst(HEADER_GUID_NAME);
			// SomthingCallClass.callMethod(uuid, request, response, respBody);
			// 최종 로깅처리를 Async로 특정서버나, 특정 LOGGING으로 전송할 수 있다.(자체로그 이외의...)
		}
		return response;
	}
	
	private void traceRequest(HttpRequest request, byte[] body) throws IOException {
		if(!NetUtil.isEmptyRequest()) {
			String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS", Locale.getDefault()).format(new Date());
			((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().setAttribute(REST_CLIENT_TIME, timestamp);
		}
		LOG.info("===========================[ RestTemplate Outbound Request Begin ]============================================");
		LOG.info("URI         : {}", request.getURI());
		LOG.info("Method      : {}", request.getMethod());
		LOG.info("Headers     : {}", request.getHeaders());
		LOG.info("Request body: {}", MaskingPayload.passwdMasking(new String(body, "UTF-8")));
		LOG.info("===========================[ RestTemplate Outbound Request End ]============================================");
	}

	private String traceResponse(ClientHttpResponse response) throws IOException {
		StringBuilder inputStringBuilder = new StringBuilder();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(response.getBody(), "UTF-8"));
		String line = bufferedReader.readLine();
		while (line != null) {
			inputStringBuilder.append(line);
			inputStringBuilder.append('\n');
			line = bufferedReader.readLine();
		}
		LOG.info("===========================[ RestTemplate Outbound Response Begin ]============================================");
		LOG.info("Status code  : {}", response.getStatusCode());
		LOG.info("Status text  : {}", response.getStatusText());
		LOG.info("Headers      : {}", response.getHeaders());
		LOG.info("Response body: {}", MaskingPayload.passwdMasking(inputStringBuilder.toString()));
		LOG.info("===========================[ RestTemplate Outbound Response End ]============================================");
		return inputStringBuilder.toString();
	}

}
