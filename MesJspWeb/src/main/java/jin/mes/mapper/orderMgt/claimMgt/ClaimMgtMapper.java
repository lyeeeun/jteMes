package jin.mes.mapper.orderMgt.claimMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.orderMgt.claimMgt.ClaimMgtDto;
import jin.mes.form.orderMgt.orderDetailMgt.OrderDetailMgtDto;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;

@Mapper
public interface ClaimMgtMapper {
	public List<OrderDetailMgtDto> selectOrderClaimList(OrderDetailMgtDto orderDto);
	
	public int selectOrderClaimListCount(OrderDetailMgtDto orderDto);
	
	public List<ClaimMgtDto> selectLotClaimList(ClaimMgtDto claimDto);
	
	public int selectLotClaimListCount(ClaimMgtDto claimDto);
	
	public void insertClaimInfo(ClaimMgtDto claimDto);
	
	public void updateClaimInfo(ClaimMgtDto claimDto);
	
	public int deleteClaimInfo(ClaimMgtDto claimDto);
	
	public List<InfergodsMgtDto> selectRtlDefectList(ClaimMgtDto claimDto);
	
	public void insertRtlDefectList(ClaimMgtDto claimDto, String badCode, int badQty, String chkUser);
	
	public void updateRtlDefectList(ClaimMgtDto claimDto, String badCode, int badQty, String chkUser);
	
	public void deleteRtlDefectList(ClaimMgtDto claimDto, String badCode);
	
	public void updateReorder(ClaimMgtDto claimDto);
	
	public List<ClaimMgtDto> selectClaimInfo(ClaimMgtDto claimDto);
	
	public int selectClaimInfoCount(ClaimMgtDto claimDto);
	
}
