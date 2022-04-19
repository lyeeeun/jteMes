package jin.mes.form.mfgMgt.productWork;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mfgMgt.wrkinWrkerMgt.MtrlUseDto;
import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;


public interface ProductWorkService {
	//주문목록 List
	public PageInfo<LotInfoDto> getProductWorkLotList(LotInfoDto lotInfoDto, PageRequestVo pageRequestVo);
	
	//작업지시 목록  조회
	public List<WrkinTeamMgtDto> getProdWorkAsgnList(WrkinTeamMgtDto wrkinTeamMgtDto);
	
	// 작업지시 팝업 조회
	public List<WrkinTeamMgtDto> getProdWorkAsgnDetail(WrkinTeamMgtDto asgnDto);
			
	// 작업지시 입력/수정
	public String setProdWorkAsgnSave(WrkinTeamMgtDto asgnDto);

	// 작업지시 삭제
	public int setProdWorkAsgnDelete(List<WrkinTeamMgtDto> asgnList);
	
	//라우팅시트 조회
	public List<WrkinTeamMgtDto> getProdWorkRoutSheetList(WrkinTeamMgtDto asgnDto);
	
	//작업정보 입력/수정
	public String setProdWorkRoutSheetSave(WrkinTeamMgtDto asgnDto);
	
	//설비 교체 리스트 조회
	public List<FacilMgtDto> getProdWorkEqmtChangeList(WrkinTeamMgtDto wrkinTeamMgtDto);
	
	// 작업정보 시작
	public String setProdWorkRoutSheetStart(WrkinTeamMgtDto asgnDto);
	// 작업정보 종료
	public String setProdWorkRoutSheetEnd(WrkinTeamMgtDto asgnDto);
	
	//장착된 공구 조회
	public List<FacilToolMgtDto> getProdWorkEqmtToolList(FacilToolMgtDto eqmtToolDto);
	//사용가능한 공구 조회
	public List<FacilToolMgtDto> getProdWorkToolUseableList(FacilToolMgtDto eqmtToolDto);
	//공구장착
	public String setProdWorkEqmtTool(List<FacilToolMgtDto> eqmtToolList);
	//공구해제
	public String setProdWorkEqmtToolDel(List<FacilToolMgtDto> eqmtToolList);
	
	//투입자재 조회
	public List<MtrlUseDto> getProdWorkMtrl(MtrlUseDto mtrlUseDto);
	//투입자재 등록/수정
	public String setProdWorkMtrlSave(MtrlUseDto mtrlUseDto);
	//투입자재 삭제
	public int setProdWorkMtrlDelete(List<MtrlUseDto> mtrlUseList);
	
	public List<InfergodsMgtDto> getProdWorkItemBadList(InfergodsMgtDto itemBadDto);
	
	public String setProdWorkItemBadSave(InfergodsMgtDto itemBadDto);
}
