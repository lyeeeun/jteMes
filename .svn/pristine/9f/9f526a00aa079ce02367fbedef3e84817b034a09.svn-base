package jin.mes.cform.facilMgt.facilCorMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.facilMgt.facilCorMgt.NewFacilCorMgtDto;

@Mapper
public interface NewFacilCorMgtMapper {
	//설비 상세 관리	
	public List<NewFacilCorMgtDto> selectEqmtMgtList(NewFacilCorMgtDto newEqmtMgtDto);
	
	public int selectEqmtMgtCount(NewFacilCorMgtDto newEqmtMgtDto);
	
	public List<NewFacilCorMgtDto> selectEqmtMgtListAll(NewFacilCorMgtDto newEqmtMgtDto);
	
	public NewFacilCorMgtDto selectEqmtOverall(NewFacilCorMgtDto newEqmtMgtDto);
	
	public void insertEqmtMgt(NewFacilCorMgtDto newEqmtMgtDto);
	
	public void updateEqmtMgt(NewFacilCorMgtDto newEqmtMgtDto);
	
	public int deleteEqmtMgt(NewFacilCorMgtDto newEqmtMgtDto);
	
	
	//설비 정비이력	
	public List<NewFacilCorMgtDto> selectEqmtMtncList(NewFacilCorMgtDto newEqmtMgtDto);
	
	public int selectEqmtMtncCount(NewFacilCorMgtDto newEqmtMgtDto);
	
	public void insertEqmtMtnc(NewFacilCorMgtDto newEqmtMgtDto);
	
	public void updateEqmtMtnc(NewFacilCorMgtDto newEqmtMgtDto);
	
	public int deleteEqmtMtnc(NewFacilCorMgtDto newEqmtMgtDto);
	
	//설비 가동시간
	public List<NewFacilCorMgtDto> selectEqmtWorkList(NewFacilCorMgtDto newEqmtMgtDto);
	
	public int selectEqmtWorkCount(NewFacilCorMgtDto newEqmtMgtDto);
	
	public void insertEqmtWork(NewFacilCorMgtDto newEqmtMgtDto);
	
	public void updateEqmtWork(NewFacilCorMgtDto newEqmtMgtDto);
	
}
