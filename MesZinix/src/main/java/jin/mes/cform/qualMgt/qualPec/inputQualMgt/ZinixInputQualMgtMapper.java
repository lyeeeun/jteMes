package jin.mes.cform.qualMgt.qualPec.inputQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt.ZinixMtrlOdcursitMgtDto;

@Mapper
public interface ZinixInputQualMgtMapper {
	public List<ZinixInputQualMgtDto> selectMtrlOrderInputList(ZinixInputQualMgtDto zinixInputQualMgtDto);

	public int selectMtrlOrderInputCount(ZinixInputQualMgtDto zinixInputQualMgtDto);
	
	public List<ZinixInputQualMgtDto> selectMtrlOrderPlanInputList(ZinixInputQualMgtDto zinixInputQualMgtDto);

	public int selectMtrlOrderPlanInputCount(ZinixInputQualMgtDto zinixInputQualMgtDto);
	
	public void updateInputQualOmgt(ZinixInputQualMgtDto zinixInputQualMgtDto);
}
