package kr.co.itcall.jte.util;

import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import kr.co.itcall.jte.util.support.PasswdKeyKindCd;

/**
 * 
 * @author 유영상
 * 일단 시간이 없으니 String으로만처리한다.
 * 
 *
 */

//@Component("biznaruMaskingUtil")
public class MaskingPayload {
	/*@Value("#{common['common.mask.field.list']}")
	private List<String> fieldNames;*/
	
	/*public void appplyMasking(){
		
	}*/

	private static final Logger LOG = LoggerFactory.getLogger(MaskingPayload.class);

	public static String getMaskedEmail(String email) {
		String regex = "\\b(\\S+)+@(\\S+.\\S+)";
		Matcher matcher = Pattern.compile(regex).matcher(email);
	      
		if (matcher.find()) {
			String id = matcher.group(1); // 마스킹 처리할 부분인 userId
			int length = id.length();
	         
			if (length < 3) {
	            char[] c = new char[length];
	            Arrays.fill(c, '*');
	            return email.replace(id, String.valueOf(c));
	        } else if (length == 3) {
	            return email.replaceAll("\\b(\\S+)[^@][^@]+@(\\S+)", "$1**@$2");
	        } else {
	            return email.replaceAll("\\b(\\S+)[^@][^@][^@]+@(\\S+)", "$1***@$2");
	        }
		}
		return email;
	}
	
	public static String getMaskedPhoneNum(String param) {
		String phoneNum = param;
		
		
		if(phoneNum != null){
			 if(phoneNum.length()>2 && (phoneNum.substring(0, 2)).equals("02") ){
				 if(phoneNum.length() == 10){
					 String first = phoneNum.substring(0, 2);
					 String second = phoneNum.substring(2, 6);
					 String third = phoneNum.substring(6, 10);
					 phoneNum = first+ "-"+second +"-" + third;
				 }else  if(phoneNum.length() == 9){
					 String first = phoneNum.substring(0, 2);
					 String second = phoneNum.substring(2, 5);
					 String third = phoneNum.substring(5, 9);
					 phoneNum = first+ "-"+second +"-" + third;
				 }			 			 
			 }else{
				 if(phoneNum.length() == 11){
					 String first = phoneNum.substring(0, 3);
					 String second = phoneNum.substring(3, 7);
					 String third = phoneNum.substring(7, 11);
					 phoneNum = first+ "-"+second +"-" + third;
				 }else  if(phoneNum.length() == 10){
					 String first = phoneNum.substring(0, 3);
					 String second = phoneNum.substring(3, 6);
					 String third = phoneNum.substring(6, 10);
					 phoneNum = first+ "-"+second +"-" + third;
				 }
			 }
		}		
		
		StringBuilder sb = new StringBuilder();
		String result = phoneNum;
		String regex = "(02|0[13456][0-9])-(\\d{3,4})-(\\d{4})$";
		//String regex = "(01[016789])-(\\d{3,4})-(\\d{4})$";
		//^01(?:01[6-9]) - (?:\d{3}\d{4}) - \d{4}$ 

	    Matcher matcher = Pattern.compile(regex).matcher(result);
	      
	    if (matcher.find()) {
	    	String number	= matcher.group(1);
	    	String number1 	= matcher.group(2);
	    	String number2 	= matcher.group(3);
	    	if(number1.length() == 4){
	    		number1 = number1.substring(0, 2) + "**";
	    	}else if(number1.length() == 3){
	    		number1 = number1.substring(0, 1) + "**";
	    	}
	    	
	    	//result = result.replaceFirst(matcher.group(2), number1);
	    	
	    	number2 = "*"  + number2.substring(1);
	    	
	    	//return result.replace(matcher.group(3), number2);
	    	
	    	return sb.append(number).append("-").append(number1).append("-").append(number2).toString();
	    }
	      
	    return result;
	}
	
    public static String getMaskedName(String name){
    	
    	if(!StringUtils.isEmpty(name)){
    		int length = name.length();
    		
    		return name.substring(0, length-1) +"*";
    		

        }
    	
/*        if(!StringUtils.isEmpty(name)){
            if(name.length() > 3){
                return name.substring(0, 3) + "*";
            }else if(name.length() == 3){
                return name.substring(0, 2) + "*";
            }else if(name.length() == 2){
                return name.substring(0, 1) + "*";
            }else{
                return name;
            }
        }*/
        
        return name;
    }
	
	public static String getMaskedAddress(String address){
		StringBuilder sb = new StringBuilder();
		
		if(!StringUtils.isEmpty(address)){
			String[] arrayAddress = address.split(" ");
			
			if(arrayAddress.length > 3){
				arrayAddress[3] = "***";
				return sb.append(arrayAddress[0])
						.append(" ")
						.append(arrayAddress[1])
						.append(" ")
						.append(arrayAddress[2])
						.append(" ")
						.append(arrayAddress[3]).toString();
			}
			
			return address;
		}
		
		return address;
	}
	
	
	public static String getMaskedId(String id){
		if(!StringUtils.isEmpty(id)){
			if(id.length() > 3){
				return id.substring(0, id.length()-3) + "***";
			}else{
				return id.substring(0, 1) + "***";
			}
		}
		
		return id;
	}
	 
    public static String getMaskeIpAddress(String ipAddress){
        String[] arrayIpAddress = ipAddress.split("\\.");
        StringBuffer returnIpaddress = new StringBuffer();
        int count = 0;
        if(arrayIpAddress.length == 4){
            for(String temp : arrayIpAddress){
                if(count == 0 || count == 2){
                    StringBuffer tempIpaddress = new StringBuffer();
                    arrayIpAddress[count] = "";
                    for(int len=0;len<temp.length();len++){
                        tempIpaddress.append("*"); 
                    }
                    arrayIpAddress[count] = tempIpaddress.toString();
                }
                count++;
            }
            returnIpaddress.append(arrayIpAddress[0])
                            .append(".")
                            .append(arrayIpAddress[1])
                            .append(".")
                            .append(arrayIpAddress[2])
                            .append(".")
                            .append(arrayIpAddress[3]);
        }
        return returnIpaddress.toString();
    }
    
    /*public static void main(String[] args) throws Exception{
		System.out.println(MaskingPayload.getMaskedPhoneNum("010-1234-1211"));
		//System.out.println(MaskingPayload.getMaskedPhoneNum("010-3333-3333"));
		//System.out.println(MaskingPayload.getMaskedPhoneNum("02-4234-1211"));
		//System.out.println(MaskingPayload.getMaskedPhoneNum("02-234-1211"));
		//System.out.println(MaskingPayload.getMaskedPhoneNum("000-4234-1211"));
		//System.out.println(MaskingPayload.getMaskedPhoneNum("051-434-1211"));
		//System.out.println(MaskingPayload.getMaskedEmail("squall7209@naver.com"));
		
		//System.out.println(MaskingPayload.getMaskedName("홍길동"));
		//System.out.println(MaskingPayload.getMaskedAddress("서울특별시 송파구 한가람로20길 44(풍납동)"));		
	}*/
	
	/**
	 * 로그 문자열에 대한 숫자패턴에 대해서만 마스킹 함.
	 * 2018-11-02 : 요청에 의해 4-2-4 패턴에서 3-2-3 패턴으로 변경함. (가운데 값은 열고 양옆값은 마스킹함 - 이외는 열림. - 최대 12자 이내.)
	 * @param log
	 * @return
	 */
	public static String getLogMask(String log){
		if(log==null)return log;
		String maskLog = getLogMaskNumber(log);
//		maskLog = getLogMaskCode(maskLog);
		return getLogMaskHangle(maskLog);
//		if(log==null)return log;
//		String maskingStr = "***";
//		String swapTgtStr = "[A-Za-zㄱ-ㅎ가-힣]{"+maskingStr.length()+","+maskingStr.length()+"}"; // "[0-9]{3,3}"
//		int swapGap = 2;
//		Matcher matcher = Pattern.compile("[A-Za-zㄱ-ㅎ가-힣]{8,12}").matcher(log); // 숫자 + 하이픈(-) + 알파벳대소문자 + 스페이스( ) + 한글
//		StringBuilder sb = new StringBuilder();
//		int index = 0;
//		for (int i = 0; matcher.find(i); i = matcher.end()) {
//			sb.append(log.substring(index, matcher.start()));
//			String swapStr = log.substring(matcher.start(), index = matcher.end());
//			swapStr = Pattern.compile(swapTgtStr).matcher(swapStr).replaceFirst(maskingStr);
//			sb.append(swapStr.substring(0, maskingStr.length()+swapGap));
//			swapStr = Pattern.compile(swapTgtStr).matcher(swapStr.substring(maskingStr.length()+swapGap)).replaceFirst(maskingStr);
//			sb.append(swapStr);
//			// System.out.println(log.substring(matcher.start(), matcher.end()));
//		}
//		return sb.append(log.substring(index, log.length())).toString();
	}
	public static String getLogMaskNumber(String log) {
		if(log==null)return log;
		String maskingStr = "***";
		String swapTgtStr = "[-0-9]{"+maskingStr.length()+","+maskingStr.length()+"}"; // "[0-9]{3,3}"
		int swapGap = 2;
		Matcher matcher = Pattern.compile("[-0-9]{8,12}").matcher(log); // 숫자 + 하이픈(-)
//		Matcher matcher = Pattern.compile("[-0-9A-Za-z]{8,12}").matcher(log); // 숫자 + 하이픈(-) + 알파벳대소문자
//		Matcher matcher = Pattern.compile("[ -0-9A-Za-zㄱ-ㅎ가-힣]{8,12}").matcher(log); // 숫자 + 하이픈(-) + 알파벳대소문자 + 스페이스( ) + 한글
		StringBuilder sb = new StringBuilder();
		int index = 0;
		for (int i = 0; matcher.find(i); i = matcher.end()) {
			sb.append(log.substring(index, matcher.start()));
			String swapStr = log.substring(matcher.start(), index = matcher.end());
			swapStr = Pattern.compile(swapTgtStr).matcher(swapStr).replaceFirst(maskingStr);
			sb.append(swapStr.substring(0, maskingStr.length()+swapGap));
			swapStr = Pattern.compile(swapTgtStr).matcher(swapStr.substring(maskingStr.length()+swapGap)).replaceFirst(maskingStr);
			sb.append(swapStr);
			// System.out.println(log.substring(matcher.start(), matcher.end()));
		}
		return sb.append(log.substring(index, log.length())).toString();
	}
	public static String getLogMaskCode(String log) {
		if(log==null)return log;
		String maskingStr = "***";
		String swapTgtStr = "[-0-9A-Za-z]{"+maskingStr.length()+","+maskingStr.length()+"}"; // "[0-9]{3,3}"
		int swapGap = 2;
//		Matcher matcher = Pattern.compile("[-0-9]{8,12}").matcher(log); // 숫자 + 하이픈(-)
		Matcher matcher = Pattern.compile("[-0-9A-Za-z]{8,12}").matcher(log); // 숫자 + 하이픈(-) + 알파벳대소문자
//		Matcher matcher = Pattern.compile("[ -0-9A-Za-zㄱ-ㅎ가-힣]{8,12}").matcher(log); // 숫자 + 하이픈(-) + 알파벳대소문자 + 스페이스( ) + 한글
		StringBuilder sb = new StringBuilder();
		int index = 0;
		for (int i = 0; matcher.find(i); i = matcher.end()) {
			sb.append(log.substring(index, matcher.start()));
			String swapStr = log.substring(matcher.start(), index = matcher.end());
			swapStr = Pattern.compile(swapTgtStr).matcher(swapStr).replaceFirst(maskingStr);
			sb.append(swapStr.substring(0, maskingStr.length()+swapGap));
			swapStr = Pattern.compile(swapTgtStr).matcher(swapStr.substring(maskingStr.length()+swapGap)).replaceFirst(maskingStr);
			sb.append(swapStr);
			// System.out.println(log.substring(matcher.start(), matcher.end()));
		}
		return sb.append(log.substring(index, log.length())).toString();
	}
	public static String getLogMaskHangle(String log) {
		if(log==null)return log;
		String maskingStr = "***";
		String swapTgtStr = "[ㄱ-ㅎ가-힣]{"+maskingStr.length()+","+maskingStr.length()+"}"; // "[0-9]{3,3}"
		int swapGap = 2;
//		Matcher matcher = Pattern.compile("[-0-9]{8,12}").matcher(log); // 숫자 + 하이픈(-)
//		Matcher matcher = Pattern.compile("[-0-9A-Za-z]{8,12}").matcher(log); // 숫자 + 하이픈(-) + 알파벳대소문자
		Matcher matcher = Pattern.compile("[ㄱ-ㅎ가-힣]{8,12}").matcher(log); // 숫자 + 하이픈(-) + 알파벳대소문자 + 스페이스( ) + 한글
		StringBuilder sb = new StringBuilder();
		int index = 0;
		for (int i = 0; matcher.find(i); i = matcher.end()) {
			sb.append(log.substring(index, matcher.start()));
			String swapStr = log.substring(matcher.start(), index = matcher.end());
			swapStr = Pattern.compile(swapTgtStr).matcher(swapStr).replaceFirst(maskingStr);
			sb.append(swapStr.substring(0, maskingStr.length()+swapGap));
			swapStr = Pattern.compile(swapTgtStr).matcher(swapStr.substring(maskingStr.length()+swapGap)).replaceFirst(maskingStr);
			sb.append(swapStr);
			// System.out.println(log.substring(matcher.start(), matcher.end()));
		}
		return sb.append(log.substring(index, log.length())).toString();
	}

	public static String maskPwdJson(String payload, String pwdName) {
		if(StringUtils.isEmpty(payload)) return "";
//		String pwdName = "pwd";
//		String payload = "12345678-\"pwd \":\"	sedb\"-234567898++\"pwd\":\"seeedb	\"-234567898";

		StringBuilder regexJson = new StringBuilder();
		regexJson.append("\"[ |\t]*").append(pwdName).append("[ |\t]*\"[ |\t]*:[ |\t]*\"[^\"]*\"");
		String regex = regexJson.toString();
		String subRegex = "\"[ |\t]*:[ |\t]*\""; 
		Matcher matcher = Pattern.compile(regex).matcher(payload);

		StringBuilder sb = new StringBuilder();
		int index = 0;
		boolean find = false;
		for (int i = 0; matcher.find(i); i = matcher.end()) {
			find = true;
			sb.append(payload.substring(index, matcher.start()));
			String swapStr = payload.substring(matcher.start(), index = matcher.end());
			Matcher subMatcher = Pattern.compile(subRegex).matcher(swapStr);
			if(subMatcher.find()) {
				sb.append(swapStr.substring(0, subMatcher.end()));
				swapStr = swapStr.substring(subMatcher.end(), swapStr.length() - 1);
				for(int count = 0; count < swapStr.length(); count++) {
					sb.append("*");
				}
				sb.append("\"");
			} else {
				sb.append(swapStr);
			}
//			LOG.debug("maskPwdJson step:::swapStr={},sb={}",swapStr, sb.toString());
		}
		if(!find) {
			sb.append(payload);
		}
//		LOG.debug("maskPwdJson org payload={}", payload);
//		LOG.debug("maskPwdJson new payload={}", sb.append(payload.substring(index, payload.length())).toString());
		
		return sb.toString();
	}
	
	public static String maskPwdXMLNotUsed(String payload, String pwdName) {
		if(StringUtils.isEmpty(payload)) return "";
//		String pwdName = "userPwd";
//		String payload = "123--45678-<userPwd   >	sedb</userPwd>-2345++67898++<userPwd>seeedb	</userPwd>-234567898";

		StringBuilder regexXML = new StringBuilder();
		regexXML.append("<[ |\t]*").append(pwdName).append("[^>]*>[^<]*<[ |\t]*/[ |\t]*").append(pwdName).append("[ |\t]*>");
		String regex = regexXML.toString();

		StringBuilder regexXMLPre = new StringBuilder();
		regexXMLPre.append("<[ |\t]*").append(pwdName).append("[^>]*>");
		String regexPre = regexXMLPre.toString();

		StringBuilder regexXMLPost = new StringBuilder();
		regexXMLPost.append("<[ |\t]*/[ |\t]*").append(pwdName).append("[ |\t]*>");
		String regexPost = regexXMLPost.toString();
		
		Matcher matcher = Pattern.compile(regex).matcher(payload);

		StringBuilder sb = new StringBuilder();
		int index = 0;
		boolean find = false;
		for (int i = 0; matcher.find(i); i = matcher.end()) {
			find = true;
			sb.append(payload.substring(index, matcher.start()));
			String swapStr = payload.substring(matcher.start(), index = matcher.end());

			Matcher preMatcher = Pattern.compile(regexPre).matcher(swapStr);
			Matcher postMatcher = Pattern.compile(regexPost).matcher(swapStr);
			if(preMatcher.find() && postMatcher.find()) {
				sb.append(swapStr.substring(0, preMatcher.end()));
				String passwd = swapStr.substring(preMatcher.end(), postMatcher.start());
				for(int count = 0; count < passwd.length(); count++) {
					sb.append("*");
				}
				sb.append(swapStr.substring(postMatcher.start(), postMatcher.end()));
			} else {
				sb.append(swapStr);
			}
//			LOG.debug("maskPwdXML step:::swapStr={},sb={}",swapStr, sb.toString());
		}
		if(!find) {
			sb.append(payload);
		}
//		LOG.debug("maskPwdXML org payload={}", payload);
//		LOG.debug("maskPwdXML new payload={}", sb.append(payload.substring(index, payload.length())).toString());
		
		return sb.toString();
	}

	public static String maskPwdXML(String payload, String pwdName) {
		if(StringUtils.isEmpty(payload)) return "";
//		String pwdName = "userPwd";
//		payload = "123--45678-<userPwd   >	sedb</userPwd>-2345++67898++<biz:userPwd>seeedb	</biz:userPwd>-234567898";

		StringBuilder regexXML = new StringBuilder();
		regexXML.append("<[ |\t]*").append("[^>]*").append("[^>]*>[^<]*<[ |\t]*/[ |\t]*").append("[^>]*").append("[ |\t]*>");
		String regex = regexXML.toString();

		StringBuilder regexXMLPre = new StringBuilder();
		regexXMLPre.append("<[ |\t]*").append("[^>]*").append("[^>]*>");
		String regexPre = regexXMLPre.toString();

		StringBuilder regexXMLPost = new StringBuilder();
		regexXMLPost.append("<[ |\t]*/[ |\t]*").append("[^>]*").append("[ |\t]*>");
		String regexPost = regexXMLPost.toString();
		
		Matcher matcher = Pattern.compile(regex).matcher(payload);

		StringBuilder sb = new StringBuilder();
		int index = 0;
		boolean find = false;
		for (int i = 0; matcher.find(i); i = matcher.end()) {
			find = true;
			sb.append(payload.substring(index, matcher.start()));
			String swapStr = payload.substring(matcher.start(), index = matcher.end());

			StringBuilder regexKeyBuilder = new StringBuilder();
			regexKeyBuilder.append("[ |\t|:|<]").append(pwdName).append("[ |\t|>]");
			String regexKey = regexKeyBuilder.toString();
			Matcher matcherKey = Pattern.compile(regexKey).matcher(swapStr);
			if(matcherKey.find()) {
				Matcher preMatcher = Pattern.compile(regexPre).matcher(swapStr);
				Matcher postMatcher = Pattern.compile(regexPost).matcher(swapStr);
				if(preMatcher.find() && postMatcher.find()) {
					if(((swapStr.substring(preMatcher.start(), preMatcher.end())).indexOf(pwdName) > 0) &&
						((swapStr.substring(postMatcher.start(), postMatcher.end())).indexOf(pwdName) > 0)) {	
						sb.append(swapStr.substring(0, preMatcher.end()));
						String passwd = swapStr.substring(preMatcher.end(), postMatcher.start());
						for(int count = 0; count < passwd.length(); count++) {
							sb.append("*");
						}
						sb.append(swapStr.substring(postMatcher.start(), postMatcher.end()));
						continue;
					}
				}
			}
			sb.append(swapStr);
//			LOG.debug("maskPwdXML step:::swapStr={},sb={}",swapStr, sb.toString());
		}
		if(!find) {
			sb.append(payload);
		}
//		LOG.debug("maskPwdXML org payload={}", payload);
//		LOG.debug("maskPwdXML new payload={}", sb.append(payload.substring(index, payload.length())).toString());
		
		return sb.toString();
	}
	
	public static String maskPwdXMLAttr(String payload, String pwdName) {
		if(StringUtils.isEmpty(payload)) return "";
//		String payload = "123--45678-<passwd userPwd=\"sdfg\"   >	sedb</passwd>-2345++67898++<pass userPwd = \"12345\">seeedb	</pass>-234567898";

		StringBuilder regexXML = new StringBuilder();
		regexXML.append("[ |\t]+").append(pwdName).append("[ |\t]*=[ |\t]*\"[^\"]*\"");
		String regex = regexXML.toString();

		StringBuilder regexXMLPre = new StringBuilder();
		regexXMLPre.append("[ |\t]+").append(pwdName).append("[ |\t]*=[ |\t]*\"");
		String regexPre = regexXMLPre.toString();
		
		Matcher matcher = Pattern.compile(regex).matcher(payload);

		StringBuilder sb = new StringBuilder();
		int index = 0;
		boolean find = false;
		for (int i = 0; matcher.find(i); i = matcher.end()) {
			find = true;
			sb.append(payload.substring(index, matcher.start()));
			String swapStr = payload.substring(matcher.start(), index = matcher.end());

			Matcher preMatcher = Pattern.compile(regexPre).matcher(swapStr);
			if(preMatcher.find()) {
				sb.append(swapStr.substring(0, preMatcher.end()));
				String passwd = swapStr.substring(preMatcher.end(), swapStr.length() - 1);
				for(int count = 0; count < passwd.length(); count++) {
					sb.append("*");
				}
				sb.append("\"");
			} else {
				sb.append(swapStr);
			}
//			LOG.debug("maskPwdXMLAttr step:::swapStr={},sb={}",swapStr, sb.toString());
		}
		if(!find) {
			sb.append(payload);
		}
//		LOG.debug("maskPwdXMLAttr org payload={}", payload);
//		LOG.debug("maskPwdXMLAttr new payload={}", sb.append(payload.substring(index, payload.length())).toString());
		
		return sb.toString();
	}
	
	public static String passwdMasking(String payload) {
		if(StringUtils.isEmpty(payload)) return "";
		String outPayload = payload;
		
		PasswdKeyKindCd passwdKeyKindCd[] = PasswdKeyKindCd.values();
		for (int i = 0; i < passwdKeyKindCd.length; i++) {
			String pwdStr = passwdKeyKindCd[i].value();
			outPayload = maskPwdJson(outPayload, pwdStr);
			outPayload = maskPwdXML(outPayload, pwdStr);
			outPayload = maskPwdXMLAttr(outPayload, pwdStr);
		}
		
		return outPayload;
	}
	
}
