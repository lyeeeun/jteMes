package jin.mes.form.basMgt.routing.routingMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingRtlToolDto;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class RoutingMgtService {

	@Resource
	protected RoutingMgtMapper routingMgtMapper;

	@Autowired
	AttachMgtService attachMgtService;
	
	public List<RoutingMgtDto> getRoutingInfo(RoutingMgtDto routingMgtDto){
		List<RoutingMgtDto> routingInfo = null;
		try {
			routingInfo = routingMgtMapper.selectRoutingInfo(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: Routing - Select Error: " + e.getMessage());
		}
		return routingInfo;
	}
	
	//라우팅 등록
	@Transactional
	public String setRoutingInfo(RoutingMgtDto routingMgtDto) {
		try {
			routingMgtDto.setCreatorId(JteUtils.getUserId());
			routingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			routingMgtMapper.insertRoutingInfo(routingMgtDto);
			
			//첨부파일 저장
			if(routingMgtDto.getInsertAttach() != null && routingMgtDto.getInsertAttach().size() > 0) {
				String target = routingMgtDto.getCurrentMenuId();
				String targetCode = routingMgtDto.getRoutingId();
				attachMgtService.attachFilesSave(routingMgtDto.getInsertAttach(), target, targetCode);
			}
			//첨부파일 삭제
			if(routingMgtDto.getDeleteAttach() != null && routingMgtDto.getDeleteAttach().size() > 0) {
				attachMgtService.attachFilesDelete(routingMgtDto.getDeleteAttach());
			}
			
			setRtlBomSave(routingMgtDto);
			setRtlEqmtSave(routingMgtDto);
			setRtlToolSave(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: setRoutingInfo Error: " + e.getMessage());
		}
		return routingMgtDto.getRoutingId();
	}
	
	//라우팅 수정
	@Transactional
	public String updateRoutingInfo(RoutingMgtDto routingMgtDto) {
		try {
			routingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			routingMgtMapper.updateRoutingInfo(routingMgtDto);
			
			//첨부파일 저장
			if(routingMgtDto.getInsertAttach() != null && routingMgtDto.getInsertAttach().size() > 0) {
				String target = routingMgtDto.getCurrentMenuId();
				String targetCode = routingMgtDto.getRoutingId();
				attachMgtService.attachFilesSave(routingMgtDto.getInsertAttach(), target, targetCode);
			}
			//첨부파일 삭제
			if(routingMgtDto.getDeleteAttach() != null && routingMgtDto.getDeleteAttach().size() > 0) {
				attachMgtService.attachFilesDelete(routingMgtDto.getDeleteAttach());
			}
			
			setRtlBomSave(routingMgtDto);
			setRtlEqmtSave(routingMgtDto);
			setRtlToolSave(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateRoutingInfo Error: " + e.getMessage());
		}
		return routingMgtDto.getRoutingId();
	}
	
	//라우팅 삭제
	@Transactional
	public void deleteRoutingInfo(RoutingMgtDto routingMgtDto) {
		try {
			routingMgtMapper.deleteRoutingInfo(routingMgtDto);
			
			setRtlBomSave(routingMgtDto);
			setRtlEqmtSave(routingMgtDto);
			setRtlToolSave(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: deleteRoutingInfo Error: " + e.getMessage());
		}
	}
	
	//기본 설비 지정
	@Transactional
	public void settingDefaultTool(RoutingMgtDto routingMgtDto) {
		try {
			routingMgtMapper.updateEqmtAllFalse(routingMgtDto);
			routingMgtMapper.updateEqmtTrue(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: settingDefaultTool Error: " + e.getMessage());
		}
	}
	
	//rtl 조회
	public RoutingMgtDto getChildRtlList(RoutingMgtDto routingMgtDto){
		try {
			routingMgtDto.setChildBomList(routingMgtMapper.selectRtlBomList(routingMgtDto));
			routingMgtDto.setChildEqmtList(routingMgtMapper.selectRtlEqmtList(routingMgtDto));
			routingMgtDto.setChildToolList(routingMgtMapper.selectRtlToolList(routingMgtDto));
		} catch (Exception e) {
			throw new BusinessException("라우팅 rtl 조회 에러 : " + e.getMessage());
		}
		return routingMgtDto;
	}
	
	//Bom 저장
	@Transactional
	public int setRtlBomSave(RoutingMgtDto routingMgtDto){
		int returnKey = 0;
		try {
			for(BomMgtDto bomMgtDto : routingMgtDto.getChildBomList()) {
				bomMgtDto.setCreatorId(JteUtils.getUserId());
				bomMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(bomMgtDto.getAction().equals("C")) {
					routingMgtMapper.insertRtlBomList(bomMgtDto.getBomId(), routingMgtDto.getRoutingId());
				}else if(bomMgtDto.getAction().equals("D")) {
					routingMgtMapper.deleteRtlBomList(bomMgtDto.getBomId(), routingMgtDto.getRoutingId());
				}
			}
		} catch (Exception e) {
			returnKey = 0;
			throw new BusinessException("Bom 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//설비 저장
	@Transactional
	public int setRtlEqmtSave(RoutingMgtDto routingMgtDto){
		int returnKey = 0;
		try {
			
			for(FacilMgtDto eqmtDto : routingMgtDto.getChildEqmtList()) {
				eqmtDto.setCreatorId(JteUtils.getUserId());
				eqmtDto.setUpdatorId(JteUtils.getUserId());
				
				if(eqmtDto.getAction().equals("C")) {
					routingMgtMapper.insertRtlEquipment(eqmtDto.getEqmtMgtId(), routingMgtDto.getRoutingId());
				}else if(eqmtDto.getAction().equals("D")) {
					routingMgtMapper.deleteRtlEquipment(eqmtDto.getEqmtMgtId(), routingMgtDto.getRoutingId());
				}
			}
		} catch (Exception e) {
			returnKey = 0;
			throw new BusinessException("설비 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구 저장
	@Transactional
	public int setRtlToolSave(RoutingMgtDto routingMgtDto){
		int returnKey = 0;
		try {
			
			for(RoutingRtlToolDto rtlToolDto : routingMgtDto.getChildToolList()) {
				rtlToolDto.setRoutingId(routingMgtDto.getRoutingId());
				
				if(rtlToolDto.getAction().equals("C")) {
					routingMgtMapper.insertRtlToolList(rtlToolDto);
				}else if(rtlToolDto.getAction().equals("U")) {
					routingMgtMapper.updateRtlToolList(rtlToolDto);
				}else if(rtlToolDto.getAction().equals("D")) {
					routingMgtMapper.deleteRtlToolList(rtlToolDto);
				}
			}
		} catch (Exception e) {
			returnKey = 0;
			throw new BusinessException("공구 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
}
