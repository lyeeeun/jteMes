package jin.mes.form.basMgt.operMgt.toolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.compMgt.CompAddrDto;
import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.toolMgt.ToolMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;

@Mapper
public interface ToolMgtMapper {

	public List<ToolMgtDto> selectToolInfoList(ToolMgtDto toolMgtDto);
	
	public int selectToolInfoCount(ToolMgtDto toolMgtDto);
	
	public void insertToolInfo(ToolMgtDto toolMgtDto);
	
	public void updateToolInfo(ToolMgtDto toolMgtDto);
	
	public int deleteToolInfo(ToolMgtDto toolMgtDto);
	
	public List<ToolMgtDto> selectAllToolInfo(ToolMgtDto toolMgtDto);
	
	
	public List<CompMgtDto> selectToolRtlCompList(CompMgtDto compDto);
	
	public int selectToolRtlCompCount(CompMgtDto compDto);
	
	public void insertToolRtlComp(ToolCompMgtDto toolCompMgtDto);
	
	public int deleteToolRtlComp(ToolCompMgtDto toolCompMgtDto);
	
	public CompMgtDto selectCompPop(CompMgtDto compMgtDto);
	public List<CompAddrDto> selectCompChild(CompAddrDto compAddrDto);
	
	
	//해당수주에 포함된 LOT 조회(order-child)
	public List<ToolCompMgtDto> selectRtlCompChild(ToolCompMgtDto toolCompDto);
	public ToolMgtDto selectToolInfo(ToolMgtDto toolDto);
	
	
}
