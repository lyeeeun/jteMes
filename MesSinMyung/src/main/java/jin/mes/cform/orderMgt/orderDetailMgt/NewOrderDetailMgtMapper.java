package jin.mes.cform.orderMgt.orderDetailMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewOrderDetailMgtMapper {
	
	public List<NewOrderDetailMgtDto> selectOrderList(NewOrderDetailMgtDto orderDto);
	
	public int selectOrderListCount(NewOrderDetailMgtDto orderDto);
	
	public void insertOrderInfo(NewOrderDetailMgtDto orderDto);
	
	public void updateOrderInfo(NewOrderDetailMgtDto orderDto);
	
	public int deleteOrderInfo(NewOrderDetailMgtDto orderDto);
	
	
	public List<NewLotInfoDto> selectLotList(NewLotInfoDto lotInfoDto);
	
	public int selectLotListCount(NewLotInfoDto lotInfoDto);
	
	public void insertLotInfo(NewLotInfoDto lotInfoDto);
	
	public void updateLotInfo(NewLotInfoDto lotInfoDto);
	
	public int deleteLotInfo(NewLotInfoDto lotInfoDto);
	
	public void insertClaimReLotInfo(NewLotInfoDto lotInfoDto);
	
	public int selectDupleKeyCount(NewLotInfoDto lotInfoDto);
	
}
