package jin.mes.cform.basMgt.operMgt.facilMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.facilMgt.ZinixFacilMgtDto;

@Mapper
public interface ZinixFacilMgtMapper {

	public List<ZinixFacilMgtDto> selectEqmtMgtList(ZinixFacilMgtDto eqmtMgtDto);
	
	public int selectEqmtMgtCount(ZinixFacilMgtDto eqmtMgtDto);
	
	public List<ZinixFacilMgtDto> selectEqmtMgtListAll(ZinixFacilMgtDto eqmtMgtDto);
	
	public void insertEqmtMgt(ZinixFacilMgtDto eqmtMgtDto);
	
	public void updateEqmtMgt(ZinixFacilMgtDto eqmtMgtDto);
	
	public int deleteEqmtMgt(ZinixFacilMgtDto eqmtMgtDto);
	
}
