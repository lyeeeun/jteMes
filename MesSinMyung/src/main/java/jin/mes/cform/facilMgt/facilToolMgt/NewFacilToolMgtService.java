package jin.mes.cform.facilMgt.facilToolMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewFacilToolMgtService {

	@Resource
	NewFacilToolMgtMapper newEqmtToolMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	//설비공구 장착 조회
	public PageInfo<NewFacilToolMgtDto> getEqmtToolList(NewFacilToolMgtDto eqmtToolDto, PageRequestVo pageRequestVo){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		eqmtToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		eqmtToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newEqmtToolMapper.selectEqmtToolCount(eqmtToolDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = newEqmtToolMapper.selectEqmtToolList(eqmtToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비공구 장착 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilToolMgtDto>();
		}
		return new PageInfo<NewFacilToolMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비공구 장착 조회(ALL)
	public List<NewFacilToolMgtDto> getEqmtToolListAll(NewFacilToolMgtDto eqmtToolDto){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		try {
			//List
			eqmtMgtList = newEqmtToolMapper.selectEqmtToolListAll(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비공구 장착 조회 에러입니다.(ALL) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비공구 장착 입력
	@Transactional
	public String setEqmtToolSave(List<NewFacilToolMgtDto> eqmtToolList){
		String returnKey = "";
		try {
			//설비공구 장착 입력
			for(NewFacilToolMgtDto eqmtToolDto : eqmtToolList){
				eqmtToolDto.setCreatorId(JteUtils.getUserId());
				eqmtToolDto.setUpdatorId(JteUtils.getUserId());
				newEqmtToolMapper.insertEqmtTool(eqmtToolDto);
				returnKey = eqmtToolDto.getEqmtMgtId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비공구 장착  입력 에러 : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//설비공구 장착 삭제
	@Transactional
	public int setEqmtToolDelete(List<NewFacilToolMgtDto> eqmtToolList){
		int resultInt = -1;
		try {
			//설비공구 장착 삭제
			for(NewFacilToolMgtDto eqmtToolDto : eqmtToolList){
				eqmtToolDto.setCreatorId(JteUtils.getUserId());
				eqmtToolDto.setUpdatorId(JteUtils.getUserId());
				newEqmtToolMapper.deleteEqmtTool(eqmtToolDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비공구 장착  삭제 에러 : " + e.getMessage());
		}
		
		return resultInt;
	}
	
	//설비에서 제작가능한 아이템 조회
	public List<NewFacilToolMgtDto> getEqmtToolItemList(NewFacilToolMgtDto eqmtToolDto){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = newEqmtToolMapper.selectEqmtToolItemList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비-아이템 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비에서 제작가능한 라우팅 조회
	public List<NewFacilToolMgtDto> getEqmtToolRoutingList(NewFacilToolMgtDto eqmtToolDto){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = newEqmtToolMapper.selectEqmtToolRoutingList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비-아이템 -라우팅 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비공구 장착 조회
	public List<NewFacilToolMgtDto> getEqmtToolPosList(NewFacilToolMgtDto eqmtToolDto){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
//		eqmtToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
//		eqmtToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newEqmtToolMapper.selectEqmtToolPosCount(eqmtToolDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = newEqmtToolMapper.selectEqmtToolPosList(eqmtToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("장착가능 공구 조회 에러입니다.(List) : " + e.getMessage());
		}
 		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	
	//설비공구 장착 조회
	public List<NewFacilToolMgtDto> getRoutingToolCurList(NewFacilToolMgtDto eqmtToolDto){
		List<NewFacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = newEqmtToolMapper.selectRoutingToolCurList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("장착가능 공구 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<NewFacilToolMgtDto>();
		}
		return facilToolList;
	}
	
	//사용했던 공구 조회(관리자 조회용)
	public List<NewFacilToolMgtDto> getWorkToolAdminList(NewFacilToolMgtDto eqmtToolDto){
		List<NewFacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = newEqmtToolMapper.selectWorkToolAdminList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("사용했던 공구 조회 : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<NewFacilToolMgtDto>();
		}
		return facilToolList;
	}
	
	// 작업정보 관리자용 사용가능 공구 조회(모두 조회)
	public List<NewFacilToolMgtDto> getWorkToolAdminPosList(NewFacilToolMgtDto eqmtToolDto){
		List<NewFacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = newEqmtToolMapper.selectWorkToolAdminPosList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("작업정보 관리자용 사용가능 공구 조회 에러 : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<NewFacilToolMgtDto>();
		}
		return facilToolList;
	}
}
