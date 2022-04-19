package jin.mes.form.orderMgt.orderSheet.deliveryStatus;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.orderMgt.orderSheet.deliveryStatus.DeliveryStatusDto;
import jin.mes.form.orderMgt.orderSheet.deliveryStatus.LotDeliveryStaDto;

@Mapper
public interface DeliveryStatusMapper {
	//납품현황 - LoT조회
	public List<DeliveryStatusDto> selectLotDeliveryStaList(DeliveryStatusDto deliveryStaDto);
	
	public int selectLotDeliveryStaListCount(DeliveryStatusDto deliveryStaDto);
	
	public List<DeliveryStatusDto> selectOrderSearchList(DeliveryStatusDto deliveryStaDto);
	
	public int selectOrderSearchListCount(DeliveryStatusDto deliveryStaDto);
	
	//납품현황 조회
	public List<LotDeliveryStaDto> selectDeliveryStatusList(LotDeliveryStaDto lotDeliveryStaDto);
	
	public int selectDeliveryStatusListCount(LotDeliveryStaDto lotDeliveryStaDto);
}
