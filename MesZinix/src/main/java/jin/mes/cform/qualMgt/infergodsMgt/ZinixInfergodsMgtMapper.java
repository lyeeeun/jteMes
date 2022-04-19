package jin.mes.cform.qualMgt.infergodsMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.qualMgt.infergodsMgt.ZinixInfergodsMgtDto;

@Mapper
public interface ZinixInfergodsMgtMapper {
	//자재 불량관리
	public List<ZinixInfergodsMgtDto> selectMtrlBadList(ZinixInfergodsMgtDto mtrlBadDto);
	
	public int selectMtrlBadCount(ZinixInfergodsMgtDto mtrlBadDto);
	
	public void insertMtrlBad(ZinixInfergodsMgtDto mtrlBadDto);
	
	public void updateMtrlBad(ZinixInfergodsMgtDto mtrlBadDto);
	
	public int deleteMtrlBad(ZinixInfergodsMgtDto mtrlBadDto);
	
	//품목 불량관리
	public List<ZinixInfergodsMgtDto> selectItemBadList(ZinixInfergodsMgtDto itemBadDto);
		
	public int selectItemBadCount(ZinixInfergodsMgtDto itemBadDto);
	
	public int selectItemBadTotal(ZinixInfergodsMgtDto itemBadDto);
	
	public void insertItemBad(ZinixInfergodsMgtDto itemBadDto);
	
	public void updateItemBad(ZinixInfergodsMgtDto itemBadDto);
	
	
	//품목 불량율 집계
	public List<ZinixInfergodsMgtDto> selectBadRate(ZinixInfergodsMgtDto zinixInfergodsMgtDto);
	public int selectBadRateCount(ZinixInfergodsMgtDto zinixInfergodsMgtDto);
	
	//품목 불량 이력 집계(설비, 작업자)
	public List<ZinixInfergodsMgtDto> selectBadHistory(ZinixInfergodsMgtDto zinixInfergodsMgtDto);
	public int selectBadHistoryCount(ZinixInfergodsMgtDto zinixInfergodsMgtDto);
	
}
