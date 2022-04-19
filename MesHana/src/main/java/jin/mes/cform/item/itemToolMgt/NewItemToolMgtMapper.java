package jin.mes.cform.item.itemToolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.item.itemToolMgt.NewItemToolMgtDto;

@Mapper
public interface NewItemToolMgtMapper {
	public List<NewItemToolMgtDto> selectRtlEqmtList(NewItemToolMgtDto newItemToolMgtDto);
	public int rowCount(NewItemToolMgtDto newItemToolMgtDto);
	
	public List<NewItemToolMgtDto> selectRtlToolList(NewItemToolMgtDto newItemToolMgtDto);
	public int selectRtlToolCount(NewItemToolMgtDto newItemToolMgtDto);
	
	public void insertRtlTool(String itemId, String eqmtMgtId, String toolId);
	public void deleteRtlTool(String itemId, String eqmtMgtId, String toolId);
}