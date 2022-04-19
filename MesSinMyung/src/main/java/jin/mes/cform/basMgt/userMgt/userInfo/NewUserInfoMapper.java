package jin.mes.cform.basMgt.userMgt.userInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.userMgt.userAuth.NewUserAuthDto;

@Mapper
public interface NewUserInfoMapper {

	public List<NewUserInfoDto> selectUserList(NewUserInfoDto userInfo);
	
	public int selectUserListCount(NewUserInfoDto userInfo);
	
	public List<NewUserAuthDto> selectUserRoleList(NewUserAuthDto userAuthInfo);
	
	public int insertUserInfo(NewUserInfoDto userInfo);
	
	public int updateUserInfo(NewUserInfoDto userInfo);
	
	public int insertUserRole(NewUserInfoDto userInfo);
	
	public int deleteUserRole(NewUserInfoDto userInfo);
	
}
