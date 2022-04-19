package jin.mes.cform.basMgt.operMgt.compMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.compMgt.CompAddrDto;
import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;

@Mapper
public interface NewCompMgtMapper {
	
	public List<NewCompMgtDto> selectCompList(NewCompMgtDto newCompMgtDto);
	
	public int selectCompCount(NewCompMgtDto newCompMgtDto);
	
	public void insertCompInfo(NewCompMgtDto newCompMgtDto);
	
	public void updateCompInfo(NewCompMgtDto newCompMgtDto);
	
	public int deleteCompInfo(NewCompMgtDto newCompMgtDto);
	
	
	
	
	public List<NewCompAddrDto> selectCompAddrList(NewCompAddrDto newCompAddrDto);
	
	public int selectCompAddrCount(NewCompAddrDto newCompAddrDto);
	
	public void insertCompAddrInfo(NewCompAddrDto newCompAddrDto);
	
	public void updateCompAddrInfo(NewCompAddrDto newCompAddrDto);
	
	public int deleteCompAddrInfo(NewCompAddrDto newCompAddrDto);
	
	public List<NewCompMgtDto> selectAllCompList();

}
