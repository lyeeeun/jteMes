package jin.mes.cform.mfgMgt.wrkinWrkerMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtDto;

@Mapper
public interface NewWrkinWrkerMgtMapper {

	public List<NewWrkinTeamMgtDto> selectProdWorkList(NewWrkinTeamMgtDto asgnDto);

	public int selectProdWorkCount(NewWrkinTeamMgtDto asgnDto);
	
	public List<NewWrkinTeamMgtDto> selectProdWorkPop(NewWrkinTeamMgtDto asgnDto);

	public void insertProdWork(NewWrkinTeamMgtDto asgnDto);

	public void updateProdWork(NewWrkinTeamMgtDto asgnDto);

	public int deleteProdWork(NewWrkinTeamMgtDto asgnDto);
	
	public List<NewMtrlMgtDto> selectProdMtrlChkList(NewWrkinTeamMgtDto asgnDto);
	
	public List<NewMtrlUseDto> selectMtrlUseList(NewMtrlUseDto mtrlUseDto);
	
	public List<NewMtrlUseDto> selectMtrlUseDetailList(NewMtrlUseDto mtrlUseDto);
	
	public List<NewMtrlUseDto> selectMtrlUseBadList(NewMtrlUseDto mtrlUseDto);
	
	public List<NewMtrlUseDto> selectMtrlUseDevItemList(NewMtrlUseDto mtrlUseDto);
	
	public List<NewMtrlUseDto> selectMtrlUseDevItemBadList(NewMtrlUseDto mtrlUseDto);
	
	public void insertMtrlUse(NewMtrlUseDto mtrlUseDto);
	
	public void updateMtrlUse(NewMtrlUseDto mtrlUseDto);
	
	public int deleteMtrlUse(NewMtrlUseDto mtrlUseDto);
	
	public List<NewWrkinTeamMgtDto> selectbulkCopyList(NewWrkinTeamMgtDto asgnDto);
	
	public List<NewWrkinTeamMgtDto> selectbulkDeleteList(NewWrkinTeamMgtDto asgnDto);
	
}
