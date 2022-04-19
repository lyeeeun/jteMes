package jin.mes.form.pick.rlesPlanMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.pick.rlesPlanMgt.RlesPlanMgtDto;
@Mapper
public interface RlesPlanMgtMapper {
	public List<RlesPlanMgtDto> selectRlesPlanList(RlesPlanMgtDto rlesPlanMgtDto);
	public int selectRlesPlanCount(RlesPlanMgtDto rlesPlanMgtDto);
	public List<RlesPlanMgtDto> selectLotStockList(RlesPlanMgtDto rlesPlanMgtDto);
	public int selectLotStockCount(RlesPlanMgtDto rlesPlanMgtDto);
	public void insertRlesPlan(RlesPlanMgtDto rlesPlanMgtDto);
	public void updateRlesPlan(RlesPlanMgtDto rlesPlanMgtDto);
	public void deleteRlesPlan(RlesPlanMgtDto rlesPlanMgtDto);
}
