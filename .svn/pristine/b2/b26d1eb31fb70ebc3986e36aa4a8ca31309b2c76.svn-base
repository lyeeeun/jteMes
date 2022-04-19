package jin.mes.cform.qualMgt.infergodsMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewInfergodsMgtMapper {
	//자재 불량관리
	public List<NewInfergodsMgtDto> selectMtrlBadList(NewInfergodsMgtDto mtrlBadDto);
	
	public int selectMtrlBadCount(NewInfergodsMgtDto mtrlBadDto);
	
	public void insertMtrlBad(NewInfergodsMgtDto mtrlBadDto);
	
	public void updateMtrlBad(NewInfergodsMgtDto mtrlBadDto);
	
	public int deleteMtrlBad(NewInfergodsMgtDto mtrlBadDto);
	
	//품목 불량관리
	public List<NewInfergodsMgtDto> selectItemBadList(NewInfergodsMgtDto itemBadDto);
		
	public int selectItemBadCount(NewInfergodsMgtDto itemBadDto);
	
	public int selectItemBadTotal(NewInfergodsMgtDto itemBadDto);
	
	public void insertItemBad(NewInfergodsMgtDto itemBadDto);
	
	public void updateItemBad(NewInfergodsMgtDto itemBadDto);
	
	
	//품목 불량율 집계
	public List<NewInfergodsMgtDto> selectBadRate(NewInfergodsMgtDto infergodsMgtDto);
	public int selectBadRateCount(NewInfergodsMgtDto infergodsMgtDto);
	
	//품목 불량 이력 집계(설비, 작업자)
	public List<NewInfergodsMgtDto> selectBadHistory(NewInfergodsMgtDto infergodsMgtDto);
	public int selectBadHistoryCount(NewInfergodsMgtDto infergodsMgtDto);
	
}
