<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 03.24 JJW css 추가 -->
<link href="/resources/mes/css/contents/cpk/cpkExcel/cpkExcelForm_JJW.css" rel="stylesheet">

<div class="spreadsheet_wrap" style="width:100%; /* height:45em */"> <!-- 04.06 JJW 수정 -->
	<table style="width:100%; height:100%; table-layout:fixed;">
		<tr>
			<td style="width:60%;">
				<div id="spreadsheet" class="spreadsheet" style="width:100%"></div> 
			</td>
			<td style="width:40%">
				<div id="chart" style="width:100%"></div>
			</td>
		</tr>
	</table>
</div>

<script type="text/javascript">

/**
 * /codeMgt/codeMgtForm
*/
/* 
this.lfn_onChange = function(arg) {
	var spreadsheet = $("#spreadsheet").data("kendoSpreadsheet");
	var sheet = spreadsheet.activeSheet();
	var graphData = new Array();
	for (i=0; i<25; i++) {
		graphData[i] = {};
	}
	
	sheet.range("D2:I26").forEachCell(function(row, col, data){
		switch (col) {
		case 3 :
			graphData[row-1].offset = data.value;
			break;
		case 4 :
			graphData[row-1].halfValue = data.value;
			break;
		case 5 :
			graphData[row-1].maxValue = data.value;
			break;
		case 6 :
			graphData[row-1].minValue = data.value;
			break;
		case 7 :
			graphData[row-1].ucl = data.value;
			break;
		case 8 :
			graphData[row-1].lcl = data.value;
			break;
		}
	});
	lfn_graphDisplay(graphData);
}  */

this.lfn_init = function(param){
	var header = new Array();
	
	header.push({value: "SerialNo", textAlign:"center", background: "rgb(167,214,255)"});
	header.push({value: "PARTNO", textAlign:"center", background: "rgb(167,214,255)"});
	header.push({value: "DIMNO", textAlign:"center", background: "rgb(167,214,255)"});
	header.push({value: "측정값", textAlign:"center", background: "rgb(167,214,255)"});
	header.push({value: "중심규격", textAlign:"center", background: "rgb(167,214,255)"});
	header.push({value: "상한규격", textAlign:"center", background: "rgb(167,214,255)"});
	header.push({value: "하한규격", textAlign:"center", background: "rgb(167,214,255)"});
	header.push({value: "UCL", textAlign:"center", background: "rgb(167,214,255)"});
	header.push({value: "LCL", textAlign:"center", background: "rgb(167,214,255)"});
	
	var row = new Array();
	row.push({ cells: header });
	
	var sheetData = new Array();

	$.ajax({
		async:false,
		url : "/form/cpk/cpkVaneMonitor/getVaneOffsetList",
		type: "POST",
		data: { itemCd: param.itemCd, opNo: param.opNo },
		datatype: "json",
		success: function(data){
			for(var i=1; i<=data.records; i++) {
				sheetData[i-1] = {
					name: "런챠트_DIM" + i,
					mergedCells: [
						"K2:K6",
						"K7:K9",
						"k10:k11",
						"k12:k15",
						"k16:k18",
						"L2:L6",
						"L7:L9",
						"L10:L11",
						"L12:L15",
						"L16:L18"
					],
					rows: row,
					columns: [
						{index:1, width:100},
						{index:12, width:120}
					]
				};
			}
			
			$("#spreadsheet").kendoSpreadsheet({
				render: function(e){
					// do custom height calculations to determine desired height
					e.sender.element.innerHeight("45em");
				},
				/* change: lfn_onChange, */
				sheets: sheetData,
				selectSheet: function(e){
					var fullStr = e.sheet.name();
					var sheetIndex = fullStr.replace("런챠트_DIM","");
					lfn_setSheetData(sheetIndex-1, data.rows[sheetIndex-1]);
				}
			});
			
			lfn_setSheetData(0, data.rows[0]);
		}
	});
	
}

this.lfn_setSheetData = function(sheetIndex, offsetMaster) {
	var spreadsheet = $("#spreadsheet").data("kendoSpreadsheet").sheets();
	$("#spreadsheet").data("kendoSpreadsheet").activeSheet(spreadsheet[sheetIndex]);
	var sheet = $("#spreadsheet").data("kendoSpreadsheet").activeSheet();
	var minValueOpacity = 1;
	var lclOpacity = 1;
	
	var yaxisMax = 0;
	var yaxisMin = 0;
	
	var graphText = "";
	$.ajax({
		/* async:false, */
		url : "/form/cpk/cpkExcel/getCpkOffset",
		type: "POST",
		datatype: "json",
		data: { itemCd: offsetMaster.itemCd, opNo: offsetMaster.opNo, dimNo: offsetMaster.dimNo },
		success: function(data){
			graphText = offsetMaster.itemCd + "\n" + offsetMaster.opNo + "  " + offsetMaster.dimNo;
			
			if(!data.result) {
				kendo.confirm("data가 없습니다.");
				return false;
			} else if(data.result.length == 0) {
				kendo.confirm("data가 없습니다.");
				return false;
			}
			
			yaxisMax = data.result[0].maxValue + (data.result[0].maxValue - data.result[0].minValue) * 0.1;
			
			$.each(data.result, function(index, item) {
				sheet.range("A" + (index+2)).value(item.lotNo);
				sheet.range("C" + (index+2)).value(item.dimNo);
				sheet.range("D" + (index+2)).value(item.graphValue);
			});
			
			sheet.range("E2:E26").value(data.result[0].halfValue);
			sheet.range("F2:F26").value(data.result[0].maxValue);
			sheet.range("G2:G26").value(data.result[0].minValue);
			sheet.range("H2:H26").formula("F2 - (F2-G2)* 0.125");
			
			switch (data.result[0].axiesNo.trim()) {
			case "FLAT":  //형상공차 하한 타겟 0으로
			case "PARALL":
			case "PERP":
			case "TP":
				sheet.range("I2:I26").value(0);
				sheet.range("G2:G26").formula("-(F2)"); //하한공차 임의로 상한의 마이너스 값으로 정의
				minValueOpacity = 0; //하한규격, lcl 투명
				lclOpacity = 0;
				break;
			default:
				sheet.range("I2:I26").formula("G2 + (F2-G2)* 0.125");
				yaxisMin = data.result[0].minValue - (data.result[0].maxValue - data.result[0].minValue) * 0.1;
				break;
			}
			
			/*** 평균의척도 ***/
			sheet.range("K2").value("평\n균\n의\n척\n도").textAlign("center").verticalAlign("center").background("rgb(204,255,255)");
			sheet.range("L2:L6").background("rgb(204,255,255)");
			sheet.range("M2:M6").values([["시료수(n)"],["Max"],["Min"],["평균"],["중앙값"]]).textAlign("center").background("rgb(204,255,255)");
			sheet.range("N2").formula("COUNT(D2:D26)");
			sheet.range("N3").formula("MAX(D2:D26)");
			sheet.range("N4").formula("MIN(D2:D26)");
			sheet.range("N5").formula("AVERAGE(D2:D26)");
			sheet.range("N6").formula("MEDIAN(D2:D26)");
			
			/*** 산포의척도 ***/
			sheet.range("K7").value("산포\n의척도").textAlign("center").verticalAlign("center").background("rgb(153,204,255)");
			sheet.range("L7:L9").background("rgb(153,204,255)");
			sheet.range("M7:M9").values([["범위(R)"],["분산(V)"],["표준편차(σ)"]]).textAlign("center").background("rgb(153,204,255)");
			sheet.range("N7").formula("N3-N4");
			sheet.range("N8").formula("N9^2");
			sheet.range("N9").formula("STDEV.S(D2:D26)");
			
			/*** 신뢰구간 ***/
			sheet.range("K10").value("신뢰\n구간").textAlign("center").verticalAlign("center").background("rgb(192,192,192)");
			sheet.range("L10:L11").background("rgb(192,192,192)");
			sheet.range("M10:M11").values([["95%신뢰상한"],["95%신뢰하한"]]).textAlign("center").background("rgb(192,192,192)");
			sheet.range("N10").formula("NORM.INV(0.975,N5,N9)");
			sheet.range("N11").formula("NORM.INV(0.025,N5,N9)");
			
			/*** 공정능력지수 ***/
			sheet.range("K12").value("공정\n능력\n지수").textAlign("center").verticalAlign("center").background("rgb(255,255,153)");
			sheet.range("L12:L15").background("rgb(255,255,153)");
			sheet.range("M12:M15").values([["Cp"],["Cpk"],["Z bench"],["시그마 수준"]]).textAlign("center").background("rgb(255,255,153)");
			sheet.range("N12").formula("IF(COUNT(F2:G2)=2,(F2-G2)/(6*N9),IF(COUNT(F2)=1,(F2-N5)/(3*N9),(N5-G2)/(3*N9)))");
			sheet.range("N13").formula("IF(COUNT(F2:G2)=2,MIN((F2-N5)/(3*N9),(N5-G2)/(3*N9)),IF(COUNT(F2)=1,(F2-N5)/(3*N9),(N5-G2)/(3*N9)))");
			sheet.range("N14").formula("NORM.S.INV(1-N18)");
			sheet.range("N15").formula("N14+1.5");
			
			/*** 예상불량율 ***/
			sheet.range("K16").value("예상\n불량율").textAlign("center").verticalAlign("center").background("rgb(204,255,204)");
			sheet.range("L16:L18").background("rgb(204,255,204)");
			sheet.range("M16:M18").values([["Su(상한규격)이상"],["SI(하한규격)이하"],["Total불량율"]]).textAlign("center").background("rgb(204,255,204)");
			sheet.range("N16").formula("IF(COUNT(F2)=1,1-NORM.DIST(F2,N5,N9,1),0)");
			sheet.range("N17").formula("IF(COUNT(G2)=1,NORM.DIST(G2,N5,N9,1),0)");
			sheet.range("N18").formula("N16+N17");
			
			var graphData = new Array();
			for (i=0; i<25; i++) {
				graphData[i] = {};
			}
			
			sheet.range("D2:I26").forEachCell(function(row, col, data){
				switch (col) {
				case 3 :
					graphData[row-1].offset = data.value;
					break;
				case 4 :
					graphData[row-1].halfValue = data.value;
					break;
				case 5 :
					graphData[row-1].maxValue = data.value;
					break;
				case 6 :
					graphData[row-1].minValue = data.value;
					break;
				case 7 :
					graphData[row-1].ucl = data.value;
					break;
				case 8 :
					graphData[row-1].lcl = data.value;
					break;
				}
			});
			lfn_graphDisplay(graphData, minValueOpacity, lclOpacity, yaxisMax, yaxisMin, graphText);
		}
	
	});
}

this.lfn_graphDisplay = function(graphData, minValueOpacity, lclOpacity, yaxisMax, yaxisMin, graphText) {
	
	$("#chart").kendoChart({
		dataSource: {
			data: graphData
		},
		title: {
			text: graphText
		},
		legend: {
			position: "top"
		},
		seriesDefaults: {
			type: "line"
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
			}],
			valueAxis: {
				min: yaxisMin,
				max: yaxisMax
			},
			tooltip: {
			visible: true,
			shared: true,
			format: "N0"
		}
	});
}

</script>
