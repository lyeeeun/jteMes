package jin.mes.cform.mfgMgt.mrcalMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.mrcalMgt.KwangjinMrcalMgtDto;

@Mapper
public interface KwangjinMrcalMgtMapper {

	public List<KwangjinMrcalMgtDto> selectLotList (KwangjinMrcalMgtDto kwangjinMrcalMgtDto);
	
	public int selectLotCount (KwangjinMrcalMgtDto kwangjinMrcalMgtDto);
	
	
	public List<KwangjinMrcalMgtDto> selectMrpMtlList (KwangjinMrcalMgtDto kwangjinMrcalMgtDto);
	
	public int selectMrpMtlCount (KwangjinMrcalMgtDto kwangjinMrcalMgtDto);

	public List<KwangjinMrcalMgtDto> selectAllLotList();
}
