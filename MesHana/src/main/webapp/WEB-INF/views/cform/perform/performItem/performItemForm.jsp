<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 마스터 그리드 영역 -->
<div style="width:100%;">
	<div class="performItemForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
	<!-- 일간 -->
		<input class="radio-btn" type="radio" name="target" value="day" checked><span class="radio-span"><spring:message code = "pop_day"></spring:message></span>
	<!-- 월간 -->
		<input class="radio-btn" type="radio" name="target" value="month"><span class="radio-span"><spring:message code = "pop_month"></spring:message></span>
	<!-- 연간 -->
		<input class="radio-btn" type="radio" name="target" value="year"><span class="radio-span"><spring:message code = "pop_year"></spring:message></span>
	</div>
	<div id="grid-content" class="performItemForm performItemForm-gird"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>
<input type="hidden" id="hidStartDate" value="None">
<input type="hidden" id="hidEndDate" value="None">


<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/qualMgt/infergodsMgt/infergodsMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/perform/performItem/performItemForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200506 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd("day");
	
	lfn_radioBtn_event();
	
};

this.lfn_radioBtn_event = function(){
	$("input:radio[name=target]").click(function(e){
		$('#jteSingleGrid').empty();
		lfn_jteSgGrd_setGrd($(this).val());
	}); 
}

//Master Grid Binding
this.lfn_jteSgGrd_setGrd = function(target){
		
	//새로고침(custom)
	var jteMtGrd_refreshBtn = kendo.template('<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteMtGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>');
	
	var searchDate = kendo.template('<input id=\"searchDate\" title=\"datepicker\" style=\"width: 10%\" />'); 
	
	$("#jteSingleGrid").kendoGrid({
			dataSource: {
				transport: {
					read: {
						url : "/cform/perform/performItem/getPerformItem",
						dataType : "json"
					},
					parameterMap: function(data, type){
						var sort='';
						$.each(data.sort, function(index,item) {
							sort += item.field+' ' +item.dir+',';
						});
						
						if(!gfn_isEmpty(sort)){
							sort = sort.substring(0,sort.length-1);
						}
						return {
							page : data.page,
							take : data.take,
							rows : data.pageSize,
							sort : sort,
							pagingYN : "N",
							startDate : $('#hidStartDate').val(),
							endDate : $('#hidEndDate').val()
						};
					}
				},
				schema: {
					model: {
						id: "itemId",
						fields: {
							itemId : { type: "string" },
							itemNm : { type: "string" },
							itemDeduction : { type: "int" },
							itemDayTarget : { type: "int" },
							itemOrderQty : { type: "int" },
							itemAsmQty : { type: "int" },
							itemDefectQty : { type: "int" },
							itemDefectRate : { type: "float" },
							itemAchieveQty : { type: "int" },
							itemAchieveRate : { type: "float" },
							itemSalesShare : { type: "float" }
						}
					},
					data: "rows",
					total: "count"
				},
				batch: true,
				pageSize: 1000,
				serverPaging: false,
				serverFiltering: false,
				serverSorting: true
			},
			allowCopy:true,
			resizable: true,
	 		columnMenu: true,
	 		sortable: {
				mode: "multiple",
				allowUnsort: true
			},
			selectable: "multiple, row",
			navigatable: true,
			pageable: false,
			editable: {
				mode:"popup"
			},
			toolbar: [{ template: jteMtGrd_refreshBtn },{ template: searchDate }, {name:"excel"}],
			columns: [
					{ field: "itemId", title: gfn_getMsg("col_itemCd"), width: "10%" },													//부품코드
					{ field: "itemNm", title: gfn_getMsg("col_itemNm"), width: "10%" },													//부품명
					{ field: "itemDeduction", title: gfn_getMsg("col_deduction"), width: "10%" },										//공제량
					{ field: "itemDayTarget", title: gfn_getMsg("col_dayTarget"), width: "10%" },										//일일목표량
					{ field: "itemOrderQty", title: gfn_getMsg("col_totalOrderQty"), width: "10%" },									//총주문수량
					{ field: "itemAsmQty", title: gfn_getMsg("col_asmQty"), width: "10%" },												//작업 지시량
					{ field: "itemAchieveQty", title: gfn_getMsg("col_prodQuan"), width: "10%" },										//양품량
					{ field: "itemAchieveRate", title: gfn_getMsg("col_workAchieveRate"), format: "{0: 0.000'%'}", width: "10%" },			//달성률
					{ field: "itemDefectQty", title: gfn_getMsg("col_badProdQuan"), width: 150 },										//불량량
					{ field: "itemDefectRate", title: gfn_getMsg("col_badRate"), format: "{0:0.000'%'}", width: "10%" },				//불량률
					{ field: "itemSalesShare", title: gfn_getMsg("col_salesOccRate"), format: "{0:0.000'%'}", width: "10%" },			//매출점유율
			],
			excelExport: function(e) {
				var columns = e.workbook.sheets[0].columns;
					columns.forEach(function(column){
					delete column.width;
					column.autoWidth = true;
				});
				e.workbook.fileName = "Report.xlsx";
			}
	});
	
	lfn_DatePickerBind(target);
	
	var datepicker = $("#searchDate").data("kendoDatePicker");
	datepicker.value(new Date());
	datepicker.trigger("change");
}

//Master Grid Refresh
this.lfn_jteMtGrd_refresh = function(){
	var grid = $("#jteSingleGrid").data("kendoGrid");
	/* grid.dataSource.query({
		sort: {'field':'itemAchieveQty', 'dir':"desc"}
	}); */
	grid.dataSource.read();
}

this.lfn_DatePickerBind = function(target){
	if(target == "day") {
		$("#searchDate").kendoDatePicker({
			format: "yyyy-MM-dd",
			dateInput: true,
			change: function() {
				$('#hidStartDate').val(kendo.toString(this.value(), "yyyy-MM-dd"));
				$('#hidEndDate').val(kendo.toString(gfn_getDate(new Date($('#hidStartDate').val())),'yyyy-MM-dd 23:59:59'))
				$("#jteSingleGrid").data("kendoGrid").dataSource.query({
					sort: [{'field':'itemAchieveQty', 'dir':"desc"}]
				});
				$("#jteSingleGrid").data("kendoGrid").hideColumn("itemOrderQty");
				$("#jteSingleGrid").data("kendoGrid").hideColumn("itemSalesShare");
				$("#jteSingleGrid").data("kendoGrid").hideColumn("itemAchieveRate");
			}
		});
	} else if(target == "month") {
		$("#searchDate").kendoDatePicker({
			start: "year",
			depth: "year",
			format: "yyyy-MM",
			dateInput: true,
			change: function() {
				$('#hidStartDate').val(kendo.toString(this.value(), "yyyy-MM-01"));
				$('#hidEndDate').val(kendo.toString(gfn_getDate(new Date($('#hidStartDate').val()),31),'yyyy-MM-01'))
				$("#jteSingleGrid").data("kendoGrid").dataSource.read();
				$("#jteSingleGrid").data("kendoGrid").hideColumn("itemDeduction");
				$("#jteSingleGrid").data("kendoGrid").hideColumn("itemDayTarget");
			}
		});
	} else if(target == "year") {
		$("#searchDate").kendoDatePicker({
			start: "decade",
			depth: "decade",
			format: "yyyy",
			dateInput: true,
			change: function() {
				$('#hidStartDate').val(kendo.toString(this.value(), "yyyy-01-01"));
				$('#hidEndDate').val(kendo.toString(gfn_getDate(new Date($('#hidStartDate').val()),366),'yyyy-01-01'))
				$("#jteSingleGrid").data("kendoGrid").dataSource.read();
				$("#jteSingleGrid").data("kendoGrid").hideColumn("itemDeduction");
				$("#jteSingleGrid").data("kendoGrid").hideColumn("itemDayTarget");
			}
		});
	}
}
</script>