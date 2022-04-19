package jin.mes.cform.mtrl.sparePartsMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.sparePartsMgt.NewSparePartsMgtDto;

@Mapper
public interface NewSparePartsMgtMapper {
	public List<NewSparePartsMgtDto> selectToolInfoList(NewSparePartsMgtDto newSparePartsMgtDto);
	
	public int selectToolInfoCount(NewSparePartsMgtDto newSparePartsMgtDto);
	
	public void insertToolInfo(NewSparePartsMgtDto newSparePartsMgtDto);
	
	public void updateToolInfo(NewSparePartsMgtDto newSparePartsMgtDto);
	
	public int deleteToolInfo(NewSparePartsMgtDto newSparePartsMgtDto);
	
	public List<NewSparePartsMgtDto> selectAllToolInfo(NewSparePartsMgtDto newSparePartsMgtDto);
	
	
}
