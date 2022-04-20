package jin.mes.common.excelUtil;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.userMgt.userAuth.UserAuthDto;
import jin.mes.form.facilMgt.facilCorMgt.FacilCorMgtDto;

@Mapper
public interface ExcelUtilMapper {
	
	public List<ExcelUtilDto> selectTableInfo(ExcelUtilDto excelUtilDto);
	public void insertExcelData(ExcelUtilDto excelUtilDto);
	public void insertExcelSetting(ExcelUtilDto excelUtilDto);
	public void updateExcelSetting(ExcelUtilDto excelUtilDto);
	public void deleteExcelSetting(ExcelUtilDto excelUtilDto);

	public List<ExcelUtilDto> selectTableTestInfo(ExcelUtilDto excelUtilDto);
	public void insertOrderMgt(ExcelUtilDto excelUtilDto);
	public void updateOrderMgt(ExcelUtilDto excelUtilDto);
	public void deleteOrderMgt(ExcelUtilDto excelUtilDto);
	
	public String[] selectCodeList(String cdId);
	public String[] selectRtlTableCodeList(ExcelUtilDto excelUtilDto);
	
	public int selectIsSet(ExcelUtilDto excelUtilDto);
	
}