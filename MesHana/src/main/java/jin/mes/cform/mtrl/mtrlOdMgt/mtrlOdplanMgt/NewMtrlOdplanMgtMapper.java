package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.NewMtrlOdplanMgtDto;

@Mapper
public interface NewMtrlOdplanMgtMapper {

	public List<NewMtrlOdplanMgtDto> selectMtrlOrderList(NewMtrlOdplanMgtDto newMtrlOrderDto);

	public int selectMtrlOrderCount(NewMtrlOdplanMgtDto newMtrlOrderDto);

	public void insertMtrlOrder(NewMtrlOdplanMgtDto newMtrlOrderDto);

	public void updateMtrlOrder(NewMtrlOdplanMgtDto newMtrlOrderDto);

	public int deleteMtrlOrder(NewMtrlOdplanMgtDto newMtrlOrderDto);
}
