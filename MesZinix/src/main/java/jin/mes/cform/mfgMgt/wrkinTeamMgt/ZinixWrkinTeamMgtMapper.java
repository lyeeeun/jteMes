package jin.mes.cform.mfgMgt.wrkinTeamMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtDto;

@Mapper
public interface ZinixWrkinTeamMgtMapper {

	public List<ZinixWrkinTeamMgtDto> selectAsgnList(ZinixWrkinTeamMgtDto asgnDto);

	public int selectAsgnCount(ZinixWrkinTeamMgtDto asgnDto);
	
	public List<ZinixWrkinTeamMgtDto> selectAsgnPop(ZinixWrkinTeamMgtDto asgnDto);

	public void insertAsgn(ZinixWrkinTeamMgtDto asgnDto);

	public void updateAsgn(ZinixWrkinTeamMgtDto asgnDto);

	public int deleteAsgn(ZinixWrkinTeamMgtDto asgnDto);
}
