package jin.mes.mapper.facilMgt.facilCorMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.facilMgt.facilCorMgt.FacilCorMgtDto;

@Mapper
public interface FacilCorMgtMapper {
	//설비 상세 관리	
	public List<FacilCorMgtDto> selectEqmtMgtList(FacilCorMgtDto eqmtMgtDto);
	
	public int selectEqmtMgtCount(FacilCorMgtDto eqmtMgtDto);
	
	public List<FacilCorMgtDto> selectEqmtMgtListAll(FacilCorMgtDto eqmtMgtDto);
	
	public FacilCorMgtDto selectEqmtOverall(FacilCorMgtDto eqmtMgtDto);
	
	public void insertEqmtMgt(FacilCorMgtDto eqmtMgtDto);
	
	public void updateEqmtMgt(FacilCorMgtDto eqmtMgtDto);
	
	public int deleteEqmtMgt(FacilCorMgtDto eqmtMgtDto);
	
	
	//설비 정비이력	
	public List<FacilCorMgtDto> selectEqmtMtncList(FacilCorMgtDto eqmtMgtDto);
	
	public int selectEqmtMtncCount(FacilCorMgtDto eqmtMgtDto);
	
	public void insertEqmtMtnc(FacilCorMgtDto eqmtMgtDto);
	
	public void updateEqmtMtnc(FacilCorMgtDto eqmtMgtDto);
	
	public int deleteEqmtMtnc(FacilCorMgtDto eqmtMgtDto);
	
	//설비 가동시간
	public List<FacilCorMgtDto> selectEqmtWorkList(FacilCorMgtDto eqmtMgtDto);
	
	public int selectEqmtWorkCount(FacilCorMgtDto eqmtMgtDto);
	
	public void insertEqmtWork(FacilCorMgtDto eqmtMgtDto);
	
	public void updateEqmtWork(FacilCorMgtDto eqmtMgtDto);
	
}
