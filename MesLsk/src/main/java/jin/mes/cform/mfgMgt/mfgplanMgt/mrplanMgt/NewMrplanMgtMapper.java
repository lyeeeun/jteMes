package jin.mes.cform.mfgMgt.mfgplanMgt.mrplanMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.mfgplanMgt.mrplanMgt.NewMrplanMgtDto;

@Mapper
public interface NewMrplanMgtMapper {
	
	public List<NewMrplanMgtDto> selectLotList (NewMrplanMgtDto newMrplanMgtDto);
	
	public int selectLotCount (NewMrplanMgtDto newMrplanMgtDto);
	
	
	public List<NewMrplanMgtDto> selectMrpMtlList (NewMrplanMgtDto newMrplanMgtDto);
	
	public int selectMrpMtlCount (NewMrplanMgtDto newMrplanMgtDto);

	public List<NewMrplanMgtDto> selectAllLotList();
}
