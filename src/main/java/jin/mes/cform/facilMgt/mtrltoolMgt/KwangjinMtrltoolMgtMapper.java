package jin.mes.cform.facilMgt.mtrltoolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.facilMgt.mtrltoolMgt.KwangjinMtrltoolMgtDto;
import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingHisDto;
import jin.mes.form.basMgt.operMgt.compMgt.CompAddrDto;
import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.toolMgt.ToolCompMgtDto;
import jin.mes.form.basMgt.operMgt.toolMgt.ToolMgtDto;

@Mapper
public interface KwangjinMtrltoolMgtMapper {
	
	//공구 정보 조회
	public List<KwangjinMtrltoolMgtDto> selectToolInfoList(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	public int selectToolInfoCount(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	//공구 수량 정보 조회
	public List<KwangjinMtrltoolMgtDto> selectToolQtyList(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	public int selectToolQtyCount(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);

	//공구 상세 관리	
	public List<KwangjinMtrltoolMgtDto> selectToolMgtList(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public int selectToolMgtCount(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public void insertToolMgt(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public void updateToolMgt(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public void updateToolMgtIsDel(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public int deleteToolMgt(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	
	//공구 정비이력	
	public List<KwangjinMtrltoolMgtDto> selectToolMtncList(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public int selectToolMtncCount(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public void insertToolMtnc(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public void updateToolMtnc(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public int deleteToolMtnc(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	//공구 가동시간
	public List<KwangjinMtrltoolMgtDto> selectToolUseList(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public int selectToolUseCount(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public int selectToolUseChangeTotal(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public int selectToolUseTotal(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public void insertToolUse(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public void updateToolUse(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
	public int deleteToolUse(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
	
}
