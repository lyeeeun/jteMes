package kr.co.itcall.jte.util.support;

public enum ChannelKeyKindCd {

	SVC_CONT_ID("svcContId"),
	SVC_CONT_NO("svcContNo"),
	CONT_ID("ContId"),
	CONT_NO("ContNo"),
	SA_ID("saId"),
	CONT__NO("CONT_NO")
	;
	
	private String value;

	private ChannelKeyKindCd(final String value){
		this.value = value;
	}
	
	public static ChannelKeyKindCd findValue(final String v) {
		ChannelKeyKindCd find = null;
		for(ChannelKeyKindCd val: values()) {
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
