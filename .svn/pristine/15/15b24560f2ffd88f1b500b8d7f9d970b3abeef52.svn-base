package jin.mes.cform.basMgt.routing.routingMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.cform.basMgt.bom.bomMgt.ZinixBomMgtDto;
import jin.mes.cform.basMgt.operMgt.facilMgt.ZinixFacilMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.ZinixRoutingMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.ZinixRoutingRtlToolDto;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ZinixRoutingMgtService {

	@Resource
	protected ZinixRoutingMgtMapper zinixRoutingMgtMapper;

	@Autowired
	AttachMgtService attachMgtService;
	
	public List<ZinixRoutingMgtDto> getRoutingInfo(ZinixRoutingMgtDto routingMgtDto){
		List<ZinixRoutingMgtDto> routingInfo = null;
		try {
			routingInfo = zinixRoutingMgtMapper.selectRoutingInfo(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: Routing - Select Error: " + e.getMessage());
		}
		return routingInfo;
	}
	
	//라우팅 등록
	@Transactional
	public String setRoutingInfo(ZinixRoutingMgtDto routingMgtDto) {
		try {
			routingMgtDto.setCreatorId(JteUtils.getUserId());
			routingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			zinixRoutingMgtMapper.insertRoutingInfo(routingMgtDto);
			
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
	public String updateRoutingInfo(ZinixRoutingMgtDto routingMgtDto) {
		try {
			routingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			zinixRoutingMgtMapper.updateRoutingInfo(routingMgtDto);
			
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
	public void deleteRoutingInfo(ZinixRoutingMgtDto routingMgtDto) {
		try {
			zinixRoutingMgtMapper.deleteRoutingInfo(routingMgtDto);
			
			setRtlBomSave(routingMgtDto);
			setRtlEqmtSave(routingMgtDto);
			setRtlToolSave(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: deleteRoutingInfo Error: " + e.getMessage());
		}
	}
	
	//기본 설비 지정
	@Transactional
	public void settingDefaultTool(ZinixRoutingMgtDto routingMgtDto) {
		try {
			zinixRoutingMgtMapper.updateEqmtAllFalse(routingMgtDto);
			zinixRoutingMgtMapper.updateEqmtTrue(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: settingDefaultTool Error: " + e.getMessage());
		}
	}
	
	//rtl 조회
	public ZinixRoutingMgtDto getChildRtlList(ZinixRoutingMgtDto routingMgtDto){
		try {
			routingMgtDto.setChildBomList(zinixRoutingMgtMapper.selectRtlBomList(routingMgtDto));
			routingMgtDto.setChildEqmtList(zinixRoutingMgtMapper.selectRtlEqmtList(routingMgtDto));
			routingMgtDto.setChildToolList(zinixRoutingMgtMapper.selectRtlToolList(routingMgtDto));
		} catch (Exception e) {
			throw new BusinessException("라우팅 rtl 조회 에러 : " + e.getMessage());
		}
		return routingMgtDto;
	}
	
	//Bom 저장
	@Transactional
	public int setRtlBomSave(ZinixRoutingMgtDto routingMgtDto){
		int returnKey = 0;
		try {
			for(ZinixBomMgtDto bomMgtDto : routingMgtDto.getChildBomList()) {
				bomMgtDto.setCreatorId(JteUtils.getUserId());
				bomMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(bomMgtDto.getAction().equals("C")) {
					zinixRoutingMgtMapper.insertRtlBomList(bomMgtDto.getBomId(), routingMgtDto.getRoutingId());
				}else if(bomMgtDto.getAction().equals("D")) {
					zinixRoutingMgtMapper.deleteRtlBomList(bomMgtDto.getBomId(), routingMgtDto.getRoutingId());
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
	public int setRtlEqmtSave(ZinixRoutingMgtDto routingMgtDto){
		int returnKey = 0;
		try {
			
			for(ZinixFacilMgtDto eqmtDto : routingMgtDto.getChildEqmtList()) {
				eqmtDto.setCreatorId(JteUtils.getUserId());
				eqmtDto.setUpdatorId(JteUtils.getUserId());
				
				if(eqmtDto.getAction().equals("C")) {
					zinixRoutingMgtMapper.insertRtlEquipment(eqmtDto.getEqmtMgtId(), routingMgtDto.getRoutingId());
				}else if(eqmtDto.getAction().equals("D")) {
					zinixRoutingMgtMapper.deleteRtlEquipment(eqmtDto.getEqmtMgtId(), routingMgtDto.getRoutingId());
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
	public int setRtlToolSave(ZinixRoutingMgtDto routingMgtDto){
		int returnKey = 0;
		try {
			
			for(ZinixRoutingRtlToolDto rtlToolDto : routingMgtDto.getChildToolList()) {
				rtlToolDto.setRoutingId(routingMgtDto.getRoutingId());
				
				if(rtlToolDto.getAction().equals("C")) {
					zinixRoutingMgtMapper.insertRtlToolList(rtlToolDto);
				}else if(rtlToolDto.getAction().equals("U")) {
					zinixRoutingMgtMapper.updateRtlToolList(rtlToolDto);
				}else if(rtlToolDto.getAction().equals("D")) {
					zinixRoutingMgtMapper.deleteRtlToolList(rtlToolDto);
				}
			}
		} catch (Exception e) {
			returnKey = 0;
			throw new BusinessException("공구 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
}
