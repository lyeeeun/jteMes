package jin.mes.cform.cpk.cpkBase;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.cpk.cpkExcel.NewCpkExcelDto;
import jin.mes.cform.cpk.cpkVaneMonitor.NewCpkVaneMonitorDto;
import jin.mes.cform.cpk.cpkVaneMonitor.NewCpkVaneOffsetDto;

@Mapper
public interface NewCpkMapper {
	public List<NewCpkExcelDto> selectCpkList(NewCpkExcelDto newCpkDto);
    public List<NewCpkVaneMonitorDto> selectVaneMonitorList(NewCpkVaneMonitorDto newCpkVaneMonitorDto);
    public int vaneMonitorCount(NewCpkVaneMonitorDto newCpkVaneMonitorDto);
    public List<NewCpkVaneOffsetDto> selectVaneOffsetList(NewCpkVaneOffsetDto newCpkVaneMonitorDto);
    public int vaneOffsetCount(NewCpkVaneOffsetDto newCpkVaneMonitorDto);
    public List<NewCpkVaneMonitorDto> selectCpkReportList(NewCpkVaneMonitorDto newCpkVaneMonitorDto);
    public int CpkReportCount(NewCpkVaneMonitorDto newCpkVaneMonitorDto);
    public List<NewCpkExcelDto> selectCpkAggregation(NewCpkExcelDto newCpkDto);
}