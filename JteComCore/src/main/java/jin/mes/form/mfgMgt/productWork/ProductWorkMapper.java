package jin.mes.form.mfgMgt.productWork;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
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
	
	//작업정보 등록
	public void insertProdWorkRoutSheet(WrkinTeamMgtDto asgnDto);
	//작업정보 수정
	public void updateProdWork(WrkinTeamMgtDto asgnDto);
	//작업정보 삭제
	public int deleteProdWorkRoutSheet(WrkinTeamMgtDto asgnDto);
	
	//해당 작업에서 사용될 자재 조회
	public List<BomMgtDto> selectWorkUseMtrlList(WrkinTeamMgtDto asgnDto);
	//자재사용이력 테이블에 등록되어 있는지 확인하기 위함
	public int countQmMtrlInfo(MtrlHistoryDto mtrlHistoryDto);
	//품목사용이력 테이블에 등록되어 있는지 확인하기 위함
	public int countQmItemInfo(ItemStockMgtDto itemStockDto);
	
	//bom기준 자재소요량 조회
	public List<BomMtrlDto> selectBomMtrlList(BomMtrlDto bomMtrlDto);
	//bom기준 자재소요량 상세 조회
	public List<BomMtrlDto> selectBomMtrlDetail(BomMtrlDto bomMtrlDto);
	
	//자재 불량조회(작업불량만)
	public List<InfergodsMgtDto> selectMtrlBadInfo(InfergodsMgtDto mtrlBadDto);

	//작업 불량카운트 
	public int countMtrlBadWorkInfo(InfergodsMgtDto mtrlBadDto);
	
}
