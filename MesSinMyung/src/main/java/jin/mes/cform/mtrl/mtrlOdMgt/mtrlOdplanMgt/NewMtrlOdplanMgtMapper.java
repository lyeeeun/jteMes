package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewMtrlOdplanMgtMapper {

	public List<NewMtrlOdplanMgtDto> selectMtrlOrderList(NewMtrlOdplanMgtDto mtrlOrderDto);

	public int selectMtrlOrderCount(NewMtrlOdplanMgtDto mtrlOrderDto);

	public void insertMtrlOrder(NewMtrlOdplanMgtDto mtrlOrderDto);

	public void updateMtrlOrder(NewMtrlOdplanMgtDto mtrlOrderDto);

	public int deleteMtrlOrder(NewMtrlOdplanMgtDto mtrlOrderDto);
}
