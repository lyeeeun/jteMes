package jin.mes.mapper.basMgt.operMgt.mtrlInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.mtrlInfo.MtrlInfoDto;

@Mapper
public interface MtrlInfoMapper {
	
	public List<MtrlInfoDto> selectMtrlInfoList(MtrlInfoDto mtrlInfoDto);
	
	public int selectMtrlInfoCount(MtrlInfoDto mtrlInfoDto);
	
	public void insertMtrlInfo(MtrlInfoDto mtrlInfoDto);
	
	public void updateMtrlInfo(MtrlInfoDto mtrlInfoDto);
	
	public int deleteMtrlInfo(MtrlInfoDto mtrlInfoDto);
	
	
	public List<CompMgtDto> selectMtrlRtlCompList(CompMgtDto compDto);
	
	public int selectMtrlRtlCompCount(CompMgtDto compDto);
	
	public void insertMtrlRtlComp(CompMgtDto compDto);
	
	public int deleteMtrlRtlComp(CompMgtDto compDto);
}
