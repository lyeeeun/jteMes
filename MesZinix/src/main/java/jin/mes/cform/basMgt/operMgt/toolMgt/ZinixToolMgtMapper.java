package jin.mes.cform.basMgt.operMgt.toolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.ZinixCompAddrDto;
import jin.mes.cform.basMgt.operMgt.compMgt.ZinixCompMgtDto;
import jin.mes.cform.basMgt.operMgt.toolMgt.ZinixToolMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixOrderDetailMgtDto;

@Mapper
public interface ZinixToolMgtMapper {

	public List<ZinixToolMgtDto> selectToolInfoList(ZinixToolMgtDto toolMgtDto);
	
	public int selectToolInfoCount(ZinixToolMgtDto toolMgtDto);
	
	public void insertToolInfo(ZinixToolMgtDto toolMgtDto);
	
	public void updateToolInfo(ZinixToolMgtDto toolMgtDto);
	
	public int deleteToolInfo(ZinixToolMgtDto toolMgtDto);
	
	public List<ZinixToolMgtDto> selectAllToolInfo(ZinixToolMgtDto toolMgtDto);
	
	
	public List<ZinixCompMgtDto> selectToolRtlCompList(ZinixCompMgtDto compDto);
	
	public int selectToolRtlCompCount(ZinixCompMgtDto compDto);
	
	public void insertToolRtlComp(ZinixToolCompMgtDto toolCompMgtDto);
	
	public int deleteToolRtlComp(ZinixToolCompMgtDto toolCompMgtDto);
	
	public ZinixCompMgtDto selectCompPop(ZinixCompMgtDto compMgtDto);
	public List<ZinixCompAddrDto> selectCompChild(ZinixCompAddrDto compAddrDto);
	
	
	//해당수주에 포함된 LOT 조회(order-child)
	public List<ZinixToolCompMgtDto> selectRtlCompChild(ZinixToolCompMgtDto toolCompDto);
	public ZinixToolMgtDto selectToolInfo(ZinixToolMgtDto toolDto);
	
	
}
