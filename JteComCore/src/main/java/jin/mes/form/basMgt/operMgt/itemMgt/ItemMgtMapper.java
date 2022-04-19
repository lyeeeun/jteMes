package jin.mes.form.basMgt.operMgt.itemMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.itemMgt.ItemCompMgtDto;

@Mapper
public interface ItemMgtMapper {
	public List<ItemMgtDto> selectItemList(ItemMgtDto itemMgtDto);
	public int rowCount(ItemMgtDto itemMgtDto);
	
	public List<ItemMgtDto> selectRtlCompList(ItemMgtDto itemMgtDto);
	public int selectRtlCompCount(ItemMgtDto itemMgtDto);
	
	public void insertItem(ItemMgtDto itemMgtDto);
	public void updateItem(ItemMgtDto itemMgtDto);
	
	public void insertRtlComp(ItemCompMgtDto itemCompMgtDto);
	public void deleteRtlComp(ItemCompMgtDto itemCompMgtDto);
	
	public void updateIsUse(ItemMgtDto itemMgtDto);
	public void updateItemDeduction(ItemMgtDto itemMgtDto);
	
	public void insertKpi(ItemMgtDto itemMgtDto);
	public List<ItemMgtDto> selectKpi(ItemMgtDto itemMgtDto);
	
	//(order-child)
	public List<ItemCompMgtDto> selectItemCompChild(ItemCompMgtDto itemCompMgtDto);
	public ItemMgtDto selectIteminfo(ItemMgtDto itemMgtDto);
	
	
}