package jin.mes.cform.orderMgt.orderDetailMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mtrl.itemRecevingMgt.KwangjinItemRecevingMgtMapper;
import jin.mes.cform.mtrl.itemRecevingMgt.KwangjinItemRecevingMgtService;
import jin.mes.cform.mfgMgt.productWork.KwangjinProductWorkMapper;
import jin.mes.cform.mfgMgt.productWork.KwangjinProductWorkService;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtMapper;
import jin.mes.cform.mtrl.itemRecevingMgt.KwangjinItemRecevingMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtService;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdcursitMgt.MtrlOdcursitMgtDto;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinOrderDetailMgtService {
	
	@Resource
	KwangjinOrderDetailMgtMapper kwangjinOrderDetailMgtMapper;
	
	@Resource
	ItemMgtMapper itemMapper;
	
	@Resource
	KwangjinItemRecevingMgtMapper kwangjinItemRecevingMgtMapper;
	
	@Autowired
	KwangjinItemRecevingMgtService kwangjinItemRecevingMgtService; 
	
	@Autowired
	MtrlMgtService mtrlMgtService;
	
	@Autowired
	KwangjinProductWorkService kwangjinProdWorkService;
	
	@Autowired
	KwangjinProductWorkMapper kwangjinProductWorkMapper;
	
	//수주조회(page)
	public PageInfo<KwangjinOrderDetailMgtDto> getOrderList(KwangjinOrderDetailMgtDto orderDto, PageRequestVo pageRequestVo){
		List<KwangjinOrderDetailMgtDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinOrderDetailMgtMapper.selectOrderListCount(orderDto);
			if (rowCount > 0) {
				//List
				orderList = kwangjinOrderDetailMgtMapper.selectOrderList(orderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<KwangjinOrderDetailMgtDto>();
		}
		return new PageInfo<KwangjinOrderDetailMgtDto>(orderList, pageRequestVo, rowCount);
	}
	
	//수주정보 팝업조회(order-child)
	public KwangjinOrderDetailMgtDto getOrderPop(KwangjinOrderDetailMgtDto orderDto){
		KwangjinOrderDetailMgtDto orderPop = null;
		
		try {
			
			orderPop = kwangjinOrderDetailMgtMapper.selectOrderOne(orderDto);
			
			//해당 수주에 포함된 Lot 정보 조회
			if(!orderPop.getOrderId().equals(null)) {
				KwangjinLotInfoDto lotInfoDto = new KwangjinLotInfoDto();
				lotInfoDto.setOrderId(orderPop.getOrderId());
				orderPop.setChildLotList(kwangjinOrderDetailMgtMapper.selectOrderChild(lotInfoDto));
			}
		} catch (Exception e) {
			throw new BusinessException("수주팝업 조회 에러입니다. : " + e.getMessage());
		}
		return orderPop;
	}
	
	//주문정보 입력/수정
	@Transactional(rollbackFor = {Exception.class})
	public String setOrderInfoSave(KwangjinOrderDetailMgtDto orderDto){
		String returnKey = "";
		try {
			orderDto.setCreatorId(JteUtils.getUserId());
			orderDto.setUpdatorId(JteUtils.getUserId());
			
			if(orderDto.getAction().equals("C")) {
				//주문정보 입력
				orderDto.setOrderState("ord_prcd01");
				kwangjinOrderDetailMgtMapper.insertOrderInfo(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey = orderDto.getOrderId();
			}else if(orderDto.getAction().equals("U")){
				//주문정보 수정
				kwangjinOrderDetailMgtMapper.updateOrderInfo(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}else if(orderDto.getAction().equals("T")){
				//주문정보 수정
				kwangjinOrderDetailMgtMapper.updateOrderHold(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}else if(orderDto.getAction().equals("S")){
				//주문정보 수정
				kwangjinOrderDetailMgtMapper.updateOrderPass(orderDto);
				
				//Lot정보 저장
				setOrderLotSave(orderDto);
				
				returnKey =orderDto.getOrderId();
			}else if(orderDto.getAction().equals("W")){
				//주문정보 수정
				kwangjinOrderDetailMgtMapper.updateOrderPrcd(orderDto);
				
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
	public String setOrderInfoDelete(List<KwangjinOrderDetailMgtDto> orderList){
		
		String resultStr = "success";
		try {
			
			KwangjinLotInfoDto lotInfoDto = new KwangjinLotInfoDto();
			WrkinTeamMgtDto wrkinTeamMgtDto = new WrkinTeamMgtDto();
			KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto = new KwangjinItemRecevingMgtDto();
			ArrayList<WrkinTeamMgtDto> orderDeleteList = new ArrayList<WrkinTeamMgtDto>();
			ArrayList<KwangjinItemRecevingMgtDto> itemDeleteList = new ArrayList<KwangjinItemRecevingMgtDto>();
			
			//주문정보 반복
			for(KwangjinOrderDetailMgtDto orderDto : orderList){
				lotInfoDto.setOrderId(orderDto.getOrderId());
		
				//해당 order의 Lot 정보 조회
				List<KwangjinLotInfoDto> lotInfoList = getLotList(lotInfoDto);
					//Lot 정보 반복
					for(KwangjinLotInfoDto lotInfo : lotInfoList) {
						
			 			wrkinTeamMgtDto.setLotId(lotInfo.getLotId());
			 			kwangjinItemRecevingMgtDto.setItemMgtId(lotInfo.getLotId());
			 			
						//해당 Lot의 작업지시 조회
						List<WrkinTeamMgtDto> asgnList = kwangjinProdWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto);
						//해당 Lot의 제품 관리 정보 조회
						List<KwangjinItemRecevingMgtDto> itemList = kwangjinItemRecevingMgtService.getStockList(kwangjinItemRecevingMgtDto);
						//작업지시 반복
						for (WrkinTeamMgtDto asgnDto : asgnList) {
							orderDeleteList.add(asgnDto);
						}
						for (KwangjinItemRecevingMgtDto itemDto : itemList) {
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
			kwangjinProdWorkService.setProdWorkAsgnDelete(orderDeleteList);
			//제품 관리 삭제
			kwangjinItemRecevingMgtService.deleteItemStock(itemDeleteList);	
			//Lot 정보 삭제
			setLotInfoDelete(lotInfoList);
			//주문정보 삭제
			kwangjinOrderDetailMgtMapper.deleteOrderInfo(orderDto);
			}
		} catch (Exception e) {
			if(!resultStr.equals("workBad1")) {
				resultStr = "bad";
			}
		}
		return resultStr;
	}
	
	@Transactional
	public String setOrderTieSave(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto){
		String returnKey = "";
		try {
			kwangjinOrderDetailMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinOrderDetailMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinOrderDetailMgtDto.getAction().equals("C")) {//
				//제품입력
				kwangjinOrderDetailMgtMapper.insertOrderTie(kwangjinOrderDetailMgtDto);

				returnKey = kwangjinOrderDetailMgtDto.getTieId();
			}else if(kwangjinOrderDetailMgtDto.getAction().equals("U")){//제품 변경
				//제품수정
				kwangjinOrderDetailMgtMapper.updateOrderTie(kwangjinOrderDetailMgtDto);
				
				returnKey =kwangjinOrderDetailMgtDto.getTieId();
			}	
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("제품 관리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//LOT조회
	public PageInfo<KwangjinLotInfoDto> getLotList(KwangjinLotInfoDto lotInfoDto, PageRequestVo pageRequestVo){
		List<KwangjinLotInfoDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinOrderDetailMgtMapper.selectLotListCount(lotInfoDto);
			if (rowCount > 0) {
				//List
				lotList = kwangjinOrderDetailMgtMapper.selectLotList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<KwangjinLotInfoDto>();
		}
		return new PageInfo<KwangjinLotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	//Lot Info 조회
		public List<KwangjinLotInfoDto> getLotList(KwangjinLotInfoDto lotInfoDto) {
			List<KwangjinLotInfoDto> lotInfoList = null;
			try {
				lotInfoList = kwangjinOrderDetailMgtMapper.selectLotList(lotInfoDto);
			} catch (Exception e) {
				throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
			}
			if (lotInfoList == null) {
				lotInfoList = new ArrayList<KwangjinLotInfoDto>();
			}
			return lotInfoList;
		}
	
	//Lot정보 입력/수정/tkrwp(order-child)
	@Transactional
	public String setOrderLotSave(KwangjinOrderDetailMgtDto orderDto){
		String returnKey = "";
		try {
			ArrayList<WrkinTeamMgtDto> workList = new ArrayList<WrkinTeamMgtDto>();
			lot: for(KwangjinLotInfoDto lotDto : orderDto.getChildLotList()) {
				lotDto.setCreatorId(JteUtils.getUserId());
				lotDto.setUpdatorId(JteUtils.getUserId());
				lotDto.setOrderId(orderDto.getOrderId());
				
				//품목정보 불러오기
				ItemMgtDto itemMgtDto = new ItemMgtDto();
				WrkinTeamMgtDto wrkinTeamMgtDto = new WrkinTeamMgtDto();
				KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto = new KwangjinItemRecevingMgtDto();
				itemMgtDto.setFirstIndex(1);
				itemMgtDto.setLastIndex(1);
				itemMgtDto.setItemId(lotDto.getItemId());
				itemMgtDto = itemMapper.selectItemList(itemMgtDto).get(0);
				
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
					kwangjinOrderDetailMgtMapper.insertLotInfo(lotDto);
					returnKey = lotDto.getLotId();
					
					//품목 수량 관리 테이블 저장
					KwangjinItemRecevingMgtDto itemRecevingMgtDto = new KwangjinItemRecevingMgtDto(lotDto.getItemId(), lotDto.getLotId(), "LOT", lotDto.getOrderStdt(), 0, 0, "수주에 의한 등록");
					
					kwangjinItemRecevingMgtService.insertItemRecevingMgt(itemRecevingMgtDto);
					
				}else if(lotDto.getAction().equals("U")){
					//단가 계산(자재비용)
					lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
					//단가 계산(인건비용)
					lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
					
					//Lot정보 수정
					kwangjinOrderDetailMgtMapper.updateLotInfo(lotDto);
					returnKey = lotDto.getLotId();
				}else if(lotDto.getAction().equals("D")) {
					wrkinTeamMgtDto.setLotId(lotDto.getLotId());
		 			kwangjinItemRecevingMgtDto.setItemMgtId(lotDto.getLotId());
		 			
					//해당 Lot의 작업지시 조회
					List<WrkinTeamMgtDto> asgnList = kwangjinProdWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto);
					for (WrkinTeamMgtDto asgnDto : asgnList) {
						if(!asgnDto.getProdAsmState().equals("prod_sta00")) {
							returnKey = "";
							break lot;
						}
						workList.add(asgnDto);
					}
					for (WrkinTeamMgtDto asgnDto2 : workList) {
						wrkinTeamMgtDto.setProdAsmId(asgnDto2.getProdAsmId());
						List<WrkinTeamMgtDto> workInfoList = kwangjinProdWorkService.getProdWorkRoutSheetList(wrkinTeamMgtDto);
						
						//작업정보 반복
						for(WrkinTeamMgtDto workInfo : workInfoList) {
							//작업정보 삭제 
							kwangjinProductWorkMapper.deleteProdWorkRoutSheet(asgnDto2);
						}
						//작업지시 삭제
						kwangjinProductWorkMapper.deleteProdWorkAsgn(asgnDto2);
					}
					kwangjinOrderDetailMgtMapper.deleteLotInfo(lotDto);
					kwangjinItemRecevingMgtMapper.deleteItemStock(kwangjinItemRecevingMgtDto);
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
	public int setLotInfoSave(KwangjinLotInfoDto lotDto){
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
				lotDto.setLotState("ord_sta01");
				//Lot 구분 기본값 입력
				lotDto.setLotType("ord_div01");
				
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemMtrlCost() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				
				//Lot 입력
				kwangjinOrderDetailMgtMapper.insertLotInfo(lotDto);
				returnKey = lotDto.getLotSeq();

			}else if(lotDto.getAction().equals("U")){
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				
				//Lot정보 수정
				kwangjinOrderDetailMgtMapper.updateLotInfo(lotDto);
				returnKey = lotDto.getLotSeq();
				
				
			}else if(lotDto.getAction().equals("RE")) {
				//단가 계산(자재비용)
				lotDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotDto.getLotQty());
				//단가 계산(인건비용)
				lotDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotDto.getLotQty());
				//Lot 입력
				kwangjinOrderDetailMgtMapper.insertClaimReLotInfo(lotDto);

				returnKey = lotDto.getLotSeq();
			}else if(lotDto.getAction().equals("LOT")){
				//Lot 착수
				kwangjinOrderDetailMgtMapper.updateLotPass(lotDto);
				
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
	public int setLotInfoDelete(List<KwangjinLotInfoDto> lotList){
		int resultInt = -1;
		try {
			for(KwangjinLotInfoDto lotInfoDto : lotList){
				kwangjinOrderDetailMgtMapper.deleteLotInfo(lotInfoDto);
			}
 
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Lot정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	
}
