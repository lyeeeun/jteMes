package jin.mes.cform.basMgt.operMgt.rlehoMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.rlehoMgt.KwangjinRlehoMgtDto;

@Mapper
public interface KwangjinRlehoMgtMapper {

	public List<KwangjinRlehoMgtDto> selectPlaceTree(KwangjinRlehoMgtDto kwangjinRlehoMgtDto);
	
	public List<KwangjinRlehoMgtDto> selectPlaceList(KwangjinRlehoMgtDto kwangjinRlehoMgtDto);
	
	public int selectPlaceListCount(KwangjinRlehoMgtDto kwangjinRlehoMgtDto);
	
	public void insertPlaceInfo(KwangjinRlehoMgtDto kwangjinRlehoMgtDto);
	
	public void updatePlaceInfo(KwangjinRlehoMgtDto kwangjinRlehoMgtDto);
	
	public int deletePlaceInfo(KwangjinRlehoMgtDto kwangjinRlehoMgtDto);
	
}
