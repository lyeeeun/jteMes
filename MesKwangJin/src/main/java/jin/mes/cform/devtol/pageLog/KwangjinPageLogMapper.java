package jin.mes.cform.devtol.pageLog;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.devtol.userConn.KwangjinUserConnDto;
import jin.mes.cform.devtol.pageLog.KwangjinPageLogDto;

@Mapper
public interface KwangjinPageLogMapper {

	public List<KwangjinPageLogDto> selectPageLogList(KwangjinPageLogDto kwangjinpageLogDto);
	
	public int selectPageLogCount(KwangjinPageLogDto kwangjinpageLogDto);
	
	public void insertPageLog(KwangjinPageLogDto kwangjinpageLogDto);
	
	public void updatePageLog(KwangjinPageLogDto kwangjinpageLogDto);
}
