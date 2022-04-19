package jin.mes.cform.perform.performOrderGrid;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.perform.performOrderGrid.KwangjinPerformOrderGridDto;

@Mapper
public interface KwangjinPerformOrderGridMapper {
	public List<KwangjinPerformOrderGridDto> selectPerformOrder(KwangjinPerformOrderGridDto kwangjinPerformOrderGridDto);
	public int selectPerformOrderCount(KwangjinPerformOrderGridDto kwangjinPerformOrderGridDto);
	public List<KwangjinPerformOrderGridDto> selectLotDetail(KwangjinPerformOrderGridDto kwangjinPerformOrderGridDto);
	public int selectLotDetailCount(KwangjinPerformOrderGridDto kwangjinPerformOrderGridDto);
}