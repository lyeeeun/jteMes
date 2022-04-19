package jin.mes.form.orderMgt.orderSheet.orderConfirm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
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
public class OrderConfirmService {

	@Resource
	OrderConfirmMapper orderConfirmMapper;
	
	@Resource
	ItemMgtMapper itemMapper;
	
	@Resource
	ItemStockMgtMapper itemStockMgtMapper;
	
	@Autowired
	ItemStockMgtService itemStockService; 
	
	//주문서정보 조회
	public PageInfo<OrderConfirmDto> getOrderConfirmList(OrderConfirmDto orderConfirmDto, PageRequestVo pageRequestVo){
		List<OrderConfirmDto> orderList = null;
		int rowCount = 0;

		// Page Setting
		orderConfirmDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		orderConfirmDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = orderConfirmMapper.selectOrderListCount(orderConfirmDto);
			if (rowCount > 0) {
				//List
				orderList = orderConfirmMapper.selectOrderList(orderConfirmDto);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (orderList == null) {
			orderList = new ArrayList<OrderConfirmDto>();
		}
		return new PageInfo<OrderConfirmDto>(orderList, pageRequestVo, rowCount);
	}
	
	//주문서정보 등록/수정
	@Transactional
	public String setOrderConfirmSave(OrderConfirmDto orderConfirmDto){
		String returnKey = "";
		try {
			orderConfirmDto.setCreatorId(JteUtils.getUserId());
			orderConfirmDto.setUpdatorId(JteUtils.getUserId());
			
			if(orderConfirmDto.getAction().equals("C")) {
				//주문정보 입력
				orderConfirmDto.setOrderState("ordPrcd00");
				orderConfirmMapper.insertOrderInfo(orderConfirmDto);
				returnKey = orderConfirmDto.getOrderId();
			}else if(orderConfirmDto.getAction().equals("U")){
				//주문정보 수정
				orderConfirmMapper.updateOrderInfo(orderConfirmDto);
				
				returnKey =orderConfirmDto.getOrderId();
			}else if(orderConfirmDto.getAction().equals("ORDER")){
				orderConfirmMapper.updateOrderPass(orderConfirmDto);
				
				returnKey = orderConfirmDto.getOrderId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("주문정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	
	//LoT정보 조회
	public PageInfo<LotConfirmDto> getLotConfirmList(LotConfirmDto lotConfirmDto, PageRequestVo pageRequestVo){
		List<LotConfirmDto> lotList = null;
		int rowCount = 0;

		// Page Setting
		lotConfirmDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotConfirmDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = orderConfirmMapper.selectLotListCount(lotConfirmDto);
			if (rowCount > 0) {
				//List
				lotList = orderConfirmMapper.selectLotList(lotConfirmDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (lotList == null) {
			lotList = new ArrayList<LotConfirmDto>();
		}
		return new PageInfo<LotConfirmDto>(lotList, pageRequestVo, rowCount);
	}
	
	//LoT정보 등록/수정
	@Transactional
	public int setLotConfirmSave(LotConfirmDto lotConfirmDto){
		int returnKey = 0;
		//수주정보와 LOT 정보를 조회하기 위하여 등록된 LOT 조회
		LotConfirmDto lotConfirmItemDto = new LotConfirmDto();
		
		//현재시간
		SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Date dateTime = new Date();
		String nowDateTime = dateFormat.format(dateTime); 
		
		try {
			lotConfirmDto.setCreatorId(JteUtils.getUserId());
			lotConfirmDto.setUpdatorId(JteUtils.getUserId());
			//품목정보 불러오기
			ItemMgtDto itemMgtDto = new ItemMgtDto();
			itemMgtDto.setFirstIndex(1);
			itemMgtDto.setLastIndex(1);
			itemMgtDto.setItemId(lotConfirmDto.getItemId());
			itemMgtDto = itemMapper.selectItemList(itemMgtDto).get(0);
			
			if(lotConfirmDto.getAction().equals("C")) {
				//Lot 상태 기본값 입력
				lotConfirmDto.setLotState("ord_sta06");
				//Lot 구분 기본값 입력
				lotConfirmDto.setLotType("ord_div01");
				
				//단가 계산(자재비용)
				lotConfirmDto.setLotMtrlCost(itemMgtDto.getItemMtrlCost() * lotConfirmDto.getLotQty());
				//단가 계산(인건비용)
				lotConfirmDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotConfirmDto.getLotQty());
				//Lot 입력
				orderConfirmMapper.insertLotInfo(lotConfirmDto);
				returnKey = lotConfirmDto.getLotSeq();
				lotConfirmItemDto.setLotSeq(returnKey);
				lotConfirmItemDto = orderConfirmMapper.selectLotList(lotConfirmDto).get(0);
				
				
				//품목 수량 관리 테이블 저장
				ItemStockMgtDto itemstockDto = new ItemStockMgtDto(lotConfirmItemDto.getItemId(), lotConfirmItemDto.getLotId(), "LOT", lotConfirmItemDto.getOrderStdt(), 0, 0, "수주에 의한 등록");
				
				itemStockService.insertItemStock(itemstockDto);
				 

			}else if(lotConfirmDto.getAction().equals("U")){
				//단가 계산(자재비용)
				lotConfirmDto.setLotMtrlCost(itemMgtDto.getItemPrice() * lotConfirmDto.getLotQty());
				//단가 계산(인건비용)
				lotConfirmDto.setLotPersonCost(itemMgtDto.getItemPersonCost() * lotConfirmDto.getLotQty());
				
				//Lot정보 수정
				orderConfirmMapper.updateLotInfo(lotConfirmDto);
				returnKey = lotConfirmDto.getLotSeq();
				lotConfirmItemDto.setLotSeq(returnKey);
				lotConfirmItemDto = orderConfirmMapper.selectLotList(lotConfirmDto).get(0);
				
				
			}else if(lotConfirmDto.getAction().equals("ORLOT")){
				orderConfirmMapper.updateLotPass(lotConfirmDto);
				
				returnKey = lotConfirmDto.getLotSeq();
			}
		} catch (Exception e) {
			returnKey = 0;
			throw new BusinessException("Lot정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}

}
