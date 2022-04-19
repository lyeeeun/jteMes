package jin.mes.mapper.qualMgt.qualPec.inputQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.qualMgt.qualPec.inputQualMgt.InputQualMgtDto;

@Mapper
public interface InputQualMgtMapper {
	
	//입고검사 Main
	public List<InputQualMgtDto> selectInputQualList(InputQualMgtDto inputQualMgtDto);
	
	public int selectInputQualCount(InputQualMgtDto inputQualMgtDto);
	
	public int updateInputQualHold(InputQualMgtDto inputQualMgtDto);
	
	public int updateInputQualPass(InputQualMgtDto inputQualMgtDto);

	
	//입고검사 Sub 
	public List<InputQualMgtDto> selectInputQualDetailList(InputQualMgtDto inputQualMgtDto);
	
	public int selectInputQualDetailCount(InputQualMgtDto inputQualMgtDto);
	
	public void insertInputQualDetail(InputQualMgtDto inputQualMgtDto);
	
	public void updateInputQualDetail(InputQualMgtDto inputQualMgtDto);
	
	public void updateInputQualAddup(InputQualMgtDto inputQualMgtDto);
	
	//입고검사 Control No
	public List<InputQualMgtDto> selectInputQualAddList(InputQualMgtDto inputQualMgtDto);
	
	public int selectInputQualAddCount(InputQualMgtDto inputQualMgtDto);
	
	public void insertInputQualAdd(InputQualMgtDto inputQualMgtDto);
	
	public void updateInputQualAdd(InputQualMgtDto inputQualMgtDto);
	
	public int deleteInputQualAdd(InputQualMgtDto inputQualMgtDto);

}
