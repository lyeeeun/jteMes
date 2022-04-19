package jin.mes.cform.qualMgt.infergodsMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.infergodsMgt.KwangjinInfergodsMgtDto;

@Mapper
public interface KwangjinInfergodsMgtMapper {
	//자재 불량관리
	public List<KwangjinInfergodsMgtDto> selectMtrlBadList(KwangjinInfergodsMgtDto mtrlBadDto);
	
	public int selectMtrlBadCount(KwangjinInfergodsMgtDto mtrlBadDto);
	
	public void insertMtrlBad(KwangjinInfergodsMgtDto mtrlBadDto);
	
	public void updateMtrlBad(KwangjinInfergodsMgtDto mtrlBadDto);
	
	public int deleteMtrlBad(KwangjinInfergodsMgtDto mtrlBadDto);
	
	//품목 불량관리
	public List<KwangjinInfergodsMgtDto> selectItemBadList(KwangjinInfergodsMgtDto itemBadDto);
		
	public int selectItemBadCount(KwangjinInfergodsMgtDto itemBadDto);
	
	public int selectItemBadTotal(KwangjinInfergodsMgtDto itemBadDto);
	
	public void insertItemBad(KwangjinInfergodsMgtDto itemBadDto);
	
	public void updateItemBad(KwangjinInfergodsMgtDto itemBadDto);
	
	public int deleteItemBad(KwangjinInfergodsMgtDto itemBadDto);
	
	
	//품목 불량율 집계
	public List<KwangjinInfergodsMgtDto> selectBadRate(KwangjinInfergodsMgtDto infergodsMgtDto);
	public int selectBadRateCount(KwangjinInfergodsMgtDto infergodsMgtDto);
	
	//품목 불량 이력 집계(설비, 작업자)
	public List<KwangjinInfergodsMgtDto> selectBadHistory(KwangjinInfergodsMgtDto infergodsMgtDto);
	public int selectBadHistoryCount(KwangjinInfergodsMgtDto infergodsMgtDto);
	
}
