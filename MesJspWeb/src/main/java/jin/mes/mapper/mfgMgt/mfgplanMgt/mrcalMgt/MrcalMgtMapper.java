package jin.mes.mapper.mfgMgt.mfgplanMgt.mrcalMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mfgMgt.mfgplanMgt.mrcalMgt.MrcalMgtDto;

@Mapper
public interface MrcalMgtMapper {

	public List<MrcalMgtDto> selectMtrlUseCalList(MrcalMgtDto mtrlUseCalDto);
	
	public int selectMtrlUseCalCount(MrcalMgtDto mtrlUseCalDto);
}