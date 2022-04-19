package jin.mes.form.mtrl.asHisMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mtrl.asHisMgt.AsHisMgtDto;

@Mapper
public interface AsHisMgtMapper {
	
	public List<AsHisMgtDto> selectSerialList(AsHisMgtDto asHisMgtDto);
	
	public int selectSerialCount(AsHisMgtDto asHisMgtDto);
	
	//자재관리
	public List<AsHisMgtDto> selectAsHisMgtList(AsHisMgtDto asHisMgtDto);
	
	public int selectAsHisMgtCount(AsHisMgtDto asHisMgtDto);
	
	public void insertAsHisMgt(AsHisMgtDto asHisMgtDto);
	
	public void updateAsHisMgt(AsHisMgtDto asHisMgtDto);
	
	public int deleteAsHisMgt(AsHisMgtDto asHisMgtDto);
	

	public void insertAsHisSerialMgt(AsHisMgtDto asHisMgtDto);
	
	public void updateAsHisSerialMgt(AsHisMgtDto asHisMgtDto);
}
