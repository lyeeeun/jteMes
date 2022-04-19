package jin.mes.cform.mtrl.itemRecevingMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.itemRecevingMgt.KwangjinItemRecevingMgtDto;

@Mapper
public interface KwangjinItemRecevingMgtMapper {
	//자재관리
	public List<KwangjinItemRecevingMgtDto> selectItemRecevingMgtList(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public int selectItemRecevingMgtCount(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public List<KwangjinItemRecevingMgtDto> selectItemLotList(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public List<KwangjinItemRecevingMgtDto> selectStockList(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public int selectItemLotCount(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public void insertItemRecevingMgt(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public void updateItemRecevingMgt(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public void updateItemRecevingMgtIsDel(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public int selectItemLotDupleKeyCount(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public int deleteItemStock(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	//자재수량관리
	public List<KwangjinItemRecevingMgtDto> selectItemRecevingHisList(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public int selectItemRecevingHisCount(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public int selectItemRecevingHisTotal(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);

	public void insertItemRecevingHis(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public void updateItemRecevingHis(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public int deleteItemRecevingHis(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	//자재 사용이력 수동관리
	public void insertManualInfo(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public void updateManualInfo(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
	
	public int deleteManualInfo(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto);
		
}
