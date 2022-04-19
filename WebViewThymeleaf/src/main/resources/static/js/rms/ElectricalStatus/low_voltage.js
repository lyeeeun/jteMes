$(document).ready(function(){
	//progressbar 시작
	showProgressBar();
	//한국시간 표시, 반복실행 실행시키기
	play_repeat();
});

window.onload = function () {
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	
	top_line(context, 600, 1);
	top_line(context, 1200, 2);
	
	context.moveTo(20, 290);
	context.lineTo(10, 290);
	context.lineTo(10, 310);
	context.lineTo(20, 310);
	
	context.moveTo(10, 300);
	context.lineTo(1900, 300);
	
	context.moveTo(1890, 290);
	context.lineTo(1900, 290);
	context.lineTo(1900, 310);
	context.lineTo(1890, 310);
	
	context.font = "12px malgun gothic"
	context.fillText("AC, 3P3W, 480V, 60Hz, 4000A, SYM, 65kA",25,290);
	context.fillText("AC, 3P3W, 480V, 60Hz, 4000A, SYM, 65kA",1615,290);
	
	context.fillText("ACB-T",1100,330);
	context.fillText("600V",1100,345);
	context.fillText("4000A",1100,360);
	
	bottom_line(context, 150);
	bottom_line(context, 450);
	bottom_line(context, 1250);
	bottom_line(context, 1550);
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("#1 UNIT MCC",100,795);
	context.fillText("#1 COMMON MCC",390,795);
	context.fillText("#2 UNIT MCC",1200,795);
	context.fillText("#2 COMMON MCC",1490,795);
	
	context.fillText("#1 UNIT MCC",45,450);
	context.fillText("ACB",72,465);
	context.fillText("600V",68,480);
	context.fillText("3200A",64,495);
	context.fillText("#1 COM MCC",345,450);
	context.fillText("ACB",372,465);
	context.fillText("600V",368,480);
	context.fillText("1600A",364,495);
	context.fillText("BSDG",685,450);
	context.fillText("ACB",687,465);
	context.fillText("600V",685,480);
	context.fillText("3200A",682,495);
	context.fillText("#2 UNIT MCC",1145,450);
	context.fillText("ACB",1172,465);
	context.fillText("600V",1168,480);
	context.fillText("3200A",1164,495);
	context.fillText("#2 COM MCC",1445,450);
	context.fillText("ACB",1472,465);
	context.fillText("600V",1468,480);
	context.fillText("1000A",1464,495);
	
	
	context.moveTo(750, 300);
	context.lineTo(750, 830);
	context.moveTo(740, 825);
	context.lineTo(740, 830);
	context.lineTo(760, 830);
	context.lineTo(760, 825);
	context.stroke();
	
	context.beginPath();
	context.rect(739, 660, 10, 35);
	context.rect(751, 660, 10, 35);
	/*context.fillStyle = "#FFD700";*/ //사각형 안의 채울 색
	context.fillStyle = "white";
	context.fill(); //색 채우기
	context.strokeStyle = "black"; //사각형 선 색
	context.lineJoin = "miter"; //사각형 모서리 모양
	context.stroke();
	
	context.beginPath();
	context.arc(750, 788, 17, 0, Math.PI * 2);
	/*context.fillStyle = "#FF0000";*/
	context.fillStyle = "white";
	context.fill();
	context.fillStyle = "black";
	context.fillText("DG",740,795)
	
	context.strokeRect(780, 760, 250, 70);
	
	context.fillStyle = "black";
	context.fillText("BSDG COMMON ALARM",820,780);
	context.fillText("BSDG FUEL TANK LEVEL HIGH",820,800);
	context.fillText("BSDG FUEL TANK LEVEL LOW",820,820);
	
	context.stroke();
}

function top_line(context, x, i) {
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("#" + i + " AUX TR VCB PANEL",x-60,10);
	
	context.moveTo(x, 25);
	context.lineTo(x-5, 30);
	context.moveTo(x, 25);
	context.lineTo(x+5, 30);
	
	context.moveTo(x, 25);
	context.lineTo(x, 100);
	
	context.lineTo(x-10, 125);
	context.lineTo(x+10, 125);
	context.lineTo(x, 100);
	
	context.stroke();
	
	context.fillText("#" + i + " AUX TR",x-95,115);
	context.fillText("13.8/0.48kV",x-95,130);
	context.fillText("3.0MVA",x-88,145);
	context.fillText("Dyn11",x-83,160);
	
	context.beginPath();
	context.arc(x, 116, 17, 0, Math.PI * 2);
	
	context.moveTo(x-10, 160);
	context.lineTo(x, 150);
	context.lineTo(x+10, 160);
	context.moveTo(x, 150);
	context.lineTo(x, 135);
	
	context.moveTo(x, 150);
	context.lineTo(x+25, 150);
	context.lineTo(x+25, 160);
	
	context.moveTo(x+18, 160);
	context.lineTo(x+32, 160);
	context.moveTo(x+21, 163);
	context.lineTo(x+29, 163);
	context.moveTo(x+23, 166);
	context.lineTo(x+27, 166);
	
	context.stroke();
	
	context.beginPath();
	context.arc(x, 148, 17, 0, Math.PI * 2);
	
	context.moveTo(x, 165);
	context.lineTo(x, 300);
		
	context.fillText("ACB-IN " + i,x-85,215);
	context.fillText("600V",x-78,230);
	context.fillText("4000A",x-80,245);
	context.fillText("65kA",x-78,260);
	
	context.stroke();
}


function bottom_line(context, x) {
	context.moveTo(x, 300);
	context.lineTo(x, 750);
	
	context.stroke();
	
	context.beginPath();
	context.lineJoin = "round"; //사각형 모서리 모양
	context.strokeRect(x-80, 750, 150, 80);
}


//single line switch img 그리기
function switch_img(context, x, y, src) {
	var img_src = new Image();
	img_src.src = src
	img_src.onload = function(e) {
		context.drawImage(img_src, x+3, y, 30, 30);
	}
}

function elasticDataSearch(timeArea){
	try{
		var data = {"startTime":timeArea
				,"index":["common01"]};
		$.ajax({
			url: "/web-auxEquip-common",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				if(result == "noData"){
					alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");
					/*fn_LV("no_data");*/
					closeProgressBar();
				}else if(result == "error"){
					alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");
					/*fn_LV("no_data");*/
					closeProgressBar();
				}else{
					$("#hidWebData").val($("#hidWebData").val()+result);
					elasticDataSearch_CommonAlarm(result);	
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
	//progressbar 종료
	closeProgressBar();
}

function elasticDataSearch_CommonAlarm(com_data) {
	var com_data_date = JSON.parse(com_data);
	var data = {"startTime":com_data_date.common01.DATE
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
				fn_LV(com_data,"no_data");
				closeProgressBar();
			}else if(result == "error"){
				/*alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");*/
				fn_LV(com_data,"no_data");
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				fn_LV(com_data,result);	
			}
		}
	});
}




function fn_LV(result, com_data_alarm){
	var com_data = JSON.parse(result);;
	com_data = com_data.common01;
	
	var com_data_al;
	if(com_data_alarm == "no_data") {
		com_data_al = "no_data";
	} else {
		com_data_al = JSON.parse(com_data_alarm);
		com_data_al = com_data_al.common01_al
	}
	
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	
	//시간정보 SearchBox영역에 뿌려주기
	displayDate(com_data.DATE);
	
	AUX1(context, com_data, 640, 120);
	AUX2(context, com_data, 1240, 120);
	
	gen_data(context, com_data, 170, 400, "#1_UNIT");
	gen_data(context, com_data, 470, 400, "#1_COM");
	gen_data(context, com_data, 770, 400, "#BSDG");
	gen_data(context, com_data, 1270, 400, "#2_UNIT");
	gen_data(context, com_data, 1570, 400, "#1_COM");
	
	bsdg_alarm(context, com_data_al);
	
	vcb_switch(com_data_al, context);
	
}


function vcb_switch(common_data, context) {
	
	//Top Line ACB-INCOMMING
	if(common_data.CD0655) {
		switch_img(context, 581, 200, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 581, 200, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	if(common_data.CD0660) {
		switch_img(context, 1181, 200, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 1181, 200, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//ACB-TIE
	if(common_data.CD0650) {
		switch_img(context, 1100, 285, "/image/singleline/CB_OPEN_W.gif");
	} else {
		switch_img(context, 1100, 285, "/image/singleline/CB_CLOSE_W.gif");
	}
	
	//#1 UNIT MCC
	if(common_data.CD0665) {
		switch_img(context, 131, 450, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 131, 450, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//#1 COM MCC
	if(common_data.CD0675) {
		switch_img(context, 431, 450, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 431, 450, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//#2 UNIT MCC
	if(common_data.CD0670) {
		switch_img(context, 1231, 450, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 1231, 450, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//#2 COM MCC
	if(common_data.CD0680) {
		switch_img(context, 1531, 450, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 1531, 450, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
	//BSDG
	if(common_data.CD0685) {
		switch_img(context, 731, 450, "/image/singleline/CB_OPEN_W_SERO.gif");
	} else {
		switch_img(context, 731, 450, "/image/singleline/CB_CLOSE_W_SERO.gif");
	}
	
}

function AUX1(context, json, x, y) {
	var aux_data = new Array();
	var c = 0;
	while (c < 10) {
		aux_data[c] = new Array();
		c++;
	}
	aux_data[0][0] = json.CA0025; aux_data[0][1] = "R-S"; aux_data[0][2] = "V";
	aux_data[1][0] = json.CA0028; aux_data[1][1] = "R"; aux_data[1][2] = "A";
	aux_data[2][0] = json.CA0026; aux_data[2][1] = "S-T"; aux_data[2][2] = "V";
	aux_data[3][0] = json.CA0029; aux_data[3][1] = "S"; aux_data[3][2] = "A";
	aux_data[4][0] = json.CA0027; aux_data[4][1] = "T-R"; aux_data[4][2] = "V";
	aux_data[5][0] = json.CA0030; aux_data[5][1] = "T"; aux_data[5][2] = "A";
	aux_data[6][0] = json.CA0031; aux_data[6][1] = "FREQ"; aux_data[6][2] = "Hz";
	aux_data[7][0] = json.CA0032; aux_data[7][1] = "PF"; aux_data[7][2] = "pf";
	aux_data[8][0] = json.CA0033; aux_data[8][1] = "KW"; aux_data[8][2] = "kW";
	aux_data[9][0] = json.CA0034; aux_data[9][1] = "KVAR"; aux_data[9][2] = "kVar";
	
	context.clearRect(x, y, 350, 100);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 50;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 5) {
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
				context.fillText(aux_data[i][0],x+10,y+15);
				context.fillText(aux_data[i][2],x+55,y+15);
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
				context.fillText(aux_data[i][1],x+5,y+15);
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

function AUX2(context, json, x, y) {
	var aux_data = new Array();
	var c = 0;
	while (c < 10) {
		aux_data[c] = new Array();
		c++;
	}
	aux_data[0][0] = json.CA0035; aux_data[0][1] = "R-S"; aux_data[0][2] = "V";
	aux_data[1][0] = json.CA0038; aux_data[1][1] = "R"; aux_data[1][2] = "A";
	aux_data[2][0] = json.CA0036; aux_data[2][1] = "S-T"; aux_data[2][2] = "V";
	aux_data[3][0] = json.CA0039; aux_data[3][1] = "S"; aux_data[3][2] = "A";
	aux_data[4][0] = json.CA0037; aux_data[4][1] = "T-R"; aux_data[4][2] = "V";
	aux_data[5][0] = json.CA0040; aux_data[5][1] = "T"; aux_data[5][2] = "A";
	aux_data[6][0] = json.CA0041; aux_data[6][1] = "FREQ"; aux_data[6][2] = "Hz";
	aux_data[7][0] = json.CA0042; aux_data[7][1] = "PF"; aux_data[7][2] = "pf";
	aux_data[8][0] = json.CA0043; aux_data[8][1] = "KW"; aux_data[8][2] = "kW";
	aux_data[9][0] = json.CA0044; aux_data[9][1] = "KVAR"; aux_data[9][2] = "kVar";
	
	context.clearRect(x, y, 350, 100);
	context.beginPath();
	
	var sw = 0;
	var x_init=x;
	var x_w = 50;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 5) {
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
				context.fillText(aux_data[i][0],x+10,y+15);
				context.fillText(aux_data[i][2],x+55,y+15);
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
				context.fillText(aux_data[i][1],x+5,y+15);
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

function gen_data(context, json, x, y, key) {

var aux_data = new Array();
var c = 0;
while (c < 10) {
	aux_data[c] = new Array();
	c++;
}	
switch (key) {
case "#1_UNIT":
	aux_data[0][0] = json.CA0085; aux_data[0][1] = "R-S"; aux_data[0][2] = "V";
	aux_data[1][0] = json.CA0086; aux_data[1][1] = "S-T"; aux_data[1][2] = "V";
	aux_data[2][0] = json.CA0087; aux_data[2][1] = "T-R"; aux_data[2][2] = "V";
	aux_data[3][0] = json.CA0088; aux_data[3][1] = "R"; aux_data[3][2] = "A";
	aux_data[4][0] = json.CA0089; aux_data[4][1] = "S"; aux_data[4][2] = "A";
	aux_data[5][0] = json.CA0090; aux_data[5][1] = "T"; aux_data[5][2] = "A";
	aux_data[6][0] = json.CA0091; aux_data[6][1] = "FREQ"; aux_data[6][2] = "Hz";
	aux_data[7][0] = json.CA0092; aux_data[7][1] = "PF"; aux_data[7][2] = "pf";
	aux_data[8][0] = json.CA0093; aux_data[8][1] = "KW"; aux_data[8][2] = "kW";
	aux_data[9][0] = json.CA0094; aux_data[9][1] = "KVAR"; aux_data[9][2] = "kVar";
	break;
case "#1_COM":
	aux_data[0][0] = json.CA0065; aux_data[0][1] = "R-S"; aux_data[0][2] = "V";
	aux_data[1][0] = json.CA0066; aux_data[1][1] = "S-T"; aux_data[1][2] = "V";
	aux_data[2][0] = json.CA0067; aux_data[2][1] = "T-R"; aux_data[2][2] = "V";
	aux_data[3][0] = json.CA0068; aux_data[3][1] = "R"; aux_data[3][2] = "A";
	aux_data[4][0] = json.CA0069; aux_data[4][1] = "S"; aux_data[4][2] = "A";
	aux_data[5][0] = json.CA0070; aux_data[5][1] = "T"; aux_data[5][2] = "A";
	aux_data[6][0] = json.CA0071; aux_data[6][1] = "FREQ"; aux_data[6][2] = "Hz";
	aux_data[7][0] = json.CA0072; aux_data[7][1] = "PF"; aux_data[7][2] = "pf";
	aux_data[8][0] = json.CA0073; aux_data[8][1] = "KW"; aux_data[8][2] = "kW";
	aux_data[9][0] = json.CA0074; aux_data[9][1] = "KVAR"; aux_data[9][2] = "kVar";
	
	break;
case "#2_UNIT":
	aux_data[0][0] = json.CA0095; aux_data[0][1] = "R-S"; aux_data[0][2] = "V";
	aux_data[1][0] = json.CA0096; aux_data[1][1] = "S-T"; aux_data[1][2] = "V";
	aux_data[2][0] = json.CA0097; aux_data[2][1] = "T-R"; aux_data[2][2] = "V";
	aux_data[3][0] = json.CA0098; aux_data[3][1] = "R"; aux_data[3][2] = "A";
	aux_data[4][0] = json.CA0099; aux_data[4][1] = "S"; aux_data[4][2] = "A";
	aux_data[5][0] = json.CA0100; aux_data[5][1] = "T"; aux_data[5][2] = "A";
	aux_data[6][0] = json.CA0101; aux_data[6][1] = "FREQ"; aux_data[6][2] = "Hz";
	aux_data[7][0] = json.CA0102; aux_data[7][1] = "PF"; aux_data[7][2] = "pf";
	aux_data[8][0] = json.CA0103; aux_data[8][1] = "KW"; aux_data[8][2] = "kW";
	aux_data[9][0] = json.CA0104; aux_data[9][1] = "KVAR"; aux_data[9][2] = "kVar";
	break;
case "#2_COM":
	aux_data[0][0] = json.CA0075; aux_data[0][1] = "R-S"; aux_data[0][2] = "V";
	aux_data[1][0] = json.CA0076; aux_data[1][1] = "S-T"; aux_data[1][2] = "V";
	aux_data[2][0] = json.CA0077; aux_data[2][1] = "T-R"; aux_data[2][2] = "V";
	aux_data[3][0] = json.CA0078; aux_data[3][1] = "R"; aux_data[3][2] = "A";
	aux_data[4][0] = json.CA0079; aux_data[4][1] = "S"; aux_data[4][2] = "A";
	aux_data[5][0] = json.CA0080; aux_data[5][1] = "T"; aux_data[5][2] = "A";
	aux_data[6][0] = json.CA0081; aux_data[6][1] = "FREQ"; aux_data[6][2] = "Hz";
	aux_data[7][0] = json.CA0082; aux_data[7][1] = "PF"; aux_data[7][2] = "pf";
	aux_data[8][0] = json.CA0083; aux_data[8][1] = "KW"; aux_data[8][2] = "kW";
	aux_data[9][0] = json.CA0084; aux_data[9][1] = "KVAR"; aux_data[9][2] = "kVar";
	break;
case "#BSDG":
	aux_data[0][0] = json.CA0105; aux_data[0][1] = "R-S"; aux_data[0][2] = "V";
	aux_data[1][0] = json.CA0106; aux_data[1][1] = "S-T"; aux_data[1][2] = "V";
	aux_data[2][0] = json.CA0107; aux_data[2][1] = "T-R"; aux_data[2][2] = "V";
	aux_data[3][0] = json.CA0108; aux_data[3][1] = "R"; aux_data[3][2] = "A";
	aux_data[4][0] = json.CA0109; aux_data[4][1] = "S"; aux_data[4][2] = "A";
	aux_data[5][0] = json.CA0110; aux_data[5][1] = "T"; aux_data[5][2] = "A";
	aux_data[6][0] = json.CA0111; aux_data[6][1] = "FREQ"; aux_data[6][2] = "Hz";
	aux_data[7][0] = json.CA0112; aux_data[7][1] = "PF"; aux_data[7][2] = "pf";
	aux_data[8][0] = json.CA0113; aux_data[8][1] = "KW"; aux_data[8][2] = "kW";
	aux_data[9][0] = json.CA0114; aux_data[9][1] = "KVAR"; aux_data[9][2] = "kVar";
	break;
}
	context.clearRect(x, y, 170, 170);
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
				context.fillText(aux_data[i][0],x+10,y+15);
				context.fillText(aux_data[i][2],x+55,y+15);
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
				context.fillText(aux_data[i][1],x+5,y+15);
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

function bsdg_alarm(context, json) {
	context.beginPath();
	
	context.rect(790, 770, 25, 12.5); //#1
	context.rect(790, 790, 25, 12.5); //#2
	context.rect(790, 810, 25, 12.5); //#3
	
	context.fillStyle = "white"; //사각형 안의 채울 색
	context.fill(); //색 채우기
	context.strokeStyle = "black"; //사각형 선 색
	context.lineJoin = "miter"; //사각형 모서리 모양
	context.stroke();
	
	if(json.CD0625) {
		context.beginPath();
		context.rect(790, 770, 25, 12.5); //#1
		/*context.fillStyle = "RED"; //사각형 안의 채울 색
*/				context.fill(); //색 채우기
		context.strokeStyle = "black"; //사각형 선 색
		context.lineJoin = "miter"; //사각형 모서리 모양
		context.stroke();
	}
	if(json.CD0618) {
		context.beginPath();
		context.rect(790, 790, 25, 12.5); //#2
		/*context.fillStyle = "RED"; //사각형 안의 채울 색
*/				context.fill(); //색 채우기
		context.strokeStyle = "black"; //사각형 선 색
		context.lineJoin = "miter"; //사각형 모서리 모양
		context.stroke();
		context.fillStyle = "RED"; //사각형 안의 채울 색
	}
	if(json.CD0617) {
		context.beginPath();
		context.rect(790, 810, 25, 12.5); //#3
		/*context.fillStyle = "RED"; //사각형 안의 채울 색
*/				context.fill(); //색 채우기
		context.strokeStyle = "black"; //사각형 선 색
		context.lineJoin = "miter"; //사각형 모서리 모양
		context.stroke();
		context.fillStyle = "RED"; //사각형 안의 채울 색
	}
}
