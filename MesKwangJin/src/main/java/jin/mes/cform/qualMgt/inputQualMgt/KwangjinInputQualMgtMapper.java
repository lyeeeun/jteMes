package jin.mes.cform.qualMgt.inputQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.inputQualMgt.KwangjinInputQualMgtDto;

@Mapper
public interface KwangjinInputQualMgtMapper {
	
	public List<KwangjinInputQualMgtDto> selectMtrlBadList(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);
	
	public int selectMtrlBadCount(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);
	
	public void insertMtrlBad(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);
	
	public void updateMtrlBad(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);
	
	public int deleteMtrlBad(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);
	
	
	public List<KwangjinInputQualMgtDto> selectMtrlMgtHisList(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);

	public int selectMtrlMgtHisCount(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);

	
	public List<KwangjinInputQualMgtDto> selectMtrlMgtList(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);

	public int selectMtrlMgtCount(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);
	
	
	public void updateInputQual(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);
	public void updateMtrlInput(KwangjinInputQualMgtDto kwangjinInputQualMgtDto);
}
