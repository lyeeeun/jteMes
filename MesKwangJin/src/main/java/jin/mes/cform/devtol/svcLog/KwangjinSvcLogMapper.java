package jin.mes.cform.devtol.svcLog;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.devtol.userConn.KwangjinUserConnDto;
import jin.mes.cform.devtol.svcLog.KwangjinSvcLogDto;

@Mapper
public interface KwangjinSvcLogMapper {

	public List<KwangjinSvcLogDto> selectSvcLogList(KwangjinSvcLogDto kwangjinSvcLogDto);
	
	public int selectSvcLogCount(KwangjinSvcLogDto kwangjinSvcLogDto);
	
	public void insertSvcLog(KwangjinSvcLogDto kwangjinSvcLogDto);
	
	public void updateSvcLog(KwangjinSvcLogDto kwangjinSvcLogDto);
}
