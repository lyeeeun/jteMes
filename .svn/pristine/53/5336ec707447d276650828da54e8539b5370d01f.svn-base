//ElasticSearch 데이타 조회 -header
function header_elasticDataSearch(){
	try{
		var startCalcDate = dateCalc(getWorldTime(-6), -0);
		var data = {"startTime":startCalcDate,"endTime":getWorldTime(-6)
				,"index":["engine01","engine02","engine03","engine04","engine05","engine06","engine07","engine08","engine09","engine10"]
				,"field1":["DATE","EA0172"]}; // "ED1035" => Engine Analog data, Alarm data 분리 
		$.ajax({
			url: "/web-header",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				if(result == "noData"||result == "error"){
					$("#header_KW").html("---");
				}else{
					$("#hidWebData").val(result);
					header_elasticDataSearch_state(result, startCalcDate);	
				}
			}
		});
	}catch(err){
		if(err == 404){
			alert("404")
		}else{
			alert(err);	
		}
	}
}

function header_elasticDataSearch_state(eng_data, startCalcDate){
	try{
		var data = {"startTime":startCalcDate,"endTime":getWorldTime(-6)
				,"index":["engine01_st","engine02_st","engine03_st","engine04_st","engine05_st","engine06_st","engine07_st","engine08_st","engine09_st","engine10_st"]
				,"field1":["DATE","ED1035"]}; // "ED1035" => Engine Analog data, Alarm data 분리 
		$.ajax({
			url: "/web-header",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				if(result == "noData"||result == "error"){
					fn_headerPower(eng_data, "no_data");
				}else{
					$("#hidWebData").val(result);
					fn_headerPower(eng_data, result);	
				}
					
			}
		});
	}catch(err){
		if(err == 404){
			alert("404")
		}else{
			alert(err);	
		}
	}
}

////ElasticSearch 데이타 조회 콜백 -header
function fn_headerPower(eng_data, eng_data_alarm){
	var jsonData = JSON.parse(eng_data);
	if(eng_data_alarm != "no_data") {
		var jsonData_al = JSON.parse(eng_data_alarm);
	}
	var KW = 0.0;
	//엔진 상태
	var engineStatus = new Array();
	
	//정렬
	/*jsonData.sort(function(a,b){
		return a._index < b._index ? -1 : a._index > b._index ? 1:0;
	});*/ //검색과정에서 순차적으로 돌기때문에 굳이 정렬할 필요 없어보임. 우선 주석처리.
	

	//데이터 처리
	for(var i = 0; i<= jsonData.length -1; i++) {
		if(jsonData[i].data_exist == "no_data") {
			KW += 0;
		} else {
			KW += jsonData[i].EA0172; // KW
		} 
		if(jsonData[i].data_exist == "no_data" || eng_data_alarm == "no_data") {
			engineStatus[i] = false; // EngineRunning
		} else {
			engineStatus[i] = jsonData_al[i].ED1035; // EngineRunning
		}
		
	}
	
	//엔진 상태값 표시
	menuEngineStatus(engineStatus);

	//엔진 출력량 표시
	$("#header_KW").html((KW+"Kw / "+(KW/93000*100).toFixed(1))+"%");
}

$(document).ready(function(){
	//최초 1회 실행
	header_elasticDataSearch();
	//5초마다 데이터를 불러와 호출
	setInterval(header_elasticDataSearch,5000);
	
	if($("#header_engine").length){
		var gubun  = $('#hidCurrentMenu').val().split('_')[0];
		var menu = ["engine01","engine02","engine03","engine04","engine05","engine06","engine07","engine08","engine09","engine10"]
		for(i=0; i< menu.length; i++){
			$("#header_engine").append("<li><a id='"+gubun+"_"+menu[i]+"' onclick='menuStyleChange(\""+gubun+'_'+menu[i]+"\"),playButtonClick()'><span>"+menu[i]+"</span></a></li>");
		}
	}
});	

window.onload  = function() {
	if($("#header_engine").length){
		setTimeout(function(){menuStyleChange($("#hidCurrentMenu").val())},500);
	}
}

//메뉴 선택 이벤트
//1. class 주기(선택메뉴 표시)
//2. 이벤트 주기
function menuStyleChange(menu){
	$("#"+menu).closest("ul").find("a").each(function(){
		$(this).removeClass("on");
	});
	$("#"+menu).addClass("on");	
	menuSetting(menu);
}

//엔진 상태 on/off 이벤트(header에 엔진 메뉴가 있는 경우만)
function menuEngineStatus(engine){
	if($("#header_engine").length){
		$("#header_engine").closest("ul").find("span").each(function(index){
			if(engine[index]){
				$(this).addClass("engineON");
			}else{
				$(this).removeClass("engineON");
			}
		});
	}
}

//엉망진창 소스 나중에 수정
function menuSetting(menu){
	$("#hidCurrentMenu").val(menu);
	$('#left_tree').tree('expandTo', $('.' + $('#hidCurrentMenu').val()).parent());
	$("#left_tree").find("div").each(function(){
		$(this).removeClass("tree-node-selected");
	});
	$('.' + $('#hidCurrentMenu').val()).parent().addClass("tree-node-selected");
}

function playButtonClick(){
	$("#playBtn").click();
}
