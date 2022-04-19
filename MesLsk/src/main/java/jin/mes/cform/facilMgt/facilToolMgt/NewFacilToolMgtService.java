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
	public PageInfo<NewFacilToolMgtDto> getEqmtToolList(NewFacilToolMgtDto newEqmtToolDto, PageRequestVo pageRequestVo){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		newEqmtToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newEqmtToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newEqmtToolMapper.selectEqmtToolCount(newEqmtToolDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = newEqmtToolMapper.selectEqmtToolList(newEqmtToolDto);
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
	public List<NewFacilToolMgtDto> getEqmtToolListAll(NewFacilToolMgtDto newEqmtToolDto){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		try {
			//List
			eqmtMgtList = newEqmtToolMapper.selectEqmtToolListAll(newEqmtToolDto);
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
			for(NewFacilToolMgtDto newEqmtToolDto : eqmtToolList){
				newEqmtToolDto.setCreatorId(JteUtils.getUserId());
				newEqmtToolDto.setUpdatorId(JteUtils.getUserId());
				newEqmtToolMapper.insertEqmtTool(newEqmtToolDto);
				returnKey = newEqmtToolDto.getEqmtMgtId();
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
			for(NewFacilToolMgtDto newEqmtToolDto : eqmtToolList){
				newEqmtToolDto.setCreatorId(JteUtils.getUserId());
				newEqmtToolDto.setUpdatorId(JteUtils.getUserId());
				newEqmtToolMapper.deleteEqmtTool(newEqmtToolDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비공구 장착  삭제 에러 : " + e.getMessage());
		}
		
		return resultInt;
	}
	
	//설비에서 제작가능한 아이템 조회
	public List<NewFacilToolMgtDto> getEqmtToolItemList(NewFacilToolMgtDto newEqmtToolDto){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = newEqmtToolMapper.selectEqmtToolItemList(newEqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비-아이템 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비에서 제작가능한 라우팅 조회
	public List<NewFacilToolMgtDto> getEqmtToolRoutingList(NewFacilToolMgtDto newEqmtToolDto){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = newEqmtToolMapper.selectEqmtToolRoutingList(newEqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비-아이템 -라우팅 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비공구 장착 조회
	public List<NewFacilToolMgtDto> getEqmtToolPosList(NewFacilToolMgtDto newEqmtToolDto){
		List<NewFacilToolMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
//		newEqmtToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
//		newEqmtToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newEqmtToolMapper.selectEqmtToolPosCount(newEqmtToolDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = newEqmtToolMapper.selectEqmtToolPosList(newEqmtToolDto);
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
	public List<NewFacilToolMgtDto> getRoutingToolCurList(NewFacilToolMgtDto newEqmtToolDto){
		List<NewFacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = newEqmtToolMapper.selectRoutingToolCurList(newEqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("장착가능 공구 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<NewFacilToolMgtDto>();
		}
		return facilToolList;
	}
	
	//사용했던 공구 조회(관리자 조회용)
	public List<NewFacilToolMgtDto> getWorkToolAdminList(NewFacilToolMgtDto newEqmtToolDto){
		List<NewFacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = newEqmtToolMapper.selectWorkToolAdminList(newEqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("사용했던 공구 조회 : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<NewFacilToolMgtDto>();
		}
		return facilToolList;
	}
	
	// 작업정보 관리자용 사용가능 공구 조회(모두 조회)
	public List<NewFacilToolMgtDto> getWorkToolAdminPosList(NewFacilToolMgtDto newEqmtToolDto){
		List<NewFacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = newEqmtToolMapper.selectWorkToolAdminPosList(newEqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("작업정보 관리자용 사용가능 공구 조회 에러 : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<NewFacilToolMgtDto>();
		}
		return facilToolList;
	}
}
