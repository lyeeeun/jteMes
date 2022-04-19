package jin.mes.cform.basMgt.routing.routingMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.facilMgt.NewFacilMgtDto;
import jin.mes.common.attach.AttachMgtService;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewRoutingMgtService {

	@Resource
	protected NewRoutingMgtMapper newRoutingMgtMapper;

	@Autowired
	AttachMgtService attachMgtService;
	
	public List<NewRoutingMgtDto> getRoutingInfo(NewRoutingMgtDto routingMgtDto){
		List<NewRoutingMgtDto> routingInfo = null;

		routingInfo = newRoutingMgtMapper.selectRoutingInfo(routingMgtDto);
		
		return routingInfo;
	}
	
	@Transactional
	public void setRoutingInfo(NewRoutingMgtDto routingMgtDto) {
		try {
			routingMgtDto.setCreatorId(JteUtils.getUserId());
			routingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			newRoutingMgtMapper.insertRoutingInfo(routingMgtDto);
			
			if(routingMgtDto.getBomList() != null) {
				routingMgtDto.getBomList().forEach(x -> {
					newRoutingMgtMapper.insertRtlBomList(x.getBomId(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getEqmtMgtList() != null) {
				routingMgtDto.getEqmtMgtList().forEach(x -> {
					newRoutingMgtMapper.insertRtlEquipment(x.getEqmtMgtId(), routingMgtDto.getRoutingId());
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
	public void updateRoutingInfo(NewRoutingMgtDto routingMgtDto) {
		try {
			routingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			newRoutingMgtMapper.updateRoutingInfo(routingMgtDto);
			
			if(routingMgtDto.getBomList() != null) {
				routingMgtDto.getBomList().forEach(x -> {
					newRoutingMgtMapper.insertRtlBomList(x.getBomId(), routingMgtDto.getRoutingId());
				});
			}
			if(routingMgtDto.getDelBomList() != null) {
				routingMgtDto.getDelBomList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlBomList(x.getBomId(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getEqmtMgtList() != null) {
				routingMgtDto.getEqmtMgtList().forEach(x -> {
					newRoutingMgtMapper.insertRtlEquipment(x.getEqmtMgtId(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getDelEqmtMgtList() != null) {
				routingMgtDto.getDelEqmtMgtList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlEquipment(x.getEqmtMgtId(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getToolList() != null) {
				routingMgtDto.getToolList().forEach(x -> {
					newRoutingMgtMapper.insertRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getUpdateToolList()!= null) {
				routingMgtDto.getUpdateToolList().forEach(x -> {
					newRoutingMgtMapper.updateRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getDelToolList()!= null) {
				routingMgtDto.getDelToolList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), routingMgtDto.getRoutingId());
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
			throw new BusinessException("Service: updateRoutingInfo Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void deleteRoutingInfo(NewRoutingMgtDto routingMgtDto) {
		try {
			newRoutingMgtMapper.deleteRoutingInfo(routingMgtDto);
			
			if(routingMgtDto.getDelBomList() != null) {
				routingMgtDto.getDelBomList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlBomList(x.getBomId(), routingMgtDto.getRoutingId());
				});
			}
			
			if(routingMgtDto.getDelEqmtMgtList() != null) {
				routingMgtDto.getDelEqmtMgtList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlEquipment(x.getEqmtMgtId(), routingMgtDto.getRoutingId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: deleteRoutingInfo Error: " + e.getMessage());
		}
	}
	
	public void settingDefaultTool(NewRoutingMgtDto routingMgtDto) {
		try {
			if(routingMgtDto.getToolList() != null) {
				routingMgtDto.getToolList().forEach(x -> {
					newRoutingMgtMapper.insertRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), "default");
				});
			}
			
			if(routingMgtDto.getUpdateToolList()!= null) {
				routingMgtDto.getUpdateToolList().forEach(x -> {
					newRoutingMgtMapper.updateRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), "default");
				});
			}
			
			if(routingMgtDto.getDelToolList()!= null) {
				routingMgtDto.getDelToolList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), "default");
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: settingDefaultTool Error: " + e.getMessage());
		}
	}
	
	public NewRoutingMgtDto getRtlBomList(NewRoutingMgtDto routingMgtDto){
		routingMgtDto.setBomList(newRoutingMgtMapper.selectRtlBomList(routingMgtDto));
		
		return routingMgtDto;
	}
	
	public List<NewFacilMgtDto> getRtlEqmtList(NewRoutingMgtDto routingMgtDto) {
		List<NewFacilMgtDto> eqmtInfoList;
		try {
			eqmtInfoList = newRoutingMgtMapper.selectRtlEqmtList(routingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlEqmtList Error " + e.getMessage());
		}
		
		return eqmtInfoList;
	}
	
	public List<NewRoutingRtlToolDto> getRtlToolList(NewRoutingRtlToolDto routingRtlToolDto){
		List<NewRoutingRtlToolDto> rtlToolInfo = null;
		try {
			rtlToolInfo = newRoutingMgtMapper.selectRtlToolList(routingRtlToolDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlToolList Error " + e.getMessage());
		}
		return rtlToolInfo;
	}
	
}
