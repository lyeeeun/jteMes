package jin.mes.cform.basMgt.routing.routingMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.cform.basMgt.operMgt.facilMgt.NewFacilMgtDto;
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
	
	public List<NewRoutingMgtDto> getRoutingInfo(NewRoutingMgtDto newRoutingMgtDto){
		List<NewRoutingMgtDto> routingInfo = null;

		routingInfo = newRoutingMgtMapper.selectRoutingInfo(newRoutingMgtDto);
		
		return routingInfo;
	}
	
	@Transactional
	public void setRoutingInfo(NewRoutingMgtDto newRoutingMgtDto) {
		try {
			newRoutingMgtDto.setCreatorId(JteUtils.getUserId());
			newRoutingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			newRoutingMgtMapper.insertRoutingInfo(newRoutingMgtDto);
			
			if(newRoutingMgtDto.getBomList() != null) {
				newRoutingMgtDto.getBomList().forEach(x -> {
					newRoutingMgtMapper.insertRtlBomList(x.getBomId(), newRoutingMgtDto.getRoutingId());
				});
			}
			
			if(newRoutingMgtDto.getEqmtMgtList() != null) {
				newRoutingMgtDto.getEqmtMgtList().forEach(x -> {
					newRoutingMgtMapper.insertRtlEquipment(x.getEqmtMgtId(), newRoutingMgtDto.getRoutingId());
				});
			}
			
			
			//첨부파일 저장
			if(newRoutingMgtDto.getInsertAttach() != null && newRoutingMgtDto.getInsertAttach().size() > 0) {
				String target = newRoutingMgtDto.getCurrentMenuId();
				String targetCode = newRoutingMgtDto.getRoutingId();
				attachMgtService.attachFilesSave(newRoutingMgtDto.getInsertAttach(), target, targetCode);
			}
			//첨부파일 삭제
			if(newRoutingMgtDto.getDeleteAttach() != null && newRoutingMgtDto.getDeleteAttach().size() > 0) {
				attachMgtService.attachFilesDelete(newRoutingMgtDto.getDeleteAttach());
			}
		} catch (Exception e) {
			throw new BusinessException("Service: setRoutingInfo Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateRoutingInfo(NewRoutingMgtDto newRoutingMgtDto) {
		try {
			newRoutingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			newRoutingMgtMapper.updateRoutingInfo(newRoutingMgtDto);
			
			if(newRoutingMgtDto.getBomList() != null) {
				newRoutingMgtDto.getBomList().forEach(x -> {
					newRoutingMgtMapper.insertRtlBomList(x.getBomId(), newRoutingMgtDto.getRoutingId());
				});
			}
			if(newRoutingMgtDto.getDelBomList() != null) {
				newRoutingMgtDto.getDelBomList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlBomList(x.getBomId(), newRoutingMgtDto.getRoutingId());
				});
			}
			
			if(newRoutingMgtDto.getEqmtMgtList() != null) {
				newRoutingMgtDto.getEqmtMgtList().forEach(x -> {
					newRoutingMgtMapper.insertRtlEquipment(x.getEqmtMgtId(), newRoutingMgtDto.getRoutingId());
				});
			}
			
			if(newRoutingMgtDto.getDelEqmtMgtList() != null) {
				newRoutingMgtDto.getDelEqmtMgtList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlEquipment(x.getEqmtMgtId(), newRoutingMgtDto.getRoutingId());
				});
			}
			
			// Default 설비 저장
			if(newRoutingMgtDto.getDefaultEqmtMgtId() != null) {
				newRoutingMgtMapper.updateDefaultEqmt(newRoutingMgtDto);
			}
//			
//			if(newRoutingMgtDto.getToolList() != null) {
//				newRoutingMgtDto.getToolList().forEach(x -> {
//					newRoutingMgtMapper.insertRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), newRoutingMgtDto.getRoutingId());
//				});
//			}
//			
//			if(newRoutingMgtDto.getUpdateToolList()!= null) {
//				newRoutingMgtDto.getUpdateToolList().forEach(x -> {
//					newRoutingMgtMapper.updateRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), newRoutingMgtDto.getRoutingId());
//				});
//			}
//			
//			if(newRoutingMgtDto.getDelToolList()!= null) {
//				newRoutingMgtDto.getDelToolList().forEach(x -> {
//					newRoutingMgtMapper.deleteRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), newRoutingMgtDto.getRoutingId());
//				});
//			}
			
			//첨부파일 저장
			if(newRoutingMgtDto.getInsertAttach() != null && newRoutingMgtDto.getInsertAttach().size() > 0) {
				String target = newRoutingMgtDto.getCurrentMenuId();
				String targetCode = newRoutingMgtDto.getRoutingId();
				attachMgtService.attachFilesSave(newRoutingMgtDto.getInsertAttach(), target, targetCode);
			}
			//첨부파일 삭제
			if(newRoutingMgtDto.getDeleteAttach() != null && newRoutingMgtDto.getDeleteAttach().size() > 0) {
				attachMgtService.attachFilesDelete(newRoutingMgtDto.getDeleteAttach());
			}
			

		} catch (Exception e) {
			throw new BusinessException("Service: updateRoutingInfo Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void deleteRoutingInfo(NewRoutingMgtDto newRoutingMgtDto) {
		try {
			newRoutingMgtMapper.deleteRoutingInfo(newRoutingMgtDto);
			
			if(newRoutingMgtDto.getDelBomList() != null) {
				newRoutingMgtDto.getDelBomList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlBomList(x.getBomId(), newRoutingMgtDto.getRoutingId());
				});
			}
			
			if(newRoutingMgtDto.getDelEqmtMgtList() != null) {
				newRoutingMgtDto.getDelEqmtMgtList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlEquipment(x.getEqmtMgtId(), newRoutingMgtDto.getRoutingId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: deleteRoutingInfo Error: " + e.getMessage());
		}
	}
	
	public void settingDefaultTool(NewRoutingMgtDto newRoutingMgtDto) {
		try {
			if(newRoutingMgtDto.getToolList() != null) {
				newRoutingMgtDto.getToolList().forEach(x -> {
					newRoutingMgtMapper.insertRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), "default");
				});
			}
			
			if(newRoutingMgtDto.getUpdateToolList()!= null) {
				newRoutingMgtDto.getUpdateToolList().forEach(x -> {
					newRoutingMgtMapper.updateRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), "default");
				});
			}
			
			if(newRoutingMgtDto.getDelToolList()!= null) {
				newRoutingMgtDto.getDelToolList().forEach(x -> {
					newRoutingMgtMapper.deleteRtlToolList(x.getToolId(), x.getToolRpm(), x.getToolLocation(), x.getToolCount(), "default");
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: settingDefaultTool Error: " + e.getMessage());
		}
	}
	
	public NewRoutingMgtDto getRtlBomList(NewRoutingMgtDto newRoutingMgtDto){
		newRoutingMgtDto.setBomList(newRoutingMgtMapper.selectRtlBomList(newRoutingMgtDto));
		
		return newRoutingMgtDto;
	}
	
	public List<NewFacilMgtDto> getRtlEqmtList(NewRoutingMgtDto newRoutingMgtDto) {
		List<NewFacilMgtDto> eqmtInfoList;
		try {
			eqmtInfoList = newRoutingMgtMapper.selectRtlEqmtList(newRoutingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlEqmtList Error " + e.getMessage());
		}
		
		return eqmtInfoList;
	}
	
	public List<NewRoutingRtlToolDto> getRtlToolList(NewRoutingRtlToolDto newRoutingRtlToolDto){
		List<NewRoutingRtlToolDto> rtlToolInfo = null;
		try {
			rtlToolInfo = newRoutingMgtMapper.selectRtlToolList(newRoutingRtlToolDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlToolList Error " + e.getMessage());
		}
		return rtlToolInfo;
	}
	
}
