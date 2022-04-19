package jin.mes.cform.orderMgt.orderDetailMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.orderDetailMgt.KwangjinLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.KwangjinOrderDetailMgtDto;

@Mapper
public interface KwangjinOrderDetailMgtMapper {
	
	public List<KwangjinOrderDetailMgtDto> selectOrderList(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	//팝업 조회
	public KwangjinOrderDetailMgtDto selectOrderOne(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	public int selectOrderListCount(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	public void insertOrderInfo(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	public void updateOrderInfo(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	public int deleteOrderInfo(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	public void updateOrderHold(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	public void updateOrderPass(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	public void updateOrderPrcd(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	
	public void insertOrderTie(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	public void updateOrderTie(KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto);
	
	
	//해당수주에 포함된 LOT 조회(order-child)
	public List<KwangjinLotInfoDto> selectOrderChild(KwangjinLotInfoDto kwangjinLotInfoDto);
	
	public List<KwangjinLotInfoDto> selectLotList(KwangjinLotInfoDto kwangjinLotInfoDto);
	
	public int selectLotListCount(KwangjinLotInfoDto kwangjinLotInfoDto);
	
	public void insertLotInfo(KwangjinLotInfoDto kwangjinLotInfoDto);
	
	public void updateLotInfo(KwangjinLotInfoDto kwangjinLotInfoDto);
	
	public void updateLotPass(KwangjinLotInfoDto kwangjinLotInfoDto);
	
	public int deleteLotInfo(KwangjinLotInfoDto kwangjinLotInfoDto);
	
	public void insertClaimReLotInfo(KwangjinLotInfoDto kwangjinLotInfoDto);
	
}
