package jin.mes.cform.basMgt.operMgt.itemMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.itemMgt.ZinixItemCompMgtDto;

@Mapper
public interface ZinixItemMgtMapper {
	public List<ZinixItemMgtDto> selectItemList(ZinixItemMgtDto itemMgtDto);
	public int rowCount(ZinixItemMgtDto itemMgtDto);
	
	public List<ZinixItemMgtDto> selectRtlCompList(ZinixItemMgtDto itemMgtDto);
	public int selectRtlCompCount(ZinixItemMgtDto itemMgtDto);
	
	public void insertItem(ZinixItemMgtDto itemMgtDto);
	public void updateItem(ZinixItemMgtDto itemMgtDto);
	
	public void insertRtlComp(ZinixItemCompMgtDto itemCompMgtDto);
	public void deleteRtlComp(ZinixItemCompMgtDto itemCompMgtDto);
	
	public void updateIsUse(ZinixItemMgtDto itemMgtDto);
	public void updateItemDeduction(ZinixItemMgtDto itemMgtDto);
	
	public void insertKpi(ZinixItemMgtDto itemMgtDto);
	public List<ZinixItemMgtDto> selectKpi(ZinixItemMgtDto itemMgtDto);
	
	//(order-child)
	public List<ZinixItemCompMgtDto> selectItemCompChild(ZinixItemCompMgtDto itemCompMgtDto);
	public ZinixItemMgtDto selectIteminfo(ZinixItemMgtDto itemMgtDto);
	
	
}