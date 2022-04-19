package jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

public interface NewMfgplanService {
	
	public PageInfo<NewMfgplanDto> getMonthPlanList(NewMfgplanDto newPlanDto, PageRequestVo pageRequestVo);

	public PageInfo<NewMfgplanDto> getDayPlanList(NewMfgplanDto newPlanDto, PageRequestVo pageRequestVo);
	
	public PageInfo<NewProductPlanDto> getPlanDetail(NewProductPlanDto newProductPlanDto, PageRequestVo pageRequestVo);
	
	public String setPlanCnt(NewProductPlanDto newProductPlanDto);
	
	//일괄처리 가능여부 조회
	public NewProductPlanDto getBulkPos(NewProductPlanDto newProductPlanDto);
	
	//일괄처리 저장
	public String setBulkSave(NewProductPlanDto newProductPlanDto);
	
	//일괄처리 삭제
	public String setBulkDelete(NewProductPlanDto newProductPlanDto);
}
