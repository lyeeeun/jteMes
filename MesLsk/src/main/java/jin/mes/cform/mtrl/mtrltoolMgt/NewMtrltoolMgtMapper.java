package jin.mes.cform.mtrl.mtrltoolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.mtrltoolMgt.NewMtrltoolMgtDto;

@Mapper
public interface NewMtrltoolMgtMapper {
	//공구 상세 관리	
	public List<NewMtrltoolMgtDto> selectToolMgtList(NewMtrltoolMgtDto newToolMgtDto);
	
	public int selectToolMgtCount(NewMtrltoolMgtDto newToolMgtDto);
	
	public void insertToolMgt(NewMtrltoolMgtDto newToolMgtDto);
	
	public void updateToolMgt(NewMtrltoolMgtDto newToolMgtDto);
	
	public void updateToolMgtIsDel(NewMtrltoolMgtDto newToolMgtDto);
	
	public int deleteToolMgt(NewMtrltoolMgtDto newToolMgtDto);
	
	public int selectToolMgtDupleKeyCount(NewMtrltoolMgtDto newToolMgtDto);
	
	
	//공구 정비이력	
	public List<NewMtrltoolMgtDto> selectToolMtncList(NewMtrltoolMgtDto newToolMgtDto);
	
	public int selectToolMtncCount(NewMtrltoolMgtDto newToolMgtDto);
	
	public void insertToolMtnc(NewMtrltoolMgtDto newToolMgtDto);
	
	public void updateToolMtnc(NewMtrltoolMgtDto newToolMgtDto);
	
	public int deleteToolMtnc(NewMtrltoolMgtDto newToolMgtDto);
	
	//공구 가동시간
	public List<NewMtrltoolMgtDto> selectToolUseList(NewMtrltoolMgtDto newToolMgtDto);
	
	public int selectToolUseCount(NewMtrltoolMgtDto newToolMgtDto);
	
	public int selectToolUseChangeTotal(NewMtrltoolMgtDto newToolMgtDto);
	
	public int selectToolUseTotal(NewMtrltoolMgtDto newToolMgtDto);
	
	public void insertToolUse(NewMtrltoolMgtDto newToolMgtDto);
	
	public void updateToolUse(NewMtrltoolMgtDto newToolMgtDto);
	
	public int deleteToolUse(NewMtrltoolMgtDto newToolMgtDto);
}
