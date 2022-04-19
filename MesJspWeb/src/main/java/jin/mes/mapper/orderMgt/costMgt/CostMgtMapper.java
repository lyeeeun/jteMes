package jin.mes.mapper.orderMgt.costMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderDetailMgt.OrderDetailMgtDto;

@Mapper
public interface CostMgtMapper {
	public List<OrderDetailMgtDto> selectOrderCostList(OrderDetailMgtDto orderDto);
	
	public int selectOrderCostListCount(OrderDetailMgtDto orderDto);
	
	public List<LotInfoDto> selectLotCostList(LotInfoDto lotInfoDto);
	
	public int selectLotCostListCount(LotInfoDto lotInfoDto);
}
