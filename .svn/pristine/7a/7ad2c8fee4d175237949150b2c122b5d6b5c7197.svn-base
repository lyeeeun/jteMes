package jin.mes.mapper.mtrl.mtrlMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtDto;

@Mapper
public interface MtrlMgtMapper {
	//자재관리
	public List<MtrlMgtDto> selectMtrlMgtList(MtrlMgtDto mtrlMgtDto);
	
	public int selectMtrlMgtCount(MtrlMgtDto mtrlMgtDto);
	
	public void insertMtrlMgt(MtrlMgtDto mtrlMgtDto);
	
	public void updateMtrlMgt(MtrlMgtDto mtrlMgtDto);
	
	public void updateMtrlMgtIsDel(MtrlMgtDto mtrlMgtDto);
	
	public int deleteMtrlMgt(MtrlMgtDto mtrlMgtDto);
	
	
	//자재수량관리
	public List<MtrlHistoryDto> selectMtrlHistoryList(MtrlHistoryDto mtrlHisDto);
	
	public int selectMtrlHistoryCount(MtrlHistoryDto mtrlHisDto);
	
	public int selectMtrlHistoryTotal(MtrlHistoryDto mtrlHisDto);

	public void insertMtrlHistory(MtrlHistoryDto mtrlHisDto);
	
	public void updateMtrlHistory(MtrlHistoryDto mtrlHisDto);
	
	public int deleteMtrlHistory(MtrlHistoryDto mtrlHisDto);
	
	
	//자재 사용이력 수동관리
	public void insertManualInfo(MtrlHistoryDto mtrlHisDto);
	
	public void updateManualInfo(MtrlHistoryDto mtrlHisDto);
	
	public int deleteManualInfo(MtrlHistoryDto mtrlHisDto);
		
}
