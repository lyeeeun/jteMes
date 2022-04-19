package jin.mes.cform.qualMgt.badTotalMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;

@Mapper
public interface NewBadTotalMgtMapper {
	
	public List<NewInfergodsMgtDto> selectBadTotalSelectBoxList(NewInfergodsMgtDto mtrlBadDto);
	
	public List<NewInfergodsMgtDto> selectBadTotalList(NewInfergodsMgtDto mtrlBadDto);
	
	public int selectBadTotalCount(NewInfergodsMgtDto mtrlBadDto);
	
	public List<NewInfergodsMgtDto> selectBadTotalDetailList(NewInfergodsMgtDto mtrlBadDto);
	
	public int selectBadTotalDetailCount(NewInfergodsMgtDto mtrlBadDto);
}
