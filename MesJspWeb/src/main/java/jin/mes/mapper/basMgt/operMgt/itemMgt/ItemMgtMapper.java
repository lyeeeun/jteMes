package jin.mes.mapper.basMgt.operMgt.itemMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;

@Mapper
public interface ItemMgtMapper {
	public List<ItemMgtDto> selectItemList(ItemMgtDto itemMgtDto);
	public int rowCount(ItemMgtDto itemMgtDto);
	
	public List<ItemMgtDto> selectRtlCompList(ItemMgtDto itemMgtDto);
	public int selectRtlCompCount(ItemMgtDto itemMgtDto);
	
	public void insertItem(ItemMgtDto itemMgtDto);
	public void updateItem(ItemMgtDto itemMgtDto);
	
	public void insertRtlComp(String compId, String itemId);
	public void deleteRtlComp(String compId, String itemId);
	
	public void updateIsUse(ItemMgtDto itemMgtDto);
	public void updateItemDeduction(ItemMgtDto itemMgtDto);
	
	public void insertKpi(ItemMgtDto itemMgtDto);
	public List<ItemMgtDto> selectKpi(ItemMgtDto itemMgtDto);
}