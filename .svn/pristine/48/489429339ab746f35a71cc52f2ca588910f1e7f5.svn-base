package kr.co.itcall.jte;

import org.jasypt.encryption.StringEncryptor;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.EnvironmentStringPBEConfig;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.co.itcall.jte.util.SecureAesCripto;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class SecureTest {

	/**
	 * -Daes.enc.pwd=passwordKey from runTime.
	 */
	// @Value("${aes.enc.pwd}")
	// private String key = "jte@EncriptQ$^Keys#$%08810/95210";
	private String key = "..rnlgo12JinTechEng@EncriptorKey.s";

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	private static String JASYPT_ALGORITHM = "PBEWITHMD5ANDDES";
	private static String JASYPT_KEY_CODE = "SlsvPpmFBZi9wBEGbZlpZJGO7HvvFoH9V/oyOa3R8B1QWKBLE7MqyHtXadNwO/JF"; // Aes256으로 암호화된 Properties키코드.

	private SecureAesCripto secureAesCripto;
	private StringEncryptor stringEncryptor;
	
	// @PostConstruct
	@Before
	public void initialize() throws Throwable {
		this.secureAesCripto = new SecureAesCripto();
		this.stringEncryptor = stringEncryptor();
	}

	private StringEncryptor stringEncryptor() throws Exception {
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		String psNameKey = this.secureAesCripto.decrypt(JASYPT_KEY_CODE, this.key);
		EnvironmentStringPBEConfig pbeConfig = new EnvironmentStringPBEConfig();
		pbeConfig.setAlgorithm(JASYPT_ALGORITHM);
		pbeConfig.setPassword(psNameKey);
		encryptor.setConfig(pbeConfig);
		return encryptor;
	}

	/**
	 * AES-265 양방향 대칭 암복호화 테스트.
	 * @throws Exception 
	 */
	@Test
	public void checkSecureAES() throws Exception {
		
		String rawText = "암호화하기전에 테스트 for AES-256";
		String encText = this.secureAesCripto.encrypt(rawText, this.key);
		log.info("AES-256 암호화 : 원시텍스트[{}] >>> 암호텍스트[{}]", rawText, encText);
		String decText = this.secureAesCripto.decrypt(encText, this.key);
		log.info("AES-256 복호화 : 암호텍스트[{}] >>> 복호텍스트[{}]", encText, decText);
		
		log.info("AES-256 신규암복호화 : [{}] >>> [{}]", this.secureAesCripto.encrypt(decText, key), this.secureAesCripto.decrypt(this.secureAesCripto.encrypt(decText, key), key));
		log.info("AES-256 신규암복호화 : [{}] >>> [{}]", this.secureAesCripto.encrypt("", key), this.secureAesCripto.decrypt(this.secureAesCripto.encrypt(decText, key), key));
		log.info("AES-256 신규암복호화 : [{}] >>> [{}]", this.secureAesCripto.encrypt("테스트입니다.", key), this.secureAesCripto.decrypt(this.secureAesCripto.encrypt(decText, key), key));
		/**
		 * Properties 암복호화에서 사용하는 Jasypt의 패스워드키는 AES로 암호화 하여 저장한다.
		 * AES의 암호화기준 코드(키값)은 실행옵션으로 읽어온다. -Daes.enc.pwd=...
		 */
		log.info("Properties KeyCode(PasswordKey) = [{}] <<< [{}]", this.secureAesCripto.decrypt(JASYPT_KEY_CODE, this.key), JASYPT_KEY_CODE);
		
		
		
		log.info("==================================================================================");
		log.info("==================================================================================\n");
		
	}

	/**
	 * Jasypt SpringBootProperties 양방향 대칭 암복호화 테스트.
	 */
	@Test
	public void propertiesSecureTest() {
		String rawData = "zzz";
		String encProperty = this.stringEncryptor.encrypt(rawData);
		log.info("Jasypt Properties 암호화 : [{}] >>> [{}]", rawData, encProperty);
		String decProperty = this.stringEncryptor.decrypt(encProperty);
		log.info("Jasypt Properties 복호화 : [{}] >>> [{}]", encProperty, decProperty);
		
		//암호화
		rawData = "jdbc:mariadb://127.0.0.1/jinmes";
		log.error("Jasypt Properties 암호화테스트 : [{}] >>> [{}]", rawData, this.stringEncryptor.encrypt(rawData));
		
		//복호화
		rawData = "ksBCQazGBTygFa+XR68U/hpgDm7YFBQ6H0gL8xp52BLn9TnunpMnns6M2O3cZQLPisRisN5p45A=";
		log.error("Jasypt Properties 암호화테스트 : [{}] >>> [{}]", rawData, this.stringEncryptor.decrypt(rawData));
		
		rawData = "wnrnx+AiOv+/BcM7BFFtCS4zDCr5yM96DCBXYAhf9N83yt/6tEO62np2iCdjAgN7appYDMZrLgnsxLZqRailmx2sKB7w0GU9";
		log.error("Jasypt Properties 암호화테스트 : [{}] >>> [{}]", rawData, this.stringEncryptor.decrypt(rawData));
	}
	
	@Test
	public void shahashTest() {
		String rawData = "1q2w3e~!@";
//		log.info("==================================================================================");
//		log.info("암호화 ", rawData,passwordEncoder.encode(rawData));
//		log.info("==================================================================================");
		//log.info("암호화 ", rawData,passwordEncoder.getCustomPw(rawData));
		
	}
	
}
