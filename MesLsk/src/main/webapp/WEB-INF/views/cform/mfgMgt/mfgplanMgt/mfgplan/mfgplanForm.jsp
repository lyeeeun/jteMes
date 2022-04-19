<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div style="width:100%;">
<!-- 	최상단 검색영역 -->
	<div style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<!-- 월/일 체크박스 -->
		<input type="radio" name="dateType" id="monthChk" class="k-radio" checked="checked" value="month" style="margin : 0 5px 0 5px;">
		<label class="mfgplanForm-label" for="monthChk" style="vertical-align:middle;"><spring:message code = "html_month"/></label>			<!-- 월 -->
		<input type="radio" name="dateType" id="dayChk" class="k-radio"  value="day" style="margin : 0 5px 0 5px;">
		<label class="mfgplanForm-label" for="dayChk" style="vertical-align:middle;"><spring:message code = "html_day"/></label>								<!-- 일 -->
		<!-- 년/월 셀렉트 박스 -->
		<input id="jteYearSelBox" style="width:80px; margin-left:15px;"/>
		<input id="jteMonthSelBox" style="width:80px;"/>
		
		<!-- 진행중/종료 체크박스 -->
		<input type="radio" name="lotType" id="prosChk" class="k-radio" checked="checked" value="ord_sta01" style="margin : 0 5px 0 5px;">
		<label class="mfgplanForm-label" for="prosChk" style="vertical-align:middle;"><spring:message code = "html_proceed"/></label>			<!-- 진행중 -->
		<input type="radio" name="lotType" id="endChk" class="k-radio" value="ord_sta02" style="margin : 0 5px 0 5px;">
		<label class="mfgplanForm-label" for="endChk" style="vertical-align:middle;"><spring:message code = "html_end"/></label>								<!-- 종료 -->
	</div>
	<!-- 년/월 그리드 -->
	<div id="grid-content" style="width:100%;">
		<div id="jteSingleGrid" style="display:block;"></div>
		<div id="jteDoubleGrid" style="display:block;"></div>
	</div>
</div>
<div style="display:none;">
	<div id="jtePopForm" style="height:100%;">
 		<ul>
			<li>
				생산계획
			</li>
			<li>
				일괄처리
			</li>
		</ul>
		<!--1번탭 -->
		<div>
			<form id="jtePopForm_form" class="mfgplanForm">
				<!-- 생산계획정보 -->
				<div class="pop_title"><spring:message code = "pop_prodPlanInfo"></spring:message></div>
				<table style="width:100%;" id="jtePopForm_master">
				<colgroup>
					<col class="col-left-title">
					<col class="col-right-content">
				</colgroup>
					<tr>
					<!-- Lot코드 -->
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_lotCd"/> : </td>
						<td>
							<input type="text" id="lotId" class="center-input" name="lotId" format="text" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/>						<!-- 자동입력 -->
						</td>
					</tr>
					<tr>
					<!-- 생산계획코드 -->
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_prodPlanCd"/> : </td>
						<td>
							<input type="text" id="prodPlanId" class="center-input" name="prodPlanId" format="text" placeholder="<spring:message code = "pop_autoInput"></spring:message> " readonly/>			<!-- 자동입력 -->
						</td>
					</tr>
					<tr id="dayTargetArea" style="display:none;">
					<!-- 일일목표량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_dayTarget"/> : </td>
					<td colspan="2"><input id="itemDayTarget" class="center-input" name="itemDayTarget" format="currency" readonly/></td>
					</tr>
					<tr>
					<!-- 계획량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_planQuan"/> : </td>
					<td ><input id="prodPlanQty" class="center-input" name="prodPlanQty" format="currency"/></td>
					</tr>
					<tr>
					<!-- 설명 -->
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"/> : </td>
						<td><input type="text" id="prodPlanDesc" class="center-input" name="prodPlanDesc" format="text"/></td>
					</tr>
					<tr style="display:none;">
						<td colspan="2">
							<input type="hidden" id= "prodPlanType" name = "prodPlanType"/>
							<input type="hidden" id= "prodPlanYear" name = "prodPlanYear"/>
							<input type="hidden" id= "prodPlanMonth" name = "prodPlanMonth"/>
							<input type="hidden" id= "prodPlanDay" name = "prodPlanDay"/>
							<input type="hidden" id= "action" name = "action"/>
						</td>
					</tr>
				</table>
			</form>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-save final-btn" type="button"><spring:message code = "pop_save"/></button>											<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
			</div>
			<!--생산지시 정보  일간계획 계획량 저장이 되었을 경우에만 표시된다. -->
			<div id="asgnInfo" style="display:none;">
			<!-- 작업지시 -->
				<div class="pop_title"><spring:message code = "pop_workAsm"></spring:message></div>
				<div id="jtePopForm_grid"></div>
			</div>
		</div>
		<!--2번탭 -->
		<div>
			<form id="jtePopForm_tab" class="mfgplanForm">
				<div style="width:100%; background:#E2ECFF; padding:15px 0 15px 0; margin:10px 0 10px 0;">
					<span class="bulkTypeArea">
						<!-- 등록/삭제 라디오박스 -->
						<input type="radio" name="bulkType" id="bulkInsert" class="k-radio" style="margin-left:5px;" checked="checked" value="ins">
						<label class="mfgplanForm-label" for="bulkInsert" style="vertical-align:middle; margin-left:5px;">등록</label>
						<input type="radio" name="bulkType" id="bulkDelete" class="k-radio" style="margin-left:5px;" value="del">
						<label class="mfgplanForm-label" for="bulkDelete" style="vertical-align:middle; margin-left:5px;">삭제</label>
					</span>
					<span class="bulkTargetArea" style="float:right;">
						<!-- 계획/지시/작업 체크박스 -->
						<input type="checkbox" name="bulkTarget" id="bulkPlan" class="k-checkbox" checked="checked" value="plan">
						<label class="mfgplanForm-label" for="bulkPlan" style="vertical-align:middle; margin-left:15px;">생산계획</label>
						<input type="hidden" name="hidBulkPlanYN"/>
						
						<input type="checkbox" name="bulkTarget" id="bulkAsgn" class="k-checkbox" checked="checked" value="asgn">
						<label class="mfgplanForm-label" for="bulkAsgn" style="vertical-align:middle;">생산지시</label>
						<input type="hidden" name="hidBulkAsgnYN"/>
						
						<input type="checkbox" name="bulkTarget" id="bulkWork" class="k-checkbox" checked="checked" value="work">
						<label class="mfgplanForm-label" for="bulkWork" style="vertical-align:middle;">작업지시</label>
						<input type="hidden" name="hidBulkWorkYN"/>
					</span>
				</div>
				<table style="width:100%;" id="jtePopForm_master">
					<colgroup>
						<col style="width:40%;"/>
						<col style="width:60%;"/>
					</colgroup>
					<tr>
						<td>
							<i class="fas fa-caret-right"></i>LOT코드 : 
						</td>
						<td>
							<input class="k-textbox center-input" name="lotId" readonly/>
						</td>
					</tr>
					<tr class="baseDateArea">
						<td>
							<i class="fas fa-caret-right"></i>복사데이터 조회 : 
						</td>
						<td>
							<input name="baseDate" style="width:45%;"/>
							<lable name="bulkPos"></lable>
							<input type="hidden" name="hidBulkPos"/>
							
						</td>
					</tr>
					<tr id="bulkPeriodChkArea">
						<td colspan="2" style="padding: 5px 0 10px 0;">
							<input type="checkbox" name="bulkPeriod" id="bulkPeriod" class="k-checkbox" checked="checked" value="Y">
							<label class="mfgplanForm-label" for="bulkPeriod" style="vertical-align:middle; margin-left:5px;">기간 직접 지정</label>
							<input type="hidden" name="bulkPeriodYN"/>
						</td>
					</tr>
					<tr id="bulkPeriodArea" style="display:none;">
						<td>
 							<i class="fas fa-caret-right"></i>등록기간 : 
						</td>
						<td>
							<input name="bulkStdt" style="width:45%;"/>~
							<input name="bulkEddt" style="width:45%;"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="final-btn-area">
							<button class="k-button k-primary jte-bulk-save final-btn" onclick="lfn_bulk_save();" type="button">일괄등록</button>
							<button class="k-button k-primary jte-bulk-delete final-btn" onclick="lfn_bulk_delete();" type="button">일괄삭제</button>
							<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
						</td>
					</tr>
					<tr style="display:none;">
						<td colspan="2">
							<input type="hidden" name = "prodPlanId"/>
							<input type="hidden" name = "prodPlanType"/>
							<input type="hidden" name = "prodPlanYear"/>
							<input type="hidden" name = "prodPlanMonth"/>
							<input type="hidden" name = "prodPlanDay"/>
							<input type="hidden" name = "action"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>

<!-- 생산지시 팝업 -->
<div style="display:none;">
	<div id="jteProdAsgnPop">
		<form id="jteProdAsgnPop_form" class="mfgplanForm">
		<!-- 작업지시 -->
			<div class="pop_title"><spring:message code = "pop_workAsm"></spring:message></div>
			<table style="width:100%;" id="jteProdAsgnPop_master">
			<colgroup>
				<col class="popsc-col-left-title">
				<col class="popsc-col-left-content">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr>
				<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td>
						<input type="text" id="itemNm" class="left-input" name="itemNm" readonly />
						<input type="hidden" id="itemId" name="itemId"/>
					</td>
				<!-- 작업상태 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_workStatus"></spring:message> : </td>
					<td><input id="prodAsmState" class="right-input" name="prodAsmState"  format = "selBox" msg="prod_sta" readonly/></td>
				</tr>
				<tr>
				<!-- 작업지시코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderCd"></spring:message> : </td>
					<td>
						<input type="text" id="prodAsmId" class="left-input" name="prodAsmId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/>			<!-- 자동입력 -->
					</td>
				<!-- 긴급여부 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_prodEmj"></spring:message> : </td>
					<td>
						<input name="prodAsmEmj" id="prodAsmEmj" class="right-input" format="selBox" msg="prod_emj"/>
					</td>
<%-- 				<!-- 작업지시명 -->
					<td><spring:message code = "col_workOrderNm"></spring:message> : </td>
					<td>
						<input type="text" id="prodAsmNm" name="prodAsmNm"/>
					</td> --%>
				</tr>
				<tr>
				<!-- 지시량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_asmQuan"></spring:message> : </td>
					<td colspan="3"><input id="prodAsmQty" class="center-input" name="prodAsmQty" format="currency"/></td>
				</tr>
				<tr style="display:none;">
				<!-- 부서명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_deptNm"></spring:message> : </td>
					<td>
						<input id="deptNm" class="left-input btn-input" name="deptNm" format="text" readonly/>
						<input type="hidden" name="deptId" id="deptId"/>
					</td>
					<td>
				<!-- 조회 -->
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_deptInfoPop_Open(lfn_deptInfoPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				<!-- 작업지시자 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderUser"></spring:message> : <i class="fas fa-info-circle" title="미설정시 지정된 부서의 팀장에게 발송됩니다." style="background:yellow;"></i></td>
					<td>
						<input id="prodAsmUserNm" class="right-input btn-input" name="prodAsmUserNm" format="text" readonly/>
						<input type="hidden" name="prodAsmUser" id="prodAsmUser"/>
					</td>
					<td>
				<!-- 조회 -->
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="prodAsmDesc" class="center-input" name="prodAsmDesc" format="text"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name="prodPlanId"/>
						<input type="hidden" name="prodPlanYear"/>
						<input type="hidden" name="prodPlanMonth"/>
						<input type="hidden" name="prodPlanDay"/>
						<input type="hidden" name="prodAsmDate"/>
						<input type="hidden" name="use"/>
						<input type="hidden" name="planAction" id="planAction"/>
						<input type="hidden" name="workAction" id="workAction"/>
						<input type="hidden" name="action"/>
					</td>
				</tr>
			</table>
		</form>
		
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>				<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>				<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteProdAsgnPop');"><spring:message code = "pop_cancel"></spring:message></button>		<!-- 취소 -->
		</div>
		
		<div id="prodWorkInfo" style="display:none;">
		<!-- 라우팅,설비 지정 -->
			<div class="pop_title"><spring:message code = "pop_dirRoutEqmt"></spring:message></div>
			<div id="jteProdAsgnPop_gird"></div>
		</div>
	</div>
</div>

<!-- 생산지시 팝업 -->
<div style="display:none;">
	<div id="jteProdProdWorkPop">
		<form id="jteProdProdWorkPop_form" class="mfgplanForm">
			<table style="width:100%;" id="jteProdProdWorkPop_master">
			<colgroup>
				<col class="poptr-col-left-title">
				<col class="poptr-col-left-content-1">
				<col class="poptr-col-left-content-2">
				<col class="poptr-col-right-title">
				<col class="poptr-col-right-content-1">
				<col class="poptr-col-right-content-2">
			</colgroup>
				<tr class="pop_title">
					<td colspan="6">
					<!-- 라우팅,설비 지정 -->
						<spring:message code = "pop_dirRoutEqmt"></spring:message>
					</td>
				</tr>
				<tr>
				<!-- 라우팅코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_routCd"></spring:message> : </td>
					<td>
						<input id="routingType" class="left-input btn-input" name="routingType" format="selBox" msg="process_type" def="null" readonly/>
						<input type="hidden" name="routingId" id="routingId"/>
					</td>
					<!-- 조회 -->
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_routingPop_Open(lfn_routingPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				<!-- 설비개별코드 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtIndivCd"></spring:message> : </td>
					<td>
						<input id="eqmtMgtNm" class="right-input btn-input" name="eqmtMgtNm" format="text" readonly/>
						<input type="hidden" name="eqmtMgtId" id="eqmtMgtId"/>
					</td>
					<!-- 조회 -->
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_equipmentPop_Open(lfn_equipmentPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				</tr>
				<tr>
				<!-- 지시량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_asmQuan"></spring:message> : </td>
					<td colspan="5">
						<input id="prodWorkQty" class="center-input" name="prodWorkQty" format="currency"/>
					</td>
				</tr>
				<tr class="pop_title">
					<td colspan="6">
				<!-- 작업자 직접 지정 -->
						<spring:message code = "col_dirWrkAsm"></spring:message><i class="fas fa-info-circle" title="작업자를 직접 지정시 입력해주세요."></i>
					</td>
				</tr>
				<tr>
				<!-- 작업자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_worker"></spring:message> : </td>
					<td>
						<input id="prodWorkUserNm" class="left-input btn-input" name="prodWorkUserNm" format="text" readonly/>
						<input type="hidden" name="prodWorkUser" id="prodWorkUser"/>
					</td>
				<!-- 조회 -->
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_prodWorkPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="5"><input id="prodWorkDesc" class="center-input" name="prodWorkDesc"/></td>
				</tr>
				<tr class="adminWorkInputArea" style="display:none">
				<!-- 양품량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_prodQuan"></spring:message> : </td>
					<td colspan="2"><input id="prodWorkGood" class="left-input" name="prodWorkGood" format="currency"/></td>
				<!-- 불량량 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_badProdQuan"></spring:message> : </td>
					<td colspan="2"><input id="prodWorkBad" class="right-input" name="prodWorkBad" format="currency"/></td>
				</tr>
				<tr class="adminWorkInputArea" style="display:none">
				<!-- 작업시작 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_workStart"></spring:message> : </td>
					<td colspan="5"><input id="prodWorkStart" class="center-input" name="prodWorkStart" format="datetimepicker"/></td>
				</tr>
				<tr class="adminWorkInputArea" style="display:none">
				<!-- 작업종료 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_workEnd"></spring:message> : </td>
					<td colspan="5"><input id="prodWorkEnd" class="center-input" name="prodWorkEnd" format="datetimepicker"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name="itemId"/>
						<input type="hidden" name="prodPlanId"/>
						<input type="hidden" name="prodPlanYear"/>
						<input type="hidden" name="prodPlanMonth"/>
						<input type="hidden" name="prodPlanDay"/>
						<input type="hidden" name="prodAsmDate"/>
						<input type="hidden" name="action"/>
						<input type="hidden" name="use"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteProdProdWorkPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>


<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/mfgplanMgt/mfgplan/mfgplanForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200519 JJW  -->

<script>
var lfo_dateBox = {};
var lfo_common = {};//Form 내부에서 사용될 Object 
var lfo_popGrd = {};
var lfo_prodWorkGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){	
	
	//연도 세팅
	lfo_dateBox.monthArray = ['01','02','03','04','05','06','07','08','09','10','11','12'];
	
	//최상위 검색영역 세팅
	lfn_dateSelBoxSet();
	
	//최상위 검색영역 이벤트 바인딩
	$("[name='dateType']").change(function(e){
		lfn_clearLoadGrid();
	});

	$("[name='lotType']").change(function(e){
		lfn_clearLoadGrid();
	});
	
	//grid 최초 로드
	lfn_clearLoadGrid();
};

//최상위 검색영역 세팅 - selectBox
this.lfn_dateSelBoxSet = function(){
	
	//selectBox 연도 정보 세팅
	lfo_dateBox.yearArray = [];
	var shBoxItem = [];
	var selectedIndex = 0;
	for(i=-5; i<=5; i++){
		var yearUnit = new Date().getFullYear()+i;
		shBoxItem.push({ text: yearUnit, value: yearUnit})
		
		//최초 selected
		if(yearUnit == new Date().getFullYear()){
			selectedIndex = i+5;
		}
	}
	$("#jteYearSelBox").kendoDropDownList({
	dataTextField: "text",
	dataValueField: "value",
	dataSource: shBoxItem,
	index: selectedIndex,
	change: lfn_clearLoadGrid
	});
	
	
	//selectBox 월정보 세팅
	var shBoxItem = [];
	var selectedIndex;
	lfo_dateBox.monthArray.forEach(function(monthUnit,index){
		shBoxItem.push({ text: monthUnit, value: monthUnit});
		
		//최초 selected
		if(monthUnit == gfn_padLeft(new Date().getMonth()+1,  0, 2)){
			selectedIndex = index;
		}
	});
	$("#jteMonthSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: shBoxItem,
		index: selectedIndex,
		//index: 0,
		change: lfn_clearLoadGrid
	});
}

//최상단 checkBox/SelectBox 선택 이벤트
this.lfn_clearLoadGrid = function(){
	lfo_dateBox.chkVal = $("[name='dateType']:checked").val();
// 	lfo_dateBox.yearVal = $("#jteYearSelBox").data("kendoDropDownList").select(0);
// 	lfo_dateBox.monthVal = $("#jteMonthSelBox").data("kendoDropDownList").select(0);
	lfo_dateBox.yearVal = $("#jteYearSelBox").val();
	lfo_dateBox.monthVal = $("#jteMonthSelBox").val(); 
	lfo_dateBox.lotState = $("[name='lotType']:checked").val();
	
	if(lfo_dateBox.chkVal == "month"){
		$("#jteMonthSelBox").closest(".k-dropdown").hide();
		$("#jteDoubleGrid").hide();
		$("#jteSingleGrid").show();
		lfn_monthPlan_load();
	}else if(lfo_dateBox.chkVal == "day"){
		$("#jteMonthSelBox").closest(".k-dropdown").show();
		$("#jteSingleGrid").hide();
		$("#jteDoubleGrid").show();
		lfn_dayPlan_load();
	}
}

//Month -gridLoad
this.lfn_monthPlan_load = function(){
	//초기화
	$("#jteSingleGrid").html("");
	
	//그리드 생성
	lfn_jteSgGrd_setGrd();
}

//Day -gridLoad
this.lfn_dayPlan_load = function(){
	//초기화
	$("#jteDoubleGrid").html("");
	
	//custom 영역
	lfo_dateBox.dayArray =[];
	
	//선택된 년/월에 대한 말일 구하기
	var endDay = new Date(lfo_dateBox.yearVal, lfo_dateBox.monthVal, 0).getDate();
	
	//선택된 년/월에 대한 날짜 범위 구하기(1~??)
	for(var i=1; i<=endDay; i++){
		lfo_dateBox.dayArray.push(gfn_padLeft(i,'0',2));
	}
	
	//그리드 생성
	lfn_jteDbGrd_setGrd();
}


//month - grid 생성
this.lfn_jteSgGrd_setGrd = function(){
	//lfo_common = {};//Form 내부에서 사용될 Object
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mfgMgt/mfgplanMgt/mfgplan";
		
	//CUD 커스텀 진행
	lfo_common.crud  = {
		read:{url:"/getMonthPlanList", auth:"", prmt:{calPrmt : lfo_dateBox.monthArray, calYear : lfo_dateBox.yearVal, lotState : lfo_dateBox.lotState}},
	};
	
	//5.
	lfo_common.model = {
		id: "orderId",
		fields: {
			orderId: { type: "string" },
			orderNm: { type: "string" },
			orderStdt: { type: "date" },
			orderEddt: { type: "date" },
			description: { type: "string" },
			lotId: { type: "string" },
			lotNm: { type: "string" },
			itemId:{ type: "string" },
			itemNm:{ type: "string" },
			itemDeduction:{ type: "int" },
			itemDayTarget:{ type: "int" },
			lotState: { type: "string" },
			lotQty: { type: "int" },
			lotDesc: { type: "string" },
			lotCreatorId: { type: "string" },
			lotCreatedAt: { type: "string" },
			lotUpdatorId: { type: "string" },
			lotUpdatedAt: { type: "string" },
			prodPlanYear: { type: "string" }
		}
	};
	
	var monthDataCol = {title: lfo_dateBox.yearVal, columns: []};	
	lfo_dateBox.monthArray.forEach(function(item){
		lfo_common.model.fields["planQty"+item] = { type: "int" };
		lfo_common.model.fields["workQty"+item] = { type: "int" };
		
		monthDataCol.columns.push({
			title: item , 
			columns: [
				{field: "planQty"+item, format: "{0:n0}", title: gfn_getMsg("col_planQuan"), attributes:{"class":"planCol","planAttr":lfo_dateBox.yearVal+"_"+item}, width: "87px"},			//계획량
				{field: "workQty"+item, format: "{0:n0}", title: gfn_getMsg("col_prodQuan"), width: "87px"}																					//생산량
			]
		});
	});
	
	//6.
	lfo_common.columns = [
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "180px", locked: true},								//수주코드
		//2020.05.14|ymlee|수주명 주석(신명기계 사용x)
		/* {field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "300px"},											//수주명 */
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "180px", locked: true},									//Lot코드
		//2020.05.14|ymlee|LoT명 주석(신명기계 사용x)
		/* {field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "300px"},											//Lot명 */
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "180px", locked: true},												//부품코드
		{field: "itemNm", format: "{0:n0}", title:gfn_getMsg("col_itemNm"), width: "230px", locked: true},							//부품명
		{field: "itemDeduction", title:gfn_getMsg("col_deduction"), width: "120px", locked: true},									//공제량
		{field: "itemDayTarget", title:gfn_getMsg("col_dayTarget"), width: "120px", locked: true},									//일일목표량
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "120px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "120px"},			//납기일
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title:gfn_getMsg("col_orderStatus"), width: "120px"},													//수주상태
		{field: "lotQty", format: "{0:n0}", title:gfn_getMsg("col_lotQty"), width: "120px"},							//Lot수량
		{field: "planTotalQty", format: "{0:n0}", title:gfn_getMsg("col_totalPlanQuan"), width: "120px"},				//총계획량
		{field: "workTotalQty", format: "{0:n0}", title:gfn_getMsg("col_totalProdQuan"), width: "120px"},				//총생산량
		monthDataCol,
		{field: "lotDesc", title:gfn_getMsg("col_desc"), width: "300px"}												//설명
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" },					//부품명
		{ text: gfn_getMsg("col_lotCd"), value: "lotCal.lotId" },					//LoT코드
		{ text: gfn_getMsg("col_orderCd"), value: "orderInfo.order_id" }			//수주코드
		/* { text: gfn_getMsg("col_orderNm"), value: "orderInfo.order_nm" }, */
		/* { text: gfn_getMsg("col_lotWrkNm"), value: "lotCal.lotNm" } */
	];
	
	//8.
	lfo_common.validation ={
		prodPlanQty:{
			messages : "계획량을 입력하세요",
			rules : function(input){
				if(input.is("[name=prodPlanQty]")){
					return input.val().length != 0;
				}
				return true;
			}
		}
	}
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	//계획량 더블클릭(팝업 오픈)
	$("#jteSingleGrid tbody").on("dblclick", ".planCol", function(e){
		var rowData= lfo_common.grid.dataItem($(e.target).closest('tr'));
		lfn_jtePop_open(rowData,$(this).attr("planAttr"));
	});
}

//Day - grid 생성
this.lfn_jteDbGrd_setGrd = function(){
	//lfo_common = {};//Form 내부에서 사용될 Object	
	//1.
	lfo_common.layoutId = "jteDoubleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mfgMgt/mfgplanMgt/mfgplan";
	
	//CUD 커스텀 진행
	lfo_common.crud  = {
		read:{url:"/getDayPlanList", auth:"", prmt:{calPrmt : lfo_dateBox.dayArray, calYear : lfo_dateBox.yearVal, calMonth : lfo_dateBox.monthVal, lotState : lfo_dateBox.lotState}}, 
	};
	
	//5.
	lfo_common.model = {
			id: "orderId",
			fields: {
				orderId: { type: "string" },
				orderNm: { type: "string" },
				orderStdt: { type: "date" },
				orderEddt: { type: "date" },
				description: { type: "string" },
				lotId: { type: "string" },
				lotNm: { type: "string" },
				itemId: { type: "string" },
				itemNm: { type: "string" },
				itemDeduction: { type: "int" },
				itemDayTarget: { type: "int" },
				lotState: { type: "string" },
				lotQty: { type: "int" },
				lotDesc: { type: "string" },
				lotCreatorId: { type: "string" },
				lotCreatedAt: { type: "string" },
				lotUpdatorId: { type: "string" },
				lotUpdatedAt: { type: "string" },
				prodPlanYear: { type: "string" },
				prodPlanMonth: { type: "string" }
			}
		};
	
	var dayDataCol = {title: lfo_dateBox.yearVal+'-'+lfo_dateBox.monthVal, columns: []};
	lfo_dateBox.dayArray.forEach(function(item){
		var week = new Date(lfo_dateBox.yearVal+'-'+lfo_dateBox.monthVal+'-'+item).getDay();
		lfo_common.model.fields["planQty"+item] = { type: "int" };
		lfo_common.model.fields["workQty"+item] = { type: "int" };
		
		dayDataCol.columns.push({
			title: item , 
			columns: [
				{field: "planQty"+item, format: "{0:n0}", title: gfn_getMsg("col_planQuan"),						//계획량
					attributes:{"class":"planCol","planAttr":lfo_dateBox.yearVal + "_"+lfo_dateBox.monthVal+"_"+item}, width: "87px"},
				{field: "workQty"+item, format: "{0:n0}", title: gfn_getMsg("col_prodQuan"), width: "87px"}			//생산량
			],
			headerAttributes :  week == 0 ? {style:"color:red;"} : week == 6 ? {style:"color:blue;"} : {} 
		});
	});
	
	//6.
	lfo_common.columns = [
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "180px", locked: true},											//수주코드
		/* {field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "300px"},											//수주명 */
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "180px", locked: true},												//Lot코드
		/* {field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "300px"},												//Lot명 */
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "180px", locked: true},												//부품코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "230px", locked: true},												//부품명
		{field: "itemDeduction",format: "{0:n0}" , title:gfn_getMsg("col_deduction"), width: "120px", locked: true},					//공제량
		{field: "itemDayTarget",format: "{0:n0}" , title:gfn_getMsg("col_dayTarget"), width: "120px", locked: true},					//itemDayTarget
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "120px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "120px"},			//납기일
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title:gfn_getMsg("col_orderStatus"), width: "120px"},										//수주상태
		{field: "lotQty", format: "{0:n0}", title:gfn_getMsg("col_lotQty"), width: "120px"},							//Lot수량
		{field: "planTotalQty", format: "{0:n0}", title:gfn_getMsg("col_totalPlanQuan"), width: "120px"},				//총계획량
		{field: "workTotalQty", format: "{0:n0}", title:gfn_getMsg("col_totalProdQuan"), width: "120px"},				//총생산량
		dayDataCol,
		{field: "lotDesc", title:gfn_getMsg("col_desc"), width: "300px"}												//설명
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_orderCd"), value: "orderInfo.order_id" },			//수주코드
		/* { text: gfn_getMsg("col_orderNm"), value: "orderInfo.order_nm" },			//수주명 */
		{ text: gfn_getMsg("col_lotCd"), value: "lotCal.lotId" },					//Lot코드
		/* { text: gfn_getMsg("col_lotWrkNm"), value: "lotCal.lotNm" }					//Lot명 */
	];
	
	//8.
	lfo_common.validation ={
		prodPlanQty:{
			messages : "계획량을 입력하세요",
			rules : function(input){
				if(input.is("[name=prodPlanQty]")){
					return input.val().length != 0;
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	//계획량 더블클릭(팝업 오픈)
	$("#jteDoubleGrid tbody").on("dblclick", ".planCol", function(e){
		var rowData= lfo_common.grid.dataItem($(e.target).closest('tr'));
		lfn_jtePop_open(rowData, $(this).attr("planAttr"));
	});
}

//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(selectedItem,selectedDate){
	var options = {
			modal:true, 
			id : lfo_common.popId, 
			title : selectedDate + " " + gfn_getMsg("pop_planQuanInput"),			//계획량 입력
			workCd : lfo_dateBox.chkVal, 
			bdSeq : "",
			resizable : true,
			animation : {open :{effects:"expand:vertical fadeIn"},
			close : {effects:"expand:vertical fadeIn", reverse: true}},
			actions : [/*"Minimize", "Maximize", */"Close"]
	};
	switch (lfo_dateBox.chkVal) {
	case "month" :
	//20.05.11|ymlee|계획량등록팝업 한눈에 보이도록 조정
		options.width = "510px"; /** 20.08.06 JJW 450-> 510 **/
		options.height = "395px"; /** 20.08.06 JJW 380-> 395 **/
		selectedItem.prodPlanType = "prod_plan01";
		selectedItem.prodPlanYear = selectedDate.split("_")[0];
		selectedItem.prodPlanMonth = selectedDate.split("_")[1];
	break;
	
	case "day" :
		options.width = "510px"; /** 20.08.06 JJW 450-> 510 **/
		options.height = "400px"; /** 20.08.06 JJW 400 **/
		selectedItem.prodPlanType = "prod_plan02";
		selectedItem.prodPlanYear = selectedDate.split("_")[0];
		selectedItem.prodPlanMonth = selectedDate.split("_")[1];
		selectedItem.prodPlanDay = selectedDate.split("_")[2];
	break;
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//탭 메뉴
		$("#jtePopForm").kendoTabStrip({
			animation:  {
				open: {
					effects: "fadeIn"
				}
			}
		});
		//첫번째 탭 선택
		var tabStrip = $("#jtePopForm").kendoTabStrip().data("kendoTabStrip");
		tabStrip.select(0);
		
		//생산계획 세팅 
		lfn_jtePop_set("EDT", selectedItem);
		
	};
	this.gfn_winOpen(options);
}


//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = {};
	
	if(typeof(selectedItem) == "object"){
		lfo_common.gridSelected = selectedItem;
	}else if(typeof(selectedItem) == "string"){
		lfo_common.gridSelected.prodPlanId = selectedItem;
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getPlanDetail",
		type: "POST",
		data: JSON.stringify(lfo_common.gridSelected),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//검색결과 오브젝트에 담아두기
			lfo_common.gridSelected = data.rows[0];
			
			//검색결과 pop화면 세팅
			gfn_popform_set(lfo_common, mode, lfo_common.gridSelected);
			
			//등록, 수정여부를 쿼리에서 판단해서 가져온다.
			$("#"+lfo_common.popId+" [name=action]").val(lfo_common.gridSelected.action);
			
			//일괄처리 세팅
			lfn_jteBulkPop_set();
			
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	//기본적인 정보는 불러오고 계획량이 없는경우 쿼리에서 C 액션값을 불러옴.
	if(lfo_common.gridSelected.action == "C"){
		$("#"+lfo_common.popId+" [name=prodPlanType]").val(selectedItem.prodPlanType);
		
		//계획량등록이 되어 있지 않고 일간계획인 경우 계획량에 일일목표량을 입력해준다.
		if(selectedItem.prodPlanType=="prod_plan02"){
			$("#dayTargetArea").show();
		}
	}else{
		//일간계획인경우
		if(lfo_common.gridSelected.prodPlanType=="prod_plan02"){
			
			$("#dayTargetArea").show();
			
			//pop화면 리사이즈
			//20.05.11|ymlee|지시화면 한눈에 보이도록 조정
			gfn_resizePop(lfo_common.popId,{height : 625, width: 730})
			
			//생산지시열어주기
			$("#asgnInfo").show();
			//그리드 세팅
			if($("#jtePopForm_grid").html() ==""){
				lfn_jtePopGrd_setGrd();
			}else{
				lfo_popGrd.grid.dataSource.read();
			}
		}
	}
	//저장이벤트 커스텀 바인딩
	var event = $._data($("#"+lfo_common.popId+" .jte-save")[0],"events")
	if(gfn_isEmpty(event) || !event.click){
		$("#"+lfo_common.popId+" .jte-save").on('click',function(){
			lfn_popSave();
		});
	}
}

//일괄처리 영역  세팅
this.lfn_jteBulkPop_set = function(){
	
	//등록/삭제 변경 이벤트 
	$("#jtePopForm_tab [name=bulkType]").change(function(){
		lfn_bulkType_change();
	});
	
	//등록/삭제 변경 이벤트 
	$("#jtePopForm_tab [name=bulkTarget]").change(function(){
		lfn_bulkTarget_change();
	});
	
	//등록기간 직접 지정 
	$("#jtePopForm_tab [name=bulkPeriod]").change(function(){
		lfn_bulkPeriod_change();
	});
	
	//최초 실행
	lfn_bulkType_change();

	
	//날짜 포맷 세팅
	switch (lfo_dateBox.chkVal) {
	case "month" :
		$("#jtePopForm_tab [name=baseDate]").kendoDatePicker({
			culture:"ko-KR",
			depth: "year",
			start: "year",
			format: "yyyy-MM",
			change : function(){
				//일괄처리 데이터가 있는지 조회
				lfn_bulkDate_pos();
			}
		});
		$("#jtePopForm_tab [name=bulkStdt]").kendoDatePicker({
			culture:"ko-KR",
			depth: "year",
			start: "year",
			format: "yyyy-MM"
		});
		
		$("#jtePopForm_tab [name=bulkEddt]").kendoDatePicker({
			culture:"ko-KR",
			depth: "year",
			start: "year",
			format: "yyyy-MM"
		});
		
		//기준날짜날짜 세팅
		$("#jtePopForm_tab [name = baseDate]").data("kendoDatePicker").value(lfo_common.gridSelected.prodPlanYear+"-"+lfo_common.gridSelected.prodPlanMonth);
		
		//월간 데이터 세팅
		$("#jtePopForm_tab [name = prodPlanType]").val("prod_plan01");
		
		//계획/지시/작업 정보 체크박스 
		$("#jtePopForm_tab .bulkTargetArea").hide();
	break;
	case "day" :
		$("#jtePopForm_tab [name=baseDate]").kendoDatePicker({
			culture:"ko-KR",
			format: "yyyy-MM-dd",
			change : function(){
				//일괄처리 데이터가 있는지 조회
				lfn_bulkDate_pos();
			}
		});
		
		$("#jtePopForm_tab [name=bulkStdt]").kendoDatePicker({
			culture:"ko-KR",
			format: "yyyy-MM-dd"
		});
		
		$("#jtePopForm_tab [name=bulkEddt]").kendoDatePicker({
			culture:"ko-KR",
			format: "yyyy-MM-dd"
		});
		
		//기준날짜날짜 세팅
		$("#jtePopForm_tab [name = baseDate]").data("kendoDatePicker").value(lfo_common.gridSelected.prodPlanYear+"-"+lfo_common.gridSelected.prodPlanMonth+"-"+lfo_common.gridSelected.prodPlanDay);
		
		//일간 데이터 세팅
		$("#jtePopForm_tab [name = prodPlanType]").val("prod_plan02");
		
		//계획/지시/작업 정보 체크박스 (일단 숨김처리)
		$("#jtePopForm_tab .bulkTargetArea").hide();
	break;
	}
	
	//LOTID
	$("#jtePopForm_tab [name=lotId]").val(lfo_common.gridSelected.lotId);
	
	//prodPlanId
	$("#jtePopForm_tab [name=prodPlanId]").val(lfo_common.gridSelected.prodPlanId);
	
	//일괄처리 데이터가 있는지 조회
	lfn_bulkDate_pos();
}

//일괄처리 등록/삭제 라디오버튼
this.lfn_bulkType_change = function(){
	var rdoChkVal = $("#jtePopForm_tab [name=bulkType]:checked").val();
	if(rdoChkVal=="ins"){
		$("#jtePopForm_tab .jte-bulk-save").show();
		$("#jtePopForm_tab .jte-bulk-delete").hide();
		$("#jtePopForm_tab .baseDateArea").show();
		
		// 기간 직접 입력 체크
		$("#bulkPeriodChkArea").show();
		lfn_bulkPeriod_change();
	}else if(rdoChkVal=="del"){
		$("#jtePopForm_tab .jte-bulk-save").hide();
		$("#jtePopForm_tab .jte-bulk-delete").show();
		$("#jtePopForm_tab .baseDateArea").hide();
		$("#jtePopForm_tab .bulkTargetArea").hide();
		$("#bulkPeriodChkArea").hide();
		$("#bulkPeriodArea").show();
	}
}

//일괄처리 데이터가 있는지 조회
this.lfn_bulkDate_pos = function(){
	var baseDate = $("#jtePopForm_tab [name = baseDate]").val();
	var planType = $("#jtePopForm_tab [name = prodPlanType]").val();
	
	$("#jtePopForm_tab [name=hidBulkPlanYN]").val("");
	$("#jtePopForm_tab [name=hidBulkAsgnYN]").val("");
	$("#jtePopForm_tab [name=hidBulkWorkYN]").val("");
	
	var prodPlanDate = [];
	if(planType == "prod_plan01"){
		prodPlanDate =  baseDate.split("-");
		$("#jtePopForm_tab [name = prodPlanYear]").val(prodPlanDate[0]);
		$("#jtePopForm_tab [name = prodPlanMonth]").val(prodPlanDate[1]);
	}else if(planType == "prod_plan02"){
		prodPlanDate =  baseDate.split("-");
		$("#jtePopForm_tab [name = prodPlanYear]").val(prodPlanDate[0]);
		$("#jtePopForm_tab [name = prodPlanMonth]").val(prodPlanDate[1]);
		$("#jtePopForm_tab [name = prodPlanDay]").val(prodPlanDate[2]);
	}
	
	var searchPrmt = gfn_serializeObject("jtePopForm_tab");
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getBulkPos",
		type: "POST",
		data: JSON.stringify(searchPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != null){
				var resltRows = data.rows;
				if(!gfn_isNull(resltRows)){
					if(planType == "prod_plan01"){
						if(!gfn_isEmpty(resltRows.planCnt) && resltRows.planCnt > 0){
							$("#jtePopForm_tab [name=hidBulkPlanYN]").val("Y");
						}else{
							$("#jtePopForm_tab [name=hidBulkPlanYN]").val("N");
						}
					}else if(planType == "prod_plan02"){
						if(!gfn_isEmpty(resltRows.planCnt) && resltRows.planCnt > 0){
							$("#jtePopForm_tab [name=hidBulkPlanYN]").val("Y");
						}else{
							$("#jtePopForm_tab [name=hidBulkPlanYN]").val("N");
						} 
						if(!gfn_isEmpty(resltRows.asgnCnt) && resltRows.asgnCnt > 0){
							$("#jtePopForm_tab [name=hidBulkAsgnYN]").val("Y");
						}else{
							$("#jtePopForm_tab [name=hidBulkAsgnYN]").val("N");
						} 
						if(!gfn_isEmpty(resltRows.workCnt) && resltRows.workCnt > 0){
							$("#jtePopForm_tab [name=hidBulkWorkYN]").val("Y");
						}else{
							$("#jtePopForm_tab [name=hidBulkWorkYN]").val("N");
						}
					}
				}
				// 타겟 체크박스에 따른 데이터가 있는지 확인
				lfn_bulkTarget_change();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//타겟 체크박스에 따른 데이터가 있는지 체크
this.lfn_bulkTarget_change = function(){
	var planType = $("#jtePopForm_tab [name = prodPlanType]").val();
	var flag = false;
	if(planType == "prod_plan01"){
		if($("#jtePopForm_tab [name = hidBulkPlanYN]").val() == "Y"){
			$("#jtePopForm_tab [name = hidBulkPos]").val("Y");
			$("#jtePopForm_tab [name = bulkPos]").text("가능");
		}else{
			$("#jtePopForm_tab [name = hidBulkPos]").val("N");
			$("#jtePopForm_tab [name = bulkPos]").text("불가능");
			return false;
		}
	}else if(planType == "prod_plan02"){
		//생산계획 체크
		if(!gfn_isNull($("#bulkPlan:checked").val())){
			if($("#jtePopForm_tab [name = hidBulkPlanYN]").val() == "Y"){
				$("#jtePopForm_tab [name = hidBulkPos]").val("Y");
				$("#jtePopForm_tab [name = bulkPos]").text("가능");
			}else{
				$("#jtePopForm_tab [name = hidBulkPos]").val("N");
				$("#jtePopForm_tab [name = bulkPos]").text("불가능");
				return false;
			}
		}
		//생산지시 체크
		if(!gfn_isNull($("#bulkAsgn:checked").val())){
			if($("#jtePopForm_tab [name = hidBulkAsgnYN]").val() == "Y"){
				$("#jtePopForm_tab [name = hidBulkPos]").val("Y");
				$("#jtePopForm_tab [name = bulkPos]").text("가능");
			}else{
				$("#jtePopForm_tab [name = hidBulkPos]").val("N");
				$("#jtePopForm_tab [name = bulkPos]").text("불가능");
				return false;
			}
		}
		//작업지시 체크
		if(!gfn_isNull($("#bulkWork:checked").val())){
			if($("#jtePopForm_tab [name = hidBulkWorkYN]").val() == "Y"){
				$("#jtePopForm_tab [name = hidBulkPos]").val("Y");
				$("#jtePopForm_tab [name = bulkPos]").text("가능");
			}else{
				$("#jtePopForm_tab [name = hidBulkPos]").val("N");
				$("#jtePopForm_tab [name = bulkPos]").text("불가능");
				return false;
			}
		}
	}
}

//기간직접입력 체크
this.lfn_bulkPeriod_change = function(){
	var bulkPeriodChk = $("#jtePopForm_tab [name = bulkPeriod]:checked").val();
	if(!gfn_isNull(bulkPeriodChk)){
		$("#jtePopForm_tab [name = bulkPeriodYN]").val("Y");
		$("#jtePopForm_tab [name = bulkStdt]").val("");
		$("#jtePopForm_tab [name = bulkEddt]").val("");
		$("#bulkPeriodArea").show();
	}else{
		$("#jtePopForm_tab [name = bulkPeriodYN]").val("N");
		$("#bulkPeriodArea").hide();
	}
}

//일괄처리 저장
this.lfn_bulk_save = function(){
	if($("#jtePopForm_tab [name = hidBulkPos]").val() == "Y"){
		var savePrmt = gfn_serializeObject("jtePopForm_tab");
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setBulkSave",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != null){
					if(data.result == "success"){
						
						gfn_closePop(lfo_common.popId);
						
						gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
						
						//그리드 리로드
						lfo_common.grid.dataSource.read();
						
					}else{
						switch (data.result) {
							case "bulk_plan_err01" :
								gfn_warnBox({msg : "복사할 데이터가 존재하지 않습니다."});
							break;
							
							case "bulk_plan_err02" :
								gfn_warnBox({msg : "기간내에 등록된 데이터가 있습니다."});
							break;
							
							default:
								gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
						}
					}
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}else{
		gfn_warnBox({msg : "복사할 데이터가 존재하지 않습니다."});
	}	
}

//일괄처리 삭제
this.lfn_bulk_delete = function(){
	var deletePrmt = gfn_serializeObject("jtePopForm_tab");
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/setBulkDelete",
		type: "POST",
		data: JSON.stringify(deletePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != null){
				if(data.result == "success"){
					gfn_closePop(lfo_common.popId);
				
					gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});
					
					//그리드 리로드
					lfo_common.grid.dataSource.read();
					
				}else{
					switch (data.result) {
						case "bulk_planDelete_err01" :
							gfn_warnBox({msg : "생산계획 등록 오류입니다."});
						break;
						case "bulk_planDelete_err02" :
							gfn_warnBox({msg : "생산지시 등록 오류입니다."});
						break;
						case "bulk_planDelete_err03" :
							gfn_warnBox({msg : "작업지시 등록 오류입니다. 작업이 시작된 데이터는 삭제가 불가능합니다."});
						break;
						default:
							gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
					}
				}
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//pop 저장
this.lfn_popSave = function(){
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		var savePrmt = gfn_serializeObject(lfo_common.popId+"_form");
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setPlanCnt",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업 재설정
					lfn_jtePop_set("EDT",data)
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					//그리드 리로드
					lfo_common.grid.dataSource.read();
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	lfo_popGrd.popId = "jteProdAsgnPop";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/mfgMgt/wrkinTeamMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getAsgnList", auth:"", prmt:{
			prodPlanId : lfo_common.gridSelected.prodPlanId, 
			prodPlanYear : lfo_common.gridSelected.prodPlanYear, 
			prodPlanMonth : lfo_common.gridSelected.prodPlanMonth, 
			prodPlanDay : lfo_common.gridSelected.prodPlanDay}
		}, 
		create:{url:"/setAsgnSave", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback : lfn_jtePopGrd_save},
		update:{url:"/setAsgnSave", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback: lfn_jtePopGrd_save},
		destroy:{url:"/setAsgnDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "prodAsmId",
		fields: {
			orderId: { type: "string" },
			lotId: { type: "string" },
			lotNm: { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			prodPlanId: { type: "string" },
			prodPlanYear: { type: "int" },
			prodPlanMonth: { type: "int" },
			prodPlanDay: { type: "int" },
			prodPlanQty: { type: "int" },
			prodPlanDesc: { type: "string" },
			prodAsmId: { type: "string" },
			prodAsmNm: { type: "string" },
			prodAsmDate: { type: "date" },
			prodAsmQty: { type: "int" },
			prodAsmDesc: { type: "string" },
			prodAsmUser: { type: "string" },
			prodAsmUserNm: { type: "string" },
			prodAsmEmj: { type: "string" },
			prodAsmState: { type: "string" },
			createdAt: { type: "date" },
			creatorId: { type: "string" },
			deptId: { type: "string" },
			deptNm: { type: "string" }
// 			prodWorkId: { type: "string" },
// 			routingId: { type: "string" },
// 			routingSeq: { type: "int" },
// 			processId: { type: "string" },
// 			processNm: { type: "string" },
// 			eqmtMgtId: { type: "string" },
// 			eqmtMgtNm: { type: "string" },
// 			prodWorkUser: { type: "string" },
// 			prodWorkUserNm: { type: "string" },
// 			prodWorkQty: { type: "int" },
// 			prodWorkGood: { type: "int" },
// 			prodWorkBad: { type: "int" },
// 			prodWorkStart: { type: "date" },
// 			prodWorkEnd: { type: "date" },
// 			planAction: { type: "string" },
// 			workAction: { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		//{selectable : true, width:"50px"},
		//{field: "prodAsmUserNm", title:"지시자", width: 110},
		//2020.05.14|ymlee|작업지시명 주석(신명기계 사용x)
		/* {field: "prodAsmNm", title:gfn_getMsg("col_workOrderNm"), width: 150},*/
		{field: "prodAsmId", title:gfn_getMsg("col_workOrderCd"), width: "160px"},			//작업지시코드
		//{field: "prodAsmUserNm", title:gfn_getMsg("col_workOrderUser"), width: 110},
		{field: "prodAsmEmj", template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #",
			title:gfn_getMsg("col_prodEmj"), width: "110px"},								//긴급여부
		{field: "prodAsmQty", title:gfn_getMsg("col_asmQuan"), width: "110px"},				//지시량
		{field: "prodAsmState", template:"# var item = gfn_isNull(gfn_getCode(prodAsmState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmState).cdId , gfn_getCode(prodAsmState).cdNm) # #= item #",
				title:gfn_getMsg("col_workStatus"), width: "130px"},						//작업상태
		//{field: "deptNm", title:gfn_getMsg("col_deptNm"), width: 120},
		{field: "prodAsmDesc", title:gfn_getMsg("col_desc"), width: "250px"}				//설명
// 		{field: "prodWorkId", title:"작업정보코드", width: 120},
// 		{field: "routingId", title:"라우팅코드", width: 120},
// 		{field: "processNm", title:"공정명", width: 120},
// 		{field: "eqmtMgtNm", title:"설비명", width: 120},
// 		{field: "prodWorkUserNm", title:"작업자", width: 120},
// 		{field: "prodWorkGood", title:"생산량", width: 120},
// 		{field: "prodWorkBad", title:"불량량", width: 120},
// 		{field: "prodWorkStart", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"작업시작", width: 120},
// 		{field: "prodWorkEnd", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"작업종료", width: 120}
	];
	
	//7.
	lfo_popGrd.selectBox = [
		/* { text: gfn_getMsg("col_workOrderNm"), value: "asgn.prod_asm_nm" },			//작업지시명 */
		{ text: gfn_getMsg("col_workOrderCd"), value: "asgn.prod_asm_id" },			//작업지시코드
		{ text: gfn_getMsg("col_desc"), value: "asgn.prod_asm_desc" }				//설명
	];
	
	//8.
	lfo_popGrd.validation ={
		prodAsmQty:{
			messages : "지시량을 입력하세요",
			rules : function(input){
				if(input.is("[name=prodAsmQty]")){
					return input.val().length != 0;
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

//생산지시 팝업
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "560px", //200520 JJW 550 -> 560
		height: "330px", //200520 JJW 265 -> 330
		id : lfo_popGrd.popId, 
		title : gfn_getMsg("pop_workAsm"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}


//팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	lfo_popGrd.gridSelected = {};
	if(mode=='NEW'){
		//팝업 기본정보 세팅
		lfo_popGrd.gridSelected={ 
			prodPlanId : lfo_common.gridSelected.prodPlanId, 
			prodPlanYear : lfo_common.gridSelected.prodPlanYear, 
			prodPlanMonth : lfo_common.gridSelected.prodPlanMonth, 
			prodPlanDay : lfo_common.gridSelected.prodPlanDay,
			itemId : lfo_common.gridSelected.itemId,
			itemNm : lfo_common.gridSelected.itemNm
		};
		
		//팝업 세팅 로드
		gfn_popform_set(lfo_popGrd, mode, lfo_popGrd.gridSelected);
	}else if(mode == 'EDT'){
		lfo_popGrd.gridSelecte ={
			prodPlanId : lfo_common.gridSelected.prodPlanId, 
			prodPlanYear : lfo_common.gridSelected.prodPlanYear, 
			prodPlanMonth : lfo_common.gridSelected.prodPlanMonth, 
			prodPlanDay : lfo_common.gridSelected.prodPlanDay,
			lotId : lfo_common.gridSelected.lotId
		}
		
		//데이터 저장시 pk가 콜백이 되기 때문에 pk매핑은 별도로 처리
		if(typeof(selectedItem) == "object"){
			lfo_popGrd.gridSelected.prodAsmId = selectedItem.prodAsmId;
		}else if(typeof(selectedItem) == "string"){
			lfo_popGrd.gridSelected.prodAsmId = selectedItem;
		}
		
		//팝업내용 조회
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + "/getAsgnPop",
			type: "POST",
			data: lfo_popGrd.gridSelected,
			success: function(data){
				lfo_popGrd.gridSelected = data.rows[0];
				//팝업 세팅 로드
				gfn_popform_set(lfo_popGrd, mode, data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		
		
		//팝업창 리사이즈
		gfn_resizePop(lfo_popGrd.popId,{height : 520, width: 650});
		
		//라우팅,설비, 작업자 지정 영역 열어주기
		$("#prodWorkInfo").show();
		//그리드 세팅
		if($("#jteProdAsgnPop_gird").html() ==""){
			lfn_jteProdWorkGrd_setGrd();
		}else{
			lfo_prodWorkGrd.grid.dataSource.read();
		}
	}
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(savePrmt){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		var savePrmt = gfn_serializeObject(lfo_popGrd.popId+"_form");
		
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.create.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//이전화면 리로드
					lfo_common.grid.dataSource.read();
					lfo_popGrd.grid.dataSource.read();
					
					//이전 팝업화면 리로드
					lfn_jtePopGrd_popSet('EDT',data);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}
//삭제 콜백
this.lfn_jtePopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_popGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_popGrd.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}


//라우팅,설비지정 그리드 그려주기. 
this.lfn_jteProdWorkGrd_setGrd = function(){
	lfo_prodWorkGrd = {};
	
	//1.
	lfo_prodWorkGrd.layoutId = "jteProdAsgnPop_gird";
	
	//2.
	lfo_prodWorkGrd.popId = "jteProdProdWorkPop";
	
	//3.
	lfo_prodWorkGrd.ctrlUrl = "/cform/mfgMgt/wrkinWrkerMgt"
	2
	//4.
	lfo_prodWorkGrd.crud  = {
		read:{url:"/getProdWorkList", auth:"", prmt:{
			prodPlanId : lfo_popGrd.gridSelected.prodPlanId,
			prodAsmId : lfo_popGrd.gridSelected.prodAsmId,
			prodPlanYear : lfo_popGrd.gridSelected.prodPlanYear, 
			prodPlanMonth : lfo_popGrd.gridSelected.prodPlanMonth, 
			prodPlanDay : lfo_popGrd.gridSelected.prodPlanDay}
		}, 
		create:{url:"/setProdWorkSave", auth:"", openFunc : lfn_jteProdWork_popOpen, callback : lfn_jteProdWork_save},
		update:{url:"/setProdWorkSave", auth:"", openFunc : lfn_jteProdWork_popOpen, callback: lfn_jteProdWork_save},
		destroy:{url:"/setProdWorkDelete", auth:"", callback:lfn_jteProdWork_delete}
	};
	
	//5.
	lfo_prodWorkGrd.model = {
		id: "prodWorkId",
		fields: {
			orderId: { type: "string" },
			lotId: { type: "string" },
			lotNm: { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			prodPlanId: { type: "string" },
			prodPlanYear: { type: "int" },
			prodPlanMonth: { type: "int" },
			prodPlanDay: { type: "int" },
			prodPlanQty: { type: "int" },
			prodPlanDesc: { type: "string" },
			prodAsmId: { type: "string" },
			prodAsmNm: { type: "string" },
			prodAsmDate: { type: "date" },
			prodAsmQty: { type: "int" },
			prodAsmDesc: { type: "string" },
			prodAsmUser: { type: "string" },
			prodAsmUserNm: { type: "string" },
			prodAsmEmj: { type: "string" },
			prodAsmState: { type: "string" },
			createdAt: { type: "date" },
			creatorId: { type: "string" },
			deptId: { type: "string" },
			deptNm: { type: "string" },
			prodWorkId: { type: "string" },
			routingId: { type: "string" },
			routingSeq: { type: "int" },
			routingType: { type: "string" },
			eqmtMgtId: { type: "string" },
			eqmtMgtNm: { type: "string" },
			prodWorkUser: { type: "string" },
			prodWorkUserNm: { type: "string" },
			prodWorkQty: { type: "int" },
			prodWorkGood: { type: "int" },
			prodWorkBad: { type: "int" },
			prodWorkStart: { type: "date" },
			prodWorkEnd: { type: "date" },
			prodWorkDesc: { type: "string" },
			planAction: { type: "string" },
			workAction: { type: "string" }
		}
	};
	
	//6.
	lfo_prodWorkGrd.columns = [
		//{selectable : true, width:"50px"},
// 		{field: "prodAsmNm", title:"생산지시명", width: 150},
// 		{field: "prodAsmId", title:"생산지시코드", width: 150},
// 		{field: "prodAsmUserNm", title:"지시자", width: 110},
// 		{field: "prodAsmEmj", title:"긴급여부", width: 100},
// 		{field: "prodAsmState", title:"상태", width: 100},
// 		{field: "deptNm", title:"부서명", width: 120},
 		//{field: "prodAsmId", title:"생산지시코드", width: 150},
		//{field: "prodAsmDesc", title:"생산지시 비고", width: 300},
		{field: "prodWorkId", title:gfn_getMsg("col_workInfoCd"), width: "160px"},												//작업정보코드
		{field: "routingId", title:gfn_getMsg("col_routCd"), width: "180px"},													//라우팅코드
		{field: "routingSeq", format:"{0:n0}",title:gfn_getMsg("col_routSeq"), width: "100px"},									//차수
		{field: "routingType", template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
				title:gfn_getMsg("col_routType"), width: "110px"},																//공정유형
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: "160px"},												//설비명
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "130px"},												//작업자
		{field: "prodWorkQty", format:"{0:n0}", title:gfn_getMsg("col_asmQuan"), width: "110px"},								//지시량
		{field: "prodWorkGood", format:"{0:n0}", title:gfn_getMsg("col_prodQuan"), width: "110px"},								//양품량
		{field: "prodWorkBad", format:"{0:n0}", title:gfn_getMsg("col_badProdQuan"), width: "110px"},							//불량량
		{field: "prodWorkStart", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_workStart"), width: "160px"},			//작업시작
		{field: "prodWorkEnd", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_workEnd"), width: "160px"},				//작업종료
		{field: "prodWorkDesc", title:gfn_getMsg("col_desc"), width: "250px"}													//설명
	];
	
	//7.
	lfo_prodWorkGrd.selectBox = [
		{ text: gfn_getMsg("col_worker"), value: "w_usr.user_nm" },					//작업자
		{ text: gfn_getMsg("col_workInfoCd"), value: "wok.prod_work_id" },			//작업정보코드
		{ text: gfn_getMsg("col_desc"), value: "wok.prod_work_desc" }				//비고
	];
	
	//8.
	lfo_prodWorkGrd.validation ={
		prodWorkQty:{
			messages : "지시량을 입력하세요",
			rules : function(input){
				if(input.is("[name=prodWorkQty]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		routingId:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=routingId]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 라우팅을 등록하세요");
						return false;
					}
				}
				return true;
			}
		},
		prodWorkUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=prodWorkUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 작업자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_prodWorkGrd.grid = gfn_grid_set(lfo_prodWorkGrd);
}


//설비, 라우팅 팝업
this.lfn_jteProdWork_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		//20.05.11|ymlee|팝업한눈에 들어오도록 조정
		width: "650px", 
		height: "400px", //200520 JJW 320-> 400
		id : lfo_prodWorkGrd.popId, 
		title : "작업 상세정보",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jteProdWork_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}


//설비, 라우팅 팝업 내용 세팅
this.lfn_jteProdWork_popSet = function(mode,selectedItem){
	lfo_prodWorkGrd.gridSelected = {};
	if(mode=='NEW'){
		//팝업 기본정보 세팅
		lfo_prodWorkGrd.gridSelected={ 
			prodPlanId : lfo_popGrd.gridSelected.prodPlanId, 
			prodPlanYear : lfo_popGrd.gridSelected.prodPlanYear, 
			prodPlanMonth : lfo_popGrd.gridSelected.prodPlanMonth, 
			prodPlanDay : lfo_popGrd.gridSelected.prodPlanDay,
			prodAsmId : lfo_popGrd.gridSelected.prodAsmId,
			itemId : lfo_popGrd.gridSelected.itemId,
			itemNm : lfo_popGrd.gridSelected.itemNm,
			lotId : lfo_popGrd.gridSelected.lotId
		};
		
		//팝업 세팅 로드
		gfn_popform_set(lfo_prodWorkGrd, mode, lfo_prodWorkGrd.gridSelected);
		//$(".adminWorkInputArea").hide();
	}else if(mode == 'EDT'){
		//팝업 내용 조회 파라미터 세팅
		lfo_prodWorkGrd.gridSelected={
			prodPlanId : lfo_popGrd.gridSelected.prodPlanId, 
			prodPlanYear : lfo_popGrd.gridSelected.prodPlanYear, 
			prodPlanMonth : lfo_popGrd.gridSelected.prodPlanMonth, 
			prodPlanDay : lfo_popGrd.gridSelected.prodPlanDay,
			prodAsmId : selectedItem.prodAsmId,
			prodWorkId : selectedItem.prodWorkId,
			lotId : lfo_popGrd.gridSelected.lotId
		}
		//팝업내용 조회
		$.ajax({
			async:false,
			url : lfo_prodWorkGrd.ctrlUrl + "/getProdWorkPop",
			type: "POST",
			data: lfo_prodWorkGrd.gridSelected,
			success: function(data){
				//팝업 세팅 로드
				gfn_popform_set(lfo_prodWorkGrd, mode, data.rows[0]);
				//$(".adminWorkInputArea").show();
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//작업정보 Form내용 입력/저장
this.lfn_jteProdWork_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_prodWorkGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		var savePrmt = gfn_serializeObject(lfo_prodWorkGrd.popId+"_form");
		
		$.ajax({
			async:false,
			url : lfo_prodWorkGrd.ctrlUrl + lfo_prodWorkGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					// 이전 그리드 리로드
					lfo_popGrd.grid.dataSource.read();
					lfo_common.grid.dataSource.read();
					lfo_prodWorkGrd.grid.dataSource.read();
					
					//현재팝업 종료
					gfn_closePop(lfo_prodWorkGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}
//작업정보 삭제 콜백
this.lfn_jteProdWork_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_prodWorkGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_prodWorkGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_prodWorkGrd.ctrlUrl + lfo_prodWorkGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_prodWorkGrd.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}


//생산지시pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

//부서 수신자 - 유저정보 팝업 콜백
this.lfn_userInfoPop_callback = function(rtnObj){
	$("#" + lfo_popGrd.popId + " [name=prodAsmUser]").val(rtnObj["userId"]);
	$("#" + lfo_popGrd.popId + " [name=prodAsmUserNm]").val(rtnObj["userNm"]);
}

//생산지시pop - 부서정보 팝업 오픈
this.lfn_deptInfoPop_Open = function(call){
	gfn_openCustomPop('deptInfo',call);
}

//작업수행부서 지정 - 부서정보 팝업 콜백
this.lfn_deptInfoPop_callback = function(rtnObj){
	$("#" + lfo_popGrd.popId + " [name=deptId]").val(rtnObj["deptId"]);
	$("#" + lfo_popGrd.popId + " [name=deptNm]").val(rtnObj["deptNm"]);
}

//생산지시pop - 라우팅정보 팝업 오픈
this.lfn_routingPop_Open = function(call){
	//저장되어 있는 아이템 아이디
	var itemId = $("#" + lfo_prodWorkGrd.popId + " [name=itemId]").val();
	//아이템아이디가 없으면 조회불가
	if(!gfn_isNull(itemId)){
		gfn_openCustomPop('routing',call,{"itemId" : itemId});
	}else{
		alert("부품정보가 없습니다.");
	}
}


//작업자 지정 - 유저정보 팝업 콜백
this.lfn_prodWorkPop_callback = function(rtnObj){
	$("#" + lfo_prodWorkGrd.popId + " [name=prodWorkUser]").val(rtnObj["userId"]);
	$("#" + lfo_prodWorkGrd.popId + " [name=prodWorkUserNm]").val(rtnObj["userNm"]);
}

//작업라우팅 지정 - 라우팅정보 팝업 콜백
this.lfn_routingPop_callback = function(rtnObj){
	$("#" + lfo_prodWorkGrd.popId + " [name=routingId]").val(rtnObj["routingId"]);
	$("#" + lfo_prodWorkGrd.popId + " [name=routingType]").data("kendoDropDownList").select(function(dataItem) {
				return dataItem.cdId === rtnObj["routingType"];
		});
}

//생산지시pop - 설비정보 팝업 오픈
this.lfn_equipmentPop_Open = function(call){
	
	var routingId = $("#" + lfo_prodWorkGrd.popId + " [name=routingId]").val();
	if(gfn_isEmpty(gfn_getCode("devItem")) || lfo_popGrd.gridSelected.itemId != gfn_getCode("devItem").cdVal){
		//라우팅을 먼저지정해주지 않으면 선택불가능.
		if(!gfn_isNull(routingId)){
			gfn_openCustomPop('routingEquip',call, {"routingId":routingId});
		}else{
			alert("라우팅을 먼저 지정해주세요.")
		}
	}else{
		gfn_openCustomPop('eqmtMgt',call);
	}
	
}

//설비정보 지정 - 설비정보 팝업 콜백
this.lfn_equipmentPop_callback = function(rtnObj){
	$("#" + lfo_prodWorkGrd.popId + " [name=eqmtMgtId]").val(rtnObj["eqmtMgtId"]);
	$("#" + lfo_prodWorkGrd.popId + " [name=eqmtMgtNm]").val(rtnObj["eqmtMgtNm"]);
}

</script>