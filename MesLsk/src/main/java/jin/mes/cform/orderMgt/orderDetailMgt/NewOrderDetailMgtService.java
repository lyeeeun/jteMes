package jin.mes.cform.orderMgt.orderDetailMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.itemMgt.NewItemMgtDto;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtDto;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtService;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtService;
import jin.mes.cform.basMgt.operMgt.itemMgt.NewItemMgtMapper;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewOrderDetailMgtService {
	
	@Resource
	NewOrderDetailMgtMapper newOrderMapper;
	
	@Resource
	NewItemMgtMapper newItemMapper;
	
	@Autowired
	NewItemStockMgtService newItemStockService; 
	
	@Autowired
	NewMtrlMgtService newMtrlMgtService;
	
	public PageInfo<NewOrderDetailMgtDto> getOrderList(NewOrderDetailMgtDto newOrderDto, PageRequestVo pageRequestVo){
		List<NewOrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		newOrderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newOrderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newOrderMapper.selectOrderListCount(newOrderDto);
			if (rowCount > 0) {
				//List
				orderList = newOrderMapper.selectOrderList(newOrderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<NewOrderDetailMgtDto>();
		}
		return new PageInfo<NewOrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}
	
	//주문정보 입력/수정
	@Transactional
	public String setOrderInfoSave(NewOrderDetailMgtDto newOrderDto){
		String returnKey = "";
		try {
			newOrderDto.setCreatorId(JteUtils.getUserId());
			newOrderDto.setUpdatorId(JteUtils.getUserId());
			
			if(newOrderDto.getAction().equals("C")) {
				//주문정보 입력
				newOrderDto.setOrderState("ord_prcd01");
				newOrderMapper.insertOrderInfo(newOrderDto);
				returnKey = newOrderDto.getOrderId();
			}else if(newOrderDto.getAction().equals("U")){
				//주문정보 수정
				newOrderMapper.updateOrderInfo(newOrderDto);
				
				returnKey = newOrderDto.getOrderId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("주문정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//주문정보 입력/수정
	@Transactional
	public int setOrderInfoDelete(List<NewOrderDetailMgtDto> orderList){
		int resultInt = -1;
		try {
			//주문정보 삭제
			for(NewOrderDetailMgtDto newOrderDto : orderList){
				newOrderMapper.deleteOrderInfo(newOrderDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("주문정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}

	
	
	

	// 공구정비이력 조회
	public PageInfo<NewLotInfoDto> getMidLotList(NewLotInfoDto newLotInfoDto, PageRequestVo pageRequestVo) {
		List<NewLotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		newLotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newLotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newOrderMapper.selectMidLotListCount(newLotInfoDto);
			if (rowCount > 0) {
				// List
				lotList = newOrderMapper.selectMidLotList(newLotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<NewLotInfoDto>();
		}
		return new PageInfo<NewLotInfoDto>(lotList, pageRequestVo, rowCount);
	}

	// 공구 정비이력 입력/수정
	@Transactional
	public String setMidLotInfoSave(NewLotInfoDto newLotInfoDto) {
		String returnKey = "";
		try {
			newLotInfoDto.setCreatorId(JteUtils.getUserId());
			newLotInfoDto.setUpdatorId(JteUtils.getUserId());

			if (newLotInfoDto.getAction().equals("C")) {// 공구정비이력 등록

				// 공구정비이력 입력
				newOrderMapper.insertMidLotInfo(newLotInfoDto);

				returnKey = newLotInfoDto.getMidlotId();
				
			} else if (newLotInfoDto.getAction().equals("U")) {// 공구정비이력 수정
				// 공구정비이력 수정
				newOrderMapper.updateMidLotInfo(newLotInfoDto);
				
				returnKey = newLotInfoDto.getMidlotId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("입고검사  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구정비이력 삭제
	@Transactional
	public int setMidLotInfoDelete(List<NewLotInfoDto> lotList) {
		int resultInt = -1;
		try {
			// 공구정비이력 삭제
			for (NewLotInfoDto newLotInfoDto : lotList) {
				newOrderMapper.deleteMidLotInfo(newLotInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구정비이력  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
	
	@Transactional
	public int selectLotDupleKeyCount(NewLotInfoDto newLotInfoDto){
		int resultInt = -1;
		try {
			resultInt = newOrderMapper.selectLotDupleKeyCount(newLotInfoDto);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Lot정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	
	
	
	public PageInfo<NewLotInfoDto> getLotList(NewLotInfoDto newLotInfoDto, PageRequestVo pageRequestVo){
		List<NewLotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		newLotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newLotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newOrderMapper.selectLotListCount(newLotInfoDto);
			if (rowCount > 0) {
				//List
				lotList = newOrderMapper.selectLotList(newLotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<NewLotInfoDto>();
		}
		return new PageInfo<NewLotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	//Lot정보 입력/수정
	@Transactional
	public int setLotInfoSave(NewLotInfoDto newLotDto){
		int returnKey = 0;
		//수주정보와 LOT 정보를 조회하기 위하여 등록된 LOT 조회
		NewLotInfoDto newLotItemDto = new NewLotInfoDto();
		
		//현재시간
		SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Date dateTime = new Date();
		String nowDateTime = dateFormat.format(dateTime); 
		
		try {
			newLotDto.setCreatorId(JteUtils.getUserId());
			newLotDto.setUpdatorId(JteUtils.getUserId());
			//품목정보 불러오기
			NewItemMgtDto newItemMgtDto = new NewItemMgtDto();
			newItemMgtDto.setFirstIndex(1);
			newItemMgtDto.setLastIndex(1);
			newItemMgtDto.setItemId(newLotDto.getItemId());
			newItemMgtDto = newItemMapper.selectItemList(newItemMgtDto).get(0);
			
			if(newLotDto.getAction().equals("C")) {
				//Lot 상태 기본값 입력
				newLotDto.setLotState("ord_sta01");
				//Lot 구분 기본값 입력
				newLotDto.setLotType("ord_div01");
				
				//단가 계산(자재비용)
				newLotDto.setLotMtrlCost(newItemMgtDto.getItemMtrlCost() * newLotDto.getLotQty());
				//단가 계산(인건비용)
				newLotDto.setLotPersonCost(newItemMgtDto.getItemPersonCost() * newLotDto.getLotQty());
				//Lot 입력
				newOrderMapper.insertLotInfo(newLotDto);
				returnKey = newLotDto.getLotSeq();
				newLotItemDto.setLotSeq(returnKey);
				newLotItemDto = newOrderMapper.selectLotList(newLotDto).get(0);
				
				//공제량 저장
				newItemMgtDto.setItemDeduction(newLotDto.getItemDeduction());
				newItemMapper.updateItemDeduction(newItemMgtDto);
				
				//품목 수량 관리 테이블 저장
				NewItemStockMgtDto newItemstockDto = new NewItemStockMgtDto(newLotItemDto.getItemId(), newLotItemDto.getLotId(), "LOT", newLotItemDto.getOrderStdt(), 0, 0, "수주에 의한 등록");
				
				newItemStockService.insertItemStock(newItemstockDto);
				 
				
				//자재수량을 저장하기 위한 생성자
				if(!StringUtils.isEmpty(newLotDto.getMtrlId())) {
					NewMtrlHistoryDto newMtrlCntDto = new NewMtrlHistoryDto(newLotDto.getMtrlId(), "mtrl_tagt05", newLotItemDto.getLotId(),
							newLotDto.getMtrlQty(), nowDateTime, newLotDto.getLotPm(), newLotDto.getMtrlMgtId(), newLotItemDto.getLotId());
					newMtrlCntDto.setAction("ADD");//자재 수량 insert
			
					//자재수량 저장
					newMtrlMgtService.setMtrlMgtPgSave(newMtrlCntDto);
				}

			}else if(newLotDto.getAction().equals("U")){
				//단가 계산(자재비용)
				newLotDto.setLotMtrlCost(newItemMgtDto.getItemPrice() * newLotDto.getLotQty());
				//단가 계산(인건비용)
				newLotDto.setLotPersonCost(newItemMgtDto.getItemPersonCost() * newLotDto.getLotQty());
				
				//Lot정보 수정
				newOrderMapper.updateLotInfo(newLotDto);
				returnKey = newLotDto.getLotSeq();
				newLotItemDto.setLotSeq(returnKey);
				newLotItemDto = newOrderMapper.selectLotList(newLotDto).get(0);
				
				//공제량 저장
				newItemMgtDto.setItemDeduction(newLotDto.getItemDeduction());
				newItemMapper.updateItemDeduction(newItemMgtDto);
				
				if(!StringUtils.isEmpty(newLotDto.getMtrlId())) {
					//자재수량을 저장하기 위한 생성자
					NewMtrlHistoryDto newMtrlCntDto = new NewMtrlHistoryDto(newLotDto.getMtrlId(), "mtrl_tagt05", newLotItemDto.getLotId(),
							newLotDto.getMtrlQty(), nowDateTime, newLotDto.getLotPm(), newLotDto.getMtrlMgtId(), newLotItemDto.getLotId());
					newMtrlCntDto.setAction("U");//자재 수량 update
			
					//자재수량 저장
					newMtrlMgtService.setMtrlMgtPgSave(newMtrlCntDto);
				}
			}else if(newLotDto.getAction().equals("RE")) {
				//단가 계산(자재비용)
				newLotDto.setLotMtrlCost(newItemMgtDto.getItemPrice() * newLotDto.getLotQty());
				//단가 계산(인건비용)
				newLotDto.setLotPersonCost(newItemMgtDto.getItemPersonCost() * newLotDto.getLotQty());
				//Lot 입력
				newOrderMapper.insertClaimReLotInfo(newLotDto);
				
				//공제량 저장
//				itemMgtDto.setItemDeduction(lotDto.getItemDeduction());
//				itemMapper.updateItemDeduction(itemMgtDto);
				
				returnKey = newLotDto.getLotSeq();
			}
		} catch (Exception e) {
			returnKey = 0;
			throw new BusinessException("Lot정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//Lot정보 삭제
	@Transactional
	public int setLotInfoDelete(List<NewLotInfoDto> lotList){
		int resultInt = -1;
		try {
			//자재삭제
			for(NewLotInfoDto newLotInfoDto : lotList){
				newOrderMapper.deleteLotInfo(newLotInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Lot정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	@Transactional
	public int selectMidlotDupleKeyCount(NewLotInfoDto newLotInfoDto){
		int resultInt = -1;
		try {
			resultInt = newOrderMapper.selectMidlotDupleKeyCount(newLotInfoDto);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Lot정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}

}
