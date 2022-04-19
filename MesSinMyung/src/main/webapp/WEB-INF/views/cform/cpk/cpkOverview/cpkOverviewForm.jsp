<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/cpk/cpkOverview/cpkOverviewForm_JJW.css' rel="stylesheet">

<!-- 이윤민 주임 작업 CSS -->
<!--	<link href='/resources/mes/css/contents/cpk/cpkOverview/cpkOverviewForm_lym.css' rel="stylesheet"> -->
<div id="grid-content" style="width:100%;">
	<div id="tabStrip"></div>
</div>

<input type="hidden" id="autoFlag" value="Run">
<script type="text/javascript">

this.lfn_init = function(){
	lfn_setMachine();
}

this.lfn_setMachine = function() {
	$('#autoFlag').val('Run');
	
	var nowDate = new Date();
	var nowHours = nowDate.getHours(); 
	var shiftTime;
	if(nowHours >= 08 && nowHours < 20) {
		shiftTime = "Day"
	} else {
		shiftTime = "Night";
	}
	
	var machineData;
	$.ajax({
		async:false,
		url: "/cform/cpk/cpkVaneMonitor/getVaneMonitorList",
		type: "POST",
		data: { shiftCd: shiftTime },
		datatype: "json",
		success: function(data){
			machineData = data;
		}
	});

	lfn_setOffset(machineData, machineData.rows, machineData.rows.length, 0);
}

this.lfn_setOffset = function(vaneMonitor, machineData, machineDataLen, recCount) {
	if($('#autoFlag').val() == "Stop") {
		return false;
	}
	
	if(recCount<machineDataLen) {
		$('#tabStrip').empty();
		$.ajax({
			async:false,
			url : "/cform/cpk/cpkVaneMonitor/getVaneOffsetList",
			type: "POST",
			data: { itemCd: machineData[recCount].partNo, opNo: machineData[recCount].opNo },
			datatype: "json",
			success: function(data){
				var tabData = new Array();
				var chartCount = 1;
				var i;
				var temp = "";
				
				for(i=1; chartCount<=data.records; i++) {
					var rowItem = "";
					for(var r=1; r<=2; r++) {
						rowItem += "<tr>";
						for(var c=1; c<=2; c++) {
							if(chartCount > data.records) break;
							rowItem += "<td class='main-td' style='height:15em'><div class='chart-cpk' id='chart" + chartCount + "'></div></td>";

							chartCount++;
						}
						rowItem += "</tr>";
			 		}
					tabData[i-1] = {
						text: "Slide" + i,
						content: "<em class='playButton'></em><em class='stopButton'></em><div class='selMachine'></div><table id='chartTable" + i + "' style='width:100%; height:95%;'>" + rowItem + "</table>"
					};
				}
				
				tabData[i-1] = {
						text: "Slide" + i,
						content: "<em class='playButton'></em><em class='stopButton'></em><div class='selMachine'></div><div id='jteMasterGrid' class='jteGrid' style='width:100%;'></div>"
				};
				
				$("#tabStrip").kendoTabStrip({
					animation: { open: { effects: "fadeIn"} },
					dataTextField: "text",
					dataImageUrlField: "imageUrl",
					dataContentField: "content",
					dataSource: tabData
				}).data("kendoTabStrip").select(0);
				
				for(var i=1; i<=data.records; i++) {
					lfn_graphDisplay(i, data.rows[i-1]);
				} 
				
				lfn_masterGridBind(vaneMonitor);
				
				$(".playButton").kendoButton({
					icon: "play",
					click: function(e) {
						lfn_setMachine();
					}
				});
				
				$(".stopButton").kendoButton({
					icon: "stop",
					click: function(e) {
						$('#autoFlag').val('Stop');
					}
				});
			
				lfn_setSelBox(machineData, vaneMonitor, recCount);
				
				lfn_slideClick(vaneMonitor, $("#tabStrip").data("kendoTabStrip").contentElements.length, 0, machineData, machineDataLen, recCount);
			}
		});
	} else {
		lfn_setOffset(vaneMonitor, machineData, machineDataLen, 0);
	}
}

this.lfn_slideClick = function(vaneMonitor, tabLen, i, machineData, machineDataLen, recCount) {
	setTimeout(function() {
		if($('#autoFlag').val() == "Stop") {
			return false;
		}
		
		if(i<tabLen) {
			i++;
			$("#tabStrip").data("kendoTabStrip").select(i);
			lfn_slideClick(vaneMonitor, tabLen, i, machineData, machineDataLen, recCount);
		} else {
			recCount++;
			$("#tabstrip").empty()
			lfn_setOffset(vaneMonitor, machineData, machineDataLen, recCount);
		}
	},5000);
}

this.lfn_graphDisplay = function(index, offsetMaster) {
	var minValueOpacity = 1;
	var lclOpacity = 1;
	var yaxisMax = 0;
	
	var graphData = new Array();
	for (i=0; i<25; i++) {
		graphData[i] = {};
	}
	var graphText = "";

	var Cpk = 0;
	var Cp = 0;
	
	var halfValue = 0;
	var maxValue = 0;
	var minValue = 0;
	
	$.ajax({
		async:false,
		url : "/cform/cpk/cpkExcel/getCpkOffset",
		type: "POST",
		datatype: "json",
		data: { itemCd: offsetMaster.itemCd, opNo: offsetMaster.opNo, dimNo: offsetMaster.dimNo },
		success: function(data){

			 
				
			graphText = offsetMaster.itemCd + "<br />" + offsetMaster.opNo + "  " + offsetMaster.dimNo;
			
			if(!data.result) {
				yaxisMax = 0;
			} else {
				if(data.result.length != 0 ) {
					yaxisMax = data.result[0].maxValue + (data.result[0].maxValue - data.result[0].minValue) * 0.1;
					halfValue = data.result[0].halfValue.toFixed(3);
					maxValue = Math.abs(data.result[0].maxValue - data.result[0].halfValue).toFixed(3);
					minValue = Math.abs(data.result[0].minValue - data.result[0].halfValue).toFixed(3);
				} else {
					yaxisMax = 0;
				}
			}
			
			$.each(data.result, function(index, item) {
				graphData[index].offset = $(item)[0].graphValue;
				graphData[index].halfValue = $(item)[0].halfValue;
				graphData[index].maxValue = $(item)[0].maxValue;
				graphData[index].minValue = $(item)[0].minValue;
				graphData[index].ucl = $(item)[0].maxValue - ($(item)[0].maxValue-$(item)[0].minValue)*0.125;
				switch ($(item)[0].axiesNo.trim()) {
				case "FLAT":  //형상공차 하한 타겟 0으로
				case "PARALL":
				case "PERP":
				case "TP":
					graphData[index].lcl = 0;
					graphData[index].minValue = -($(item)[0].maxValue); //하한공차 임의로 상한의 마이너스 값으로 정의
					minValueOpacity = 0; //하한규격, lcl 투명
					lclOpacity = 0;
					break;
				default:
					graphData[index].lcl = $(item)[0].minValue + ($(item)[0].maxValue-$(item)[0].minValue)*0.125;
					yaxisMin = $(item)[0].minValue - ($(item)[0].maxValue - $(item)[0].minValue) * 0.1;
					break;
				}
			});
		}
	}); 
	
	var aggTemplate = "";
	
	$.ajax({
		async:false,
		url : "/cform/cpk/cpkExcel/getCpkAggregation",
		type: "POST",
		data: { itemCd: offsetMaster.itemCd, opNo: offsetMaster.opNo, dimNo: offsetMaster.dimNo },
		datatype: "json",
		success: function(data){
			if(!gfn_isNull(graphData[index].maxValue) && !gfn_isNull(graphData[index].minValue)) {
				Cp = ((graphData[index].maxValue - graphData[index].minValue)/(6*data.result[0].stddevCpk));
				if((graphData[index].maxValue - data.result[0].avgCpk)/(3*data.result[0].stddevCpk) >= (data.result[0].avgCpk - graphData[index].minValue)/(3*data.result[0].stddevCpk)) {
					Cpk = (graphData[index].maxValue - data.result[0].avgCpk)/(3*data.result[0].stddevCpk);
				} else {
					Cpk = (data.result[0].avgCpk - graphData[index].minValue)/(3*data.result[0].stddevCpk);
				}
			} else if(!gfn_isNull(graphData[index].maxValue)) {
				Cp = ((graphData[index].maxValue - data.result[0].avgCpk)/(3*data.result[0].stddevCpk));
				Cpk = ((graphData[index].maxValue - data.result[0].avgCpk)/(3*data.result[0].stddevCpk));
			} else {
				Cp = ((data.result[0].avgCpk - graphData[index].minValue)/(3*data.result[0].stddevCpk));
				Cpk = ((data.result[0].avgCpk - graphData[index].minValue)/(3*data.result[0].stddevCpk));
			}
			
			aggTemplate = "<div><table class='main-table'>" +
			"<tr><td class='sub-title-standard' rowspan='2'>" + halfValue + "</td><td class='sub-content-max'>+</td><td class='sub-content-max-value'>" + maxValue + "</td><td rowspan='2' class='main-title'>" + graphText + "</td><td class='sub-title-cp'>CP</td><td class='sub-content-cp'>" + Cp.toFixed(3) + "</td></tr>" +
			"<tr><td class='sub-content-min'>-</td><td class='sub-content-min-value'>" + minValue + "</td><td class='sub-title-cpk'>CPK</td><td class='sub-content-cpk' style='color:red;'>(" + Cpk.toFixed(3) + ")</td></tr>" +
			"</table></div>";
			
			$('#chart' + index).before(aggTemplate);
		}
	});
	
	$("#chart"+ index).kendoChart({
		dataSource: {
			data: graphData
		},
		legend: {
			position: "top"
		},
		seriesDefaults: {
			type: "line"
		},
		chartArea: {
			height: 250
		},
		series: [{
				field: "offset",
				name: "측정값",
				color: "purple",
				markers: {
					visible: true,
					background: "purple"
				}
			}, {
				field: "halfValue",
				name: "중심규격",
				color: "rgb(0,176,80)",
				markers: {
					visible: false,
				},
				dashType: "dot"
			}, {
				field: "maxValue",
				name: "상한규격",
				color: "rgb(255,0,0)",
				markers: {
					visible: false,
				}
			}, {
				field: "minValue",
				name: "하한규격",
				color: "rgb(255,0,0)",
				markers: {
					visible: false,
				},
				opacity: minValueOpacity
			}, {
				field: "ucl",
				name: "UCL",
				color: "rgb(0,176,80)",
				markers: {
					visible: false,
				}
			}, {
				field: "lcl",
				name: "LCL",
				color: "rgb(0,176,80)",
				markers: {
					visible: false,
				},
				opacity: lclOpacity
			}
		],
		valueAxis: {
			min: yaxisMin,
			max: yaxisMax,
			plotBands: [{
				from: graphData[index].lcl,
				to: graphData[index].ucl,
				color: "#b8f3af",
				opacity: 0.3
			}],
		},
		tooltip: {
		visible: true,
		shared: true,
		format: "{0:N3}"
		},
		plotAreaClick: function(e) {
			goMenuToBody({menuId: "cpkOverviewDetail", svcUrl: "/cform/cpk/cpkOverviewDetail", msgId: "mn_cpkOverviewDetail", msgView: "CPK Overview Detail", menuCd: "M", msgIdPath: "CPK Overview Detail", msgViewPath: "CPK Overview Detail", duplYn: "Y"}, 
					{data: e.sender.dataSource.data(), title: graphText, cpkVal: Cpk, cpVal: Cp, maxVal: maxValue, halfVal: halfValue, minVal: minValue, yMax: e.sender.options.valueAxis.max, yMin: e.sender.options.valueAxis.min});
		}
	});
	

}

this.lfn_masterGridBind = function(machineData) {
	$("#jteMasterGrid").kendoGrid({
		dataSource: {
			data: machineData,
			schema: {
				data: "rows",
				total: "count"
			},
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
		editable: {
			mode:"popup"
		},
		dataBound: function(e){
			var rows = e.sender.content.find('tr');
		    var performance = e.sender.wrapper.find(".k-grid-header [data-field=" + "performance" + "]").index();
		    rows.each(function(index, row){
		    var dataItem = e.sender.dataItem(row);
		      
		      if(dataItem.actQty == null) {
		    	  dataItem.actQty = 0;
		      }
		      
		      
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
				{ field: "elapsedTime", title: "Elapsed time", format: "{0:0.0'%'}", width: "10%" },
				{ field: "utilizationRate", title: "Utilization_Rate", format: "{0:0.0'%'}", width: "10%" }
		]
	});
}

//Master Grid Select Box Binding
this.lfn_setSelBox = function(machineData, vaneMonitor, recCount){
	var data = new Array();
	var dataValue = "";
	var index = recCount;
	
	$.each(machineData, function(index, item) {
		dataValue = item.partNo + ";" + item.opNo;
		data[index] = { text: item.machineCd, value: dataValue }
	});
	
	$(".selMachine").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: data,
		index: recCount,
		change: function(e) {
			if($('#autoFlag').val() == "Stop") {
				lfn_manual(this.value(), vaneMonitor, machineData, e.sender.selectedIndex);
			} else {
				kendo.confirm("정지 버튼을 클릭하신 후 선택하여 주십시오.(Manual Option)");
			}
		}
	});	
}

this.lfn_manual = function(param, vaneMonitor, machineData, selectedIndex){
	$('#tabStrip').empty();	
	
	var machineParam = param.split(";");
	$.ajax({
		async:false,
		url : "/cform/cpk/cpkVaneMonitor/getVaneOffsetList",
		type: "POST",
		data: { itemCd: machineParam[0], opNo: machineParam[1] },
		datatype: "json",
		success: function(data){
			var tabData = new Array();
			var chartCount = 1;
			var i;
			for(i=1; chartCount<=data.records; i++) {
				var rowItem = "";
				for(var r=1; r<=3; r++) {
					rowItem += "<tr>";
					for(var c=1; c<=3; c++) {
						rowItem += "<td style='width:33.3%;'><div id='chart" + chartCount + "'></div></td>";
						chartCount++;
					}
					rowItem += "</tr>";
		 		}
				tabData[i-1] = {
					text: "Slide" + i,
					content: "<em class='playButton'></em><em class='stopButton'></em><div class='selMachine'></div><table id='chartTable" + i + "' style='width:100%'>" + rowItem + "</table>"
				};
			}
			
			tabData[i-1] = {
					text: "Slide" + i,
					content: "<em class='playButton'></em><em class='stopButton'></em><div class='selMachine'></div><div id='jteMasterGrid' class='jteGrid' style='width:100%;'></div>"
			};
			
			$("#tabStrip").kendoTabStrip({
				animation: { open: { effects: "fadeIn"} },
				dataTextField: "text",
				dataImageUrlField: "imageUrl",
				dataContentField: "content",
				dataSource: tabData
			}).data("kendoTabStrip").select(0);
			
			for(var i=1; i<=data.records; i++) {
				lfn_graphDisplay(i, data.rows[i-1]);
			}
			lfn_masterGridBind(vaneMonitor);
			
			$(".playButton").kendoButton({
		    	icon: "play",
		    	click: function(e) {
		    		lfn_setMachine();
		    	}
		    });
		    
			$(".stopButton").kendoButton({
		    	icon: "stop",
		    	click: function(e) {
		    		$('#autoFlag').val('Stop');
		    	}
		    });
			
			lfn_setSelBox(machineData, vaneMonitor, selectedIndex);
		}
	});
	
}
</script>
