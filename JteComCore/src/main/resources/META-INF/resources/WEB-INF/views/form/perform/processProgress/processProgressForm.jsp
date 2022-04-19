 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 메인화면 -->
<div id="grid-content"  style="overflow:auto;">
	<div class="div-title">
		<span class="date-title">
			<span>지시일 : </span>
			<input id="prodAsmDate" name="prodAsmDate"/>
			<span>작업지시 : </span>
			<input id="prodAsmId" name="prodAsmId"/>
			<button class="k-button k-primary" onclick="lfn_full_open()">전체화면</button>
		</span>
		<span class="a-title">종합 현황판</span>
	</div>
	<div>
		<table class="monitoring_table" style="width: 100%;">
			<colgroup>
				<col style="width: 5%;"/>
				<col style="width: 23%;"/>
				<col style="width: 9%;"/>
				<col style="width: 9%;"/>
				<col style="width: 7%;"/>
				<col style="width: 9%;"/>
				<col style="width: 7%;"/>
				<col style="width: 13%;"/>
				<col style="width: 10%;"/>
				<col style="width: 8%;"/>
			</colgroup>
			<thead class="tr-title">
				<tr>
					<th>차수</th>
					<th>생산명(BOM)</th>
					<th>목표수량</th>
					<th>생산량</th>
					<th>달성률</th>
					<th>불량량</th>
					<th>불량률</th>
					<th>시작시간</th>
					<th>작업시간</th>
					<th>가동</th>
				</tr>
			</thead>
			<tbody id ="monitorBody">
			</tbody>
		</table>
	</div>
</div>

<!-- 전체화면 -->
<div style="display:none;">
	<div id="jtePopForm">
		<div>
			<span class="date-title"  style="margin:15px 10px;">
				<span>지시일 : </span>
				<input id="popProdAsmDate" name="popProdAsmDate"/>
				<span>작업지시 : </span>
				<input id="popProdAsmId" name="popProdAsmId"/>
				<button class="k-button k-primary" onclick="lfn_full_close()">전체화면 종료</button>
			</span>
		</div>
		<div>
			<table class="monitoring_table" style="width: 100%;">
				<colgroup>
					<col style="width: 5%;"/>
					<col style="width: 23%;"/>
					<col style="width: 9%;"/>
					<col style="width: 9%;"/>
					<col style="width: 7%;"/>
					<col style="width: 9%;"/>
					<col style="width: 7%;"/>
					<col style="width: 13%;"/>
					<col style="width: 10%;"/>
					<col style="width: 8%;"/>
				</colgroup>
				<thead class="tr-title">
					<tr>
						<th>차수</th>
						<th>생산명(BOM)</th>
						<th>목표수량</th>
						<th>생산량</th>
						<th>달성률</th>
						<th>불량량</th>
						<th>불량률</th>
						<th>시작시간</th>
						<th>작업시간</th>
						<th>가동</th>
					</tr>
				</thead>
				<tbody id ="popMonitorBody"></tbody>
			</table>
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/perform/monitoring/monitoring.css' rel="stylesheet">

<script>

var lfo_common = {};

var pop_interval;//전체화면 interval 종료를 위한 전역변수 선언

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//날짜검색 박스 세팅(초기 오늘 날짜 세팅)
	if($("#prodAsmDate").attr("data-role") != "datepicker"){
		$("#prodAsmDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_getDate(new Date(),"yyyy-MM-dd"),
			change : function(){
				lfn_asgnBox_set();
			}
		});
	}
	//해당날짜 작업지시 조회
	lfn_asgnBox_set();
	
	//모니터링 데이터 조회(화면전화시 실횅되지 않도록 예외처리 )
	setInterval(function(){if($("#_currentMenuId").val() == 'processProgress')lfn_monitor_select()},5000);
}

//전체화면세팅 이벤트
this.lfn_fullSecreen_set = function(){
	//날짜검색 박스 세팅(초기 오늘 날짜 세팅)
	if($("#popProdAsmDate").attr("data-role") != "datepicker"){
		$("#popProdAsmDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : $("#prodAsmDate").val(),
			change : function(){
				lfn_asgnBox_set('pop');
			}
		});
	}
	
	//해당날짜 작업지시 조회
	lfn_asgnBox_set('pop');
	
	//모니터링 데이터 조회(화면전화시 실횅되지 않도록 예외처리 )
	pop_interval = setInterval(function(){if($("#_currentMenuId").val() == 'processProgress')lfn_monitor_select('pop')},5000);
}

//해당날짜 작업지시 조회
this.lfn_asgnBox_set = function(mode){
	var asgnList = [];
	
	//메인화면, 전체화면 분기처리
	var asmDate = 'prodAsmDate';
	var asmId = 'prodAsmId';
	if(mode == 'pop'){
		asmDate = 'popProdAsmDate';
		asmId = 'popProdAsmId';
	}
	
	//팝업내용 조회
	$.ajax({
		async:false,
		url : "/form/mfgMgt/productWork/getProdWorkAsgnList",
		type: "POST",
		data: {prodAsmDate : $("#" + asmDate).val()},
		success: function(data){
			if(data.rows.length > 0){
				asgnList = data.rows;
			}else{
				asgnList = [{"prodAsmId":"X", "prodAsmNm":"-"}];
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	//select box 세팅
	$("#" + asmId).kendoDropDownList({
		dataTextField: "prodAsmNm",
		dataValueField: "prodAsmId",
		dataSource: asgnList,
		index: 0,
		change : function(){
			//메인화면, 전체화면 분기처리하여 모니터화면 조회
			if(mode == 'pop'){
				lfn_monitor_select('pop')
			}else{
				lfn_monitor_select()
			}
		}
	});
	
	//메인화면, 전체화면 분기처리하여 모니터화면 조회
	if(mode == 'pop'){
		lfn_monitor_select('pop')
	}else{
		lfn_monitor_select()
	}
}

//모니터링 데이터 조회
this.lfn_monitor_select = function(mode){
	//table초기화  (메인화면, 전체화면 분기처리)
	if(mode == 'pop'){
		$("#popMonitorBody").html("");
	}else{
		$("#monitorBody").html("");
	}
	
	//메인화면, 전체화면 분기처리
	var asmDate = 'prodAsmDate'
	var asmId = 'prodAsmId'
	if(mode == 'pop'){
		asmDate = 'popProdAsmDate';
		asmId = 'popProdAsmId';
	}
	
	//팝업내용 조회
	$.ajax({
		async:false,
		url : "/form/mfgMgt/productWork/getProdWorkRoutSheetList",
		type: "POST",
		data: {prodAsmDate : $("#"+asmDate).val(), prodAsmId : $("#"+asmId).val()},
		success: function(data){
			if(data.rows.length > 0){
				//메인화면, 전체화면 분기처리하여 테이블 세팅
				if(mode == 'pop'){
					lfn_monitor_tableSet(data.rows, 'pop');
				}else{
					lfn_monitor_tableSet(data.rows);
				}
				
			}else{
				//메인화면, 전체화면 분기처리하여 테이블 세팅
				if(mode == 'pop'){
					$("#popMonitorBody").html("<tr><td class='no-data' colspan='10'>진행중인 작업이 없습니다.</td></tr>");
				}else{
					$("#monitorBody").html("<tr><td class='no-data' colspan='10'>진행중인 작업이 없습니다.</td></tr>");
				}
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//monitoring table 세팅
this.lfn_monitor_tableSet = function(selectedItems, mode){
	var inHtml = "";
	for(i = 0; i< selectedItems.length; i++){
		var tbodyObject = {workGood : "0%", workBad : "0%", workStart:"-", workTime : "0", workStatus : "값 없음"};
		
		//달성률
		if(selectedItems[i]["prodWorkGood"] != 0 && selectedItems[i]["prodWorkQty"] != 0){
			tbodyObject.workGood = Math.floor(selectedItems[i]["prodWorkGood"]/selectedItems[i]["prodWorkQty"]*100) + "%";
		}
		
		//불량률
		if(selectedItems[i]["prodWorkBad"] != 0 && selectedItems[i]["prodWorkGood"] != 0){
			tbodyObject.workBad = Math.floor(selectedItems[i]["prodWorkBad"]/selectedItems[i]["prodWorkGood"]*100) + "%";			
		}
		
		//시작시간
		if(!gfn_isNull(selectedItems[i]["prodWorkStart"])){
			tbodyObject.workStart = gfn_getDate(new Date(selectedItems[i]["prodWorkStart"]),"HH:mm:dd")
		}
		
		//작동시간
		if(selectedItems[i]["prodWorkStatus"] == "work_wait"){
			tbodyObject.workTime = "0";
		}else if(selectedItems[i]["prodWorkStatus"] == "work_prs"){
			var millSec = (new Date() - new Date(selectedItems[i]["prodWorkStart"])) / 1000;
			var hour = Math.floor(millSec / 3600);
			var min = Math.floor((millSec - (hour * 3600)) / 60);
			tbodyObject.workTime = gfn_padLeft(hour, "0", 2) + ":" + gfn_padLeft(min, "0", 2);
		}else if(selectedItems[i]["prodWorkStatus"] == "work_end"){
			var millSec = (new Date(selectedItems[i]["prodWorkEnd"]) - new Date(selectedItems[i]["prodWorkStart"])) / 1000;
			var hour = Math.floor(millSec / 3600);
			var min = Math.floor((millSec - (hour * 3600)) / 60);
			tbodyObject.workTime = gfn_padLeft(hour, "0", 2) + ":" + gfn_padLeft(min, "0", 2);
		}
		
		//작동여부
		if(selectedItems[i]["prodWorkStatus"] == "work_wait" || selectedItems[i]["prodWorkStatus"] == "work_end"){
			tbodyObject.workStatus = "<a class='off-btn'>OFF</a>";
		}else if(selectedItems[i]["prodWorkStatus"] == "work_prs"){
			tbodyObject.workStatus = "<a class='on-btn'>ON</a>";
		}
		
		inHtml += "<tr class='tr-content'>";
			inHtml += "<td class='td-name'>"+ selectedItems[i]["routingSeq"] +"</td>";
			inHtml += "<td class='td-code'><div class='td-white'>"+ selectedItems[i]["bomNm"] +"</div></td>";
			inHtml += "<td class='td-stat'><div class='td-black'>"+ selectedItems[i]["prodWorkQty"] +"</div></td>";
			inHtml += "<td class='td-stat'><div class='td-black'>"+ selectedItems[i]["prodWorkGood"] +"</div></td>";
			inHtml += "<td class='td-stat'><div class='td-black'>"+ tbodyObject.workGood +"</div></td>";
			inHtml += "<td class='td-stat'><div class='td-black'>"+ selectedItems[i]["prodWorkBad"] +"</div></td>";
			inHtml += "<td class='td-stat'><div class='td-black'>"+ tbodyObject.workBad +"</div></td>";
			inHtml += "<td class='td-stat'><div class='td-black'>"+ tbodyObject.workStart +"</div></td>";
			inHtml += "<td class='td-stat'><div class='td-black'>"+ tbodyObject.workTime +"</div></td>";
			inHtml += "<td><div class='td-silver'>"+ tbodyObject.workStatus +"</div></td>";
		inHtml += "</tr>";
	}
	
	//메인화면, 전체화면 분기처리하여 테이블 데이터 넣어줌
	if(mode == 'pop'){
		$("#popMonitorBody").html(inHtml);
	}else{
		$("#monitorBody").html(inHtml);
	}
	
}

//전체화면 오픈
this.lfn_full_open = function(){
	var options = {
			modal:true,
			id:"jtePopForm",
			title:"종합 현황판", 
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:["none"]
		};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		$("#popProdAsmId").val($("#prodAsmId").val())
		//팝업 full screen
		$("#jtePopForm").parent("div").data("kendoWindow").maximize();
		
		//window 전체화면
		gfn_screen_full();
		
		//전체화면 데이터 세팅
		lfn_fullSecreen_set()
	};
	
	this.gfn_winOpen(options);		
}

//전체화면 종료
this.lfn_full_close = function(){
	//팝업종료
	gfn_closePop("jtePopForm");
	
	//전체화면 종료
	gfn_screen_exit();
	
	//반복종료 조회
	clearInterval(pop_interval);
}

</script>