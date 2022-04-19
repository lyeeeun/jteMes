package jin.mes.cform.cpk.cpkBase;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.cpk.cpkExcel.NewCpkExcelDto;
import jin.mes.cform.cpk.cpkVaneMonitor.NewCpkVaneMonitorDto;
import jin.mes.cform.cpk.cpkVaneMonitor.NewCpkVaneOffsetDto;

@Mapper
public interface NewCpkMapper {
	public List<NewCpkExcelDto> selectCpkList(NewCpkExcelDto cpkDto);
    public List<NewCpkVaneMonitorDto> selectVaneMonitorList(NewCpkVaneMonitorDto cpkVaneMonitorDto);
    public int vaneMonitorCount(NewCpkVaneMonitorDto cpkVaneMonitorDto);
    public List<NewCpkVaneOffsetDto> selectVaneOffsetList(NewCpkVaneOffsetDto cpkVaneOffsetDto);
    public int vaneOffsetCount(NewCpkVaneOffsetDto cpkVaneOffsetDto);
    public List<NewCpkVaneMonitorDto> selectCpkReportList(NewCpkVaneMonitorDto cpkVaneMonitorDto);
    public int CpkReportCount(NewCpkVaneMonitorDto cpkVaneMonitorDto);
    public List<NewCpkExcelDto> selectCpkAggregation(NewCpkExcelDto cpkDto);
}