package jin.mes.form.mfgMgt.wrkinWrkerMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mfgMgt.wrkinWrkerMgt.MtrlUseDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtDto;

@Mapper
public interface WrkinWrkerMgtMapper {

	public List<WrkinTeamMgtDto> selectProdWorkList(WrkinTeamMgtDto asgnDto);

	public int selectProdWorkCount(WrkinTeamMgtDto asgnDto);
	
	public List<WrkinTeamMgtDto> selectProdWorkPop(WrkinTeamMgtDto asgnDto);

	public void insertProdWork(WrkinTeamMgtDto asgnDto);

	public void updateProdWork(WrkinTeamMgtDto asgnDto);

	public int deleteProdWork(WrkinTeamMgtDto asgnDto);
	
	public List<MtrlMgtDto> selectProdMtrlChkList(WrkinTeamMgtDto asgnDto);
	
	public List<MtrlUseDto> selectMtrlUseList(MtrlUseDto mtrlUseDto);
	
	public List<MtrlUseDto> selectMtrlUseDetailList(MtrlUseDto mtrlUseDto);
	
	public List<MtrlUseDto> selectMtrlUseBadList(MtrlUseDto mtrlUseDto);
	
	public List<MtrlUseDto> selectMtrlUseDevItemList(MtrlUseDto mtrlUseDto);
	
	public List<MtrlUseDto> selectMtrlUseDevItemBadList(MtrlUseDto mtrlUseDto);
	
	public void insertMtrlUse(MtrlUseDto mtrlUseDto);
	
	public void updateMtrlUse(MtrlUseDto mtrlUseDto);
	
	public int deleteMtrlUse(MtrlUseDto mtrlUseDto);
	
	public List<WrkinTeamMgtDto> selectbulkCopyList(WrkinTeamMgtDto asgnDto);
	
	public List<WrkinTeamMgtDto> selectbulkDeleteList(WrkinTeamMgtDto asgnDto);
	
}
