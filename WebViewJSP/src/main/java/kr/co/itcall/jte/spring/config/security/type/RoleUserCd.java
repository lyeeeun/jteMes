package kr.co.itcall.jte.spring.config.security.type;

import java.util.Arrays;

public enum RoleUserCd {

	ROLE_SOME_AUTH
	, ROLE_SOME_AUTH_WRITE
	;

	public static String[] getAllUserRoles() {
		String[] result = new String[values().length];
		int index=0;
		for (RoleUserCd role : values()) {
			result[index] = role.name();
			++index;
		}
		Arrays.sort(result);
		return result;
	}

}
