package kr.co.itcall.jte.util;

import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.client.config.RequestConfig;
import org.apache.http.conn.ssl.AllowAllHostnameVerifier;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContextBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.BufferingClientHttpRequestFactory;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@SuppressWarnings("deprecation")
public class RestClient {

	private static final Logger LOG = LoggerFactory.getLogger(RestClient.class);
	private static final String SECURE_API_KEY_NAME = "authorization";
	private static final int CONNECTION_TIMEOUT = 5 * 1000;
	private static final int READ_TIMEOUT = 90 * 1000;

	private static RestTemplate restTemplate;
	
	private static String apiAuthKey = "Basic ZG9tYWluX3VzZXI6ZG9tYWluX3VzZXI=";
	
	public static String getForObject(String url,Object params){
		return callExchange(url, HttpMethod.GET, params, null).getBody();
	}
	
	public static String getForObject(String url,Object params, Map<String,String> header){
		return callExchange(url, HttpMethod.GET, params, header).getBody();
	}
	
	public static String postForObject(String url,Object params){
		return callExchange(url, HttpMethod.POST, params, null).getBody();
	}
	
	public static String postForObject(String url,Object params, Map<String,String> header){
		LOG.info("RestCall postForObject headers:{}", header.toString());
		return callExchange(url, HttpMethod.POST, params, header).getBody();
	}
	
	public static ResponseEntity<String> callExchange(String url, Object params) {
		return callExchange(url, HttpMethod.POST, params, null);
	}

	public static ResponseEntity<String> callExchange(String url, HttpMethod httpMethod, Object params) {
		return callExchange(url, httpMethod, params, null);
	}

	public static ResponseEntity<String> callExchange(String url, Object params, Map<String,String> header) {
		return callExchange(url, HttpMethod.POST, params, header);
	}
	
	public static ResponseEntity<String> callExchange(String url, HttpMethod httpMethod, Object params, Map<String,String> header) {
		HttpEntity<Object> headerAndBody = getHttpEntity(params, header);
		LOG.info("RestCall to URL[{}] with headers[{}]", url, headerAndBody.getHeaders());
		return restTemplate().exchange(url, httpMethod, headerAndBody, String.class);
	}

	public static ResponseEntity<Object> callExchangeObj(String url, Object params) {
		return callExchangeObj(url, HttpMethod.POST, params, null);
	}

	public static ResponseEntity<Object> callExchangeObj(String url, HttpMethod httpMethod, Object params) {
		return callExchangeObj(url, httpMethod, params, null);
	}

	public static ResponseEntity<Object> callExchangeObj(String url, Object params, Map<String,String> header) {
		return callExchangeObj(url, HttpMethod.POST, params, header);
	}
	
	public static ResponseEntity<Object> callExchangeObj(String url, HttpMethod httpMethod, Object params, Map<String,String> header) {
		HttpEntity<Object> headerAndBody = getHttpEntity(params, header);
		LOG.info("RestCall to URL[{}] with headers[{}] using Object", url, headerAndBody.getHeaders());
		return restTemplate().exchange(url, httpMethod, headerAndBody, Object.class);
	}

	private static HttpEntity<Object> getHttpEntity(Object params, Map<String,String> header){
		MultiValueMap<String, String> headers = new LinkedMultiValueMap<String, String>(); 
		headers.add("Content-Type", "application/json; charset=UTF-8");
		headers.add("Accept", "application/json");
		headers.add(SECURE_API_KEY_NAME, apiAuthKey);
		if(header!=null) {
			for (String key : header.keySet()) {
				headers.add(key, header.get(key));
			}
		}
//		try {
//			String guid = (String) ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getAttribute(LampLogVo.GLOVAL_NO_KEY_NAME);
//			headers.add(LampLogVo.GLOVAL_NO_KEY_NAME, guid); // LAMP관련 키 셋팅.
////			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
////			LampInfoVo userInfo = (LampInfoVo)authentication.getPrincipal();
//			LampInfoVo lampInfoVo = (LampInfoVo)((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getAttribute(LampLogVo.USER_INFO_KEY_NAME);
//			headers.add(LampLogVo.USER_ID_KEY_NAME, lampInfoVo.getUsername()); // LAMP관련 키 셋팅.
//			headers.add(LampLogVo.USER_IP_KEY_NAME, lampInfoVo.getIpAddr()); // LAMP관련 키 셋팅.
//			headers.add(LampLogVo.USER_TYPE_KEY_NAME, lampInfoVo.getAthyGroupNm()); // LAMP관련 키 셋팅.
//		} catch (Exception e) {
//			LOG.warn("ApiCall without request none UserInfomation[{}], {}",e.getMessage(), e);
//		}
		HttpEntity<Object> entity = new HttpEntity<Object>(params, headers);

		return entity;
	}

	public static RestTemplate restTemplate() {
		if(restTemplate!=null) return restTemplate;
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
		factory.setConnectTimeout(CONNECTION_TIMEOUT);
		factory.setReadTimeout(READ_TIMEOUT);
		factory.setHttpClient(getHttpClientWithSSL()); // support SSL
		BufferingClientHttpRequestFactory bufferingClientHttpRequestFactory = new BufferingClientHttpRequestFactory(
				factory);
		RestTemplate restTemplate = new RestTemplate(bufferingClientHttpRequestFactory);
		List<ClientHttpRequestInterceptor> interceptors = new ArrayList<>();
		interceptors.add(new RestTemplateLoggerInterceptor(apiAuthKey));
		restTemplate.setInterceptors(interceptors);
		return RestClient.restTemplate = restTemplate;
	}

	/**
	 * for RestTemplate with Suppoprt SSL
	 * 
	 * @return
	 */
	private static CloseableHttpClient getHttpClientWithSSL() {
		CloseableHttpClient httpClient = null;
		try {
			RequestConfig config = RequestConfig.custom().setConnectTimeout(CONNECTION_TIMEOUT)
					.setConnectionRequestTimeout(READ_TIMEOUT).setSocketTimeout(READ_TIMEOUT).build();
			httpClient = HttpClients.custom().setDefaultRequestConfig(config)
					.setHostnameVerifier(new AllowAllHostnameVerifier()).setSslcontext(
							new SSLContextBuilder().loadTrustMaterial(null, new org.apache.http.ssl.TrustStrategy() {
								public boolean isTrusted(X509Certificate[] arg0, String arg1)
										throws CertificateException {
									return true;
								}
							}).build())
					.build();
		} catch (NoSuchAlgorithmException e) {
			LOG.error("@@ {}", e.getMessage());
		} catch (KeyManagementException e) {
			LOG.error("@@ {}", e.getMessage());
		} catch (KeyStoreException e) {
			LOG.error("@@ {}", e.getMessage());
		}
		return httpClient;
	}

}
