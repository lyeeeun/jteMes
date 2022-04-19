package jin.mes.cform.basMgt.routing.routingMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.cform.basMgt.bom.bomMgt.KwangjinBomMgtDto;
import jin.mes.cform.basMgt.operMgt.facilMgt.KwangjinFacilMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.KwangjinRoutingMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.KwangjinRoutingRtlToolDto;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class KwangjinRoutingMgtService {

	@Resource
	protected KwangjinRoutingMgtMapper kwangjinRoutingMgtMapper;

	@Autowired
	AttachMgtService attachMgtService;
	
	public List<KwangjinRoutingMgtDto> getRoutingInfo(KwangjinRoutingMgtDto kwangjinRoutingMgtDto){
		List<KwangjinRoutingMgtDto> routingInfo = null;
		try {
			routingInfo = kwangjinRoutingMgtMapper.selectRoutingInfo(kwangjinRoutingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: Routing - Select Error: " + e.getMessage());
		}
		return routingInfo;
	}
	
	//라우팅 등록
	@Transactional
	public String setRoutingInfo(KwangjinRoutingMgtDto kwangjinRoutingMgtDto) {
		try {
			kwangjinRoutingMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinRoutingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			kwangjinRoutingMgtMapper.insertRoutingInfo(kwangjinRoutingMgtDto);
			
			//첨부파일 저장
			if(kwangjinRoutingMgtDto.getInsertAttach() != null && kwangjinRoutingMgtDto.getInsertAttach().size() > 0) {
				String target = kwangjinRoutingMgtDto.getCurrentMenuId();
				String targetCode = kwangjinRoutingMgtDto.getRoutingId();
				attachMgtService.attachFilesSave(kwangjinRoutingMgtDto.getInsertAttach(), target, targetCode);
			}
			//첨부파일 삭제
			if(kwangjinRoutingMgtDto.getDeleteAttach() != null && kwangjinRoutingMgtDto.getDeleteAttach().size() > 0) {
				attachMgtService.attachFilesDelete(kwangjinRoutingMgtDto.getDeleteAttach());
			}
			
			setRtlBomSave(kwangjinRoutingMgtDto);
			setRtlEqmtSave(kwangjinRoutingMgtDto);
			setRtlToolSave(kwangjinRoutingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: setRoutingInfo Error: " + e.getMessage());
		}
		return kwangjinRoutingMgtDto.getRoutingId();
	}
	
	//라우팅 수정
	@Transactional
	public String updateRoutingInfo(KwangjinRoutingMgtDto kwangjinRoutingMgtDto) {
		try {
			kwangjinRoutingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			kwangjinRoutingMgtMapper.updateRoutingInfo(kwangjinRoutingMgtDto);
			
			//첨부파일 저장
			if(kwangjinRoutingMgtDto.getInsertAttach() != null && kwangjinRoutingMgtDto.getInsertAttach().size() > 0) {
				String target = kwangjinRoutingMgtDto.getCurrentMenuId();
				String targetCode = kwangjinRoutingMgtDto.getRoutingId();
				attachMgtService.attachFilesSave(kwangjinRoutingMgtDto.getInsertAttach(), target, targetCode);
			}
			//첨부파일 삭제
			if(kwangjinRoutingMgtDto.getDeleteAttach() != null && kwangjinRoutingMgtDto.getDeleteAttach().size() > 0) {
				attachMgtService.attachFilesDelete(kwangjinRoutingMgtDto.getDeleteAttach());
			}
			
			setRtlBomSave(kwangjinRoutingMgtDto);
			setRtlEqmtSave(kwangjinRoutingMgtDto);
			setRtlToolSave(kwangjinRoutingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateRoutingInfo Error: " + e.getMessage());
		}
		return kwangjinRoutingMgtDto.getRoutingId();
	}
	
	//라우팅 삭제
	@Transactional
	public void deleteRoutingInfo(KwangjinRoutingMgtDto kwangjinRoutingMgtDto) {
		try {
			kwangjinRoutingMgtMapper.deleteRoutingInfo(kwangjinRoutingMgtDto);
			
			setRtlBomSave(kwangjinRoutingMgtDto);
			setRtlEqmtSave(kwangjinRoutingMgtDto);
			setRtlToolSave(kwangjinRoutingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: deleteRoutingInfo Error: " + e.getMessage());
		}
	}
	
	//기본 설비 지정
	@Transactional
	public void settingDefaultTool(KwangjinRoutingMgtDto kwangjinRoutingMgtDto) {
		try {
			kwangjinRoutingMgtMapper.updateEqmtAllFalse(kwangjinRoutingMgtDto);
			kwangjinRoutingMgtMapper.updateEqmtTrue(kwangjinRoutingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: settingDefaultTool Error: " + e.getMessage());
		}
	}
	
	//rtl 조회
	public KwangjinRoutingMgtDto getChildRtlList(KwangjinRoutingMgtDto kwangjinRoutingMgtDto){
		try {
			kwangjinRoutingMgtDto.setChildBomList(kwangjinRoutingMgtMapper.selectRtlBomList(kwangjinRoutingMgtDto));
			kwangjinRoutingMgtDto.setChildEqmtList(kwangjinRoutingMgtMapper.selectRtlEqmtList(kwangjinRoutingMgtDto));
			kwangjinRoutingMgtDto.setChildToolList(kwangjinRoutingMgtMapper.selectRtlToolList(kwangjinRoutingMgtDto));
		} catch (Exception e) {
			throw new BusinessException("라우팅 rtl 조회 에러 : " + e.getMessage());
		}
		return kwangjinRoutingMgtDto;
	}
	
	//Bom 저장
	@Transactional
	public int setRtlBomSave(KwangjinRoutingMgtDto kwangjinRoutingMgtDto){
		int returnKey = 0;
		try {
			for(KwangjinBomMgtDto bomMgtDto : kwangjinRoutingMgtDto.getChildBomList()) {
				bomMgtDto.setCreatorId(JteUtils.getUserId());
				bomMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(bomMgtDto.getAction().equals("C")) {
					kwangjinRoutingMgtMapper.insertRtlBomList(bomMgtDto.getBomId(), kwangjinRoutingMgtDto.getRoutingId());
				}else if(bomMgtDto.getAction().equals("D")) {
					kwangjinRoutingMgtMapper.deleteRtlBomList(bomMgtDto.getBomId(), kwangjinRoutingMgtDto.getRoutingId());
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
	public int setRtlEqmtSave(KwangjinRoutingMgtDto kwangjinRoutingMgtDto){
		int returnKey = 0;
		try {
			
			for(KwangjinFacilMgtDto eqmtDto : kwangjinRoutingMgtDto.getChildEqmtList()) {
				eqmtDto.setCreatorId(JteUtils.getUserId());
				eqmtDto.setUpdatorId(JteUtils.getUserId());
				
				if(eqmtDto.getAction().equals("C")) {
					kwangjinRoutingMgtMapper.insertRtlEquipment(eqmtDto.getEqmtMgtId(), kwangjinRoutingMgtDto.getRoutingId());
				}else if(eqmtDto.getAction().equals("D")) {
					kwangjinRoutingMgtMapper.deleteRtlEquipment(eqmtDto.getEqmtMgtId(), kwangjinRoutingMgtDto.getRoutingId());
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
	public int setRtlToolSave(KwangjinRoutingMgtDto kwangjinRoutingMgtDto){
		int returnKey = 0;
		try {
			
			for(KwangjinRoutingRtlToolDto kwangjinRoutingRtlToolDto : kwangjinRoutingMgtDto.getChildToolList()) {
				kwangjinRoutingRtlToolDto.setRoutingId(kwangjinRoutingMgtDto.getRoutingId());
				
				if(kwangjinRoutingRtlToolDto.getAction().equals("C")) {
					kwangjinRoutingMgtMapper.insertRtlToolList(kwangjinRoutingRtlToolDto);
				}else if(kwangjinRoutingRtlToolDto.getAction().equals("U")) {
					kwangjinRoutingMgtMapper.updateRtlToolList(kwangjinRoutingRtlToolDto);
				}else if(kwangjinRoutingRtlToolDto.getAction().equals("D")) {
					kwangjinRoutingMgtMapper.deleteRtlToolList(kwangjinRoutingRtlToolDto);
				}
			}
		} catch (Exception e) {
			returnKey = 0;
			throw new BusinessException("공구 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
}
