package kr.co.itcall.jte.spring.config.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserSessionInfoVo extends User {

	private static final long serialVersionUID = -5120447647802146699L;

	public UserSessionInfoVo(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
	}

	private UserInfoVo userInfo;

	private String isMoreInfos;

}
