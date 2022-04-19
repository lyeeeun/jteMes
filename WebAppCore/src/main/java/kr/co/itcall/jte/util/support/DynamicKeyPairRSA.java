package kr.co.itcall.jte.util.support;

import javax.crypto.Cipher;

import lombok.Data;

@Data
public class DynamicKeyPairRSA{
	Cipher decodeModeCipher;
	String privateKey;
	String publicKey;
	String publicKeyModules;
	String publicKeyExponent;
}
