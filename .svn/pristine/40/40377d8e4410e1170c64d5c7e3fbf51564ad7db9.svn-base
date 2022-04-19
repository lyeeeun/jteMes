package jin.mes.cform.mfgMgt.wrkinWrkerMgt;

import java.util.List;

import jin.mes.cform.facilMgt.facilToolMgt.NewFacilToolMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtDto;
import jin.mes.cform.mtrl.mtrltoolMgt.NewMtrltoolMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;


public interface NewWrkinWrkerMgtService {
	// 작업정보 조회
	public PageInfo<NewWrkinTeamMgtDto> getProdWorkList(NewWrkinTeamMgtDto asgnDto, PageRequestVo pageRequestVo);

	// 작업정보 팝업 조회
	public List<NewWrkinTeamMgtDto> getProdWorkPop(NewWrkinTeamMgtDto asgnDto);
		
	// 작업정보 입력/수정
	public String setProdWorkSave(NewWrkinTeamMgtDto asgnDto);
	
	// 작업정보 삭제
	public int setProdWorkDelete(List<NewWrkinTeamMgtDto> asgnList);	
	// 자재점검 팝업 조회(리스트)
	public List<NewMtrlMgtDto> getProdMtrlChkList(NewWrkinTeamMgtDto asgnDto);
	
	//설비공구 장착 해제 
	public String setEqmtToolDelete(List<NewFacilToolMgtDto> eqmtToolList);
	
	// 작업정보 시작 저장
	public String setProdWorkStartSave(NewWrkinTeamMgtDto asgnDto);
	
	// 자재투입현황(종합, 상세, 불량)
	public List<NewMtrlUseDto> getMtrlUseList(NewMtrlUseDto mtrlUseDto);
	
	// 자재 사용정보 입력/수정
	public String setMtrlUseSave(NewMtrlUseDto mtrlUseDto);

	// 자재 사용정보 삭제
	public int setMtrlUseDelete(List<NewMtrlUseDto> mtrlUseList);
	
	//작업종료 기본정보만 저장
	public String setProdWorkEndPgSave(NewWrkinTeamMgtDto asgnDto);
	
	// 작업종료 저장
	//설비가동시간, 공구사용, 자재투입등
	public String setProdWorkEndSave(NewWrkinTeamMgtDto asgnDto);
	
	// 작업종료 관리자저장
	public String setProdWorkAdminSave(NewWrkinTeamMgtDto asgnDto);
	
	//작업공구 등록 (관리자)
	public int setWorkToolAdminInsert(List<NewMtrltoolMgtDto> toolMgtList);
	
	//작업공구 수정(관리자)
	public int setWorkToolAdminUpdate(NewMtrltoolMgtDto toolMgtDto);
	
	//작업공구 삭제 (관리자)
	public int setWorkToolAdminDelete(List<NewMtrltoolMgtDto> toolMgtList);
}
