package kr.co.itcall.jte.util.support;

public enum PasswdKeyKindCd {

	USER_PWD("userPwd"),
	LOGINPWD("loginPwd"),
	PASSWD("passwd"),
	PASSWORD("password")
	;
	
	private String value;

	private PasswdKeyKindCd(final String value){
		this.value = value;
	}
	
	public static PasswdKeyKindCd findValue(final String v) {
		PasswdKeyKindCd find = null;
		for(PasswdKeyKindCd val: values()) {
			if(v.equals(val.value())){
				find = val;
				break;
			}
		}
		return find;
	}
	
	public String value() {
		return value;
	}
}
