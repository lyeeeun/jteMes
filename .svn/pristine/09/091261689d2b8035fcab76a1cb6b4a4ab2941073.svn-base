package jin.mes.cform.item.itemToolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewItemToolMgtMapper {
	public List<NewItemToolMgtDto> selectRtlEqmtList(NewItemToolMgtDto itemToolMgtDto);
	public int rowCount(NewItemToolMgtDto itemToolMgtDto);
	
	public List<NewItemToolMgtDto> selectRtlToolList(NewItemToolMgtDto itemToolMgtDto);
	public int selectRtlToolCount(NewItemToolMgtDto itemToolMgtDto);
	
	public void insertRtlTool(String itemId, String eqmtMgtId, String toolId);
	public void deleteRtlTool(String itemId, String eqmtMgtId, String toolId);
}