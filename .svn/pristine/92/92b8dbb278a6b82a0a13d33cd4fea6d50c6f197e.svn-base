package jin.mes.cform.mtrl.mtrlMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewMtrlMgtMapper {
	//자재관리
	public List<NewMtrlMgtDto> selectMtrlMgtList(NewMtrlMgtDto mtrlMgtDto);
	
	public int selectMtrlMgtCount(NewMtrlMgtDto mtrlMgtDto);
	
	public void insertMtrlMgt(NewMtrlMgtDto mtrlMgtDto);
	
	public void updateMtrlMgt(NewMtrlMgtDto mtrlMgtDto);
	
	public void updateMtrlMgtIsDel(NewMtrlMgtDto mtrlMgtDto);
	
	public int deleteMtrlMgt(NewMtrlMgtDto mtrlMgtDto);
	
	
	//자재수량관리
	public List<NewMtrlHistoryDto> selectMtrlHistoryList(NewMtrlHistoryDto mtrlHisDto);
	
	public int selectMtrlHistoryCount(NewMtrlHistoryDto mtrlHisDto);
	
	public int selectMtrlHistoryTotal(NewMtrlHistoryDto mtrlHisDto);

	public void insertMtrlHistory(NewMtrlHistoryDto mtrlHisDto);
	
	public void updateMtrlHistory(NewMtrlHistoryDto mtrlHisDto);
	
	public int deleteMtrlHistory(NewMtrlHistoryDto mtrlHisDto);
	
	
	//자재 사용이력 수동관리
	public void insertManualInfo(NewMtrlHistoryDto mtrlHisDto);
	
	public void updateManualInfo(NewMtrlHistoryDto mtrlHisDto);
	
	public int deleteManualInfo(NewMtrlHistoryDto mtrlHisDto);
		
}
