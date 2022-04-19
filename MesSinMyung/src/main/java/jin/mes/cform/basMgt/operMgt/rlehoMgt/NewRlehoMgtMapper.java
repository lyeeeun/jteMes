package jin.mes.cform.basMgt.operMgt.rlehoMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewRlehoMgtMapper {

	public List<NewRlehoMgtDto> selectPlaceTree(NewRlehoMgtDto placeDto);
	
	public List<NewRlehoMgtDto> selectPlaceList(NewRlehoMgtDto placeDto);
	
	public int selectPlaceListCount(NewRlehoMgtDto placeDto);
	
	public int insertPlaceInfo(NewRlehoMgtDto placeDto);
	
	public int updatePlaceInfo(NewRlehoMgtDto placeDto);
	
	public int deletePlaceInfo(NewRlehoMgtDto placeDto);
	
}
