package jin.mes.form.basMgt.codMgt.baseCodeMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;

@Mapper
public interface BaseCodeMgtMapper {
	
	public List<BaseCodeMgtDto> readCode(BaseCodeMgtDto codeDto);
	public int codeCount(BaseCodeMgtDto codeDto);
	
	public void codeAdd(BaseCodeMgtDto codeInputDto);
	public void codeUpdate(BaseCodeMgtDto codeInputDto);
	public int codeDelete(@Param("cdId") String cdId, @Param("loginId") String loginId);
}
