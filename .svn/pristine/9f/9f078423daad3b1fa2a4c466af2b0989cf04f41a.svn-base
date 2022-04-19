package jin.mes.cform.mtrl.mtrlMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtDto;

@Mapper
public interface ZinixMtrlMgtMapper {
	//자재관리
	public List<ZinixMtrlMgtDto> selectMtrlMgtList(ZinixMtrlMgtDto mtrlMgtDto);
	
	public int selectMtrlMgtCount(ZinixMtrlMgtDto mtrlMgtDto);
	
	public void insertMtrlMgt(ZinixMtrlMgtDto mtrlMgtDto);
	
	public void updateMtrlMgt(ZinixMtrlMgtDto mtrlMgtDto);
	
	public void updateMtrlMgtIsDel(ZinixMtrlMgtDto mtrlMgtDto);
	
	public int deleteMtrlMgt(ZinixMtrlMgtDto mtrlMgtDto);
	
	
	//자재수량관리
	public List<ZinixMtrlHistoryDto> selectMtrlHistoryList(ZinixMtrlHistoryDto mtrlHisDto);
	
	public int selectMtrlHistoryCount(ZinixMtrlHistoryDto mtrlHisDto);
	
	public int selectMtrlHistoryTotal(ZinixMtrlHistoryDto mtrlHisDto);

	public void insertMtrlHistory(ZinixMtrlHistoryDto mtrlHisDto);
	
	public void updateMtrlHistory(ZinixMtrlHistoryDto mtrlHisDto);
	
	public int deleteMtrlHistory(ZinixMtrlHistoryDto mtrlHisDto);
	
	
	//자재 사용이력 수동관리
	public void insertManualInfo(ZinixMtrlHistoryDto mtrlHisDto);
	
	public void updateManualInfo(ZinixMtrlHistoryDto mtrlHisDto);
	
	public int deleteManualInfo(ZinixMtrlHistoryDto mtrlHisDto);
		
}
