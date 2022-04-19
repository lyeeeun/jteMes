package jin.mes.cform.orderMgt.claimMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.claimMgt.KwangjinClaimMgtDto;

@Mapper
public interface KwangjinClaimMgtMapper {
	public List<KwangjinClaimMgtDto> selectLotClaimList(KwangjinClaimMgtDto kwangjinClaimDto);
	
	public int selectLotClaimListCount(KwangjinClaimMgtDto kwangjinClaimDto);
	
	public void insertClaimInfo(KwangjinClaimMgtDto kwangjinClaimDto);
	
	public void updateClaimInfo(KwangjinClaimMgtDto kwangjinClaimDto);
	
	public int deleteClaimInfo(KwangjinClaimMgtDto kwangjinClaimDto);
	
	
}
