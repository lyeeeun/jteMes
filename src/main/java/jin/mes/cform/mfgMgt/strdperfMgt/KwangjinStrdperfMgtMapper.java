package jin.mes.cform.mfgMgt.strdperfMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.strdperfMgt.KwangjinStrdperfMgtDto;

@Mapper
public interface KwangjinStrdperfMgtMapper {

	public List<KwangjinStrdperfMgtDto> selectProdAssignList(KwangjinStrdperfMgtDto kwangjinStrdperfMgtDto);
	public int selectProdAssignCount(KwangjinStrdperfMgtDto kwangjinStrdperfMgtDto);
	
	public List<KwangjinStrdperfMgtDto> selectStrderfList(KwangjinStrdperfMgtDto kwangjinStrdperfMgtDto);
	public int selectStrderfListCount(KwangjinStrdperfMgtDto kwangjinStrdperfMgtDto);
	
	public List<KwangjinStrdperfMgtDto> selectStrderfDetailList(KwangjinStrdperfMgtDto kwangjinStrdperfMgtDto);
	public int selectStrderfDetailListCount(KwangjinStrdperfMgtDto kwangjinStrdperfMgtDto);
}
