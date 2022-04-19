<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="performOrderChartForm">
	<div class="performOrderChartForm search-btn-area">
		<input id="searchTime" style="width:250px;">
		<input id="dataLimit">
		<input id="eqmtMgtId">
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_orderInfo();"><spring:message code = "btn_search"/></button>
	</div>
	<div id="pdmChart"></div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/perform/performOrderChart/performOrderChartForm_lym.css' rel="stylesheet">  -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/perform/performOrderChart/performOrderChartForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200501 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//검색 Selectbox 바인딩 
	var data = [
			{ text: "No 1.", value: "NO1" },
			{ text: "No 2.", value: "NO2" },
			{ text: "No 3.", value: "NO3" },
			{ text: "No 4.", value: "NO4" },
			{ text: "No 5.", value: "NO5" },
			{ text: "No 6.", value: "NO6" },
			{ text: "No 7.", value: "NO7" },
			{ text: "No 8.", value: "NO8" },
			{ text: "No 9.", value: "NO9" },
			{ text: "No 10.", value: "NO10" }
		];
	
	$("#eqmtMgtId").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: data,
		index: 0
	});
	
/* 	lfn_orderChartDisplay(); */
	lfn_setDateTimePicker();
	lfn_setNumericBox();
};

this.lfn_setDateTimePicker = function() {
	$("#searchTime").kendoDateTimePicker({
		culture:"ko-KR",
		format:'yyyy-MM-dd HH:mm:ss',
		timeFormat: "HH:mm"
	});
}

this.lfn_setNumericBox = function() {
	$("#dataLimit").kendoNumericTextBox({
		format: "n0",
	});
	$("#dataLimit").data("kendoNumericTextBox").value(900);
}

this.lfn_orderInfo = function() {
	lfn_orderChartDisplay();
}

this.lfn_orderChartDisplay = function() {
	
	if($("#dataLimit").data("kendoNumericTextBox").value() > 1800) {
		kendo.confirm("1800 건을 초과하여 조회 할 수 없습니다.");
		return false;
	}
	
	var date = new Array();
	var sensorData1 = new Array();
	var sensorData2 = new Array();
	var sensorData3 = new Array();
	
	var sensorData = new Array();
	
	$.ajax({
		async:false,
		url : '/cform/facilMgt/prevMgt/selectPdmData',
		type: "POST",
		data: { searchTime: $('#searchTime').val(), dataLimit: $("#dataLimit").val() },
		success: function(data){
			$.each(data.rows, function(index, item) {
				date.push(item.date);

				/*** 설비 10개 하드코딩. 실제 설비 ID 변경 시 변경해줄 것_20200820 PGW ***/
				if($('#eqmtMgtId').val() == 'NO1') {
					sensorData.push({sensor1: item.a0001, sensor2: item.a0002, sensor3: item.a0003})
					/* sensorData1.push(item.a0001);
					sensorData2.push(item.a0002);
					sensorData3.push(item.a0003); */
				} else if($('#eqmtMgtId').val() == 'NO2') {
					sensorData.push({sensor1: item.a0004, sensor2: item.a0005, sensor3: item.a0006})
					/* sensorData1.push(item.a0004);
					sensorData2.push(item.a0005);
					sensorData3.push(item.a0006); */
				} else if($('#eqmtMgtId').val() == 'NO3') {
					sensorData.push({sensor1: item.a0007, sensor2: item.a0008, sensor3: item.a0009})
					/* sensorData1.push(item.a0007);
					sensorData2.push(item.a0008);
					sensorData3.push(item.a0009); */
				} else if($('#eqmtMgtId').val() == 'NO4') {
					sensorData.push({sensor1: item.a0010, sensor2: item.a0011, sensor3: item.a0012})
					/* sensorData1.push(item.a0010);
					sensorData2.push(item.a0011);
					sensorData3.push(item.a0012); */
				} else if($('#eqmtMgtId').val() == 'NO5') {
					sensorData.push({sensor1: item.a0013, sensor2: item.a0014, sensor3: item.a0015})
					/* sensorData1.push(item.a0013);
					sensorData2.push(item.a0014);
					sensorData3.push(item.a0015); */
				} else if($('#eqmtMgtId').val() == 'NO6') {
					sensorData.push({sensor1: item.a0016, sensor2: item.a0017, sensor3: item.a0018})
					/* sensorData1.push(item.a0016);
					sensorData2.push(item.a0017);
					sensorData3.push(item.a0018); */
				} else if($('#eqmtMgtId').val() == 'NO7') {
					sensorData.push({sensor1: item.a0019, sensor2: item.a0020, sensor3: item.a0021})
					/* sensorData1.push(item.a0019);
					sensorData2.push(item.a0020);
					sensorData3.push(item.a0021); */
				} else if($('#eqmtMgtId').val() == 'NO8') {
					sensorData.push({sensor1: item.a0022, sensor2: item.a0023, sensor3: item.a0024})
					/* sensorData1.push(item.a0022);
					sensorData2.push(item.a0023);
					sensorData3.push(item.a0024); */
				} else if($('#eqmtMgtId').val() == 'NO9') {
					sensorData.push({sensor1: item.a0025, sensor2: item.a0026, sensor3: item.a0027})
					/* sensorData1.push(item.a0025);
					sensorData2.push(item.a0026);
					sensorData3.push(item.a0027); */
				} else if($('#eqmtMgtId').val() == 'NO10') {
					sensorData.push({sensor1: item.a0028, sensor2: item.a0029, sensor3: item.a0030})
					/* sensorData1.push(item.a0028);
					sensorData2.push(item.a0029);
					sensorData3.push(item.a0030); */
				}
			});
		},
		error : function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
		}
	});
	
	 $("#pdmChart").kendoChart({
		/* renderAs: "canvas", */
		title: {
			text: "Sensor Trend Graph"
		},
		legend: {
			position: "bottom"
		},
		series: [{
			type: "line",
			data: sensorData,
			field: "sensor1",
			name: "Sensor 1",
			color: "#ff1c1c",
			axis: "Sencor1",
			markers: {
				visible: false,
			}
		}, {
			type: "line",
			data: sensorData,
			field: "sensor2",
			name: "Sensor 2",
			color: "#ffae00",
			axis: "Sencor2",
			markers: {
				visible: false,
			}
		}, {
			type: "line",
			data: sensorData,
			field: "sensor3",
			name: "Sensor 3",
			color: "#FFCCA9",
			axis: "Sencor3",
			markers: {
				visible: false,
			}
		}],
		valueAxes: [{
			name: "Sencor1",
			color: "#ff1c1c",
			min: -20,
			max: 70
		}, {
			name: "Sencor2",
			color: "#ffae00",
			min: -45,
			max: 55
		}, {
			name: "Sencor3",
			color: "#FFCCA9",
			min: -70,
			max: 40
		}],
		categoryAxis: {
			minorGridLines: {visible: false},
			majorGridLines: {visible: false},
			categories: date,
			axisCrossingValues: [0, 0],
			labels: false,
			justified: true
		},
		tooltip: {
			visible: true,
			format: "{0}",
			template: "#= category #/data: #= value #"
		},
		transitions: false
	});
	
}
</script>