package jin.mes.common.attach;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.common.attach.AttachMgtDto;

@Mapper
public interface AttachMgtMapper {

	public List<AttachMgtDto> selectAttchMgtList(AttachMgtDto attachMgtDto);
	
	public List<AttachMgtDto> selectAttchMgtPage(AttachMgtDto attachMgtDto);
	
	public int selectAttchMgtCount(AttachMgtDto attachMgtDto);

	public void insertAttchMgt(AttachMgtDto attachMgtDto);
	
	public void deleteAttchMgt(AttachMgtDto attachMgtDto);
	
}