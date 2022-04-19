package jin.mes.cform.mtrl.mtrlMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.mtrlMgt.NewMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtDto;

@Mapper
public interface NewMtrlMgtMapper {
	//자재관리
	public List<NewMtrlMgtDto> selectMtrlMgtList(NewMtrlMgtDto newMtrlMgtDto);
	
	public int selectMtrlMgtCount(NewMtrlMgtDto newMtrlMgtDto);
	
	public void insertMtrlMgt(NewMtrlMgtDto newMtrlMgtDto);
	
	public void updateMtrlMgt(NewMtrlMgtDto newMtrlMgtDto);
	
	public void updateMtrlMgtIsDel(NewMtrlMgtDto newMtrlMgtDto);
	
	public int deleteMtrlMgt(NewMtrlMgtDto newMtrlMgtDto);
	
	
	//자재수량관리
	public List<NewMtrlHistoryDto> selectMtrlHistoryList(NewMtrlHistoryDto newMtrlHisDto);
	
	public int selectMtrlHistoryCount(NewMtrlHistoryDto newMtrlHisDto);
	
	public int selectMtrlHistoryTotal(NewMtrlHistoryDto newMtrlHisDto);

	public void insertMtrlHistory(NewMtrlHistoryDto newMtrlHisDto);
	
	public void updateMtrlHistory(NewMtrlHistoryDto newMtrlHisDto);
	
	public int deleteMtrlHistory(NewMtrlHistoryDto newMtrlHisDto);
	
	
	//자재 사용이력 수동관리
	public void insertManualInfo(NewMtrlHistoryDto newMtrlHisDto);
	
	public void updateManualInfo(NewMtrlHistoryDto newMtrlHisDto);
	
	public int deleteManualInfo(NewMtrlHistoryDto newMtrlHisDto);
		
}
