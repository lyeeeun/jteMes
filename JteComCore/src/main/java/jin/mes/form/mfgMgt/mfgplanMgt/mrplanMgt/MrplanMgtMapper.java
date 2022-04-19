package jin.mes.form.mfgMgt.mfgplanMgt.mrplanMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mfgMgt.mfgplanMgt.mrplanMgt.MrplanMgtDto;

@Mapper
public interface MrplanMgtMapper {
	
	public List<MrplanMgtDto> selectLotList (MrplanMgtDto mrplanMgtDto);
	
	public int selectLotCount (MrplanMgtDto mrplanMgtDto);
	
	
	public List<MrplanMgtDto> selectMrpMtlList (MrplanMgtDto mrplanMgtDto);
	
	public int selectMrpMtlCount (MrplanMgtDto mrplanMgtDto);

	public List<MrplanMgtDto> selectAllLotList();
}
