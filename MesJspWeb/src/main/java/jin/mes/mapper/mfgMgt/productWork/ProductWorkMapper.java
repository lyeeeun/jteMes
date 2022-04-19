package jin.mes.mapper.mfgMgt.productWork;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mfgMgt.wrkinWrkerMgt.MtrlUseDto;
import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;

@Mapper
public interface ProductWorkMapper {
	//생산 LOT 내역
	public List<LotInfoDto> selectProdWorkLotList(LotInfoDto lotInfoDto);
	
	//생산 LOT 카운트
	public int selectProdWorkLotCount(LotInfoDto lotInfoDto);
	
	//생산지시 내역 리스트
	public List<WrkinTeamMgtDto> selectProdWorkAsgnList(WrkinTeamMgtDto wrkinTeamMgtDto);
	
	//생산지시 팝업 조회
	public List<WrkinTeamMgtDto> selectProdWorkAsgnDetail(WrkinTeamMgtDto asgnDto);
	
	//생산지시 등록
	public void insertProdWorkAsgn(WrkinTeamMgtDto asgnDto);
	//생산지시 수정
	public void updateProdWorkAsgn(WrkinTeamMgtDto asgnDto);
	//생산지시 삭제
	public int deleteProdWorkAsgn(WrkinTeamMgtDto asgnDto);
	
	//생산 LOT 내역
	public List<WrkinTeamMgtDto> selectProdWorkRoutSheetList(WrkinTeamMgtDto asgnDto);
	
	//작업정보 등록
	public void insertProdWorkRoutSheet(WrkinTeamMgtDto asgnDto);
	//작업정보 수정
	public void updateProdWorkRoutSheet(WrkinTeamMgtDto asgnDto);
	//작업정보 삭제
	public int deletProdWorkRoutSheet(WrkinTeamMgtDto asgnDto);
	
	//설비교체 리스트
	public List<FacilMgtDto> selectProdWorkEqmtChangeList(WrkinTeamMgtDto asgnDto);
	

	//장착된 공구 조회 - group by 
	public List<FacilToolMgtDto> selectProdWorkEqmtToolList(FacilToolMgtDto eqmtToolDto);
	//사용가능한 공구 조회
	public List<FacilToolMgtDto> selectProdWorkToolUseableList(FacilToolMgtDto eqmtToolDto);	
	//장착된 공구조회(라우팅,설비) -단일값 
	public List<FacilToolMgtDto> selectEqmtToolList(FacilToolMgtDto eqmtToolDto);
		
	//공구등록
	public void insertProdWorkEqmtTool(FacilToolMgtDto eqmtToolDto);
	//공구해제
	public void deleteProdWorkEqmtTool(FacilToolMgtDto eqmtToolDto);
	
	
	//공구카운트 등록
	//public int insertProdWorkEqmtToolCount(FacilToolMgtDto eqmtToolDto);
	//공구카운트 변경
	//public int updateProdWorkEqmtToolCount(FacilToolMgtDto eqmtToolDto);
	
	
	//자재투입 total 조회
	public List<MtrlUseDto> selectProdWorkMtrlTotal(MtrlUseDto mtrlUseDto);
	//자재투입 Detial 조회
	public List<MtrlUseDto> selectProdWorkMtrlDetail(MtrlUseDto mtrlUseDto);
	//자재투입 등록
	public void insertProdWorkMtrl(MtrlUseDto mtrlUseDto);
	//자재투입 수정
	public void updateProdWorkMtrl(MtrlUseDto mtrlUseDto);
	//자재투입 삭제
	public int deleteProdWorkMtrl(MtrlUseDto mtrlUseDto);
	
	//부품 불량 조회
	public List<InfergodsMgtDto> selectItemBadList(InfergodsMgtDto itemBadDto);
	//부품 불량 토탈
	public int selectItemBadTotal(InfergodsMgtDto itemBadDto);
	//부품 불량 등록
	public void insertItemBad(InfergodsMgtDto itemBadDto);
	//부품 불량 수정
	public void updateItemBad(InfergodsMgtDto itemBadDto);
	//부품 불량 삭제
	public int deleteItemBad(InfergodsMgtDto itemBadDto);
}
