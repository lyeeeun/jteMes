package jin.mes.form.orderMgt.costMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;

@Mapper
public interface CostMgtMapper {
	public List<CostMgtDto> selectLotCostList(CostMgtDto costMgtDto);
	public int selectLotCostListCount(CostMgtDto costMgtDto);
}
