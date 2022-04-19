package jin.mes.form.basMgt.routing.routingMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.mapper.basMgt.routing.routingMgt.RoutingMgtMapper;
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

		routingInfo = routingMgtMapper.selectRoutingInfo(routingMgtDto);
		
		return routingInfo;
	}
	
	@Transactional
	public void setRoutingInfo(RoutingMgtDto routingMgtDto) {
		try {
			routingMgtDto.setCreatorId(JteUtils.getUserId());
			routingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			routingMgtMapper.insertRoutingInfo(routingMgtDto);
			
			if(routingMgtDto.getBomList() != null) {
				routingMgtDto.getBomList().forEach(x -> {
					routingMgtMapper.insertRtlBomList(x.getBomId(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getEqmtMgtList() != null) {
				routingMgtDto.getEqmtMgtList().forEach(x -> {
					routingMgtMapper.insertRtlEquipment(x.getEqmtMgtId(), routingMgtDto.getRoutingId());
				});
			}
			
			
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
		} catch (Exception e) {
			throw new BusinessException("Service: setRoutingInfo Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateRoutingInfo(RoutingMgtDto routingMgtDto) {
		try {
			routingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			routingMgtMapper.updateRoutingInfo(routingMgtDto);
			
			if(routingMgtDto.getBomList() != null) {
				routingMgtDto.getBomList().forEach(x -> {
					routingMgtMapper.insertRtlBomList(x.getBomId(), routingMgtDto.getRoutingId());
				});
			}
			if(routingMgtDto.getDelBomList() != null) {
				routingMgtDto.getDelBomList().forEach(x -> {
					routingMgtMapper.deleteRtlBomList(x.getBomId(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getEqmtMgtList() != null) {
				routingMgtDto.getEqmtMgtList().forEach(x -> {
					routingMgtMapper.insertRtlEquipment(x.getEqmtMgtId(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getDelEqmtMgtList() != null) {
				routingMgtDto.getDelEqmtMgtList().forEach(x -> {
					routingMgtMapper.deleteRtlEquipment(x.getEqmtMgtId(), routingMgtDto.getRoutingId());
				});
			}
			
			// Default 설비 저장
			if(routingMgtDto.getDefaultEqmtMgtId() != null) {
				routingMgtMapper.updateDefaultEqmt(routingMgtDto);
			}
//			
//			if(routingMgtDto.getToolList() != null) {
//				routingMgtDto.getToolList().forEach(x -> {
//					routingMgtMapper.insertRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), routingMgtDto.getRoutingId());
//				});
//			}
//			
//			if(routingMgtDto.getUpdateToolList()!= null) {
//				routingMgtDto.getUpdateToolList().forEach(x -> {
//					routingMgtMapper.updateRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), routingMgtDto.getRoutingId());
//				});
//			}
//			
//			if(routingMgtDto.getDelToolList()!= null) {
//				routingMgtDto.getDelToolList().forEach(x -> {
//					routingMgtMapper.deleteRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), routingMgtDto.getRoutingId());
//				});
//			}
			
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
			

		} catch (Exception e) {
			throw new BusinessException("Service: updateRoutingInfo Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void deleteRoutingInfo(RoutingMgtDto routingMgtDto) {
		try {
			routingMgtMapper.deleteRoutingInfo(routingMgtDto);
			
			if(routingMgtDto.getDelBomList() != null) {
				routingMgtDto.getDelBomList().forEach(x -> {
					routingMgtMapper.deleteRtlBomList(x.getBomId(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getDelEqmtMgtList() != null) {
				routingMgtDto.getDelEqmtMgtList().forEach(x -> {
					routingMgtMapper.deleteRtlEquipment(x.getEqmtMgtId(), routingMgtDto.getRoutingId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: deleteRoutingInfo Error: " + e.getMessage());
		}
	}
	
	public void settingDefaultTool(RoutingMgtDto routingMgtDto) {
		try {
			if(routingMgtDto.getToolList() != null) {
				routingMgtDto.getToolList().forEach(x -> {
					routingMgtMapper.insertRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), "default");
				});
			}
			
			if(routingMgtDto.getUpdateToolList()!= null) {
				routingMgtDto.getUpdateToolList().forEach(x -> {
					routingMgtMapper.updateRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), "default");
				});
			}
			
			if(routingMgtDto.getDelToolList()!= null) {
				routingMgtDto.getDelToolList().forEach(x -> {
					routingMgtMapper.deleteRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), "default");
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: settingDefaultTool Error: " + e.getMessage());
		}
	}
	
	public RoutingMgtDto getRtlBomList(RoutingMgtDto routingMgtDto){
		routingMgtDto.setBomList(routingMgtMapper.selectRtlBomList(routingMgtDto));
		
		return routingMgtDto;
	}
	
	public List<FacilMgtDto> getRtlEqmtList(RoutingMgtDto routingMgtDto) {
		List<FacilMgtDto> eqmtInfoList;
		try {
			eqmtInfoList = routingMgtMapper.selectRtlEqmtList(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlEqmtList Error " + e.getMessage());
		}
		
		return eqmtInfoList;
	}
	
	public List<RoutingRtlToolDto> getRtlToolList(RoutingRtlToolDto routingRtlToolDto){
		List<RoutingRtlToolDto> rtlToolInfo = null;
		try {
			rtlToolInfo = routingMgtMapper.selectRtlToolList(routingRtlToolDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlToolList Error " + e.getMessage());
		}
		return rtlToolInfo;
	}
	
}
