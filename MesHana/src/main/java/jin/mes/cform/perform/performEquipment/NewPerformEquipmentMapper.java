package jin.mes.cform.perform.performEquipment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.rlehoMgt.NewRlehoMgtDto;
import jin.mes.cform.perform.performEquipment.NewPerformEquipmentDto;

@Mapper
public interface NewPerformEquipmentMapper {
	public List<NewPerformEquipmentDto> selectPerformEquipInfo(NewPerformEquipmentDto newPermapperEquipmentDto);
	public int rowCount(NewPerformEquipmentDto newPermapperOrderGridDto);
	
	public List<NewRlehoMgtDto> selectPlaceAll();
	
}