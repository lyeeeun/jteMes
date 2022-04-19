package jin.mes.cform.basMgt.operMgt.toolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.NewCompMgtDto;
import jin.mes.cform.basMgt.operMgt.toolMgt.NewToolMgtDto;

@Mapper
public interface NewToolMgtMapper {

	public List<NewToolMgtDto> selectToolInfoList(NewToolMgtDto newToolMgtDto);
	
	public int selectToolInfoCount(NewToolMgtDto newToolMgtDto);
	
	public void insertToolInfo(NewToolMgtDto newToolMgtDto);
	
	public void updateToolInfo(NewToolMgtDto newToolMgtDto);
	
	public int deleteToolInfo(NewToolMgtDto newToolMgtDto);
	
	public List<NewToolMgtDto> selectAllToolInfo(NewToolMgtDto newToolMgtDto);
	
	
	public List<NewCompMgtDto> selectToolRtlCompList(NewCompMgtDto newCompDto);
	
	public int selectToolRtlCompCount(NewCompMgtDto newCompDto);
	
	public void insertToolRtlComp(NewCompMgtDto newCompDto);
	
	public int deleteToolRtlComp(NewCompMgtDto newCompDto);
	
	
}
