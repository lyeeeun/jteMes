package jin.mes.cform.orderMgt.claimMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.orderMgt.claimMgt.ZinixClaimMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixOrderDetailMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.ZinixInfergodsMgtDto;

@Mapper
public interface ZinixClaimMgtMapper {
	public List<ZinixOrderDetailMgtDto> selectOrderClaimList(ZinixOrderDetailMgtDto newOrderDto);
	
	public int selectOrderClaimListCount(ZinixOrderDetailMgtDto newOrderDto);
	
	public List<ZinixClaimMgtDto> selectLotClaimList(ZinixClaimMgtDto newClaimDto);
	
	public int selectLotClaimListCount(ZinixClaimMgtDto newClaimDto);
	
	public void insertClaimInfo(ZinixClaimMgtDto newClaimDto);
	
	public void updateClaimInfo(ZinixClaimMgtDto newClaimDto);
	
	public int deleteClaimInfo(ZinixClaimMgtDto newClaimDto);
	
	public List<ZinixInfergodsMgtDto> selectRtlDefectList(ZinixClaimMgtDto newClaimDto);
	
	public void insertRtlDefectList(ZinixClaimMgtDto newClaimDto, String badCode, int badQty, String chkUser);
	
	public void updateRtlDefectList(ZinixClaimMgtDto newClaimDto, String badCode, int badQty, String chkUser);
	
	public void deleteRtlDefectList(ZinixClaimMgtDto newClaimDto, String badCode);
	
	public void updateReorder(ZinixClaimMgtDto newClaimDto);
	
	public List<ZinixClaimMgtDto> selectClaimInfo(ZinixClaimMgtDto newClaimDto);
	
	public int selectClaimInfoCount(ZinixClaimMgtDto newClaimDto);
	
	public List<ZinixOrderDetailMgtDto> selectOrderList(ZinixOrderDetailMgtDto newOrderDto);
	
	public int selectOrderListCount(ZinixOrderDetailMgtDto newOrderDto);
	
	public List<ZinixLotInfoDto> selectLotList(ZinixLotInfoDto ZinixLotInfoDto);
	
	public int selectLotListCount(ZinixLotInfoDto ZinixLotInfoDto);
	
}
