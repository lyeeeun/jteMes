package jin.mes.mapper.orderMgt.orderDetailMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderDetailMgt.OrderDetailMgtDto;

@Mapper
public interface OrderDetailMgtMapper {
	
	public List<OrderDetailMgtDto> selectOrderList(OrderDetailMgtDto orderDto);
	
	public int selectOrderListCount(OrderDetailMgtDto orderDto);
	
	public void insertOrderInfo(OrderDetailMgtDto orderDto);
	
	public void updateOrderInfo(OrderDetailMgtDto orderDto);
	
	public int deleteOrderInfo(OrderDetailMgtDto orderDto);
	
	
	public List<LotInfoDto> selectLotList(LotInfoDto lotInfoDto);
	
	public int selectLotListCount(LotInfoDto lotInfoDto);
	
	public void insertLotInfo(LotInfoDto lotInfoDto);
	
	public void updateLotInfo(LotInfoDto lotInfoDto);
	
	public int deleteLotInfo(LotInfoDto lotInfoDto);
	
	public void insertClaimReLotInfo(LotInfoDto lotInfoDto);
	
}
