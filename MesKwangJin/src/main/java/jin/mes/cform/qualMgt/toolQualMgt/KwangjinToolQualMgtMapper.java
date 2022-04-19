package jin.mes.cform.qualMgt.toolQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.toolQualMgt.KwangjinToolQualMgtDto;


@Mapper
public interface KwangjinToolQualMgtMapper {
	
	public List<KwangjinToolQualMgtDto> selectToolMgtList(KwangjinToolQualMgtDto kwangjinToolQualMgtDto);
	public List<KwangjinToolQualMgtDto> selectToolInfoList(KwangjinToolQualMgtDto kwangjinToolQualMgtDto);
	public List<KwangjinToolQualMgtDto> selectToolQualList(KwangjinToolQualMgtDto kwangjinToolQualMgtDto);
	
	public int selectToolMgtCount(KwangjinToolQualMgtDto kwangjinToolQualMgtDto);
	public int selectToolInfoCount(KwangjinToolQualMgtDto kwangjinToolQualMgtDto);
	public int selectToolQualCount(KwangjinToolQualMgtDto kwangjinToolQualMgtDto);
	
	public void insertToolQual(KwangjinToolQualMgtDto kwangjinToolQualMgtDto);
	public void updateToolQual(KwangjinToolQualMgtDto kwangjinToolQualMgtDto);
	public int deleteToolQual(KwangjinToolQualMgtDto kwangjinToolQualMgtDto);
}
