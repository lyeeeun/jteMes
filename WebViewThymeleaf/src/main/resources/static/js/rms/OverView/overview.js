var Search_Date;

$(document).ready(function(){
	//progressbar 시작
	showProgressBar();
	//한국시간 표시, 반복실행 실행시키기
	play_repeat();
});

//ElasticSearch 데이타 조회 
function elasticDataSearch(timeArea){
	var startCalcDate = dateCalc(timeArea, -0);
	var data = {"startTime":startCalcDate,"endTime":timeArea
			,"index":["engine01","engine02","engine03","engine04","engine05","engine06","engine07","engine08","engine09","engine10"]
			,"field1":["DATE","EA0172","EA0054"]};
	try{
	$.ajax({
		url: "/web-overview",
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
				elasticDataSearch_EngineSD(JSON.parse(result));	
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
	//프로그레스 종료
	closeProgressBar();
}


function elasticDataSearch_EngineSD(eng_data) {
	var c = 0;
	var eng_data_date;
	while (c < 10) {
		if(eng_data[c].source[0].DATE != undefined) {
			eng_data_date = eng_data[c].source[0].DATE;
			break;
		}
		c++;
	}
	
	if(c == 10) {
		alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");
	}
	
	var data = {"startTime":eng_data_date
			,"index":["engine01_sd","engine02_sd","engine03_sd","engine04_sd","engine05_sd","engine06_sd","engine07_sd","engine08_sd","engine09_sd","engine10_sd"]};
	$.ajax({
		url: "/web-overview",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				elasticDataSearch_EngineTR(eng_data,"no_data",eng_data_date);
				closeProgressBar();
			}else if(result == "error"){
				elasticDataSearch_EngineTR(eng_data,"no_data",eng_data_date);
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				elasticDataSearch_EngineTR(eng_data,result,eng_data_date);	
			}
		}
	});
}

function elasticDataSearch_EngineTR(eng_data,eng_data_sd,eng_data_date) {
	var data = {"startTime":eng_data_date
			,"index":["engine01_tr","engine02_tr","engine03_tr","engine04_tr","engine05_tr","engine06_tr","engine07_tr","engine08_tr","engine09_tr","engine10_tr"]};
	$.ajax({
		url: "/web-overview",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				elasticDataSearch_EngineAL(eng_data,eng_data_sd,"no_data",eng_data_date);
				closeProgressBar();
			}else if(result == "error"){
				elasticDataSearch_EngineAL(eng_data,eng_data_sd,"no_data",eng_data_date);
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				elasticDataSearch_EngineAL(eng_data,eng_data_sd,result,eng_data_date);	
			}
		}
	});
}

function elasticDataSearch_EngineAL(eng_data,eng_data_sd,eng_data_tr,eng_data_date) {
	var data = {"startTime":eng_data_date
			,"index":["engine01_al","engine02_al","engine03_al","engine04_al","engine05_al","engine06_al","engine07_al","engine08_al","engine09_al","engine10_al"]};
	$.ajax({
		url: "/web-overview",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				elasticDataSearch_EngineST(eng_data,eng_data_sd,eng_data_tr,"no_data",eng_data_date);
				closeProgressBar();
			}else if(result == "error"){
				elasticDataSearch_EngineST(eng_data,eng_data_sd,eng_data_tr,"no_data",eng_data_date);
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				elasticDataSearch_EngineST(eng_data,eng_data_sd,eng_data_tr,result,eng_data_date);	
			}
		}
	});
}

function elasticDataSearch_EngineST(eng_data,eng_data_sd,eng_data_tr,eng_data_al,eng_data_date) {
	var data = {"startTime":eng_data_date
			,"index":["engine01_st","engine02_st","engine03_st","engine04_st","engine05_st","engine06_st","engine07_st","engine08_st","engine09_st","engine10_st"]};
	$.ajax({
		url: "/web-overview",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				fn_OverView(eng_data,eng_data_sd,eng_data_tr,eng_data_al,"no_data");
				closeProgressBar();
			}else if(result == "error"){
				fn_OverView(eng_data,eng_data_sd,eng_data_tr,eng_data_al,"no_data");
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				fn_OverView(eng_data,eng_data_sd,eng_data_tr,eng_data_al,result);	
			}
		}
	});
}

//ElasticSearch 데이타 조회 콜백
function fn_OverView(searchData,eng_data_sd,eng_data_tr,eng_data_al,eng_data_st){
	var jsonData = searchData
	var jsonData_sd = JSON.parse(eng_data_sd);
	var jsonData_tr = JSON.parse(eng_data_tr);
	var jsonData_al = JSON.parse(eng_data_al);
	var jsonData_st = JSON.parse(eng_data_st);
	
	
	/*var jsonData_al = searchData.source_al;*/
	var i = 0;
	var enName= ["No.01 GE","No.02 GE","No.03 GE","No.04 GE","No.05 GE","No.06 GE","No.07 GE","No.08 GE","No.09 GE","No.10 GE"];
	var realAvg = 0;
	var realCnt = 0;
	var aJsonAr = new Array();
	var kW = new Array();
	var rToS = new Array();
	var run = new Array();
	var aval = 0;
	var runningHour = new Array();
	var engine_alarm_count = new Array();
	var total_alarm_count = 0;
	
	Search_Date = jsonData[0].source[0].DATE; 
	//시간정보 SearchBox영역에 뿌려주기
	displayDate(Search_Date);
	
	//정렬
	jsonData.sort(function(a,b){
		return a._index < b._index ? -1 : a._index > b._index ? 1:0;
	});

	
	var index_c = 0; 
	var alarm_c;
	//데이터 처리
	for(var i = 0; i<= jsonData.length -1; i++) {
		aJsonAr[i] = jsonData[i];//engine별 소스 담기
		realAvg += aJsonAr[i].source[0].EA0172; // KW 평균 값
		kW[i] = aJsonAr[i].source[0].EA0172; // KW
		if(jsonData_st[i] == undefined) {
			rToS[i] = false; // RunToStop
		} else {
			rToS[i] = jsonData_st[i].source[0].ED1053; // RunToStop
		}
		
		if(jsonData_st[i] == undefined) {
			run[i] = false; // EngineRunning
		} else {
			run[i] = jsonData_st[i].source[0].ED1035; // EngineRunning
		}
		
		
		if(rToS[i] == true || run[i] == true){
			aval += 10;
		}
		
		runningHour[i] = aJsonAr[i].source[0].EA0054;
		
		//engine별, 전체 alarm count 구하기. 749 => alarm만 가져오기 위해서 우선 하드코딩(변경 예정), 749 이후는 mode 값
		alarm_c = 0; 
		engine_alarm_count[i] = 0;
		for(var count=0; count < 749; count++) {
			if(jsonData_sd[i] != undefined) {
				if(jsonData_sd[i].source[0]["ED" + padLeft(count, 4)]) {
					engine_alarm_count[i]++;
					total_alarm_count++;
				}
			}
			
			if(jsonData_tr[i] != undefined) {
				if(jsonData_tr[i].source[0]["ED" + padLeft(count, 4)]) {
					engine_alarm_count[i]++;
					total_alarm_count++;
				}
			}
			
			if(jsonData_al[i] != undefined) {
				if(jsonData_al[i].source[0]["ED" + padLeft(count, 4)]) {
					engine_alarm_count[i]++;
					total_alarm_count++;
				}
			}
			 
			if(jsonData_st[i] != undefined) {
				if(jsonData_st[i].source[0]["ED" + padLeft(count, 4)]) {
					engine_alarm_count[i]++;
					total_alarm_count++;
				}
			}
			/*} else if(jsonData_tr[i].source[0]["ED" + padLeft(count, 4)] && ) {
				engine_alarm_count[i]++;
				total_alarm_count++;
			} else if(jsonData_al[i].source[0]["ED" + padLeft(count, 4)] && jsonData_al[i].source[0] != undefined) {
				engine_alarm_count[i]++;
				total_alarm_count++;
			} else if(jsonData_st[i].source[0]["ED" + padLeft(count, 4)] && jsonData_st[i].source[0] != undefined) { 
				engine_alarm_count[i]++;
				total_alarm_count++;
			}*/
		}
	}
	
	/*Site Power Output*/
	//총 출력량 표시
	var engineHour = document.getElementById('cv_ovHour');
	var ehCanvas = engineHour.getContext('2d');
	var hourX = engineHour.width/2;
	var hourY = engineHour.height/2;
	var hourPercent = ((realAvg/93000)*100).toFixed(1);
	//게이지 표시
	ehCanvas.clearRect( 0, 0, engineHour.width, engineHour.height );
	ehCanvas.beginPath();
	ehCanvas.arc( hourX, hourY, 90, (Math.PI/180) * 270, (Math.PI/180) * (270 + 360) );
	ehCanvas.strokeStyle = '#e3e6e8';
	ehCanvas.lineWidth = '40';
	ehCanvas.stroke();
	ehCanvas.beginPath();
	ehCanvas.strokeStyle = '#92d050';
	ehCanvas.lineWidth = '40';
	ehCanvas.arc( hourX, hourY, 90, (Math.PI/180) * 270, (Math.PI/180) * (270 + hourPercent * 3.6));
	ehCanvas.stroke();
	//퍼센트 표시,출력량 표시
	$("#ovHour_text").html("<p class='ov_dashPercent'>"+ parseFloat(hourPercent).toFixed()+ "%</p>" + (realAvg/1000).toFixed(2)+"MW");
	
	
	/*Engine Availability*/
	//총 출력량 표시
	var engineRun = document.getElementById('cv_ovRun');
	var erCanvas = engineRun.getContext('2d');
	var runX = engineRun.width/2;
	var runY = engineRun.height/2;
	
	//게이지 표시
	erCanvas.clearRect( 0, 0, engineRun.width, engineRun.height );
	erCanvas.beginPath();
	erCanvas.arc( runX, runY, 90, (Math.PI/180) * 270, (Math.PI/180) * (270 + 360) );
	erCanvas.strokeStyle = '#e3e6e8';
	erCanvas.lineWidth = '40';
	erCanvas.stroke();
	erCanvas.beginPath();
	erCanvas.strokeStyle = '#e46c0a';
	erCanvas.lineWidth = '40';
	erCanvas.arc( runX, runY, 90, (Math.PI/180) * 270, (Math.PI/180) * (270 + aval * 3.6));
	erCanvas.stroke();
	
	//1. 알람표시 모형 그리기
	erCanvas.beginPath();
	erCanvas.arc(runX+80, runY-130, 20, 0, Math.PI * 2);
	erCanvas.fillStyle='#E74746';
	erCanvas.fill();
	erCanvas.beginPath();
	erCanvas.strokeStyle = '#ffc000';
	erCanvas.lineWidth = '1';
	erCanvas.moveTo(runX+80, runY-147);
	erCanvas.lineTo(runX+65, runY-120);
	erCanvas.lineTo(runX+95, runY-120);
	erCanvas.lineTo(runX+80, runY-147);
	erCanvas.fillStyle='#ffc000';
	erCanvas.fill();
	erCanvas.fillStyle='black';
	erCanvas.font = "bold 18px malgun gothic";
	erCanvas.fillText("!", runX+77, runY-125);
	erCanvas.stroke();

	//2. Total count 표시
	erCanvas.beginPath();
	erCanvas.arc(runX+92, runY-148, 10, 0, Math.PI * 2);
	erCanvas.fillStyle='red';
	erCanvas.fill(); 
	erCanvas.beginPath();
	erCanvas.fillStyle='white';
	erCanvas.font = "12px malgun gothic";
	erCanvas.fillText(total_alarm_count,(runX+91)-(total_alarm_count.toString().length*2.5),runX-43);
	erCanvas.stroke();
	
	//퍼센트 표시,카운트 표시
	$("#ovRun_text").html("<p class='ov_dashPercent'>"+ aval+ "%</p>" +dateCombine('eng_Search').replace(" ","<br />") );
	
	/*PMS Schedule*/
	var rhValue = new Array();
	var rhNextDay = new Array();
	
	//D-Day, R/H 계산
	runningHour.forEach(function(realValue){
		var tempValue = realValue % 8000
		rhValue.push(tempValue);
		rhNextDay.push(Math.floor((8000-tempValue)/10));
	});
	
	var obOberBodyHtml = "";
	for(i=0; i< rhValue.length; i++){
		obOberBodyHtml += "<tr><td>" + enName[i] + "</td><td>D-" + (rhNextDay[i] == 1 ? "DAY":rhNextDay[i]) + "</td></tr>";
	}
	
	$("#ovOper_body").html(obOberBodyHtml);
	var pms_data = [{
		type: 'bar',
		x: rhValue.reverse(),
		y: enName.reverse(),
		text:rhValue.map(String),
		textposition: 'auto',
		hoverinfo: 'none',
		orientation: 'h',
		marker: {
			color: '#60a8e3'
		 }
	}];
	var pms_layout ={
			font:{color: '#000'},
			 paper_bgcolor: '#f2f2f2',
			 plot_bgcolor: '#f2f2f2',
			yaxis: {
				color:'#0000ff00'//y축 숨김 처리 
			},
			xaxis: {
				range: [0, 8000],
				type: 'linear',
				tickformat: ',d'
			},
	};
	Plotly.newPlot('ovPms_chart', pms_data, pms_layout);
	
	/*Monthly Graph*/
	monthly_output(jsonData[0].source[0].DATE);
	
	//Engine Power
	for(i=0; i<aJsonAr.length;i++){
		var can = document.getElementById('myCanvas'+i);
		var spanProcent = document.getElementById('procent'+i);
		var c = can.getContext('2d');
		var posX = can.width / 2;
		var posY = can.height / 2;
		var result = ((kW[i]/9300)*100).toFixed(1);
		
		//게이지 표시
		c.clearRect( 0, 0, can.width, can.height );
		//c.lineCap = 'round';
		c.beginPath();
		c.arc( posX, posY, 40, (Math.PI/180) * 270, (Math.PI/180) * (270 + 360) );
		c.strokeStyle = '#e3e6e8';
		c.lineWidth = '9';
		c.stroke();
		c.beginPath();
		c.strokeStyle = '#0070c0';
		c.lineWidth = '9';
		c.arc( posX, posY, 40, (Math.PI/180) * 270, (Math.PI/180) * (270 + result * 3.6));
		c.stroke();
		
		//Engine별 count 표시
		c.beginPath();
		c.arc(posX+35, posY-35, 10, 0, Math.PI * 2);
		c.fillStyle='red'
		c.fill();
		c.beginPath();
		c.fillStyle='white';
		c.font = "12px malgun gothic";
		c.fillText(engine_alarm_count[i],(posX+33.5)-(engine_alarm_count[i].toString().length*2.5),posY-30);
		c.stroke();
		//Engine별 Alarm count, 해당 Engine canvas 속성에 입력
		can.setAttribute('alarm_count', engine_alarm_count[i]);
		can.setAttribute('engine', padLeft(i+1,2));
		
		//퍼센트 표시
		$(spanProcent).text(parseFloat(result).toFixed());
		$(spanProcent).removeClass("ov_run");
		if(rToS[i] == true || run[i] == true){
			$(spanProcent).addClass("ov_run");
		}
		
		//출력량 표시
		$("#ovEngine_KW"+i).text(kW[i]+"KW");
	}
}

//월별 output 구하기
function monthly_output(timeArea) {
	var timeArea_gte = timeArea.substring(0,4) + "-01-01 00:00:00";
	var timeArea_lte = timeArea.substring(0,4) + "-12-31 23:59:59";
	var data = {"startTime":timeArea_gte,"endTime":timeArea_lte
			,"index":["en*"]
			,"field1":["DATE"]};
	try{
		$.ajax({
			url: "/web-overview-monthlygraph",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				var count = 0;
				var montly_date = new Array();
				var montly_load = new Array();
				var mothly_availability = new Array();
				var aggs_data = JSON.parse(result);
				while(count < aggs_data.length) {
					montly_date[7 + count] = aggs_data[count].montly_date.substring(0,7);
					montly_load[7 + count] = ((aggs_data[count].montly_load_value/3600/24/31)/1000).toString().substring(0, 4); //MW
					mothly_availability[7 + count] = aggs_data[count].montly_availability_value.substring(0,aggs_data[count].montly_availability_value.indexOf('.'));
					count++;
				}
				montly_date[0] = "2019-01";
				montly_date[1] = "2019-02";
				montly_date[2] = "2019-03";
				montly_date[3] = "2019-04";
				montly_date[4] = "2019-05";
				montly_date[5] = "2019-06";
				montly_date[6] = "2019-07";
				//임시 하드코딩
				mothly_availability[0] = "0";
				mothly_availability[1] = "0";
				mothly_availability[2] = "0";
				mothly_availability[3] = "0";
				mothly_availability[4] = "0";
				mothly_availability[5] = "0";
				mothly_availability[6] = "0";
				
				count=9;
				while(count < 12) {
					montly_date[count] = timeArea.substring(0,4) + "-" + padLeft(count+1, 2);
					montly_load[count] = 0;
					mothly_availability[count] = 0;
					count++;
				}

				var trace1 = {
					x: montly_date,
					y: montly_load,
					text:montly_load.map(String),
					textposition: 'auto',
					textfont: {
					    color: "white"
					},
					hoverinfo: 'none',
					name: '출력량(Mw)',
					marker: {
						color: '#60A8E3'
					},
					type: 'bar'
				};

				var trace2 = {
					x: montly_date,
					y: mothly_availability,
					mode:'lines+markers+text',
					text:mothly_availability.map(String),
					textposition: 'auto',
					hoverinfo: 'none',
					name: 'Availability(%)',
					marker: {
						color: '#E46C0A'
					},
					type: 'scatter'
				};
				
				var output_layout ={
						legend: {
						    x: 0.9,
						    y: 1.2,
						},
						font:{color: '#000'},
						paper_bgcolor: '#f2f2f2',
						plot_bgcolor: '#f2f2f2',
						yaxis: {
							color:'#0000ff00'//y축 숨김 처리 
						},
						xaxis: {
							tick0: montly_date[0],
						    dtick: "M1", // milliseconds
						    tickformat: '%B'
						}
				};
				var data = [trace1, trace2];

				Plotly.newPlot('output_year_graph', data, output_layout);
				
			}
		});
	}catch(err){
		if (err.status === 404) {
			alert("error 404" );
		} else {
			alert("error : " + err );
		}
	}
}

$(".ov_table").on('click', function(event){

	if($(event.target).attr('alarm_count') == 0 || $(event.target).prev().attr('alarm_count') == 0 || 
			($(event.target).attr('alarm_count') == undefined && $(event.target).prev().attr('alarm_count') == undefined )) {
		return false;
	} else {
		if($(event.target).attr('engine') != undefined) {
			var engine = $(event.target).attr('engine');
		} else {
			var engine = $(event.target).prev().attr('engine');
		}
		//페이지 이동(date, menuId,text, url)
		page_move(Search_Date,"esrv_engine" + engine,"RealValue","/engine_value");
	}

});
