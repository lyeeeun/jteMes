package jin.mes.mapper.perform.performOrderGrid;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.perform.performOrderGrid.PerformOrderGridDto;

@Mapper
public interface PerformOrderGridMapper {
	public List<PerformOrderGridDto> selectPerformOrder(PerformOrderGridDto performOrderGridDto);
	public int selectPerformOrderCount(PerformOrderGridDto performOrderGridDto);
	public List<PerformOrderGridDto> selectLotDetail(PerformOrderGridDto performOrderGridDto);
	public int selectLotDetailCount(PerformOrderGridDto performOrderGridDto);
}