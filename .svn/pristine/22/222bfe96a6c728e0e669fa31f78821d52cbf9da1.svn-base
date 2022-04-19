package kr.co.itcall.jte.spring.config.security;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import jin.mes.common.menu.MenuInfoModel;
import jin.mes.common.menu.MyMenuVo;
import jin.mes.form.basMgt.authMgt.authInfo.AuthInfoModel;
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

	private List<String> roleGrpIds;

	private List<String> authInfoIds;

	private List<AuthInfoModel> authInfoModels;

	private List<MyMenuVo> myMenuVos;

	private MyMenuVo defMenu;

	private String isMoreInfos;
	
	private String sessionId;

}
