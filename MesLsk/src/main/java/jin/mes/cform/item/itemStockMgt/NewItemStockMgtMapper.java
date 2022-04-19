package jin.mes.cform.item.itemStockMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.item.itemStockMgt.NewItemStockMgtDto;

@Mapper
public interface NewItemStockMgtMapper {
	public List<NewItemStockMgtDto> selectItemStockList(NewItemStockMgtDto newItemStockMgtDto);
	public int rowCount(NewItemStockMgtDto newItemStockMgtDto);
	
	public List<NewItemStockMgtDto> selectItemStockHistory(NewItemStockMgtDto newItemStockMgtDto);
	public int itemStockHistoryCount(NewItemStockMgtDto newItemStockMgtDto);
	
	public void insertItemStock(NewItemStockMgtDto newItemStockMgtDto);
	
	public void insertManualInfo(NewItemStockMgtDto newItemStockMgtDto);
	
	public void insertItemStockHistory(NewItemStockMgtDto newItemStockMgtDto);
	
	public int selectItemStock(NewItemStockMgtDto newItemStockMgtDto);
	
	public void updateItemStock(NewItemStockMgtDto newItemStockMgtDto);
	
	public int selectItemTotalStock(NewItemStockMgtDto newItemStockMgtDto);
	
	public void updateItemTotalStock(NewItemStockMgtDto newItemStockMgtDto);
	
	public int updateTargetStock(NewItemStockMgtDto newItemStockMgtDto);
	
	public int deleteTargetStock(NewItemStockMgtDto newItemStockMgtDto);
	
	public void updateItemMgtIsDel(NewItemStockMgtDto newItemStockMgtDto);
	
}