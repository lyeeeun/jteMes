package jin.mes.form.qualMgt.qualCheckList;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QualCheckListMapper {

	/*** 자주 검사 ***/
	public String selectInspectId();
	
	public int selectCheckListHistoryCount(QualCheckListDto qualCheckListDto);
	public List<QualCheckListDto> selectCheckListHistory(QualCheckListDto qualCheckListDto);
	
	public List<QualCheckListDto> selectCheckList(QualCheckListDto qualCheckListDto);
	public void insertCheckList(QualCheckListDto qualCheckListDto);
	public void updateCheckList(QualCheckListDto qualCheckListDto);
	
}
