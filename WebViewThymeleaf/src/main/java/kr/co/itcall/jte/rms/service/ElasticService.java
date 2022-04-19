package kr.co.itcall.jte.rms.service;

import java.util.List;
import java.util.Map;

import kr.co.itcall.jte.rms.model.ElasticVO;

public interface ElasticService{
	public String GetData_graph(ElasticVO elasticVO);
	
	public String GetData_Header(ElasticVO elasticVO);
	
	public String GetData_OverView(ElasticVO elasticVO);
	
	public String GetData_OverView_MonthlyGraph(ElasticVO elasticVO);
	
	public String GetData_EngineStatus(ElasticVO elasticVO);
	
	public String GetData_EngineStatus_Alarm(ElasticVO ElasticVO);
	
	public String GetData_ElecStatus(ElasticVO ElasticVO);
	
	public String GetData_ElecStatus_Common(ElasticVO elasticVO);
	
	public String GetData_Aux_Common(ElasticVO elasticVO);
	
	public String GetData_AlarmList(ElasticVO elasticVO);
	
	public String GetData_EventRanking(ElasticVO elasticVO);
	
	public String GetData_ActionList(ElasticVO elasticVO);
	
	public String GetData_EngineTrend(ElasticVO elasticVO);
	
	public String GetData_EngineTrend_periodically(ElasticVO elasticVO);
	
	public String GetData_loss(ElasticVO elasticVO);
	
	public Map<String,Map> GetData_RunningHour(ElasticVO elasticVO);
	
	public List<Map> GetData_DataDownload (ElasticVO elasticVO);
}
