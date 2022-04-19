package jin.mes.cform.qualMgt.qualPec.toolQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.item.itemToolMgt.NewItemToolMgtDto;
import jin.mes.cform.qualMgt.qualPec.inputQualMgt.NewInputQualMgtDto;

@Mapper
public interface NewToolQualMgtMapper {
	public List<NewToolQualMgtDto> selectToolInspInfo(NewToolQualMgtDto newToolQualMgtDto);
	public List<NewToolQualMgtDto> selectRtlPlaceInfo(NewToolQualMgtDto newToolQualMgtDto);
	public List<NewToolQualMgtDto> selectInspHistory(NewToolQualMgtDto newToolQualMgtDto);
	public int selectToolInspInfoCount(NewToolQualMgtDto newToolQualMgtDto);
	
	
	public String selectToolInspId();
	
	public void insertToolInspInfo(NewToolQualMgtDto newToolQualMgtDto);
	public void updateToolInspInfo(NewToolQualMgtDto newToolQualMgtDto);
	
//	public void updateRtlToolInfo(NewItemToolMgtDto newItemToolMgtDto);
//	public void deleteRtlToolInfo(NewItemToolMgtDto newItemToolMgtDto);
}
