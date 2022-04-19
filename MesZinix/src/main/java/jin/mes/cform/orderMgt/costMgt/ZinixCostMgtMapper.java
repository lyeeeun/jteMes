package jin.mes.cform.orderMgt.costMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface ZinixCostMgtMapper {
	public List<ZinixCostMgtDto> selectLotCostList(ZinixCostMgtDto costMgtDto);
	public int selectLotCostListCount(ZinixCostMgtDto costMgtDto);
}
