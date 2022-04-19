var window_x = $(window).width();
var window_y = $(window).height();
$(window).resize( function() {
	window_x = $(window).width();
	window_y = $(window).height();
})

$(document).ready(function(){
	//progressbar 시작
	showProgressBar();
	//한국시간 표시, 반복실행 실행시키기
	play_repeat();
});
window.onload = function () {
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	top_line(context);
	

	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("13.8kV, 3P3W, 60Hz, 3200A, SYM, 31.5kA",25,290);
	
	context.moveTo(10, 300);
	context.lineTo(1900,300);
	context.moveTo(20, 290);
	context.lineTo(10, 290);
	context.lineTo(10, 310);
	context.lineTo(20, 310);
	context.moveTo(1890, 290);
	context.lineTo(1900, 290);
	context.lineTo(1900, 310);
	context.lineTo(1890, 310);
	
	var i = 5;
	var x = 110;
	while (i < 10) {
		middle_line(context, x, i);
		x += 300;
		i++;
	}
	
	middle_line_common(context);
	
	context.stroke();
	
	canvas.addEventListener("click", function (e) {
		//480V SWITCHYARD 화살표 클릭 시 Low Voltage로 이동
		//페이지 이동(date, menuId,text, url)		
		/*if((window_x*0.7>e.layerX && e.layerX>window_x*0.64)&&(window_y*0.70>e.layerY && e.layerY>window_y*0.68)) {
			page_move(dateCombine("eng_Search"),"low_voltage","LowVoltage","/low_voltage");
		}*/
		if(window_x > 1900) {
			if((window_x*0.7>e.layerX && e.layerX>window_x*0.64)&&(window_y*0.70>e.layerY && e.layerY>window_y*0.68)) {
				page_move(dateCombine("eng_Search"),"low_voltage","LowVoltage","/low_voltage");
			}
		} else if(window_x > 1700) {
			if(window_x*0.69>e.layerX && e.layerX>window_x*0.63&&(window_y*0.69>e.layerY && e.layerY>window_y*0.67)) {
				page_move(dateCombine("eng_Search"),"low_voltage","LowVoltage","/low_voltage");
			}
		} else if(window_x > 1500) {
			if(window_x*0.68>e.layerX && e.layerX>window_x*0.62&&(window_y*0.68>e.layerY && e.layerY>window_y*0.66)) {
				page_move(dateCombine("eng_Search"),"low_voltage","LowVoltage","/low_voltage");
			}
		}
	});
}

function top_line(context) {
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("TERMONORTE 44KV S/S",830,20);
	
	
	context.moveTo(900, 30);
	context.lineTo(895, 35);
	context.moveTo(900, 30);
	context.lineTo(905, 35);
	
	context.moveTo(900, 30);
	context.lineTo(900, 100);
	context.lineTo(926, 100);
	context.lineTo(926, 110);
	
	context.moveTo(919, 110);
	context.lineTo(933, 110);
	context.moveTo(921, 113);
	context.lineTo(931, 113);
	context.moveTo(923, 116);
	context.lineTo(929, 116);
	
	context.moveTo(900, 100);
	context.lineTo(890, 110);
	context.moveTo(900, 100);
	context.lineTo(910, 110);
	
	context.stroke();
	
	context.font = "12px malgun gothic";
	context.fillText("#2 STEP UP TR",795,100);
	context.fillText("44/13.8kV",805,115);
	context.fillText("50/60MVA",805,130);
	context.fillText("YNd11",810,145);
	
	context.beginPath();
	context.arc(900, 100, 17, 0, Math.PI * 2);
	
	context.moveTo(900, 118);
	context.lineTo(890, 140);
	context.lineTo(910, 140);
	context.lineTo(900, 118);
	
	context.stroke();
	
	context.beginPath();
	context.arc(900, 127, 17, 0, Math.PI * 2);
	
	context.moveTo(900, 145);
	context.lineTo(900, 300);

	context.fillText("VCB-OUT",810,195);
	context.fillText("17.5kV",815,210);
	context.fillText("1250A",815,225);
	context.fillText("31.5kA",815,240);
	
	
	context.stroke();
}

function middle_line(context, x, i) {
	context.moveTo(x, 300);
	context.lineTo(x, 850);
	
	context.moveTo(x-7, 850);
	context.lineTo(x+7, 850);
	context.moveTo(x-4, 853);
	context.lineTo(x+4, 853);
	context.moveTo(x-2, 856);
	context.lineTo(x+2, 856);
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("VCB-EG" + (i+1),x-65,390);
	context.fillText("17.5KV",x-62,405);
	context.fillText("1250A",x-62,420);
	context.fillText("31.5kA",x-62,435);
	
	context.moveTo(x, 450);
	context.lineTo(x-50, 450);
	context.lineTo(x-50, 520);
	
	context.fillText("ES",x-30,500);
	
	context.moveTo(x-57, 520);
	context.lineTo(x-43, 520);
	context.moveTo(x-54, 523);
	context.lineTo(x-46, 523);
	context.moveTo(x-52, 526);
	context.lineTo(x-48, 526);
	context.stroke();
	
	context.beginPath();
	context.arc(x, 600, 17, 0, Math.PI * 2);
	context.fillStyle = "white";
	/*context.fillStyle = "#FF0000";*/
	context.fill();
	
	context.font = "14px malgun gothic"
	context.fillStyle = "black";
	context.fillText("G" + (i+1),x-10,605);
	
	context.font = "12px malgun gothic"
	context.fillText("#" + (i+1) + " GEN",x+30,600);
	context.fillText("13.8kV 60Hz",x+25,615);
	context.fillText("11640kVA",x+27,630);
	context.fillText("720RPM",x+29,645);
	
	context.moveTo(x-10, 645);
	context.lineTo(x-10, 650);
	context.lineTo(x+10, 650);
	context.lineTo(x+10, 645);
	
	context.fillText("#" + (i+1) + " NGR",x+28,730);
	context.fillText("100A",x+30,745);
	context.fillText("10SEC",x+28,760);
	context.fillText("79.7ohm",x+27,775);
	
	/*context.fillStyle = "#FFD700";*/
	context.fillStyle = "GREY";
	context.fillRect(x-7.5, 800, 15, 25);
}

function middle_line_common(context) {
	context.moveTo(1610, 300);
	context.lineTo(1610, 585);
	
	context.font = "12px malgun gothic";
	context.fillStyle = "black";
	context.fillText("VCB-AU2",1535,390);
	context.fillText("17.5KV",1538,405);
	context.fillText("1250A",1538,420);
	context.fillText("31.5kA",1538,435);
	
	context.moveTo(1610, 585);
	context.lineTo(1600, 610);
	context.lineTo(1620, 610);
	context.lineTo(1610, 585);
	context.stroke();

	context.beginPath();
	context.arc(1610, 600, 17, 0, Math.PI * 2);

	context.moveTo(1610, 616);
	context.lineTo(1610, 635);
	context.lineTo(1600, 645);
	context.moveTo(1610, 635);
	context.lineTo(1620, 645);
	
	context.moveTo(1610, 635);
	context.lineTo(1585, 635);
	context.lineTo(1585, 640);
	context.moveTo(1578, 640);
	context.lineTo(1592, 640);
	context.moveTo(1581, 643);
	context.lineTo(1589, 643);
	context.moveTo(1583, 646);
	context.lineTo(1587, 646);
	
	context.stroke();
	
	context.beginPath();
	context.arc(1610, 632, 17, 0, Math.PI * 2);
	
	context.font = "12px malgun gothic";
	context.fillText("#2 AUX. TR",1520,600);
	context.fillText("13.8/0.48kV",1520,615);
	context.fillText("3.0MVA",1530,630);
	context.fillText("Dyn11",1535,645);
	
	context.moveTo(1610, 650);
	context.lineTo(1610, 820);
	context.lineTo(1570, 820);
	
	context.lineTo(1570, 830);
	context.lineTo(1480, 830);
	context.lineTo(1460, 820);
	context.lineTo(1480, 810);
	context.lineTo(1570, 810);
	context.lineTo(1570, 820);
	
	context.font = "10px malgun gothic"
	context.fillStyle = "black";
	context.fillText("480V SWITCHYARD",1475,823);

	
	/*
	ctx.lineTo(1570, 830);
	ctx.lineTo(1480, 830);
	ctx.lineTo(1460, 820);
	ctx.lineTo(1480, 810);
	ctx.lineTo(1570, 810);
	ctx.lineTo(1570, 820);
	
	ctx.font = "10px malgun gothic"
	ctx.fillStyle = "black";
	ctx.fillText("480V SWITCHYARD",1475,823);
	ctx.stroke();*/
	
	/*path = new Path2D();
	path.rect(1400, 800, 150, 100.5);
	ctx.fillStyle = "black";
	ctx.fill(path);*/
	
}

//single line switch img 그리기
function switch_img(context, x, y, src) {
	var img_src = new Image();
	img_src.src = src
	img_src.onload = function(e) {
		context.drawImage(img_src, x+3, y, 30, 30);
	}
}
//ElasticSearch 데이타 조회 - engine
function elasticDataSearch(timeArea){
	try{
		var data = {"startTime":timeArea
				,"index":["engine01", "engine02", "engine03","engine04", "engine05", "engine06", "engine07","engine08", "engine09", "engine10"]
				,"field1":["*"]};
		$.ajax({
			url: "/web-elecStauts",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				if(result == "error"){
					alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");
					closeProgressBar();
				}
				
				var json_result = JSON.parse(result);
				var c = 0;
				while(c < 10) {
					if(json_result[c].data_exist != "no_data") {
						$("#hidWebData").val(result);
						fn_EngSort(result, c);	
						break;
					}
					c++;
				}
				if( c == 10 ) {
					alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");
					closeProgressBar();
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

//Engine Data 2(데이터 파싱 후 뿌려주기)
function fn_EngSort(searchData, index) {
	var jsonData = JSON.parse(searchData);
	
	//시간정보 SearchBox영역에 뿌려주기
	displayDate(jsonData[index].DATE);
	
	//정렬
	jsonData.sort(function(a,b){
		return a._index < b._index ? -1 : a._index > b._index ? 1:0;
	});
	// 커먼데이터 호출
	elasticDataSearch_Common(jsonData, index);
}

//ElasticSearch 데이타 조회 - common
function elasticDataSearch_Common(eng_data, index){
	var data = {"startTime":eng_data[index].DATE
			,"index":["common01"]};
	$.ajax({
		url: "/web-elecStauts-common",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				elasticDataSearch_EngineAlarm("no_data",eng_data,index);	
				closeProgressBar();
			}else if(result == "error"){
				elasticDataSearch_EngineAlarm("no_data",eng_data,index);	
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				elasticDataSearch_EngineAlarm(result,eng_data,index);	
			}
		}
	});
}


function elasticDataSearch_EngineAlarm(com_data, eng_data, index) {
	var data = {"startTime":eng_data[index].DATE
			,"index":["engine01_st","engine02_st","engine03_st","engine04_st","engine05_st","engine06_st","engine07_st","engine08_st","engine09_st","engine10_st"]
			,"field1":["DATE","ED1031","ED1049"]};
	$.ajax({
		url: "/web-elecStauts",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				/*alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");*/
				elasticDataSearch_CommonAlarm(com_data,eng_data,"no_data",index);
				closeProgressBar();
			}else if(result == "error"){
				/*alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");*/
				elasticDataSearch_CommonAlarm(com_data,eng_data,"no_data",index);
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				elasticDataSearch_CommonAlarm(com_data,eng_data,result,index);	
			}
		}
	});
}

function elasticDataSearch_CommonAlarm(com_data, eng_data, engine_alarm, index) {
	var data = {"startTime":eng_data[index].DATE
			,"index":["common01_al"]
			,"field1":["DATE","CD0630","CD0640"]};
	$.ajax({
		url: "/web-elecStauts-common",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				/*alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");*/
				fn_MV(com_data,eng_data,engine_alarm,"no_data");
				closeProgressBar();
			}else if(result == "error"){
				/*alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");*/
				fn_MV(com_data,eng_data,engine_alarm,"no_data");
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				fn_MV(com_data,eng_data,engine_alarm,result);	
			}
		}
	});
}

//ElasticSearch 데이타 조회  콜백
function fn_MV(result, eng_data, eng_data_alarm, com_data_alarm){
	var com_data;
	if(result == "no_data") {
		com_data = "no_data";
	} else {
		com_data = JSON.parse(result);
		com_data = com_data.common01;
	}
	
	if(com_data_alarm == "no_data") {
		com_data_al = "no_data";
	} else {
		com_data_al = JSON.parse(com_data_alarm);
		com_data_al = com_data_al.common01_al;
	}
	
	var eng_data_al = JSON.parse(eng_data_alarm);
	
	//정렬
	eng_data_al.sort(function(a,b){
		return a._index < b._index ? -1 : a._index > b._index ? 1:0;
	});
	
	
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	
	context.clearRect(950, 130, 270, 150);
	
	var i=5;
	var x=130;
	while (i<10) {
		context.clearRect(x, 320, 150, 270);
		if(eng_data[i].data_exist == "no_data") {
			gen_data(context,"no_data",x,320);
		} else {
			gen_data(context,eng_data[i],x,320);
		}
		
		x+=300;
		i++;
	}
	
	context.clearRect(x, 320, 150, 270);
	if(com_data == "no_data") {
		outgoing(context,"no_data",950,130);
		AUX(context,"no_data",x,320);
	} else {
		outgoing(context,com_data,950,130);
		AUX(context,com_data,x,320);
	}
	
	vcb_switch(com_data_al, eng_data_al, context);
	///////////////////////////////
	//progressbar 종료
	closeProgressBar();
}
	
function vcb_switch(common_data, engine_data, context) {
	//Top Line OUTGOING VCB
	if(common_data.CD0630) {
		switch_img(context, 881, 200, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 881, 200, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//Middle Line Engine GEN VCB(1~5)
	var i = 5;
	var x = 110;
	while (i < 10) {
		if(engine_data[i].ED1031) {
			switch_img(context, x-20, 400, "/image/singleline/CB_OPEN_W_SERO.gif");
		} else {
			switch_img(context, x-20, 400, "/image/singleline/CB_CLOSE_W_SERO.gif");
		}
		if(engine_data[i].ED1049) {
			switch_img(context, x-69, 480, "/image/singleline/CB_OPEN_W_SERO.gif");
		} else {
			switch_img(context, x-69, 480, "/image/singleline/CB_CLOSE_W_SERO.gif");
		}
		x += 300;
		i++;
	}
	
	//VCB AUX1
	if(common_data.CD0640) {
		switch_img(context, 1590, 400, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 1590, 400, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
}
	
function outgoing(context, json, x, y) {
	var data = new Array();
	var c = 0;
	while (c < 12) {
		data[c] = new Array();
		c++;
	}
	
	c = 0;
	if(json == "no_data") {
		while (c < 12) {
			data[c][0] = 0;
			c++;
		}
	} else {
		data[0][0] = json.CA0013; 
		data[1][0] = json.CA0016; 
		data[2][0] = json.CA0014; 
		data[3][0] = json.CA0017; 
		data[4][0] = json.CA0015; 
		data[5][0] = json.CA0018;
		data[6][0] = json.CA0019; 
		data[7][0] = json.CA0020; 
		data[8][0] = json.CA0021; 
		data[9][0] = json.CA0022;
		data[10][0] = json.CA0023; 
		data[11][0] = json.CA0024; 
	}
	
	data[0][1] = "R-S"; data[0][2] = "V";
	data[1][1] = "R"; data[1][2] = "A";
	data[2][1] = "S-T"; data[2][2] = "V";
	data[3][1] = "S"; data[3][2] = "A";
	data[4][1] = "T-R"; data[4][2] = "V";
	data[5][1] = "T"; data[5][2] = "A";
	data[6][1] = "FREQ"; data[6][2] = "Hz";
	data[7][1] = "PF"; data[7][2] = "pf";
	data[8][1] = "KW"; data[8][2] = "kW";
	data[9][1] = "KVAR"; data[9][2] = "kVar";
	data[10][1] = "MWh"; data[10][2] = "MWh";
	data[11][1] = "MVarh"; data[11][2] = "MVarh";
	
	
	context.clearRect(x, y, 350, 100);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 50;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 6) {
		while (x_i < 4) {
			context.beginPath();
			context.rect(x, y, x_w, 25);
			context.strokeStyle = "black"; //사각형 선 색
			context.lineWidth = 1.5; //사각형 선 두께
			context.lineJoin = "miter"; //사각형 모서리 모양
			if(sw == 1) {
				context.fillStyle = "white";
				/*context.fillStyle = "#32CD32";*/ //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][0],x+10,y+15);
				context.fillText(data[i][2],x+55,y+15);
				x += 100
				x_w = 50;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+5,y+15);
				x += 50;
				x_w = 100;
				sw = 1;
			}
			x_i++;
			
		}
		x_i = 0;
		x = x_init;
		y += 25;
		y_i++;
	}
}
	
function gen_data(context, json, x, y) {
	
	var data = new Array();
	var c = 0;
	while (c < 10) {
		data[c] = new Array();
		c++;
	}
	
	c = 0;
	if(json == "no_data") {
		while(c < 10) {
			data[c][0] = 0;
			c++;
		}
	} else {
		data[0][0] = json.EA0164; 
		data[1][0] = json.EA0167; 
		data[2][0] = json.EA0165; 
		data[3][0] = json.EA0168; 
		data[4][0] = json.EA0166; 
		data[5][0] = json.EA0169; 
		data[6][0] = json.EA0170; 
		data[7][0] = json.EA0171; 
		data[8][0] = json.EA0172; 
		data[9][0] = json.EA0173; 
	}
	
	
	data[0][1] = "R-S"; data[0][2] = "V";
	data[1][1] = "R"; data[1][2] = "A";
	data[2][1] = "S-T"; data[2][2] = "V";
	data[3][1] = "S"; data[3][2] = "A";
	data[4][1] = "T-R"; data[4][2] = "V";
	data[5][1] = "T"; data[5][2] = "A";
	data[6][1] = "FREQ"; data[6][2] = "Hz";
	data[7][1] = "PF"; data[7][2] = "pf";
	data[8][1] = "KW"; data[8][2] = "kW";
	data[9][1] = "KVAR"; data[9][2] = "kVar";
	
	
	context.clearRect(x, y, 200, 100);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 50;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 10) {
		while (x_i < 2) {
			context.beginPath();
			context.rect(x, y, x_w, 25);
			context.strokeStyle = "black"; //사각형 선 색
			context.lineWidth = 1.5; //사각형 선 두께
			context.lineJoin = "miter"; //사각형 모서리 모양
			if(sw == 1) {
				context.fillStyle = "white";
				/*context.fillStyle = "#32CD32";*/ //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][0],x+10,y+15);
				context.fillText(data[i][2],x+55,y+15);
				x += 100
				x_w = 50;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+5,y+15);
				x += 50;
				x_w = 100;
				sw = 1;
			}
			x_i++;
			
		}
		x_i = 0;
		x = x_init;
		y += 25;
		y_i++;
	}
	
}
	
function AUX(context, json, x, y) {
	var data = new Array();
	var c = 0;
	while (c < 10) {
		data[c] = new Array();
		c++;
	}
	
	c = 0;
	if(json == "no_data") {
		while (c < 10) {
			data[c][0] = 0;
			c++;
		}
	} else {
		data[0][0] = json.CA0035; 
		data[1][0] = json.CA0038; 
		data[2][0] = json.CA0036; 
		data[3][0] = json.CA0039; 
		data[4][0] = json.CA0037; 
		data[5][0] = json.CA0040; 
		data[6][0] = json.CA0041; 
		data[7][0] = json.CA0042; 
		data[8][0] = json.CA0043; 
		data[9][0] = json.CA0044;
	}

	
	data[0][1] = "R-S"; data[0][2] = "V";
	data[1][1] = "R"; data[1][2] = "A";
	data[2][1] = "S-T"; data[2][2] = "V";
	data[3][1] = "S"; data[3][2] = "A";
	data[4][1] = "T-R"; data[4][2] = "V";
	data[5][1] = "T"; data[5][2] = "A";
	data[6][1] = "FREQ"; data[6][2] = "Hz";
	data[7][1] = "PF"; data[7][2] = "pf";
	data[8][1] = "KW"; data[8][2] = "kW";
	data[9][1] = "KVAR"; data[9][2] = "kVar";
	
	
	
	
	context.clearRect(x, y, 200, 100);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 50;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 10) {
		while (x_i < 2) {
			context.beginPath();
			context.rect(x, y, x_w, 25);
			context.strokeStyle = "black"; //사각형 선 색
			context.lineWidth = 1.5; //사각형 선 두께
			context.lineJoin = "miter"; //사각형 모서리 모양
			if(sw == 1) {
				context.fillStyle = "white";
				/*context.fillStyle = "#32CD32";*/ //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][0],x+10,y+15);
				context.fillText(data[i][2],x+55,y+15);
				x += 100
				x_w = 50;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+5,y+15);
				x += 50;
				x_w = 100;
				sw = 1;
			}
			x_i++;
		}
		x_i = 0;
		x = x_init;
		y += 25;
		y_i++;
	}
}


