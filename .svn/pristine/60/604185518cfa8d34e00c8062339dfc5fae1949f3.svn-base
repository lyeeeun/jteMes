package jin.mes.mapper.qualMgt.infergodsMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;

@Mapper
public interface InfergodsMgtMapper {
	//자재 불량관리
	public List<InfergodsMgtDto> selectMtrlBadList(InfergodsMgtDto mtrlBadDto);
	
	public int selectMtrlBadCount(InfergodsMgtDto mtrlBadDto);
	
	public void insertMtrlBad(InfergodsMgtDto mtrlBadDto);
	
	public void updateMtrlBad(InfergodsMgtDto mtrlBadDto);
	
	public int deleteMtrlBad(InfergodsMgtDto mtrlBadDto);
	
	//품목 불량관리
	public List<InfergodsMgtDto> selectItemBadList(InfergodsMgtDto itemBadDto);
		
	public int selectItemBadCount(InfergodsMgtDto itemBadDto);
	
	public int selectItemBadTotal(InfergodsMgtDto itemBadDto);
	
	public void insertItemBad(InfergodsMgtDto itemBadDto);
	
	public void updateItemBad(InfergodsMgtDto itemBadDto);
	
	
	//품목 불량율 집계
	public List<InfergodsMgtDto> selectBadRate(InfergodsMgtDto infergodsMgtDto);
	public int selectBadRateCount(InfergodsMgtDto infergodsMgtDto);
	
	//품목 불량 이력 집계(설비, 작업자)
	public List<InfergodsMgtDto> selectBadHistory(InfergodsMgtDto infergodsMgtDto);
	public int selectBadHistoryCount(InfergodsMgtDto infergodsMgtDto);
	
}
