package jin.mes.form.perform.workStaMgt.lotProStatus;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.perform.workStaMgt.lotProStatus.LotProStatusDto;

@Mapper
public interface LotProStatusMapper {
	
	public List<LotProStatusDto> selectLotProgressList(LotProStatusDto lotProStatusDto);
	
	public int selectLotProgressCount(LotProStatusDto lotProStatusDto);
}
