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
		<form id="jtePopForm_form" class="productPlanForm">
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:28%;">
				<col style="width:72%;">
			</colgroup>
				<tr><td colspan="2"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td>
						<input type="text" id="itemNm" name="itemNm" format="text" readonly/>
						<input type="hidden" id="itemId" name="itemId"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_planQuan"/> : </td>
					<td ><input id="prodPlanQty" name="prodPlanQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 비고 -->
					<td><i class="fas fa-caret-right"></i>비고 : </td>
					<td><input type="text" id="prodPlanDesc" name="prodPlanDesc" format="text"/></td>
				</tr>
				<tr style="display:none;">
					<td colspan="2">
						<input type="hidden" id= "prodPlanId" name = "prodPlanId"/>
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
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/mfgplanMgt/productPlan/productPlanForm_JJW.css' rel="stylesheet">

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
	lfo_common.ctrlUrl = "/cform/mfgMgt/mfgplanMgt/productPlan";
	
	//CUD 커스텀 진행
	lfo_common.crud  = {
		read:{url:"/getMonthPlanList", auth:"", prmt:{calPrmt : lfo_dateBox.dayArray, calYear : lfo_dateBox.yearVal, calMonth : lfo_dateBox.monthVal}}, 
	};
	
	//5.
	lfo_common.model = {
			id: "orderId",
			fields: {
				itemId: { type: "string" },
				itemNm: { type: "string" },
				itemStdStr01: { type: "string" },
				//itemUnit: { type: "string" },
				planTotalQty:{type : "int"},
				prodPlanYear: { type: "string" },
				prodPlanMonth: { type: "string" }
				
			}
		};
	
	var dayDataCol = {title: lfo_dateBox.yearVal+'-'+lfo_dateBox.monthVal, columns: []};
	lfo_dateBox.dayArray.forEach(function(item){
		var week = new Date(lfo_dateBox.yearVal+'-'+lfo_dateBox.monthVal+'-'+item).getDay();
		lfo_common.model.fields["planQty"+item] = { type: "int" };
		dayDataCol.columns.push({
			title: item, field: "planQty"+item, format: "{0:n0}", attributes : { style : "text-align : right;"}, width: "87px",
			attributes:{"class":"planCol","planAttr":lfo_dateBox.yearVal + "_"+lfo_dateBox.monthVal+"_"+item}, 
			headerAttributes :  week == 0 ? {style:"color : red;", class:"planHdSun"} : week == 6 ? {style:"color : blue;", class:"planHdSat"} : {} 
		});
	});
	
	//6.
	lfo_common.columns = [
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "180px", locked: true},												//부품코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "180px", locked: true},												//부품명
		{field: "itemStdStr01", title : "규격", width: "120px", locked: true},											//예비1(Str)
		//{field: "itemUnit", template:"# var item = gfn_isNull(itemUnit)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(itemUnit).cdId , gfn_getCode(itemUnit).cdNm) # #= item #",
		//		title:"단위", width: "80px", locked: true},
		{field: "planTotalQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_totalPlanQuan"), width: "120px", locked: true},				//총계획량
 		/* {field: "itemStdStr02", title : "예비2(Str)", width: "100px"},											//예비2(Str)
 		{field: "itemStdStr03", title : "예비3(Str)", width: "100px"},											//예비3(Str)
 		{field: "itemStdStr04", title : "예비4(Str)", width: "100px"},											//예비4(Str)
 		{field: "itemStdStr05", title : "예비5(Str)", width: "100px"},											//예비5(Str) */
		dayDataCol,
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "품명", value: "itemCal.itemNm" },
		{ text: "품번", value: "itemCal.itemIId" },
	];
	
	//8.
	lfo_common.validation ={
		prodPlanQty:{
			messages : "계획량을 입력하세요",
			rules : function(input){
				if(input.is("[name = prodPlanQty]")){
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
			width: "400px",
			height: "270px", /** 20.08.28 JJW 250 -> 270 **/
			workCd : "", 
			bdSeq : "",
			resizable : true,
			animation : {open :{effects:"expand:vertical fadeIn"},
			close : {effects:"expand:vertical fadeIn", reverse: true}},
			actions : [/*"Minimize", "Maximize", */"Close"]
	};
	
	selectedItem.prodPlanType = "prod_plan02";
	selectedItem.prodPlanYear = selectedDate.split("_")[0];
	selectedItem.prodPlanMonth = selectedDate.split("_")[1];
	selectedItem.prodPlanDay = selectedDate.split("_")[2];
	
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
		lfo_common.gridSelected.prodPlanId = selectedItem;
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getProductPlanDetail",
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
			$("#prodPlanType").val("prod_plan02");
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
			url : lfo_common.ctrlUrl + "/setProductPlan",
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