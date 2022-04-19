package jin.mes.mapper.basMgt.operMgt.compMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.compMgt.CompAddrDto;
import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;

@Mapper
public interface CompMgtMapper {
	
	public List<CompMgtDto> selectCompList(CompMgtDto compMgtDto);
	
	public int selectCompCount(CompMgtDto compMgtDto);
	
	public void insertCompInfo(CompMgtDto compMgtDto);
	
	public void updateCompInfo(CompMgtDto compMgtDto);
	
	public int deleteCompInfo(CompMgtDto compMgtDto);
	
	
	
	
	public List<CompAddrDto> selectCompAddrList(CompAddrDto compAddrDto);
	
	public int selectCompAddrCount(CompAddrDto compAddrDto);
	
	public void insertCompAddrInfo(CompAddrDto compAddrDto);
	
	public void updateCompAddrInfo(CompAddrDto compAddrDto);
	
	public int deleteCompAddrInfo(CompAddrDto compAddrDto);
	
	public List<CompMgtDto> selectAllCompList();

}
