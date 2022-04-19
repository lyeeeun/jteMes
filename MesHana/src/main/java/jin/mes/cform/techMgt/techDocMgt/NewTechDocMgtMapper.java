package jin.mes.cform.techMgt.techDocMgt;

import java.util.List;

import jin.mes.cform.techMgt.techDocMgt.NewTechDocMgtDto;

public interface NewTechDocMgtMapper {
	public List<NewTechDocMgtDto> selectTechDocInfo(NewTechDocMgtDto techDocMgtDto);
	public int selectTechDocInfoCount(NewTechDocMgtDto techDocMgtDto);
	
	public List<NewTechDocMgtDto> selectTechDocGroup(NewTechDocMgtDto techDocMgtDto);
	
	public List<NewTechDocMgtDto> selectTechDocRtlItem(NewTechDocMgtDto techDocMgtDto);
	public int selectTechDocRtlItemCount(NewTechDocMgtDto techDocMgtDto);
	
	public void insertTechDocRtlItem(NewTechDocMgtDto techDocMgtDto);
	public void updateTechDocRtlItem(NewTechDocMgtDto techDocMgtDto);
	
	public void insertTechDocInfo(NewTechDocMgtDto techDocMgtDto);
	public void updateTechDocInfo(NewTechDocMgtDto techDocMgtDto);
	
}
