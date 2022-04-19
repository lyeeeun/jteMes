package jin.mes.cform.mfgMgt.mfgplanMgt.mrcalMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.mfgplanMgt.mrcalMgt.NewMrcalMgtDto;

@Mapper
public interface NewMrcalMgtMapper {

	public List<NewMrcalMgtDto> selectMtrlUseCalList(NewMrcalMgtDto newMtrlUseCalDto);
	
	public int selectMtrlUseCalCount(NewMrcalMgtDto newMtrlUseCalDto);
}
