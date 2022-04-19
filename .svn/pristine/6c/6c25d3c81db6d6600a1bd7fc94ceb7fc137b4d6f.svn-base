package jin.mes.cform.qualMgt.specProcMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.specProcMgt.NewSpecProcMgtDto;
import jin.mes.cform.qualMgt.specProcMgt.NewSpecProcUserDto;



@Mapper
public interface NewSpecProcMgtMapper {
	
	public List<NewSpecProcMgtDto> selectSpcList (NewSpecProcMgtDto specProcMgtDto );
	
	public int selectSpcCount (NewSpecProcMgtDto specProcMgtDto);
	
	public void insertSpcInfo (NewSpecProcMgtDto specProcMgtDto);
	
	public void updateSpcInfo (NewSpecProcMgtDto specProcMgtDto);
	
	public void deleteSpcInfo (NewSpecProcMgtDto specProcMgtDto);
	
	public List<NewSpecProcUserDto> selectSpcUserList (NewSpecProcUserDto specProcUserDto );
	
	public int selectSpcUserCount (NewSpecProcUserDto specProcUserDto);
	
	public void insertSpcUser (NewSpecProcUserDto specProcUserDto);
	
	public void deleteSpcUser (NewSpecProcUserDto specProcUserDto);
	
	
	public List<NewSpecProcMgtDto> selectAllSpcList();
}
