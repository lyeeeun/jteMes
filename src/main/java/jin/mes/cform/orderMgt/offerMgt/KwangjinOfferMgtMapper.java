package jin.mes.cform.orderMgt.offerMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.offerMgt.KwangjinOfferMgtDto;

@Mapper
public interface KwangjinOfferMgtMapper {
	
	public List<KwangjinOfferMgtDto> selectOfferInfoList(KwangjinOfferMgtDto kwangjinOfferMgtDto);
	
	public int selectOfferInfoCount(KwangjinOfferMgtDto kwangjinOfferMgtDto);
	
	public void insertOfferInfo(KwangjinOfferMgtDto kwangjinOfferMgtDto);
	
	public void updateOfferInfo(KwangjinOfferMgtDto kwangjinOfferMgtDto);
	
	public int deleteOfferInfo(KwangjinOfferMgtDto kwangjinOfferMgtDto);
	
	
}
