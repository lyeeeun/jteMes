package jin.mes.form.barcode.barcodeBase;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BarcodeBaseMapper {
	
	//바코드 조회(page)
	public List<BarcodeBaseDto> selectBarcodeList(BarcodeBaseDto barcodeBaseDto);
	
	//바코드 조회(count)
	public int selectBarcodeCount(BarcodeBaseDto barcodeBaseDto);
	
	//바코드 입력 
	public void insertBarcodeBase(BarcodeBaseDto barcodeBaseDto);
	
	//바코드 수정
	public void updateBarcodeBase(BarcodeBaseDto barcodeBaseDto);
	
	//바코드 삭제
	public void deleteBarcodeBase(BarcodeBaseDto barcodeBaseDto);
}