package jin.mes.form.perform.prodStaMgt.facilProdMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.perform.prodStaMgt.facilProdMgt.FacilProdMgtDto;

@Mapper
public interface FacilProdMgtMapper {
	public List<FacilProdMgtDto> selectFacilProdList(FacilProdMgtDto facilProdMgtDto);
	public int selectFacilProdCount(FacilProdMgtDto facilProdMgtDto);
}
