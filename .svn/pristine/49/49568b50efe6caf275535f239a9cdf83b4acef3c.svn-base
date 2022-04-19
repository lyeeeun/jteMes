package kr.co.itcall.jte.security;

import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;

import org.apache.commons.codec.binary.Base64;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.co.itcall.jte.util.SecureAesCripto;
import kr.co.itcall.jte.util.SecureRsaCripto;



@Service
public class SecurityServiceImpl implements SecurityService {
	@Qualifier("secureAesCripto")
	@Autowired
	SecureAesCripto secureAesCripto;

	@Autowired
	SecureRsaCripto secureRsaCripto;
	
	private static final String JASYPT_ALGORITHM = "PBEWITHMD5ANDDES";
	private static final String JASYPT_KEY_CODE = "SlsvPpmFBZi9wBEGbZlpZJGO7HvvFoH9V/oyOa3R8B1QWKBLE7MqyHtXadNwO/JF";
	@Override
	public String GetData_Security_Enc(SecurityVO securityVO) throws Exception{
		return secureAesCripto.encrypt(securityVO.getSec_text(),securityVO.getSec_key());
	}
	@Override
	public String GetData_Security_Dec(SecurityVO securityVO) throws Exception {
		/*
		 * SecureAesCripto aes256 = new SecureAesCripto(); return aes256.decrypt(securityVO.getSec_text(),securityVO.getSec_key());
		 */
		return secureAesCripto.decrypt(securityVO.getSec_text(),securityVO.getSec_key());
	}
	@Override
	public String GetData_Jsaypt_Enc(SecurityVO securityVO) throws Exception{
		SecureAesCripto aes256 = new SecureAesCripto();
		String jasyptAlgorizm = aes256.decrypt(JASYPT_KEY_CODE,securityVO.getSec_key());
		
		StandardPBEStringEncryptor standardPBEStringEncryptor = new StandardPBEStringEncryptor();  
		standardPBEStringEncryptor.setAlgorithm(JASYPT_ALGORITHM);  
		standardPBEStringEncryptor.setPassword(jasyptAlgorizm);  
		return standardPBEStringEncryptor.encrypt(securityVO.getSec_text());  
	}
	
	@Override
	public String GetData_Jsaypt_Dec(SecurityVO securityVO) throws Exception{
		SecureAesCripto aes256 = new SecureAesCripto();
		String jasyptAlgorizm = aes256.decrypt(JASYPT_KEY_CODE,securityVO.getSec_key());
		
		StandardPBEStringEncryptor standardPBEStringEncryptor = new StandardPBEStringEncryptor();  
		standardPBEStringEncryptor.setAlgorithm(JASYPT_ALGORITHM);  
		standardPBEStringEncryptor.setPassword(jasyptAlgorizm);  
		return standardPBEStringEncryptor.decrypt(securityVO.getSec_text());  
	}
	@Override
	public String GetData_Rsa_Enc(SecurityVO securityVO) throws Exception {
		return secureRsaCripto.getRSAEncode(securityVO.getSec_text());
	}
	@Override
	public String GetData_Rsa_Dec(SecurityVO securityVO) throws Exception {
		return secureRsaCripto.getRSADecode(securityVO.getSec_text());
	}
	
	@Override
	public String GetData_RsaKey_Enc(SecurityVO securityVO) throws Exception {
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		byte[] bPublicKey = Base64.decodeBase64(securityVO.getSec_text().getBytes());
		PublicKey publicKey = null;
		X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(bPublicKey);
		publicKey = keyFactory.generatePublic(publicKeySpec);
		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.ENCRYPT_MODE, publicKey);
		return cipher.toString();
	}
	@Override
	public String GetData_RsaKey_Dec(SecurityVO securityVO) throws Exception {
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		byte[] bPrivateKey = Base64.decodeBase64(securityVO.getSec_text().getBytes());
		PrivateKey privateKey = null;
		PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bPrivateKey);
		privateKey = keyFactory.generatePrivate(privateKeySpec);
		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		return cipher.toString();
	}
	
}
