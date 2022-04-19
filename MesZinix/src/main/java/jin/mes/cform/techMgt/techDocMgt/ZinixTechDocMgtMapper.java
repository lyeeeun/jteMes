package jin.mes.cform.techMgt.techDocMgt;

import java.util.List;

import jin.mes.cform.techMgt.techDocMgt.ZinixTechDocMgtDto;

public interface ZinixTechDocMgtMapper {
	public List<ZinixTechDocMgtDto> selectTechDocInfo(ZinixTechDocMgtDto techDocMgtDto);
	public int selectTechDocInfoCount(ZinixTechDocMgtDto techDocMgtDto);
	
	public List<ZinixTechDocMgtDto> selectTechDocGroup(ZinixTechDocMgtDto techDocMgtDto);
	
	public List<ZinixTechDocMgtDto> selectTechDocRtlItem(ZinixTechDocMgtDto techDocMgtDto);
	public int selectTechDocRtlItemCount(ZinixTechDocMgtDto techDocMgtDto);
	
	public void insertTechDocRtlItem(ZinixTechDocMgtDto techDocMgtDto);
	public void updateTechDocRtlItem(ZinixTechDocMgtDto techDocMgtDto);
	
	public void insertTechDocInfo(ZinixTechDocMgtDto techDocMgtDto);
	public void updateTechDocInfo(ZinixTechDocMgtDto techDocMgtDto);
	
}
