package kr.co.itcall.jte.util;

import java.nio.charset.Charset;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.RSAPrivateKeySpec;
import java.security.spec.RSAPublicKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

// import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.util.support.DynamicKeyPairRSA;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class SecureRsaCripto {

	public static final String RSA_DYNMIC_KEY = "_RSA_Dynamic_Key_";

	@Value("#{app['app.secure.rsa.public.key01']?:'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsnl1D2xM0YFWx7MEKqKS8YnHqipW5oZtOloQ0llJ09zl8TBzaW9DKfermX6v/As2x+W4pjUBif652RjvGNntmZ2f/sAJBzUJ7H4ScVCXQG1N/aFErQ3V+Rmo4/OOFyRn5xE0J3P23+kK+GO2E5c9EH6vqMtbykP9Y0k9az0Ag4z/C5wHrrmXKZkQsUJ8o/RZbeb+g5BjOeTF6uIyl4I8WrLlV6cQZUCemdFlDUYluXQCIkYUjDCqiAzCRWsDK8ToULTekFZRDqbVPetKfexbG/MiiX0yTW36CzWvZ7HuDBewFUa3xSD92ov/gijiyYqx3NQCTsZDu2txGJyPUmaJ/wIDAQAB'}")
	private String rsaPublicKey01;
	@Value("#{app['app.secure.rsa.public.key02']?:''}")
	private String rsaPublicKey02;
	@Value("#{app['app.secure.rsa.public.key03']?:''}")
	private String rsaPublicKey03;
	@Value("#{app['app.secure.rsa.public.key04']?:''}")
	private String rsaPublicKey04;
	@Value("#{app['app.secure.rsa.public.key05']?:''}")
	private String rsaPublicKey05;
	@Value("#{app['app.secure.rsa.public.key06']?:''}")
	private String rsaPublicKey06;
	@Value("#{app['app.secure.rsa.public.key07']?:''}")
	private String rsaPublicKey07;
	@Value("#{app['app.secure.rsa.public.key08']?:''}")
	private String rsaPublicKey08;
	@Value("#{app['app.secure.rsa.public.key09']?:''}")
	private String rsaPublicKey09;
	@Value("#{app['app.secure.rsa.public.key10']?:''}")
	private String rsaPublicKey10;
	@Value("#{app['app.secure.rsa.private.key01']?:'MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCyeXUPbEzRgVbHswQqopLxiceqKlbmhm06WhDSWUnT3OXxMHNpb0Mp96uZfq/8CzbH5bimNQGJ/rnZGO8Y2e2ZnZ/+wAkHNQnsfhJxUJdAbU39oUStDdX5Gajj844XJGfnETQnc/bf6Qr4Y7YTlz0Qfq+oy1vKQ/1jST1rPQCDjP8LnAeuuZcpmRCxQnyj9Flt5v6DkGM55MXq4jKXgjxasuVXpxBlQJ6Z0WUNRiW5dAIiRhSMMKqIDMJFawMrxOhQtN6QVlEOptU960p97Fsb8yKJfTJNbfoLNa9nse4MF7AVRrfFIP3ai/+CKOLJirHc1AJOxkO7a3EYnI9SZon/AgMBAAECggEBAKC/rKPbk8UPja4ImzQbgeZzhpbJ08OGSFNKU+Rh75EXYTQ/w3OvdvsRzElQRgnpv8mEKy/ohh5Yg+P6BUCI6Ox3gGffZ0JKj0mms83EHLc2vAw5eLW1xIe8iNXnxI8rhzoj0KnIVQ+PwwW+KXyzt5hnwqdxopcnbc5DZUJ1i0Tv8zdfat470PYYx01HIOil2jcptUG9tXAwL7xfk3M82s/WALWaAtIEAsG0lzD5qrmeqUfv/f49Eh8oBtk0o8pRDKR0UTx9Bhy2muk39W69VcOd0zykmx+9SR1uJOMjENXhCTF8NcLKGgptcmwnHdIFAeyJI9Gt3HXydy6FgkGAD4ECgYEA6SURDDlJ3KOzC0RflmvFVVujJnYKdmkbuP22wSybZZW8MTXWZ6XH2EYSufLz9MnNOcdmVgjgurY/Ez5wHBlVfUtW2QUP0+TSt+fIQTmuf4nmU1fz98q+Tn4cCoXIbnLR31GSdOUz+dSgyHnvogh+B5/kd5W0yUYA9Vka5fjjrk8CgYEAw/hmTKxqwNi+W7iiGJ2RqOwQ0pLGerqXMYuFwYRd55f6Qe8UH18TX8KVAz1cFKUnisJmSNnmD+3c2q+i+uwcStoQMUqcVNb9fZCe8HcKgZ5Z8TOeUwnkdJlnJL8upX/VNzETRyEVmxE24cdRuNR3dSoraEIXKLwGlyc1QkYfrVECgYEA5udSEgQvFfl+2trVvLlx0A8Y73+a7xk8XqPQu1M9eIeqwiYq+a4j1hvYchef68FtoxrMTMswH1td7uY4zGt+0r+p/PfZbCfFVmSVXZwOKbxexA5ozvIaNs0JYpaLInBPUViNr35NUtJ2hvbVEWpNv6lo8dLwISNW0ad1T2yHulsCgYEAjiAWwUDCY35OAGNVXBjazPH3+V/thpDQmmQf64s+N3pnS25C38WqXWbXf3P+1hI5LU9zsx4k1iSiag+7WdPnaPnhiH4eBwGs8mXyf182RW88t8vB5WNlRpMC1Qm6oNinH9H9szZxXvcLII/X2v5sbJLazFAyT56eAP20iI4m5yECgYAsexb/kuMjaH6DcAqcXP6+1A5JFlnsiPUWextWFNUoka5j+iqq05gIqmBlOLDYh0mxO4KfoyjN8n+mH7+C9Bzd8btrtkMz//I+WFfPh0ewJ+SYyZvQxhkYftjL0xKUYQDis3TKTSb4NY3KHxKQyBVcT058gj7AXcqvlKacK4khxQ=='}")
	private String rsaPrivateKey01;
	@Value("#{app['app.secure.rsa.private.key02']?:''}")
	private String rsaPrivateKey02;
	@Value("#{app['app.secure.rsa.private.key03']?:''}")
	private String rsaPrivateKey03;
	@Value("#{app['app.secure.rsa.private.key04']?:''}")
	private String rsaPrivateKey04;
	@Value("#{app['app.secure.rsa.private.key05']?:''}")
	private String rsaPrivateKey05;
	@Value("#{app['app.secure.rsa.private.key06']?:''}")
	private String rsaPrivateKey06;
	@Value("#{app['app.secure.rsa.private.key07']?:''}")
	private String rsaPrivateKey07;
	@Value("#{app['app.secure.rsa.private.key08']?:''}")
	private String rsaPrivateKey08;
	@Value("#{app['app.secure.rsa.private.key09']?:''}")
	private String rsaPrivateKey09;
	@Value("#{app['app.secure.rsa.private.key10']?:''}")
	private String rsaPrivateKey10;
	
	private List<Cipher> rsaPublicCipherList;
	
	private List<Cipher> rsaPrivateCipherList;
	
	@PostConstruct
	private void initialize() {
		this.rsaPrivateCipherList = new ArrayList<Cipher>();
		this.rsaPublicCipherList = new ArrayList<Cipher>();
		List<String> rsaPublicKeyStrList = new ArrayList<String>();
		rsaPublicKeyStrList.add(rsaPublicKey01);
		rsaPublicKeyStrList.add(rsaPublicKey02);
		rsaPublicKeyStrList.add(rsaPublicKey03);
		rsaPublicKeyStrList.add(rsaPublicKey04);
		rsaPublicKeyStrList.add(rsaPublicKey05);
		rsaPublicKeyStrList.add(rsaPublicKey06);
		rsaPublicKeyStrList.add(rsaPublicKey07);
		rsaPublicKeyStrList.add(rsaPublicKey08);
		rsaPublicKeyStrList.add(rsaPublicKey09);
		rsaPublicKeyStrList.add(rsaPublicKey10);
		List<String> rsaPrivateKeyStrList = new ArrayList<String>();
		rsaPrivateKeyStrList.add(rsaPrivateKey01);
		rsaPrivateKeyStrList.add(rsaPrivateKey02);
		rsaPrivateKeyStrList.add(rsaPrivateKey03);
		rsaPrivateKeyStrList.add(rsaPrivateKey04);
		rsaPrivateKeyStrList.add(rsaPrivateKey05);
		rsaPrivateKeyStrList.add(rsaPrivateKey06);
		rsaPrivateKeyStrList.add(rsaPrivateKey07);
		rsaPrivateKeyStrList.add(rsaPrivateKey08);
		rsaPrivateKeyStrList.add(rsaPrivateKey09);
		rsaPrivateKeyStrList.add(rsaPrivateKey10);
		
		KeyFactory keyFactory;
		try {
			keyFactory = KeyFactory.getInstance("RSA");

			// 비밀키 이용 암호화 cipher 10개.
			for (String privateKeyStr : rsaPrivateKeyStrList) {
				byte[] bPrivateKey = Base64.decodeBase64(privateKeyStr.getBytes());
				PrivateKey privateKey = null;
				PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bPrivateKey);
				privateKey = keyFactory.generatePrivate(privateKeySpec);
				Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
				cipher.init(Cipher.DECRYPT_MODE, privateKey);
				this.rsaPrivateCipherList.add(cipher);
			}

			// 공개키 이용 암호화 cipher 10개.
			for (String publicKeyStr : rsaPublicKeyStrList) {
				byte[] bPublicKey = Base64.decodeBase64(publicKeyStr.getBytes());
				PublicKey publicKey = null;
				X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(bPublicKey);
				publicKey = keyFactory.generatePublic(publicKeySpec);
				Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
				cipher.init(Cipher.ENCRYPT_MODE, publicKey);
				this.rsaPublicCipherList.add(cipher);
			}
		} catch (NoSuchAlgorithmException | InvalidKeySpecException | NoSuchPaddingException | InvalidKeyException e) {
			e.printStackTrace();
		}
		
	}

	public Cipher getRSAPublicKey() {
		return getRSAPublicKey(0);
	}

	public Cipher getRSAPublicKey(int index) {
		try {
			return this.rsaPublicCipherList.get(index);
		} catch (Exception e) {
			return this.rsaPublicCipherList.get(0);
		}
	}

	public Cipher getRSAPrivateCipher() {
		return getRSAPrivateCipher(0);
	}

	public Cipher getRSAPrivateCipher(int index) {
		try {
			return this.rsaPrivateCipherList.get(index);
		} catch (Exception e) {
			return this.rsaPrivateCipherList.get(0);
		}
	}

	public String getRSAEncode(String data) {
		return getRSAEncode(data, 0);
	}
	public String getRSAEncode(String data, String publicKeyStr) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException {
		return getRSAEncode(data, publicKeyStr, Charset.defaultCharset());
	}
	public String getRSAEncode(String data, String publicKeyStr, Charset charset) throws NoSuchAlgorithmException, InvalidKeyException, InvalidKeySpecException, NoSuchPaddingException {
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		byte[] bPublicKey = Base64.decodeBase64(publicKeyStr.getBytes());
		PublicKey publicKey = null;
		X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(bPublicKey);
		publicKey = keyFactory.generatePublic(publicKeySpec);
		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.ENCRYPT_MODE, publicKey);
		return getRSAEncode(data, cipher, charset);
	}
	public String getRSAEncode(String data, int index) {
		return getRSAEncode(data, index, Charset.defaultCharset());
	}
	public String getRSAEncode(String data, int index, Charset charset) {
		try {
			// 공개키 이용 암호화
			return getRSAEncode(data, getRSAPublicKey(index), charset);
		} catch (Exception e) {
			log.error("RSA Secure Encode Error PublicKey index[{}]. error mesage[{}] :{}", index, e.getMessage(), e);
		}
		return null;
	}
	public String getRSAEncode(String data, Cipher cipher) {
		return getRSAEncode(data, cipher, Charset.defaultCharset());
	}
	public String getRSAEncode(String data, Cipher cipher, Charset charset) {
		try {
			// 공개키 이용 암호화
			byte[] bCipher = cipher.doFinal(data.getBytes(charset));
			String sCipherBase64 = Base64.encodeBase64String(bCipher);
			return sCipherBase64;
		} catch (IllegalBlockSizeException | BadPaddingException e) {
			log.error("RSA Secure Encode Error Cipher[{}]. error mesage[{}] :{}", cipher, e.getMessage(), e);
		}
		return null;
	}

	public String getRSADecode(String encData) {
		return getRSADecode(encData, 0);
	}
	public String getRSADecode(String encData, int index) {
		return getRSADecode(encData, index, Charset.defaultCharset());
	}
	public String getRSADecode(String encData, int index, Charset charset) {
		// 개인키 이용 복호화
		try {
			return getRSADecode(encData, getRSAPrivateCipher(index), charset);
		} catch (Exception e) {
			log.error("RSA Secure Decode Error PrivateKey index[{}]. error mesage[{}] :{}", index, e.getMessage(), e);
			e.printStackTrace();
		}
		return null;
	}
	public static String getRSADecode(String encData, Cipher cipher) {
		return getRSADecode(encData, cipher, Charset.defaultCharset());
	}
	public static String getRSADecode(String encData, DynamicKeyPairRSA dynamicKeyPairRSA) {
		return getRSADecode(encData, dynamicKeyPairRSA, Charset.defaultCharset());
	}
	public static String getRSADecode(String encData, DynamicKeyPairRSA dynamicKeyPairRSA, Charset charset) {
		return getRSADecode(encData, dynamicKeyPairRSA.getDecodeModeCipher(), charset);
	}
	
	public static String getRSADecode(String encData, Cipher cipher, Charset charset) {
		// 개인키 이용 복호화
		try {
			byte[] bCipher = Base64.decodeBase64(encData.getBytes());
			byte[] bPlain = cipher.doFinal(bCipher);
			return new String(bPlain, charset);
		} catch (IllegalBlockSizeException | BadPaddingException e) {
			log.error("RSA Secure Decode Error Cipher[{}]. error mesage[{}] :{}", cipher, e.getMessage(), e);
			e.printStackTrace();
		}
		return null;
	}

	public static String getRSADecode(String encData, String privateKeyStr) throws NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException, InvalidKeyException {
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		byte[] bPrivateKey = Base64.decodeBase64(privateKeyStr.getBytes());
		PrivateKey privateKey = null;
		PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bPrivateKey);
		privateKey = keyFactory.generatePrivate(privateKeySpec);
		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		return getRSADecode(encData, cipher);
	}

	public static DynamicKeyPairRSA getOneTimeRSA() throws NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException, InvalidKeyException {
		DynamicKeyPairRSA result = new DynamicKeyPairRSA();
		PublicKey publicKey = null;
		PrivateKey privateKey = null;
		SecureRandom secureRandom = new SecureRandom();
		KeyPairGenerator keyPairGenerator;
		keyPairGenerator = KeyPairGenerator.getInstance("RSA");
		keyPairGenerator.initialize(2048, secureRandom);
		KeyPair keyPair = keyPairGenerator.genKeyPair();
		KeyFactory keyFactory1 = KeyFactory.getInstance("RSA");
		publicKey = keyPair.getPublic();
		RSAPublicKeySpec rsaPublicKeySpec = keyFactory1.getKeySpec(publicKey, RSAPublicKeySpec.class);
		result.setPublicKeyModules( rsaPublicKeySpec.getModulus().toString(16));
		result.setPublicKeyExponent(rsaPublicKeySpec.getPublicExponent().toString(16));
		log.info("Public key[DynamicKeyMake] modulus : {}", result.getPublicKeyModules());
		log.info("Public key[DynamicKeyMake] exponent: {}", result.getPublicKeyExponent());
		byte[] bPublicKey = publicKey.getEncoded();
		result.setPublicKey(Base64.encodeBase64String(bPublicKey));
		log.info("Public key[DynamicKeyMake] : {}", result.getPublicKey());

		privateKey = keyPair.getPrivate();
		RSAPrivateKeySpec rsaPrivateKeySpec = keyFactory1.getKeySpec(privateKey, RSAPrivateKeySpec.class);
		log.info("Private key[DynamicKeyMake] modulus : {}", rsaPrivateKeySpec.getModulus());
		log.info("Private key[DynamicKeyMake] exponent: {}", rsaPrivateKeySpec.getPrivateExponent());
		byte[] bPrivateKey = privateKey.getEncoded();
		String sPrivateKey  = Base64.encodeBase64String(bPrivateKey);
		result.setPrivateKey(sPrivateKey);

		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		result.setDecodeModeCipher(cipher);

		return result;
	}

	public static void initRsaSession(String useYn) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpSession session = request.getSession(false);
		DynamicKeyPairRSA dynamicKeyPairRSA = getOneTimeRSA();
		session.removeAttribute(RSA_DYNMIC_KEY);
		session.setAttribute(RSA_DYNMIC_KEY, dynamicKeyPairRSA.getPrivateKey());
		request.setAttribute("_RSAModules", dynamicKeyPairRSA.getPublicKeyModules());
		request.setAttribute("_RSAExponent", dynamicKeyPairRSA.getPublicKeyExponent());
		if(StringUtils.equalsIgnoreCase(useYn, "Y")) {
			request.setAttribute("_RSAUseYn", "Y");
		} else {
			request.setAttribute("_RSAUseYn", "N");
		}
	}

	public static String getRsaDecodeFromSession(String encStr, String useYn) throws Exception {
		if(StringUtils.equalsIgnoreCase(useYn, "Y")) {
			String privateKeyStr = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getSession(false).getAttribute(RSA_DYNMIC_KEY).toString();
			return decryptRsa(encStr, privateKeyStr);
		} else {
			return encStr;
		}
	}
//	public static UserInfoVo getRsaDecodeFromSession() throws Exception {
//		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
//		String username = request.getParameter("username");
//		return getRsaDecodeFromSession(username);
//	}
//
//	public static UserInfoVo getRsaDecodeFromSession(String username) throws Exception {
//		UserInfoVo user = new UserInfoVo();
//		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
//		String password = request.getParameter("password");
//		HttpSession session = request.getSession(false);
//		log.debug("RSA Decode for login session : userId[{}], password[{}], session[{}]", username, password, session);
//		String privateKeyStr = session.getAttribute(RSA_DYNMIC_KEY).toString();
//		
//		user.setUserId(decryptRsa(username, privateKeyStr));
//		user.setPassword(decryptRsa(password, privateKeyStr));
////		request.setAttribute("username", user.getUserId());
//		log.debug("RSA Decoded for loginInfo[{}], dynamicPrivateKey[{}]", user, privateKeyStr);
////		session.removeAttribute(RSA_DYNMIC_KEY);
//		return user;
//	}

	/**
	 * 복호화
	 * 
	 * @param privateKey
	 * @param securedValue
	 * @return
	 * @throws Exception
	 */
	private static String decryptRsa(String securedValue, String privateKeyStr) throws Exception {
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		byte[] bPrivateKey = Base64.decodeBase64(privateKeyStr.getBytes());
		PrivateKey privateKey = null;
		PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bPrivateKey);
		privateKey = keyFactory.generatePrivate(privateKeySpec);
		
		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		byte[] encryptedBytes = ComUtil.hexToByteArray(securedValue);
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
		String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
		return decryptedValue;
	}

}
