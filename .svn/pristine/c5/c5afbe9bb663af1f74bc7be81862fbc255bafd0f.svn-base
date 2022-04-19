package kr.co.itcall.jte.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

/**
 * 대칭형 양방향 암복호화 Util.
 * 암호방식과 복호방식 두가지가 가능하며, 단일한 키를 사용함.
 * 암호화 복호화가 제공되고, 속도는 빠르나 키에 대한 보안이 약함.(노출되면 끝?)
 * Properties암복호화 등에 쓰인다.
 * @author haeng
 *
 */
@Slf4j
@Component(value="secureAesCripto")
public class SecureAesCripto /* implements StringEncryptor */ {

	private static final String DEF_AES_ENC_KEY = "..rnlgo12JinTechEng@EncriptorKey.s";

	/**
	 * -Daes.enc.pwd=passwordKey from runTime.
	 */
	@Value("${aes.enc.pwd:"+DEF_AES_ENC_KEY+"}")
	// private String key = "jte@EncriptQ$^Keys#$%08810/95210";
	private String key;

	//@Override
	public String encode(String rawData) throws Exception {
		// return aesEncode((String) rawPassword);
		return encrypt(rawData, this.key);
	}

	//@Override
	public boolean matches(String rawPassword, String encodedPassword) throws Exception {
		if (encodedPassword == null || encodedPassword.length() == 0) {
			log.warn("Empty encoded password");
			return false;
		}
		return encrypt(rawPassword).equals(encodedPassword); // 단방향인 경우는 복호화 하지 않고 암호화 하여 비교한다. (여기서는 양방향을 썼지만...)
	}

	// 암호화
	public String encrypt(String message) throws Exception {
		// return aesEncode(message);
		return encrypt(message, this.key);
	}

	// 복호화
	public String decrypt(String encryptedMessage) throws Exception {
		// return aesDecode(encryptedMessage);
		return decrypt(encryptedMessage, this.key);
	}

//	// 암호화
//	private String aesEncode(String str) {
//		Cipher c;
//		String enStr = null;
//		try {
//			c = Cipher.getInstance("AES/CBC/PKCS5Padding");
//			c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
//
//			byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
//			enStr = new String(Base64.encodeBase64(encrypted));
//		} catch (Exception e) {
//			throw new SystemException(e.getMessage());
//		}
//
//		return enStr;
//	}
//
//	// 복호화
//	private String aesDecode(String str) {
//		byte[] byteStr = null;
//		Cipher c = null;
//		String result = null;
//		try {
//			c = Cipher.getInstance("AES/CBC/PKCS5Padding");
//			c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes("UTF-8")));
//
//			byteStr = Base64.decodeBase64(str.getBytes());
//			result = new String(c.doFinal(byteStr), "UTF-8");
//		} catch (Exception e) {
//			throw new SystemException(e.getMessage());
//		}
//
//		return result;
//	}

	public String encrypt(String plain, String key) throws Exception {
		byte[] clean = plain.getBytes("UTF-8");

		int ivSize = 16;
		byte[] iv = new byte[ivSize];
		SecureRandom random = new SecureRandom();
		random.nextBytes(iv);
		IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);

		MessageDigest digest = MessageDigest.getInstance("SHA-256");
		digest.update(key.getBytes("UTF-8"));
		byte[] keyBytes = new byte[16];
		System.arraycopy(digest.digest(), 0, keyBytes, 0, keyBytes.length);
		SecretKeySpec secretKeySpec = new SecretKeySpec(keyBytes, "AES");

		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);
		byte[] encrypted = cipher.doFinal(clean);

		byte[] encryptedIVAndText = new byte[ivSize + encrypted.length];
		System.arraycopy(iv, 0, encryptedIVAndText, 0, ivSize);
		System.arraycopy(encrypted, 0, encryptedIVAndText, ivSize, encrypted.length);

		return new String(Base64.encodeBase64(encryptedIVAndText));
		// return new String(encryptedIVAndText, "UTF-8");
	}

	public String decrypt(String encData, String key) throws Exception {
		int ivSize = 16;
		int keySize = 16;

		byte[] encryptedIvTextBytes = Base64.decodeBase64(encData.getBytes());
		byte[] iv = new byte[ivSize];
		System.arraycopy(encryptedIvTextBytes, 0, iv, 0, iv.length);
		IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);

		int encryptedSize = encryptedIvTextBytes.length - ivSize;
		byte[] encryptedBytes = new byte[encryptedSize];
		System.arraycopy(encryptedIvTextBytes, ivSize, encryptedBytes, 0, encryptedSize);

		byte[] keyBytes = new byte[keySize];
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(key.getBytes());
		System.arraycopy(md.digest(), 0, keyBytes, 0, keyBytes.length);
		SecretKeySpec secretKeySpec = new SecretKeySpec(keyBytes, "AES");

		Cipher cipherDecrypt = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipherDecrypt.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);
		byte[] decrypted = cipherDecrypt.doFinal(encryptedBytes);

		return new String(decrypted, "UTF-8");
	}

	public static void main(String[] args) throws Throwable {
		/*
		 * SecureAesCripto aes256 = new SecureAesCripto(); String text =
		 * "BizNaru_Ld@pUser!"; String encText = aes256.aesEncode(text); String decText
		 * = aes256.aesDecode(encText); System.out.println("암호화할 문자 : " + text);
		 * System.out.println("암호화된 문자 : " + encText); System.out.println("복호화된 문자 : " +
		 * decText);
		 */
		SecureAesCripto aes256 = new SecureAesCripto();
		aes256.key = "..rnlgo12JinTechEng@EncriptorKey.s";
		String propKey = "!^w^!_dlrnlgoddlaksemfek_!^w^!";
		System.out.println(aes256.encrypt(propKey));

		String text = "mymijung@gmail.com";
		String encText = aes256.encrypt(text);
		// String decText = aes256.aesDecode(encText);

		System.out.println("암호화할 문자 : " + text);
		System.out.println("암호화된 문자 : " + encText);
		String encoder = URLEncoder.encode(encText, "UTF-8");
		System.out.println("암호화된 문자 인코딩: " + URLEncoder.encode(encText, "UTF-8"));
		System.out.println("복호화된 문자 디코딩: " + URLDecoder.decode(encoder, "UTF-8"));

		String testKey = "jte1234!";
		log.info("암호화 : [{}] >>> [{}]", testKey, aes256.encrypt(testKey));
		testKey = "테스트AAA";
		log.info("암호화 : [{}] >>> [{}]", testKey, aes256.encrypt(testKey));
		testKey = "테스트b";
		log.info("암호화 : [{}] >>> [{}]", testKey, aes256.encrypt(testKey));
		testKey = "테스트C";
		log.info("암호화 : [{}] >>> [{}]", testKey, aes256.encrypt(testKey));
		testKey = "테D";
		log.info("암호화 : [{}] >>> [{}]", testKey, aes256.encrypt(testKey));

		encText = "Wq9j+k0TfO7ixSvuM1z8rIaS9ibHMcc/jGeRyJ1rhTs=";
		System.out.println(aes256.decrypt(encText));
		encText = "u9t67umjfRgCijcxB/WSPEwN+xC868cHqImLdKInpgY="; // 
		System.out.println(aes256.decrypt(encText));
//		encText = "xdjV+MaHMj+YnREOPb9FJeJalORnSPEbNRmsy3kPNl0=";
//		System.out.println(aes256.aesDecode(encText));
	}



}
