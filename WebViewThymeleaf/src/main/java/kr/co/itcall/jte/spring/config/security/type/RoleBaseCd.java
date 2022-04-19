package kr.co.itcall.jte.spring.config.security.type;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import kr.co.itcall.jte.spring.user.model.RoleInfoVo;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public enum RoleBaseCd {

	ROLE_ROOT
	, ROLE_ADMIN
	, ROLE_MANAGER
	, ROLE_USER
	, ROLE_GUEST
	;
	
	public static String[] getAdminRoles() {
		return new String[] {ROLE_ROOT.name(), ROLE_ADMIN.name()};
	}

	public static String[] getRoles() {
		return new String[] {ROLE_ROOT.name(), ROLE_ADMIN.name(), ROLE_USER.name()};
	}

	public static String[] getSubUserRoles() {
		return RoleUserCd.getAllUserRoles();
	}

	public static String[] getAllRoles() {
		String[] result = new String[values().length + RoleUserCd.values().length];
		int index = 0;
		for (RoleBaseCd role : values()) {
			result[index] = role.name();
			++index;
		}
		for (RoleUserCd role : RoleUserCd.values()) {
			result[index] = role.name();
			++index;
		}
		Arrays.sort(result);
		return result;
	}

	public static boolean isExistRole(String role) {
		String[] roles = getAllRoles();
		log.info("find role[{}] in allRoles[{}]",role, roles);
		if(Arrays.binarySearch(roles, role)>=0)
			return true;
		return false;
	}

	/**
	 * Find addRoles from Allroles and returns only matches elements.
	 * @param addRoles
	 * @return Exists Role's elements
	 */
	public static Set<RoleInfoVo> getExistRoles(String[] addRoles) {
		Set<RoleInfoVo> result = new HashSet<RoleInfoVo>();
		String[] allRoles = getAllRoles();
		for (String role : addRoles) {
			if(Arrays.binarySearch(allRoles, role)<0) {
				log.warn("Do not found role[{}] in allRoles[{}].", role, allRoles);
				continue;
			}
			result.add(new RoleInfoVo(role));
		}
		return result;
	}

}
