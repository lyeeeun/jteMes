package jin.mes.cform.qualMgt.qualPec.prcesQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;

@Mapper
public interface NewPrcesQualMgtMapper {
	
	public List<NewLotInfoDto> selectPrcesQualList(NewLotInfoDto lotInfoDto);
	
	public int selectPrcesQualCount(NewLotInfoDto lotInfoDto);
	
	//입고검사 Main
	public List<NewWrkinTeamMgtDto> selectPrcesQualInfo(NewWrkinTeamMgtDto asgnDto);
	
}
