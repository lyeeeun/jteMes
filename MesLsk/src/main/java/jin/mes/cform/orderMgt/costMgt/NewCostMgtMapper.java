package jin.mes.cform.orderMgt.costMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtDto;

@Mapper
public interface NewCostMgtMapper {
	public List<NewOrderDetailMgtDto> selectOrderCostList(NewOrderDetailMgtDto newOrderDto);
	
	public int selectOrderCostListCount(NewOrderDetailMgtDto newOrderDto);
	
	public List<NewLotInfoDto> selectLotCostList(NewLotInfoDto newLotInfoDto);
	
	public int selectLotCostListCount(NewLotInfoDto newLotInfoDto);
}
