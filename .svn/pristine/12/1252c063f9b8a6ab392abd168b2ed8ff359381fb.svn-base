package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ZinixMtrlOdplanMgtMapper {

	public List<ZinixMtrlOdplanMgtDto> selectMtrlOrderList(ZinixMtrlOdplanMgtDto mtrlOrderDto);

	public int selectMtrlOrderCount(ZinixMtrlOdplanMgtDto mtrlOrderDto);

	public void insertMtrlOrder(ZinixMtrlOdplanMgtDto mtrlOrderDto);

	public void updateMtrlOrder(ZinixMtrlOdplanMgtDto mtrlOrderDto);

	public int deleteMtrlOrder(ZinixMtrlOdplanMgtDto mtrlOrderDto);
	
	
	//관련 업체
	public List<ZinixMtrlOdplanMgtDto> selectOrderCompChild(ZinixMtrlOdplanMgtDto odPlanMgtDto);
	
	public void insertOrderComp(ZinixMtrlOdplanMgtDto mtrlOrderDto);
	
	public void deleteOrderComp(ZinixMtrlOdplanMgtDto mtrlOrderDto);
	
}
