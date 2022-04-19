//필드 리스트
var fieldList = ["EA0054&RUNNING HOUR","EA0122&GAS TEMP","EA0171&LOAD FACTOR","EA0174&POWER(KWh)","EA0176&GAS(METER)","EA0187&AMBIENT TEMP","EA0198&HFO(METER)",
	"ED1060&DO MODE","ED1061&HFO MODE","ED1062&GAS MODE"];

var commonList = ["CA0115&HFO#A(LEVEL)","CA0116&HFO#B(LEVEL)","CA0119&DO(LEVEL)","CA0120&PO(LEVEL)",
	"CA0162&PO(METER)","CA0178&POWER AUX#1(KWh)","CA0179&POWER AUX#2(KWh)"];

var searchFieldValue;
var searchFieldName;
var searchFieldWidth;
var searchFieldAlign;

var commonFieldValue;
var commonFieldName;
var commonFieldWidth;
var commonFieldAlign;

var jsonData; 

//필드 체크박스 (easyui 로드를 위해 window.onload)
window.onload = function () {
	fieldList.forEach(function(field,index){
		$("#fieldCheckArea").append('<span class="spnField">'+field.split('&')[1]+'<input class="easyui-checkbox" name="searchField" value="'+field+'">');
		if((index+1) % 10 == 0){
			$("#fieldCheckArea").append("</br>");	
		}
	});
}

$(document).ready( function () {
	//검색 Select 박스 생성
	setSearchCombo();
	$("#tempCombo").hide();
	
	//현지시간 세팅(데이터 기준 -1시간)
	displayDate();
	
	//최초 조회
	searchBtn();
});

//검색 Combo 박스 생성
function setSearchCombo(){
	var comboData = [{"id":"all","text":"All","selected":true},{"id":"direct","text":"Direct"}];
	$("#reportCombo").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
}

//Search영역 DATE 표시
function displayDate(){
	//시간 표시하기
	var engSearch_TEMP = getWorldTime(-6).split(' ');
	//날짜
	$("#report_DATE").datebox('setValue', engSearch_TEMP[0]);
	var engSearch_TIME = engSearch_TEMP[1].split(":");
	//시간
	$("#report_HOUR").combobox('setValue',engSearch_TIME[0]);
	//분
	$("#report_MIN").combobox('setValue',engSearch_TIME[1]);
	//초
	$("#report_SEC").combobox('setValue',engSearch_TIME[2]);
}

//조회버튼 - Data 조회
function searchBtn(){
	//조회 시간
	var searchDate = dateCombine("reportDateArea");
	
	//조회 필드
	searchFieldValue = new Array();
	searchFieldName = new Array();
	searchFieldWidth = new Array();
	searchFieldAlign = new Array();
	
	//DATE 값 고정 필드
	searchFieldValue.push("DATE");
	searchFieldName.push("DATE");
	searchFieldWidth.push("200");
	searchFieldAlign.push("center");
	
	//검색 창 콤보박스에서 all, direct 선택에 따른 필드 매핑
	if($("#reportCombo").val() == "all"){
		fieldList.forEach(function(field,index){
			searchFieldValue.push(field.split("&")[0]);
			searchFieldName.push(field.split("&")[1]);
			searchFieldAlign.push("right");
		});
	}else if($("#reportCombo").val() == "direct"){
		$("input[name=searchField]:checked").each(function(){
			searchFieldValue.push($(this).val().split("&")[0]);
			searchFieldName.push($(this).val().split("&")[1]);
			searchFieldAlign.push("right");
		});
	}
	
	var data = {"startTime":searchDate, "field1":searchFieldValue, "index":["engine01","engine02","engine03","engine04","engine05","engine06","engine07","engine08","engine09","engine10"]};
	//ajax 호출
	try{
		$.ajax({
			url: "/web-reportDownload",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				
				//commonData도 호출
				searchCommonData(result);
			}
		});
	}catch(err){
		if (err.status === 404) {
			alert("error 404" );
		} else {
			alert("error : " + err );
		}
		//progressbar 종료
		closeProgressBar();
	}
}

//조회버튼 - Data 조회
function searchCommonData(engineData){
	//조회 시간
	var searchDate = dateCombine("reportDateArea");
	
	//조회 필드
	commonFieldValue = new Array();
	commonFieldName = new Array();
	commonFieldWidth = new Array();
	commonFieldAlign = new Array();
	
	//검색 창 콤보박스에서 all, direct 선택에 따른 필드 매핑
	if($("#reportCombo").val() == "all"){
		commonList.forEach(function(field,index){
			commonFieldValue.push(field.split("&")[0]);
			commonFieldName.push(field.split("&")[1]);
			commonFieldAlign.push("right");
		});
	}else if($("#reportCombo").val() == "direct"){
		$("input[name=searchCommon]:checked").each(function(){
			commonFieldValue.push($(this).val().split("&")[0]);
			commonFieldName.push($(this).val().split("&")[1]);
			commonFieldAlign.push("right");
		});
	}
	
	var data = {"startTime":searchDate, "field1":commonFieldValue, "index":["common01"]};
	//ajax 호출
	try{
		$.ajax({
			url: "/web-reportDownload",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				
				for(i = 0; i < engineData.length; i++){
					if(engineData[i]["ED1060"]){
						engineData[i]["ED1060"] = "ON";	
					}else{
						engineData[i]["ED1060"] = "OFF";
					}
					
					if(engineData[i]["ED1061"]){
						engineData[i]["ED1061"] = "ON";	
					}else{
						engineData[i]["ED1061"] = "OFF";
					}
					
					if(engineData[i]["ED1062"]){
						engineData[i]["ED1062"] = "ON";	
					}else{
						engineData[i]["ED1062"] = "OFF";
					}
					//engineData[i] = Object.assign(engineData[i], result[0]);
					engineData[i] = $.extend({}, engineData[i], result[0]);
					
					//engineData[i] = Object.assign(engineData[i], {"CA0178":0, "CA0179":0});
					//ojooy 하드코딩
//					engineData[i] = $.extend({}, engineData[i], {"CA0178":0, "CA0179":0});
				}
				//전역변수에 결과 값 매핑 - csv 다운로드를 위함
				jsonData = engineData;
				
				//Data Display 함수 호출
				displayReportData();

			}
		});
	}catch(err){
		if (err.status === 404) {
			alert("error 404" );
		} else {
			alert("error : " + err );
		}
		//progressbar 종료
		closeProgressBar();
	}
}

//조회 데이터 Display
function displayReportData(){
	var tableRow = new Array();
	
	//index 정보는 조회 필드가 아니기 때문에 조회 후 필드 정보 매핑
	searchFieldValue.unshift("_index");
	searchFieldName.unshift("Index");
	searchFieldWidth.unshift("100");
	searchFieldAlign.unshift("center");
	
	searchFieldValue = searchFieldValue.concat(commonFieldValue);
	searchFieldName = searchFieldName.concat(commonFieldName);
	searchFieldWidth = searchFieldWidth.concat(commonFieldWidth);
	searchFieldAlign = searchFieldAlign.concat(commonFieldAlign);
	
	//jsonData가 0이 아니면  show display
	if(jsonData.length > 0){
		
		//display 부분 hidden > show
		$("#reportDataContent").show();
		
		//헤더 및 필드 값 정의
		for(i = 0; i<searchFieldValue.length; i++){
			tableRow.push({field:searchFieldValue[i],
				title:searchFieldName[i],
				
				align:searchFieldAlign[i]});
		}
		
		//필드 값 세팅
		$('#orderGridTable').datagrid({
			data:jsonData,
			columns:[tableRow]
		});
	}else{
		$.messager.alert('Result message!','해당하는 시간에 데이터가 없습니다.','warning');
	}
}

//Report Data Download - csv 파일 저장
function reportDataDownload(){
	try{
		//CSV의 Row
		var csvRow = new Array();
		
		//첫 행은 FieldName로 setting
		csvRow[0] = searchFieldName.join(',');
		
		//csv파일 본문 매핑
		var bodyField = new Array();
		for(var i = 0; i<=jsonData.length-1; i++)//조회결과
		{
			for(var j = 0; j<=searchFieldName.length-1; j++){ //필드 정보
				bodyField[j] = jsonData[i][searchFieldValue[j]];
			}
			csvRow[i+1] = bodyField.join(',');
		}
		
		//데이터가 없는 경우 예외 처리
		if(!csvRow) {
			console.error('Console.save: No data')
			return;
		}
		
		//파일이름 앞 날짜 정보 붙여주기
		var fullDate = jsonData[0]["DATE"].replace(/-/gi,'').replace(/:/gi,'').replace(/ /gi,'');
		
		//파일이름
		var filename = fullDate+"_ReportData.csv";
		
		//파일 저장
		var blob = new Blob([csvRow.join("\n")], {type: 'text/plain'}),
		e = document.createEvent('MouseEvents'),
		a = document.createElement('a')
		// FOR IE:
		if (window.navigator && window.navigator.msSaveOrOpenBlob) {
			window.navigator.msSaveOrOpenBlob(blob, filename);
		}else{
			var e = document.createEvent('MouseEvents'),
			a = document.createElement('a');				
			a.download = filename;
			a.href = window.URL.createObjectURL(blob);
			a.dataset.downloadurl = ['text/plain', a.download, a.href].join(':');
			e.initEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
			a.dispatchEvent(e);
		}
	}catch(err) {
		if (err.status === 404) {
			alert("error 404" );
		} else {
			alert("error : " + err );
		}
	}
}


//스타일 관련 js
//Field ComboBox change이벤트 
$("#reportCombo").combobox({
	onChange:function(){
		var selectedValue = $("#reportCombo").combobox('getValue');
		if(selectedValue == "all"){
			$("#fieldCheckArea").hide();
		}else if(selectedValue == "direct"){
			$("#fieldCheckArea").show();
		}
	}
});