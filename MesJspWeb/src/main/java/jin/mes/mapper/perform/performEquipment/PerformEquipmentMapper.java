package jin.mes.mapper.perform.performEquipment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import jin.mes.form.perform.performEquipment.PerformEquipmentDto;

@Mapper
public interface PerformEquipmentMapper {
	public List<PerformEquipmentDto> selectPerformEquipInfo(PerformEquipmentDto permapperEquipmentDto);
	public int rowCount(PerformEquipmentDto permapperOrderGridDto);
	
	public List<RlehoMgtDto> selectPlaceAll();
	
}