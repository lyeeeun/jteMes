package jin.mes.cform.qualMgt.qualPec.inputQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.qualPec.inputQualMgt.NewInputQualMgtDto;

@Mapper
public interface NewInputQualMgtMapper {
	
	//입고검사 Main
	public List<NewInputQualMgtDto> selectInputQualList(NewInputQualMgtDto newInputQualMgtDto);
	
	public int selectInputQualCount(NewInputQualMgtDto newInputQualMgtDto);

	//입고검사 Control No(pop)
	public List<NewInputQualMgtDto> selectInputQualAddList(NewInputQualMgtDto newInputQualMgtDto);
	
	public int selectInputQualAddCount(NewInputQualMgtDto newInputQualMgtDto);
	
	public void insertInputQualAdd(NewInputQualMgtDto newInputQualMgtDto);
	
	public void updateInputQualAdd(NewInputQualMgtDto newInputQualMgtDto);
	
	public int deleteInputQualAdd(NewInputQualMgtDto newInputQualMgtDto);
	
	//발주 업데이트
	public void updateInputQual(NewInputQualMgtDto newInputQualMgtDto);

	//검사 보류, 현황
	public int updateInputQualHold(NewInputQualMgtDto newInputQualMgtDto);
	
	public int updateInputQualPass(NewInputQualMgtDto newInputQualMgtDto);

}
