<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
	<div class="keyPerfindInfoForm">
		<div class="keyPerfindInfoForm search-btn-area">
			<input type="text" class="k-textbox" id="itemNm" readonly/>
			<input type="hidden" id="itemId">
			<button class="k-button k-primary page-search-btn" type="button" id="itemSelBtn" onclick= "lfn_itemInfo();"><spring:message code = "btn_search"/></button>
		</div>
	</div>
</div>
<div id="search-grid-content" class="keyPerfindInfoForm-gird" style="width:100%;">
	<table class="keyPerfindInfoForm keyPerfindInfoForm-gird"><!-- style="width:100%;" -->
		<colgroup>
			<col class="col-left">
			<col class="col-right">
		</colgroup>
		<tr>
			<!-- <td><div id="kpi_itemSumCost" class="kpi-left-top-chart"></div></td> -->
			<td class="td-chart-area"><div id="kpi_itemDefectRate" class="kpi-right-chart"></div></td>
		</tr>
	</table>
	
</div>

<link href='/resources/mes/css/contents/prcesMgt/keyPerfindInfo/keyPerfindInfoForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_kpiInfoChart();
};


this.lfn_itemInfo = function() {
	var callback = function(selectedItem){
		$('#itemId').val(selectedItem.itemId);
		$('#itemNm').val(selectedItem.itemNm);
		
		lfn_kpiInfoChart();
	};
	gfn_openCustomPop('item', callback);
}


// 그리드 세팅
this.lfn_kpiInfoChart = function() {
	
/* 		var historyMtrlCost = new Array();
		var historyPersonCost = new Array();
		var historySumCost = new Array(); */
		var historyDefectRate = new Array();

/* 		$.ajax({
			async:false,
			url: "/form/basMgt/operMgt/itemMgt/selectKpi",
			type: "POST",
			data: {itemId: $('#itemId').val()},
			success: function(data){
				$.each(data.rows, function(index, item) {
					if(item.kpiTarget == "kpi_sumCost") {
						historySumCost.push({ "sumCost" : item.kpiValue, "kpiDate" : item.kpiDate });
					}
				});
			}
		}); */
		
		$.ajax({
			async:false,
			url: "/cform/perform/performItem/selectKpiDefect",
			type: "POST",
			data: {itemId: $('#itemId').val()},
			success: function(data){
				$.each(data.rows, function(index, item) {
					historyDefectRate.push({ "defectRate" : item.itemDefectRate, "kpiDate" : item.monthDate });
				});
				
				
			}
		});
		
/* 		$("#kpi_itemSumCost").kendoChart({
			chartArea: {
				height: 550
			},
			title: {
				text: gfn_getMsg("pop_mtrlCostVar"),
				font: "18px Helvetica",
				color: " #000000",
				background: "#f2f6fc"
			},
			dataSource: {
				data: historySumCost
			},
			series: [{
				name: gfn_getMsg("col_manufactCost"),
				type: "line",
				field:  "sumCost",
				categoryField: "kpiDate",
				color: "#92B5FC"
			}],
			categoryAxis: {
				baseUnit: "weeks",
				labels: {
					rotation: {
						angle: 45
					}
				}
			},
			tooltip: {
				visible: true,
				shared: true,
				format: "N0",
				template: "#= value #"
			}
		}); */

		$("#kpi_itemDefectRate").kendoChart({
			chartArea: {
				height: 550
			},
			title: {
				text: gfn_getMsg("col_badRateVar"),
				font: "18px Helvetica",
				color: " #000000",
				background: "#f2f6fc"
			},
			dataSource: {
				data: historyDefectRate
			},
			legend: {
				position: "top",
				labels: {
					font: "16px Helvetica"}
			},
			series: [{
				name: gfn_getMsg("col_badRate"),
				type: "line",
				field:  "defectRate",
				categoryField: "kpiDate",
				color: "#FF427B"
			}],
			categoryAxis: {
				baseUnit: "weeks",
				labels: {
					rotation: {
						angle: 45
					}
				}
			},
			tooltip: {
				visible: true,
				shared: true,
				format: "N0",
				template: "#= value #%"
			}
		});

}

</script>