package jin.mes.cform.qualMgt.badTotalMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;

@Mapper
public interface NewBadTotalMgtMapper {
	
	public List<NewInfergodsMgtDto> selectBadTotalSelectBoxList(NewInfergodsMgtDto newMtrlBadDto);
	
	public List<NewInfergodsMgtDto> selectBadTotalList(NewInfergodsMgtDto newMtrlBadDto);
	
	public int selectBadTotalCount(NewInfergodsMgtDto newMtrlBadDto);
	
	public List<NewInfergodsMgtDto> selectBadTotalDetailList(NewInfergodsMgtDto newMtrlBadDto);
	
	public int selectBadTotalDetailCount(NewInfergodsMgtDto newMtrlBadDto);
}
