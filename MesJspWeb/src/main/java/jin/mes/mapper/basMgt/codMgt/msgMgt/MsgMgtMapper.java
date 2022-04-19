package jin.mes.mapper.basMgt.codMgt.msgMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtDto;

@Mapper
public interface MsgMgtMapper {
	
	public List<MsgMgtDto> selectMsgList(MsgMgtDto msgMgtDto);
	
	public int selectMsgListCount(MsgMgtDto msgMgtDto);
	
	public List<MsgMgtDto> selectMsgOne(MsgMgtDto msgMgtDto);
}
