package jin.mes.form.tool.toolUseInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.tool.toolUseInfo.ToolUseInfoDto;

@Mapper
public interface ToolUseInfoMapper {
	//공구 상세 관리	
	public List<ToolUseInfoDto> selectToolUseList(ToolUseInfoDto toolUseInfoDto);
	
	public int selectToolUseCount(ToolUseInfoDto toolUseInfoDto);
	
	//공구 가동시간
	public List<ToolUseInfoDto> selectToolUseInfoList(ToolUseInfoDto toolUseInfoDto);
	
	public int selectToolUseInfoCount(ToolUseInfoDto toolUseInfoDto);
	
}
