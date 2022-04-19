package jin.mes.cform.cpk.cpkBase;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.cpk.cpkExcel.NewCpkExcelDto;
import jin.mes.cform.cpk.cpkVaneMonitor.NewCpkVaneMonitorDto;
import jin.mes.cform.cpk.cpkVaneMonitor.NewCpkVaneOffsetDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewCpkService {

    @Resource
    protected NewCpkMapper newCpkMapper;

    public List<NewCpkExcelDto> getCpkList(NewCpkExcelDto cpkDto){
    	List<NewCpkExcelDto> cpkList = null;

		try {
			cpkList = newCpkMapper.selectCpkList(cpkDto);
		} catch (Exception e) {
			log.error(e.toString());
		}
		
		return cpkList;
    }
    
    public List<NewCpkExcelDto> getCpkAggregation(NewCpkExcelDto cpkDto){
    	List<NewCpkExcelDto> cpkList = null;

		try {
			cpkList = newCpkMapper.selectCpkAggregation(cpkDto);
		} catch (Exception e) {
			log.error(e.toString());
		}
		
		return cpkList;
    }

    public PageInfo<NewCpkVaneMonitorDto> getVaneMonitorList(NewCpkVaneMonitorDto cpkVaneMonitorDto, PageRequestVo pageRequestVo){
    	List<NewCpkVaneMonitorDto> vaneMonitorList = null;
		int rowCount = 0;

		// Page Setting
		cpkVaneMonitorDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		cpkVaneMonitorDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newCpkMapper.vaneMonitorCount(cpkVaneMonitorDto);
			vaneMonitorList = newCpkMapper.selectVaneMonitorList(cpkVaneMonitorDto);
			if (rowCount > 0) {
				//prodInfoList = itmMgtMapper.selectProdInfoList(itmMgtDto); // not registerd user
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (vaneMonitorList == null) {
			vaneMonitorList = new ArrayList<NewCpkVaneMonitorDto>();
		}
 		return new PageInfo<NewCpkVaneMonitorDto>(vaneMonitorList, pageRequestVo, rowCount);
    }
    
    public PageInfo<NewCpkVaneOffsetDto> getVaneOffsetList(NewCpkVaneOffsetDto cpkVaneOffsetDto, PageRequestVo pageRequestVo){
    	List<NewCpkVaneOffsetDto> vaneOffsetList = null;
		int rowCount = 0;

		// Page Setting
		cpkVaneOffsetDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		cpkVaneOffsetDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newCpkMapper.vaneOffsetCount(cpkVaneOffsetDto);
			vaneOffsetList = newCpkMapper.selectVaneOffsetList(cpkVaneOffsetDto);
			if (rowCount > 0) {
				//prodInfoList = itmMgtMapper.selectProdInfoList(itmMgtDto); // not registerd user
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (vaneOffsetList == null) {
			vaneOffsetList = new ArrayList<NewCpkVaneOffsetDto>();
		}
 		return new PageInfo<NewCpkVaneOffsetDto>(vaneOffsetList, pageRequestVo, rowCount);
    }
    
    public PageInfo<NewCpkVaneMonitorDto> getCpkReportList(NewCpkVaneMonitorDto cpkVaneMonitorDto, PageRequestVo pageRequestVo){
    	List<NewCpkVaneMonitorDto> vaneMonitorList = null;
		int rowCount = 0;

		// Page Setting
		cpkVaneMonitorDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		cpkVaneMonitorDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newCpkMapper.CpkReportCount(cpkVaneMonitorDto);
			vaneMonitorList = newCpkMapper.selectCpkReportList(cpkVaneMonitorDto);
			if (rowCount > 0) {
				//prodInfoList = itmMgtMapper.selectProdInfoList(itmMgtDto); // not registerd user
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (vaneMonitorList == null) {
			vaneMonitorList = new ArrayList<NewCpkVaneMonitorDto>();
		}
 		return new PageInfo<NewCpkVaneMonitorDto>(vaneMonitorList, pageRequestVo, rowCount);
    }
}
