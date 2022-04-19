package jin.mes.cform.techMgt.mqsToolMgt;

import java.util.List;

import jin.mes.cform.techMgt.mqsToolMgt.NewMqsToolMgtDto;

public interface NewMqsToolMgtMapper {
	public List<NewMqsToolMgtDto> selectMqsRoutingInfo(NewMqsToolMgtDto mqsToolMgtDto);
	public int selectMqsRoutingInfoCount(NewMqsToolMgtDto mqsToolMgtDto);
	
	public List<NewMqsToolMgtDto> selectMqsToolInfo(NewMqsToolMgtDto mqsToolMgtDto);
	public int selectMqsToolInfoCount(NewMqsToolMgtDto mqsToolMgtDto);
	
	public void insertMqsToolInfo(NewMqsToolMgtDto mqsToolMgtDto);
	public void updateMqsToolInfo(NewMqsToolMgtDto mqsToolMgtDto);
	
	public int selectDupleKeyCheck(NewMqsToolMgtDto mqsToolMgtDto);
	
}
