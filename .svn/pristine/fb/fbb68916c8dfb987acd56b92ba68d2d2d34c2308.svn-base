package kr.co.itcall.jte.rms.cotroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.rms.model.ElasticVO;
import kr.co.itcall.jte.rms.model.PageVO;
import kr.co.itcall.jte.rms.service.ElasticService;

@Controller
public class ElasticWebController {

	@Autowired
	private ElasticService elasticService;

	// header
	@RequestMapping("/web-header")
	@ResponseBody
	public String GetData_Header(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_Header(elasticVO);
	}
	// overview
	@RequestMapping("/web-overview")
	@ResponseBody
	public String GetData_OverView(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_OverView(elasticVO);
	}
	// overview-monthlygraph
	@RequestMapping("/web-overview-monthlygraph")
	@ResponseBody
	public String GetData_OverView_MonthlyGraph(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_OverView_MonthlyGraph(elasticVO);
	}
		
	// EngineStatus - RealValue/ProcessFlowDiagram
	@RequestMapping("/web-engineStatus")
	@ResponseBody
	public String GetData_EngineValue(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_EngineStatus(elasticVO);
	}
	
	// EngineStatus - RealValue/ProcessFlowDiagram(Alarm)
		@RequestMapping("/web-engineStatusAlarm")
		@ResponseBody
		public String GetData_EngineStatus_Alarm(@RequestBody ElasticVO elasticVO) {
			return elasticService.GetData_EngineStatus_Alarm(elasticVO);
	}
	
	
	// ElectricalStatus,AuxEquipment 공통사용
	@RequestMapping("/web-elecStauts")
	@ResponseBody
	public String GetData_Overall(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_ElecStatus(elasticVO);
	}
	// ElectricalStatus(Common)
	@RequestMapping("/web-elecStauts-common")
	@ResponseBody
	public String GetData_Overall_Common(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_ElecStatus_Common(elasticVO);
	}
	
	// AuxEquipment, ElectricalStatus(Common) - 공통사용
	@RequestMapping("/web-auxEquip-common")
	@ResponseBody
	public String GetData_Aux_Common(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_Aux_Common(elasticVO);
	}
		
	// EngineAlarm - AlarmList
	@RequestMapping("/web-alarmList")
	@ResponseBody
	public String GetData_AlarmList(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_AlarmList(elasticVO);
	}

	// EngineAlarm - EvnentRanking
	@RequestMapping("/web-eventRanking")
	@ResponseBody
	public String GetData_EventRanking(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_EventRanking(elasticVO);
	}

	// EngineAlarm - ActionList
	@RequestMapping("/web-actionList")
	@ResponseBody
	public String GetData_ActionList(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_ActionList(elasticVO);
	}

	// TrendView - Engine
	@RequestMapping("/web-engineTrend")
	@ResponseBody
	public String GetData_EngineTrend(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_EngineTrend(elasticVO);
	}
	
	// TrendView - EngineTrendPeriodically(HGS 장현성 차장님 사용)
		@RequestMapping("/web-engineTrendPeriodically")
		@ResponseBody
		public String GetData_EngineTrend_periodically(@RequestBody ElasticVO elasticVO) {
			return elasticService.GetData_EngineTrend_periodically(elasticVO);
		}
	
	// overview-monthlygraph
	@RequestMapping("/web-lossdata")
	@ResponseBody
	public String GetData_loss(@RequestBody ElasticVO elasticVO) {
		return elasticService.GetData_loss(elasticVO);
	}
	
	// reportData - dataDownload
	@RequestMapping("/web-reportDownload")
	@ResponseBody
	public ResponseEntity<Object> GetData_dataDownload(@RequestBody ElasticVO elasticVO) {
		return new ResponseEntity<Object>(elasticService.GetData_DataDownload(elasticVO), HttpStatus.OK);
	}
	
	
	// reportData - dataDownload
		@RequestMapping("/web-graph")
		@ResponseBody
		public ResponseEntity<Object> GetData_graph(@RequestBody ElasticVO elasticVO) {
			return new ResponseEntity<Object>(elasticService.GetData_graph(elasticVO), HttpStatus.OK);
		}
}
