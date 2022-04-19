package jin.mes.form.mfgMgt.wrkinWrkerMgt;

import java.util.List;

import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtDto;
import jin.mes.form.mtrl.mtrltoolMgt.MtrltoolMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;


public interface WrkinWrkerMgtService {
	// 작업정보 조회
	public PageInfo<WrkinTeamMgtDto> getProdWorkList(WrkinTeamMgtDto asgnDto, PageRequestVo pageRequestVo);

	// 작업정보 팝업 조회
	public List<WrkinTeamMgtDto> getProdWorkPop(WrkinTeamMgtDto asgnDto);
		
	// 작업정보 입력/수정
	public String setProdWorkSave(WrkinTeamMgtDto asgnDto);
	
	// 작업정보 삭제
	public int setProdWorkDelete(List<WrkinTeamMgtDto> asgnList);	
	// 자재점검 팝업 조회(리스트)
	public List<MtrlMgtDto> getProdMtrlChkList(WrkinTeamMgtDto asgnDto);
	
	//설비공구 장착 해제 
	public String setEqmtToolDelete(List<FacilToolMgtDto> eqmtToolList);
	
	// 작업정보 시작 저장
	public String setProdWorkStartSave(WrkinTeamMgtDto asgnDto);
	
	// 자재투입현황(종합, 상세, 불량)
	public List<MtrlUseDto> getMtrlUseList(MtrlUseDto mtrlUseDto);
	
	// 자재 사용정보 입력/수정
	public String setMtrlUseSave(MtrlUseDto mtrlUseDto);

	// 자재 사용정보 삭제
	public int setMtrlUseDelete(List<MtrlUseDto> mtrlUseList);
	
	//작업종료 기본정보만 저장
	public String setProdWorkEndPgSave(WrkinTeamMgtDto asgnDto);
	
	// 작업종료 저장
	//설비가동시간, 공구사용, 자재투입등
	public String setProdWorkEndSave(WrkinTeamMgtDto asgnDto);
	
	// 작업종료 관리자저장
	public String setProdWorkAdminSave(WrkinTeamMgtDto asgnDto);
	
	//작업공구 등록 (관리자)
	public int setWorkToolAdminInsert(List<MtrltoolMgtDto> toolMgtList);
	
	//작업공구 수정(관리자)
	public int setWorkToolAdminUpdate(MtrltoolMgtDto toolMgtDto);
	
	//작업공구 삭제 (관리자)
	public int setWorkToolAdminDelete(List<MtrltoolMgtDto> toolMgtList);
}
