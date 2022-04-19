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
			<td><div id="kpi_itemSumCost" class="kpi-left-top-chart"></div></td>
			<td class="td-chart-area"><div id="kpi_itemDefectRate" class="kpi-right-chart"></div></td>
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
	
		var historyMtrlCost = new Array();
		var historyPersonCost = new Array();
		var historySumCost = new Array();
		var historyDefectRate = new Array();

		$.ajax({
			async:false,
			url: "/cform/basMgt/operMgt/itemMgt/selectKpi",
			type: "POST",
			data: {itemId: $('#itemId').val()},
			success: function(data){
				$.each(data.rows, function(index, item) {
				/* 	if(item.kpiTarget == "kpi_mtrlCost") {
						historyMtrlCost.push({ "mtrlCost" : item.kpiValue, "kpiDate" : item.kpiDate });
					} else if(item.kpiTarget == "kpi_personCost") {
						historyPersonCost.push({ "personCost" : item.kpiValue, "kpiDate" : item.kpiDate });
					} */
					if(item.kpiTarget == "kpi_sumCost") {
						historySumCost.push({ "sumCost" : item.kpiValue, "kpiDate" : item.kpiDate });
					}
				});
				
				/* historyPersonCost = data.rows[0]. */
				
			}
		});
		
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
		
		$("#kpi_itemSumCost").kendoChart({
			chartArea: {
				height: 550 // 200519 JJW 왼쪽 제조원가 차트 높이 변형 250 -> 300
			},
			title: {
				text: gfn_getMsg("pop_mtrlCostVar"),			//제조원가 변동
				font: "18px Helvetica", // 200519 JJW 제목 사이즈 변경 (원래는 없었는데 새로 추가)
				color: " #000000", // 200519 JJW 제목 색상 변경 #000000 (원래는 없었는데 새로 추가)
				background: "#f2f6fc"// 200519 JJW 제목 바탕 변경 #f2f6fc (원래는 없었는데 새로 추가)
			},
			dataSource: {
				data: historySumCost
			},
			/* legend: { // 200519 JJW 위쪽으로 위치 변형을 위해 추가
				position: "top",
				labels: {
					font: "16px Helvetica"}
			}, 위쪽으로 옮기면 차트가 모두 출력되지 않음으로 주석 200519 JJW */
			series: [{
				name: gfn_getMsg("col_manufactCost"),			//제조원가
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
		});
		
		/* $("#kpi_itemPersonCost").kendoChart({
			chartArea: {
				height: 300, // 200519 JJW 왼쪽 인건비 차트 높이 변형 250 -> 300
			},
			title: {
				text: gfn_getMsg("col_personCostVar"),			//인건비 변동
				font: "18px Helvetica", // 200519 JJW 제목 사이즈 변경 (원래는 없었는데 새로 추가)
				color: " #000000", // 200519 JJW 제목 색상 변경 #000000 (원래는 없었는데 새로 추가)
				background: "#f2f6fc"// 200519 JJW 제목 바탕 변경 #f2f6fc (원래는 없었는데 새로 추가)
			},
			dataSource: {
				data: historyPersonCost
			},*/
			/* legend: { // 200519 JJW 위쪽으로 위치 변형을 위해 추가
				position: "top",
				labels: {
					font: "16px Helvetica"}
			}, -> 위쪽으로 옮기면 차트가 모두 출력되지 않음으로 주석 200519 JJW */
			/*series: [{
				name: gfn_getMsg("col_laborCost"),			//인건비
				type: "line",
				field:  "personCost",
				categoryField: "kpiDate",
				color: "#3367D6"
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
		});
 */
		$("#kpi_itemDefectRate").kendoChart({
			chartArea: {
				height: 550 // 200519 JJW 오른쪽 불량율 차트 높이 변형 300 -> 550
			},
			title: {
				text: gfn_getMsg("col_badRateVar"),			//불량률 변동
				font: "18px Helvetica", // 200519 JJW 제목 사이즈 변경 (원래는 없었는데 새로 추가)
				color: " #000000", // 200519 JJW 제목 색상 변경 #000000 (원래는 없었는데 새로 추가)
				background: "#f2f6fc"// 200519 JJW 제목 바탕 변경 #f2f6fc (원래는 없었는데 새로 추가)
			},
			dataSource: {
				data: historyDefectRate
			},
			legend: { // 200519 JJW 위쪽으로 위치 변형을 위해 추가
				position: "top",
				labels: {
					font: "16px Helvetica"}
			},
			series: [{
				name: gfn_getMsg("col_badRate"),			//불량률
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
 console.log(historyDefectRate);
	/* 	  
	 $("#chart").kendoChart({
         title: {
             text: "Spain electricity production (GWh)"
         },
         legend: {
             position: "top"
         },
         seriesDefaults: {
             type: "line"
         },
         series: [{
             field: "nuclear",
             categoryField: "year",
             name: "Nuclear"
         }, {
             field: "hydro",
             categoryField: "year",
             name: "Hydro"
         }, {
             field: "wind",
             categoryField: "year",
             name: "Wind"
         }],
         categoryAxis: {
             labels: {
                 rotation: -90
             },
             crosshair: {
                 visible: true
             }
         },
         valueAxis: {
             type: "log",
             labels: {
                 format: "N0"
             },
             minorGridLines: {
                 visible: true
             }
         },
         tooltip: {
             visible: true,
             shared: true,
             format: "N0"
         }
     }); */
}

</script>