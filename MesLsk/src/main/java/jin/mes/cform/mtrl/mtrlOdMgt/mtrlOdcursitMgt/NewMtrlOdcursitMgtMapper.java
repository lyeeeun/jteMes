package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt.NewMtrlOdcursitMgtDto;

@Mapper
public interface NewMtrlOdcursitMgtMapper {
	public List<NewMtrlOdcursitMgtDto> selectMtrlOrderFormList(NewMtrlOdcursitMgtDto newMtrlOrderFormDto);

	public int selectMtrlOrderFormCount(NewMtrlOdcursitMgtDto newMtrlOrderFormDto);

	public void insertMtrlOrderForm(NewMtrlOdcursitMgtDto newMtrlOrderFormDto);

	public void updateMtrlOrderForm(NewMtrlOdcursitMgtDto newMtrlOrderFormDto);

	public int deleteMtrlOrderForm(NewMtrlOdcursitMgtDto newMtrlOrderFormDto);
}
