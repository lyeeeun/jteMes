package jin.mes.form.facilMgt.facilToolMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.mapper.facilMgt.facilToolMgt.FacilToolMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class FacilToolMgtService {

	@Resource
	FacilToolMgtMapper eqmtToolMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	//설비공구 장착 조회
	public PageInfo<FacilToolMgtDto> getEqmtToolList(FacilToolMgtDto eqmtToolDto, PageRequestVo pageRequestVo){
		List<FacilToolMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		eqmtToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		eqmtToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = eqmtToolMapper.selectEqmtToolCount(eqmtToolDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = eqmtToolMapper.selectEqmtToolList(eqmtToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비공구 장착 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilToolMgtDto>();
		}
		return new PageInfo<FacilToolMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비공구 장착 조회(ALL)
	public List<FacilToolMgtDto> getEqmtToolListAll(FacilToolMgtDto eqmtToolDto){
		List<FacilToolMgtDto> eqmtMgtList = null;
		try {
			//List
			eqmtMgtList = eqmtToolMapper.selectEqmtToolListAll(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비공구 장착 조회 에러입니다.(ALL) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비공구 장착 입력
	@Transactional
	public String setEqmtToolSave(List<FacilToolMgtDto> eqmtToolList){
		String returnKey = "";
		try {
			//설비공구 장착 입력
			for(FacilToolMgtDto eqmtToolDto : eqmtToolList){
				eqmtToolDto.setCreatorId(JteUtils.getUserId());
				eqmtToolDto.setUpdatorId(JteUtils.getUserId());
				eqmtToolMapper.insertEqmtTool(eqmtToolDto);
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
	public int setEqmtToolDelete(List<FacilToolMgtDto> eqmtToolList){
		int resultInt = -1;
		try {
			//설비공구 장착 삭제
			for(FacilToolMgtDto eqmtToolDto : eqmtToolList){
				eqmtToolDto.setCreatorId(JteUtils.getUserId());
				eqmtToolDto.setUpdatorId(JteUtils.getUserId());
				eqmtToolMapper.deleteEqmtTool(eqmtToolDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비공구 장착  삭제 에러 : " + e.getMessage());
		}
		
		return resultInt;
	}
	
	//설비에서 제작가능한 아이템 조회
	public List<FacilToolMgtDto> getEqmtToolItemList(FacilToolMgtDto eqmtToolDto){
		List<FacilToolMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = eqmtToolMapper.selectEqmtToolItemList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비-아이템 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비에서 제작가능한 라우팅 조회
	public List<FacilToolMgtDto> getEqmtToolRoutingList(FacilToolMgtDto eqmtToolDto){
		List<FacilToolMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = eqmtToolMapper.selectEqmtToolRoutingList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비-아이템 -라우팅 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비공구 장착 조회
	public List<FacilToolMgtDto> getEqmtToolPosList(FacilToolMgtDto eqmtToolDto){
		List<FacilToolMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
//		eqmtToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
//		eqmtToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = eqmtToolMapper.selectEqmtToolPosCount(eqmtToolDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = eqmtToolMapper.selectEqmtToolPosList(eqmtToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("장착가능 공구 조회 에러입니다.(List) : " + e.getMessage());
		}
 		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	
	//설비공구 장착 조회
	public List<FacilToolMgtDto> getRoutingToolCurList(FacilToolMgtDto eqmtToolDto){
		List<FacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = eqmtToolMapper.selectRoutingToolCurList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("장착가능 공구 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<FacilToolMgtDto>();
		}
		return facilToolList;
	}
	
	//사용했던 공구 조회(관리자 조회용)
	public List<FacilToolMgtDto> getWorkToolAdminList(FacilToolMgtDto eqmtToolDto){
		List<FacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = eqmtToolMapper.selectWorkToolAdminList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("사용했던 공구 조회 : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<FacilToolMgtDto>();
		}
		return facilToolList;
	}
	
	// 작업정보 관리자용 사용가능 공구 조회(모두 조회)
	public List<FacilToolMgtDto> getWorkToolAdminPosList(FacilToolMgtDto eqmtToolDto){
		List<FacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = eqmtToolMapper.selectWorkToolAdminPosList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("작업정보 관리자용 사용가능 공구 조회 에러 : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<FacilToolMgtDto>();
		}
		return facilToolList;
	}
}
