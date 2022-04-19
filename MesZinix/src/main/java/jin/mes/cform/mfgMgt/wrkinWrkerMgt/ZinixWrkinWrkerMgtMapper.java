package jin.mes.cform.mfgMgt.wrkinWrkerMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtDto;
import jin.mes.cform.mfgMgt.wrkinWrkerMgt.ZinixMtrlUseDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtDto;

@Mapper
public interface ZinixWrkinWrkerMgtMapper {

	public List<ZinixWrkinTeamMgtDto> selectProdWorkList(ZinixWrkinTeamMgtDto asgnDto);

	public int selectProdWorkCount(ZinixWrkinTeamMgtDto asgnDto);
	
	public List<ZinixWrkinTeamMgtDto> selectProdWorkPop(ZinixWrkinTeamMgtDto asgnDto);

	public void insertProdWork(ZinixWrkinTeamMgtDto asgnDto);

	public void updateProdWork(ZinixWrkinTeamMgtDto asgnDto);

	public int deleteProdWork(ZinixWrkinTeamMgtDto asgnDto);
	
	public List<ZinixMtrlMgtDto> selectProdMtrlChkList(ZinixWrkinTeamMgtDto asgnDto);
	
	public List<ZinixMtrlUseDto> selectMtrlUseList(ZinixMtrlUseDto mtrlUseDto);
	
	public List<ZinixMtrlUseDto> selectMtrlUseDetailList(ZinixMtrlUseDto mtrlUseDto);
	
	public List<ZinixMtrlUseDto> selectMtrlUseBadList(ZinixMtrlUseDto mtrlUseDto);
	
	public List<ZinixMtrlUseDto> selectMtrlUseDevItemList(ZinixMtrlUseDto mtrlUseDto);
	
	public List<ZinixMtrlUseDto> selectMtrlUseDevItemBadList(ZinixMtrlUseDto mtrlUseDto);
	
	public void insertMtrlUse(ZinixMtrlUseDto mtrlUseDto);
	
	public void updateMtrlUse(ZinixMtrlUseDto mtrlUseDto);
	
	public int deleteMtrlUse(ZinixMtrlUseDto mtrlUseDto);
	
	public List<ZinixWrkinTeamMgtDto> selectbulkCopyList(ZinixWrkinTeamMgtDto asgnDto);
	
	public List<ZinixWrkinTeamMgtDto> selectbulkDeleteList(ZinixWrkinTeamMgtDto asgnDto);
	
}
