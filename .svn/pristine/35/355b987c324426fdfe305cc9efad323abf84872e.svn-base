$(document).ready(function(){
	//progressbar 시작
	showProgressBar();
	//한국시간 표시, 반복실행 실행시키기
	play_repeat();
});

window.onload = function () {
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	
	context.beginPath();
	context.lineJoin = "round"; //사각형 모서리 모양
	//#1 HAM3 영역(사각형)
	context.strokeRect(80, 50, 620, 150);
	context.strokeRect(1200, 50, 620, 150);
	context.strokeRect(130, 300, 1600, 600);

	left_line(context, 740);
	context.stroke();
	
	context.beginPath();	
	context.moveTo(490, 47);
	context.lineTo(485, 37);
	context.lineTo(495, 37);
	context.moveTo(490, 47);
	context.fillStyle="black";
	context.fill();
	context.closePath();

	context.moveTo(490, 37);
	context.lineTo(490, 30);
	context.lineTo(50, 30);
	context.lineTo(50, 950);
	context.lineTo(800, 950);
	context.lineTo(800, 820);
	
	context.moveTo(730, 810);
	context.lineTo(730, 820);
	context.lineTo(870, 820);
	context.lineTo(870, 810);
	
	right_line(context, 1160);
	
	bottom_line(context, 880);
	
	engine_img(context, 750, 20, "/image/singleline/Engine.gif");
	tank_img(context, 470, 80, "/image/singleline/T-106-01.gif");
	tank_img(context, 1320, 80, "/image/singleline/T-106-01.gif");
	pump_img(context, 1500, 115, "/image/singleline/P-107-01.gif");
	pump_img(context, 340, 115, "/image/singleline/P-107-01.gif");
	pump_img(context, 650, 335, "/image/singleline/P-107-01.gif");
	pump_img(context, 1055, 565, "/image/singleline/P-107-01.gif");
	pump_img(context, 1055, 685, "/image/singleline/P-107-01.gif");
	
	vent_tank_img(context, 1270, 560, "/image/singleline/V-101-01.gif");
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("HFO SETTLING TANK",120,165);
	context.fillText("DO PILOT TANK",1665,165);
	context.fillText("#1 ENGINE",385,385);
	context.fillText("#1 CW RADIATOR",755,385);
	context.fillText("DO STORAGE TANK",315,485);
	context.fillText("HFO SERVICE TANK",1765,455);
	context.fillText("HFO SUPPLY PUMP",1775,605);
	context.fillText("DO SUPPLY PUMP",1775,655);
	context.fillText("M-111-01",150,65);
	context.fillText("#1 FO DRAIN TANK & PUMP UNIT",85,80);
	context.fillText("M-111-01",1650,65);
	context.fillText("#1 DO PILOT COLLECTING TANK & PUMP UNIT",1550,80);
	context.fillText("P-107-01",340,180);
	context.fillText("P-108-01",1500,180);
	context.fillText("P-303-01",650,400);
	context.fillText("CW CIRCULATION",623,420);
	context.fillText("PUMP",657,435);
	context.fillText("P-109A-01",1050,630);
	context.fillText("P-109B-01",1050,750);
	context.fillText("BOOSTER PUMP",1035,770);
	context.fillText("#1 HAM3",640,215);
	context.fillText("#1 HAM3",1760,215);
	context.fillText("#1 HAM3",1670,915);
	context.fillText("T-106-01",495,185);
	context.fillText("T-107-01",1350,185);
	context.fillText("#1 ENGINE",1100,200);
	context.fillText("BOOSTER OUTLET",190,495);
	context.fillText("TO ENGINE",205,510);
	context.fillText("AUTO FILTER",365,575);
	context.fillText("F-106-01",375,710);
	context.fillText("E-103-01",570,520);
	context.fillText("M-101-01",607,710);
	context.fillText("VISCOSITY CONTROL",577,730);
	context.fillText("VALVE",615,745);
	context.fillText("E-102-01",776,635);
	context.fillText("BOOSTER INLET",900,400);
	context.fillText("FROM ENGINE",903,415);
	/*context.fillText("VENTING&SERVICE",1245,400);
	context.fillText("TANK",1280,415);*/
	context.fillText("V-101-01",1345,560);
	context.fillText("F O",1360,575);
	context.fillText("VENT TANK",1340,590);
	/*context.fillText("BOOSTER INLET",1545,560);
	context.fillText("FOR SUPPLY PUMP",1535,575);*/
	context.fillText("M-103-01",1635,875);
	context.fillText("#1 FO BOOSTER UNIT",1600,890);
	context.font = "16px malgun gothic"
	context.fillText("M",393,618);
	
	context.stroke();
	
}

function left_line(context, x) {
	context.moveTo(x-43, 115);
	context.lineTo(x-43, 125);
	context.moveTo(x-37, 115);
	context.lineTo(x-37, 125);
	
	context.moveTo(x, 120);
	context.lineTo(x-250, 120);
	context.lineTo(x-250, 160);
	
	//화살표
	context.lineTo(x-500, 160);
	context.lineTo(x-500, 170);
	context.lineTo(x-630, 170);
	context.lineTo(x-640, 160);
	context.lineTo(x-630, 150);
	context.lineTo(x-500, 150);
	context.lineTo(x-500, 160);
	
	context.moveTo(x-250, 120);
	context.lineTo(x-250, 53);
	context.moveTo(x-245, 53);
	context.lineTo(x-255, 53);
	context.moveTo(x-255, 47);
	context.lineTo(x-245, 47);
}

function right_line(context, x) {
	context.moveTo(x+43, 115);
	context.lineTo(x+43, 125);
	context.moveTo(x+37, 115);
	context.lineTo(x+37, 125);
	
	context.moveTo(x, 120);
	context.lineTo(x+250, 120);
	context.lineTo(x+250, 160);
	
	//화살표
	context.lineTo(x+500, 160);
	context.lineTo(x+500, 170);
	context.lineTo(x+600, 170);
	context.lineTo(x+610, 160);
	context.lineTo(x+600, 150);
	context.lineTo(x+500, 150);
	context.lineTo(x+500, 160);
	
}

function bottom_line(context, x) {
	context.moveTo(x, 155);
	context.lineTo(x, 287);
	context.stroke();
	context.beginPath();	
	context.moveTo(x, 287);
	context.lineTo(x-5, 287);
	context.lineTo(x, 297);
	context.lineTo(x+5, 287);
	context.lineTo(x, 287);
	context.fillStyle="black";
	context.fill();
	context.closePath();

	context.moveTo(x, 297);
	context.lineTo(x-5, 297);
	context.lineTo(x+5, 297);
	context.moveTo(x, 303);
	context.lineTo(x-5, 303);
	context.lineTo(x+5, 303);

	context.moveTo(x, 303);
	context.lineTo(x, 450);
	context.lineTo(x+40, 450);
	context.stroke();

	context.beginPath();
	context.fillStyle="grey";
	context.stroke();
	
	context.moveTo(x+70, 450);
	
	/*context.lineTo(x+400, 450);*/
	//venting 임시 제거
	context.lineTo(x+430, 450);
	context.moveTo(x+415, 450);
	context.lineTo(x+415, 465);
	context.stroke();
	
	context.beginPath();
	context.fillStyle="grey";
	context.stroke();
	/*
	context.beginPath();
	context.lineTo(x+400, 440);
	context.lineTo(x+415, 450);
	context.lineTo(x+400, 460);
	context.lineTo(x+400, 440);
	context.fill();
	context.stroke();
	
	context.beginPath();
	context.moveTo(x+415, 450);
	context.lineTo(x+430, 460);
	context.lineTo(x+430, 440);
	context.lineTo(x+415, 450);
	context.fill();*/
	context.fill();
	
	context.moveTo(x+430, 450);
	context.lineTo(x+880, 450);
	
	context.moveTo(x+847, 445);
	context.lineTo(x+847, 455);
	context.moveTo(x+853, 445);
	context.lineTo(x+853, 455);
	
	//HFO SERVICE TANK 화살표
	context.moveTo(x+880, 450);
	context.lineTo(x+880, 440);
	context.lineTo(x+1000, 440);
	context.lineTo(x+1010, 450);
	context.lineTo(x+1000, 460);
	context.lineTo(x+880, 460);
	context.lineTo(x+880, 450);
	context.stroke();
	
	context.beginPath();
	context.fillStyle="grey";
	context.stroke();
	
	context.moveTo(x+55, 465);
	context.lineTo(x+55, 480);
	context.lineTo(x-450, 480);
	context.stroke();
	
	context.beginPath();
	context.moveTo(x-150, 475);
	context.lineTo(x-150, 485);
	context.lineTo(x-160, 480);
	context.lineTo(x-150, 475);
	context.fillStyle="black";
	context.fill();
	
	context.beginPath();
	context.fillStyle = "white";
	context.rect(x-310, 455, 50, 50);
	context.strokeStyle = "black"; //사각형 선 색
	context.lineJoin = "miter"; //사각형 모서리 모양
	context.fill();
	
	// DO STORAGE TANK 화살표
	context.moveTo(x-450, 480);
	context.lineTo(x-450, 470);
	context.lineTo(x-570, 470);
	context.lineTo(x-580, 480);
	context.lineTo(x-570, 490);
	context.lineTo(x-450, 490);
	context.lineTo(x-450, 480);
	
	// #1 ENGINE 화살표
	context.moveTo(x-285, 480);
	context.lineTo(x-300, 495);
	context.lineTo(x-300, 380);
	context.lineTo(x-400, 380);
	context.lineTo(x-400, 370);
	context.lineTo(x-500, 370);
	context.lineTo(x-510, 380);
	context.lineTo(x-500, 390);
	context.lineTo(x-400, 390);
	context.lineTo(x-400, 380);
	
	// #1 CW RADIATOR 화살표
	context.moveTo(x-285, 480);
	context.lineTo(x-270, 495);
	context.lineTo(x-270, 380);
	context.lineTo(x-140, 380);
	context.lineTo(x-130, 390);
	context.lineTo(x-10, 390);
	context.lineTo(x-10, 370);
	context.lineTo(x-130, 370);
	context.lineTo(x-140, 380);
	context.stroke();
	
/*
	context.beginPath();
	context.moveTo(x+415, 450);
	context.lineTo(x+425, 465);
	context.lineTo(x+405, 465);
	context.lineTo(x+415, 450);
	context.fillStyle = "grey";
	context.fill();
*/	
	context.beginPath();
	context.fillStyle = "grey";
	context.fill();
	
	context.moveTo(x+415, 465);
	context.lineTo(x+415, 600);
	/*context.lineTo(x+690, 600);*/
	//BOOSTER INLET FOR SUPPLY PUMP 임시 제거
	context.lineTo(x+720, 600);
	context.moveTo(x+705, 600);
	context.lineTo(x+705, 615);
	context.stroke();
	
	/*context.beginPath();	
	context.moveTo(x+690, 600);
	context.lineTo(x+690, 590);
	context.lineTo(x+705, 600);
	context.lineTo(x+690, 610);
	context.lineTo(x+690, 600);
	
	context.moveTo(x+705, 600);
	context.lineTo(x+720, 610);
	context.lineTo(x+720, 590);
	context.lineTo(x+705, 600);
	
	context.moveTo(x+705, 600);
	context.lineTo(x+695, 615);
	context.lineTo(x+715, 615);
	context.lineTo(x+705, 600);
	
	context.fill();
	context.stroke();
	*/
	context.beginPath();
	context.fillStyle = "grey";
	context.fill();
	
	// HFO SUPPLY PUMP 화살표
	context.moveTo(x+720, 600);
	context.lineTo(x+880, 600);
	context.lineTo(x+890, 610);
	context.lineTo(x+1010, 610);
	context.lineTo(x+1010, 590);
	context.lineTo(x+890, 590);
	context.lineTo(x+880, 600);
	
	context.moveTo(x+847, 595);
	context.lineTo(x+847, 605);
	context.moveTo(x+853, 595);
	context.lineTo(x+853, 605);
	
	context.moveTo(x+705, 615);
	context.lineTo(x+705, 860);
	context.lineTo(x-650, 860);
	context.lineTo(x-650, 570);
	context.stroke();
	
	/*context.beginPath();
	context.moveTo(x-650, 570);
	context.lineTo(x-640, 570);
	context.lineTo(x-650, 555);
	context.lineTo(x-660, 570);
	context.lineTo(x-650, 570);

	context.moveTo(x-650, 555);
	context.lineTo(x-635, 565);
	context.lineTo(x-635, 545);
	context.lineTo(x-650, 555);
	
	context.moveTo(x-650, 555);
	context.lineTo(x-665, 565);
	context.lineTo(x-665, 545);
	context.lineTo(x-650, 555);
	
	context.fill();
	context.stroke();*/
	context.beginPath();
	context.fillStyle = "grey";
	context.fill();
	
	context.moveTo(x-665, 555);
	context.lineTo(x-700, 555);
	context.lineTo(x-700, 250);
	context.lineTo(x-80, 250);
	context.lineTo(x-80, 155);
	
	context.moveTo(x-635, 555);
	context.lineTo(x-600, 555);
	context.lineTo(x-600, 670);
	context.lineTo(x-530, 670);
	context.lineTo(x-530, 730);
	context.lineTo(x-525, 730);
	
	context.moveTo(x-438, 730);
	context.lineTo(x-433, 730);
	context.lineTo(x-433, 670);
	context.lineTo(x+100, 670);
	
	context.stroke();
	
	context.strokeRect(x-540, 580, 120, 170);
	context.beginPath();
	drawEllipse(context, x-523, 715, 85, 30);

	context.beginPath();
	context.fillStyle = "Grey";
	context.rect(x-500, 716, 40, 28);
	context.strokeStyle = "black"; //사각형 선 색
	/*context.lineJoin = "miter"; //사각형 모서리 모양
*/	context.fill();

	context.rect(x-515, 650, 70, 45);
	context.rect(x-505, 630, 50, 20);
	context.rect(x-500, 595, 40, 35);
	context.stroke();
	context.beginPath();
	context.rect(x-280, 650, 70, 45);
	context.rect(x-270, 630, 50, 20);
	context.rect(x-115, 650, 70, 50);
	context.fillStyle = "white";
	context.fill();
	
	context.moveTo(x-100, 640);
	context.lineTo(x-100, 690);
	context.lineTo(x-80, 670);
	context.lineTo(x-60, 690);
	context.lineTo(x-60, 640);
	
	context.moveTo(x-100, 700);
	context.lineTo(x-100, 810);
	context.moveTo(x-60, 700);
	context.lineTo(x-60, 810);
	context.stroke();
	
	context.beginPath();	
	context.moveTo(x-135, 810);
	context.lineTo(x-125, 810);
	context.lineTo(x-130, 820);
	context.lineTo(x-135, 810);
	context.lineTo(x-130, 810);
	context.moveTo(x-100, 810);
	context.lineTo(x-95, 810);
	context.lineTo(x-100, 820);
	context.lineTo(x-105, 810);
	context.lineTo(x-100, 810);
	context.moveTo(x-65, 810);
	context.lineTo(x-55, 810);
	context.lineTo(x-60, 820);
	context.lineTo(x-65, 810);
	context.lineTo(x-60, 810);
	context.moveTo(x-30, 810);
	context.lineTo(x-20, 810);
	context.lineTo(x-25, 820);
	context.lineTo(x-30, 810);
	context.lineTo(x-25, 810);
	
	context.fillStyle="black";
	context.fill();
	context.closePath();
	
	context.moveTo(x+100, 670);
	context.lineTo(x+100, 610);
	context.lineTo(x+300, 610);
	context.lineTo(x+300, 730);
	context.lineTo(x+100, 730);
	context.lineTo(x+100, 670);
	
	context.moveTo(x+300, 670);
	context.lineTo(x+410, 670);
	
	context.moveTo(x+420, 700);
	context.lineTo(x+420, 780);
	context.lineTo(x-470, 780);
	context.lineTo(x-470, 745);
	
	context.moveTo(x-485, 745);
	context.lineTo(x-485, 800);
	context.lineTo(x-130, 800);
	context.lineTo(x-130, 810);
	
	context.moveTo(x+440, 700);
	context.lineTo(x+440, 800);
	context.lineTo(x-25, 800);
	context.lineTo(x-25, 810);
	
	//DO SUPPLY PUMP 화살표
	context.moveTo(x+705, 650);
	context.lineTo(x+880, 650);
	context.lineTo(x+890, 660);
	context.lineTo(x+1010, 660);
	context.lineTo(x+1010, 640);
	context.lineTo(x+890, 640);
	context.lineTo(x+880, 650);
	
	context.moveTo(x+847, 645);
	context.lineTo(x+847, 655);
	context.moveTo(x+853, 645);
	context.lineTo(x+853, 655);
	/*
	context.beginPath();
	context.fillStyle = "white";
	context.rect(532, 100, 40, 15);
	context.rect(532, 154, 40, 15);
	context.rect(1382, 100, 40, 15);
	context.rect(1382, 154, 40, 15);
	context.strokeStyle = "black"; //사각형 선 색
	context.lineJoin = "miter"; //사각형 모서리 모양
	context.fill();
	context.stroke();*/
}

function drawEllipse(ctx, x, y, w, h) {
	var kappa = .5522848;
	ox = (w / 2) * kappa, // control point offset horizontal
	oy = (h / 2) * kappa, // control point offset vertical
	xe = x + w,           // x-end
	ye = y + h,           // y-end
	xm = x + w / 2,       // x-middle
	ym = y + h / 2;       // y-middle

	  ctx.beginPath();
	  ctx.moveTo(x, ym);
	  ctx.bezierCurveTo(x, ym - oy, xm - ox, y, xm, y);
	  ctx.bezierCurveTo(xm + ox, y, xe, ym - oy, xe, ym);
	  ctx.bezierCurveTo(xe, ym + oy, xm + ox, ye, xm, ye);
	  ctx.bezierCurveTo(xm - ox, ye, x, ym + oy, x, ym);
	  ctx.closePath();
	  ctx.stroke();
	}


//single line engine img 그리기
function engine_img(context, x, y, src) {
	var img_src = new Image();
	img_src.src = src
	img_src.onload = function(e) {
		context.drawImage(img_src, x+3, y, 400, 130);
	}
}

function tank_img(context, x, y, src) {
	var img_src = new Image();
	img_src.src = src
	img_src.onload = function(e) {
		context.drawImage(img_src, x+3, y, 100, 90);
	}
}

function pump_img(context, x, y, src) {
	var img_src = new Image();
	img_src.src = src
	img_src.onload = function(e) {
		context.drawImage(img_src, x+3, y, 50, 50);
	}
}

function vent_tank_img(context, x, y, src) {
	var img_src = new Image();
	img_src.src = src
	img_src.onload = function(e) {
		context.drawImage(img_src, x+3, y, 60, 150);
	}
}

//ElasticSearch Data 조회
function elasticDataSearch(timeArea){
	var index = $("#hidCurrentMenu").val().split('_')[1];
	var data = {"startTime":timeArea
			,"index":[index]
			/*,"field01":["DATE","EA0108","EA0109","EA0180","EA0182","ED0941","ED0956","ED1024","ED0081","ED0080","ED0082","ED0975","ED0077","ED0078","ED0994",
			"ED0083","ED0865","ED0866","ED0881","ED0094","ED0095","ED0760","ED0761","EA0181","EA0179","ED1060","ED1061","ED1062","ED1064","ED1035","EA0174",
			"EA0195","EA0196"]*/};
	$.ajax({
		url: "/web-engineStatus",
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
				elasticDataSearch_EngineAlarm(result);	
			}
		}
	})
}

function elasticDataSearch_EngineAlarm(eng_data) {
	var index_al = $("#hidCurrentMenu").val().split('_')[1] + "_al";
	var index_sd = $("#hidCurrentMenu").val().split('_')[1] + "_sd";
	var index_tr = $("#hidCurrentMenu").val().split('_')[1] + "_tr";
	var index_st = $("#hidCurrentMenu").val().split('_')[1] + "_st";
	var json_date = JSON.parse(eng_data);
	var data = {"startTime":json_date.source.DATE
			,"index":[index_sd, index_tr, index_al, index_st]};
	$.ajax({
		url: "/web-engineStatusAlarm",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				/*alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");*/
				fn_EngineDiagram(eng_data,"no_data");
				closeProgressBar();
			}else if(result == "error"){
				/*alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");*/
				fn_EngineDiagram(eng_data,"no_data");
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				fn_EngineDiagram(eng_data,result);	
			}
		}
	});
}

//ElasticSearch Data 조회 콜백
function fn_EngineDiagram(searchData, eng_data_alarm){
	var eng_data = JSON.parse(searchData);
	
	var eng_data_al = JSON.parse(eng_data_alarm);
	var eng_data_sd = eng_data_al[0];
	var eng_data_tr = eng_data_al[1];
	var eng_data_st = eng_data_al[3];
	eng_data_al = eng_data_al[2];
	
	/*if(eng_data_st.data_exist == "no_data") {
		eng_data_st = JSON.parse({"ED0941":"FALSE"})
	}*/
	//시간정보 SearchBox영역에 뿌려주기
	displayDate(eng_data.source.DATE);
	
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	
	MAIN_FO_PRESS_TEMP(context, eng_data.source, 720, 160);
	BOOSTER_OUTLET_PRESS_TEMP(context, eng_data.source, 200, 400);
	DO_RETURN_TEMPERATURE(context, eng_data.source, 490, 430);
	BOOSTER_INLET_TEMP(context, eng_data.source, 1450, 550);
	ENGINE_DATA(context, eng_data.source, eng_data_st, 900, 160);
	VISCOSITY_CONTROL_VALVE(context, eng_data.source, 570, 580);
	/*{key: value}*/
	
	
	//P-107-01
	RUN_STATUS(context, eng_data_st.ED0941, eng_data_al.ED0081, 335, 90);
	//P-108-01
	RUN_STATUS(context, eng_data_st.ED0956, eng_data_al.ED0082, 1495, 90);
	//P-303-01
	RUN_STATUS(context, eng_data_st.ED1024, eng_data_al.ED0080, 645, 310);
	//P-109A-01
	RUN_STATUS(context, eng_data_st.ED0975, eng_data_al.ED0077, 1050, 540);
	//P-109B-01
	RUN_STATUS(context, eng_data_st.ED0994, eng_data_al.ED0078, 1050, 660);
	//F-106-01
	RUN_STATUS(context, eng_data_st.ED0866, eng_data_al.ED0083, 370, 657);
	//M-101-01
	VALVE_ONOFF(context, eng_data_st.ED0881, 605, 657);
	//T-106-01
	TANK_HIGH_LOW(context, eng_data_al.ED0094, eng_data_al.ED0095, 526, 152);
	//T-107-01
	TANK_HIGH_LOW(context, eng_data_al.ED0094, eng_data_al.ED0095, 1376, 152);
	//BOSTER INLET VALVE
	SET_VALVE(context, eng_data_st.ED0760, eng_data_st.ED0761, 880, 0);
	//VENTING&SERVICE TANK
	/*SET_VALVE(context, false, false, 1240, 0);*/
	//BOSTER OUTLET VALVE
	SET_VALVE(context, eng_data_st.ED0775, eng_data_st.ED0776, 175, 105);
	//BOOSTER INLET FOR SUPPLY PUMP
	/*SET_VALVE(context, eng_data.source.ED0775, eng_data.source.ED0776, 1530, 150);*/
	
	//progressbar 종료
	closeProgressBar();
}

function SET_VALVE(context, hfo_valve, do_valve, x, y) {
	if(hfo_valve) {
		context.beginPath();	
		context.moveTo(x+40, y+450);
		context.lineTo(x+40, y+440);
		context.lineTo(x+55, y+450);
		context.lineTo(x+40, y+460);
		context.lineTo(x+40, y+450);
		context.fillStyle="grey";
		context.fill();
		context.stroke();
		
		context.beginPath();
		context.moveTo(x+55, y+450);
		context.lineTo(x+70, y+460);
		context.lineTo(x+70, y+440);
		context.lineTo(x+55, y+450);
		context.fill();
		context.stroke();
		
		context.beginPath();
		context.moveTo(x+55, y+450);
		context.lineTo(x+45, y+465);
		context.lineTo(x+65, y+465);
		context.lineTo(x+55, y+450);
		context.stroke();
	} 
	if(do_valve) {
		context.beginPath();	
		context.moveTo(x+40, y+450);
		context.lineTo(x+40, y+440);
		context.lineTo(x+55, y+450);
		context.lineTo(x+40, y+460);
		context.lineTo(x+40, y+450);
		context.fillStyle="grey";
		context.fill();
		context.stroke();
		
		context.beginPath();
		context.moveTo(x+55, y+450);
		context.lineTo(x+70, y+460);
		context.lineTo(x+70, y+440);
		context.lineTo(x+55, y+450);
		context.stroke();
		
		context.beginPath();
		context.moveTo(x+55, y+450);
		context.lineTo(x+45, y+465);
		context.lineTo(x+65, y+465);
		context.lineTo(x+55, y+450);
		context.fill();
		context.stroke();
	} 
	if(!hfo_valve && !do_valve)
	{
		context.beginPath();	
		context.moveTo(x+40, y+450);
		context.lineTo(x+40, y+440);
		context.lineTo(x+55, y+450);
		context.lineTo(x+40, y+460);
		context.lineTo(x+40, y+450);
		context.stroke();
		
		context.beginPath();
		context.moveTo(x+55, y+450);
		context.lineTo(x+70, y+460);
		context.lineTo(x+70, y+440);
		context.lineTo(x+55, y+450);
		context.stroke();
		
		context.beginPath();
		context.moveTo(x+55, y+450);
		context.lineTo(x+45, y+465);
		context.lineTo(x+65, y+465);
		context.lineTo(x+55, y+450);
		context.stroke();
	}
}
function TANK_HIGH_LOW(context, high_data, low_data, x, y) {
	context.clearRect(x+10,y+5,32,10);
	context.clearRect(x+10,y-50,32,10);

	if(high_data) {
		context.fillText("H",x+25,y-41);
	} else if(low_data) {
		context.fillText("L",x+25,y+15);
	}
}
function VALVE_ONOFF(context, data, x, y) {
	context.beginPath();
	context.rect(x, y, 60, 20);
	context.strokeStyle = "black"; //사각형 선 색
	context.lineWidth = 1.5; //사각형 선 두께
	context.lineJoin = "miter"; //사각형 모서리 모양
	context.fillStyle = "white";
	/*context.fillStyle = "#32CD32";*/ //사각형 안의 채울 색
	context.fill(); //색 채우기
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	if(data) {
		context.fillText("ON",x+20,y+15);
	} else {
		context.fillText("OFF",x+18,y+15);
	}

	context.stroke();
}

function RUN_STATUS(context, data, fault_signal, x, y) {
	context.beginPath();
	context.rect(x, y, 60, 20);
		context.strokeStyle = "black"; //사각형 선 색
		context.lineWidth = 1.5; //사각형 선 두께
		context.lineJoin = "miter"; //사각형 모서리 모양
		context.fillStyle = "white";
		/*context.fillStyle = "#32CD32";*/ //사각형 안의 채울 색
		context.fill(); //색 채우기
		
		context.font = "12px malgun gothic"
		context.fillStyle = "black";
		if(fault_signal) {
			context.fillText("FAULT",x+12,y+15);
		} else {
			if(data) {
				context.fillText("RUN",x+18,y+15);
			} else {
				context.fillText("STOP",x+16,y+15);
			}
		}
		context.stroke();
}

function MAIN_FO_PRESS_TEMP(context, json, x, y) {
	
	var data = new Array();
	var c = 0;
	while (c < 2) {
		data[c] = new Array();
		c++;
	}
	data[0][0] = json.EA0109; data[0][1] = "TE52"; data[0][2] = "℃";
	data[1][0] = json.EA0108; data[1][1] = "PT52"; data[1][2] = "bar";
	
	context.clearRect(x, y, 75, 85);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 70;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 4) {
		while (x_i < 1) {
			context.beginPath();
			context.rect(x, y, x_w, 20);
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
				context.fillText(data[i][0],x+25,y+15);
				context.fillText(data[i][2],x+50,y+15);
				x += 70
				x_w = 70;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+23,y+15);
				x += 70;
				x_w = 70;
				sw = 1;
			}
			x_i++;
			
		}
		x_i = 0;
		x = x_init;
		y += 20;
		y_i++;
	}
}

function BOOSTER_OUTLET_PRESS_TEMP(context, json, x, y) {
	
	var data = new Array();
	var c = 0;
	while (c < 2) {
		data[c] = new Array();
		c++;
	}
	data[0][0] = json.EA0180; data[0][1] = "TI-103-01"; data[0][2] = "℃";
	data[1][0] = json.EA0182; data[1][1] = "PI-103-01"; data[1][2] = "bar";
	
	context.clearRect(x, y, 75, 85);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 70;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 4) {
		while (x_i < 1) {
			context.beginPath();
			context.rect(x, y, x_w, 20);
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
				context.fillText(data[i][0],x+25,y+15);
				context.fillText(data[i][2],x+50,y+15);
				x += 70
				x_w = 70;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+10,y+15);
				x += 70;
				x_w = 70;
				sw = 1;
			}
			x_i++;
			
		}
		x_i = 0;
		x = x_init;
		y += 20;
		y_i++;
	}
}

function DO_RETURN_TEMPERATURE(context, json, x, y) {
	var data = new Array();
	var c = 0;
	while (c < 2) {
		data[c] = new Array();
		c++;
	}
	data[0][0] = json.EA0181; data[0][1] = "TI-102-01"; data[0][2] = "℃";
	context.clearRect(x, y, 75, 35);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 70;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 2) {
		while (x_i < 1) {
			context.beginPath();
			context.rect(x, y, x_w, 20);
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
				context.fillText(data[i][0],x+25,y+15);
				context.fillText(data[i][2],x+50,y+15);
				x += 70
				x_w = 70;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+10,y+15);
				x += 70;
				x_w = 70;
				sw = 1;
			}
			x_i++;
			
		}
		x_i = 0;
		x = x_init;
		y += 20;
		y_i++;
	}
}

function BOOSTER_INLET_TEMP(context, json, x, y) {
	var data = new Array();
	var c = 0;
	while (c < 2) {
		data[c] = new Array();
		c++;
	}
	data[0][0] = json.EA0179; data[0][1] = "TI-101-01"; data[0][2] = "℃";
	context.clearRect(x, y, 75, 35);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 70;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 2) {
		while (x_i < 1) {
			context.beginPath();
			context.rect(x, y, x_w, 20);
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
				context.fillText(data[i][0],x+25,y+15);
				context.fillText(data[i][2],x+50,y+15);
				x += 70
				x_w = 70;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+10,y+15);
				x += 70;
				x_w = 70;
				sw = 1;
			}
			x_i++;
			
		}
		x_i = 0;
		x = x_init;
		y += 20;
		y_i++;
	}
}

function VISCOSITY_CONTROL_VALVE(context, json, x, y) {
	var data = new Array();
	var c = 0;
	while (c < 2) {
		data[c] = new Array();
		c++;
	}
	data[0][0] = json.EA0195; data[0][1] = "TI-110-01"; data[0][2] = "℃";
	data[1][0] = json.EA0196; data[1][1] = "AI-110-01"; data[1][2] = "Cst";
	context.clearRect(x, y, 75, 35);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 70;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 2) {
		while (x_i < 2) {
			context.beginPath();
			context.rect(x, y, x_w, 20);
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
				context.fillText(data[i][0],x+25,y+15);
				context.fillText(data[i][2],x+50,y+15);
				x += 70
				x_w = 70;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+10,y+15);
				x += 70;
				x_w = 70;
				sw = 1;
			}
			x_i++;
			
		}
		x_i = 0;
		x = x_init;
		y += 20;
		y_i++;
	}
}

function ENGINE_DATA(context, json, json_st, x, y) {
	var data = new Array();
	var c = 0;
	while (c < 3) {
		data[c] = new Array();
		c++;
	}
	
	if(json_st != undefined) {
		if (json_st.ED1060) {
			data[0][0] = "DO"; data[0][1] = "MODE"; data[0][2] = "";
		}
		if (json_st.ED1061) {
			data[0][0] = "HFO"; data[0][1] = "MODE"; data[0][2] = "";
		}
		if (json_st.ED1062) {
			data[0][0] = "GAS"; data[0][1] = "MODE"; data[0][2] = "";
		} 
		if(!json_st.ED1060 && !json_st.ED1061 && !json_st.ED1062) {
			data[0][0] = ""; data[0][1] = "STAT"; data[0][2] = "";
		}
		
		if (json_st.ED1035) {
			data[1][0] = "RUN"; data[1][1] = "STAT"; data[1][2] = "";
		}
		else {
			data[1][0] = "STOP"; data[1][1] = "STAT"; data[1][2] = "";
		}
	}
	
	data[2][0] = json.EA0174; data[2][1] = "LOAD"; data[2][2] = "kW";

	context.clearRect(x, y, 75, 35);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 70;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 3) {
		while (x_i < 2) {
			context.beginPath();
			context.rect(x, y, x_w, 20);
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
				context.fillText(data[i][0],x+15,y+15);
				context.fillText(data[i][2],x+50,y+15);
				x += 70
				x_w = 70;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "12px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+10,y+15);
				x += 70;
				x_w = 70;
				sw = 1;
			}
			x_i++;
			
		}
		x_i = 0;
		x = x_init;
		y += 20;
		y_i++;
	}
}
