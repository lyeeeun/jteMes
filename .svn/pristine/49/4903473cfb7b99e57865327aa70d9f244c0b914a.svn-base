package jin.mes.cform.basMgt.operMgt.itemMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewItemMgtMapper {
	public List<NewItemMgtDto> selectItemList(NewItemMgtDto newItemMgtDto);
	public int rowCount(NewItemMgtDto newItemMgtDto);
	
	public List<NewItemMgtDto> selectRtlCompList(NewItemMgtDto newItemMgtDto);
	public int selectRtlCompCount(NewItemMgtDto newItemMgtDto);
	
	public void insertItem(NewItemMgtDto newItemMgtDto);
	public void updateItem(NewItemMgtDto newItemMgtDto);
	
	public void insertRtlComp(String compId, String itemId);
	public void deleteRtlComp(String compId, String itemId);
	
	public void updateIsUse(NewItemMgtDto newItemMgtDto);
	public void updateItemDeduction(NewItemMgtDto newItemMgtDto);
	
	public void insertKpi(NewItemMgtDto newItemMgtDto);
	public List<NewItemMgtDto> selectKpi(NewItemMgtDto newItemMgtDto);
}