package jin.mes.cform.barcode.barcodeBase;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ZinixBarcodeBaseMapper {
	
	//바코드 조회(page)
	public List<ZinixBarcodeBaseDto> selectBarcodeList(ZinixBarcodeBaseDto zinixBarcodeBaseDto);
	
	//바코드 조회(count)
	public int selectBarcodeCount(ZinixBarcodeBaseDto zinixBarcodeBaseDto);
	
	//바코드 입력 
	public void insertBarcodeBase(ZinixBarcodeBaseDto zinixBarcodeBaseDto);
	
	//바코드 수정
	public void updateBarcodeBase(ZinixBarcodeBaseDto zinixBarcodeBaseDto);
	
	//바코드 삭제
	public void deleteBarcodeBase(ZinixBarcodeBaseDto zinixBarcodeBaseDto);
}