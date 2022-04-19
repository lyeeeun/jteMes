package jin.mes.cform.facilMgt.prevMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.facilMgt.prevMgt.NewPrevMgtDto;

@Mapper
public interface NewPrevMgtMapper {
	public List<NewPrevMgtDto> selectPdmData(NewPrevMgtDto newPrevMgtDto);
	

}
