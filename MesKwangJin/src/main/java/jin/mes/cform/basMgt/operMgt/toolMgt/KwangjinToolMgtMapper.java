package jin.mes.cform.basMgt.operMgt.toolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompAddrDto;
import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompMgtDto;
import jin.mes.cform.basMgt.operMgt.toolMgt.KwangjinToolMgtDto;

@Mapper
public interface KwangjinToolMgtMapper {

	public List<KwangjinToolMgtDto> selectToolInfoList(KwangjinToolMgtDto kwangjinToolMgtDto);
	
	public int selectToolInfoCount(KwangjinToolMgtDto kwangjinToolMgtDto);
	
	public void insertToolInfo(KwangjinToolMgtDto kwangjinToolMgtDto);
	
	public void updateToolInfo(KwangjinToolMgtDto kwangjinToolMgtDto);
	
	public int deleteToolInfo(KwangjinToolMgtDto kwangjinToolMgtDto);
	
	public List<KwangjinToolMgtDto> selectAllToolInfo(KwangjinToolMgtDto kwangjinToolMgtDto);
	
	
	public List<KwangjinCompMgtDto> selectToolRtlCompList(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public int selectToolRtlCompCount(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public void insertToolRtlComp(KwangjinToolCompMgtDto kwangjinToolCompMgtDto);
	
	public int deleteToolRtlComp(KwangjinToolCompMgtDto kwangjinToolCompMgtDto);
	
	public KwangjinCompMgtDto selectCompPop(KwangjinCompMgtDto kwangjinCompMgtDto);
	public List<KwangjinCompAddrDto> selectCompChild(KwangjinCompAddrDto kwangjinCompAddrDto);
	
	
	//해당수주에 포함된 LOT 조회(order-child)
	public List<KwangjinToolCompMgtDto> selectRtlCompChild(KwangjinToolCompMgtDto kwangjinToolCompMgtDto);
	public KwangjinToolMgtDto selectToolInfo(KwangjinToolMgtDto kwangjinToolMgtDto);
	
	
}
