package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.ZinixCompMgtDto;

@Mapper
public interface ZinixMtrlInfoMapper {
	
	public List<ZinixMtrlInfoDto> selectMtrlInfoList(ZinixMtrlInfoDto mtrlInfoDto);
	
	//팝업조회
	public ZinixMtrlInfoDto selectMtrlOne(ZinixMtrlInfoDto mtrlInfoDto);
		
	public int selectMtrlInfoCount(ZinixMtrlInfoDto mtrlInfoDto);
	
	public void insertMtrlInfo(ZinixMtrlInfoDto mtrlInfoDto);
	
	public void updateMtrlInfo(ZinixMtrlInfoDto mtrlInfoDto);
	
	public int deleteMtrlInfo(ZinixMtrlInfoDto mtrlInfoDto);
	
	// 포함된 Comp 조회(mtrl-child)
	public List<ZinixCompMgtDto> selectMtrlChild(ZinixCompMgtDto compDto);
	
	public List<ZinixCompMgtDto> selectMtrlRtlCompList(ZinixCompMgtDto compDto);
	
	public int selectMtrlRtlCompCount(ZinixCompMgtDto compDto);
	
	public void insertMtrlRtlComp(ZinixCompMgtDto compDto);
	
	public int deleteMtrlRtlComp(ZinixCompMgtDto compDto);
	
	public List<ZinixMtrlInfoDto> selectMinOutOfStock();	

	// 부품 제조원가 계산
	public List<String> selectMtrlRtlItemList(String mtrlId);
	
	public int selectItemMtrlCost(String itemId);
}
