package jin.mes.cform.mtrl.mtrlRecevingMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingHisDto;
import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingMgtDto;


@Mapper
public interface KwangjinMtrlRecevingMgtMapper {
	//자재관리
	public List<KwangjinMtrlRecevingMgtDto> selectMtrlRecevingMgtList(KwangjinMtrlRecevingMgtDto kwangjinMtrlRecevingMgtDto);
	
	public int selectMtrlRecevingMgtCount(KwangjinMtrlRecevingMgtDto kwangjinMtrlRecevingMgtDto);
	
	public void insertMtrlRecevingMgt(KwangjinMtrlRecevingMgtDto kwangjinMtrlRecevingMgtDto);
	
	public void updateMtrlRecevingMgt(KwangjinMtrlRecevingMgtDto kwangjinMtrlRecevingMgtDto);
	
	public void updateMtrlRecevingMgtIsDel(KwangjinMtrlRecevingMgtDto kwangjinMtrlRecevingMgtDto);
	
	//자재수량관리
	public List<KwangjinMtrlRecevingHisDto> selectMtrlRecevingHisList(KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto);
	
	public int selectMtrlRecevingHisCount(KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto);
	
	public int selectMtrlRecevingHisTotal(KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto);

	public void insertMtrlRecevingHis(KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto);
	
	public void updateMtrlRecevingHis(KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto);
	
	public int deleteMtrlRecevingHis(KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto);
	
	
	//자재 사용이력 수동관리
	public void insertManualInfo(KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto);
	
	public void updateManualInfo(KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto);
	
	public int deleteManualInfo(KwangjinMtrlRecevingHisDto kwangjinMtrlRecevingHisDto);
		
}
