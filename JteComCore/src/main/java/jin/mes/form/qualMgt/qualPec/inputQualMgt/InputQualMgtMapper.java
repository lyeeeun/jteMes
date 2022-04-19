package jin.mes.form.qualMgt.qualPec.inputQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdcursitMgt.MtrlOdcursitMgtDto;

@Mapper
public interface InputQualMgtMapper {
	public List<InputQualMgtDto> selectMtrlOrderInputList(InputQualMgtDto inputQualMgtDto);

	public int selectMtrlOrderInputCount(InputQualMgtDto inputQualMgtDto);
	
	public List<InputQualMgtDto> selectMtrlOrderPlanInputList(InputQualMgtDto inputQualMgtDto);

	public int selectMtrlOrderPlanInputCount(InputQualMgtDto inputQualMgtDto);
	
	public void updateInputQualOmgt(InputQualMgtDto inputQualMgtDto);
}
