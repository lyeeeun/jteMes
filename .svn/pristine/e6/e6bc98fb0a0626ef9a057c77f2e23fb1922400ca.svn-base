package jin.mes.form.cpk.cpkBase;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.cpk.cpkExcel.CpkExcelDto;
import jin.mes.form.cpk.cpkVaneMonitor.CpkVaneMonitorDto;
import jin.mes.form.cpk.cpkVaneMonitor.CpkVaneOffsetDto;

@Mapper
public interface CpkMapper {
	public List<CpkExcelDto> selectCpkList(CpkExcelDto cpkDto);
    public List<CpkVaneMonitorDto> selectVaneMonitorList(CpkVaneMonitorDto cpkVaneMonitorDto);
    public int vaneMonitorCount(CpkVaneMonitorDto cpkVaneMonitorDto);
    public List<CpkVaneOffsetDto> selectVaneOffsetList(CpkVaneOffsetDto cpkVaneOffsetDto);
    public int vaneOffsetCount(CpkVaneOffsetDto cpkVaneOffsetDto);
    public List<CpkVaneMonitorDto> selectCpkReportList(CpkVaneMonitorDto cpkVaneMonitorDto);
    public int CpkReportCount(CpkVaneMonitorDto cpkVaneMonitorDto);
    public List<CpkExcelDto> selectCpkAggregation(CpkExcelDto cpkDto);
}