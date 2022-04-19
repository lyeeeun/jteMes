package jin.mes.cform.facilMgt.performEquipment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import jin.mes.cform.facilMgt.performEquipment.KwangjinPerformEquipmentDto;

@Mapper
public interface KwangjinPerformEquipmentMapper {
	public List<KwangjinPerformEquipmentDto> selectPerformEquipInfo(KwangjinPerformEquipmentDto kwangjinPerformEquipmentDto);
	public int rowCount(KwangjinPerformEquipmentDto kwangjinPerformEquipmentDto);
	
	public List<RlehoMgtDto> selectPlaceAll();
	
}