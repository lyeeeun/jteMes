<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div style="width:100%;">
<!-- 	최상단 검색영역 -->
	<div class="shipMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<!-- 년/월 셀렉트 박스 -->
		<input id="jteYearSelBox" style="width:80px; margin-left:10px;"/>
		<input id="jteMonthSelBox" style="width:80px;"/>
	</div>
	<!-- 년/월 그리드 -->
	<div id="grid-content" style="width:100%;">
		<div id="jteDoubleGrid" style="display:block;"></div>
	</div>
</div>
<div style="display:none;">
	<div id="jtePopForm" style="height:100%;">
		<form id="jtePopForm_form" class="shipPlanMgtForm">
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width: 30%;">
				<col style="width: 70%;">
			</colgroup>
				<tr><td colspan="2"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_lotCd"/> : </td>
					<td>
						<input type="text" id="itemMgtId" name="itemMgtId" format="text" readonly/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>출고 계획량 : </td>
					<td ><input id="pickPlanQty" name="pickPlanQty" format="currency"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>출하 계획량 : </td>
					<td ><input id="shipPlanQty" name="shipPlanQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 비고 -->
					<td><i class="fas fa-caret-right"></i>비고 : </td>
					<td><input type="text" id="shipPlanDesc" name="shipPlanDesc" format="text"/></td>
				</tr>
				<tr style="display:none;">
					<td colspan="2">
						<input type="hidden" id= "shipPlanId" name = "shipPlanId"/>
						<input type="hidden" id= "shipPlanType" name = "shipPlanType"/>
						<input type="hidden" id= "shipPlanYear" name = "shipPlanYear"/>
						<input type="hidden" id= "shipPlanMonth" name = "shipPlanMonth"/>
						<input type="hidden" id= "shipPlanDay" name = "shipPlanDay"/>
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
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/ship/shipPlanMgt/shipPlanMgtForm_JJW.css' rel="stylesheet">

<style type="text/css">
.planHdSun > *{
	color : red !important;
}
.planHdSat > *{
	color : blue !important;
}
</style>

<script>
var lfo_dateBox = {};
var lfo_common = {};//Form 내부에서 사용될 Object 
var lfo_popGrd = {};

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
	lfo_dateBox.yearVal = $("#jteYearSelBox").val();
	lfo_dateBox.monthVal = $("#jteMonthSelBox").val(); 
	lfn_dayPlan_load();
}


//Day -gridLoad
this.lfn_dayPlan_load = function(){	
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

//Day - grid 생성
this.lfn_jteDbGrd_setGrd = function(){
	//lfo_common = {};//Form 내부에서 사용될 Object	
	//1.
	lfo_common.layoutId = "jteDoubleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	//3.
	lfo_common.ctrlUrl = "/cform/ship/shipPlanMgt";
	
	//CUD 커스텀 진행
	lfo_common.crud  = {
		read:{url:"/getMonthPlanList", auth:"", prmt:{calPrmt : lfo_dateBox.dayArray, calYear : lfo_dateBox.yearVal, calMonth : lfo_dateBox.monthVal}}, 
	};
	
	//5.
	lfo_common.model = {
			id: "orderId",
			fields: {
				itemMgtId: { type: "string" },
				itemNm: { type: "string" },
				itemStock: { type: "int" },
				itemUnit: { type: "string" },
				shipTotalQty:{type : "int"},
				shipPlanYear: { type: "string" },
				shipPlanMonth: { type: "string" }
				
			}
		};
	
	var dayDataCol = {title: lfo_dateBox.yearVal+'-'+lfo_dateBox.monthVal, columns: []};
	lfo_dateBox.dayArray.forEach(function(item){
		var week = new Date(lfo_dateBox.yearVal+'-'+lfo_dateBox.monthVal+'-'+item).getDay();
		lfo_common.model.fields["planQty"+item] = { type: "int" };
		lfo_common.model.fields["pickPlanQty"+item] = { type: "int" };
		dayDataCol.columns.push({
			title: item, field: "planQty"+item, width: "87px",
			template : function(rows) {
				return rows["pickPlanQty"+item] + " / " + rows["planQty"+item];
			},
			attributes:{"class":"planCol","planAttr":lfo_dateBox.yearVal + "_"+lfo_dateBox.monthVal+"_"+item}, 
			headerAttributes :  week == 0 ? {style:"color : red;", class:"planHdSun"} : week == 6 ? {style:"color : blue;", class:"planHdSat"} : {} 
		});
	});
	
	//6.
	lfo_common.columns = [
		{field: "itemMgtId", title:gfn_getMsg("col_lotCd"), width: "180px", locked: true},												//부품코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "180px", locked: true},												//부품명
		{field: "itemStock", title:gfn_getMsg("col_indivStockQty"), width: "180px", locked: true},												//부품코드
		{field: "shipTotalQty", title: "총 계획량(출고/출하)", width: "180px",
			template : function(rows) {
				return rows.pickTotalQty + " / " + rows.shipTotalQty;
			}, locked: true},
		
		dayDataCol,
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "품명", value: "item.item_nm" },
		{ text: "Lot 코드", value: "itemCal.itemMgtId" },
	];
	
	//8.
	lfo_common.validation ={
		shipPlanQty:{
			messages : "계획량을 입력하세요",
			rules : function(input){
				if(input.is("[name = shipPlanQty]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		pickPlanQty:{
			messages : "계획량을 입력하세요",
			rules : function(input){
				if(input.is("[name = pickPlanQty]")){
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
this.lfn_jtePop_open = function(selectedItem, selectedDate){
	var options = {
			modal:true, 
			id : lfo_common.popId, 
			title : selectedDate + " " + gfn_getMsg("pop_planQuanInput"),			//계획량 입력
			width: "420px", /** 20.12.18 400 -> 420 **/
			height: "315px", /** 20.12.18 270 -> 325 **/
			workCd : "", 
			bdSeq : "",
			resizable : true,
			animation : {open :{effects:"expand:vertical fadeIn"},
			close : {effects:"expand:vertical fadeIn", reverse: true}},
			actions : [/*"Minimize", "Maximize", */"Close"]
	};
	
	selectedItem.shipPlanType = "ship_plan02";
	selectedItem.shipPlanYear = selectedDate.split("_")[0];
	selectedItem.shipPlanMonth = selectedDate.split("_")[1];
	selectedItem.shipPlanDay = selectedDate.split("_")[2];
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
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
		lfo_common.gridSelected.shipPlanId = selectedItem;
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getShipPlanDetail",
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
			
			//월간 생산계획이 없기 때문에 일간 계획 코드값 하드코딩
			$("#shipPlanType").val("ship_plan02");
			//등록, 수정여부를 쿼리에서 판단해서 가져온다.
			$("#"+lfo_common.popId+" [name=action]").val(lfo_common.gridSelected.action);
			
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});

	//저장이벤트 커스텀 바인딩
	var event = $._data($("#"+lfo_common.popId+" .jte-save")[0],"events")
	if(gfn_isEmpty(event) || !event.click){
		$("#"+lfo_common.popId+" .jte-save").on('click',function(){
			lfn_popSave();
		});
	}
}

//pop 저장
this.lfn_popSave = function(){
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		var savePrmt = gfn_serializeObject(lfo_common.popId+"_form");
		console.log(savePrmt);
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setShipPlan",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					gfn_closePop(lfo_common.popId);
					
					//gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
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

</script>