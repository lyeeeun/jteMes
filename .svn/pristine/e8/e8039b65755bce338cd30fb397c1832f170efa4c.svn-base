package jin.mes.cform.mfgMgt.wrkinTeamMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;

@Mapper
public interface NewWrkinTeamMgtMapper {

	public List<NewWrkinTeamMgtDto> selectAsgnList(NewWrkinTeamMgtDto newAsgnDto);

	public int selectAsgnCount(NewWrkinTeamMgtDto newAsgnDto);
	
	public List<NewWrkinTeamMgtDto> selectAsgnPop(NewWrkinTeamMgtDto newAsgnDto);

	public void insertAsgn(NewWrkinTeamMgtDto newAsgnDto);

	public void updateAsgn(NewWrkinTeamMgtDto newAsgnDto);

	public int deleteAsgn(NewWrkinTeamMgtDto newAsgnDto);
}
