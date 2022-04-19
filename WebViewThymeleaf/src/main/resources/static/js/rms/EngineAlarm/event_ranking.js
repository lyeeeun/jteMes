var altag = new Array();//검색 조건 태그(WHERE)
var altag_source = new Array();//조회할 데이터(SELECT)
var altag_name = {};//태그이름
var rank_data = new Object;//이벤트 카운트

$(document).ready(function(){
	//index콤보박스 데이터생성
	var indexArray = ["engine01", "engine02", "engine03","engine04", "engine05", "engine06", "engine07","engine08", "engine09", "engine10"];
	var indexComboBox = [{"text":"TOTAL","id":indexArray.join(","),"selected":true}];
	for(var index in indexArray){
		indexComboBox.push({"id":indexArray[index],"text":indexArray[index].toUpperCase()});
	}
	$("#indexBox").combobox({
		data : indexComboBox,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
	
	
	//수정 -jkkim
	$.ajax({
		url: "/config/xml/DB4_conf.xml",              // ajax로 ajax_xml.xml파일을 불러온다
		cache: true,                     // 사용자캐시를 사용할 것인가.
		dataType: "xml",                  // 서버로부터 받을 것으로 예상되는 데이터 타입.
		success: function(data){          // ajax요청을 통해 반환되는 데이터 data.
			var json_data = "[";
			var pGroup = "";
			var nGroup = "";
			var trend_selbox = new Array('');
			var g_count = 0;
			$(data).find("TAG").each(function(index){
				json_data += '{ "id": "' + $(this).find('id').text() + '","name": "' + $(this).find('name').text() + '","GROUP": "' + $(this).find('GROUP').text() + '","unit": "' + $(this).find('unit').text() + '"},';
			});
			
			json_data = json_data.substring(0,json_data.length-1) + "]";
			var Conf_json = JSON.parse(json_data); //Engine, Common Conf 설정 담고 있는 전역변수
			
			var alarm_count = 0;
			$.each(Conf_json, function(key,value) {
				if(value.GROUP == "SD" || value.GROUP == "TR" || value.GROUP == "AL") {
				/*if(value.GROUP == "SD") {*/
					altag[alarm_count] = value.id;
					altag_source[alarm_count] = value.id;
					altag_name[value.id] = value.name;
					alarm_count++;
				}
			});
			altag_source.push("DATE");
			//실행
			startSearch();
		}
	});
});
//Controller 데이터 조회
function elasticDataSearch(timearea){
	try{
		//progressbar 시작
		showProgressBar();
		
	var indexArray = new Array();
		
		var data = {"startTime":timearea
				,"size":parseInt($('#sizeBox').val())
				,"field1":altag_source
				,"field2":altag};
		$('#indexBox').combobox('getValue').split(',').forEach(function(element){
			indexArray.push(element+"_sd");
			indexArray.push(element+"_tr");
			indexArray.push(element+"_al");
		});
		
		data["index"] = indexArray;
		
		$.ajax({
			url: "/web-eventRanking",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				if(result == "noData"){
					alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");
					closeProgressBar();
				}else if(result == "error"){
					alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");
					closeProgressBar();
				}else{
					$("#hidWebData").val(result);
					fn_EventRanking(result);	
				}
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

function fn_EventRanking(result) {
	var eng_data = JSON.parse(result);
	
	//시간정보 표시
	displayDate(eng_data[0].DATE);
	
	//이벤트가 발생된 'index' 카운트 초기화
	var index_count = {"engine01":0,"engine02":0,"engine03":0,"engine04":0,"engine05":0,"engine06":0,"engine07":0,"engine08":0,"engine09":0,"engine10":0};
	//이벤트 발생 카운트 초기화 작업
	var event_count = new Object();
	for(var tag in altag){
		event_count[altag[tag]] = 0;
	}
	
	//이벤트가 발생된 필드, 인덱스 카운트 
	for(var i =0; i<eng_data.length; i++){
		for(var tag in altag){
			if(eng_data[i][altag[tag]]){
				event_count[altag[tag]]++;
				index_count[eng_data[i]._index.split('_')[0]]++
			}
		}
	}
	
	//카운트 결과 0인 event 제외
	for (key in event_count) {
		if(event_count[key] != 0){
			rank_data[key] = event_count[key];
		}
	}
	
	//원형 차트 초기화
	$("#result").html("");
	//Event Ranking pie chart(JUI Chart)
	var chart = jui.include("chart.builder");
	chart("#result", {
		padding : 120,
		height:500,
		axis : {
			data : [rank_data]
		},
		brush : {
			type : "pie",
			showText : "outer",
			active : "",
			activeEvent : "click",
			format : function(k, v) {
				return altag_name[k] + ": " + v;
			}
		},
		widget : [
			{type : "title", text : "Event Ranking pie chart"} 
			,{
				type : "tooltip",orient : "left"
				,format : function(data, k) {return {key: altag_name[k]}}
			}
		/*,{type : "legend", format : function(k) { return altag_name[k];}}*/
		]
		,style:{backgroundColor:'#f2f2f2'}});
	
	//EventRanking 호출
	getRankList();
	
	//Event Bar chart(plotly.js)
	var rankPlotly_name = new Array();
	var rankPlotly_value = new Array();
	for (key in index_count) {
		rankPlotly_name.push(key); 
		rankPlotly_value.push(index_count[key]);
	}
	
	var xValue = rankPlotly_name;

	var yValue = rankPlotly_value;

	var Bartrace1 = {
			x: xValue,
			y: yValue,
			type: 'bar',
			name: 'System',
			text: yValue,
			textposition: 'auto',
			hoverinfo: 'none',
			opacity: 0.5,
			marker: {
				color: 'rgb(158,202,225)',
				line: {
					color: 'rbg(8,48,107)',
					width: 1.5
				}
			}
	};

	var Bardata = [Bartrace1];

	var layouts2 = {
		title : 'Event status',
		paper_bgcolor: '#f2f2f2',
		plot_bgcolor: '#f2f2f2'
	};

	Plotly.newPlot('Eventranking', Bardata, layouts2);
	
	//progressbar 종료
	closeProgressBar();
}

//Event Ranking - 이벤트 grid
function getRankList(){
	//소트키
	var rSort = $("#rankSortSelect").val();
	//검색어
	var rText = $("#rankSearchText").val();
	
	//정렬
	var sort_data = [];
	for (var key in rank_data) {
		sort_data.push({"name":key, "value":rank_data[key]});
	}
	sort_data.sort(function(a, b) {
		if(rSort =="asc"){
			return a.value - b.value;
		}else{
			return b.value - a.value;
		}
	});
	
	//리스트 항목 생성
	var ranklist_li = ""
	for(i=0; i<sort_data.length;i++){
		if(altag_name[sort_data[i].name].indexOf(rText) != -1){//SearchText
			ranklist_li += "<li><div>"+altag_name[sort_data[i].name]+"</div><div>"+sort_data[i].value+"</div></li>";
		}
	}
	$("#event_list").html(ranklist_li);
}