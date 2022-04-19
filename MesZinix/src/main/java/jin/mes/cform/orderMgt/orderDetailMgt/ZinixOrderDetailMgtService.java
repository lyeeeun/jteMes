package jin.mes.cform.orderMgt.orderDetailMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtMapper;
import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtService;
import jin.mes.cform.mfgMgt.productWork.ZinixProductWorkMapper;
import jin.mes.cform.mfgMgt.productWork.ZinixProductWorkService;
import jin.mes.cform.basMgt.operMgt.itemMgt.ZinixItemMgtDto;
import jin.mes.cform.basMgt.operMgt.itemMgt.ZinixItemMgtMapper;
import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixOrderDetailMgtService {
	
	@Resource
	ZinixOrderDetailMgtMapper zinixOrderMapper;
	
	@Resource
	ZinixItemMgtMapper zinixItemMapper;
	
	@Resource
	ZinixItemStockMgtMapper zinixItemStockMgtMapper;
	
	@Autowired
	ZinixItemStockMgtService zinixItemStockService; 
	
	@Autowired
	ZinixMtrlMgtService mtrlMgtService;
	
	@Autowired
	ZinixProductWorkService zinixProdWorkService;
	
	@Autowired
	ZinixProductWorkMapper zinixProductWorkMapper;
	
	//수주조회(page)
	public PageInfo<ZinixOrderDetailMgtDto> getOrderList(ZinixOrderDetailMgtDto orderDto, PageRequestVo pageRequestVo){
		List<ZinixOrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixOrderMapper.selectOrderListCount(orderDto);
			if (rowCount > 0) {
				//List
				orderList = zinixOrderMapper.selectOrderList(orderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<ZinixOrderDetailMgtDto>();
		}
		return new PageInfo<ZinixOrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}
	
	//수주정보 팝업조회(order-child)
	public ZinixOrderDetailMgtDto getOrderPop(ZinixOrderDetailMgtDto orderDto){
		ZinixOrderDetailMgtDto orderPop = null;
		
		try {
			
			orderPop = zinixOrderMapper.selectOrderOne(orderDto);
			
			//해당 수주에 포함된 Lot 정보 조회
			if(!orderPop.getOrderId().equals(null)) {
				ZinixLotInfoDto lotInfoDto = new ZinixLotInfoDto();
				lotInfoDto.setOrderId(orderPop.getOrderId());
				orderPop.setChildLotList(zinixOrderMapper.selectOrderChild(lotInfoDto));
			}
		} catch (Exception e) {
			throw new BusinessException("수주팝업 조회 에러입니다. : " + e.getMessage());
		}
		return orderPop;
	}
	
	//주문정보 입력/수정
	@Transactional(rollbackFor = {Exception.class})
	public String setOrderInfoSave(ZinixOrderDetailMgtDto orderDto){
		String returnKey = "";
		try {
			orderDto.setCreatorId(JteUtils.getUserId());
			orderDto.setUpdatorId(JteUtils.getUserId());
			
			if(orderDto.getAction().equals("C")) {
				//주문정보 입력
				orderDto.setOrderState("ordPrcd00");
				zinixOrderMapper.insertOrderInfo(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey = orderDto.getOrderId();
			}else if(orderDto.getAction().equals("U")){
				//주문정보 수정
				zinixOrderMapper.updateOrderInfo(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}else if(orderDto.getAction().equals("T")){
				//주문정보 수정
				zinixOrderMapper.updateOrderHold(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}else if(orderDto.getAction().equals("S")){
				//주문정보 수정
				zinixOrderMapper.updateOrderPass(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}else if(orderDto.getAction().equals("W")){
				//주문정보 수정
				zinixOrderMapper.updateOrderPrcd(orderDto);
				
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
	public String setOrderInfoDelete(List<ZinixOrderDetailMgtDto> orderList){
		
		String resultStr = "success";
		try {
			
			ZinixLotInfoDto lotInfoDto = new ZinixLotInfoDto();
			ZinixWrkinTeamMgtDto wrkinTeamMgtDto = new ZinixWrkinTeamMgtDto();
			ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto();
			ArrayList<ZinixWrkinTeamMgtDto> orderDeleteList = new ArrayList<ZinixWrkinTeamMgtDto>();
			ArrayList<ZinixItemStockMgtDto> itemDeleteList = new ArrayList<ZinixItemStockMgtDto>();
			
			//주문정보 반복
			for(ZinixOrderDetailMgtDto orderDto : orderList){
				lotInfoDto.setOrderId(orderDto.getOrderId());
		
				//해당 order의 Lot 정보 조회
				List<ZinixLotInfoDto> lotInfoList = getLotList(lotInfoDto);
					//Lot 정보 반복
					for(ZinixLotInfoDto lotInfo : lotInfoList) {
						
			 			wrkinTeamMgtDto.setLotId(lotInfo.getLotId());
			 			itemStockMgtDto.setItemMgtId(lotInfo.getLotId());
			 			
						//해당 Lot의 작업지시 조회
						List<ZinixWrkinTeamMgtDto> asgnList = zinixProdWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto);
						//해당 Lot의 제품 관리 정보 조회
						List<ZinixItemStockMgtDto> itemList = zinixItemStockService.getStockList(itemStockMgtDto);
						//작업지시 반복
						for (ZinixWrkinTeamMgtDto asgnDto : asgnList) {
							orderDeleteList.add(asgnDto);
						}
						for (ZinixItemStockMgtDto itemDto : itemList) {
							itemDeleteList.add(itemDto);
						}
					}
				
				for(ZinixWrkinTeamMgtDto deleteInfo : orderDeleteList) {
					//진행중인 작업 존재시 수주 삭제 불가능 
					if(!deleteInfo.getProdAsmState().equals("prod_sta00")) {
						resultStr="workBad1";
						throw new Exception();
					}
				}
			
			//작업지시 삭제
			zinixProdWorkService.setProdWorkAsgnDelete(orderDeleteList);
			//제품 관리 삭제
			zinixItemStockService.deleteItemStock(itemDeleteList);	
			//Lot 정보 삭제
			setLotInfoDelete(lotInfoList);
			//주문정보 삭제
			zinixOrderMapper.deleteOrderInfo(orderDto);
			}
		} catch (Exception e) {
			if(!resultStr.equals("workBad1")) {
				resultStr = "bad";
			}
		}
		return resultStr;
	}
	
	

	//LOT조회
	public PageInfo<ZinixLotInfoDto> getLotList(ZinixLotInfoDto lotInfoDto, PageRequestVo pageRequestVo){
		List<ZinixLotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixOrderMapper.selectLotListCount(lotInfoDto);
			if (rowCount > 0) {
				//List
				lotList = zinixOrderMapper.selectLotList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<ZinixLotInfoDto>();
		}
		return new PageInfo<ZinixLotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	//Lot Info 조회
		public List<ZinixLotInfoDto> getLotList(ZinixLotInfoDto lotInfoDto) {
			List<ZinixLotInfoDto> lotInfoList = null;
			try {
				lotInfoList = zinixOrderMapper.selectLotList(lotInfoDto);
			} catch (Exception e) {
				throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
			}
			if (lotInfoList == null) {
				lotInfoList = new ArrayList<ZinixLotInfoDto>();
			}
			return lotInfoList;
		}
	
	//Lot정보 입력/수정/tkrwp(order-child)
	@Transactional
	public String setOrderLotSave(ZinixOrderDetailMgtDto orderDto){
		String returnKey = "";
		try {
			ArrayList<ZinixWrkinTeamMgtDto> workList = new ArrayList<ZinixWrkinTeamMgtDto>();
			lot: for(ZinixLotInfoDto lotDto : orderDto.getChildLotList()) {
				lotDto.setCreatorId(JteUtils.getUserId());
				lotDto.setUpdatorId(JteUtils.getUserId());
				lotDto.setOrderId(orderDto.getOrderId());
				
				//품목정보 불러오기
				ZinixItemMgtDto itemMgtDto = new ZinixItemMgtDto();
				ZinixWrkinTeamMgtDto wrkinTeamMgtDto = new ZinixWrkinTeamMgtDto();
				ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto();
				itemMgtDto.setFirstIndex(1);
				itemMgtDto.setLastIndex(1);
				itemMgtDto.setItemId(lotDto.getItemId());
				itemMgtDto = zinixItemMapper.selectItemList(itemMgtDto).get(0);
				
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
					zinixOrderMapper.insertLotInfo(lotDto);
					returnKey = lotDto.getLotId();
					
					//품목 수량 관리 테이블 저장
					ZinixItemStockMgtDto itemstockDto = new ZinixItemStockMgtDto(lotDto.getItemId(), lotDto.getLotId(), "LOT", lotDto.getOrderStdt(), 0, 0, "수주에 의한 등록");
					
					zinixItemStockService.insertItemStock(itemstockDto);
				}else if(lotDto.getAction().equals("U")){
					//단가 계산(자재비용)
					lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
					//단가 계산(인건비용)
					lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
					
					//Lot정보 수정
					zinixOrderMapper.updateLotInfo(lotDto);
					returnKey = lotDto.getLotId();
				}else if(lotDto.getAction().equals("D")) {
					wrkinTeamMgtDto.setLotId(lotDto.getLotId());
		 			itemStockMgtDto.setItemMgtId(lotDto.getLotId());
		 			
					//해당 Lot의 작업지시 조회
					List<ZinixWrkinTeamMgtDto> asgnList = zinixProdWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto);
					for (ZinixWrkinTeamMgtDto asgnDto : asgnList) {
						if(!asgnDto.getProdAsmState().equals("prod_sta00")) {
							returnKey = "";
							break lot;
						}
						workList.add(asgnDto);
					}
					for (ZinixWrkinTeamMgtDto asgnDto2 : workList) {
						wrkinTeamMgtDto.setProdAsmId(asgnDto2.getProdAsmId());
						List<ZinixWrkinTeamMgtDto> workInfoList = zinixProdWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto);
						
						//작업정보 반복
						for(ZinixWrkinTeamMgtDto workInfo : workInfoList) {
							//작업정보 삭제 
							zinixProductWorkMapper.deleteProdWorkRoutSheet(asgnDto2);
						}
						//작업지시 삭제
						zinixProductWorkMapper.deleteProdWorkAsgn(asgnDto2);
					}
					zinixOrderMapper.deleteLotInfo(lotDto);
					zinixItemStockMgtMapper.deleteItemStock(itemStockMgtDto);
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
	public int setLotInfoSave(ZinixLotInfoDto lotDto){
		int returnKey = 0;
		try {
			lotDto.setCreatorId(JteUtils.getUserId());
			lotDto.setUpdatorId(JteUtils.getUserId());
			//품목정보 불러오기
			ZinixItemMgtDto itemMgtDto = new ZinixItemMgtDto();
			itemMgtDto.setFirstIndex(1);
			itemMgtDto.setLastIndex(1);
			itemMgtDto.setItemId(lotDto.getItemId());
			itemMgtDto = zinixItemMapper.selectItemList(itemMgtDto).get(0);
			
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
				zinixOrderMapper.insertLotInfo(lotDto);
				returnKey = lotDto.getLotSeq();
				
				//품목 수량 관리 테이블 저장
				ZinixItemStockMgtDto itemstockDto = new ZinixItemStockMgtDto(lotDto.getItemId(), lotDto.getLotId(), "LOT", lotDto.getOrderStdt(), 0, 0, "수주에 의한 등록");
				
				zinixItemStockService.insertItemStock(itemstockDto);
			}else if(lotDto.getAction().equals("U")){
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				
				//Lot정보 수정
				zinixOrderMapper.updateLotInfo(lotDto);
				returnKey = lotDto.getLotSeq();
				
				
			}else if(lotDto.getAction().equals("RE")) {
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				//Lot 입력
				zinixOrderMapper.insertClaimReLotInfo(lotDto);

				returnKey = lotDto.getLotSeq();
			}
		} catch (Exception e) {
			returnKey = 0;
			throw new BusinessException("Lot정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//Lot정보 삭제(기본)
	@Transactional
	public int setLotInfoDelete(List<ZinixLotInfoDto> lotList){
		int resultInt = -1;
		try {
			//자재삭제
			for(ZinixLotInfoDto lotInfoDto : lotList){
				zinixOrderMapper.deleteLotInfo(lotInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Lot정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
}
