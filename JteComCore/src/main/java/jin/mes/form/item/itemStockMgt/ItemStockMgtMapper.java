package jin.mes.form.item.itemStockMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;

@Mapper
public interface ItemStockMgtMapper {
	public List<ItemStockMgtDto> selectItemStockList(ItemStockMgtDto itemStockMgtDto);
	public List<ItemStockMgtDto> selectStockList(ItemStockMgtDto itemStockMgtDto);
	public int rowCount(ItemStockMgtDto itemStockMgtDto);
	
	public List<ItemStockMgtDto> selectItemStockHistory(ItemStockMgtDto itemStockMgtDto);
	public int itemStockHistoryCount(ItemStockMgtDto itemStockMgtDto);
	
	public void insertItemMgtStock(ItemStockMgtDto itemStockMgtDto);
	
	public void insertManualInfo(ItemStockMgtDto itemStockMgtDto);
	
	public void insertItemStockHistory(ItemStockMgtDto itemStockMgtDto);
	
	public int selectItemStock(ItemStockMgtDto itemStockMgtDto);
	
	public void updateItemStock(ItemStockMgtDto itemStockMgtDto);
	
	public void deleteItemStock(ItemStockMgtDto itemStockMgtDto);
	
	public void updateItemMgtStock(ItemStockMgtDto itemStockMgtDto);
	
	public int selectItemTotalStock(ItemStockMgtDto itemStockMgtDto);
	
	public void updateItemTotalStock(ItemStockMgtDto itemStockMgtDto);
	
	public int updateTargetStock(ItemStockMgtDto itemStockMgtDto);
	
	public int deleteTargetStock(ItemStockMgtDto itemStockMgtDto);
	
	public void updateItemMgtIsDel(ItemStockMgtDto itemStockMgtDto);
	
}