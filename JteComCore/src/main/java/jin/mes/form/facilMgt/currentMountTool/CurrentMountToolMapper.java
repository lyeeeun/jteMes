package jin.mes.form.facilMgt.currentMountTool;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.facilMgt.currentMountTool.CurrentMountToolDto;
//import jin.mes.form.item.facilMountTool.EqipToolDto;

@Mapper
public interface CurrentMountToolMapper {

	public List<CurrentMountToolDto> selectEqmtToolList(CurrentMountToolDto currentMountToolDto);
	public int selectEqmtToolListCount(CurrentMountToolDto currentMountToolDto);
	
	public List<CurrentMountToolDto> selectRtlToolList(CurrentMountToolDto currentMountToolDto);
	public int selectRtlToolCount(CurrentMountToolDto currentMountToolDto);
	
	public void updateEqmtTool(CurrentMountToolDto currentMountToolDto);
	
	public void insertRtlTool(MountDto mountDto);
	public void deleteRtlTool(MountDto mountDto);
	
	public List<MountDto> selectEqmtToolChild(MountDto mountDto);
	public CurrentMountToolDto selectEqmtToolinfo(CurrentMountToolDto currentMountToolDto);
}