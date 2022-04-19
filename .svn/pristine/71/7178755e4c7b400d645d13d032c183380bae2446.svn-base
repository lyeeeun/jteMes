package jin.mes.cform.orderMgt.costMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtDto;

@Mapper
public interface NewCostMgtMapper {
	public List<NewOrderDetailMgtDto> selectOrderCostList(NewOrderDetailMgtDto orderDto);
	
	public int selectOrderCostListCount(NewOrderDetailMgtDto orderDto);
	
	public List<NewLotInfoDto> selectLotCostList(NewLotInfoDto lotInfoDto);
	
	public int selectLotCostListCount(NewLotInfoDto lotInfoDto);
}
