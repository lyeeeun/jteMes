package jin.mes.cform.basMgt.userMgt.userInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.userMgt.userAuth.NewUserAuthDto;
import jin.mes.cform.basMgt.userMgt.userInfo.NewUserInfoDto;

@Mapper
public interface NewUserInfoMapper {

	public List<NewUserInfoDto> selectUserList(NewUserInfoDto newUserInfo);
	
	public int selectUserListCount(NewUserInfoDto newUserInfo);
	
	public List<NewUserAuthDto> selectUserRoleList(NewUserAuthDto newUserAuthInfo);
	
	public int insertUserInfo(NewUserInfoDto newUserInfo);
	
	public int updateUserInfo(NewUserInfoDto newUserInfo);
	
	public int insertUserRole(NewUserInfoDto newUserInfo);
	
	public int deleteUserRole(NewUserInfoDto newUserInfo);
	
}
