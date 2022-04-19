package jin.mes.form.perform.facilStaMgt.facilTotalEff;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.perform.facilStaMgt.facilTotalEff.FacilTotalEffDto;

@Mapper
public interface FacilTotalEffMapper {

	public List<FacilTotalEffDto> selectEqmtMgtList(FacilTotalEffDto facilTotalEffDto);
	
	public int selectEqmtMgtCount(FacilTotalEffDto facilTotalEffDto);
}
