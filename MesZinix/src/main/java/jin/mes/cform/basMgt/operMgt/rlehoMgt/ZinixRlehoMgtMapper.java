package jin.mes.cform.basMgt.operMgt.rlehoMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.rlehoMgt.ZinixRlehoMgtDto;

@Mapper
public interface ZinixRlehoMgtMapper {

	public List<ZinixRlehoMgtDto> selectPlaceTree(ZinixRlehoMgtDto placeDto);
	
	public List<ZinixRlehoMgtDto> selectPlaceList(ZinixRlehoMgtDto placeDto);
	
	public int selectPlaceListCount(ZinixRlehoMgtDto placeDto);
	
	public int insertPlaceInfo(ZinixRlehoMgtDto placeDto);
	
	public int updatePlaceInfo(ZinixRlehoMgtDto placeDto);
	
	public int deletePlaceInfo(ZinixRlehoMgtDto placeDto);
	
}
