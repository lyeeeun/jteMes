package jin.mes.cform.mfgMgt.productWork;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.bom.bomMgt.ZinixBomMgtDto;
import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlHistoryDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.ZinixInfergodsMgtDto;

@Mapper
public interface ZinixProductWorkMapper {
	//생산 LOT 내역
	public List<ZinixLotInfoDto> selectProdWorkLotList(ZinixLotInfoDto lotInfoDto);
	
	//생산 LOT 카운트
	public int selectProdWorkLotCount(ZinixLotInfoDto lotInfoDto);
	
	//생산지시 내역 리스트
	public List<ZinixWrkinTeamMgtDto> selectProdWorkAsgnList(ZinixWrkinTeamMgtDto wrkinTeamMgtDto);
	
	//생산지시 팝업 조회
	public List<ZinixWrkinTeamMgtDto> selectProdWorkAsgnDetail(ZinixWrkinTeamMgtDto asgnDto);
	
	//생산지시 등록
	public void insertProdWorkAsgn(ZinixWrkinTeamMgtDto asgnDto);
	//생산지시 수정
	public void updateProdWorkAsgn(ZinixWrkinTeamMgtDto asgnDto);
	//생산지시 삭제
	public int deleteProdWorkAsgn(ZinixWrkinTeamMgtDto asgnDto);
	
	//생산 LOT 내역
	public List<ZinixWrkinTeamMgtDto> selectProdWorkRoutSheetList(ZinixWrkinTeamMgtDto asgnDto);
	
	//작업정보 등록
	public void insertProdWorkRoutSheet(ZinixWrkinTeamMgtDto asgnDto);
	//작업정보 수정
	public void updateProdWork(ZinixWrkinTeamMgtDto asgnDto);
	//작업정보 삭제
	public int deleteProdWorkRoutSheet(ZinixWrkinTeamMgtDto asgnDto);
	
	//해당 작업에서 사용될 자재 조회
	public List<ZinixBomMgtDto> selectWorkUseMtrlList(ZinixWrkinTeamMgtDto asgnDto);
	//자재사용이력 테이블에 등록되어 있는지 확인하기 위함
	public int countQmMtrlInfo(ZinixMtrlHistoryDto mtrlHistoryDto);
	//품목사용이력 테이블에 등록되어 있는지 확인하기 위함
	public int countQmItemInfo(ZinixItemStockMgtDto itemStockDto);
	
	//bom기준 자재소요량 조회
	public List<ZinixBomMtrlDto> selectBomMtrlList(ZinixBomMtrlDto bomMtrlDto);
	//bom기준 자재소요량 상세 조회
	public List<ZinixBomMtrlDto> selectBomMtrlDetail(ZinixBomMtrlDto bomMtrlDto);
	
	//자재 불량조회(작업불량만)
	public List<ZinixInfergodsMgtDto> selectMtrlBadInfo(ZinixInfergodsMgtDto mtrlBadDto);

	//작업 불량카운트 
	public int countMtrlBadWorkInfo(ZinixInfergodsMgtDto mtrlBadDto);
	
}
