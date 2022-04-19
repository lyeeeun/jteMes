package jin.mes.form.cpk.cpkBase;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.cpk.cpkExcel.CpkExcelDto;
import jin.mes.form.cpk.cpkVaneMonitor.CpkVaneMonitorDto;
import jin.mes.form.cpk.cpkVaneMonitor.CpkVaneOffsetDto;
import jin.mes.mapper.cpk.cpkBase.CpkMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class CpkService {

    @Resource
    protected CpkMapper cpkMapper;

    public List<CpkExcelDto> getCpkList(CpkExcelDto cpkDto){
    	List<CpkExcelDto> cpkList = null;

		try {
			cpkList = cpkMapper.selectCpkList(cpkDto);
		} catch (Exception e) {
			log.error(e.toString());
		}
		
		return cpkList;
    }
    
    public List<CpkExcelDto> getCpkAggregation(CpkExcelDto cpkDto){
    	List<CpkExcelDto> cpkList = null;

		try {
			cpkList = cpkMapper.selectCpkAggregation(cpkDto);
		} catch (Exception e) {
			log.error(e.toString());
		}
		
		return cpkList;
    }

    public PageInfo<CpkVaneMonitorDto> getVaneMonitorList(CpkVaneMonitorDto cpkVaneMonitorDto, PageRequestVo pageRequestVo){
    	List<CpkVaneMonitorDto> vaneMonitorList = null;
		int rowCount = 0;

		// Page Setting
		cpkVaneMonitorDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		cpkVaneMonitorDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = cpkMapper.vaneMonitorCount(cpkVaneMonitorDto);
			vaneMonitorList = cpkMapper.selectVaneMonitorList(cpkVaneMonitorDto);
			if (rowCount > 0) {
				//prodInfoList = itmMgtMapper.selectProdInfoList(itmMgtDto); // not registerd user
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (vaneMonitorList == null) {
			vaneMonitorList = new ArrayList<CpkVaneMonitorDto>();
		}
 		return new PageInfo<CpkVaneMonitorDto>(vaneMonitorList, pageRequestVo, rowCount);
    }
    
    public PageInfo<CpkVaneOffsetDto> getVaneOffsetList(CpkVaneOffsetDto cpkVaneOffsetDto, PageRequestVo pageRequestVo){
    	List<CpkVaneOffsetDto> vaneOffsetList = null;
		int rowCount = 0;

		// Page Setting
		cpkVaneOffsetDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		cpkVaneOffsetDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = cpkMapper.vaneOffsetCount(cpkVaneOffsetDto);
			vaneOffsetList = cpkMapper.selectVaneOffsetList(cpkVaneOffsetDto);
			if (rowCount > 0) {
				//prodInfoList = itmMgtMapper.selectProdInfoList(itmMgtDto); // not registerd user
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (vaneOffsetList == null) {
			vaneOffsetList = new ArrayList<CpkVaneOffsetDto>();
		}
 		return new PageInfo<CpkVaneOffsetDto>(vaneOffsetList, pageRequestVo, rowCount);
    }
    
    public PageInfo<CpkVaneMonitorDto> getCpkReportList(CpkVaneMonitorDto cpkVaneMonitorDto, PageRequestVo pageRequestVo){
    	List<CpkVaneMonitorDto> vaneMonitorList = null;
		int rowCount = 0;

		// Page Setting
		cpkVaneMonitorDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		cpkVaneMonitorDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = cpkMapper.CpkReportCount(cpkVaneMonitorDto);
			vaneMonitorList = cpkMapper.selectCpkReportList(cpkVaneMonitorDto);
			if (rowCount > 0) {
				//prodInfoList = itmMgtMapper.selectProdInfoList(itmMgtDto); // not registerd user
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (vaneMonitorList == null) {
			vaneMonitorList = new ArrayList<CpkVaneMonitorDto>();
		}
 		return new PageInfo<CpkVaneMonitorDto>(vaneMonitorList, pageRequestVo, rowCount);
    }
}
