package jin.mes.cform.basMgt.operMgt.facilMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.facilMgt.NewFacilMgtDto;

@Mapper
public interface NewFacilMgtMapper {

	public List<NewFacilMgtDto> selectEqmtMgtList(NewFacilMgtDto newEqmtMgtDto);
	
	public int selectEqmtMgtCount(NewFacilMgtDto newEqmtMgtDto);
	
	public List<NewFacilMgtDto> selectEqmtMgtListAll(NewFacilMgtDto newEqmtMgtDto);
	
	public void insertEqmtMgt(NewFacilMgtDto newEqmtMgtDto);
	
	public void updateEqmtMgt(NewFacilMgtDto newEqmtMgtDto);
	
	public int deleteEqmtMgt(NewFacilMgtDto newEqmtMgtDto);
	
}
