<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link href='/resources/mes/css/contents/cpk/cpkOverview/cpkOverviewForm_JJW.css' rel="stylesheet">

<div>
	<table class='main-table'>
		<tr>
			<td id='halfValue' class='sub-title-standard' rowspan='2'></td>
			<td class='sub-content-max'>+</td>
			<td id='maxValue' class='sub-content-max-value'></td>
			<td id='graphText' rowspan='2' class='main-title'></td>
			<td class='sub-title-cp'>CP</td>
			<td id='Cp' class='sub-content-cp'></td>
		</tr>
		<tr>
			<td class='sub-content-min'>-</td>
			<td id='minValue' class='sub-content-min-value'></td>
			<td class='sub-title-cpk'>CPK</td>
			<td id='Cpk' class='sub-content-cpk' style='color:red;'></td>
		</tr>
	</table>
</div>
<div id="chart" style="width:100%; height:45em">
	
</div>

<script type="text/javascript">

this.lfn_init = function(param){
	
	$('#halfValue').text(parseFloat(param.halfVal).toFixed(3));
	$('#maxValue').text(parseFloat(param.maxVal).toFixed(3));
	$('#minValue').text(parseFloat(param.minVal).toFixed(3));
	$('#Cp').text(parseFloat(param.cpVal).toFixed(3));
	$('#Cpk').text("(" + parseFloat(param.cpkVal).toFixed(3) + ")");
	$('#graphText').append($.parseHTML(param.title));
	
	$("#chart").kendoChart({
		dataSource: {
			data: param.data
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
				}
				/* ,opacity: minValueOpacity */
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
				}
				/* ,opacity: lclOpacity */
			}
		],
		valueAxis: {
			min: param.yMin,
			max: param.yMax,
			plotBands: [{
				from: param.data[0].lcl,
				to: param.data[0].
				ucl,
				color: "#b8f3af",
				opacity: 0.3
			}],
		},
		tooltip: {
			visible: true,
			shared: true,
			format: "{0:N3}",
			color: "black"
		}
	});
}
</script>
