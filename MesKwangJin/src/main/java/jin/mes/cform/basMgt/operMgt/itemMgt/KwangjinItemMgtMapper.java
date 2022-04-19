package jin.mes.cform.basMgt.operMgt.itemMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.itemMgt.KwangjinItemCompMgtDto;

@Mapper
public interface KwangjinItemMgtMapper {
	public List<KwangjinItemMgtDto> selectItemList(KwangjinItemMgtDto kwangjinItemMgtDto);
	public int rowCount(KwangjinItemMgtDto kwangjinItemMgtDto);
	
	public List<KwangjinItemMgtDto> selectRtlCompList(KwangjinItemMgtDto kwangjinItemMgtDto);
	public int selectRtlCompCount(KwangjinItemMgtDto kwangjinItemMgtDto);
	
	public void insertItem(KwangjinItemMgtDto kwangjinItemMgtDto);
	public void updateItem(KwangjinItemMgtDto kwangjinItemMgtDto);
	
	public void insertRtlComp(KwangjinItemCompMgtDto kwangjinItemCompMgtDto);
	public void deleteRtlComp(KwangjinItemCompMgtDto kwangjinItemCompMgtDto);
	
	public void updateIsUse(KwangjinItemMgtDto kwangjinItemMgtDto);
	
	public void insertKpi(KwangjinItemMgtDto kwangjinItemMgtDto);
	public List<KwangjinItemMgtDto> selectKpi(KwangjinItemMgtDto kwangjinItemMgtDto);
	
	//(order-child)
	public List<KwangjinItemCompMgtDto> selectItemCompChild(KwangjinItemCompMgtDto kwangjinItemCompMgtDto);
	public KwangjinItemMgtDto selectIteminfo(KwangjinItemMgtDto kwangjinItemMgtDto);
	
	
}