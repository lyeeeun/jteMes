package jin.mes.cform.perform.performEquipment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.rlehoMgt.NewRlehoMgtDto;

@Mapper
public interface NewPerformEquipmentMapper {
	public List<NewPerformEquipmentDto> selectPerformEquipInfo(NewPerformEquipmentDto permapperEquipmentDto);
	public int rowCount(NewPerformEquipmentDto permapperOrderGridDto);
	
	public List<NewRlehoMgtDto> selectPlaceAll();
	
}