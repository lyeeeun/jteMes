package jin.mes.cform.qualMgt.infergodsMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;

@Mapper
public interface NewInfergodsMgtMapper {
	//자재 불량관리
	public List<NewInfergodsMgtDto> selectMtrlBadList(NewInfergodsMgtDto newMtrlBadDto);
	
	public int selectMtrlBadCount(NewInfergodsMgtDto newMtrlBadDto);
	
	public void insertMtrlBad(NewInfergodsMgtDto newMtrlBadDto);
	
	public void updateMtrlBad(NewInfergodsMgtDto newMtrlBadDto);
	
	public int deleteMtrlBad(NewInfergodsMgtDto newMtrlBadDto);
	
	//품목 불량관리
	public List<NewInfergodsMgtDto> selectItemBadList(NewInfergodsMgtDto newItemBadDto);
		
	public int selectItemBadCount(NewInfergodsMgtDto newItemBadDto);
	
	public int selectItemBadTotal(NewInfergodsMgtDto newItemBadDto);
	
	public void insertItemBad(NewInfergodsMgtDto newItemBadDto);
	
	public void updateItemBad(NewInfergodsMgtDto newItemBadDto);
	
	
	//품목 불량율 집계
	public List<NewInfergodsMgtDto> selectBadRate(NewInfergodsMgtDto infergodsMgtDto);
	public int selectBadRateCount(NewInfergodsMgtDto infergodsMgtDto);
	
	//품목 불량 이력 집계(설비, 작업자)
	public List<NewInfergodsMgtDto> selectBadHistory(NewInfergodsMgtDto infergodsMgtDto);
	public int selectBadHistoryCount(NewInfergodsMgtDto infergodsMgtDto);
	
}
