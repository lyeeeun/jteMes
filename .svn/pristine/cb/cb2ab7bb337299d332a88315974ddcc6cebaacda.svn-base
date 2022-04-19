package jin.mes.cform.mfgMgt.productWork;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.facilMgt.NewFacilMgtDto;
import jin.mes.cform.facilMgt.facilToolMgt.NewFacilToolMgtDto;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mfgMgt.wrkinWrkerMgt.NewMtrlUseDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;

@Mapper
public interface NewProductWorkMapper {
	//생산 LOT 내역
	public List<NewLotInfoDto> selectProdWorkLotList(NewLotInfoDto newLotInfoDto);
	
	//생산 LOT 카운트
	public int selectProdWorkLotCount(NewLotInfoDto newLotInfoDto);
	
	//생산지시 내역 리스트
	public List<NewWrkinTeamMgtDto> selectProdWorkAsgnList(NewWrkinTeamMgtDto newWrkinTeamMgtDto);
	
	//생산지시 팝업 조회
	public List<NewWrkinTeamMgtDto> selectProdWorkAsgnDetail(NewWrkinTeamMgtDto newAsgnDto);
	
	//생산지시 등록
	public void insertProdWorkAsgn(NewWrkinTeamMgtDto newAsgnDto);
	//생산지시 수정
	public void updateProdWorkAsgn(NewWrkinTeamMgtDto newAsgnDto);
	//생산지시 삭제
	public int deleteProdWorkAsgn(NewWrkinTeamMgtDto newAsgnDto);
	
	//생산 LOT 내역
	public List<NewWrkinTeamMgtDto> selectProdWorkRoutSheetList(NewWrkinTeamMgtDto newAsgnDto);
	
	//작업정보 등록
	public void insertProdWorkRoutSheet(NewWrkinTeamMgtDto newAsgnDto);
	//작업정보 수정
	public void updateProdWorkRoutSheet(NewWrkinTeamMgtDto newAsgnDto);
	//작업정보 삭제
	public int deletProdWorkRoutSheet(NewWrkinTeamMgtDto newAsgnDto);
	
	//설비교체 리스트
	public List<NewFacilMgtDto> selectProdWorkEqmtChangeList(NewWrkinTeamMgtDto newAsgnDto);
	

	//장착된 공구 조회 - group by 
	public List<NewFacilToolMgtDto> selectProdWorkEqmtToolList(NewFacilToolMgtDto newEqmtToolDto);
	//사용가능한 공구 조회
	public List<NewFacilToolMgtDto> selectProdWorkToolUseableList(NewFacilToolMgtDto newEqmtToolDto);	
	//장착된 공구조회(라우팅,설비) -단일값 
	public List<NewFacilToolMgtDto> selectEqmtToolList(NewFacilToolMgtDto newEqmtToolDto);
		
	//공구등록
	public void insertProdWorkEqmtTool(NewFacilToolMgtDto newEqmtToolDto);
	//공구해제
	public void deleteProdWorkEqmtTool(NewFacilToolMgtDto newEqmtToolDto);
	
	
	//공구카운트 등록
	//public int insertProdWorkEqmtToolCount(NewFacilToolMgtDto newEqmtToolDto);
	//공구카운트 변경
	//public int updateProdWorkEqmtToolCount(NewFacilToolMgtDto newEqmtToolDto);
	
	
	//자재투입 total 조회
	public List<NewMtrlUseDto> selectProdWorkMtrlTotal(NewMtrlUseDto newMtrlUseDto);
	//자재투입 Detial 조회
	public List<NewMtrlUseDto> selectProdWorkMtrlDetail(NewMtrlUseDto newMtrlUseDto);
	//자재투입 등록
	public void insertProdWorkMtrl(NewMtrlUseDto newMtrlUseDto);
	//자재투입 수정
	public void updateProdWorkMtrl(NewMtrlUseDto newMtrlUseDto);
	//자재투입 삭제
	public int deleteProdWorkMtrl(NewMtrlUseDto newMtrlUseDto);
	
	//부품 불량 조회
	public List<NewInfergodsMgtDto> selectItemBadList(NewInfergodsMgtDto newItemBadDto);
	//부품 불량 토탈
	public int selectItemBadTotal(NewInfergodsMgtDto newItemBadDto);
	//통신 양품량 - 불량량
	public int selectItemCallBadTotal(NewWrkinTeamMgtDto newAsgnDto);
	//부품 불량 등록
	public void insertItemBad(NewInfergodsMgtDto newItemBadDto);
	//부품 불량 수정
	public void updateItemBad(NewInfergodsMgtDto newItemBadDto);
	//부품 불량 삭제
	public int deleteItemBad(NewInfergodsMgtDto newItemBadDto);
}
