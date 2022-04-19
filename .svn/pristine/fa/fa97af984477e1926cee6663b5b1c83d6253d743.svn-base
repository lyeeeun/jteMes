package jin.mes.cform.qualMgt.qualPec.inputQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.qualPec.inputQualMgt.NewInputQualMgtDto;

@Mapper
public interface NewInputQualMgtMapper {
	
	//입고검사 Main
	public List<NewInputQualMgtDto> selectInputQualList(NewInputQualMgtDto newInputQualMgtDto);
	
	public int selectInputQualCount(NewInputQualMgtDto newInputQualMgtDto);
	
	public int updateInputQualHold(NewInputQualMgtDto newInputQualMgtDto);
	
	public int updateInputQualPass(NewInputQualMgtDto newInputQualMgtDto);

	
	//입고검사 Sub 
	public List<NewInputQualMgtDto> selectInputQualDetailList(NewInputQualMgtDto newInputQualMgtDto);
	
	public int selectInputQualDetailCount(NewInputQualMgtDto newInputQualMgtDto);
	
	public void insertInputQualDetail(NewInputQualMgtDto newInputQualMgtDto);
	
	public void updateInputQualDetail(NewInputQualMgtDto newInputQualMgtDto);
	
	public void updateInputQualAddup(NewInputQualMgtDto newInputQualMgtDto);
	
	//입고검사 Control No
	public List<NewInputQualMgtDto> selectInputQualAddList(NewInputQualMgtDto newInputQualMgtDto);
	
	public int selectInputQualAddCount(NewInputQualMgtDto newInputQualMgtDto);
	
	public void insertInputQualAdd(NewInputQualMgtDto newInputQualMgtDto);
	
	public void updateInputQualAdd(NewInputQualMgtDto newInputQualMgtDto);
	
	public int deleteInputQualAdd(NewInputQualMgtDto newInputQualMgtDto);

}
