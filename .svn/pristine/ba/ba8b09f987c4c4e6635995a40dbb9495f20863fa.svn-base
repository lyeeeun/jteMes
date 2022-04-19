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
import jin.mes.cform.basMgt.operMgt.itemMgt.NewItemMgtMapper;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtDto;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtService;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewOrderDetailMgtService {
	
	@Resource
	NewOrderDetailMgtMapper NewOrderMapper;
	
	@Resource
	NewItemMgtMapper newItemMapper;
	
	@Autowired
	NewItemStockMgtService newItemStockService; 
	
	@Autowired
	NewMtrlMgtService newMtrlMgtService;
	
	public PageInfo<NewOrderDetailMgtDto> getOrderList(NewOrderDetailMgtDto orderDto, PageRequestVo pageRequestVo){
		List<NewOrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = NewOrderMapper.selectOrderListCount(orderDto);
			if (rowCount > 0) {
				//List
				orderList = NewOrderMapper.selectOrderList(orderDto);
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
	public String setOrderInfoSave(NewOrderDetailMgtDto orderDto){
		String returnKey = "";
		try {
			orderDto.setCreatorId(JteUtils.getUserId());
			orderDto.setUpdatorId(JteUtils.getUserId());
			
			if(orderDto.getAction().equals("C")) {
				//주문정보 입력
				orderDto.setOrderState("ord_prcd01");
				NewOrderMapper.insertOrderInfo(orderDto);
				returnKey = orderDto.getOrderId();
			}else if(orderDto.getAction().equals("U")){
				//주문정보 수정
				NewOrderMapper.updateOrderInfo(orderDto);
				
				returnKey =orderDto.getOrderId();
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
			for(NewOrderDetailMgtDto orderDto : orderList){
				NewOrderMapper.deleteOrderInfo(orderDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("주문정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}

	public PageInfo<NewLotInfoDto> getLotList(NewLotInfoDto lotInfoDto, PageRequestVo pageRequestVo){
		List<NewLotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = NewOrderMapper.selectLotListCount(lotInfoDto);
			if (rowCount > 0) {
				//List
				lotList = NewOrderMapper.selectLotList(lotInfoDto);
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
	public int setLotInfoSave(NewLotInfoDto lotDto){
		int returnKey = 0;
		//수주정보와 LOT 정보를 조회하기 위하여 등록된 LOT 조회
		NewLotInfoDto lotItemDto = new NewLotInfoDto();
		
		//현재시간
		SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Date dateTime = new Date();
		String nowDateTime = dateFormat.format(dateTime); 
		
		try {
			lotDto.setCreatorId(JteUtils.getUserId());
			lotDto.setUpdatorId(JteUtils.getUserId());
			//품목정보 불러오기
			NewItemMgtDto itemMgtDto = new NewItemMgtDto();
			itemMgtDto.setFirstIndex(1);
			itemMgtDto.setLastIndex(1);
			itemMgtDto.setItemId(lotDto.getItemId());
			itemMgtDto = newItemMapper.selectItemList(itemMgtDto).get(0);
			
			if(lotDto.getAction().equals("C")) {
				//Lot 상태 기본값 입력
				lotDto.setLotState("ord_sta01");
				//Lot 구분 기본값 입력
				lotDto.setLotType("ord_div01");
				
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemMtrlCost() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				//Lot 입력
				NewOrderMapper.insertLotInfo(lotDto);
				returnKey = lotDto.getLotSeq();
				lotItemDto.setLotSeq(returnKey);
				lotItemDto = NewOrderMapper.selectLotList(lotDto).get(0);
				
				//공제량 저장
				itemMgtDto.setItemDeduction(lotDto.getItemDeduction());
				newItemMapper.updateItemDeduction(itemMgtDto);
				
				//품목 수량 관리 테이블 저장
				NewItemStockMgtDto itemstockDto = new NewItemStockMgtDto(lotItemDto.getItemId(), lotItemDto.getLotId(), "LOT", lotItemDto.getOrderStdt(), 0, 0, "수주에 의한 등록");
				
				newItemStockService.insertItemStock(itemstockDto);
				 
				
				//자재수량을 저장하기 위한 생성자
				if(!StringUtils.isEmpty(lotDto.getMtrlId())) {
					NewMtrlHistoryDto mtrlCntDto = new NewMtrlHistoryDto(lotDto.getMtrlId(), "mtrl_tagt05", lotItemDto.getLotId(),
							lotDto.getMtrlQty(), nowDateTime, lotDto.getLotPm(), lotDto.getMtrlMgtId(), lotItemDto.getLotId());
					mtrlCntDto.setAction("ADD");//자재 수량 insert
			
					//자재수량 저장
					newMtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				}

			}else if(lotDto.getAction().equals("U")){
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				
				//Lot정보 수정
				NewOrderMapper.updateLotInfo(lotDto);
				returnKey = lotDto.getLotSeq();
				lotItemDto.setLotSeq(returnKey);
				lotItemDto = NewOrderMapper.selectLotList(lotDto).get(0);
				
				//공제량 저장
				itemMgtDto.setItemDeduction(lotDto.getItemDeduction());
				newItemMapper.updateItemDeduction(itemMgtDto);
				
				if(!StringUtils.isEmpty(lotDto.getMtrlId())) {
					//자재수량을 저장하기 위한 생성자
					NewMtrlHistoryDto mtrlCntDto = new NewMtrlHistoryDto(lotDto.getMtrlId(), "mtrl_tagt05", lotItemDto.getLotId(),
							lotDto.getMtrlQty(), nowDateTime, lotDto.getLotPm(), lotDto.getMtrlMgtId(), lotItemDto.getLotId());
					mtrlCntDto.setAction("U");//자재 수량 update
			
					//자재수량 저장
					newMtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				}
			}else if(lotDto.getAction().equals("RE")) {
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				//Lot 입력
				NewOrderMapper.insertClaimReLotInfo(lotDto);
				
				//공제량 저장
//				itemMgtDto.setItemDeduction(lotDto.getItemDeduction());
//				newItemMapper.updateItemDeduction(itemMgtDto);
				
				returnKey = lotDto.getLotSeq();
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
			for(NewLotInfoDto lotInfoDto : lotList){
				NewOrderMapper.deleteLotInfo(lotInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Lot정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	@Transactional
	public int selectDupleKeyCount(NewLotInfoDto lotInfoDto){
		int resultInt = -1;
		try {
			resultInt = NewOrderMapper.selectDupleKeyCount(lotInfoDto);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Lot정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
}
