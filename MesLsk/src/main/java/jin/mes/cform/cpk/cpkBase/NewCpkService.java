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

    public List<NewCpkExcelDto> getCpkList(NewCpkExcelDto newCpkDto){
    	List<NewCpkExcelDto> cpkList = null;

		try {
			cpkList = newCpkMapper.selectCpkList(newCpkDto);
		} catch (Exception e) {
			log.error(e.toString());
		}
		
		return cpkList;
    }
    
    public List<NewCpkExcelDto> getCpkAggregation(NewCpkExcelDto newCpkDto){
    	List<NewCpkExcelDto> cpkList = null;

		try {
			cpkList = newCpkMapper.selectCpkAggregation(newCpkDto);
		} catch (Exception e) {
			log.error(e.toString());
		}
		
		return cpkList;
    }

    public PageInfo<NewCpkVaneMonitorDto> getVaneMonitorList(NewCpkVaneMonitorDto newCpkVaneMonitorDto, PageRequestVo pageRequestVo){
    	List<NewCpkVaneMonitorDto> vaneMonitorList = null;
		int rowCount = 0;

		// Page Setting
		newCpkVaneMonitorDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newCpkVaneMonitorDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newCpkMapper.vaneMonitorCount(newCpkVaneMonitorDto);
			vaneMonitorList = newCpkMapper.selectVaneMonitorList(newCpkVaneMonitorDto);
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
    
    public PageInfo<NewCpkVaneOffsetDto> getVaneOffsetList(NewCpkVaneOffsetDto newCpkVaneOffsetDto, PageRequestVo pageRequestVo){
    	List<NewCpkVaneOffsetDto> vaneOffsetList = null;
		int rowCount = 0;

		// Page Setting
		newCpkVaneOffsetDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newCpkVaneOffsetDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newCpkMapper.vaneOffsetCount(newCpkVaneOffsetDto);
			vaneOffsetList = newCpkMapper.selectVaneOffsetList(newCpkVaneOffsetDto);
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
    
    public PageInfo<NewCpkVaneMonitorDto> getCpkReportList(NewCpkVaneMonitorDto newCpkVaneMonitorDto, PageRequestVo pageRequestVo){
    	List<NewCpkVaneMonitorDto> vaneMonitorList = null;
		int rowCount = 0;

		// Page Setting
		newCpkVaneMonitorDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newCpkVaneMonitorDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newCpkMapper.CpkReportCount(newCpkVaneMonitorDto);
			vaneMonitorList = newCpkMapper.selectCpkReportList(newCpkVaneMonitorDto);
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
