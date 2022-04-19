package jin.mes.form.tool.toolMainRecord;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.tool.toolMainRecord.ToolMainRecordDto;

@Mapper
public interface ToolMainRecordMapper {
	//공구 상세 관리	
	public List<ToolMainRecordDto> selectToolRecordList(ToolMainRecordDto toolMainRecordDto);
	
	public int selectToolRecordCount(ToolMainRecordDto toolMainRecordDto);
	
	//공구 정비이력	
	public List<ToolMainRecordDto> selectToolMainRecordList(ToolMainRecordDto toolMainRecordDto);
	
	public int selectToolMainRecordCount(ToolMainRecordDto toolMainRecordDto);
	
	public void insertToolMainRecord(ToolMainRecordDto toolMainRecordDto);
	
	public void updateToolMainRecord(ToolMainRecordDto toolMainRecordDto);
	
	public int deleteToolMainRecord(ToolMainRecordDto toolMainRecordDto);
}
