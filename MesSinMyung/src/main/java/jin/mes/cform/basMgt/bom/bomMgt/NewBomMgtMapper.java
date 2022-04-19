package jin.mes.cform.basMgt.bom.bomMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewBomMgtMapper {
	public List<NewBomMgtDto> selectBomList(NewBomMgtDto newBomMgtDto);
	public void insertBom(NewBomMgtDto newBomMgtDto);
	public void updateBom(NewBomMgtDto newBomMgtDto);
	public void deleteBom(NewBomMgtDto newBomMgtDto);
	
	public NewBomMgtDto selectBomRoot(NewBomMgtDto newBomMgtDto);
}