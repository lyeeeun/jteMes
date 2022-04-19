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
public class ZinixFacilToolMgtService {

	@Resource
	ZinixFacilToolMgtMapper eqmtToolMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	//설비공구 장착 조회
	public PageInfo<ZinixFacilToolMgtDto> getEqmtToolList(ZinixFacilToolMgtDto eqmtToolDto, PageRequestVo pageRequestVo){
		List<ZinixFacilToolMgtDto> eqmtMgtList = null;
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
			eqmtMgtList = new ArrayList<ZinixFacilToolMgtDto>();
		}
		return new PageInfo<ZinixFacilToolMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비공구 장착 조회(ALL)
	public List<ZinixFacilToolMgtDto> getEqmtToolListAll(ZinixFacilToolMgtDto eqmtToolDto){
		List<ZinixFacilToolMgtDto> eqmtMgtList = null;
		try {
			//List
			eqmtMgtList = eqmtToolMapper.selectEqmtToolListAll(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비공구 장착 조회 에러입니다.(ALL) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<ZinixFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비공구 장착 입력
	@Transactional
	public String setEqmtToolSave(List<ZinixFacilToolMgtDto> eqmtToolList){
		String returnKey = "";
		try {
			//설비공구 장착 입력
			for(ZinixFacilToolMgtDto eqmtToolDto : eqmtToolList){
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
	public int setEqmtToolDelete(List<ZinixFacilToolMgtDto> eqmtToolList){
		int resultInt = -1;
		try {
			//설비공구 장착 삭제
			for(ZinixFacilToolMgtDto eqmtToolDto : eqmtToolList){
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
	public List<ZinixFacilToolMgtDto> getEqmtToolItemList(ZinixFacilToolMgtDto eqmtToolDto){
		List<ZinixFacilToolMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = eqmtToolMapper.selectEqmtToolItemList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비-아이템 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<ZinixFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비에서 제작가능한 라우팅 조회
	public List<ZinixFacilToolMgtDto> getEqmtToolRoutingList(ZinixFacilToolMgtDto eqmtToolDto){
		List<ZinixFacilToolMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = eqmtToolMapper.selectEqmtToolRoutingList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("설비-아이템 -라우팅 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<ZinixFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비공구 장착 조회
	public List<ZinixFacilToolMgtDto> getEqmtToolPosList(ZinixFacilToolMgtDto eqmtToolDto){
		List<ZinixFacilToolMgtDto> eqmtMgtList = null;
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
			eqmtMgtList = new ArrayList<ZinixFacilToolMgtDto>();
		}
		return eqmtMgtList;
	}
	
	
	//설비공구 장착 조회
	public List<ZinixFacilToolMgtDto> getRoutingToolCurList(ZinixFacilToolMgtDto eqmtToolDto){
		List<ZinixFacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = eqmtToolMapper.selectRoutingToolCurList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("장착가능 공구 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<ZinixFacilToolMgtDto>();
		}
		return facilToolList;
	}
	
	//사용했던 공구 조회(관리자 조회용)
	public List<ZinixFacilToolMgtDto> getWorkToolAdminList(ZinixFacilToolMgtDto eqmtToolDto){
		List<ZinixFacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = eqmtToolMapper.selectWorkToolAdminList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("사용했던 공구 조회 : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<ZinixFacilToolMgtDto>();
		}
		return facilToolList;
	}
	
	// 작업정보 관리자용 사용가능 공구 조회(모두 조회)
	public List<ZinixFacilToolMgtDto> getWorkToolAdminPosList(ZinixFacilToolMgtDto eqmtToolDto){
		List<ZinixFacilToolMgtDto> facilToolList = null;
		try {
			//List
			facilToolList = eqmtToolMapper.selectWorkToolAdminPosList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("작업정보 관리자용 사용가능 공구 조회 에러 : " + e.getMessage());
		}
		if (facilToolList == null) {
			facilToolList = new ArrayList<ZinixFacilToolMgtDto>();
		}
		return facilToolList;
	}
}
