package jin.mes.cform.basMgt.operMgt.compMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.ZinixCompAddrDto;
import jin.mes.cform.basMgt.operMgt.compMgt.ZinixCompMgtDto;

@Mapper
public interface ZinixCompMgtMapper {
	
	public List<ZinixCompMgtDto> selectCompList(ZinixCompMgtDto compMgtDto);
	
	public int selectCompCount(ZinixCompMgtDto compMgtDto);
	
	public ZinixCompMgtDto selectCompPop(ZinixCompMgtDto compMgtDto);
	
	public void insertCompInfo(ZinixCompMgtDto compMgtDto);
	
	public void updateCompInfo(ZinixCompMgtDto compMgtDto);
	
	public int deleteCompInfo(ZinixCompMgtDto compMgtDto);
	
	
	public List<ZinixCompAddrDto> selectCompAddrList(ZinixCompAddrDto compAddrDto);
	
	public int selectCompAddrCount(ZinixCompAddrDto compAddrDto);
	
	public List<ZinixCompAddrDto> selectCompChild(ZinixCompAddrDto compAddrDto);
	
	public void insertCompAddrInfo(ZinixCompAddrDto compAddrDto);
	
	public void updateCompAddrInfo(ZinixCompAddrDto compAddrDto);
	
	public int deleteCompAddrInfo(ZinixCompAddrDto compAddrDto);
	
	public List<ZinixCompMgtDto> selectAllCompList();

}
