<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="performOrderChartForm">
	<div class="performOrderChartForm search-btn-area">
		<input type="text" class="k-textbox" id="itemNm" readonly/>
		<input type="hidden" id="itemId">
		<button class="k-button k-primary page-search-btn" type="button" id="itemSelBtn" onclick= "lfn_itemInfo();"><spring:message code = "btn_search"/></button>
	</div>
	<table class="performOrderChartForm-table">
		<colgroup>
			<col class="col-content">
		</colgroup>
		<tr>
			<td class="left-content-box">
				<div id="performOrderChart"></div>
			</td>
		</tr>
	</table>
</div>

<link href='/resources/mes/css/contents/perform/performOrderChart/performOrderChartForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//lfn_chartDisplay();
};

this.lfn_itemInfo = function() {
	var callback = function(selectedItem){
		$('#itemId').val(selectedItem.itemId);
		$('#itemNm').val(selectedItem.itemNm);
		
		lfn_chartDisplay();
	};
	gfn_openCustomPop('item', callback);
}


this.lfn_chartDisplay = function() {
	$('.performOrderChartForm .performOrderChartForm-table .left-content-box').css({"border": "2px solid #C7D5F4"});
	$.ajax({
		async:false,
		url : '/cform/perform/performOrderGrid/getPerformOrder',
		type: "POST",
		data: {itemId: $('#itemId').val()},
		success: function(data){
			if(data.rows[0] == null) {
				var output = 0;
				var remain = 100;
			} else {
				var output = data.rows[0].itemTotalGoodRate;
				var remain = data.rows[0].itemTotalRemainRate;
				if(remain < 0) {
					remain = 0;
				}
			}
			
			$("#performOrderChart").kendoChart({
	            title: {
	                text: $('#itemNm').val()+" 생산 현황",
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
	                template: "#= category # - #= kendo.format('{0:P}', percentage) #",
	                color: " #000000"
	            }
	        });
		},
		error : function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
		}
	});
	
}

</script>