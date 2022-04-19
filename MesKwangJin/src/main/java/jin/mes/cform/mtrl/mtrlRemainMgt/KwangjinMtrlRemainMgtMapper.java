package jin.mes.cform.mtrl.mtrlRemainMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.mtrlRemainMgt.KwangjinMtrlRemainHisDto;
import jin.mes.cform.mtrl.mtrlRemainMgt.KwangjinMtrlRemainMgtDto;

@Mapper
public interface KwangjinMtrlRemainMgtMapper {
	//자재관리
	public List<KwangjinMtrlRemainMgtDto> selectMtrlMgtList(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);
	
	public int selectMtrlMgtCount(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);

	public void insertMtrlMgt(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);
	
	public void updateMtrlMgt(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);
	
	
	//자재수량관리
	public List<KwangjinMtrlRemainMgtDto> selectMtrlMgtHisList(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);
	
	public int selectMtrlMgtHisCount(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);
	
	public int selectMtrlMgtHisTotal(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);

	
	public List<KwangjinMtrlRemainHisDto> selectMtrlRemainHisList(KwangjinMtrlRemainHisDto kwangjinMtrlRemainHisDto);
	
	public int selectMtrlRemainHisCount(KwangjinMtrlRemainHisDto kwangjinMtrlRemainHisDto);
	
	public int selectMtrlRemainHisTotal(KwangjinMtrlRemainHisDto kwangjinMtrlRemainHisDto);

	public void insertMtrlRemainHis(KwangjinMtrlRemainHisDto kwangjinMtrlRemainHisDto);
	
	public void updateMtrlRemainHis(KwangjinMtrlRemainHisDto kwangjinMtrlRemainHisDto);
	
	public int deleteMtrlRemainHis(KwangjinMtrlRemainHisDto kwangjinMtrlRemainHisDto);
	
	//자재 사용이력 수동관리
	public void insertManualInfo(KwangjinMtrlRemainHisDto kwangjinMtrlRemainHisDto);
	
	public void updateManualInfo(KwangjinMtrlRemainHisDto kwangjinMtrlRemainHisDto);
	
	public int deleteManualInfo(KwangjinMtrlRemainHisDto kwangjinMtrlRemainHisDto);
	
	//자재 잔량 관리
	public List<KwangjinMtrlRemainMgtDto> selectMtrlRemainList(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);
	
	public int selectMtrlRemainCount(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);

	public void insertMtrlRemain(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);
		
	public void updateMtrlRemain(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);
	
	public void deleteMtrlRemain(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto);
	
}
