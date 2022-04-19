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
	
    public PageInfo<NewProcessInfoDto> getProcessInfo(NewProcessInfoDto newProcessInfoDto, PageRequestVo pageRequestVo){
    	List<NewProcessInfoDto> processInfoList = null;
		int rowCount = 0;

		newProcessInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newProcessInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			processInfoList = newProcessInfoMapper.selectProcessInfo(newProcessInfoDto);
			rowCount = newProcessInfoMapper.rowCount(newProcessInfoDto);
			if (rowCount > 0) {
				processInfoList = newProcessInfoMapper.selectProcessInfo(newProcessInfoDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (processInfoList == null) {
			processInfoList = new ArrayList<NewProcessInfoDto>();
		}
		return new PageInfo<NewProcessInfoDto>(processInfoList, pageRequestVo, rowCount);
	}

	public List<NewProcessInfoDto> getRtlEqmtList(NewProcessInfoDto newProcessInfoDto) {
		List<NewProcessInfoDto> rtlEqmtList = null;
		int rowCount = 0;
		
		try {
			rowCount = newProcessInfoMapper.selectRtlEqmtCount(newProcessInfoDto);
			if (rowCount > 0) {
				rtlEqmtList = newProcessInfoMapper.selectRtlEqmtList(newProcessInfoDto);
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
	public void setProcessInfo(NewProcessInfoDto newProcessInfoDto) {
		try {
			
			newProcessInfoDto.setCreatorId(JteUtils.getUserId());
			newProcessInfoDto.setUpdatorId(JteUtils.getUserId());
			
			newProcessInfoMapper.insertProcessInfo(newProcessInfoDto);
			
			if(newProcessInfoDto.getRtlEqmtMgtList() != null) {
				newProcessInfoDto.getRtlEqmtMgtList().forEach(x -> {
					newProcessInfoMapper.insertRtlEquipment(x.getEqmtMgtId(), newProcessInfoDto.getProcessId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: setProcessInfo Error: " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateProcessInfo(NewProcessInfoDto newProcessInfoDto) {
		try {
			newProcessInfoDto.setUpdatorId(JteUtils.getUserId());
			
			newProcessInfoMapper.updateProcessInfo(newProcessInfoDto);
			
			if(newProcessInfoDto.getRtlEqmtMgtList() != null) {
				newProcessInfoDto.getRtlEqmtMgtList().forEach(x -> {
					newProcessInfoMapper.insertRtlEquipment(x.getEqmtMgtId(), newProcessInfoDto.getProcessId());
				});
			}
			if(newProcessInfoDto.getDelRtlEqmtMgtList() != null) {
				newProcessInfoDto.getDelRtlEqmtMgtList().forEach(x -> {
					newProcessInfoMapper.deleteRtlEquipment(x.getEqmtMgtId(), newProcessInfoDto.getProcessId());
				});
			}
			
		} catch (Exception e) {
			throw new BusinessException("Service: updateProcessInfo Error " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateIsUse(NewProcessInfoDto newProcessInfoDto) {
		try {
			newProcessInfoMapper.updateIsUse(newProcessInfoDto);
		} catch (Exception e) {
			throw new BusinessException("Service: updateIsUse " + e.getMessage());
		}
	}

}