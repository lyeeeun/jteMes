package jin.mes.mapper.techMgt.mqsToolMgt;

import java.util.List;

import jin.mes.form.techMgt.mqsToolMgt.MqsToolMgtDto;

public interface MqsToolMgtMapper {
	public List<MqsToolMgtDto> selectMqsRoutingInfo(MqsToolMgtDto mqsToolMgtDto);
	public int selectMqsRoutingInfoCount(MqsToolMgtDto mqsToolMgtDto);
	
	public List<MqsToolMgtDto> selectMqsToolInfo(MqsToolMgtDto mqsToolMgtDto);
	public int selectMqsToolInfoCount(MqsToolMgtDto mqsToolMgtDto);
	
	public void insertMqsToolInfo(MqsToolMgtDto mqsToolMgtDto);
	public void updateMqsToolInfo(MqsToolMgtDto mqsToolMgtDto);
	
	public int selectDupleKeyCheck(MqsToolMgtDto mqsToolMgtDto);
	
}
