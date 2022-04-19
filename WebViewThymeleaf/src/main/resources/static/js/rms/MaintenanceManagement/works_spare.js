var engCount;
var histEngComboData;
var histCylComboData;

$(document).ready( function () {
	//검색 Select 박스 생성
	setSearchCombo();
	
	//LastHistory - Date 구분 박스 생성
	setHistoryDateCombo();
	
	//LastHistory - OverHaul 구분박스 생성
	setHistoryOverHaulCombo();
	
	//화면 로딩 시 첫 Item 선택 - 요청사항
	$(".orderListItem").eq(0).click();
});

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
//history Date Combo 박스 생성
function setHistoryDateCombo(){
	var comboData = [{"id":"NOW","text":"NowTime","selected":true},{"id":"SELF","text":"direct Input"}];
//	if($("#hidCombo").val() == "code"){
//		comboData = [{"id":"name","text":"NAME"},{"id":"code","text":"CODE","selected":true}];
//	}
	$("#historyDateCombo").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
}

//history Overhaul Combo 박스 생성
function setHistoryOverHaulCombo(){
	var comboData = [{"id":"Auto","text":"Auto","selected":true},{"id":"SELF","text":"direct Input"}];
	$("#overHaulCombo").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
}

//검색 실행(메뉴정보를 보내기 위해 하드코딩 추후 메뉴 DB 구성 시 서비스단에서 처리하는걸로 변경필요)
function searchBtn(){
	var form =  document.forms['worksSearchForm'];
	var objs;
	objs = document.createElement('input');
	objs.setAttribute('type', 'hidden');
	objs.setAttribute('name', 'name');
	objs.setAttribute('value', "works_spare");
	form.appendChild(objs);
	
	objs = null;
	objs = document.createElement('input');
	objs.setAttribute('type', 'hidden');
	objs.setAttribute('name', 'title');
	objs.setAttribute('value', "works_spare");
	form.appendChild(objs);
	$(form).submit();
}

//검색된 항목 클릭 시 해당 항목 상세 조회
function worksItemSelectOne(cd_01,cd_02,cd_03,cd_04,cd_05,desc){
	//Create Progressbar
	showProgressBar();
	
	var data = {"pmsTechOrderPk":{"pmsCd01":cd_01,"pmsCd02":cd_02,"pmsCd03":cd_03,"pmsCd04":cd_04,"pmsCd05":cd_05}};
	$.ajax({
		url: "/getAllPmsOrderList",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			order_callback(result);
		}
	});
}

//검색된 항목 클릭 시 해당 항목 상세 조회 콜백
function order_callback(result){
	var jsonData = result[0];
	
	$('#pms_order_body').empty();
	$('#history_engine_body').empty();
	$("#history_cylinder_body").empty();
	$("#hidEngineId").val("");
	$("#hidParentId").val("");
	$("#history_detail_div").hide();
	$("#history_table").hide();
	if(jsonData.partDtlList.length > 0){
		//pmsQty, pmsUnit를 가지고 있는 JSON(String type으로 데이터를 가지고 있기 때문에 변환이 필요)
		var orderAdditionInfo = JSON.parse(jsonData.needPlateInfoJson);
		
		for(var i = 0; i < jsonData.partDtlList.length; i++)
		{
			//pmsQty, pmsUnit가 있는지 Check
			var pmsAddInfo ="";
			if(orderAdditionInfo == undefined || orderAdditionInfo[jsonData.partDtlList[i].pmsPartDtlPk.plateNo] == undefined){
				pmsAddInfo = "<td></td>"+
				"<td></td>";
			}else{
				pmsAddInfo = "<td>" + orderAdditionInfo[jsonData.partDtlList[i].pmsPartDtlPk.plateNo].pmsQty + "</td>" +
				"<td>" + orderAdditionInfo[jsonData.partDtlList[i].pmsPartDtlPk.plateNo].pmsUnit + "</td>";
			}
			var pmsPO = "<td></td>";
			if(jsonData.partDtlList[i].amtCount >= 0){
				pmsPO = "<td onclick='location.href=\"www.naver.com\"' style='color:red;'>▶PO</td>";
			}
			
			$('#pms_order_body').append("<tr style='text-align:center; cursor:pointer;' ondblclick='appendPartsPop(\"DEL\",\""+jsonData.partDtlList[i].pmsPartDtlPk.plateNo+"\")'>" +
					"<td>" + jsonData.pmsTechOrderPk.pmsCd01+' '+jsonData.pmsTechOrderPk.pmsCd02+' '+jsonData.pmsTechOrderPk.pmsCd03+' '+jsonData.pmsTechOrderPk.pmsCd04+' '+jsonData.pmsTechOrderPk.pmsCd05 + "</td>" +
					"<td style='text-align:left'>" + jsonData.descTech + "</td>" +
					"<td style='text-align:left'>" + jsonData.partDtlList[i].prodStd + "</td>" +
					"<td style='text-align:left'>" + jsonData.partDtlList[i].pmsPartDtlPk.plateNo + "</td>" +
					"<td>" + jsonData.partDtlList[i].drawNo + "</td>" +
					pmsAddInfo + 
					"<td>" + jsonData.partDtlList[i].amtCount + "</td>" +
					pmsPO+
					"</tr>");
		}
	}else{//Parts가 없는 경우
		$('#pms_order_body').append("<tr style='text-align:center;'>" +
				"<td>" + jsonData.pmsTechOrderPk.pmsCd01+' '+jsonData.pmsTechOrderPk.pmsCd02+' '+jsonData.pmsTechOrderPk.pmsCd03+' '+jsonData.pmsTechOrderPk.pmsCd04+' '+jsonData.pmsTechOrderPk.pmsCd05 + "</td>" +
				"<td style='text-align:left'>" + jsonData.descTech + "</td>" +
				"<td style='text-align:left'></td>" +
				"<td style='text-align:left'></td>" +
				"<td></td>" +
				"<td></td>" +
				"<td></td>" + 
				"<td></td>" +
				"<td></td>" +
				"</tr>");
	}
	$('#pms_order_body').append("<tr style='text-align:center;'>" +
			"<td></td>" +
			"<td></td>" +
			"<td><input type='button' class='appendBtn' value='+' ondblclick='appendPartsPop(\"INS\")'></td>" +
			"<td></td>" +
			"<td></td>" +
			"<td></td>" +
			"<td></td>" + 
			"<td></td>" +
			"<td></td>" +
			"</tr>");
	
	$("#hidPmsCd01").val(jsonData.pmsTechOrderPk.pmsCd01);
	$("#hidPmsCd02").val(jsonData.pmsTechOrderPk.pmsCd02);
	$("#hidPmsCd03").val(jsonData.pmsTechOrderPk.pmsCd03);
	$("#hidPmsCd04").val(jsonData.pmsTechOrderPk.pmsCd04);
	$("#hidPmsCd05").val(jsonData.pmsTechOrderPk.pmsCd05);
	
	//Additional Infomation 추가정보
	engineHistoryInfo("");
	
	$("#pms_order_table").show();
}

//Additional Infomation 추가정보 호출(engine)
function engineHistoryInfo(engine){
	return new Promise(function(resolve,reject){
		var targetOrder01 = document.getElementById("hidPmsCd01").value;
		var targetOrder02 = document.getElementById("hidPmsCd02").value;
		var targetOrder03 = document.getElementById("hidPmsCd03").value;
		var targetOrder04 = document.getElementById("hidPmsCd04").value;
		var targetOrder05 = document.getElementById("hidPmsCd05").value;
		
		var data = {"pmsTechOrderPk":{"pmsCd01":targetOrder01,"pmsCd02":targetOrder02,"pmsCd03":targetOrder03,"pmsCd04":targetOrder04,"pmsCd05":targetOrder05}};
		$.ajax({
			url: "/getHitoryParent",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				resolve(engineHistoryInfo_callback(result,engine));
			}
		});
	})
}

//Additional Infomation 추가정보 콜백(engine)
function engineHistoryInfo_callback(jsonData,engine){
	
	//engine갯수(하위 탭을 위해 전역변수 지정)
	engCount = jsonData.length;
	
	var histotyEngineHtml = "<tr><td class='histFieldName'>Engine No.</td>";
	var tempArray = new Array();
	for(var i = 0; i < engCount; i++){
		
		var rhIcon = "";
		var runAlarm = jsonData[i].runAlarm;
		if(runAlarm < 72 && runAlarm > 0){
			rhIcon = '<i class="fas fa-wrench" style="color:green;"></i>';
		}else if(runAlarm <= 0){
			rhIcon = '<i class="fas fa-wrench" style="color:red;"></i>';
		}
		
		histotyEngineHtml += "<td class='engCell histEngItem_"+jsonData[i].engineId+"' Info='" + JSON.stringify(jsonData[i]) + "' onclick='historyDetailDisplay(this), engCellSelected(this),cylienderHistoryInfo(\""+jsonData[i].engineId+"\",\"\")'>"
		+ rhIcon
		+ jsonData[i].engineId + "</td>";
		tempArray.push(jsonData[i].engineId);
	}
	
	histEngComboData = tempArray;
	
	histotyEngineHtml += "</tr>";
	
	$("#history_engine_body").html(histotyEngineHtml);
	
	$("#history_table").show();
	
	//첫번째 엔진 선택 - 요청사항
	if(engine != ""){
		$(".histEngItem_"+engine).click();
	}else{
		$(".histEngItem_engine01").eq(0).click();
	}
}

//Additional Information - engine 선택(engine history 출력, 하위 탭이 있으면 하위 탭 리스트 뿌림) 
function cylienderHistoryInfo(parentId,engine){
	//Create Progressbar
	showProgressBar();
	
	var targetOrder01 = document.getElementById("hidPmsCd01").value;
	var targetOrder02 = document.getElementById("hidPmsCd02").value;
	var targetOrder03 = document.getElementById("hidPmsCd03").value;
	var targetOrder04 = document.getElementById("hidPmsCd04").value;
	var targetOrder05 = document.getElementById("hidPmsCd05").value;
	
	var data = {"parentId":parentId,"pmsTechOrderPk":{"pmsCd01":targetOrder01,"pmsCd02":targetOrder02,"pmsCd03":targetOrder03,"pmsCd04":targetOrder04,"pmsCd05":targetOrder05}};
	$.ajax({
		url: "/getHitoryParent",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			history_callback(result,engine);
		}
	});
}

//Additional Information - engine 선택 Callback(engine history 출력, 하위 탭이 있으면 하위 탭 리스트 뿌림) 
function history_callback(result,engine){
	$("#history_cylinder_body").empty();
	//jsonData[0] = engine, jsonData[1]~[n] = cyl
	var jsonData = result;
	
	//Cyliender 리스트 뿌려주기(실린더 갯수가 10개 단위로 증가하기 때문에 동적테이블 짱남)
	if(jsonData.length > 0){
		//실린더 Table Row 수 
		var cylRow = Math.ceil((jsonData.length) /engCount);
		
		//Row수 증가 카운트
		var appendRow = (jsonData.length)  - engCount;
		
		var tempArray = new Array();
		var cylBodyHtml = "<tr><td class='histFieldName' rowspan="+cylRow+">Cyliender No.</td>";//첫 번째 row
		for(i = 0; i < cylRow; i++){
			if(i !=0){
				cylBodyHtml +="<tr>"
			}
			//한 row에 engineCount 만큼만 출력(1~10, 11~20, 21~30 ... 등)
			var rowCount = 0;
			if(jsonData.length <= engCount){
				rowCount = jsonData.length;
			}else{
				rowCount = jsonData.length - appendRow;
				if(rowCount > jsonData.length){
					rowCount = jsonData.length;	
				}
			}
			for(j = i*engCount; j<rowCount; j++){
				
				//runnunghour 아이콘 표시
				var rhIcon = "";
				var runAlarm = jsonData[j].runAlarm;
				if(runAlarm < 72 && runAlarm > 0){
					rhIcon = '<i class="fas fa-wrench" style="color:green;"></i>';
				}else if(runAlarm <= 0){
					rhIcon = '<i class="fas fa-wrench" style="color:red;"></i>';
				}
				//html
				cylBodyHtml +="<td class='engCell histEngItem_"+jsonData[j].engineId+"' Info='" + JSON.stringify(jsonData[j]) + "' onclick='historyDetailDisplay(this), cylCellSelected(this)'>"
				+rhIcon
				+jsonData[j].engineId+"</td>"
				
				tempArray.push(jsonData[j].engineId);
			}
			appendRow -= engCount;
			cylBodyHtml += "</tr>";
		}
		
		histCylComboData = tempArray;
		
		$("#history_cylinder_body").append(cylBodyHtml);
		
		if(engine != ""){
			$(".histEngItem_"+engine).click();
		}
	}
	
	var comboData = [{"id":"All","text":"All","selected":true}];
	var tempObj;
	if(histEngComboData != null){
		tempObj = {"id":"Eng","text":"Engine All"}
		comboData.push(tempObj);
	}
	if(histCylComboData != null){
		tempObj = {"id":"Cyl","text":"Cyliender All"}
		comboData.push(tempObj);
	}

	$("#targetCombo").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
	
	//finish ProgressBar
	closeProgressBar();
}


//Additional Information Item 클릭 상세정보 및 히스토리 등록 정보 표시
function historyDetailDisplay(obj){
	var jsonData = JSON.parse($(obj).attr("Info"));
		$("#spnHisDetailDate").text(dateToString(new Date(jsonData.atFixedDate)));
		$("#spnHisDetailRegister").text(jsonData.creatorId);
		$("#spnHisDetailOverhaul").text(jsonData.atFixedHour);
		$("#spnHisDetailRunTime").text(jsonData.runTime);
		$("#spnHisDetailNotice").text(jsonData.lastWorkNoti);
		$("#hidParentId").val(jsonData.parentId);
		$("#hidEngineId").val(jsonData.engineId);
		if(jsonData.parentId != null){
			$("#historyTargetBase").text(jsonData.parentId + " > " + jsonData.engineId);
		}else{
			$("#historyTargetBase").text(jsonData.engineId);
		}
		
		$("#history_detail_div").show();
}

//history 저장 버튼
function historySaveBtn(){
	//Create Progressbar
	showProgressBar();
	
	var targetOrder01 = document.getElementById("hidPmsCd01").value;
	var targetOrder02 = document.getElementById("hidPmsCd02").value;
	var targetOrder03 = document.getElementById("hidPmsCd03").value;
	var targetOrder04 = document.getElementById("hidPmsCd04").value;
	var targetOrder05 = document.getElementById("hidPmsCd05").value;
	var targetParentId = $("#hidParentId").val();
	var targetEngineId = $("#hidEngineId").val();
	var selectedDateValue = $("#historyDateCombo").combobox('getValue');
	var selectedOverHaulValue = $("#overHaulCombo").combobox('getValue');
	var targetNotice = $("#historyNotice").val();
	var targetComboVal = $("#targetCombo").combobox('getValue');
	
	var data = {"lastWorkNoti" : targetNotice,
			"pmsTechOrderPk":{"pmsCd01":targetOrder01,"pmsCd02":targetOrder02,"pmsCd03":targetOrder03,"pmsCd04":targetOrder04,"pmsCd05":targetOrder05}};
	
	if($("input[name='historyTarget']:checked").val() == "AddInfo"){
		data["engineId"] = targetEngineId;
		//parentId가 있으면 하위 노드, parentId가 없으면 상위 노드 
		if(targetParentId != ""){
			data["parentId"] = targetParentId;
		}
	}else{
			data["multiSave"] = targetComboVal;
			data["parentList"] = histEngComboData;
			data["engineList"] = histCylComboData;
	}
	
	//시간정보
	if(selectedDateValue == "SELF"){
		data["atFixedDate"] = dateUTC(new Date($("#history_DATE").datebox('getValue').replace(/-/gi,'/') + ' ' + $("#history_HOUR").datebox('getValue') +':'+ $("#history_MIN").datebox('getValue')));
	}else if(selectedDateValue == "NOW"){
		data["atFixedDate"] = dateUTC(new Date());
	}
	
	//OverHaul 정보
	if(selectedOverHaulValue == "SELF"){
		data["atFixedHour"] = $("#history_OverHaul").val();
	}
	
	$.ajax({
		url: "/setHistoryAppend",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result =="SUCCESS"){
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','성공적으로 등록되었습니다','info',function(){
					
					engineHistoryInfo(targetParentId).then(function(){
						cylienderHistoryInfo(targetParentId,targetEngineId);
					});
					
				});
			}else{
				//finish ProgressBar
				closeProgressBar();
				$.messager.alert('Result message!','알 수 없는 에러가 발생하였습니다. 관리자에게 문의해주시기 바랍니다.','error');
			}
		}
	});
}

//Parts 추가 팝업창 오픈
function appendPartsPop(mode, plateNo){
	var targetOrder01 = document.getElementById("hidPmsCd01").value;
	var targetOrder02 = document.getElementById("hidPmsCd02").value;
	var targetOrder03 = document.getElementById("hidPmsCd03").value;
	var targetOrder04 = document.getElementById("hidPmsCd04").value;
	var targetOrder05 = document.getElementById("hidPmsCd05").value;
	
	var url;
	if(plateNo ==''){
		url= "/PartsManagePop?popMode="+mode+"&pmsCd01="+targetOrder01+"&pmsCd02="+targetOrder02+"&pmsCd03="+targetOrder03+"&pmsCd04="+targetOrder04+"&pmsCd05="+targetOrder05;
	}else{
		url= "/PartsManagePop?popMode="+mode+"&plateNo="+plateNo+"&pmsCd01="+targetOrder01+"&pmsCd02="+targetOrder02+"&pmsCd03="+targetOrder03+"&pmsCd04="+targetOrder04+"&pmsCd05="+targetOrder05;
	}
	var popName = "appendParts"
	var windowW = 600;  // 창의 가로 길이
	var windowH = 600;  // 창의 세로 길이
	var left = Math.ceil((window.screen.width - windowW)/2);
	var top = Math.ceil((window.screen.height - windowH)/2);
	window.open(url,popName,"left="+ left +", top="+ top +", width="+ windowW +", height="+ windowH +", toolbar=no, status=no, resizable=no, scrollbars=no, directories=no,menubar=no, location=no");
}

//스타일 관련 js

$("input[name=historyTarget]").radiobutton({
	onChange:function(){
		if($("input[name=historyTarget]:checked").val() == "Unit"){
			$("#targetCombo").combobox('enable');
		}else{
			$("#targetCombo").combobox('disable');
		}
	}
});
//history Date ComboBox change이벤트 
$("#historyDateCombo").combobox({
		onChange:function(){
			var selectedValue = $("#historyDateCombo").combobox('getValue');
			if(selectedValue == "SELF"){
				$("#historyDateArea").show();
			}else if(selectedValue == "NOW"){
				$("#historyDateArea").hide();
			}
		}
});

//history OverHaul ComboBox change이벤트 
$("#overHaulCombo").combobox({
		onChange:function(){
			var selectedValue = $("#overHaulCombo").combobox('getValue');
			if(selectedValue == "SELF"){
				$("#historyOverHaulArea").show();
			}else if(selectedValue == "Auto"){
				$("#historyOverHaulArea").hide();
			}
		}
});

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

//CylienderList 클릭 이벤트
function cylCellSelected(objSpan){
	$(objSpan).closest("table").find(".cylSelected").each(function(){
			$(this).removeClass("cylSelected")
	});
	$(objSpan).addClass("cylSelected");
}