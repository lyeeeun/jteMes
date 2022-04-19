package kr.co.itcall.jte.spring.config.security.type;

public enum PermitStaticList {

	STATIC("/resources/**","STATIC접근(javascript, css, image 등")
	,FAVICON("/favicon.ico","파비콘 이미지 접근")
	,OTHER_PATH("/ATOS_MES/**", "고정static참조Resources")
	,REGISTRY("/registration","등록관련")
	,LOGIN_PS("/loginProcessAuto", "별도로그인 처리관련")
	,STATIC_RESOURCES("/static/**", "화면 라이브러리")
	;

	String uri;
	String desc;
	private PermitStaticList(String uri, String desc) {
		this.uri = uri;
		this.desc = desc;
	}
	public static String[] toArray() {
		String[] result = new String[values().length];
		for (int i = 0; i < result.length; i++) {
			result[i] = values()[i].uri;
		}
		return result;
	}

}
