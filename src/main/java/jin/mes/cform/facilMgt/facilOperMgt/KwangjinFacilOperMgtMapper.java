package jin.mes.cform.facilMgt.facilOperMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.facilMgt.facilOperMgt.KwangjinFacilOperMgtDto;

@Mapper
public interface KwangjinFacilOperMgtMapper {

	public List<KwangjinFacilOperMgtDto> selectEqmtOperList(KwangjinFacilOperMgtDto kwangjinFacilOperMgtDto);
	public List<KwangjinFacilOperMgtDto> selectEqmtWorkList(KwangjinFacilOperMgtDto kwangjinFacilOperMgtDto);
	public int selectEqmtOperCount(KwangjinFacilOperMgtDto kwangjinFacilOperMgtDto);
}
