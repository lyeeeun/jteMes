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
      </colgroup>
      <tr>
         <td><div id="chart" class="kpi-left-top-chart"></div></td>
      </tr>
   </table>
   
</div>

<!-- 이윤민 주임 작업 CSS -->
 <!-- <link href='/resources/mes/css/contents/perform/performEquipment/performEquipmentForm_lym.css' rel="stylesheet">  -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/prcesMgt/keyPerfindInfo/keyPerfindInfoForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
};


this.lfn_itemInfo = function() {
	$('#itemNm').val("고주파자극기");
	$('#itemId').val("ITEM202012160001");
	
	lfn_kpiInfoChart();
}


// 그리드 세팅
this.lfn_kpiInfoChart = function() {
	var hLotId = new Array();
	var hLeadTime = new Array();
	var hBadItemRate = new Array();
	var hStockTime = new Array();
	var hShipmentTime = new Array();
	

	$.ajax({
		async:false,
		url: "/form/basMgt/operMgt/itemMgt/selectKpi",
		type: "POST",
		data: {itemId: $('#itemId').val()},
		success: function(data){
			$.each(data.rows, function(index, item) {
				hLotId.push(item.itemId + "\n" + item.kpiTarget);
				hBadItemRate.push(item.kpiValue);
			});
		}
	});
	
	$("#chart").kendoChart({
		chartArea: {
			height: 550
		},
		title: {
			text: "KPI 정보"
		},
		legend: {
			position: "top"
		},
		series: [{
			type: "column",
			data: hBadItemRate,
			name: "불량율(%)",
			color: "#FF5675",
			axis: "percent"
		}],
		valueAxes: [{
			name: "percent",
			title: { text: "Percent" },
			min: 0,
			max: 10,
			color: "#E54C4C"
		}],
		categoryAxis: {
			categories: hLotId,
			/* color: "#ff0000", */
			axisCrossingValues: [0]
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