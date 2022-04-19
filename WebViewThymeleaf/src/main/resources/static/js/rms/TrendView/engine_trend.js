var Zoom_start = "";
var Zoom_end = "";
var Conf_json;
$(document).ready(function(){
	$.ajax({
		url: "/config/xml/DB4_conf.xml",              // ajax로 ajax_xml.xml파일을 불러온다
		cache: true,                     // 사용자캐시를 사용할 것인가.
		dataType: "xml",                  // 서버로부터 받을 것으로 예상되는 데이터 타입.
		async: false,
		success: function(data){          // ajax요청을 통해 반환되는 데이터 data.
			var json_Array = [];
			var objSelBox_id = {};
			var objSelBox_name = {};
			$(data).find("TAG").each(function(index){
				var tag_id = $(this).find('id').text();// EA0000, EA0000...
				var tag_name = $(this).find('name').text();// EngineRunning,RunHour ...
				var tag_GROUP = $(this).find('GROUP').text();//GENERATOR DATA, MAIN BEARING TEMP ...
				var tag_unit = $(this).find('unit').text();// %, C, bar ...
				
				//CONVERT XML to JSON
				var json_object  = new Object();
				json_object["id"] = tag_id;
				json_object["name"] = tag_name;
				json_object["GROUP"] = tag_GROUP;
				json_object["unit"] = tag_unit;
				
				json_Array.push(json_object);
				
				// SelectBox 데이터 만들기
				if(tag_id.indexOf("EA") != -1 && tag_GROUP != "COMMON" && tag_GROUP != "불필요"){
					//Group이 2개 이상인 태그들이 있어 반복문 이용
					var sel_group = tag_GROUP.split(',');
					for(var i=0; i<sel_group.length; i++) {
						tag_GROUP = sel_group[i];
						
						//id 매핑
						if(objSelBox_id[tag_GROUP] == undefined) {
							objSelBox_id[tag_GROUP] = [tag_id];
						}else{
							objSelBox_id[tag_GROUP].push(tag_id);
						}
						//name 매핑
						if(objSelBox_name[tag_GROUP] == undefined) {
							objSelBox_name[tag_GROUP] = [tag_name];
						}else{
							objSelBox_name[tag_GROUP].push(tag_name);
						}
					}
				}
			});
			
			//comboBox 설정			
			var tagComboBox = new Array();
			
			for(var key in objSelBox_id){
				//slice - 마지막 쉼표 제거
				/*
				if(key =="GENERATOR DATA"){//GENERATOR DATA 초기선택 (현대중공업 요청사항)
					tagComboBox.push({"id":objSelBox_id[key].join(",")+"&&&"+objSelBox_name[key].join(","),"text":key,"selected":true});
				}else{
					tagComboBox.push({"id":objSelBox_id[key].join(",")+"&&&"+objSelBox_name[key].join(","),"text":key});
				}
				*/
				if(key =="DEFAULT"){//특정 그룹 default (HGS 요청 사항 - Gropu명 변경 예정)
					tagComboBox.push({"id":objSelBox_id[key].join(",")+"&&&"+objSelBox_name[key].join(","),"text":key,"selected":true});
				}else{
					tagComboBox.push({"id":objSelBox_id[key].join(",")+"&&&"+objSelBox_name[key].join(","),"text":key});
				}
			}

			$("#tag_id").combobox({
				data : tagComboBox,
				valueField : 'id',
				textField : 'text',
				method : 'get'
			});
			//JSON 파싱 후 전역변수
			Conf_json = JSON.parse(JSON.stringify(json_Array));
		}
	});
	startSearch();
});

//ElasticSearch 데이터 조회
function elasticDataSearch(timeArea){
	try{
		//progressbar 시작
		showProgressBar();
		
		//저장 Button hide
		$('#excelDownBtn').hide();
		
		//조회 할 태그
		var tag_Array = $('#tag_id').combobox('getValue').split("&&&")[0].split(',');
		tag_Array.push("DATE");
		//조회 시작 시간
		var startTrendCalcDate = dateCalc(timeArea, -3599);
		//조회할 index
		var index_name = $("#hidCurrentMenu").val().split('_')[1];
		//파라미터
		var data = {"startTime":startTrendCalcDate
				,"endTime":timeArea
				,"index":[index_name]
				,"field1":tag_Array
				};
		
		$.ajax({
			url: "/web-engineTrend",
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
					
					//default Zoom value
					Zoom_start = startTrendCalcDate;
					Zoom_end = timeArea;
					
					fn_EngineTrend(result,tag_Array);
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

//ElasticSearch 데이터 콜백
function fn_EngineTrend(result, tag_Array){	
	var tag_name = $('#tag_id').combobox('getText');
	var jsonData = JSON.parse(result);
	var aJsonAr = new Array();
	var Mdate = new Array();
	var Mvalue = new Array();
	var Mvalue_real = new Array();
		
	//시간정보 SearchBox영역에 뿌려주기
	displayDate(jsonData[0].DATE);
	
	// 가독성을 위해 TEXT길이 맞추기 - 길이가 가장 긴 데이터를 찾는다.
	var strlen = 0;
	for(var i = 0; i <jsonData.length-1; i++){
		for(var j = 0; j <tag_Array.length-1; j++){
			if(tag_Array[j] == "EA0060" || tag_Array[j] == "EA0061" || tag_Array[j] == "EA0062" || tag_Array[j] == "EA0063" || tag_Array[j] == "EA0064" || tag_Array[j] == "EA0065" || tag_Array[j] == "EA0066" ||
					tag_Array[j] == "EA0067" || tag_Array[j] == "EA0068" || tag_Array[j] == "EA0069" || tag_Array[j] == "EA0070" || tag_Array[j] == "EA0071" || tag_Array[j] == "EA0072" || tag_Array[j] == "EA0073" || tag_Array[j] == "EA0074" || tag_Array[j] == "EA0075" || tag_Array[j] == "EA0076"
						|| tag_Array[j] == "EA0077" || tag_Array[j] == "EA0078" || tag_Array[j] == "EA0079" || tag_Array[j] == "EA0080" || tag_Array[j] == "EA0081" || tag_Array[j] == "EA0082" || tag_Array[j] == "EA0083" || tag_Array[j] == "EA0084" || tag_Array[j] == "EA0085" || tag_Array[j] == "EA0086"
							|| tag_Array[j] == "EA0087" || tag_Array[j] == "EA0088" || tag_Array[j] == "EA0089" || tag_Array[j] == "EA0090" || tag_Array[j] == "EA0091" || tag_Array[j] == "EA0092" || tag_Array[j] == "EA0093" || tag_Array[j] == "EA0094" || tag_Array[j] == "EA0095" || tag_Array[j] == "EA0096"
								|| tag_Array[j] == "EA0097" || tag_Array[j] == "EA0098" || tag_Array[j] == "EA0099" || tag_Array[j] == "EA0100" || tag_Array[j] == "EA0101" || tag_Array[j] == "EA0102" || tag_Array[j] == "EA0103" || tag_Array[j] == "EA0104" || tag_Array[j] == "EA0105" || tag_Array[j] == "EA0112"
									|| tag_Array[j] == "EA0116" || tag_Array[j] == "EA0138" || tag_Array[j] == "EA0139" || tag_Array[j] == "EA0140" || tag_Array[j] == "EA0167" || tag_Array[j] == "EA0168" || tag_Array[j] == "EA0169"){
				var datalen = JSON.stringify(jsonData[i][tag_Array[j]]).length;
			} else if(tag_Array[j] == "EA0125" || tag_Array[j] == "EA0141" || tag_Array[j] == "EA0142" || tag_Array[j] == "EA0164" || tag_Array[j] == "EA0165" || tag_Array[j] == "EA0166" || tag_Array[j] == "EA0172") {
				var datalen = JSON.stringify(jsonData[i][tag_Array[j]]).length;
			} else {
				var datalen = JSON.stringify(jsonData[i][tag_Array[j]]).length;
			}
			if(strlen < datalen) {
				strlen = datalen;
			}
		}
	}
	
	for(var i = 0; i <jsonData.length-1; i++){
		for(var j = 0; j <tag_Array.length-1; j++){
			if(i == 0) {
				Mvalue[j] = new Array();
				Mvalue_real[j] = new Array();
			}
			if(tag_Array[j] == "EA0060" || tag_Array[j] == "EA0061" || tag_Array[j] == "EA0062" || tag_Array[j] == "EA0063" || tag_Array[j] == "EA0064" || tag_Array[j] == "EA0065" || tag_Array[j] == "EA0066" ||
					tag_Array[j] == "EA0067" || tag_Array[j] == "EA0068" || tag_Array[j] == "EA0069" || tag_Array[j] == "EA0070" || tag_Array[j] == "EA0071" || tag_Array[j] == "EA0072" || tag_Array[j] == "EA0073" || tag_Array[j] == "EA0074" || tag_Array[j] == "EA0075" || tag_Array[j] == "EA0076"
						|| tag_Array[j] == "EA0077" || tag_Array[j] == "EA0078" || tag_Array[j] == "EA0079" || tag_Array[j] == "EA0080" || tag_Array[j] == "EA0081" || tag_Array[j] == "EA0082" || tag_Array[j] == "EA0083" || tag_Array[j] == "EA0084" || tag_Array[j] == "EA0085" || tag_Array[j] == "EA0086"
							|| tag_Array[j] == "EA0087" || tag_Array[j] == "EA0088" || tag_Array[j] == "EA0089" || tag_Array[j] == "EA0090" || tag_Array[j] == "EA0091" || tag_Array[j] == "EA0092" || tag_Array[j] == "EA0093" || tag_Array[j] == "EA0094" || tag_Array[j] == "EA0095" || tag_Array[j] == "EA0096"
								|| tag_Array[j] == "EA0097" || tag_Array[j] == "EA0098" || tag_Array[j] == "EA0099" || tag_Array[j] == "EA0100" || tag_Array[j] == "EA0101" || tag_Array[j] == "EA0102" || tag_Array[j] == "EA0103" || tag_Array[j] == "EA0104" || tag_Array[j] == "EA0105" || tag_Array[j] == "EA0112"
									|| tag_Array[j] == "EA0116" || tag_Array[j] == "EA0138" || tag_Array[j] == "EA0139" || tag_Array[j] == "EA0140" || tag_Array[j] == "EA0167" || tag_Array[j] == "EA0168" || tag_Array[j] == "EA0169"){
				Mvalue[j][i] = data_spaces(jsonData[i][tag_Array[j]]/10, strlen);
			} else if(tag_Array[j] == "EA0125" || tag_Array[j] == "EA0141" || tag_Array[j] == "EA0142" || tag_Array[j] == "EA0164" || tag_Array[j] == "EA0165" || tag_Array[j] == "EA0166" || tag_Array[j] == "EA0172") {
				Mvalue[j][i] = data_spaces(jsonData[i][tag_Array[j]]/100, strlen);
			}
			else {
				Mvalue[j][i] = data_spaces(jsonData[i][tag_Array[j]], strlen);
			}
			Mvalue_real[j][i] = data_spaces(jsonData[i][tag_Array[j]], strlen);
		}
		Mdate[i] = jsonData[i]["DATE"];
	}
	
	var plotly_Data = new Array();
	var trace_name = "";
	c=0;
	$.each(Conf_json, function(key,value) {
		if(value.GROUP.indexOf(tag_name) != -1) {
			if(value.id == "EA0060" || value.id == "EA0061" || value.id == "EA0062" || value.id == "EA0063" || value.id == "EA0064" || value.id == "EA0065" || value.id == "EA0066" || 
					 value.id == "EA0067" || value.id == "EA0068" || value.id == "EA0069" || value.id == "EA0070" || value.id == "EA0071" || value.id == "EA0072" || value.id == "EA0073" || value.id == "EA0074" || value.id == "EA0075" || value.id == "EA0076"
						 || value.id == "EA0077" || value.id == "EA0078" || value.id == "EA0079" || value.id == "EA0080" || value.id == "EA0081" || value.id == "EA0082" || value.id == "EA0083" || value.id == "EA0084" || value.id == "EA0085" || value.id == "EA0086"
							 || value.id == "EA0087" || value.id == "EA0088" || value.id == "EA0089" || value.id == "EA0090" || value.id == "EA0091" || value.id == "EA0092" || value.id == "EA0093" || value.id == "EA0094" || value.id == "EA0095" || value.id == "EA0096"
								 || value.id == "EA0097" || value.id == "EA0098" || value.id == "EA0099" || value.id == "EA0100" || value.id == "EA0101" || value.id == "EA0102" || value.id == "EA0103" || value.id == "EA0104" || value.id == "EA0105" || value.id == "EA0112"
									 || value.id == "EA0116" || value.id == "EA0138" || value.id == "EA0139" || value.id == "EA0140" || value.id == "EA0167" || value.id == "EA0168" || value.id == "EA0169") {
				trace_name = value.name + "[value/10]";
			} else if( value.id == "EA0125" || value.id == "EA0141" || value.id == "EA0142" || value.id == "EA0164" || value.id == "EA0165" || value.id == "EA0166" || value.id == "EA0172") {
				trace_name = value.name + "[value/100]";
			} else {
				trace_name = value.name;
			}
			var trace = {
					type: "scatter",
					mode: "lines",
					name: trace_name,
					x: Mdate,
					y: Mvalue[c],
					text: Mvalue_real[c],
					hoverlabel: {namelength :-1, font: {
						family: 'Courier New, monospace',
						size: 13
					}},
					hoverinfo: "text+name",
					line: {color: '#' + Math.floor( Math.random() * 16777215).toString(16), width: 0.8}
			};
			plotly_Data.push(trace)
			c++;
		}
	});
	$('.content_layer').height("720px")
	var graph_h = 720;
	if(Mvalue.length >= 20 && Mvalue.length < 35){
		$('.content_layer').height("900px")
		graph_h = 870;
	} else if(Mvalue.length >= 35){
		$('.content_layer').height("1400px")
		graph_h = 1300;
	}
	
	var layout = {
			title: 'Time Series with Rangeslider',
			paper_bgcolor: 'rgba(0,0,0,0)',
			plot_bgcolor: '#f2f2f2',
			xaxis: {
				autorange: true, 
				range: [Mdate[Mdate.length-1], Mdate[0]],
/*				rangeselector: {buttons: [
					{step: 'all'}
					]},*/
					/*rangeslider: {range: [Mdate[0], Mdate[Mdate.length-1]]},*/
					type: 'date'
			},
			yaxis: {
				autorange: true,
				range: [0, 8000],
				type: 'linear',
				tickformat: ',d'
			},/*
			legend: {
			    x: 10,
			    y: 1
			},*/
			height: graph_h,
			/*width: 1350,*/
			/*showlegend: false*/
	};
	Plotly.newPlot('myDiv', plotly_Data, layout);

	
	var bae = getXYFromTranslate($('.legend'));
	var $legends_check_g = $(document.createElementNS("http://www.w3.org/2000/svg", "g")).attr({
        width: 10,
        height: 100,
        transform: "translate(" + (bae[0]-20) + "," + bae[1] + ")",
        class: "legends_checkbox"
    });
	$('.legend').before($legends_check_g);
	var ht = 10;
	$('.traces').each( function(index, item) {
		var traces_transform = getXYFromTranslate($(item));
		var $rect = $(document.createElementNS("http://www.w3.org/2000/svg", "rect")).attr({
	        width: 10,
	        height: 10,
	        x:10,
	        rx:2,
	        ry:2,
	        y:traces_transform[1]-5,
	        background:"white",
	        style:"fill: #00498C; stroke: cadetblue;",
	        class: "check_rect"
	    });
		
		$('.legends_checkbox').append($rect);

		ht = ht + 20;
	});
	
	
	var legend_click_check = new Array(); 
	myDiv.on('plotly_legendclick', function(eventdata){
		setTimeout(function(){
		 $('.traces').each( function (index, item) {
			 legend_click_check[index] = $(item).css('opacity'); 
		 });
		 $('.check_rect').each( function (index, item) {
			 if(legend_click_check[index] == "1") {
				$(item).css('fill','#00498C');
			 } else {
				$(item).css('fill','white');
			 }
		 })
		},500);
	});
	
	myDiv.on('plotly_legenddoubleclick', function(eventdata){
		setTimeout(function(){
			 $('.traces').each( function (index, item) {
				 legend_click_check[index] = $(item).css('opacity'); 
			 });
			 $('.check_rect').each( function (index, item) {
				 if(legend_click_check[index] == "1") {
					$(item).css('fill','#00498C');
				 } else {
					$(item).css('fill','white');
				 }
			 })
			},500);
	});
	
	//Zoom 했을 경우 
	myDiv.on('plotly_relayout',
			function(eventdata){
			//분기처리 추가(버튼을 눌러 사이즈를 조정 하게 되면 무조건 plotly_relayout을 타게됨 > 엑셀 데이터에 문제생김)
			if(eventdata['xaxis.range[0]'] != undefined){
				if(eventdata['xaxis.range[0]'].indexOf(".") != -1){
					Zoom_start = eventdata['xaxis.range[0]'].substring(0, eventdata['xaxis.range[0]'].indexOf("."));
				}else{
					Zoom_start = eventdata['xaxis.range[0]'];
				}
			}
			
			if(eventdata['xaxis.range[1]'] != undefined){
				if(eventdata['xaxis.range[1]'].indexOf(".") != -1){
					Zoom_end = eventdata['xaxis.range[1]'].substring(0, eventdata['xaxis.range[1]'].indexOf("."));
				}else{
					Zoom_end = eventdata['xaxis.range[1]'];
				}	
			}
			//초기화
			if(eventdata["xaxis.autorange"]){
				Zoom_start = dateCalc(jsonData[0].DATE, -3599);
				Zoom_end = jsonData[0].DATE;
			}
	});
	
	//double click 하여 Zoom 축소 했을 경우 
	myDiv.on('plotly_doubleclick', function() {
		Zoom_start = dateCalc(jsonData[0].DATE, -3599);
		Zoom_end = jsonData[0].DATE;
	});
	/*
	
	*/
	/*myDiv.on('plotly_legenddoubleclick',function() { 
		alert("오예~");
	});*/
	//저장 Button hide
	$('#excelDownBtn').show();
	
	//progressbar 종료
	closeProgressBar();
}



/*
function rand() {
	  return Math.random();
}

var cnt = 0;
var time = new Date(timeArea);

var interval = setInterval(function() {
	time = new Date(time.setSeconds(time.getSeconds() + 1));
	if(time.getMonth()+1 < 10) {
		var month = "0" + (time.getMonth()+1);
	} else {
		var month = (time.getMonth()+1);
	}
	
	if(time.getDate() < 10) {
		var date = time.getDate() + 1                         
	}
	
	querytime  = time.getFullYear() + "-" + month + "-" + (time.getDate()) + " " + time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds();
	es.search({
		index: id,
		body: {
			"query":{"bool" : {"should" : {"match" : {"DATE" : querytime}}}},
			"sort": {"DATE" : {"order":"desc"}},
			"_source": tag_id_bae ,
			size : 1,
		}
	}).then(function (response) {
		$scope.hits = response.hits.hits;
		
		var time = new Date();
		  var something = {};
		  something["aa"] = "aa";
		  var update = {};
		  var i=0;
		  var DATE = new Array();
		  var DATA = new Array();
		  while (i<tag_id_bae.length-1) {
			  DATE[i] =  [time];
			  DATA[i] = [$scope.hits[0]._source[tag_id_bae[i]]];    
			  DATA[i] = [rand()];
			  i++;
		  }
		  
		  update["x"] = DATE;
		  update["y"] = DATA;
		  
		  
		  
		  console.log([DATE[0],DATE[1]]);
		  
		  var olderTime = time.setMinutes(time.getMinutes() - 1);
		  var futureTime = time.setMinutes(time.getMinutes() + 1);
		  
		  var minuteView = {
		        xaxis: {
		          type: 'date',
		          range: [olderTime,futureTime]
		        }
		      };
		  
		  Plotly.relayout('myDiv', minuteView);
		  Plotly.extendTraces('myDiv', update, [0,1,2,3,4,5,6,7,8,9,10])
	});
  
  
  if(cnt === 100) clearInterval(interval);
}, 1000);
*/

//다운 버튼 - csv 파일 저장
function fn_excelDown(){
	try{
		//source
		var id = $('#hidCurrentMenu').val().split('_')[1];
		var tag_id_bae = $('#tag_id').combobox('getValue').split("&&&")[0].split(',');
		tag_id_bae.push("DATE");
		
		var data = {"startTime":Zoom_start
				,"endTime":Zoom_end
				,"index":[id]
				,"field1":tag_id_bae
				};
		
		$.ajax({
			url: "/web-engineTrend",
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
					fn_excelDown_callback(result,tag_id_bae);	
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

//다운 버튼 - csv 파일 저장 콜백
function fn_excelDown_callback(result){
	try{
		//호출데이터
		var jsonData = JSON.parse(result);
		//SelectBox 선택 ID - EA0000,EA0000,EA0000 ...
		var tag_Array = $('#tag_id').combobox('getValue').split("&&&")[0].split(',');
		//SelectBox 선택 Group - EA0000,EA0000,EA0000 ...
		var tag_Group = $('#tag_id').combobox('getText');
		//CSV - Row
		var csv_row = new Array();
		
		//csv파일 헤더 매핑
		csv_row[0] = ["DATE"];
		csv_row[0].push($("#tag_id").combobox('getValue').split("&&&")[1].split(','));
		
		//csv파일 바디 매핑
		var csv_body_field = new Array();
		for(var i = 0; i<=jsonData.length-1; i++)
		{
			//DATE
			csv_body_field[0] = jsonData[i].DATE;
			//EngineData
			for(var j = 0; j<=tag_Array.length-1; j++){
				csv_body_field[j+1] = jsonData[i][tag_Array[j]];
			}
			csv_row[i+1] = csv_body_field.join(',');
		}
		
		//데이터가 없는 경우 예외 처리
		if(!csv_row) {
			console.error('Console.save: No data')
			return;
		}
		//파일 저장
		var filename = "TrendViewData.csv";
		var blob = new Blob([csv_row.join("\n")], {type: 'text/plain'}),
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

//y축 보폭 변경
function Change_yscale() {
	var update = {
			'yaxis.range[0]': $("#yaxis_min").val(),
			'yaxis.range[1]': $("#yaxis_max").val()
		}

		Plotly.relayout('myDiv', update);
}

//hoverinfo textbox 자릿수 맞추기
function data_spaces(num, plus_len) {
	var space = '';
	num = num.toString();

	if (num.length < plus_len) {
		for (var i = 0; i < plus_len - num.length; i++)
			space += ' ';
	}
	return space + num;
}

function parse (a)
{
    var b={};
    for (var i in a = a.match(/(\w+\((\-?\d+\.?\d*e?\-?\d*,?)+\))+/g))
    {
        var c = a[i].match(/[\w\.\-]+/g);
        b[c.shift()] = c;
    }
    return b;
}

function getXYFromTranslate(element){
    var split = $(element).attr("transform").split(",");
    var x = split[0].split("(")[1];
    var y = split[1].split(")")[0];
    /*alert(x, y);*/
    return [x, y];
} 