package jin.mes.form.basMgt.operMgt.facilMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;

@Mapper
public interface FacilMgtMapper {

	public List<FacilMgtDto> selectEqmtMgtList(FacilMgtDto eqmtMgtDto);
	
	public int selectEqmtMgtCount(FacilMgtDto eqmtMgtDto);
	
	public List<FacilMgtDto> selectEqmtMgtListAll(FacilMgtDto eqmtMgtDto);
	
	public void insertEqmtMgt(FacilMgtDto eqmtMgtDto);
	
	public void updateEqmtMgt(FacilMgtDto eqmtMgtDto);
	
	public int deleteEqmtMgt(FacilMgtDto eqmtMgtDto);
	
}
