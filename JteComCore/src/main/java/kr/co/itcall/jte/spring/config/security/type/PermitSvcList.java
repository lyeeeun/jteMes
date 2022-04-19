package kr.co.itcall.jte.spring.config.security.type;

public enum PermitSvcList {

	LOGIN("/login.do", "")
	,BIZ_SVC("/CM/CM_pcCam.do", "")
	,UPLOAD( "/upload/*", "")
	,COMMON_ALL( "/common/**", "모든 공통항목 접근은 허가한다.")
	,STATIC_ALL("/static/**", "모든 고정항목 접근은 허가한다.")
	,OTHER_PATH("/ATOS_MES/**", "고정static참조Resources")
	,OTHER_PATH2("/resources/**", "고정static참조Resources")
	,REGISTRY("/attach/**","등록관련")
	,LOGIN_PS("/loginProcessAuto", "별도로그인 처리관련")
	,LOGIN2("/login", "별도로그인 처리관련")
	,PROFILE("/profile", "별도로그인 처리관련")
	;

	String uri;
	String desc;
	private PermitSvcList(String uri, String desc) {
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
