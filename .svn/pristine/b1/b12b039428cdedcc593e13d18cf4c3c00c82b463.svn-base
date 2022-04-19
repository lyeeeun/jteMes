package jin.mes.cform.qualMgt.qualCheckList;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewQualCheckListMapper {

	/*** 자주 검사 ***/
	public String selectInspectId();
	
	public int selectCheckListHistoryCount(NewQualCheckListDto newQualCheckListDto);
	public List<NewQualCheckListDto> selectCheckListHistory(NewQualCheckListDto newQualCheckListDto);
	
	public List<NewQualCheckListDto> selectCheckList(NewQualCheckListDto newQualCheckListDto);
	public void insertCheckList(NewQualCheckListDto newQualCheckListDto);
	public void updateCheckList(NewQualCheckListDto newQualCheckListDto);
	
}
