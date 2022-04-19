package kr.co.itcall.jte.util;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import kr.co.itcall.jte.common.util.CodeUtil;
import lombok.extern.slf4j.Slf4j;

/********************************************************************************************
 *  SecureRsaCripto : RSA 비대칭 암복호화. 대칭보다 1000배 느리다.
 *  SecureAesCripto : AES-256 대칭 암복호화. 비대칭보다 1000배 빠르다.
 *  SecureShaHash : 단방향 SHA-256에 SALT기법을 추가한. 단방향이라 복호화를 하지 않으며, 가장 속도가 빠름. 
 *                  정확히 말하면 암(복)호화가 아닌 해쉬 알고리즘임.
 *                  자동SALT가 적용된 org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder를 사용함.
 ********************************************************************************************/
@Slf4j
@Component
public class SecureShaHash implements PasswordEncoder {

	private static final long DEF_SALT_NUMBER = 3029;
	private static final String DEF_PWD_ENCODER_FORMAT = "^%sv\" %s+ %s@*%s~%d=%s..~%s!";

	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Value("${spring.profiles.active:prd}")
	private String profile;

	@Value("#{app['secure.rsa.use.yn']?:'N'}")
	private String rsaUseYn;

	@Value("#{app['secure.rsa.use.yn']?:'N'}")
	private String domain;
	
	@Value("#{biz['company.domain']?:'jintech2ng'}") // WEB-RESOURCES 경로.
	private String companyDomain;
	
	@PostConstruct
	private void initialize() {
		this.bCryptPasswordEncoder = new BCryptPasswordEncoder(); // Spring에서 제공하는 단방향 해쉬알고리즘 SHA-256 with SALT
		this.getCustomPw();
	}

	@Override
	public String encode(CharSequence rawPassword) {
		return encode(rawPassword, DEF_SALT_NUMBER);
	}
	
	public String encode(CharSequence rawPassword, long salt) {
		return this.bCryptPasswordEncoder.encode(getWithSalt(rawPassword, salt));
	}
	
	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		boolean result = matches(rawPassword, encodedPassword, DEF_SALT_NUMBER);
		return result;
	}
	public boolean matches(CharSequence rawPassword, String encodedPassword, long salt) {
		return this.bCryptPasswordEncoder.matches(getWithSalt(rawPassword, DEF_SALT_NUMBER), encodedPassword);
	}

	private String getWithSalt(CharSequence rawPassword, long salt) {
		log.info("SHA-256 with SALT-KEY[{}]", salt);
		try {
			rawPassword = SecureRsaCripto.getRsaDecodeFromSession(rawPassword.toString(), this.rsaUseYn);
		} catch (Exception e) {
			log.warn("RSA Decode Error rawPassword[{}]", rawPassword);
		}
		
		//jkkim - 개인 PC에서 암호화 할 경우 "System.getProperty("user.name", "khaeng@nate.com")" 부분이 개인 PC USER정보가 들어가기 때문에 local환경에서는 하드코딩   
//		String result = String.format(DEF_PWD_ENCODER_FORMAT, System.getProperty("file.separator", "/"), System.getProperty("path.separator", ":"), rawPassword, this.profile, salt, System.getProperty("line.separator", "\n"), System.getProperty("user.name", "khaeng@nate.com"));
//		if(StringUtils.equalsIgnoreCase(profile, "local")) {}

		//prod, prod2 분리로 인한
		if(profile.indexOf("prod") != -1) {
			profile = "prod";
		}
		
		//OS 따른  getPropery가 달라 수정 예정
		String result = String.format(DEF_PWD_ENCODER_FORMAT, System.getProperty("file.separator", "/"), System.getProperty("path.separator", ":"), rawPassword, profile, salt, System.getProperty("line.separator", "\n"),companyDomain);
		
		log.debug("getWithSalt(rawPassword[{}], salt[{}]) : [{}]", rawPassword, salt, result);
		return result;
	}
	
	private void getCustomPw() {
		String rawPassword = "1q2w3e~!@";
		try {
			rawPassword = SecureRsaCripto.getRsaDecodeFromSession(rawPassword.toString(), this.rsaUseYn);
		} catch (Exception e) {
			log.warn("RSA Decode Error rawPassword[{}]", rawPassword);
		}
		
		if(profile.indexOf("prod") != -1) {
			profile = "prod";
		}
		
		String result = String.format(DEF_PWD_ENCODER_FORMAT, System.getProperty("file.separator", "/"), System.getProperty("path.separator", ":"), rawPassword, profile, DEF_SALT_NUMBER, System.getProperty("line.separator", "\n"), companyDomain);
		
		log.error("초기 패스워드 : [{}]", this.bCryptPasswordEncoder.encode(result));
		
	}

}