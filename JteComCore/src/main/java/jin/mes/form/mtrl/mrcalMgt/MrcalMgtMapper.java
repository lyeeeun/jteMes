package jin.mes.form.mtrl.mrcalMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mtrl.mrcalMgt.MrcalMgtDto;

@Mapper
public interface MrcalMgtMapper {

	public List<MrcalMgtDto> selectLotList (MrcalMgtDto mrcalMgtDto);
	
	public int selectLotCount (MrcalMgtDto mrcalMgtDto);
	
	
	public List<MrcalMgtDto> selectMrpMtlList (MrcalMgtDto mrcalMgtDto);
	
	public int selectMrpMtlCount (MrcalMgtDto mrcalMgtDto);

	public List<MrcalMgtDto> selectAllLotList();
}
