package jin.mes.cform.basMgt.userMgt.userInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.userMgt.userAuth.ZinixUserAuthDto;
import jin.mes.cform.basMgt.userMgt.userInfo.ZinixUserInfoDto;

@Mapper
public interface ZinixUserInfoMapper {

	public List<ZinixUserInfoDto> selectUserList(ZinixUserInfoDto userInfo);
	
	public int selectUserListCount(ZinixUserInfoDto userInfo);
	
	public List<ZinixUserAuthDto> selectUserRoleList(ZinixUserAuthDto userAuthInfo);
	
	public int insertUserInfo(ZinixUserInfoDto userInfo);
	
	public int updateUserInfo(ZinixUserInfoDto userInfo);
	
	public int insertUserRole(ZinixUserInfoDto userInfo);
	
	public int deleteUserRole(ZinixUserInfoDto userInfo);
	
}
