package jin.mes.cform.perform.processProgress;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface KwangjinProcessProgressMapper {
	public List<KwangjinProcessProgressDto> selectPerformItem(KwangjinProcessProgressDto kwangjinProcessProgressDto);
	public int selectPerformItemCount(KwangjinProcessProgressDto kwangjinProcessProgressDto);
	
	public List<KwangjinProcessProgressDto> selectKpiDefect(KwangjinProcessProgressDto kwangjinProcessProgressDto);
}