package jin.mes.cform.mtrl.mtrltoolMgt;

import java.util.List;
import jin.mes.cform.mtrl.mtrltoolMgt.ZinixMtrltoolMgtDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ZinixMtrltoolMgtMapper {
	//공구 상세 관리	
	public List<ZinixMtrltoolMgtDto> selectToolMgtList(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public int selectToolMgtCount(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public void insertToolMgt(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public void updateToolMgt(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public void updateToolMgtIsDel(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public int deleteToolMgt(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	
	//공구 정비이력	
	public List<ZinixMtrltoolMgtDto> selectToolMtncList(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public int selectToolMtncCount(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public void insertToolMtnc(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public void updateToolMtnc(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public int deleteToolMtnc(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	//공구 가동시간
	public List<ZinixMtrltoolMgtDto> selectToolUseList(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public int selectToolUseCount(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public int selectToolUseChangeTotal(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public int selectToolUseTotal(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public void insertToolUse(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public void updateToolUse(ZinixMtrltoolMgtDto zinixToolMgtDto);
	
	public int deleteToolUse(ZinixMtrltoolMgtDto zinixToolMgtDto);
}
