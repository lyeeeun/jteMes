package jin.mes.cform.mtrl.mtrlDisburseMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.mtrlDisburseMgt.KwangjinMtrlDisburseHisDto;
import jin.mes.cform.mtrl.mtrlDisburseMgt.KwangjinMtrlDisburseMgtDto;


@Mapper
public interface KwangjinMtrlDisburseMgtMapper {
	//자재관리
	public List<KwangjinMtrlDisburseMgtDto> selectMtrlDisburseMgtList(KwangjinMtrlDisburseMgtDto kwangjinMtrlDisburseMgtDto);
	
	public int selectMtrlDisburseMgtCount(KwangjinMtrlDisburseMgtDto kwangjinMtrlDisburseMgtDto);
	
	public void insertMtrlDisburseMgt(KwangjinMtrlDisburseMgtDto kwangjinMtrlDisburseMgtDto);
	
	public void updateMtrlDisburseMgt(KwangjinMtrlDisburseMgtDto kwangjinMtrlDisburseMgtDto);
	
	public void updateMtrlDisburseMgtIsDel(KwangjinMtrlDisburseMgtDto kwangjinMtrlDisburseMgtDto);
	
	//자재수량관리
	public List<KwangjinMtrlDisburseHisDto> selectMtrlDisburseHisList(KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto);
	
	public int selectMtrlDisburseHisCount(KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto);
	
	public int selectMtrlDisburseHisTotal(KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto);

	public void insertMtrlDisburseHis(KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto);
	
	public void updateMtrlDisburseHis(KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto);
	
	public int deleteMtrlDisburseHis(KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto);
	
	
	//자재 사용이력 수동관리
	public void insertManualInfo(KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto);
	
	public void updateManualInfo(KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto);
	
	public int deleteManualInfo(KwangjinMtrlDisburseHisDto kwangjinMtrlDisburseHisDto);
		
}
