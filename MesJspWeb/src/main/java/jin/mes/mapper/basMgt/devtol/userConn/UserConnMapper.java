package jin.mes.mapper.basMgt.devtol.userConn;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.devtol.userConn.UserConnDto;

@Mapper
public interface UserConnMapper {

	public List<UserConnDto> selectUserConnList(UserConnDto userConn);
	
	public int selectUserConnCount(UserConnDto userConn);
	
	public void insertUserConn(UserConnDto userConn);
	
	public void updateUserConn(UserConnDto userConn);
}
