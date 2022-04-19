package jin.mes.cform.item.itemStockMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewItemStockMgtMapper {
	public List<NewItemStockMgtDto> selectItemStockList(NewItemStockMgtDto itemStockMgtDto);
	public int rowCount(NewItemStockMgtDto itemStockMgtDto);
	
	public List<NewItemStockMgtDto> selectItemStockHistory(NewItemStockMgtDto itemStockMgtDto);
	public int itemStockHistoryCount(NewItemStockMgtDto itemStockMgtDto);
	
	public void insertItemStock(NewItemStockMgtDto itemStockMgtDto);
	
	public void insertManualInfo(NewItemStockMgtDto itemStockMgtDto);
	
	public void insertItemStockHistory(NewItemStockMgtDto itemStockMgtDto);
	
	public int selectItemStock(NewItemStockMgtDto itemStockMgtDto);
	
	public void updateItemStock(NewItemStockMgtDto itemStockMgtDto);
	
	public int selectItemTotalStock(NewItemStockMgtDto itemStockMgtDto);
	
	public void updateItemTotalStock(NewItemStockMgtDto itemStockMgtDto);
	
	public int updateTargetStock(NewItemStockMgtDto itemStockMgtDto);
	
	public int deleteTargetStock(NewItemStockMgtDto itemStockMgtDto);
	
	public void updateItemMgtIsDel(NewItemStockMgtDto itemStockMgtDto);
	
}