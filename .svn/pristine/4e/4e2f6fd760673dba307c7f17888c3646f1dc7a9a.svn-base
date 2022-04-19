package jin.mes.mapper.basMgt.operMgt.toolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.toolMgt.ToolMgtDto;

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
	
	public void insertToolRtlComp(CompMgtDto compDto);
	
	public int deleteToolRtlComp(CompMgtDto compDto);
	
	
}
