package jin.mes.cform.item.itemStockMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtDto;

@Mapper
public interface ZinixItemStockMgtMapper {
	public List<ZinixItemStockMgtDto> selectItemStockList(ZinixItemStockMgtDto itemStockMgtDto);
	public List<ZinixItemStockMgtDto> selectStockList(ZinixItemStockMgtDto itemStockMgtDto);
	public int rowCount(ZinixItemStockMgtDto itemStockMgtDto);
	
	public List<ZinixItemStockMgtDto> selectItemStockHistory(ZinixItemStockMgtDto itemStockMgtDto);
	public int itemStockHistoryCount(ZinixItemStockMgtDto itemStockMgtDto);
	
	public void insertItemMgtStock(ZinixItemStockMgtDto itemStockMgtDto);
	
	public void insertManualInfo(ZinixItemStockMgtDto itemStockMgtDto);
	
	public void insertItemStockHistory(ZinixItemStockMgtDto itemStockMgtDto);
	
	public int selectItemStock(ZinixItemStockMgtDto itemStockMgtDto);
	
	public void updateItemStock(ZinixItemStockMgtDto itemStockMgtDto);
	
	public void deleteItemStock(ZinixItemStockMgtDto itemStockMgtDto);
	
	public void updateItemMgtStock(ZinixItemStockMgtDto itemStockMgtDto);
	
	public int selectItemTotalStock(ZinixItemStockMgtDto itemStockMgtDto);
	
	public void updateItemTotalStock(ZinixItemStockMgtDto itemStockMgtDto);
	
	public int updateTargetStock(ZinixItemStockMgtDto itemStockMgtDto);
	
	public int deleteTargetStock(ZinixItemStockMgtDto itemStockMgtDto);
	
	public void updateItemMgtIsDel(ZinixItemStockMgtDto itemStockMgtDto);
	
}