package jin.mes.form.qualMgt.specProcMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.qualMgt.specProcMgt.SpecProcMgtDto;
import jin.mes.form.qualMgt.specProcMgt.SpecProcUserDto;



@Mapper
public interface SpecProcMgtMapper {
	
	public List<SpecProcMgtDto> selectSpcList (SpecProcMgtDto specProcMgtDto );
	
	public int selectSpcCount (SpecProcMgtDto specProcMgtDto);
	
	public void insertSpcInfo (SpecProcMgtDto specProcMgtDto);
	
	public void updateSpcInfo (SpecProcMgtDto specProcMgtDto);
	
	public void deleteSpcInfo (SpecProcMgtDto specProcMgtDto);
	
	public List<SpecProcUserDto> selectSpcUserList (SpecProcUserDto specProcUserDto );
	
	public int selectSpcUserCount (SpecProcUserDto specProcUserDto);
	
	public void insertSpcUser (SpecProcUserDto specProcUserDto);
	
	public void deleteSpcUser (SpecProcUserDto specProcUserDto);
	
	
	public List<SpecProcMgtDto> selectAllSpcList();
}
