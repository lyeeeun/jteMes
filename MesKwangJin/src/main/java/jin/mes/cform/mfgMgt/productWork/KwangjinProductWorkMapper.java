package jin.mes.cform.mfgMgt.productWork;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import jin.mes.cform.orderMgt.orderDetailMgt.KwangjinLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.KwangjinInfergodsMgtDto;

@Mapper
public interface KwangjinProductWorkMapper {
	//생산 LOT 내역
	public List<KwangjinLotInfoDto> selectProdWorkLotList(KwangjinLotInfoDto kwangjinLotInfoDto);
	
	//생산 LOT 카운트
	public int selectProdWorkLotCount(KwangjinLotInfoDto kwangjinLotInfoDto);
	
	//생산지시 내역 리스트
	public List<WrkinTeamMgtDto> selectProdWorkAsgnList(WrkinTeamMgtDto wrkinTeamMgtDto);
	
	//생산지시 팝업 조회
	public List<WrkinTeamMgtDto> selectProdWorkAsgnDetail(WrkinTeamMgtDto asgnDto);
	
	//생산지시 등록
	public void insertProdWorkAsgn(WrkinTeamMgtDto asgnDto);
	//생산지시 수정
	public void updateProdWorkAsgn(WrkinTeamMgtDto asgnDto);
	//생산지시 수정(상태값)
	public void updateAsgnState(WrkinTeamMgtDto asgnDto);
	//생산지시 삭제
	public int deleteProdWorkAsgn(WrkinTeamMgtDto asgnDto);
	
	//생산 LOT 내역
	public List<WrkinTeamMgtDto> selectProdWorkRoutSheetList(WrkinTeamMgtDto asgnDto);
	
	//설비교체 리스트
	public List<FacilMgtDto> selectProdWorkEqmtChangeList(WrkinTeamMgtDto asgnDto);

	//작업정보 등록
	public void insertProdWorkRoutSheet(WrkinTeamMgtDto asgnDto);
	//작업정보 수정
	public void updateProdWork(WrkinTeamMgtDto asgnDto);
	//작업정보 수정(설비 교체시 on)
	public void updateProdWorkEqmtOn(WrkinTeamMgtDto asgnDto);
	//작업정보 수정(설비 교체시 off)
	public void updateProdWorkEqmtOff(WrkinTeamMgtDto asgnDto);
	//작업정보 삭제
	public int deleteProdWorkRoutSheet(WrkinTeamMgtDto asgnDto);
	
	//해당 작업에서 사용될 자재 조회
	public List<BomMgtDto> selectWorkUseMtrlList(WrkinTeamMgtDto asgnDto);
	//자재사용이력 테이블에 등록되어 있는지 확인하기 위함
	public int countQmMtrlInfo(MtrlHistoryDto mtrlHistoryDto);
	//품목사용이력 테이블에 등록되어 있는지 확인하기 위함
	public int countQmItemInfo(ItemStockMgtDto itemStockDto);
	
	//bom기준 자재소요량 조회
	public List<KwangjinBomMtrlDto> selectBomMtrlList(KwangjinBomMtrlDto kwangjinBomMtrlDto);
	//bom기준 자재소요량 상세 조회
	public List<KwangjinBomMtrlDto> selectBomMtrlDetail(KwangjinBomMtrlDto kwangjinBomMtrlDto);
	
	//자재 불량조회(작업불량만)
	public List<KwangjinInfergodsMgtDto> selectMtrlBadInfo(KwangjinInfergodsMgtDto kwangjinInfergodsMgtDto);

	//작업 불량카운트 
	public int countMtrlBadWorkInfo(KwangjinInfergodsMgtDto kwangjinInfergodsMgtDto);
	
}
