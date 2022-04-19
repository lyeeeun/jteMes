package jin.mes.cform.devtol.userConn;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.devtol.userConn.KwangjinUserConnDto;

@Mapper
public interface KwangjinUserConnMapper {

	public List<KwangjinUserConnDto> selectUserConnList(KwangjinUserConnDto kwangjinUserConnDto);
	
	public int selectUserConnCount(KwangjinUserConnDto kwangjinUserConnDto);
	
	public void insertUserConn(KwangjinUserConnDto kwangjinUserConnDto);
	
	public void updateUserConn(KwangjinUserConnDto kwangjinUserConnDto);
}
