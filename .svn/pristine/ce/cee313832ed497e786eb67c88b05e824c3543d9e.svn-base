package jin.mes.cform.ship.shipMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.ship.pickMgt.ZinixPickMgtDto;

@Mapper
public interface ZinixShipMgtMapper {
	
	public List<ZinixShipMgtDto> selectShipInfo(ZinixShipMgtDto shipMgtDto);
	public int selectShipInfoCount(ZinixShipMgtDto shipMgtDto);

	public List<ZinixShipMgtDto> selectShipRtlBarcode(ZinixShipMgtDto shipMgtDto);
	public int selectShipRtlBarcodeCount(ZinixShipMgtDto shipMgtDto);

	public List<ZinixShipMgtDto> selectBarcodeInfo(ZinixShipMgtDto shipMgtDto);
	public int selectBarcodeInfoCount(ZinixShipMgtDto shipMgtDto);
	
	public void insertShipInfo(ZinixShipMgtDto shipMgtDto);
	public void updateShipInfo(ZinixShipMgtDto shipMgtDto);
	public void deleteShipInfo(ZinixShipMgtDto shipMgtDto);
	
	public void insertShipRtlBarcode(ZinixShipMgtDto shipMgtDto);
	public void deleteShipRtlBarcode(ZinixShipMgtDto shipMgtDto);
	
	public String selectLotState(ZinixShipMgtDto shipMgtDto);
	public void updateLotState(ZinixShipMgtDto shipMgtDto);
	
	

}
