<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="cpkVaneMonitorForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<input type="text" id="cpkDept" name="cpkDept" style="margin-left: 10px ;" />
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_changeDept();"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="cpkVaneMonitorForm cpkVaneMonitorForm-gird"> <!-- style="width:100%;" -->
		<div id="jteMasterGrid" class="cpkVaneMonitorForm left-contents"></div>
		<div id="jteSubGrid" class="cpkVaneMonitorForm right-contents"></div>
	</div>
</div>

<input type="hidden" id="hidSelItemCd" value="none">
<input type="hidden" id="hidSelOpNo" value="none">

<!-- 전주원 주임 작업 CSS -->
<link href="<c:url value='/resources/mes/css/contents/cpk/cpkVaneMonitor/vaneMonitorForm_JJW.css'/>" rel="stylesheet">

<script type="text/javascript">
/**
 * /msgMgt/msgMgtForm
*/

this.lfn_init = function(){
	lfn_initSelBox();
	
	lfn_masterGridBind();
	lfn_subGridBind();
	lfn_eventBind();
}

this.lfn_initSelBox = function() {
	var selBoxItem = gfn_getCode('cpk_dept');
	$("#cpkDept").kendoDropDownList({
		dataSource: selBoxItem,
		dataValueField: "cdVal",
		valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
		template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
		index:0
	});
}

this.lfn_changeDept = function(){
	$('#jteMasterGrid').data('kendoGrid').dataSource.read();
	/* lfn_setMachine(); */
}

//Master Grid Binding
this.lfn_masterGridBind = function(){
	
	var nowDate = new Date();
	var nowHours = nowDate.getHours(); 
	var shiftTime;
	var dueTime;
	if(nowHours >= 08 && nowHours < 20) {
		shiftTime = "Day"
		dueTime = gfn_getDate("yyyy/MM/dd").toString() + " 08:00 ~ " + gfn_getDate("yyyy/MM/dd").toString() + " 20:00";
	} else {
		shiftTime = "Night";
		
		if(nowHours >= 20) {
			shiftTimeStart = gfn_getDate("yyyy/MM/dd");
			shiftTimeEnd = gfn_getDate(1,"yyyy/MM/dd");
			
		} else {
			shiftTimeStart = gfn_getDate(-1,"yyyy/MM/dd");
			shiftTimeEnd = gfn_getDate("yyyy/MM/dd");
		}
		dueTime = shiftTimeStart.toString() + " 20:00 ~ " + shiftTimeEnd.toString() + " 08:00";
	}
		
	var shiftTimeArea = kendo.template('<div style=\"float:right; text-weight:bold;\"><span>Shift Time : </span><span>' + shiftTime + ' </span><span>&nbsp;&nbsp;&nbsp;' + dueTime + '</span></div>');
	
	//새로고침(custom)
	var jteMtGrd_refreshBtn = kendo.template('<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteMtGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span></a>');
	
	var treeJson = [];
	
	$("#jteMasterGrid").kendoGrid({
			dataSource: {
				transport: {
					read: {
						url : "/cform/cpk/cpkVaneMonitor/getVaneMonitorList",
						dataType : "json"
					},
					parameterMap: function(data, type){
						return {
							page : data.page,
							take : data.take,
							rows : data.pageSize,
							shiftCd : shiftTime,
							deptCd: $("#cpkDept").val()
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
			toolbar: [{ template: shiftTimeArea }],
			dataBound: function(e){
				var rows = e.sender.content.find('tr');
			    var machineStatus = e.sender.wrapper.find(".k-grid-header [data-field=" + "machineStatus" + "]").index();
			    
			    rows.each(function(index, row){
			      var dataItem = e.sender.dataItem(row);
			      
			      switch (dataItem.machineStatus) {
			      case "RUN":
			    	  $(row).children('td:eq(' + machineStatus + ')').addClass('machineRun');
			    	  break;
			      case "STOP": 
			    	  $(row).children('td:eq(' + machineStatus + ')').addClass('machineStop');
			    	  break;
			      case "HOLD":
			    	  $(row).children('td:eq(' + machineStatus + ')').addClass('machineHold');
			    	  break;
			      }
			      
			      if(dataItem.actQty == null) {
			    	  dataItem.actQty = 0;
			      }
			      
			      var performance = e.sender.wrapper.find(".k-grid-header [data-field=" + "performance" + "]").index();
			      if(parseInt(dataItem.actQty)/parseInt(dataItem.planedQty) < (dataItem.haveTime/dataItem.dueTime)) {
			    	  $(row).children('td:eq(' + performance + ')').addClass('performanceBad');
			      } else {
			    	  $(row).children('td:eq(' + performance + ')').addClass('performanceGood');
			      }
			    })
			},
			dataBinding: function(e) {},
			columns: [
					{ field: "machineCd", title: "Machine No", width: "5%" },
					{ field: "machineStatus", title: "Status", width: "5%" },
					{ field: "partNo", title: "Part No", width: "10%" },
					{ field: "opNo", title: "OP No", width: "10%" },
					{ field: "planedQty", title: "Planed_Qty", width: "10%" },
					{ field: "actQty", title: "ACT_Qty", width: "10%" },
					{ field: "performance", title: "Performance", format: "{0:0.0'%'}", width: "10%" },
					{ field: "elapsedTime", title: "Elapsed time", format: "{0:0.0'%'}", width: "10%" },
					{ field: "utilizationRate", title: "Utilization_Rate", format: "{0:0.0'%'}", width: "10%" },
					{ field: "ipAdd", title: "IP Address", width: "10%" },
					{ field: "mcnoDisp", title: "MCNO_DISP", width: "10%" } 
			]
	});
}

this.lfn_subGridBind = function() {
	//새로고침(custom)
	var refreshBtn = kendo.template('<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteMtGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span></a>');
	
	var goToVaneGraphBtn = kendo.template('<a style=\"float:right;\" role=\"button\" class=\"k-button k-button-icontext\" onclick=\"lfn_moveGraphView()\"><span>Go Graph(Excel)</span></a>');
	
	var treeJson = [];
	
	$("#jteSubGrid").kendoGrid({
			dataSource: {
				transport: {
					read: {
						url : "/cform/cpk/cpkVaneMonitor/getVaneOffsetList",
						dataType : "json"
					},
					parameterMap: function(data, type){
						return {
							page : data.page,
							take : data.take,
							rows : data.pageSize,
							itemCd: $('#hidSelItemCd').val(),
							opNo: $('#hidSelOpNo').val()
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
			toolbar: [{ template: goToVaneGraphBtn }],
			dataBound: function(e){
			},
			dataBinding: function(e) {},
			columns: [
					{ field: "itemCd", title: "제품번호", width: "5%" },
					{ field: "opNo", title: "공정번호", width: "5%" },
					{ field: "dimNo", title: "DIM NO", width: "10%" },
					{ field: "offsetNo", title: "공구번호", width: "10%" },
					{ field: "offsetGu", title: "옵셋구분", width: "10%" },
					{ field: "dimDesc", title: "DIM DESC", width: "10%" },
					{ field: "calDesc", title: "옵셋전송계산식", width: "10%" },
					{ field: "graphDesc", title: "그래프계산식", width: "10%" },
					{ field: "graphDisp", title: "Graph Disp", width: "10%" }
			]
	});
}

this.lfn_eventBind = function(){
	//마스터테이블 더블 클릭
	$("#jteMasterGrid tbody").on("dblclick", "tr", function(e){
		//선택한 항목(Row)
		var selectedItem = $("#jteMasterGrid").getKendoGrid().dataItem($(this));
		
		$("#hidSelItemCd").val(selectedItem.partNo);
		$("#hidSelOpNo").val(selectedItem.opNo);

		//그리드 리로드
		$("#jteSubGrid").data("kendoGrid").dataSource.read();
		
	});
};


this.lfn_moveGraphView = function() {
	if($('#hidSelItemCd').val() == "none" || $('#hidSelOpNo').val() == "none") {
		kendo.confirm("특정 설비 정보를 더블 클릭하여 offset 정보를 불러와주십시오.");
		return false;
	} else if($('#hidSelItemCd').val() == "" || $('#hidSelOpNo').val() == "") {
		kendo.confirm("Offset 기준 정보가 없는 설비입니다.");
		return false;
	}
	goMenuToBody({menuId: "cpkExcel", svcUrl: "/cform/cpk/cpkExcel", msgId: "mn_cpkExcel", msgView: "CPK - EXCEL", menuCd: "M", msgIdPath: "CPK - EXCEL", msgViewPath: "CPK - EXCEL", duplYn: "Y"}, {itemCd: $('#hidSelItemCd').val(), opNo: $('#hidSelOpNo').val()});
}
//Master Grid Refresh
this.lfn_jteMtGrd_refresh = function(){
	$("#jteMtGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteMtGrd_shSelTxt").val("");
	
	var grid = $("#jteMasterGrid").data("kendoGrid");
	grid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	grid.dataSource.read();
}

</script>
