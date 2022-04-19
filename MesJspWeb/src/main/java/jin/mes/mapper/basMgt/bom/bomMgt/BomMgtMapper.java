package jin.mes.mapper.basMgt.bom.bomMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;

@Mapper
public interface BomMgtMapper {
	public List<BomMgtDto> selectBomList(BomMgtDto bomMgtDto);
	public void insertBom(BomMgtDto bomMgtDto);
	public void updateBom(BomMgtDto bomMgtDto);
	public void deleteBom(BomMgtDto bomMgtDto);
	
	public BomMgtDto selectBomRoot(BomMgtDto bomMgtDto);
}