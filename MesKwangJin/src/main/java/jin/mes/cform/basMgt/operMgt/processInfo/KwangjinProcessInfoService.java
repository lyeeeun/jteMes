package jin.mes.cform.basMgt.operMgt.processInfo;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class KwangjinProcessInfoService {

	@Resource
    protected KwangjinProcessInfoMapper kwangjinProcessInfoMapper;
	
    public PageInfo<KwangjinProcessInfoDto> getProcessInfo(KwangjinProcessInfoDto kwangjinProcessInfoDto, PageRequestVo pageRequestVo){
    	List<KwangjinProcessInfoDto> processInfoList = null;
		int rowCount = 0;

		kwangjinProcessInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinProcessInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			processInfoList = kwangjinProcessInfoMapper.selectProcessInfo(kwangjinProcessInfoDto);
			rowCount = kwangjinProcessInfoMapper.rowCount(kwangjinProcessInfoDto);
			if (rowCount > 0) {
				processInfoList = kwangjinProcessInfoMapper.selectProcessInfo(kwangjinProcessInfoDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (processInfoList == null) {
			processInfoList = new ArrayList<KwangjinProcessInfoDto>();
		}
		return new PageInfo<KwangjinProcessInfoDto>(processInfoList, pageRequestVo, rowCount);
	}

	public List<KwangjinProcessInfoDto> getRtlEqmtList(KwangjinProcessInfoDto kwangjinProcessInfoDto) {
		List<KwangjinProcessInfoDto> rtlEqmtList = null;
		int rowCount = 0;
		
		try {
			rowCount = kwangjinProcessInfoMapper.selectRtlEqmtCount(kwangjinProcessInfoDto);
			if (rowCount > 0) {
				rtlEqmtList = kwangjinProcessInfoMapper.selectRtlEqmtList(kwangjinProcessInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlEqmtInfoList Error " + e.getMessage());
		}
		if (rtlEqmtList == null) {
			rtlEqmtList = new ArrayList<KwangjinProcessInfoDto>();
		}
		
		return rtlEqmtList;
	}
	
	@Transactional
	public void setProcessInfo(KwangjinProcessInfoDto kwangjinProcessInfoDto) {
		try {
			
			kwangjinProcessInfoDto.setCreatorId(JteUtils.getUserId());
			kwangjinProcessInfoDto.setUpdatorId(JteUtils.getUserId());
			
			kwangjinProcessInfoMapper.insertProcessInfo(kwangjinProcessInfoDto);
			
			if(kwangjinProcessInfoDto.getRtlEqmtMgtList() != null) {
				kwangjinProcessInfoDto.getRtlEqmtMgtList().forEach(x -> {
					kwangjinProcessInfoMapper.insertRtlEquipment(x.getEqmtMgtId(), kwangjinProcessInfoDto.getProcessId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: setProcessInfo Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateProcessInfo(KwangjinProcessInfoDto kwangjinProcessInfoDto) {
		try {
			kwangjinProcessInfoDto.setUpdatorId(JteUtils.getUserId());
			
			kwangjinProcessInfoMapper.updateProcessInfo(kwangjinProcessInfoDto);
			
			if(kwangjinProcessInfoDto.getRtlEqmtMgtList() != null) {
				kwangjinProcessInfoDto.getRtlEqmtMgtList().forEach(x -> {
					kwangjinProcessInfoMapper.insertRtlEquipment(x.getEqmtMgtId(), kwangjinProcessInfoDto.getProcessId());
				});
			}
			if(kwangjinProcessInfoDto.getDelRtlEqmtMgtList() != null) {
				kwangjinProcessInfoDto.getDelRtlEqmtMgtList().forEach(x -> {
					kwangjinProcessInfoMapper.deleteRtlEquipment(x.getEqmtMgtId(), kwangjinProcessInfoDto.getProcessId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: updateProcessInfo Error " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateIsUse(KwangjinProcessInfoDto kwangjinProcessInfoDto) {
		try {
			kwangjinProcessInfoMapper.updateIsUse(kwangjinProcessInfoDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateIsUse " + e.getMessage());
		}
	}

}