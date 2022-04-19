package jin.mes.cform.facilMgt.facilCorMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.facilMgt.facilCorMgt.KwangjinFacilCorMgtDto;

@Mapper
public interface KwangjinFacilCorMgtMapper {
	//설비 상세 관리	
	public List<KwangjinFacilCorMgtDto> selectEqmtMgtList(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public int selectEqmtMgtCount(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public List<KwangjinFacilCorMgtDto> selectEqmtMgtListAll(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public KwangjinFacilCorMgtDto selectEqmtOverall(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public void insertEqmtMgt(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public void updateEqmtMgt(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public int deleteEqmtMgt(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	
	//설비 정비이력	
	public List<KwangjinFacilCorMgtDto> selectEqmtMtncList(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public int selectEqmtMtncCount(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public void insertEqmtMtnc(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public void updateEqmtMtnc(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public int deleteEqmtMtnc(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	//설비 가동시간
	public List<KwangjinFacilCorMgtDto> selectEqmtWorkList(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public int selectEqmtWorkCount(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public void insertEqmtWork(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
	public void updateEqmtWork(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto);
	
}
