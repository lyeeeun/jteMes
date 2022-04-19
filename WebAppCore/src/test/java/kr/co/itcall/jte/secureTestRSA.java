package kr.co.itcall.jte;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
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

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.commons.codec.binary.Base64;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class secureTestRSA {

	private PublicKey publicKey;
	private PrivateKey privateKey;

	@Test
	public void testMakeAndFileSaveRSA(){
		log.info("Server Start-----------------------------------");
		// 서버측 키 파일 생성 하기

		SecureRandom secureRandom = new SecureRandom();
		KeyPairGenerator keyPairGenerator;
		try {
			keyPairGenerator = KeyPairGenerator.getInstance("RSA");
			keyPairGenerator.initialize(2048, secureRandom);

			for (int i = 0; i < 10; i++) {
				KeyPair keyPair = keyPairGenerator.genKeyPair();
				KeyFactory keyFactory1 = KeyFactory.getInstance("RSA");

				String publicKeyStr = "PublicKey" + (i+1) + ".txt";
				publicKey = keyPair.getPublic();
				RSAPublicKeySpec rsaPublicKeySpec = keyFactory1.getKeySpec(publicKey, RSAPublicKeySpec.class);
				log.info("Public key[{}] modulus : {}", publicKeyStr, rsaPublicKeySpec.getModulus());
				log.info("Public key[{}] exponent: {}", publicKeyStr, rsaPublicKeySpec.getPublicExponent());

				byte[] bPublicKey1 = publicKey.getEncoded();
				String sPublicKey1 = Base64.encodeBase64String(bPublicKey1);
				log.info(String.format("app.secure.rsa.public.key%02d=%s", i+1, sPublicKey1));

				try {
					BufferedWriter bw1 = new BufferedWriter(new FileWriter(publicKeyStr));
					bw1.write(sPublicKey1);
					bw1.newLine();
					bw1.close();
				} catch (IOException e) {
					e.printStackTrace();
				}



				String PrivateKeyStr = "PrivateKey" + (i+1) + ".txt";
				privateKey = keyPair.getPrivate();
				RSAPrivateKeySpec rsaPrivateKeySpec = keyFactory1.getKeySpec(privateKey, RSAPrivateKeySpec.class);
				log.info("Private key modulus : {}", rsaPrivateKeySpec.getModulus());
				log.info("Private key exponent: {}", rsaPrivateKeySpec.getPrivateExponent());

				byte[] bPrivateKey1 = privateKey.getEncoded();
				String sPrivateKey1 = Base64.encodeBase64String(bPrivateKey1);
				log.info(String.format("app.secure.rsa.private.key%02d=%s", i+1, sPrivateKey1));

				try {
					BufferedWriter bw2 = new BufferedWriter(new FileWriter(PrivateKeyStr));
					bw2.write(sPrivateKey1);
					bw2.newLine();
					bw2.close();
				}catch (IOException e) {
					e.printStackTrace();
				}


				log.info("=====================================================================");
				log.info("=====================================================================\n");
			}


		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}
	}



	@Test
	public void testUsingRSA_FromReadFileKey() {
		// 클라이언트측 키 파일 로딩
		log.info("Client Start-----------------------------------");
		String sPublicKey2 = null;
		String sPrivateKey2 = null;

		BufferedReader brPublicKey = null;
		BufferedReader brPrivateKey = null;
		try {
			brPublicKey = new BufferedReader(new FileReader("PublicKey1.txt"));
			sPublicKey2 = brPublicKey.readLine(); // First Line Read
			brPrivateKey = new BufferedReader(new FileReader("PrivateKey1.txt"));
			sPrivateKey2 = brPrivateKey.readLine(); // First Line Read
			log.info("Pubilc Key & Private Key Read");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (brPublicKey != null)
					brPublicKey.close();
				if (brPrivateKey != null)
					brPrivateKey.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		byte[] bPublicKey2 = Base64.decodeBase64(sPublicKey2.getBytes());
		PublicKey publicKey2 = null;

		byte[] bPrivateKey2 = Base64.decodeBase64(sPrivateKey2.getBytes());
		PrivateKey privateKey2 = null;

		try {
			KeyFactory keyFactory2 = KeyFactory.getInstance("RSA");

			X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(bPublicKey2);
			publicKey2 = keyFactory2.generatePublic(publicKeySpec);

			PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bPrivateKey2);
			privateKey2 = keyFactory2.generatePrivate(privateKeySpec);

		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}

		String sPlain1 = "Welcome to RSA암복호화테스트!";
		String sPlain2 = null;

		try {
			Cipher cipher = Cipher.getInstance("RSA");

			// 공개키 이용 암호화
			cipher.init(Cipher.ENCRYPT_MODE, publicKey2);
			byte[] bCipher1 = cipher.doFinal(sPlain1.getBytes());
			String sCipherBase64 = Base64.encodeBase64String(bCipher1);
			log.info("암호화 : [{}] => [{}]", sPlain1, sCipherBase64);

			// 개인키 이용 복호화
			cipher.init(Cipher.DECRYPT_MODE, privateKey2);
			byte[] bCipher2 = Base64.decodeBase64(sCipherBase64.getBytes());
			byte[] bPlain2 = cipher.doFinal(bCipher2);
			sPlain2 = new String(bPlain2);
			log.info("복호화 : [{}] => [{}]", sCipherBase64, sPlain2);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}

		log.info("sPlain1 : [{}]", sPlain1); // 평문(원본)
		log.info("sPlain2 : [{}]", sPlain2); // 평문(암호화후 복호화된 평문)
	}

}
