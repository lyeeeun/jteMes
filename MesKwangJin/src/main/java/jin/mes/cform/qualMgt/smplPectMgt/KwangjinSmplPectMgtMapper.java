package jin.mes.cform.qualMgt.smplPectMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.smplPectMgt.KwangjinSmplPectMgtDto;

@Mapper
public interface KwangjinSmplPectMgtMapper {

	public List<KwangjinSmplPectMgtDto> selectProdAsgnList(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);

	public int selectProdAsgnCount(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);
	
	
	public List<KwangjinSmplPectMgtDto> selectLotList(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);

	public int selectLotCount(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);
	
	
	public List<KwangjinSmplPectMgtDto> selectRoutWorkList(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);

	public int selectRoutWorkCount(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);
	
	
	public List<KwangjinSmplPectMgtDto> selectItemBadList(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);
	
	public int selectItemBadCount(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);
	
	public int selectItemBadTotal(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);
	
	public void insertItemBad(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);
	
	public void updateItemBad(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);
	
	public int deleteItemBad(KwangjinSmplPectMgtDto kwangjinSmplPectMgtDto);
}
