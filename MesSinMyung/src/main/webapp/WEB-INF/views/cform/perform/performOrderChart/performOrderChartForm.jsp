<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="performOrderChartForm">
	<div class="performOrderChartForm search-btn-area">
		<input type="text" class="k-textbox" id="orderId" readonly/>
		<!-- <input type="hidden" id="orderId"> -->
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_orderInfo();"><spring:message code = "btn_search"/></button>
	</div>
	<table class="performOrderChartForm-table">
		<colgroup>
			<col class="col-left-content"> 
			<col class="col-right-content">
		</colgroup>
		<tr>
			<td class="left-content-box">
				<div id="performOrderChart"></div>
			</td>
			<td class="right-content-box">
				<div id="performInfoChart"></div>
			</td>
		</tr>
	</table>
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
	lfn_chartDisplay();
	lfn_orderChartDisplay();
};

this.lfn_orderInfo = function() {
	var callback = function(selectedItem){
		$('#orderId').val(selectedItem.orderId);
		/* $('#orderNm').val(selectedItem.orderNm); */
		
		lfn_chartDisplay();
		lfn_orderChartDisplay();
	};
	gfn_openCustomPop('orderInfo',callback);
}

this.lfn_orderChartDisplay = function() {
	
	$.ajax({
		async:false,
		url : '/cform/perform/performOrderChart/getPerformTotalOrderChart',
		type: "POST",
		data: {orderId: $('#orderId').val()},
		success: function(data){
			if(data.rows[0] == null) {
				var output = 0;
				var remain = 100;
			} else {
				var output = data.rows[0].lotTotalGoodRate;
				var remain = data.rows[0].lotTotalRemainRate;
				if(remain < 0) {
					remain = 0;
				}
			}
			
			
			$("#performOrderChart").kendoChart({
	            title: {
	                text: "프로젝트 전체 진척 현황",
	                font: "26px Helvetica", // 200501 JJW 제목 사이즈 변경 (원래는 없었는데 새로 추가)
	                color: " #000000", // 200501 JJW 제목 색상 변경 #000000 (원래는 없었는데 새로 추가) LYM #FFFFFF
	                background: "#f2f6fc"// 200501 JJW 제목 바탕 변경 #f2f6fc (원래는 없었는데 새로 추가) LYM #081332
	            },
	            legend: {
	               position: "top",
	               labels: { // 200501 JJW 위쪽 색상 표시 사이즈 변경 (원래는 없었는데 새로 추가)
	                   font: "20px Helvetica"}
	            },
	            seriesDefaults: {
	                labels: {
	                    template: "#= category # - #= kendo.format('{0:P}', percentage)#",
	                    position: "outsideEnd",
	                    visible: true,
	                    background: "transparent",
	                    font: "20px Helvetica", // 200501 JJW 도넛 차트 폰트 사이즈 변경 (원래는 없었는데 새로 추가)
	                }
	            },
	            series: [{
	                type: "donut",
	                data: [{
	                    category: "생산량",
	                    value: output,
	                    color:  "#2464ed" // 200501 JJW #2464ed 원형그래프 진한 색상 변경 LYM #2794c1
	                }, {
	                    category: "남은 생산량",
	                    value: remain,
	                    color: "#92B5FC" // 200501 JJW #92B5FC 원형그래프 연한 색상 변경 LYM #299bc9
	                }]
	            }],
	            tooltip: {
	                visible: true,
	                template: "#= category # - #= kendo.format('{0:P}', percentage) #"
	            }
	        });
		},
		error : function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
		}
	});
	
}
this.lfn_chartDisplay = function() {
	$.ajax({
		async:false,
		url : '/cform/perform/performOrderChart/getPerformOrderChart',
		type: "POST",
		data: {orderId: $('#orderId').val()},
		success: function(data){
			
			var output = new Array();
			var remain = new Array();
			var defect = new Array();
			var itemNm = new Array();
			
			
			$.each(data.rows, function(index, item) {
				output.push(item.lotAchieve);
				if(item.lotRemain < 0) {
					item.lotRemain = 0;
				}
				remain.push(item.lotRemain);
				defect.push(item.lotDefect);
				itemNm.push(item.itemNm);
			});
			
			
			  $("#performInfoChart").kendoChart({
	                title: {
	                    text: $('#orderId').val() + " 프로젝트 Lot 별 실적 정보",
	                    font: "26px Helvetica", // 200501 JJW 제목 사이즈 변경 (원래는 없었는데 새로 추가)
	                    color: "#000000", // 200501 JJW #000000 제목 색상 변경 (원래는 없었는데 새로 추가) LYM #FFFFFF
	                    background: "#f2f6fc" // 200501 JJW #f2f6fc제목 바탕 변경 (원래는 없었는데 새로 추가) LYM #081332
	                },
	                legend: {
	                    visible: false
	                },
	                seriesDefaults: {
	                    type: "bar",
	                    stack: {
	                        type: "100%"
	                    }
	                },
	                series: [{
	                    name: "생산량",
	                    stack: {
	                        group: "goods"
	                    },
	                    data: output
	                }, {
	                    name: "남은 생산량",
	                    stack: {
	                        group: "goods"
	                    },
	                    data: remain
	                }, {
	                    name: "불량 수",
	                    stack: {
	                        group: "defect"
	                    },
	                    data: defect
	                }],
	                seriesColors: [ "#2464ed", "#92B5FC",
	                	"#ff4765", "#ffbfca"], // 200501 JJW 오른쪽 차트 색상 변경 ( 차례대로 생산량 #2464ed, 남은 생산량 #92B5FC, 불량수 #ff4765, 미불량수 #ffbfca)
	                valueAxis: {
	                    line: {
	                        visible: false
	                    }
	                },
	                categoryAxis: {
	                    categories: itemNm,
	                    majorGridLines: {
	                        visible: false
	                    }
	                },
	                tooltip: {
	                    visible: true,
	                    template: "#= series.name #: #= value #"
	                }
	            });
		},
		error : function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
		}
	});
}
</script>