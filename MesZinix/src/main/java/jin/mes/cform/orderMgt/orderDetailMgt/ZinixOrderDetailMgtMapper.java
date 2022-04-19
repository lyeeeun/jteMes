package jin.mes.cform.orderMgt.orderDetailMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixOrderDetailMgtDto;

@Mapper
public interface ZinixOrderDetailMgtMapper {
	
	public List<ZinixOrderDetailMgtDto> selectOrderList(ZinixOrderDetailMgtDto orderDto);
	
	//팝업 조회
	public ZinixOrderDetailMgtDto selectOrderOne(ZinixOrderDetailMgtDto orderDto);
	
	public int selectOrderListCount(ZinixOrderDetailMgtDto orderDto);
	
	public void insertOrderInfo(ZinixOrderDetailMgtDto orderDto);
	
	public void updateOrderInfo(ZinixOrderDetailMgtDto orderDto);
	
	public int deleteOrderInfo(ZinixOrderDetailMgtDto orderDto);
	
	public void updateOrderHold(ZinixOrderDetailMgtDto orderDto);
	
	public void updateOrderPass(ZinixOrderDetailMgtDto orderDto);
	
	public void updateOrderPrcd(ZinixOrderDetailMgtDto orderDto);
	
	//해당수주에 포함된 LOT 조회(order-child)
	public List<ZinixLotInfoDto> selectOrderChild(ZinixLotInfoDto lotInfoDto);
	
	public List<ZinixLotInfoDto> selectLotList(ZinixLotInfoDto lotInfoDto);
	
	public int selectLotListCount(ZinixLotInfoDto lotInfoDto);
	
	public void insertLotInfo(ZinixLotInfoDto lotInfoDto);
	
	public void updateLotInfo(ZinixLotInfoDto lotInfoDto);
	
	public int deleteLotInfo(ZinixLotInfoDto lotInfoDto);
	
	public void insertClaimReLotInfo(ZinixLotInfoDto lotInfoDto);
	
}
