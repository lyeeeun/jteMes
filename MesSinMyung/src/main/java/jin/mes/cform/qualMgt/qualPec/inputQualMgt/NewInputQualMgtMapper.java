package jin.mes.cform.qualMgt.qualPec.inputQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewInputQualMgtMapper {
	
	//입고검사 Main
	public List<NewInputQualMgtDto> selectInputQualList(NewInputQualMgtDto inputQualMgtDto);
	
	public int selectInputQualCount(NewInputQualMgtDto inputQualMgtDto);
	
	public void insertInputQual(NewInputQualMgtDto inputQualMgtDto);
	
	public void updateInputQual(NewInputQualMgtDto inputQualMgtDto);
	
	public void updateInputQualIsDel(NewInputQualMgtDto inputQualMgtDto);
	
	public int deleteInputQual(NewInputQualMgtDto inputQualMgtDto);
	
	//입고검사 Sub 
	public List<NewInputQualMgtDto> selectInputQualDetailList(NewInputQualMgtDto inputQualMgtDto);
	
	public int selectInputQualDetailCount(NewInputQualMgtDto inputQualMgtDto);
	
	//입고검사 Control No
	public List<NewInputQualMgtDto> selectInputQualAddList(NewInputQualMgtDto inputQualMgtDto);
	
	public int selectInputQualAddCount(NewInputQualMgtDto inputQualMgtDto);
	
	public void insertInputQualAdd(NewInputQualMgtDto inputQualMgtDto);
	
	public void updateInputQualAdd(NewInputQualMgtDto inputQualMgtDto);
	
	public int deleteInputQualAdd(NewInputQualMgtDto inputQualMgtDto);

}
