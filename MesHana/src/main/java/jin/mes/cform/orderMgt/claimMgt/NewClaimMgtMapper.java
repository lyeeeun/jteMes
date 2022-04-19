package jin.mes.cform.orderMgt.claimMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.claimMgt.NewClaimMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtDto;
import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;

@Mapper
public interface NewClaimMgtMapper {
	public List<NewOrderDetailMgtDto> selectOrderClaimList(NewOrderDetailMgtDto newOrderDto);
	
	public int selectOrderClaimListCount(NewOrderDetailMgtDto newOrderDto);
	
	public List<NewClaimMgtDto> selectLotClaimList(NewClaimMgtDto newClaimDto);
	
	public int selectLotClaimListCount(NewClaimMgtDto newClaimDto);
	
	public void insertClaimInfo(NewClaimMgtDto newClaimDto);
	
	public void updateClaimInfo(NewClaimMgtDto newClaimDto);
	
	public int deleteClaimInfo(NewClaimMgtDto newClaimDto);
	
	public List<NewInfergodsMgtDto> selectRtlDefectList(NewClaimMgtDto newClaimDto);
	
	public void insertRtlDefectList(NewClaimMgtDto newClaimDto, String badCode, int badQty, String chkUser);
	
	public void updateRtlDefectList(NewClaimMgtDto newClaimDto, String badCode, int badQty, String chkUser);
	
	public void deleteRtlDefectList(NewClaimMgtDto newClaimDto, String badCode);
	
	public void updateReorder(NewClaimMgtDto newClaimDto);
	
	public List<NewClaimMgtDto> selectClaimInfo(NewClaimMgtDto newClaimDto);
	
	public int selectClaimInfoCount(NewClaimMgtDto newClaimDto);
	
}
