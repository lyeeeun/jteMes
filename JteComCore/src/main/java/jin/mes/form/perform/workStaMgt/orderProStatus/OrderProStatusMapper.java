package jin.mes.form.perform.workStaMgt.orderProStatus;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface OrderProStatusMapper {
	public List<OrderProStatusDto> selectOrderInfo(OrderProStatusDto orderProStatusDto);
	public int rowCount(OrderProStatusDto orderProStatusDto);
	public List<OrderProStatusDto> selectTotalOrderInfo(OrderProStatusDto orderProStatusDto);
}
