package jin.mes.cform.ship.pickMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ZinixPickMgtMapper {
	
	public List<ZinixPickMgtDto> selectPickInfo(ZinixPickMgtDto pickMgtDto);
	public int selectPickInfoCount(ZinixPickMgtDto pickMgtDto);
	
	public List<ZinixPickMgtDto> selectBarcodeInfo(ZinixPickMgtDto pickMgtDto);
	public int selectBarcodeInfoCount(ZinixPickMgtDto pickMgtDto);
	public List<ZinixPickMgtDto> selectBarcodeInfoAll(ZinixPickMgtDto pickMgtDto);
	
	public void insertPickInfo(ZinixPickMgtDto pickMgtDto);
	public void insertBarcode(ZinixPickMgtDto pickMgtDto);

	public void updatePickInfo(ZinixPickMgtDto pickMgtDto);
	
	public void deletePickInfo(ZinixPickMgtDto pickMgtDto);
	public void deleteBarcode(ZinixPickMgtDto pickMgtDto);
	
	public void updatePackageStock(ZinixPickMgtDto pickMgtDto);
	
}
