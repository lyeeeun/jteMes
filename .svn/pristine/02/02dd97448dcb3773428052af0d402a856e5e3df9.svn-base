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
	$('#itemNm').val("VANE6");
	$('#itemId').val("ITEM202008260001");
	
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
		url: "/cform/basMgt/operMgt/itemMgt/selectKpi",
		type: "POST",
		data: {itemId: $('#itemId').val()},
		success: function(data){
			$.each(data.rows, function(index, item) {
				hLotId.push(item.lotId + "\n" + item.createdAt);
				hLeadTime.push(item.leadTime);
				hBadItemRate.push(item.badItemRate);
				hStockTime.push(item.stockTime);
				hShipmentTime.push(item.shipmentTime);
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
			data: hLeadTime,
			name: "제조리드타임(주)",
			color: "#AAEBAA",
			axis: "week"
			}, {
			type: "column",
			data: hBadItemRate,
			name: "불량율(%)",
			color: "#FF5675",
			axis: "percent"
		}, {
			type: "column",
			data: hStockTime,
			name: "재공재고(일)",
			color: "#1E96FF",
			axis: "day"
		}, {
			type: "column",
			data: hShipmentTime,
			name: "납기(주)",
			color: "#B2FA5C",
			axis: "week"
		}],
		valueAxes: [{
			name: "week",
			title: { text: "Week" },
			min: 0,
			max: 60,
			color: "#74C600"
		}, {
			name: "day",
			title: { text: "Day" },
			min: 0,
			max: 365,
			color: "#0060FF"
		}, {
			name: "percent",
			title: { text: "Percent" },
			min: 0,
			max: 100,
			color: "#E54C4C"
		}],
		categoryAxis: {
			categories: hLotId,
			/* color: "#ff0000", */
			axisCrossingValues: [0, 0, 0]
		},
			tooltip: {
				visible: true,
				shared: true,
				format: "N0",
				template: "#= value #"
			}
	});
}

</script>