package jin.mes.cform.mfgMgt.mfgplanMgt.mrcalMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewMrcalMgtMapper {

	public List<NewMrcalMgtDto> selectMtrlUseCalList(NewMrcalMgtDto mtrlUseCalDto);
	
	public int selectMtrlUseCalCount(NewMrcalMgtDto mtrlUseCalDto);
}
