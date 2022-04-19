package jin.mes.cform.basMgt.operMgt.compMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompAddrDto;
import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompMgtDto;

@Mapper
public interface KwangjinCompMgtMapper {
	
	public List<KwangjinCompMgtDto> selectCompList(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public int selectCompCount(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public KwangjinCompMgtDto selectCompPop(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public void insertCompInfo(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public void updateCompInfo(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	public int deleteCompInfo(KwangjinCompMgtDto kwangjinCompMgtDto);
	
	
	public List<KwangjinCompAddrDto> selectCompAddrList(KwangjinCompAddrDto kwangjinCompAddrDto);
	
	public int selectCompAddrCount(KwangjinCompAddrDto kwangjinCompAddrDto);
	
	public List<KwangjinCompAddrDto> selectCompChild(KwangjinCompAddrDto kwangjinCompAddrDto);
	
	public void insertCompAddrInfo(KwangjinCompAddrDto kwangjinCompAddrDto);
	
	public void updateCompAddrInfo(KwangjinCompAddrDto kwangjinCompAddrDto);
	
	public int deleteCompAddrInfo(KwangjinCompAddrDto kwangjinCompAddrDto);
	
	public List<KwangjinCompMgtDto> selectAllCompList();

}
