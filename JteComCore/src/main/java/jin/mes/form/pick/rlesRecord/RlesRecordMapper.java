package jin.mes.form.pick.rlesRecord;

import java.util.List;

import jin.mes.form.pick.rlesPlanMgt.RlesPlanMgtDto;

public interface RlesRecordMapper {
	public List<RlesRecordDto> selectRlesRecordList(RlesRecordDto rlesRecordDto);
	public int selectRlesRecordCount(RlesRecordDto rlesRecordDto);
	public List<RlesPlanMgtDto> selectLotStockList(RlesPlanMgtDto rlesPlanMgtDto);
}
