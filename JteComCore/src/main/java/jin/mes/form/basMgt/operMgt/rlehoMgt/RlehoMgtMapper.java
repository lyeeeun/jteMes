package jin.mes.form.basMgt.operMgt.rlehoMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;

@Mapper
public interface RlehoMgtMapper {

	public List<RlehoMgtDto> selectPlaceTree(RlehoMgtDto placeDto);
	
	public List<RlehoMgtDto> selectPlaceList(RlehoMgtDto placeDto);
	
	public int selectPlaceListCount(RlehoMgtDto placeDto);
	
	public int insertPlaceInfo(RlehoMgtDto placeDto);
	
	public int updatePlaceInfo(RlehoMgtDto placeDto);
	
	public int deletePlaceInfo(RlehoMgtDto placeDto);
	
}
