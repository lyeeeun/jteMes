package jin.mes.form.orderMgt.orderSheet.orderConfirm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.orderMgt.orderSheet.orderConfirm.LotConfirmDto;
import jin.mes.form.orderMgt.orderSheet.orderConfirm.OrderConfirmDto;

@Mapper
public interface OrderConfirmMapper {
	//수주
	public List<OrderConfirmDto> selectOrderList(OrderConfirmDto orderConfirmDto);
	
	public int selectOrderListCount(OrderConfirmDto orderConfirmDto);
	
	public void insertOrderInfo(OrderConfirmDto orderConfirmDto);
	
	public void updateOrderInfo(OrderConfirmDto orderConfirmDto);
	
	public void updateOrderPass(OrderConfirmDto orderConfirmDto);
	
	
	//Lot
	public List<LotConfirmDto> selectLotList(LotConfirmDto lotConfirmDto);
	
	public int selectLotListCount(LotConfirmDto lotConfirmDto);
	
	public int insertLotInfo(LotConfirmDto lotConfirmDto);
	
	public int updateLotInfo(LotConfirmDto lotConfirmDto);
	
	public void updateLotPass(LotConfirmDto lotConfirmDto);
}
