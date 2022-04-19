package jin.mes.form.facilMgt.facilMountTool;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.facilMgt.facilMountTool.FacilMountToolDto;
import jin.mes.form.facilMgt.facilMountTool.EqipToolDto;

@Mapper
public interface FacilMountToolMapper {

	public List<EqipToolDto> selectToolMgtMountList(EqipToolDto eqipToolDto);
	public int selectToolMgtMountCount(EqipToolDto eqipToolDto);
	
	public List<FacilMountToolDto> selectEqmtToolList(FacilMountToolDto facilMountToolDto);
	public int selectEqmtToolListCount(FacilMountToolDto facilMountToolDto);
	
	public void updateEqmtTool(FacilMountToolDto facilMountToolDto);
	
	public void insertRtlTool(EqipToolDto eqipToolDto);
	public void deleteRtlTool(EqipToolDto eqipToolDto);
	
	public List<EqipToolDto> selectEqmtToolChild(EqipToolDto eqipToolDto);
	public FacilMountToolDto selectEqmtToolinfo(FacilMountToolDto facilMountToolDto);
	
	public List<EqipToolDto> selectToolEqipList(EqipToolDto eqipToolDto);
	public int selectToolEqipCount(EqipToolDto eqipToolDto);
	
	public void insertToolEqip(EqipToolDto eqipToolDto);
	public void updateDupl(EqipToolDto eqipToolDto);

	public void deleteToolEqip(EqipToolDto eqipToolDto);
	public void updateDuplZero(EqipToolDto eqipToolDto);
}