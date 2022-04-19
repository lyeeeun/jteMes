package jin.mes.cform.facilMgt.facilCorMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewFacilCorMgtMapper {
	//설비 상세 관리	
	public List<NewFacilCorMgtDto> selectEqmtMgtList(NewFacilCorMgtDto eqmtMgtDto);
	
	public int selectEqmtMgtCount(NewFacilCorMgtDto eqmtMgtDto);
	
	public List<NewFacilCorMgtDto> selectEqmtMgtListAll(NewFacilCorMgtDto eqmtMgtDto);
	
	public NewFacilCorMgtDto selectEqmtOverall(NewFacilCorMgtDto eqmtMgtDto);
	
	public void insertEqmtMgt(NewFacilCorMgtDto eqmtMgtDto);
	
	public void updateEqmtMgt(NewFacilCorMgtDto eqmtMgtDto);
	
	public int deleteEqmtMgt(NewFacilCorMgtDto eqmtMgtDto);
	
	
	//설비 정비이력	
	public List<NewFacilCorMgtDto> selectEqmtMtncList(NewFacilCorMgtDto eqmtMgtDto);
	
	public int selectEqmtMtncCount(NewFacilCorMgtDto eqmtMgtDto);
	
	public void insertEqmtMtnc(NewFacilCorMgtDto eqmtMgtDto);
	
	public void updateEqmtMtnc(NewFacilCorMgtDto eqmtMgtDto);
	
	public int deleteEqmtMtnc(NewFacilCorMgtDto eqmtMgtDto);
	
	//설비 가동시간
	public List<NewFacilCorMgtDto> selectEqmtWorkList(NewFacilCorMgtDto eqmtMgtDto);
	
	public int selectEqmtWorkCount(NewFacilCorMgtDto eqmtMgtDto);
	
	public void insertEqmtWork(NewFacilCorMgtDto eqmtMgtDto);
	
	public void updateEqmtWork(NewFacilCorMgtDto eqmtMgtDto);
	
}
