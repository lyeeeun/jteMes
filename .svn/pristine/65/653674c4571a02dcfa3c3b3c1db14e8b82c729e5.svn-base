package jin.mes.form.basMgt.operMgt.mtrlInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.mtrlInfo.MtrlInfoDto;

@Mapper
public interface MtrlInfoMapper {
	
	public List<MtrlInfoDto> selectMtrlInfoList(MtrlInfoDto mtrlInfoDto);
	
	//팝업조회
	public MtrlInfoDto selectMtrlOne(MtrlInfoDto mtrlInfoDto);
		
	public int selectMtrlInfoCount(MtrlInfoDto mtrlInfoDto);
	
	public void insertMtrlInfo(MtrlInfoDto mtrlInfoDto);
	
	public void updateMtrlInfo(MtrlInfoDto mtrlInfoDto);
	
	public int deleteMtrlInfo(MtrlInfoDto mtrlInfoDto);
	
	// 포함된 Comp 조회(mtrl-child)
	public List<CompMgtDto> selectMtrlChild(CompMgtDto compDto);
	
	public List<CompMgtDto> selectMtrlRtlCompList(CompMgtDto compDto);
	
	public int selectMtrlRtlCompCount(CompMgtDto compDto);
	
	public void insertMtrlRtlComp(CompMgtDto compDto);
	
	public int deleteMtrlRtlComp(CompMgtDto compDto);
	
	public List<MtrlInfoDto> selectMinOutOfStock();	

	// 부품 제조원가 계산
	public List<String> selectMtrlRtlItemList(String mtrlId);
	
	public int selectItemMtrlCost(String itemId);
}
