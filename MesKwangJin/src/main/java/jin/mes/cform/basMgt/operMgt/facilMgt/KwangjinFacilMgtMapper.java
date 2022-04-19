package jin.mes.cform.basMgt.operMgt.facilMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.facilMgt.KwangjinFacilMgtDto;

@Mapper
public interface KwangjinFacilMgtMapper {

	public List<KwangjinFacilMgtDto> selectEqmtMgtList(KwangjinFacilMgtDto kwangjinFacilMgtDto);
	
	public int selectEqmtMgtCount(KwangjinFacilMgtDto kwangjinFacilMgtDto);
	
	public List<KwangjinFacilMgtDto> selectEqmtMgtListAll(KwangjinFacilMgtDto kwangjinFacilMgtDto);
	
	public void insertEqmtMgt(KwangjinFacilMgtDto kwangjinFacilMgtDto);
	
	public void updateEqmtMgt(KwangjinFacilMgtDto kwangjinFacilMgtDto);
	
	public int deleteEqmtMgt(KwangjinFacilMgtDto kwangjinFacilMgtDto);
	
}
