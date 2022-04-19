package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.NewCompMgtDto;

@Mapper
public interface NewMtrlInfoMapper {
	
	public List<NewMtrlInfoDto> selectMtrlInfoList(NewMtrlInfoDto mtrlInfoDto);
	
	public int selectMtrlInfoCount(NewMtrlInfoDto mtrlInfoDto);
	
	public void insertMtrlInfo(NewMtrlInfoDto mtrlInfoDto);
	
	public void updateMtrlInfo(NewMtrlInfoDto mtrlInfoDto);
	
	public int deleteMtrlInfo(NewMtrlInfoDto mtrlInfoDto);
	
	
	public List<NewCompMgtDto> selectMtrlRtlCompList(NewCompMgtDto compDto);
	
	public int selectMtrlRtlCompCount(NewCompMgtDto compDto);
	
	public void insertMtrlRtlComp(NewCompMgtDto compDto);
	
	public int deleteMtrlRtlComp(NewCompMgtDto compDto);
}
