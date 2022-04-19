package jin.mes.cform.basMgt.operMgt.itemMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface NewItemMgtMapper {
	public List<NewItemMgtDto> selectItemList(NewItemMgtDto itemMgtDto);
	public int rowCount(NewItemMgtDto itemMgtDto);
	
	public List<NewItemMgtDto> selectRtlCompList(NewItemMgtDto itemMgtDto);
	public int selectRtlCompCount(NewItemMgtDto itemMgtDto);
	
	public void insertItem(NewItemMgtDto itemMgtDto);
	public void updateItem(NewItemMgtDto itemMgtDto);
	
	public void insertRtlComp(String compId, String itemId);
	public void deleteRtlComp(String compId, String itemId);
	
	public void updateIsUse(NewItemMgtDto itemMgtDto);
	public void updateItemDeduction(NewItemMgtDto itemMgtDto);
	
	public void insertKpi(NewItemMgtDto itemMgtDto);
	public List<NewItemMgtDto> selectKpi(NewItemMgtDto itemMgtDto);
}