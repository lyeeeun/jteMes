package kr.co.itcall.jte.rms.cotroller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itcall.jte.rms.model.ElasticVO;
import kr.co.itcall.jte.rms.model.MasterVO;

@Controller
public class ElasticSearchController {	
	
	@Resource
	private MessageSourceAccessor messageSourceAccessor;
	
	// overview
	@RequestMapping("/overview")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView ElasticOverview(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result.msg", messageSourceAccessor.getMessage("title1.OverView.lbl"));
		mv.addObject("getDic", map);
		mv.setViewName("contents/rms/OverView/overview");
		return mv;
	}

	// EngineStatus - Realvalue
	@RequestMapping("/engine_value")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView EngineRealValue(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/EngineStatus/engine_value");

		return mv;
	}

	// EngineStatus - Process Flow Diagram
	@RequestMapping("/engine_diagram")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView EngineDiagram(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/EngineStatus/engine_diagram");
		return mv;
	}

	// AuxEquipmentStatus - RealValue

	@RequestMapping("/aux_value")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView AuxRealValue(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/AuxEquipmentStatus/aux_value");
		return mv;
	}

	// AuxEquipmentStatus - Process Flow Diagram
	@RequestMapping("/aux_diagram")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView AuxDiagram(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/AuxEquipmentStatus/aux_diagram");
		return mv;
	}

	// ElectricalStatus - Overall
	@RequestMapping("/overall")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView ElecOverall(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/ElectricalStatus/overall");

		return mv;
	}

	// ElectricalStatus - MediumVoltage
	@RequestMapping("/medium_voltage")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView ElecMV(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/ElectricalStatus/medium_voltage");

		return mv;
	}
	
	// ElectricalStatus - MediumVoltage2
	@RequestMapping("/medium_voltage2")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView ElecMV2(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/ElectricalStatus/medium_voltage2");

		return mv;
	}

	// ElectricalStatus - LowVoltage
	@RequestMapping("/low_voltage")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView ElecLV(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/ElectricalStatus/low_voltage");

		return mv;
	}

	// EngineAlarm - AlarmList
	@RequestMapping("/alarm_list")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView AlarmList(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/EngineAlarm/alarm_list");
		return mv;
	}

	// EngineAlarm - EventRanking
	@RequestMapping("/event_ranking")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView AlarmRanking(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/EngineAlarm/event_ranking");
		return mv;
	}

	// EngineAlarm - ActionList
	@RequestMapping("/action_list")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView AlarmAction(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/EngineAlarm/action_list");
		return mv;
	}

	// TrendViewr - EngineTrend
	@RequestMapping("/engine_trend")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView TrendEngine(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/TrendView/engine_trend");
		return mv;
	}

	// TrendViewr - AuxEquipment
	@RequestMapping("/aux_equipment")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView TrendAux(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/TrendView/aux_equipment");
		return mv;
	}

	// TrendViewr - ElectricalSystem
	@RequestMapping("/electrical_system")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView TrendElec(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/TrendView/electrical_system");
		return mv;
	}

	// TrendViewr - Custimize
	@RequestMapping("/custimize")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView TrendCustom(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/TrendView/custimize");
		return mv;
	}
	// tab - menu
		@RequestMapping("/tab")
		@PreAuthorize("isAuthenticated()")
		public ModelAndView tab(ModelAndView mv) {
			mv.setViewName("layouts/tab_Layout");
			return mv;
		}
		
	// TrendViewr - EngineTrendPeriod(HGS 장현성 차장님 사용)
	@RequestMapping("/engine_trend_periodically")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView TrendEnginePeriodically(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/TrendView/engine_trend_periodically");
		return mv;
	}
	
	// ReportData - ReportData
	@RequestMapping("/reportData")
	@PreAuthorize("isAuthenticated()")
	public ModelAndView dataDownload(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/ReportData/dataDownload");
		return mv;
	}
	
	// reportData - dataDownload
	@RequestMapping("/graph")
	@ResponseBody
	public ModelAndView GetData_graph(ModelAndView mv, @ModelAttribute("masterVO") MasterVO masterVO) {
		mv.addObject("Menu", masterVO.getName());
		mv.addObject("Title", masterVO.getTitle());
		mv.setViewName("contents/rms/graph/graph");
		return mv;
	}
}
