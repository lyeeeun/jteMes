package jin.mes.form.orderMgt.orderSheet.orderDetailMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;

@Mapper
public interface OrderDetailMgtMapper {
	
	public List<OrderDetailMgtDto> selectOrderList(OrderDetailMgtDto orderDto);
	
	//팝업 조회
	public OrderDetailMgtDto selectOrderOne(OrderDetailMgtDto orderDto);
	
	public int selectOrderListCount(OrderDetailMgtDto orderDto);
	
	public void insertOrderInfo(OrderDetailMgtDto orderDto);
	
	public void updateOrderInfo(OrderDetailMgtDto orderDto);
	
	public int deleteOrderInfo(OrderDetailMgtDto orderDto);
	
	public void updateOrderHold(OrderDetailMgtDto orderDto);
	
	public void updateOrderPass(OrderDetailMgtDto orderDto);
	
	public void updateOrderPrcd(OrderDetailMgtDto orderDto);
	
	//해당수주에 포함된 LOT 조회(order-child)
	public List<LotInfoDto> selectOrderChild(LotInfoDto lotInfoDto);
	
	public List<LotInfoDto> selectLotList(LotInfoDto lotInfoDto);
	
	public int selectLotListCount(LotInfoDto lotInfoDto);
	
	public void insertLotInfo(LotInfoDto lotInfoDto);
	
	public void updateLotInfo(LotInfoDto lotInfoDto);
	
	public void updateLotPass(LotInfoDto lotInfoDto);
	
	public int deleteLotInfo(LotInfoDto lotInfoDto);
	
	public void insertClaimReLotInfo(LotInfoDto lotInfoDto);
	
}
