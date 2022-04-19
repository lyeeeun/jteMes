package kr.co.itcall.jte.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class NetUtil {

	private static final Logger LOG = LoggerFactory.getLogger(NetUtil.class);
	
	public static boolean isEmptyRequest() {
		try {
			if(RequestContextHolder.currentRequestAttributes()!=null 
					&& RequestContextHolder.currentRequestAttributes() instanceof ServletRequestAttributes) {
				return false;
			}
		} catch (Exception e) {
			LOG.warn("isEmptyRequest Error : {}", e.getMessage());
		}
		return true;
	}

	public static RequestAttributes getRequestAttributes() {
		try {
			return RequestContextHolder.currentRequestAttributes();
		} catch (Exception e) {
			LOG.warn("getRequestAttributes Error : {}", e.getMessage());
		}
		return null;
	}
	
	public static String getClientIp() {
		if(isEmptyRequest()) {
			return "UnknownIp";
		}
		String ip = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("X-FORWARDED-FOR");
		if (ip == null) {
			ip = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getRemoteAddr();
		}
		return ip;
	}

	public static String getHostIp(String hostName) {
		String hostIp = hostName;
		try {
			hostIp = InetAddress.getByName(hostName).getHostAddress();
		} catch (UnknownHostException e) {
			hostIp = hostName;
		}
		return hostIp;
	}

	public static String getMyIpAddr() {
		try {
			return InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			return "UnkownIP";
		}
	}

	public static String getMyHostName() {
		try {
			return InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			return "UnkownHost";
		}
	}
	
//	public static void main(String[] args) throws UnknownHostException {
//		System.out.println(getMyIpAddr());
//		System.out.println(InetAddress.getLocalHost().getHostName());
//	}
}
