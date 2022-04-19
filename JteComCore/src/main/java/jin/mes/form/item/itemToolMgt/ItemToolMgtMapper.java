package jin.mes.form.item.itemToolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.itemMgt.ItemCompMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.item.itemToolMgt.ItemToolMgtDto;

@Mapper
public interface ItemToolMgtMapper {
	
	public List<ItemToolMgtDto> selectItemToolList(ItemToolMgtDto itemToolMgtDto);
	public int selectItemToolListCount(ItemToolMgtDto itemToolMgtDto);
	
	public List<ItemToolMgtDto> selectRtlToolList(ItemToolMgtDto itemToolMgtDto);
	public int selectRtlToolCount(ItemToolMgtDto itemToolMgtDto);
	
	public void updateItemTool(ItemToolMgtDto itemToolMgtDto);
	
	public void insertRtlTool(ItemToolRtlDto itemToolRtlDto);
	public void deleteRtlTool(ItemToolRtlDto itemToolRtlDto);
	
	public List<ItemToolRtlDto> selectItemToolChild(ItemToolRtlDto itemToolRtlDto);
	public ItemToolMgtDto selectItemToolinfo(ItemToolMgtDto itemToolMgtDto);
}