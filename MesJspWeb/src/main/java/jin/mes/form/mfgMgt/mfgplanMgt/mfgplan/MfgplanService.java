package jin.mes.form.mfgMgt.mfgplanMgt.mfgplan;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

public interface MfgplanService {
	
	public PageInfo<MfgplanDto> getMonthPlanList(MfgplanDto planDto, PageRequestVo pageRequestVo);

	public PageInfo<MfgplanDto> getDayPlanList(MfgplanDto planDto, PageRequestVo pageRequestVo);
	
	public PageInfo<ProductPlanDto> getPlanDetail(ProductPlanDto productPlanDto, PageRequestVo pageRequestVo);
	
	public String setPlanCnt(ProductPlanDto productPlanDto);
	
	//일괄처리 가능여부 조회
	public ProductPlanDto getBulkPos(ProductPlanDto productPlanDto);
	
	//일괄처리 저장
	public String setBulkSave(ProductPlanDto productPlanDto);
	
	//일괄처리 삭제
	public String setBulkDelete(ProductPlanDto productPlanDto);
}
