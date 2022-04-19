package jin.mes.cform.techMgt.techDocMgt;

import java.util.List;

import jin.mes.cform.techMgt.techDocMgt.KwangjinTechDocMgtDto;

public interface KwangjinTechDocMgtMapper {
	public List<KwangjinTechDocMgtDto> selectTechDocInfo(KwangjinTechDocMgtDto kwangjinTechDocMgtDto);
	public int selectTechDocInfoCount(KwangjinTechDocMgtDto kwangjinTechDocMgtDto);
	
	public List<KwangjinTechDocMgtDto> selectTechDocGroup(KwangjinTechDocMgtDto kwangjinTechDocMgtDto);
	
	public List<KwangjinTechDocMgtDto> selectTechDocRtlItem(KwangjinTechDocMgtDto kwangjinTechDocMgtDto);
	public int selectTechDocRtlItemCount(KwangjinTechDocMgtDto kwangjinTechDocMgtDto);
	
	public void insertTechDocRtlItem(KwangjinTechDocMgtDto kwangjinTechDocMgtDto);
	public void updateTechDocRtlItem(KwangjinTechDocMgtDto kwangjinTechDocMgtDto);
	
	public void insertTechDocInfo(KwangjinTechDocMgtDto kwangjinTechDocMgtDto);
	public void updateTechDocInfo(KwangjinTechDocMgtDto kwangjinTechDocMgtDto);
	
}
