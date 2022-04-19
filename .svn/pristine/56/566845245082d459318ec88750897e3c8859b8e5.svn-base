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
public class NewProcessInfoService {

	@Resource
    protected NewProcessInfoMapper newProcessInfoMapper;
	
    public PageInfo<NewProcessInfoDto> getProcessInfo(NewProcessInfoDto processInfoDto, PageRequestVo pageRequestVo){
    	List<NewProcessInfoDto> processInfoList = null;
		int rowCount = 0;

		processInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		processInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			processInfoList = newProcessInfoMapper.selectProcessInfo(processInfoDto);
			rowCount = newProcessInfoMapper.rowCount(processInfoDto);
			if (rowCount > 0) {
				processInfoList = newProcessInfoMapper.selectProcessInfo(processInfoDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (processInfoList == null) {
			processInfoList = new ArrayList<NewProcessInfoDto>();
		}
		return new PageInfo<NewProcessInfoDto>(processInfoList, pageRequestVo, rowCount);
	}

	public List<NewProcessInfoDto> getRtlEqmtList(NewProcessInfoDto processInfoDto) {
		List<NewProcessInfoDto> rtlEqmtList = null;
		int rowCount = 0;
		
		try {
			rowCount = newProcessInfoMapper.selectRtlEqmtCount(processInfoDto);
			if (rowCount > 0) {
				rtlEqmtList = newProcessInfoMapper.selectRtlEqmtList(processInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlEqmtInfoList Error " + e.getMessage());
		}
		if (rtlEqmtList == null) {
			rtlEqmtList = new ArrayList<NewProcessInfoDto>();
		}
		
		return rtlEqmtList;
	}
	
	@Transactional
	public void setProcessInfo(NewProcessInfoDto processInfoDto) {
		try {
			
			processInfoDto.setCreatorId(JteUtils.getUserId());
			processInfoDto.setUpdatorId(JteUtils.getUserId());
			
			newProcessInfoMapper.insertProcessInfo(processInfoDto);
			
			if(processInfoDto.getRtlEqmtMgtList() != null) {
				processInfoDto.getRtlEqmtMgtList().forEach(x -> {
					newProcessInfoMapper.insertRtlEquipment(x.getEqmtMgtId(), processInfoDto.getProcessId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: setProcessInfo Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateProcessInfo(NewProcessInfoDto processInfoDto) {
		try {
			processInfoDto.setUpdatorId(JteUtils.getUserId());
			
			newProcessInfoMapper.updateProcessInfo(processInfoDto);
			
			if(processInfoDto.getRtlEqmtMgtList() != null) {
				processInfoDto.getRtlEqmtMgtList().forEach(x -> {
					newProcessInfoMapper.insertRtlEquipment(x.getEqmtMgtId(), processInfoDto.getProcessId());
				});
			}
			if(processInfoDto.getDelRtlEqmtMgtList() != null) {
				processInfoDto.getDelRtlEqmtMgtList().forEach(x -> {
					newProcessInfoMapper.deleteRtlEquipment(x.getEqmtMgtId(), processInfoDto.getProcessId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: updateProcessInfo Error " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateIsUse(NewProcessInfoDto processInfoDto) {
		try {
			newProcessInfoMapper.updateIsUse(processInfoDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateIsUse " + e.getMessage());
		}
	}

}