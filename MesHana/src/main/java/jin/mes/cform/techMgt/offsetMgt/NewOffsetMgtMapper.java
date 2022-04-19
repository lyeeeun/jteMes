package jin.mes.cform.techMgt.offsetMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.techMgt.offsetMgt.NewOffsetMgtDto;

@Mapper
public interface NewOffsetMgtMapper {
	public List<NewOffsetMgtDto> selectOffsetData(NewOffsetMgtDto offsetMgtDto);
	public int selectOffsetDataCount(NewOffsetMgtDto offsetMgtDto);
}
