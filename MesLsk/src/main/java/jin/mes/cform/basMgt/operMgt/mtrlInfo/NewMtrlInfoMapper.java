package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.NewCompMgtDto;
import jin.mes.cform.basMgt.operMgt.mtrlInfo.NewMtrlInfoDto;

@Mapper
public interface NewMtrlInfoMapper {
	
	public List<NewMtrlInfoDto> selectMtrlInfoList(NewMtrlInfoDto newMtrlInfoDto);
	
	public int selectMtrlInfoCount(NewMtrlInfoDto newMtrlInfoDto);
	
	public void insertMtrlInfo(NewMtrlInfoDto newMtrlInfoDto);
	
	public void updateMtrlInfo(NewMtrlInfoDto newMtrlInfoDto);
	
	public int deleteMtrlInfo(NewMtrlInfoDto newMtrlInfoDto);
	
	
	public List<NewCompMgtDto> selectMtrlRtlCompList(NewCompMgtDto newCompDto);
	
	public int selectMtrlRtlCompCount(NewCompMgtDto newCompDto);
	
	public void insertMtrlRtlComp(NewCompMgtDto newCompDto);
	
	public int deleteMtrlRtlComp(NewCompMgtDto newCompDto);
}
