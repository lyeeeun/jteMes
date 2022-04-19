var Conf_json;
$(document).ready( function() {
	//Create Progressbar
	showProgressBar();
	
	//검색 Select 박스 생성
	setSearchCombo();
	
	$(".orderListItem").eq(0).click();
	//finish ProgressBar
	closeProgressBar();
});

//검색 Combo 박스 생성
function setSearchCombo(){
	var comboData = [{"id":"name","text":"NAME","selected":true},{"id":"code","text":"CODE"}];
	if($("#hidCombo").val() == "code"){
		comboData = [{"id":"name","text":"NAME"},{"id":"code","text":"CODE","selected":true}];
	}
	$("#worksCombo").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
}

//검색 엔터 이벤트
$('#worksText').textbox({
	inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		keyup:function(e){
			if (e.keyCode == 13) {
				searchBtn();
			}
		}
	})
});

//검색 실행(메뉴정보를 보내기 위해 하드코딩 추후 메뉴 DB 구성 시 서비스단에서 처리하는걸로 변경필요)
function searchBtn(){
	var form =  document.forms['worksSearchForm'];
	var objs;
	objs = document.createElement('input');
	objs.setAttribute('type', 'hidden');
	objs.setAttribute('name', 'name');
	objs.setAttribute('value', "maintenance_history");
	form.appendChild(objs);
	
	objs = null;
	objs = document.createElement('input');
	objs.setAttribute('type', 'hidden');
	objs.setAttribute('name', 'title');
	objs.setAttribute('value', "MaintenanceHistory");
	form.appendChild(objs);
	$(form).submit();
}

//검색된 항목 클릭 시 해당 항목 상세 조회
function worksItemSelectOne(cd_01,cd_02,cd_03,cd_04,cd_05,desc){
	return new Promise(function(resolve,reject){
		//Create Progressbar
		showProgressBar();
		
		$("#runhourDesc").text(desc);
		var data = {"pmsCd01":cd_01,"pmsCd02":cd_02,"pmsCd03":cd_03,"pmsCd04":cd_04,"pmsCd05":cd_05};
		$.ajax({
			url: "/getAllHistoryList",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				resolve(history_callback(result));
			}
		});
	});
}

//검색된 항목 클릭 시 해당 항목 상세 조회 콜백
function history_callback(result){
	var jsonParent = result.parent;
	var jsonChild = result.child;
	
	$('#history_engine_body').empty();
	$("#history_cylinder_body").empty();
//	$("#hidEngineId").val("");
//	$("#hidParentId").val("");
//	$("#history_detail_div").hide();
	
	//parent
	if(jsonParent.length > 0){
		var histotyEngineHtml = "<tr><td>Engine No.</td>";
		for(var i = 0; i < jsonParent.length; i++){
			
			var rhIcon = "";
			var runAlarm = jsonParent[i].runAlarm;
			if(runAlarm < 72 && runAlarm > 0){
				rhIcon = '<i class="fas fa-wrench" style="color:green;"></i>';
			}else if(runAlarm <= 0){
				rhIcon = '<i class="fas fa-wrench" style="color:red;"></i>';
			}
			
			histotyEngineHtml += "<td class='engCell histEngItem_"+jsonParent[i].engineId+"' onclick='historyItemSelectOne(\""+jsonParent[i].engineId+"\"),engCellSelected(this)'>"
			+ rhIcon
			+ jsonParent[i].engineId+"</td>";
		}
		histotyEngineHtml += "</tr>";
		
		$("#history_engine_body").append(histotyEngineHtml);
	}
	
	//Child
	if(jsonChild.length > 0){
		
		var engCount = jsonParent.length;
		
		//실린더 Table Row 수 
		var cylRow = Math.ceil((jsonChild.length) /engCount);
		
		//Row수 증가 카운트
		var appendRow = jsonChild.length - engCount;
		
		var cylBodyHtml = "<tr><td rowspan="+cylRow+">Cyliender No.</td>";//첫 번째 row
		for(i = 0; i < cylRow; i++){
			if(i != 0){
				cylBodyHtml +="<tr>"//2~n 번째 row
			}
			//한 row에 engineCount 만큼만 출력(1~10, 11~20, 21~30 ... 등)
			var rowCount = 0;
			if(jsonChild.length <= engCount){
				rowCount = jsonChild.length;
			}else{
				rowCount = jsonChild.length - appendRow;
				if(rowCount > jsonChild.length){
					rowCount = jsonChild.length;	
				}
			}
			for(j = i*engCount; j<rowCount; j++){
				
				var rhIcon = "";
				var runAlarm = jsonChild[j].runAlarm;
				if(runAlarm < 72 && runAlarm > 0){
					rhIcon = '<i class="fas fa-wrench" style="color:green;"></i>';
				}else if(runAlarm <= 0){
					rhIcon = '<i class="fas fa-wrench" style="color:red;"></i>';
				}
				
				
				cylBodyHtml +="<td class='engCell histEngItem_"+jsonChild[j].engineId+"' onclick='historyItemSelectOne(\""+jsonChild[j].engineId+"\"),engCellSelected(this)'>"
				+ rhIcon
				+ jsonChild[j].engineId+"</td>"

			}
			appendRow -= engCount;
			cylBodyHtml += "</tr>";
		}
		
		$("#history_cylinder_body").append(cylBodyHtml);
	}
	
	$("#hidPmsCd01").val(jsonParent[0].pmsTechOrderPk.pmsCd01);
	$("#hidPmsCd02").val(jsonParent[0].pmsTechOrderPk.pmsCd02);
	$("#hidPmsCd03").val(jsonParent[0].pmsTechOrderPk.pmsCd03);
	$("#hidPmsCd04").val(jsonParent[0].pmsTechOrderPk.pmsCd04);
	$("#hidPmsCd05").val(jsonParent[0].pmsTechOrderPk.pmsCd05);
	
	$("#pms_order_table").show();
	$("#history_table").show();
	//첫번째 엔진 선택 - 요청사항
	$(".engCell").eq(0).click();
	
	//finish ProgressBar
	closeProgressBar();
}

//조회된 Eng, Cyl 리스트 history 조회(Click Event)
function historyItemSelectOne(engineId){
	//Create Progressbar
	showProgressBar();
	
	var targetOrder01 = document.getElementById("hidPmsCd01").value;
	var targetOrder02 = document.getElementById("hidPmsCd02").value;
	var targetOrder03 = document.getElementById("hidPmsCd03").value;
	var targetOrder04 = document.getElementById("hidPmsCd04").value;
	var targetOrder05 = document.getElementById("hidPmsCd05").value;
	
	var data = {"pmsTechOrderPk":{"pmsCd01":targetOrder01,"pmsCd02":targetOrder02,"pmsCd03":targetOrder03,"pmsCd04":targetOrder04,"pmsCd05":targetOrder05}};
	if(typeof(engineId) == "object"){
		data["engineList"] = engineId
	}else if(typeof(engineId) == "string"){
		data["engineId"] = engineId
	}
	
	$.ajax({
		url: "/getMainHistoryDetail",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			historyDeatil_callback(result);
		}
	});
}

//조회된 Eng, Cyl 리스트 history 조회 - callback(Click Event)
function historyDeatil_callback(result){
	
	var jsonData = result;
	
	$("#history_detail_body").empty();
	if(jsonData.length > 0){
		
		for(i=0; i<jsonData.length; i++){
			var tdEquip;
			var tdParent;
			var toChild;
			if(jsonData[i].parentId == null){
				tdEquip = "Eng";
				tdParent = jsonData[i].engineId;
				toChild = "";
			}else{
				tdEquip = "Cyl";
				tdParent = jsonData[i].parentId;
				toChild = jsonData[i].engineId
			}
			
			//runninghour 아이콘
			var rhIcon = "";
			var runAlarm = jsonData[i].runAlarm;
			if(runAlarm < 72 && runAlarm > 0){
				rhIcon = '<i class="fas fa-wrench" style="color:green;"></i>';
			}else if(runAlarm <= 0){
				rhIcon = '<i class="fas fa-wrench" style="color:red;"></i>';
			}
			
			$('#history_detail_body').append("<tr>" +
					"<td style='text-align:center'>" + rhIcon +tdEquip + "</td>" +
					"<td style='text-align:center'>" + dateToString(new Date(jsonData[i].atFixedDate)) + "</td>" +
					"<td style='text-align:center'>" + jsonData[i].atFixedHour + "</td>" +
					"<td style='text-align:center'>" + jsonData[i].runTime + "</td>" +
					"<td>" + jsonData[i].lastWorkNoti + "</td>" +
					"<td style='text-align:center'>" + tdParent + "</td>" +
					"<td style='text-align:center'>"+ toChild +"</td>"+
					"</tr>");
		}
		
		$("#hidEngineId").val(jsonData[0].engineId);
		$("#runhourBaseText").text(jsonData[0].atFixedHour);
		$("#history_detail_table").show();
		$("#histroy_RH_table").show();
		$("#histoty_graph").show();
		graph_search(jsonData);
		
		//finish ProgressBar
		closeProgressBar();
	}
}
//interval 저장 버튼
function runHourSaveBtn(){
	//Create Progressbar
	showProgressBar();
	
	var targetOrder01 = document.getElementById("hidPmsCd01").value;
	var targetOrder02 = document.getElementById("hidPmsCd02").value;
	var targetOrder03 = document.getElementById("hidPmsCd03").value;
	var targetOrder04 = document.getElementById("hidPmsCd04").value;
	var targetOrder05 = document.getElementById("hidPmsCd05").value;
	
	var data = {"engineId":$("#hidEngineId").val(),"atFixedHour":$("#runhourInterval").val(),
			"pmsCd01":targetOrder01,"pmsCd02":targetOrder02,"pmsCd03":targetOrder03,"pmsCd04":targetOrder04,"pmsCd05":targetOrder05,
			"fromDate":$("#runhourFDate").val(), "toDate":$("#runhourTDate").val()};
	
	$.ajax({
		url: "/setHisoryRhMod",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result =="SUCCESS"){
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','성공적으로 등록되었습니다','info',function(){
					worksItemSelectOne($("#hidPmsCd01").val(),$("#hidPmsCd02").val(),$("#hidPmsCd03").val(),$("#hidPmsCd04").val(),$("#hidPmsCd05").val()).then(function(){
						$(".histEngItem_"+$("#hidEngineId").val()).click();						
					})
				});
				
			}else{
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','알 수 없는 에러가 발생하였습니다. 관리자에게 문의해주시기 바랍니다.','error');
			}
		}
	});
}
//interval 추이 그래프 function
function graph_search(jsonData) {
	
	var graphData = new Array();
	
	for(i=0; i<jsonData.length; i++){
		
		var Mdate = new Array();
		var Mvalue = new Array();
		
		var startDate = dateToString(new Date(jsonData[i].atFixedDate));
		var maxHour = jsonData[i].atFixedHour*1.5;
		for(j = 0; j<=maxHour; j+=24){
			Mdate.push(dateCalc(startDate, j * 60 * 60));
			Mvalue.push(j);
		}
		var tagName ="";
		if(jsonData[i].parentId == null){
			tagName = jsonData[i].engineId;
		}else{
			tagName = jsonData[i].parentId +"-"+jsonData[i].engineId;
		}
			
		var trace1 = {
				type: "scatter",
				mode: "lines",
				name: tagName,
				x: Mdate,
				y: Mvalue,
				text: Mvalue,
				hoverlabel: {namelength :-1, font: {
					family: 'Courier New, monospace',
					size: 13
				}},
				hoverinfo: "text+name",
				line: {color: '#' + Math.floor( Math.random() * 16777215).toString(16), width: 0.8}
		}
				
		graphData.push(trace1);
	}
	var layout = {
			paper_bgcolor: '#f2f2f2',
			plot_bgcolor: '#f2f2f2',
			xaxis: {
				autorange: true, 
			},
			yaxis: {
				autorange: true,
				type: 'linear',
				tickformat: ',d'
			},
			marker: {
				color: "blue",
				size: 12
			}
		};
			
	Plotly.newPlot('histoty_graph', graphData, layout);
	
}

//스타일 관련 js
//$("input[name='runhourInterval']").keyup(function(){
//	alert("zz");
//})
//interval 입력
//$('#runhourInterval').numberbox().bind('keyup',function(e){
//	alert("zz");
//	$("#runhourChText").text($('#runhourInterval').val());
//});
$('#runhourInterval').numberbox({
		inputEvents: $.extend({}, $.fn.numberbox.defaults.inputEvents, {
				keypress: function(e){
			}
		})
})

//orderList 클릭 이벤트
function orderListSelected(objSpan){
	$(objSpan).closest("div").find(".orderListSelected").each(function(){
			$(this).removeClass("orderListSelected")
	});
	$(objSpan).addClass("orderListSelected");
}

//EngineList 클릭 이벤트
function engCellSelected(objSpan){
	$(objSpan).closest("table").find(".engSelected").each(function(){
			$(this).removeClass("engSelected")
	});
	$(objSpan).addClass("engSelected");
}
	