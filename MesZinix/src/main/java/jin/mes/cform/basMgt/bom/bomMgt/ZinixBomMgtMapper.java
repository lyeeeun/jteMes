package jin.mes.cform.basMgt.bom.bomMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.bom.bomMgt.ZinixBomMgtDto;

@Mapper
public interface ZinixBomMgtMapper {
	public List<ZinixBomMgtDto> selectBomList(ZinixBomMgtDto bomMgtDto);
	public List<ZinixBomMgtDto> selectBomTree(ZinixBomMgtDto bomMgtDto);
	public void insertBom(ZinixBomMgtDto bomMgtDto);
	public void updateBom(ZinixBomMgtDto bomMgtDto);
	public void deleteBom(ZinixBomMgtDto bomMgtDto);
	
	public String selectBomRoot(ZinixBomMgtDto bomMgtDto);
}