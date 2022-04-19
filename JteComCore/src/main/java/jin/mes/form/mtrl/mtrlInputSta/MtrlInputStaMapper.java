package jin.mes.form.mtrl.mtrlInputSta;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;



@Mapper
public interface MtrlInputStaMapper {
	
	public List<MtrlInputStaDto> selectLotList (MtrlInputStaDto mtrlInputStaDto);
	
	public int selectLotCount (MtrlInputStaDto mtrlInputStaDto);
	
	public List<MtrlInputStaDto> selectMtrlInputList (MtrlInputStaDto mtrlInputStaDto);
	
	public int selectMtrlInputCount (MtrlInputStaDto mtrlInputStaDto);
}
