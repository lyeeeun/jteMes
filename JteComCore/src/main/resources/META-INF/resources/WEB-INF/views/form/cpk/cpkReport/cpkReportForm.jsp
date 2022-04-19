<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="cpkReportForm" style="width:100%;">
	<div class="cpkReportForm jteGridWrap">
		<div id="tabStrip" class="cpkReportForm"></div>
	</div>
</div>

<input type="hidden" id="hidStartDate" value="none">
<input type="hidden" id="hidEndDate" value="none">

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/cpk/cpkReport/cpkReportForm_JJW.css' rel="stylesheet">
<!-- 이윤민 주임 작업 CSS -->
<%-- <link href="<c:url value='/resources/mes/css/contents/cpk/cpkReport/cpkReportForm_lym.css'/>" rel="stylesheet"> --%>

<script type="text/javascript">

this.lfn_init = function(){
	lfn_tabBind();
	lfn_masterGridBind("jteMasterGridDay", "reportDateDay");
	lfn_masterGridBind("jteMasterGridMonth", "reportDateMonth");
	lfn_masterGridBind("jteMasterGridYear", "reportDateYear");
	lfn_DatePickerBind();
}

this.lfn_tabBind = function(){
	tabData = [{
		text: "일간",
		content: "<div id='jteMasterGridDay' class='jteGrid cpkReportForm' style='width:100%;'></div>"
	},{
		text: "월간",
		content: "<div id='jteMasterGridMonth' class='jteGrid cpkReportForm' style='width:100%;'></div>"
	},{
		text: "연간",
		content: "<div id='jteMasterGridYear' class='jteGrid cpkReportForm' style='width:100%;'></div>"
	}];
	
	
	$("#tabStrip").kendoTabStrip({
		animation: { open: { effects: "fadeIn"} },
		dataTextField: "text",
		dataImageUrlField: "imageUrl",
		dataContentField: "content",
		dataSource: tabData
	}).data("kendoTabStrip").select(0);
}

//Master Grid Binding
this.lfn_masterGridBind = function(gridId, datePickerId){
	
	//새로고침(custom)
	var jteMtGrd_refreshBtn = kendo.template('<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteMtGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span></a>');
	
	var reportDateDay = kendo.template('<input id=\"' + datePickerId + '\" title=\"datepicker\" style=\"width: 10%\" />'); 
	
	$("#" + gridId).kendoGrid({
			dataSource: {
				transport: {
					read: {
						url : "/form/cpk/cpkReport/getCpkReportList",
						dataType : "json"
					},
					parameterMap: function(data, type){
						return {
							page : data.page,
							take : data.take,
							rows : data.pageSize,
							startDate : $('#hidStartDate').val(),
							endDate : $('#hidEndDate').val()
						};
					}
				},
				schema: {
					data: "rows",
					total: "count"
				},
				batch: true,
				pageSize: 10,
				serverPaging: true,
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
			pageable: {
				pageSizes: true
			},
			editable: {
				mode:"popup"
			},
			toolbar: [{ template: jteMtGrd_refreshBtn },{ template: reportDateDay }, {name:"excel"}],
			dataBound: function(e){
				var rows = e.sender.content.find('tr');

				rows.each(function(index, row){
				var dataItem = e.sender.dataItem(row);
			
				if(dataItem.actQty == null) {
					dataItem.actQty = 0;
			}

			var performance = e.sender.wrapper.find(".k-grid-header [data-field=" + "performance" + "]").index();
				if(parseInt(dataItem.actQty)/parseInt(dataItem.planedQty) < (dataItem.haveTime/dataItem.dueTime)) {
					$(row).children('td:eq(' + performance + ')').addClass('performanceBad');
				} else if(parseInt(dataItem.actQty)/parseInt(dataItem.planedQty) > (dataItem.haveTime/dataItem.dueTime)) {
					$(row).children('td:eq(' + performance + ')').addClass('performanceGood');
				}
			})
			},
			dataBinding: function(e) {},
			columns: [
					{ field: "machineCd", title: "Machine No", width: "5%" },
					{ field: "partNo", title: "Part No", width: "10%" },
					{ field: "opNo", title: "OP No", width: "10%" },
					{ field: "planedQty", title: "Planed_Qty", width: "10%" },
					{ field: "actQty", title: "ACT_Qty", width: "10%" },
					{ field: "performance", title: "Performance", format: "{0:0.0'%'}", width: "10%" },
					{ field: "elapsedTime", title: "Elapsed time", format: "{0: 0.0'%'}", width: "10%" },
					{ field: "utilizationRate", title: "Utilization_Rate", format: "{0:0.0'%'}", width: "10%" },
					{ field: "mcnoDisp", title: "MCNO_DISP", width: "10%" } 
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
}

//Master Grid Refresh
this.lfn_jteMtGrd_refresh = function(){
	var grid = $("#jteMasterGrid").data("kendoGrid");
	grid.dataSource.read();
}

this.lfn_DatePickerBind = function(){
	$("#reportDateDay").kendoDatePicker({
		format: "yyyy-MM-dd",
		change: function() {
			$('#hidStartDate').val(kendo.toString(this.value(), "yyyy-MM-dd"));
			$('#hidEndDate').val(kendo.toString(gfn_getDate(new Date($('#hidStartDate').val()),1),'yyyy-MM-dd'))
			$("#jteMasterGridDay").data("kendoGrid").dataSource.read();
		}
	});
	$("#reportDateMonth").kendoDatePicker({
		start: "year",
		depth: "year",
		format: "yyyy-MM",
		dateInput: true,
		change: function() {
			$('#hidStartDate').val(kendo.toString(this.value(), "yyyy-MM-01"));
			$('#hidEndDate').val(kendo.toString(gfn_getDate(new Date($('#hidStartDate').val()),31),'yyyy-MM-01'))
			$("#jteMasterGridMonth").data("kendoGrid").dataSource.read();
		}
	});
	$("#reportDateYear").kendoDatePicker({
		start: "decade",
		depth: "decade",
		format: "yyyy",
		dateInput: true,
		change: function() {
			$('#hidStartDate').val(kendo.toString(this.value(), "yyyy-01-01"));
			$('#hidEndDate').val(kendo.toString(gfn_getDate(new Date($('#hidStartDate').val()),366),'yyyy-01-01'))
			$("#jteMasterGridYear").data("kendoGrid").dataSource.read();
		}
	});
}
</script>
