package jin.mes.form.tool.mtrltoolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.tool.mtrltoolMgt.MtrltoolMgtDto;

@Mapper
public interface MtrltoolMgtMapper {
	//공구 상세 관리	
	public List<MtrltoolMgtDto> selectToolMgtList(MtrltoolMgtDto toolMgtDto);
	
	public int selectToolMgtCount(MtrltoolMgtDto toolMgtDto);
	
	public void insertToolMgt(MtrltoolMgtDto toolMgtDto);
	
	public void updateToolMgt(MtrltoolMgtDto toolMgtDto);
	
	public void updateToolMgtIsDel(MtrltoolMgtDto toolMgtDto);
	
	public int deleteToolMgt(MtrltoolMgtDto toolMgtDto);
	
	
	//공구 정비이력	
	public List<MtrltoolMgtDto> selectToolMtncList(MtrltoolMgtDto toolMgtDto);
	
	public int selectToolMtncCount(MtrltoolMgtDto toolMgtDto);
	
	public void insertToolMtnc(MtrltoolMgtDto toolMgtDto);
	
	public void updateToolMtnc(MtrltoolMgtDto toolMgtDto);
	
	public int deleteToolMtnc(MtrltoolMgtDto toolMgtDto);
	
	//공구 가동시간
	public List<MtrltoolMgtDto> selectToolUseList(MtrltoolMgtDto toolMgtDto);
	
	public int selectToolUseCount(MtrltoolMgtDto toolMgtDto);
	
	public int selectToolUseChangeTotal(MtrltoolMgtDto toolMgtDto);
	
	public int selectToolUseTotal(MtrltoolMgtDto toolMgtDto);
	
	public void insertToolUse(MtrltoolMgtDto toolMgtDto);
	
	public void updateToolUse(MtrltoolMgtDto toolMgtDto);
	
	public int deleteToolUse(MtrltoolMgtDto toolMgtDto);
}
