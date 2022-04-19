package jin.mes.cform.mtrl.itemShipMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.itemShipMgt.KwangjinItemShipHisDto;
import jin.mes.cform.mtrl.itemShipMgt.KwangjinItemShipMgtDto;


@Mapper
public interface KwangjinItemShipMgtMapper {
	//자재관리
	public List<KwangjinItemShipMgtDto> selectItemShipMgtList(KwangjinItemShipMgtDto kwangjinItemShipMgtDto);
	
	public int selectItemShipMgtCount(KwangjinItemShipMgtDto kwangjinItemShipMgtDto);
	
	public void insertItemShipMgt(KwangjinItemShipMgtDto kwangjinItemShipMgtDto);
	
	public void updateItemShipMgt(KwangjinItemShipMgtDto kwangjinItemShipMgtDto);
	
	public void updateItemShipMgtIsDel(KwangjinItemShipMgtDto kwangjinItemShipMgtDto);
	
	//자재수량관리
	public List<KwangjinItemShipHisDto> selectItemShipHisList(KwangjinItemShipHisDto kwangjinItemShipHisDto);
	
	public int selectItemShipHisCount(KwangjinItemShipHisDto kwangjinItemShipHisDto);
	
	public int selectItemShipHisTotal(KwangjinItemShipHisDto kwangjinItemShipHisDto);

	public void insertItemShipHis(KwangjinItemShipHisDto kwangjinItemShipHisDto);
	
	public void updateItemShipHis(KwangjinItemShipHisDto kwangjinItemShipHisDto);
	
	public int deleteItemShipHis(KwangjinItemShipHisDto kwangjinItemShipHisDto);
	
	
	//자재 사용이력 수동관리
	public void insertManualInfo(KwangjinItemShipHisDto kwangjinItemShipHisDto);
	
	public void updateManualInfo(KwangjinItemShipHisDto kwangjinItemShipHisDto);
	
	public int deleteManualInfo(KwangjinItemShipHisDto kwangjinItemShipHisDto);
		
}
