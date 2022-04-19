package jin.mes.mapper.basMgt.userMgt.userInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.userMgt.userAuth.UserAuthDto;
import jin.mes.form.basMgt.userMgt.userInfo.UserInfoDto;

@Mapper
public interface UserInfoMapper {

	public List<UserInfoDto> selectUserList(UserInfoDto userInfo);
	
	public int selectUserListCount(UserInfoDto userInfo);
	
	public List<UserAuthDto> selectUserRoleList(UserAuthDto userAuthInfo);
	
	public int insertUserInfo(UserInfoDto userInfo);
	
	public int updateUserInfo(UserInfoDto userInfo);
	
	public int insertUserRole(UserInfoDto userInfo);
	
	public int deleteUserRole(UserInfoDto userInfo);
	
}
