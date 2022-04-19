package jin.mes.cform.qualMgt.qualCheckList;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface KwangjinQualCheckListMapper {

	/*** 자주 검사 ***/
	public String selectInspectId();
	
	public int selectCheckListHistoryCount(KwangjinQualCheckListDto qualCheckListDto);
	public List<KwangjinQualCheckListDto> selectCheckListHistory(KwangjinQualCheckListDto qualCheckListDto);
	
	public List<KwangjinQualCheckListDto> selectCheckList(KwangjinQualCheckListDto qualCheckListDto);
	public void insertCheckList(KwangjinQualCheckListDto qualCheckListDto);
	public void updateCheckList(KwangjinQualCheckListDto qualCheckListDto);
	
}
