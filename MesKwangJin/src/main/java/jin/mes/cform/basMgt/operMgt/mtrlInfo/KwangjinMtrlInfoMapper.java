package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompMgtDto;
import jin.mes.cform.basMgt.operMgt.mtrlInfo.KwangjinMtrlInfoDto;

@Mapper
public interface KwangjinMtrlInfoMapper {
	
	public List<KwangjinMtrlInfoDto> selectMtrlInfoList(KwangjinMtrlInfoDto kwangjinMtrlInfoDto);
	
	//팝업조회
	public KwangjinMtrlInfoDto selectMtrlOne(KwangjinMtrlInfoDto kwangjinMtrlInfoDto);
		
	public int selectMtrlInfoCount(KwangjinMtrlInfoDto kwangjinMtrlInfoDto);
	
	public void insertMtrlInfo(KwangjinMtrlInfoDto kwangjinMtrlInfoDto);
	
	public void updateMtrlInfo(KwangjinMtrlInfoDto kwangjinMtrlInfoDto);
	
	public int deleteMtrlInfo(KwangjinMtrlInfoDto kwangjinMtrlInfoDto);
	
	// 포함된 Comp 조회(mtrl-child)
	public List<KwangjinCompMgtDto> selectMtrlChild(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public List<KwangjinCompMgtDto> selectMtrlRtlCompList(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public int selectMtrlRtlCompCount(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public void insertMtrlRtlComp(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public int deleteMtrlRtlComp(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public List<KwangjinMtrlInfoDto> selectMinOutOfStock();	

	// 부품 제조원가 계산
	public List<String> selectMtrlRtlItemList(String mtrlId);
	
	public int selectItemMtrlCost(String itemId);
}
