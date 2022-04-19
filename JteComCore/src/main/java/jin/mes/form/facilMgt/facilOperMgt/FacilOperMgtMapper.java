package jin.mes.form.facilMgt.facilOperMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.facilMgt.facilOperMgt.FacilOperMgtDto;

@Mapper
public interface FacilOperMgtMapper {

	public List<FacilOperMgtDto> selectEqmtOperList(FacilOperMgtDto facilOperMgtDto);
	
	public int selectEqmtOperCount(FacilOperMgtDto facilOperMgtDto);
}
