package jin.mes.cform.item.itemToolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.item.itemToolMgt.NewItemToolMgtDto;

@Mapper
public interface NewItemToolMgtMapper {
	public List<NewItemToolMgtDto> selectRtlToolInfo(NewItemToolMgtDto newItemToolMgtDto);
	public List<NewItemToolMgtDto> selectAllRtlToolInfo(NewItemToolMgtDto newItemToolMgtDto);
	public int selectRtlToolInfoCount(NewItemToolMgtDto newItemToolMgtDto);
	
	public void insertRtlToolInfo(NewItemToolMgtDto newItemToolMgtDto);
	public void updateRtlToolInfo(NewItemToolMgtDto newItemToolMgtDto);
	public void deleteRtlToolInfo(NewItemToolMgtDto newItemToolMgtDto);
	
	public int selectDupleKeyCheck(NewItemToolMgtDto newItemToolMgtDto);
}