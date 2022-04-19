package jin.mes.mapper.mfgMgt.wrkinTeamMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;

@Mapper
public interface WrkinTeamMgtMapper {

	public List<WrkinTeamMgtDto> selectAsgnList(WrkinTeamMgtDto asgnDto);

	public int selectAsgnCount(WrkinTeamMgtDto asgnDto);
	
	public List<WrkinTeamMgtDto> selectAsgnPop(WrkinTeamMgtDto asgnDto);

	public void insertAsgn(WrkinTeamMgtDto asgnDto);

	public void updateAsgn(WrkinTeamMgtDto asgnDto);

	public int deleteAsgn(WrkinTeamMgtDto asgnDto);
}
