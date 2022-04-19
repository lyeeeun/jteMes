package jin.mes.cform.mfgMgt.wrkinWrkerMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mfgMgt.wrkinWrkerMgt.NewMtrlUseDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtDto;

@Mapper
public interface NewWrkinWrkerMgtMapper {

	public List<NewWrkinTeamMgtDto> selectProdWorkList(NewWrkinTeamMgtDto newAsgnDto);

	public int selectProdWorkCount(NewWrkinTeamMgtDto newAsgnDto);
	
	public List<NewWrkinTeamMgtDto> selectProdWorkPop(NewWrkinTeamMgtDto newAsgnDto);

	public void insertProdWork(NewWrkinTeamMgtDto newAsgnDto);

	public void updateProdWork(NewWrkinTeamMgtDto newAsgnDto);

	public int deleteProdWork(NewWrkinTeamMgtDto newAsgnDto);
	
	public List<NewMtrlMgtDto> selectProdMtrlChkList(NewWrkinTeamMgtDto newAsgnDto);
	
	public List<NewMtrlUseDto> selectMtrlUseList(NewMtrlUseDto newMtrlUseDto);
	
	public List<NewMtrlUseDto> selectMtrlUseDetailList(NewMtrlUseDto newMtrlUseDto);
	
	public List<NewMtrlUseDto> selectMtrlUseBadList(NewMtrlUseDto newMtrlUseDto);
	
	public List<NewMtrlUseDto> selectMtrlUseDevItemList(NewMtrlUseDto newMtrlUseDto);
	
	public List<NewMtrlUseDto> selectMtrlUseDevItemBadList(NewMtrlUseDto newMtrlUseDto);
	
	public void insertMtrlUse(NewMtrlUseDto newMtrlUseDto);
	
	public void updateMtrlUse(NewMtrlUseDto newMtrlUseDto);
	
	public int deleteMtrlUse(NewMtrlUseDto newMtrlUseDto);
	
	public List<NewWrkinTeamMgtDto> selectbulkCopyList(NewWrkinTeamMgtDto newAsgnDto);
	
	public List<NewWrkinTeamMgtDto> selectbulkDeleteList(NewWrkinTeamMgtDto newAsgnDto);
	
}
