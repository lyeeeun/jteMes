package jin.mes.form.ship.pickMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PickMgtMapper {
	
	public List<PickMgtDto> selectPickInfo(PickMgtDto pickMgtDto);
	public int selectPickInfoCount(PickMgtDto pickMgtDto);
	
	public List<PickMgtDto> selectBarcodeInfo(PickMgtDto pickMgtDto);
	public int selectBarcodeInfoCount(PickMgtDto pickMgtDto);
	public List<PickMgtDto> selectBarcodeInfoAll(PickMgtDto pickMgtDto);
	
	public void insertPickInfo(PickMgtDto pickMgtDto);
	public void insertBarcode(PickMgtDto pickMgtDto);

	public void updatePickInfo(PickMgtDto pickMgtDto);
	
	public void deletePickInfo(PickMgtDto pickMgtDto);
	public void deleteBarcode(PickMgtDto pickMgtDto);
	
	public void updatePackageStock(PickMgtDto pickMgtDto);
	
}
