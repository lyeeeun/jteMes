$(document).ready(function(){
	//progressbar 시작
	showProgressBar();
	//한국시간 표시, 반복실행 실행시키기
	play_repeat();
});

window.onload = function () {
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	//상단 #1outgoing
	
	
	top_line(context, 474, 1);
	top_line(context, 1446, 2);
	
	context.moveTo(10, 250);
	context.lineTo(900, 250);

	context.moveTo(10, 260);
	context.lineTo(10, 240);
	context.lineTo(20, 240);
	context.moveTo(10, 260);
	context.lineTo(20, 260);
	
	context.moveTo(900, 260);
	context.lineTo(900, 240);
	context.lineTo(890, 240);
	context.moveTo(900, 260);
	context.lineTo(890, 260);
	
	//
	var i = 0;
	var x = 40;
	while (i<5) {
		mid_line(context, x, i+1);
		x += 160;
		i++;
	}

	mid_line_common(context, 840, 1);
	

	context.moveTo(950, 250);
	context.lineTo(1800, 250);

	context.moveTo(950, 260);
	context.lineTo(950, 240);
	context.lineTo(960, 240);
	context.moveTo(950, 260);
	context.lineTo(960, 260);
	
	context.moveTo(1800, 260);
	context.lineTo(1800, 240);
	context.lineTo(1790, 240);
	context.moveTo(1800, 260);
	context.lineTo(1790, 260);
	
	x = 980;
	while (i<10) {
		mid_line(context, x, i+1);
		x += 160;
		i++;
	}
	
	mid_line_common(context, 1780, 2);
	
	context.moveTo(10, 650);
	context.lineTo(1800, 650);
	
	context.moveTo(10, 660);
	context.lineTo(10, 640);
	context.lineTo(20, 640);
	context.moveTo(10, 660);
	context.lineTo(20, 660);
	
	context.moveTo(1800, 660);
	context.lineTo(1800, 640);
	context.lineTo(1790, 640);
	context.moveTo(1800, 660);
	context.lineTo(1790, 660);
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("13.8kV, 3P3W, 60Hz, 3200A, SYM, 31.5kA",20,230);
	context.fillText("13.8kV, 3P3W, 60Hz, 3200A, SYM, 31.5kA",960,230);
	context.fillText("AC, 3P3W, 480V 60Hz 4000A, SYM, 65kA",20,630);
	
	////////
	bottom_line(context, 180, "#1 UNIT MCC");
	bottom_line(context, 520, "#1 COMMON MCC");
	bottom_line(context, 1200, "#2 UNIT MCC");
	bottom_line(context, 1540, "#2 COMMON MCC");
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("#1 UNIT MCC",135,795);
	context.fillText("#1 COMMON MCC",455,795);
	context.fillText("#2 UNIT MCC",1155,795);
	context.fillText("#2 COMMON MCC",1475,795);
	
	context.moveTo(830, 650);
	context.lineTo(830, 770);
	
	context.fillText("BSDG",850,680);
	context.fillText("ACB",853,695);
	
	context.stroke();
	
	context.beginPath();
	context.arc(830, 788, 17, 0, Math.PI * 2);
	/*context.fillStyle = "#FF0000";*/
	context.fillStyle = "white";
	context.fill();
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	
	context.fillText("BSDG",850,790);
	context.fillText("DG",820,793);
	
	context.moveTo(830, 805);
	context.lineTo(830, 850);
	context.moveTo(820, 850);
	context.lineTo(840, 850);
	context.lineTo(840, 840);
	context.moveTo(820, 850);
	context.lineTo(820, 840);
	
	context.fillText("TIE ACB",895,630);
	
	context.stroke();
}

//single line switch img 그리기
function switch_img(context, x, y, src) {
	var img_src = new Image();
	img_src.src = src
	img_src.onload = function(e) {
		context.drawImage(img_src, x+3, y, 30, 30);
	}
}

//single line top 영역 그리기
function top_line(context, x, i) {
	
	context.moveTo(x, 15);
	context.lineTo(x-5, 20);
	context.moveTo(x, 15);
	context.lineTo(x+5, 20);
	
	context.font = "12px malgun gothic";
	context.fillStyle = "black";
	context.fillText("TERMONORTE 44kV S/S",x-65,10);
	
	context.moveTo(x, 15);
	context.lineTo(x, 60);
	context.lineTo(x+26, 60);
	context.lineTo(x+26, 70);
	
	context.moveTo(x+19, 70);
	context.lineTo(x+33, 70);
	context.moveTo(x+21, 73);
	context.lineTo(x+31, 73);
	context.moveTo(x+23, 76);
	context.lineTo(x+29, 76);
	
	context.moveTo(x, 60);
	context.lineTo(x-10, 70);
	context.moveTo(x, 60);
	context.lineTo(x+10, 70);
	
	context.stroke();
	
	context.fillText("#" + i + " STEP UP TR",x-115,80);
	
	context.beginPath();
	context.arc(x, 60, 17, 0, Math.PI * 2);
	
	context.moveTo(x, 78);
	context.lineTo(x-10, 100);
	context.lineTo(x+10, 100);
	context.lineTo(x, 78);
	
	context.stroke();
	
	context.beginPath();
	context.arc(x, 87, 17, 0, Math.PI * 2);
	
	context.moveTo(x, 105);
	context.lineTo(x, 170);
	
	context.fillText("#" + i + " OUTGOING",x-115,180);
	context.fillText("VCB",x-85,195);
	
	
	context.moveTo(x, 200);
	context.lineTo(x, 250);
	
}

//single line 중간 영역 그리기_engine
function mid_line(context, x, i) {
	
	context.moveTo(x, 250);
	context.lineTo(x, 550);
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("#" + i + " GEN",x+25,300);
	context.fillText("VCB",x+30,315);
	
	context.moveTo(x, 350);
	context.lineTo(x+30, 350);
	context.lineTo(x+30, 410);
	
	context.moveTo(x+23, 410);
	context.lineTo(x+37, 410);
	context.moveTo(x+26, 413);
	context.lineTo(x+34, 413);
	context.moveTo(x+28, 416);
	context.lineTo(x+32, 416);
	
	context.stroke();
	
	context.beginPath();
	context.arc(x, 425, 17, 0, Math.PI * 2);
	/*context.fillStyle = "#FF0000";*/
	context.fillStyle = "white";
	context.fill();
	
	context.font = "14px malgun gothic"
	context.fillStyle = "black";
	context.fillText("G" + i,x-10,430);
	
	context.moveTo(x-10, 460);
	context.lineTo(x+10, 460);

	context.moveTo(x-10, 460);
	context.lineTo(x-10, 455);
	context.moveTo(x+10, 460);
	context.lineTo(x+10, 455);
	
	/*context.fillText("#" + i + " NGR",x+30,530);*/
	
	/*context.fillStyle = "#FFD700";*/
	context.fillStyle = "GREY";
	context.fillRect(x-7.5, 550, 15, 25);
	
	context.moveTo(x, 575);
	context.lineTo(x, 590);
	
	context.moveTo(x-7, 590);
	context.lineTo(x+7, 590);
	context.moveTo(x-4, 593);
	context.lineTo(x+4, 593);
	context.moveTo(x-2, 596);
	context.lineTo(x+2, 596);
	
}

//single line 중간 영역 그리기
function mid_line_common(context, x, i) {
	
	context.moveTo(x, 250);
	context.lineTo(x, 370);
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("#" + i + " AUX TR",x+25,300);
	context.fillText("VCB",x+30,315);
	
	
	context.lineTo(x-10, 392);
	context.lineTo(x+10, 392);
	context.lineTo(x, 370);
	context.stroke();
	
	context.beginPath();
	context.arc(x, 385, 17, 0, Math.PI * 2);
	
	context.moveTo(x-10, 407);
	context.lineTo(x, 417);
	context.lineTo(x+10, 407);
	context.stroke();
	context.fillText("#" + i + " AUX TR",x+30,400);
	context.beginPath();
	context.arc(x, 417, 17, 0, Math.PI * 2);
	
	context.moveTo(x, 417);
	context.lineTo(x+30, 417);
	context.lineTo(x+30, 427);
	
	context.moveTo(x+23, 427);
	context.lineTo(x+37, 427);
	context.moveTo(x+26, 430);
	context.lineTo(x+34, 430);
	context.moveTo(x+28, 433);
	context.lineTo(x+32, 433);
	
	
	context.moveTo(x, 417)
	context.lineTo(x, 650);		
	
	
	context.fillText("#" + i + " LV ACB",x+30,530);
	
	context.stroke();
}

function bottom_line(context, x, text) {
	context.moveTo(x, 650);
	context.lineTo(x, 750);
	
	context.font = "12px malgun gothic"
	context.fillText(text,x+20,680);
	context.fillText("ACB",x+20,695);
	
	context.stroke();
	
	context.beginPath();
	context.lineJoin = "round"; //사각형 모서리 모양
	context.strokeRect(x-80, 750, 150, 80);
}

//ElasticSearch 데이타 조회 - engine 
function elasticDataSearch(timeArea){
	try{
		var data = {"startTime":timeArea
				,"index":["engine01", "engine02", "engine03","engine04", "engine05", "engine06", "engine07","engine08", "engine09", "engine10"]
				,"field1":["DATE","EA0172","EA0173","EA0170"]};
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

//Engine Data 2(데이터 정렬)
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

////ElasticSearch 데이타 조회  - common
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
				/*alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");*/
				elasticDataSearch_EngineAlarm("no_data",eng_data,index);
				closeProgressBar();
			}else if(result == "error"){
				/*alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");*/
				elasticDataSearch_EngineAlarm("no_data",eng_data,index);
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				elasticDataSearch_EngineAlarm(result, eng_data, index);
				/*fn_Overall(result,eng_data);*/	
			}
		}
	});
}

function elasticDataSearch_EngineAlarm(com_data, eng_data, index) {
	var data = {"startTime":eng_data[index].DATE
			,"index":["engine01_st","engine02_st","engine03_st","engine04_st","engine05_st","engine06_st","engine07_st","engine08_st","engine09_st","engine10_st"]
			,"field1":["DATE","ED1031","ED1032","ED1035"]};
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
			,"field1":["DATE","CD0630","CD0635","CD0640","CD0645","CD0655","CD0660","CD0650","CD0665","CD0670","CD0675","CD0680","CD0685"]};
	$.ajax({
		url: "/web-elecStauts-common",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				/*alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");*/
				fn_Overall(com_data,eng_data,engine_alarm,"no_data");
				closeProgressBar();
			}else if(result == "error"){
				/*alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");*/
				fn_Overall(com_data,eng_data,engine_alarm,"no_data");
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				fn_Overall(com_data,eng_data,engine_alarm,result);	
			}
		}
	});
}

//ElasticSearch 데이타 조회  콜백
function fn_Overall(result, eng_data, eng_data_alarm, com_data_alarm){
	var com_data, com_data_al;
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
	/*var eng_data_len = eng_data.length;*/
	/*while (eng_data_len < 10) {
		eng_data[eng_data_len] = '{EA0172: 0, EA0173: 0, _index: "nodata", EA0170: 0}';
		eng_data_len++;
	}*/
	
	
	
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	
	if(com_data != "no_data") {
		context.clearRect(530, 60, 100, 50);
		kw_kvar(context,com_data.CA0009,com_data.CA0010,530,60,"common");
		
		context.clearRect(1502, 60, 100, 50);
		kw_kvar(context,com_data.CA0021,com_data.CA0022,1502,60,"common");
	} else {
		context.clearRect(530, 60, 100, 50);
		kw_kvar(context,0,0,530,60,"common");
		
		context.clearRect(1502, 60, 100, 50);
		kw_kvar(context,0,0,1502,60,"common");
	}
	///////

	var i = 0;
	var x = 40;
	while (i<5) {
		context.clearRect(x+20, 450, 100, 50);
		context.beginPath();
		
		//data 없을 경우
		if(eng_data[i].data_exist == "no_data") {
			kw_kvar(context,0,0,x+20,450,"engine");
		} else { //data 있을 경우
			kw_kvar(context,eng_data[i].EA0172,eng_data[i].EA0173,x+20,450,"engine");
		}
		
		x += 160;
		i++;
	}
	
	x = 980;
	while (i<10) {
		context.clearRect(x+20, 450, 100, 50);
		context.beginPath();
		
		//data 없을 경우
		if(eng_data[i].data_exist == "no_data") {
			kw_kvar(context,0,0,x+20,450,"engine");
		} else { //data 있을 경우
			kw_kvar(context,eng_data[i].EA0172,eng_data[i].EA0173,x+20,450,"engine");
		}
		
		x += 160;
		i++;
	}
	
	if(com_data != "no_data") {
		context.clearRect(860, 450, 100, 50);
		//common data이지만 table 폭 때문에 engine으로 사용.
		kw_kvar(context,com_data.CA0033,com_data.CA0034,860,450,"engine");
		context.clearRect(1800, 450, 100, 50);
		kw_kvar(context,com_data.CA0043,com_data.CA0044,1800,450,"engine");
	} else {
		context.clearRect(860, 450, 100, 50);
		//common data이지만 table 폭 때문에 engine으로 사용.
		kw_kvar(context,0,0,860,450,"engine");
		context.clearRect(1800, 450, 100, 50);
		kw_kvar(context,0,0,1800,450,"engine");
	}
	
	vcb_switch(com_data_al, eng_data_al, context);
	
	context.stroke();
	//progressbar 종료
	closeProgressBar();
}
function vcb_switch(common_data, engine_data_alarm, context) {
	//Top Line OUTGOING VCB
	if(common_data.CD0630) {
		switch_img(context, 456, 170, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 456, 170, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	if(common_data.CD0635) {
		switch_img(context, 1428, 170, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 1428, 170, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//Mid Line GEN VCB
	var i = 0;
	var x = 40;
	while (i<5) {
		if(engine_data_alarm[i].ED1031) {
			switch_img(context, x-19, 290, "/image/singleline/CB_OPEN_W_SERO.gif");
		} else {
			switch_img(context, x-19, 290, "/image/singleline/CB_CLOSE_W_SERO.gif");
		}
		x += 160;
		i++;
	}
	
	x = 980;
	while (i<10) {
		if(engine_data_alarm[i].ED1031) {
			switch_img(context, x-19, 290, "/image/singleline/CB_OPEN_W_SERO.gif");
		} else {
			switch_img(context, x-19, 290, "/image/singleline/CB_CLOSE_W_SERO.gif");
		}
		
		x += 160;
		i++;
	}
	
	//Mid Line AUX TR VCB
	if(common_data.CD0640) {
		switch_img(context, 821, 290, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 821, 290, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	if(common_data.CD0645) {
		switch_img(context, 1761, 290, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 1761, 290, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//Mid Line LV ACB
	if(common_data.CD0655) {
		switch_img(context, 821, 510, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 821, 510, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	if(common_data.CD0660) {
		switch_img(context, 1761, 510, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 1761, 510, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	

	//TIE ACB
	if(common_data.CD0650) {
		switch_img(context, 900, 635, "/image/singleline/CB_OPEN_W.gif");
	} else {
		switch_img(context, 900, 635, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//Bottom Line MCC ACB
	if(common_data.CD0665) {
		switch_img(context, 161, 670, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 161, 670, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	if(common_data.CD0675) {
		switch_img(context, 501, 670, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 501, 670, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	if(common_data.CD0670) {
		switch_img(context, 1181, 670, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 1181, 670, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	if(common_data.CD0680) {
		switch_img(context, 1521, 670, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 1521, 670, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//Bottom Line BSDG ACB
	if(common_data.CD0685) {
		switch_img(context, 811, 670, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 811, 670, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
}

//kw, kvar 데이터 테이블 그리기(svg)
function kw_kvar(context, kw, kvar, x, y, key) {
	var data = new Array();
	var c = 0;
	while (c < 2) {
		data[c] = new Array();
		c++;
	}
	data[0][0] = kw; data[0][1] = "KW"; data[0][2] = "kW";
	data[1][0] = kvar; data[1][1] = "KVAR"; data[1][2] = "kVar";
	
	context.clearRect(x, y, 100, 50);
	context.beginPath();

	var sw = 0;
	var x_init=x;
	var x_w = 40;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 2) {
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
				context.fillText(data[i][0],x+5,y+16);
				if(key == "engine") {
					context.fillText(data[i][2],x+33,y+16);
					x += 60
				} else {
					context.fillText(data[i][2],x+45,y+16);
					x += 75
				}
				x_w = 40;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "11px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+5,y+16);
				if(key == "engine") {
					x_w = 60;
				} else {
					x_w = 75;	
				}
				x += 40;
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
