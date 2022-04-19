package jin.mes.form.qualMgt.qualPec.prcesQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;


@Mapper
public interface PrcesQualMgtMapper {
	
	
	public List<LotInfoDto> selectPrcesQualList(LotInfoDto lotInfoDto);
	
	public int selectPrcesQualCount(LotInfoDto lotInfoDto);
	
	//입고검사 Main
	public List<WrkinTeamMgtDto> selectPrcesQualInfo(WrkinTeamMgtDto asgnDto);
	
}
