package jin.mes.mapper.item.itemToolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.item.itemToolMgt.ItemToolMgtDto;

@Mapper
public interface ItemToolMgtMapper {
	public List<ItemToolMgtDto> selectRtlEqmtList(ItemToolMgtDto itemToolMgtDto);
	public int rowCount(ItemToolMgtDto itemToolMgtDto);
	
	public List<ItemToolMgtDto> selectRtlToolList(ItemToolMgtDto itemToolMgtDto);
	public int selectRtlToolCount(ItemToolMgtDto itemToolMgtDto);
	
	public void insertRtlTool(String itemId, String eqmtMgtId, String toolId);
	public void deleteRtlTool(String itemId, String eqmtMgtId, String toolId);
}