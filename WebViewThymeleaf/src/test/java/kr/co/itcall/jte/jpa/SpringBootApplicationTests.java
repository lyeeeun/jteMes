package kr.co.itcall.jte.jpa;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.joda.time.LocalDate;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.itcall.jte.common.code.ComnCodeService;
import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.common.code.repository.ComnCodeRepository;
import kr.co.itcall.jte.pms.model.PmsPartDtlModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderHistModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderModel;
import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;
import kr.co.itcall.jte.pms.repository.PmsPartDtlRepository;
import kr.co.itcall.jte.pms.repository.PmsTechOrderHistRepository;
import kr.co.itcall.jte.pms.repository.PmsTechOrderRepository;
import kr.co.itcall.jte.spring.user.model.RoleInfoVo;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.spring.user.repository.RoleRepository;
import kr.co.itcall.jte.spring.user.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;

 @Slf4j
// @RunWith(SpringJUnit4ClassRunner.class)
// @SpringApplicationConfiguration(classes = BootApp.class)
// @ContextConfiguration(classes = BootApp.class)
// @WebAppConfiguration
@SpringBootTest
@RunWith(SpringRunner.class)
//@Import(TestConfig.class)
//@SpringBootConfiguration
@SpringBootApplication(scanBasePackages = {"kr.co.itcall.jte"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@ActiveProfiles("local")
public class SpringBootApplicationTests {

	@Autowired
	private ComnCodeService comnCodeService;

	@Autowired
	private ComnCodeRepository comnCodeRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private RoleRepository roleRepository;

	@Autowired
	private PmsTechOrderHistRepository pmsTechOrderHistRepository;
	@Autowired
	private PmsTechOrderRepository pmsTechOrderRepository;
	@Autowired
	private PmsPartDtlRepository pmsPartDtlRepository;

	private List<ComnCodeVo> comnCodeList;

	@Test
	public void comnCodeMenuInsert() {

		// Columbia	Axia	Termonorte		엔진모델번호	20H35DFV
//jkkim/2019-11-29/Code구조 변경으로 주석처리
//		ComnCodeVo codeVo = new ComnCodeVo("rms", "rms", "Y", "rms", "rms", "", 1, "Hi-TIMMS의 회사구분 코드");
//		comnCodeService.addComnCode(codeVo);
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia", "rms.Columbia", "Y", "Columbia", "Columbia", "", 1, "콜롬비아", "rms"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia", "rms.Columbia.Axia", "Y", "Axia", "Axia", "", 1, "콜롬비아의 Axia회사", "rms.Columbia"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte", "rms.Columbia.Axia.Termonorte", "Y", "Termonorte", "Termonorte", "", 1, "콜롬비아.Axia회사.Termonorte지역", "rms.Columbia.Axia"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.model", "rms.Columbia.Axia.Termonorte.model", "Y", "Model", "Model", "", 1, "콜롬비아.Axia회사.Termonorte지역.엔진모델", "rms.Columbia.Axia.Termonorte"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.model.20H35DFV", "rms.Columbia.Axia.Termonorte.model.20H35DFV", "Y", "20H35DFV", "20H35DFV", "", 1, "콜롬비아.Axia회사.Termonorte지역.엔진모델.20H35DFV", "rms.Columbia.Axia.Termonorte.model"));
//								// 추가되는 모델은 여기에 계속 넣으면 된다. 대부분의 엔진모델은 하나다.
//								//...
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine", "rms.Columbia.Axia.Termonorte.engine", "Y", "Engine", "Engine", "", 2, "콜롬비아.Axia회사.Termonorte지역.설치엔진순번(고유번호)", "rms.Columbia.Axia.Termonorte"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no01", "rms.Columbia.Axia.Termonorte.engine.no01", "Y", "No1.Engine", "No1.Engine", "", 1, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No1.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no02", "rms.Columbia.Axia.Termonorte.engine.no02", "Y", "No1.Engine", "No2.Engine", "", 2, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No2.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no03", "rms.Columbia.Axia.Termonorte.engine.no03", "Y", "No1.Engine", "No3.Engine", "", 3, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No3.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no04", "rms.Columbia.Axia.Termonorte.engine.no04", "Y", "No1.Engine", "No4.Engine", "", 4, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No4.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no05", "rms.Columbia.Axia.Termonorte.engine.no05", "Y", "No1.Engine", "No5.Engine", "", 5, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No5.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no06", "rms.Columbia.Axia.Termonorte.engine.no06", "Y", "No1.Engine", "No6.Engine", "", 6, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No6.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no07", "rms.Columbia.Axia.Termonorte.engine.no07", "Y", "No1.Engine", "No7.Engine", "", 7, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No7.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no08", "rms.Columbia.Axia.Termonorte.engine.no08", "Y", "No1.Engine", "No8.Engine", "", 8, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No8.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no09", "rms.Columbia.Axia.Termonorte.engine.no09", "Y", "No1.Engine", "No9.Engine", "", 9, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No9.Engine", "rms.Columbia.Axia.Termonorte.engine"));
//		comnCodeService.addComnCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no10", "rms.Columbia.Axia.Termonorte.engine.no10", "Y", "No10.Engine", "No10.Engine", "", 10, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No10.Engine", "rms.Columbia.Axia.Termonorte.engine"));
		
		
//		codeVo
//		.addSubCode(new ComnCodeVo("rms.Columbia", "rms.Columbia", "Y", "Columbia", "Columbia", "", 1, "콜롬비아")
//				.addSubCode(new ComnCodeVo("rms.Columbia.Axia", "rms.Columbia.Axia", "Y", "Axia", "Axia", "", 1, "콜롬비아의 Axia회사")
//						.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte", "rms.Columbia.Axia.Termonorte", "Y", "Termonorte", "Termonorte", "", 1, "콜롬비아.Axia회사.Termonorte지역")
//								.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.model", "rms.Columbia.Axia.Termonorte.model", "Y", "Model", "Model", "", 1, "콜롬비아.Axia회사.Termonorte지역.엔진모델")
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.model.20H35DFV", "rms.Columbia.Axia.Termonorte.model.20H35DFV", "Y", "20H35DFV", "20H35DFV", "", 1, "콜롬비아.Axia회사.Termonorte지역.엔진모델.20H35DFV"))
//										// 추가되는 모델은 여기에 계속 넣으면 된다. 대부분의 엔진모델은 하나다.
//										//...
//								).addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine", "rms.Columbia.Axia.Termonorte.engine", "Y", "Engine", "Engine", "", 2, "콜롬비아.Axia회사.Termonorte지역.설치엔진순번(고유번호)")
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no01", "rms.Columbia.Axia.Termonorte.engine.no01", "Y", "No1.Engine", "No1.Engine", "", 1, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No1.Engine"))
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no02", "rms.Columbia.Axia.Termonorte.engine.no02", "Y", "No1.Engine", "No2.Engine", "", 2, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No2.Engine"))
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no03", "rms.Columbia.Axia.Termonorte.engine.no03", "Y", "No1.Engine", "No3.Engine", "", 3, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No3.Engine"))
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no04", "rms.Columbia.Axia.Termonorte.engine.no04", "Y", "No1.Engine", "No4.Engine", "", 4, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No4.Engine"))
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no05", "rms.Columbia.Axia.Termonorte.engine.no05", "Y", "No1.Engine", "No5.Engine", "", 5, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No5.Engine"))
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no06", "rms.Columbia.Axia.Termonorte.engine.no06", "Y", "No1.Engine", "No6.Engine", "", 6, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No6.Engine"))
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no07", "rms.Columbia.Axia.Termonorte.engine.no07", "Y", "No1.Engine", "No7.Engine", "", 7, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No7.Engine"))
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no08", "rms.Columbia.Axia.Termonorte.engine.no08", "Y", "No1.Engine", "No8.Engine", "", 8, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No8.Engine"))
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no09", "rms.Columbia.Axia.Termonorte.engine.no09", "Y", "No1.Engine", "No9.Engine", "", 9, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No9.Engine"))
//										.addSubCode(new ComnCodeVo("rms.Columbia.Axia.Termonorte.engine.no10", "rms.Columbia.Axia.Termonorte.engine.no10", "Y", "No10.Engine", "No10.Engine", "", 10, "콜롬비아.Axia회사.Termonorte지역.설치엔진.No10.Engine"))
//								)
//						)
//				)
//		)
//		;
//
//		comnCodeService.addComnCode(codeVo);
//
//
//
//		// MenuCode등록.
//		codeVo = new ComnCodeVo("menu", "menu", "Y", "menu", "menu", "/", 1, "최상위-메뉴코드");
//		codeVo
//		.addSubCode(new ComnCodeVo("menu.overView", "menu.overView", "Y", "OverView", "OverView", "/overview", 1, "OverView 링크메뉴(직접화면)"))
//		.addSubCode(new ComnCodeVo("menu.EngineStatus", "menu.EngineStatus", "Y", "EngineStatus", "EngineStatus", "", 2, "EngineStatus 메뉴(하위가 존재함)")
//				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine[]", "menu.EngineStatus.engine[]", "Y", "engine", "No[].Engine", "", 1, "No1.Engine, No2.Engine, ...") 
//				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine[].RealValue", "menu.EngineStatus.engine[].RealValue", "Y", "RealValue", "RealValue", "/realValue", 1, "realValue 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine[].ProcessFlowDiagram", "menu.EngineStatus.engine[].ProcessFlowDiagram", "Y", "ProcessFlowDiagram", "ProcessFlowDiagram", "/engineDiagram", 2, "ProcessFlowDiagram 링크메뉴(직접화면)"))
//						)
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine01", "menu.EngineStatus.engine01", "Y", "engine01", "No1.Engine", "", 1, "No1.Engine") 
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine01.RealValue", "menu.EngineStatus.engine01.RealValue", "Y", "RealValue", "RealValue", "/realValue", 1, "realValue 링크메뉴(직접화면)"))
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine01.ProcessFlowDiagram", "menu.EngineStatus.engine01.ProcessFlowDiagram", "Y", "ProcessFlowDiagram", "ProcessFlowDiagram", "/engineDiagram", 2, "ProcessFlowDiagram 링크메뉴(직접화면)"))
////						)
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine02", "menu.EngineStatus.engine02", "Y", "engine02", "No2.Engine", "", 2, "No2.Engine")  )
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine03", "menu.EngineStatus.engine03", "Y", "engine03", "No3.Engine", "", 3, "No3.Engine")  )
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine04", "menu.EngineStatus.engine04", "Y", "engine04", "No4.Engine", "", 4, "No4.Engine")  )
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine05", "menu.EngineStatus.engine05", "Y", "engine05", "No5.Engine", "", 5, "No5.Engine")  )
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine06", "menu.EngineStatus.engine06", "Y", "engine06", "No6.Engine", "", 6, "No6.Engine")  )
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine07", "menu.EngineStatus.engine07", "Y", "engine07", "No7.Engine", "", 7, "No7.Engine")  )
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine08", "menu.EngineStatus.engine08", "Y", "engine08", "No8.Engine", "", 8, "No8.Engine")  )
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine09", "menu.EngineStatus.engine09", "Y", "engine09", "No9.Engine", "", 9, "No9.Engine")  )
////				.addSubCode(new ComnCodeVo("menu.EngineStatus.engine10", "menu.EngineStatus.engine10", "Y", "engine10", "No10.Engine", "", 10, "No10.Engine")  )
//				)
//		.addSubCode(new ComnCodeVo("menu.auxDiagram", "menu.auxDiagram", "Y", "AuxEquipmentStatus", "AuxEquipmentStatus", "/auxDiagram", 3, "AuxEquipmentStatus 링크메뉴(직접화면)"))
//		.addSubCode(new ComnCodeVo("menu.ElectricalStatus", "menu.ElectricalStatus", "Y", "ElectricalStatus", "ElectricalStatus", "", 4, "ElectricalStatus 메뉴(하위가 존재함)")
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.Overall", "menu.ElectricalStatus.Overall", "Y", "Overall", "Overall", "/overall", 1, "Overall 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.MediumVoltage", "menu.ElectricalStatus.MediumVoltage", "Y", "MediumVoltage", "MediumVoltage", "/mediumVoltage", 1, "MediumVoltage 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.LowVoltage", "menu.ElectricalStatus.LowVoltage", "Y", "LowVoltage", "LowVoltage", "/lowVoltage", 1, "LowVoltage 링크메뉴(직접화면)"))
//				)
//		.addSubCode(new ComnCodeVo("menu.EngineAlarm", "menu.EngineAlarm", "Y", "EngineAlarm", "EngineAlarm", "", 5, "EngineAlarm 메뉴(하위가 존재함)")
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.AlarmList", "menu.ElectricalStatus.AlarmList", "Y", "AlarmList", "AlarmList", "/alarmList", 1, "AlarmList 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.EventRanking", "menu.ElectricalStatus.EventRanking", "Y", "EventRanking", "EventRanking", "/EventRanking", 1, "EventRanking 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.ActionList", "menu.ElectricalStatus.ActionList", "Y", "ActionList", "ActionList", "/actionList", 1, "ActionList 링크메뉴(직접화면)"))
//				)
//		.addSubCode(new ComnCodeVo("menu.TrendViewer", "menu.TrendViewer", "Y", "TrendViewer", "Trend Viewer", "", 6, "Trend Viewer 메뉴(하위가 존재함)")
//
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.engine[]", "menu.ElectricalStatus.engine[]", "Y", "engine", "No[].Engine", "/engineTrend", 1, "No1.Engine, No2.Engine, ... 링크메뉴(직접화면)"))
//
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.AuxEquipment", "menu.ElectricalStatus.AuxEquipment", "Y", "AuxEquipment", "Aux.Equipment", "/auxEquipment", 1, "AuxEquipment 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.ElectricalSystem", "menu.ElectricalStatus.ElectricalSystem", "Y", "ElectricalSystem", "ElectricalSystem", "/slectricalSystem", 1, "ElectricalSystem 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.Customize", "menu.ElectricalStatus.Customize", "Y", "Customize", "Customize", "/customize", 1, "Customize 링크메뉴(직접화면)"))
//				)
//		.addSubCode(new ComnCodeVo("menu.MaintenanceManagement", "menu.MaintenanceManagement", "Y", "MaintenanceManagement", "Maintenance Management", "", 7, "Maintenance Management 메뉴(하위가 존재함)")
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.WorksSpare", "menu.ElectricalStatus.WorksSpare", "Y", "WorksSpare", "Works_Spare", "/worksSpare", 1, "WorksSpare 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.ElectricalStatus.MaintenanceHistory", "menu.ElectricalStatus.MaintenanceHistory", "Y", "MaintenanceHistory", "MaintenanceHistory", "/MaintenanceHistory ", 1, "MaintenanceHistory 링크메뉴(직접화면)"))
//				)
//		.addSubCode(new ComnCodeVo("menu.OperMgt", "menu.OperMgt", "Y", "OperMgt", "Operation Management", "", 8, "Operation Management 메뉴(하위가 존재함)")
//				.addSubCode(new ComnCodeVo("menu.OperMgt.codeMgt", "menu.OperMgt.codeMgt", "Y", "codeMgt", "Code Management", "/codeMgt", 1, "Code Management 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.OperMgt.userMgt", "menu.OperMgt.userMgt", "Y", "userMgt", "User Management", "/userMgt", 2, "User Management 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.OperMgt.roleMgt", "menu.OperMgt.roleMgt", "Y", "roleMgt", "Role Management", "/roleMgt", 3, "Role Management 링크메뉴(직접화면)"))
//				.addSubCode(new ComnCodeVo("menu.OperMgt.roleGrpMgt", "menu.OperMgt.roleGrpMgt", "Y", "roleGrpMgt", "Role Group Management", "/roleGrpMgt", 4, "Role Group Management 링크메뉴(직접화면)"))
//				)
//		;
//		
//		comnCodeService.addComnCode(codeVo);
//		
//		
//		
//		// RoleCode등록.
//		codeVo = new ComnCodeVo("role", "role", "Y", "role", "Role", "/", 1, "최상위-권한코드");
//		codeVo // "ROOT", "ADMIN", "USER", "GUEST"
////		.addSubCode(new ComnCodeVo("role.ROOT", "role.ROOT", "Y", "ROOT", "ROLE_ROOT", "", 1, "ROLE_ROOT 권한")) // 시스템적으로 하드코딩된 권한임.
////		.addSubCode(new ComnCodeVo("role.ADMIN", "role.ADMIN", "Y", "ADMIN", "ROLE_ADMIN", "", 2, "ROLE_ADMIN 권한")) // 시스템적으로 하드코딩된 권한임.
////		.addSubCode(new ComnCodeVo("role.USER", "role.USER", "Y", "USER", "ROLE_USER", "", 3, "ROLE_USER 권한")) // 시스템적으로 하드코딩된 권한임.
////		.addSubCode(new ComnCodeVo("role.GUEST", "role.GUEST", "Y", "GUEST", "ROLE_GUEST", "", 4, "ROLE_GUEST 권한")) // 시스템적으로 하드코딩된 권한임.
//		
//		.addSubCode(new ComnCodeVo("role.SOMEONE", "role.SOMEONE", "Y", "SOMEONE", "ROLE_SOMEONE", "", 4, "ROLE_SOMEONE 권한"))
//		.addSubCode(new ComnCodeVo("role.SOME_AUTH", "role.SOME_AUTH", "Y", "SOME_AUTH", "ROLE_SOME_AUTH", "", 4, "ROLE_SOME_AUTH 권한"))
//		;
//		
//		comnCodeService.addComnCode(codeVo);
//		
//		
//		
//		// RoleGroupCode등록.
//		codeVo = new ComnCodeVo("roleGrp", "roleGrp", "Y", "roleGrp", "Role Group", "/", 1, "최상위-권한그룹코드");
//		codeVo // "ROOT", "ADMIN", "USER", "GUEST"
//		.addSubCode(new ComnCodeVo("roleGrp.Oper", "roleGrp.Oper", "Y", "Oper", "Operation", "", 1, "Operation Role 권한 Group")
//				.addSubCode(new ComnCodeVo("roleGrp.Oper.ROOT", "roleGrp.Oper.ROOT", "Y", "role.ROOT", "ROLE_ROOT", "", 1, "ROLE_ROOT 권한"))
//				.addSubCode(new ComnCodeVo("roleGrp.Oper.ADMIN", "roleGrp.Oper.ADMIN", "Y", "role.ADMIN", "ROLE_ADMIN", "", 2, "ROLE_ADMIN 권한"))
//				.addSubCode(new ComnCodeVo("roleGrp.Oper.USER", "roleGrp.Oper.USER", "Y", "role.USER", "ROLE_USER", "", 3, "ROLE_USER 권한"))
//				.addSubCode(new ComnCodeVo("roleGrp.Oper.SOMEONE", "roleGrp.Oper.SOMEONE", "Y", "role.SOMEONE", "ROLE_SOMEONE", "", 4, "ROLE_SOMEONE 권한"))
//				.addSubCode(new ComnCodeVo("roleGrp.Oper.SOME_AUTH", "roleGrp.Oper.SOME_AUTH", "Y", "role.SOME_AUTH", "ROLE_SOME_AUTH", "", 5, "ROLE_SOME_AUTH 권한"))
//				)
//		.addSubCode(new ComnCodeVo("roleGrp.SiteOper", "roleGrp.SiteOper", "Y", "SiteOper", "Site Operation", "", 2, "Site Operation Role 권한 Group")
//				.addSubCode(new ComnCodeVo("roleGrp.SiteOper.ADMIN", "roleGrp.SiteOper.ADMIN", "Y", "role.ADMIN", "ROLE_ADMIN", "", 1, "ROLE_ADMIN 권한"))
//				.addSubCode(new ComnCodeVo("roleGrp.SiteOper.USER", "roleGrp.SiteOper.USER", "Y", "role.USER", "ROLE_USER", "", 2, "ROLE_USER 권한"))
//				.addSubCode(new ComnCodeVo("roleGrp.SiteOper.SOMEONE", "roleGrp.SiteOper.SOMEONE", "Y", "role.SOMEONE", "ROLE_SOMEONE", "", 3, "ROLE_SOMEONE 권한"))
//				.addSubCode(new ComnCodeVo("roleGrp.SiteOper.SOME_AUTH", "roleGrp.SiteOper.SOME_AUTH", "Y", "role.SOME_AUTH", "ROLE_SOME_AUTH", "", 4, "ROLE_SOME_AUTH 권한"))
//				)
//		.addSubCode(new ComnCodeVo("roleGrp.User", "roleGrp.User", "Y", "User", "User", "", 3, "User Role 권한 Group")
//				.addSubCode(new ComnCodeVo("roleGrp.User.USER", "roleGrp.User.USER", "Y", "role.USER", "ROLE_USER", "", 1, "ROLE_USER 권한"))
//				.addSubCode(new ComnCodeVo("roleGrp.User.SOMEONE", "roleGrp.User.SOMEONE", "Y", "role.SOMEONE", "ROLE_SOMEONE", "", 2, "ROLE_SOMEONE 권한"))
//				)
//		.addSubCode(new ComnCodeVo("roleGrp.Guest", "roleGrp.Guest", "Y", "Guest", "Guest", "", 4, "Guest Role 권한 Group")
//				.addSubCode(new ComnCodeVo("roleGrp.Guest.SOME_AUTH", "roleGrp.Guest.SOME_AUTH", "Y", "role.SOME_AUTH", "ROLE_SOME_AUTH", "", 1, "ROLE_SOME_AUTH 권한"))
//				)
//		;
//		
//		comnCodeService.addComnCode(codeVo);

		
	}


	@Test
	public void contextLoads() {
		
//		comnCodeList = this.comnCodeService.getActivedComnCd(null);
//		log.debug("comnCodeService.getActivedComnCd(null) = [{}]", comnCodeList);
//		comnCodeList = this.comnCodeService.getComnCodeList(null, null);
//		log.debug("comnCodeService.getComnCodeList(null, null) = [{}]", comnCodeList);
//		comnCodeList = this.comnCodeService.getActivedComnCd("menu.OperMgt");
//		log.debug("comnCodeService.getActivedComnCd(\"menu.OperMgt\") = [{}]", comnCodeList);
//		comnCodeList = this.comnCodeService.getActivedComnCd("rms.Columbia.Axia.Termonorte.engine");
//		log.debug("comnCodeService.getActivedComnCd(\"rms.Columbia.Axia.Termonorte.engine\") = [{}]", comnCodeList);
		
		List<UserInfoVo> userInfoList = this.userRepository.findAll();
		UserInfoVo userInfoVo = null;
		log.debug("this.userRepository.findAll() = [{}]", userInfoList);
		log.debug("this.userRepository.findByUserId(\"ojooy\") = [{}]", userInfoVo = this.userRepository.findByUserId("ojooy"));
		log.debug("this.userRepository.findByUserIdAndIsLockAndIsDel(\"ojooy\") = [{}]", userInfoVo = this.userRepository.findByUserIdAndIsLockAndIsDel("ojooy", true, false));
		
		List<RoleInfoVo> roleInfoList = this.roleRepository.findAll();
		log.debug("this.roleRepository.findAll() = [{}]", roleInfoList);
		roleInfoList = this.roleRepository.findAllById(Arrays.asList(new String[] {"ROLE_SOME_AUTH_WRITE", "ROLE_USER", "ROLE_ANY"}));
		log.debug("this.roleRepository.findAllById(Arrays.asList(new String[] {\"ROLE_SOME_AUTH_WRITE\", \"ROLE_USER\", \"ROLE_ANY\"})) = [{}]", roleInfoList);
		RoleInfoVo roleInfo = this.roleRepository.findByRoleId("ROLE_ROOT");
		log.debug("this.roleRepository.findById(\"ROLE_ROOT\") = [{}]", roleInfo);
		roleInfo = this.roleRepository.findByRoleId("ROLE_ANY");
		log.debug("this.roleRepository.findById(\"ROLE_ANY\") = [{}]", roleInfo);
		
		
		//PmsTechOrderHistModel techOrderHist = new PmsTechOrderHistModel(new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV", "DFE", "FIV", "003", "14", "H")
		//		, "engine01", "work_noti : 교체테스트", new LocalDate(), 4210);
		//pmsTechOrderHistRepository.save(techOrderHist);
		//techOrderHist = new PmsTechOrderHistModel(new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV", "DFE", "FIV", "003", "14", "H")
		//		, "engine01", "work_noti : 교체테스트 LDFV53000-012", new LocalDate(), 2300);
		//pmsTechOrderHistRepository.save(techOrderHist);
		
		
		
		List<PmsTechOrderHistModel> pmsTechOrderHistList = this.pmsTechOrderHistRepository.findAll(); 
		List<PmsTechOrderModel> pmsTechOrderList = this.pmsTechOrderRepository.findAll(); 
		List<PmsPartDtlModel> pmsPartDtlList = this.pmsPartDtlRepository.findAll(); 
		
		
		
		
	}

	

}
