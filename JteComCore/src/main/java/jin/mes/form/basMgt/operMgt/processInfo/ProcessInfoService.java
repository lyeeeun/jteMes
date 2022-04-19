package jin.mes.form.basMgt.operMgt.processInfo;

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
public class ProcessInfoService {

	@Resource
    protected ProcessInfoMapper processInfoMapper;
	
    public PageInfo<ProcessInfoDto> getProcessInfo(ProcessInfoDto processInfoDto, PageRequestVo pageRequestVo){
    	List<ProcessInfoDto> processInfoList = null;
		int rowCount = 0;

		processInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		processInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			processInfoList = processInfoMapper.selectProcessInfo(processInfoDto);
			rowCount = processInfoMapper.rowCount(processInfoDto);
			if (rowCount > 0) {
				processInfoList = processInfoMapper.selectProcessInfo(processInfoDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (processInfoList == null) {
			processInfoList = new ArrayList<ProcessInfoDto>();
		}
		return new PageInfo<ProcessInfoDto>(processInfoList, pageRequestVo, rowCount);
	}

	public List<ProcessInfoDto> getRtlEqmtList(ProcessInfoDto processInfoDto) {
		List<ProcessInfoDto> rtlEqmtList = null;
		int rowCount = 0;
		
		try {
			rowCount = processInfoMapper.selectRtlEqmtCount(processInfoDto);
			if (rowCount > 0) {
				rtlEqmtList = processInfoMapper.selectRtlEqmtList(processInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlEqmtInfoList Error " + e.getMessage());
		}
		if (rtlEqmtList == null) {
			rtlEqmtList = new ArrayList<ProcessInfoDto>();
		}
		
		return rtlEqmtList;
	}
	
	@Transactional
	public void setProcessInfo(ProcessInfoDto processInfoDto) {
		try {
			
			processInfoDto.setCreatorId(JteUtils.getUserId());
			processInfoDto.setUpdatorId(JteUtils.getUserId());
			
			processInfoMapper.insertProcessInfo(processInfoDto);
			
			if(processInfoDto.getRtlEqmtMgtList() != null) {
				processInfoDto.getRtlEqmtMgtList().forEach(x -> {
					processInfoMapper.insertRtlEquipment(x.getEqmtMgtId(), processInfoDto.getProcessId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: setProcessInfo Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateProcessInfo(ProcessInfoDto processInfoDto) {
		try {
			processInfoDto.setUpdatorId(JteUtils.getUserId());
			
			processInfoMapper.updateProcessInfo(processInfoDto);
			
			if(processInfoDto.getRtlEqmtMgtList() != null) {
				processInfoDto.getRtlEqmtMgtList().forEach(x -> {
					processInfoMapper.insertRtlEquipment(x.getEqmtMgtId(), processInfoDto.getProcessId());
				});
			}
			if(processInfoDto.getDelRtlEqmtMgtList() != null) {
				processInfoDto.getDelRtlEqmtMgtList().forEach(x -> {
					processInfoMapper.deleteRtlEquipment(x.getEqmtMgtId(), processInfoDto.getProcessId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: updateProcessInfo Error " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateIsUse(ProcessInfoDto processInfoDto) {
		try {
			processInfoMapper.updateIsUse(processInfoDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateIsUse " + e.getMessage());
		}
	}

}