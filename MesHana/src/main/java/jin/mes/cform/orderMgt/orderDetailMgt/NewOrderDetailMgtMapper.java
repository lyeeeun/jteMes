package jin.mes.cform.orderMgt.orderDetailMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtDto;

@Mapper
public interface NewOrderDetailMgtMapper {
	
	public List<NewOrderDetailMgtDto> selectOrderList(NewOrderDetailMgtDto newOrderDto);
	
	public int selectOrderListCount(NewOrderDetailMgtDto newOrderDto);
	
	public void insertOrderInfo(NewOrderDetailMgtDto newOrderDto);
	
	public void updateOrderInfo(NewOrderDetailMgtDto newOrderDto);
	
	public int deleteOrderInfo(NewOrderDetailMgtDto newOrderDto);
	
	
	public List<NewLotInfoDto> selectLotList(NewLotInfoDto newLotInfoDto);
	
	public int selectLotListCount(NewLotInfoDto newLotInfoDto);
	
	public void insertLotInfo(NewLotInfoDto newLotInfoDto);
	
	public void updateLotInfo(NewLotInfoDto newLotInfoDto);
	
	public int deleteLotInfo(NewLotInfoDto newLotInfoDto);
	
	public void insertClaimReLotInfo(NewLotInfoDto newLotInfoDto);
	
	public void lotComplete(NewLotInfoDto newLotInfoDto);
	
}
