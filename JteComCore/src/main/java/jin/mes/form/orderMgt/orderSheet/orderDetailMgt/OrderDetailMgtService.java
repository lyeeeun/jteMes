package jin.mes.form.orderMgt.orderSheet.orderDetailMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.item.itemStockMgt.ItemStockMgtMapper;
import jin.mes.form.item.itemStockMgt.ItemStockMgtService;
import jin.mes.form.mfgMgt.productWork.ProductWorkMapper;
import jin.mes.form.mfgMgt.productWork.ProductWorkService;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtMapper;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class OrderDetailMgtService {
	
	@Resource
	OrderDetailMgtMapper orderMapper;
	
	@Resource
	ItemMgtMapper itemMapper;
	
	@Resource
	ItemStockMgtMapper itemStockMgtMapper;
	
	@Autowired
	ItemStockMgtService itemStockService; 
	
	@Autowired
	MtrlMgtService mtrlMgtService;
	
	@Autowired
	ProductWorkService prodWorkService;
	
	@Autowired
	ProductWorkMapper productWorkMapper;
	
	//수주조회(page)
	public PageInfo<OrderDetailMgtDto> getOrderList(OrderDetailMgtDto orderDto, PageRequestVo pageRequestVo){
		List<OrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = orderMapper.selectOrderListCount(orderDto);
			if (rowCount > 0) {
				//List
				orderList = orderMapper.selectOrderList(orderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<OrderDetailMgtDto>();
		}
		return new PageInfo<OrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}
	
	//수주정보 팝업조회(order-child)
	public OrderDetailMgtDto getOrderPop(OrderDetailMgtDto orderDto){
		OrderDetailMgtDto orderPop = null;
		
		try {
			
			orderPop = orderMapper.selectOrderOne(orderDto);
			
			//해당 수주에 포함된 Lot 정보 조회
			if(!orderPop.getOrderId().equals(null)) {
				LotInfoDto lotInfoDto = new LotInfoDto();
				lotInfoDto.setOrderId(orderPop.getOrderId());
				orderPop.setChildLotList(orderMapper.selectOrderChild(lotInfoDto));
			}
		} catch (Exception e) {
			throw new BusinessException("수주팝업 조회 에러입니다. : " + e.getMessage());
		}
		return orderPop;
	}
	
	//주문정보 입력/수정
	@Transactional(rollbackFor = {Exception.class})
	public String setOrderInfoSave(OrderDetailMgtDto orderDto){
		String returnKey = "";
		try {
			orderDto.setCreatorId(JteUtils.getUserId());
			orderDto.setUpdatorId(JteUtils.getUserId());
			
			if(orderDto.getAction().equals("C")) {
				//주문정보 입력
				orderDto.setOrderState("ordPrcd00");
				orderMapper.insertOrderInfo(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey = orderDto.getOrderId();
			}else if(orderDto.getAction().equals("U")){
				//주문정보 수정
				orderMapper.updateOrderInfo(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}else if(orderDto.getAction().equals("T")){
				//주문정보 수정
				orderMapper.updateOrderHold(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}else if(orderDto.getAction().equals("S")){
				//주문정보 수정
				orderMapper.updateOrderPass(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}else if(orderDto.getAction().equals("W")){
				//주문정보 수정
				orderMapper.updateOrderPrcd(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("주문정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
 
	//주문정보 삭제
	@Transactional
	public String setOrderInfoDelete(List<OrderDetailMgtDto> orderList){
		
		String resultStr = "success";
		try {
			
			LotInfoDto lotInfoDto = new LotInfoDto();
			WrkinTeamMgtDto wrkinTeamMgtDto = new WrkinTeamMgtDto();
			ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto();
			ArrayList<WrkinTeamMgtDto> orderDeleteList = new ArrayList<WrkinTeamMgtDto>();
			ArrayList<ItemStockMgtDto> itemDeleteList = new ArrayList<ItemStockMgtDto>();
			
			//주문정보 반복
			for(OrderDetailMgtDto orderDto : orderList){
				lotInfoDto.setOrderId(orderDto.getOrderId());
		
				//해당 order의 Lot 정보 조회
				List<LotInfoDto> lotInfoList = getLotList(lotInfoDto);
					//Lot 정보 반복
					for(LotInfoDto lotInfo : lotInfoList) {
						
			 			wrkinTeamMgtDto.setLotId(lotInfo.getLotId());
			 			itemStockMgtDto.setItemMgtId(lotInfo.getLotId());
			 			
						//해당 Lot의 작업지시 조회
						List<WrkinTeamMgtDto> asgnList = prodWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto);
						//해당 Lot의 제품 관리 정보 조회
						List<ItemStockMgtDto> itemList = itemStockService.getStockList(itemStockMgtDto);
						//작업지시 반복
						for (WrkinTeamMgtDto asgnDto : asgnList) {
							orderDeleteList.add(asgnDto);
						}
						for (ItemStockMgtDto itemDto : itemList) {
							itemDeleteList.add(itemDto);
						}
					}
				
				for(WrkinTeamMgtDto deleteInfo : orderDeleteList) {
					//진행중인 작업 존재시 수주 삭제 불가능 
					if(!deleteInfo.getProdAsmState().equals("prod_sta00")) {
						resultStr="workBad1";
						throw new Exception();
					}
				}
			
			//작업지시 삭제
			prodWorkService.setProdWorkAsgnDelete(orderDeleteList);
			//제품 관리 삭제
			itemStockService.deleteItemStock(itemDeleteList);	
			//Lot 정보 삭제
			setLotInfoDelete(lotInfoList);
			//주문정보 삭제
			orderMapper.deleteOrderInfo(orderDto);
			}
		} catch (Exception e) {
			if(!resultStr.equals("workBad1")) {
				resultStr = "bad";
			}
		}
		return resultStr;
	}
	
	//LOT조회
	public PageInfo<LotInfoDto> getLotList(LotInfoDto lotInfoDto, PageRequestVo pageRequestVo){
		List<LotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = orderMapper.selectLotListCount(lotInfoDto);
			if (rowCount > 0) {
				//List
				lotList = orderMapper.selectLotList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<LotInfoDto>();
		}
		return new PageInfo<LotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	//Lot Info 조회
		public List<LotInfoDto> getLotList(LotInfoDto lotInfoDto) {
			List<LotInfoDto> lotInfoList = null;
			try {
				lotInfoList = orderMapper.selectLotList(lotInfoDto);
			} catch (Exception e) {
				throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
			}
			if (lotInfoList == null) {
				lotInfoList = new ArrayList<LotInfoDto>();
			}
			return lotInfoList;
		}
	
	//Lot정보 입력/수정/tkrwp(order-child)
	@Transactional
	public String setOrderLotSave(OrderDetailMgtDto orderDto){
		String returnKey = "";
		try {
			ArrayList<WrkinTeamMgtDto> workList = new ArrayList<WrkinTeamMgtDto>();
			lot: for(LotInfoDto lotDto : orderDto.getChildLotList()) {
				lotDto.setCreatorId(JteUtils.getUserId());
				lotDto.setUpdatorId(JteUtils.getUserId());
				lotDto.setOrderId(orderDto.getOrderId());
				
				//품목정보 불러오기
				ItemMgtDto itemMgtDto = new ItemMgtDto();
				WrkinTeamMgtDto wrkinTeamMgtDto = new WrkinTeamMgtDto();
				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto();
				itemMgtDto.setFirstIndex(1);
				itemMgtDto.setLastIndex(1);
				itemMgtDto.setItemId(lotDto.getItemId());
				itemMgtDto = itemMapper.selectItemList(itemMgtDto).get(0);
				
				if(lotDto.getAction().equals("C")) {
					//Lot 상태 기본값 입력
					lotDto.setLotState("ord_sta06");
					//Lot 구분 기본값 입력
					lotDto.setLotType("ord_div01");
					
					//단가 계산(자재비용)
					lotDto.setLotMtrlCost(itemMgtDto.getItemMtrlCost() * lotDto.getLotQty());
					//단가 계산(인건비용)
					lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
					
					//Lot 입력
					orderMapper.insertLotInfo(lotDto);
					returnKey = lotDto.getLotId();
					
					//품목 수량 관리 테이블 저장
					ItemStockMgtDto itemstockDto = new ItemStockMgtDto(lotDto.getItemId(), lotDto.getLotId(), "LOT", lotDto.getOrderStdt(), 0, 0, "수주에 의한 등록");
					
					itemStockService.insertItemStock(itemstockDto);
				}else if(lotDto.getAction().equals("U")){
					//단가 계산(자재비용)
					lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
					//단가 계산(인건비용)
					lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
					
					//Lot정보 수정
					orderMapper.updateLotInfo(lotDto);
					returnKey = lotDto.getLotId();
				}else if(lotDto.getAction().equals("D")) {
					wrkinTeamMgtDto.setLotId(lotDto.getLotId());
		 			itemStockMgtDto.setItemMgtId(lotDto.getLotId());
		 			
					//해당 Lot의 작업지시 조회
					List<WrkinTeamMgtDto> asgnList = prodWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto);
					for (WrkinTeamMgtDto asgnDto : asgnList) {
						if(!asgnDto.getProdAsmState().equals("prod_sta00")) {
							returnKey = "";
							break lot;
						}
						workList.add(asgnDto);
					}
					for (WrkinTeamMgtDto asgnDto2 : workList) {
						wrkinTeamMgtDto.setProdAsmId(asgnDto2.getProdAsmId());
						List<WrkinTeamMgtDto> workInfoList = prodWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto);
						
						//작업정보 반복
						for(WrkinTeamMgtDto workInfo : workInfoList) {
							//작업정보 삭제 
							productWorkMapper.deleteProdWorkRoutSheet(asgnDto2);
						}
						//작업지시 삭제
						productWorkMapper.deleteProdWorkAsgn(asgnDto2);
					}
					orderMapper.deleteLotInfo(lotDto);
					itemStockMgtMapper.deleteItemStock(itemStockMgtDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("Lot정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//Lot정보 입력/수정(기본)
	@Transactional
	public int setLotInfoSave(LotInfoDto lotDto){
		int returnKey = 0;
		try {
			lotDto.setCreatorId(JteUtils.getUserId());
			lotDto.setUpdatorId(JteUtils.getUserId());
			//품목정보 불러오기
			ItemMgtDto itemMgtDto = new ItemMgtDto();
			itemMgtDto.setFirstIndex(1);
			itemMgtDto.setLastIndex(1);
			itemMgtDto.setItemId(lotDto.getItemId());
			itemMgtDto = itemMapper.selectItemList(itemMgtDto).get(0);
			
			if(lotDto.getAction().equals("C")) {
				//Lot 상태 기본값 입력
				lotDto.setLotState("ord_sta06");
				//Lot 구분 기본값 입력
				lotDto.setLotType("ord_div01");
				
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemMtrlCost() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				
				//Lot 입력
				orderMapper.insertLotInfo(lotDto);
				returnKey = lotDto.getLotSeq();
				
				//품목 수량 관리 테이블 저장
				ItemStockMgtDto itemstockDto = new ItemStockMgtDto(lotDto.getItemId(), lotDto.getLotId(), "LOT", lotDto.getOrderStdt(), 0, 0, "수주에 의한 등록");
				
				itemStockService.insertItemStock(itemstockDto);
			}else if(lotDto.getAction().equals("U")){
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				
				//Lot정보 수정
				orderMapper.updateLotInfo(lotDto);
				returnKey = lotDto.getLotSeq();
				
				
			}else if(lotDto.getAction().equals("RE")) {
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				//Lot 입력
				orderMapper.insertClaimReLotInfo(lotDto);

				returnKey = lotDto.getLotSeq();
			}else if(lotDto.getAction().equals("LOT")){
				//Lot 착수
				orderMapper.updateLotPass(lotDto);
				
				returnKey =lotDto.getLotSeq();
			}
		} catch (Exception e) {
			returnKey = 0;
			throw new BusinessException("Lot정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//Lot정보 삭제(기본)
	@Transactional
	public int setLotInfoDelete(List<LotInfoDto> lotList){
		int resultInt = -1;
		try {
			for(LotInfoDto lotInfoDto : lotList){
				orderMapper.deleteLotInfo(lotInfoDto);
			}
 
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Lot정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	
}