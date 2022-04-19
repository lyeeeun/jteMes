package jin.mes.form.orderMgt.claimMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.orderMgt.claimMgt.ClaimMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;

@Mapper
public interface ClaimMgtMapper {
	public List<OrderDetailMgtDto> selectOrderClaimList(OrderDetailMgtDto newOrderDto);
	
	public int selectOrderClaimListCount(OrderDetailMgtDto newOrderDto);
	
	public List<ClaimMgtDto> selectLotClaimList(ClaimMgtDto newClaimDto);
	
	public int selectLotClaimListCount(ClaimMgtDto newClaimDto);
	
	public void insertClaimInfo(ClaimMgtDto newClaimDto);
	
	public void updateClaimInfo(ClaimMgtDto newClaimDto);
	
	public int deleteClaimInfo(ClaimMgtDto newClaimDto);
	
	public List<InfergodsMgtDto> selectRtlDefectList(ClaimMgtDto newClaimDto);
	
	public void insertRtlDefectList(ClaimMgtDto newClaimDto, String badCode, int badQty, String chkUser);
	
	public void updateRtlDefectList(ClaimMgtDto newClaimDto, String badCode, int badQty, String chkUser);
	
	public void deleteRtlDefectList(ClaimMgtDto newClaimDto, String badCode);
	
	public void updateReorder(ClaimMgtDto newClaimDto);
	
	public List<ClaimMgtDto> selectClaimInfo(ClaimMgtDto newClaimDto);
	
	public int selectClaimInfoCount(ClaimMgtDto newClaimDto);
	
	public List<OrderDetailMgtDto> selectOrderList(OrderDetailMgtDto newOrderDto);
	
	public int selectOrderListCount(OrderDetailMgtDto newOrderDto);
	
	public List<LotInfoDto> selectLotList(LotInfoDto LotInfoDto);
	
	public int selectLotListCount(LotInfoDto LotInfoDto);
	
}
