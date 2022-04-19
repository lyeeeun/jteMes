package jin.mes.cform.basMgt.operMgt.toolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.NewCompMgtDto;

@Mapper
public interface NewToolMgtMapper {

	public List<NewToolMgtDto> selectToolInfoList(NewToolMgtDto toolMgtDto);
	
	public int selectToolInfoCount(NewToolMgtDto toolMgtDto);
	
	public void insertToolInfo(NewToolMgtDto toolMgtDto);
	
	public void updateToolInfo(NewToolMgtDto toolMgtDto);
	
	public int deleteToolInfo(NewToolMgtDto toolMgtDto);
	
	public List<NewToolMgtDto> selectAllToolInfo(NewToolMgtDto toolMgtDto);
	
	
	public List<NewCompMgtDto> selectToolRtlCompList(NewCompMgtDto compDto);
	
	public int selectToolRtlCompCount(NewCompMgtDto compDto);
	
	public void insertToolRtlComp(NewCompMgtDto compDto);
	
	public int deleteToolRtlComp(NewCompMgtDto compDto);
	
	
}
