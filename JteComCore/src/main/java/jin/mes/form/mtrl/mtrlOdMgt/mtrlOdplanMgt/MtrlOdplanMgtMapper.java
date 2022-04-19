package jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdcursitMgt.MtrlOdcursitMgtDto;

@Mapper
public interface MtrlOdplanMgtMapper {

	public List<MtrlOdplanMgtDto> selectMtrlOrderList(MtrlOdplanMgtDto mtrlOrderDto);

	public int selectMtrlOrderCount(MtrlOdplanMgtDto mtrlOrderDto);

	public void insertMtrlOrder(MtrlOdplanMgtDto mtrlOrderDto);

	public void updateMtrlOrder(MtrlOdplanMgtDto mtrlOrderDto);
	
	public void updateMtrlQualSta(MtrlOdplanMgtDto MtrlOdplanMgtDto);

	public int deleteMtrlOrder(MtrlOdplanMgtDto mtrlOrderDto);
	
	
	//관련 업체
	public List<MtrlOdplanMgtDto> selectOrderCompChild(MtrlOdplanMgtDto odPlanMgtDto);
	
	public void insertOrderComp(MtrlOdplanMgtDto mtrlOrderDto);
	
	public void deleteOrderComp(MtrlOdplanMgtDto mtrlOrderDto);
	
}
