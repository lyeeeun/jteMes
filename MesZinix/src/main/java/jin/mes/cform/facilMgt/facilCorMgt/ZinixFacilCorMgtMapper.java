package jin.mes.cform.facilMgt.facilCorMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.facilMgt.facilCorMgt.ZinixFacilCorMgtDto;

@Mapper
public interface ZinixFacilCorMgtMapper {
	//설비 상세 관리	
	public List<ZinixFacilCorMgtDto> selectEqmtMgtList(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public int selectEqmtMgtCount(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public List<ZinixFacilCorMgtDto> selectEqmtMgtListAll(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public ZinixFacilCorMgtDto selectEqmtOverall(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public void insertEqmtMgt(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public void updateEqmtMgt(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public int deleteEqmtMgt(ZinixFacilCorMgtDto eqmtMgtDto);
	
	
	//설비 정비이력	
	public List<ZinixFacilCorMgtDto> selectEqmtMtncList(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public int selectEqmtMtncCount(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public void insertEqmtMtnc(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public void updateEqmtMtnc(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public int deleteEqmtMtnc(ZinixFacilCorMgtDto eqmtMgtDto);
	
	//설비 가동시간
	public List<ZinixFacilCorMgtDto> selectEqmtWorkList(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public int selectEqmtWorkCount(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public void insertEqmtWork(ZinixFacilCorMgtDto eqmtMgtDto);
	
	public void updateEqmtWork(ZinixFacilCorMgtDto eqmtMgtDto);
	
}
