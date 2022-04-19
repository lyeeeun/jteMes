package jin.mes.cform.orderMgt.claimMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtDto;
import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;

@Mapper
public interface NewClaimMgtMapper {
	public List<NewOrderDetailMgtDto> selectOrderClaimList(NewOrderDetailMgtDto orderDto);
	
	public int selectOrderClaimListCount(NewOrderDetailMgtDto orderDto);
	
	public List<NewClaimMgtDto> selectLotClaimList(NewClaimMgtDto claimDto);

	public int selectLotClaimListCount(NewClaimMgtDto claimDto);
	
	public void insertClaimInfo(NewClaimMgtDto claimDto);
	
	public void updateClaimInfo(NewClaimMgtDto claimDto);
	
	public int deleteClaimInfo(NewClaimMgtDto claimDto);
	
	public List<NewInfergodsMgtDto> selectRtlDefectList(NewClaimMgtDto claimDto);
	
	public void insertRtlDefectList(NewClaimMgtDto claimDto, String badCode, int badQty, String chkUser);
	
	public void updateRtlDefectList(NewClaimMgtDto claimDto, String badCode, int badQty, String chkUser);
	
	public void deleteRtlDefectList(NewClaimMgtDto claimDto, String badCode);
	
	public void updateReorder(NewClaimMgtDto claimDto);
	
	public List<NewClaimMgtDto> selectClaimInfo(NewClaimMgtDto claimDto);
	
	public int selectClaimInfoCount(NewClaimMgtDto claimDto);
	
}
