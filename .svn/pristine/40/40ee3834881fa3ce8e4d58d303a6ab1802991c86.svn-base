package jin.mes.cform.mtrl.mtrltoolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewMtrltoolMgtMapper {
	//공구 상세 관리	
	public List<NewMtrltoolMgtDto> selectToolMgtList(NewMtrltoolMgtDto toolMgtDto);
	
	public int selectToolMgtCount(NewMtrltoolMgtDto toolMgtDto);
	
	public void insertToolMgt(NewMtrltoolMgtDto toolMgtDto);
	
	public void updateToolMgt(NewMtrltoolMgtDto toolMgtDto);
	
	public void updateToolMgtIsDel(NewMtrltoolMgtDto toolMgtDto);
	
	public int deleteToolMgt(NewMtrltoolMgtDto toolMgtDto);
	
	
	//공구 정비이력	
	public List<NewMtrltoolMgtDto> selectToolMtncList(NewMtrltoolMgtDto toolMgtDto);
	
	public int selectToolMtncCount(NewMtrltoolMgtDto toolMgtDto);
	
	public void insertToolMtnc(NewMtrltoolMgtDto toolMgtDto);
	
	public void updateToolMtnc(NewMtrltoolMgtDto toolMgtDto);
	
	public int deleteToolMtnc(NewMtrltoolMgtDto toolMgtDto);
	
	//공구 가동시간
	public List<NewMtrltoolMgtDto> selectToolUseList(NewMtrltoolMgtDto toolMgtDto);
	
	public int selectToolUseCount(NewMtrltoolMgtDto toolMgtDto);
	
	public int selectToolUseChangeTotal(NewMtrltoolMgtDto toolMgtDto);
	
	public int selectToolUseTotal(NewMtrltoolMgtDto toolMgtDto);
	
	public void insertToolUse(NewMtrltoolMgtDto toolMgtDto);
	
	public void updateToolUse(NewMtrltoolMgtDto toolMgtDto);
	
	public int deleteToolUse(NewMtrltoolMgtDto toolMgtDto);
}
