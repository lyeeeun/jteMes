package jin.mes.cform.basMgt.operMgt.rlehoMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.rlehoMgt.NewRlehoMgtDto;

@Mapper
public interface NewRlehoMgtMapper {

	public List<NewRlehoMgtDto> selectPlaceTree(NewRlehoMgtDto newPlaceDto);
	
	public List<NewRlehoMgtDto> selectPlaceListAll(NewRlehoMgtDto newPlaceDto);
	
	public List<NewRlehoMgtDto> selectPlaceList(NewRlehoMgtDto newPlaceDto);
	
	public int selectPlaceListCount(NewRlehoMgtDto newPlaceDto);
	
	public int insertPlaceInfo(NewRlehoMgtDto newPlaceDto);
	
	public int updatePlaceInfo(NewRlehoMgtDto newPlaceDto);
	
	public int deletePlaceInfo(NewRlehoMgtDto newPlaceDto);
	
}
