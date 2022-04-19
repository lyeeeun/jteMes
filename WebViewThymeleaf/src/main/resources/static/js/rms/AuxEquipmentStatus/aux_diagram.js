$(document).ready(function(){
	//progressbar 시작
	showProgressBar();
	//한국시간 표시, 반복실행 실행시키기
	play_repeat();	
});
window.onload = function () {
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	
	context.moveTo(643, 0);
	context.lineTo(643, 1080);
	context.moveTo(1286, 0);
	context.lineTo(1286, 1080);
	context.moveTo(0, 500);
	context.lineTo(1930, 500);
	
	aux_cw(context, 10);
	aux_lo(context, 653);
	aux_water_treatment(context, 10, 510);
	aux_compressed_air(context, 653, 510);
	aux_boiler(context, 1296, 10);
	aux_sludge(context, 1296, 510);
	
	context.stroke();
}
function aux_cw(context, x) {
	context.font = "bold 14px malgun gothic"
	context.fillStyle = "black";
	context.fillText("COOLING WATER SYSTEM", x+230, 10);
	//CW SYSTEM(AUX) START
	var i=0;
	var y=30;
	while (i < 2) {
		//좌측 화살표
		context.moveTo(x, y+180);
		context.lineTo(x+100, y+180);
		context.lineTo(x+110, y+190);
		context.lineTo(x+100, y+200);
		context.lineTo(x, y+200);
		context.lineTo(x, y+180);
		
		context.moveTo(x+110, y+190);
		context.lineTo(x+320, y+190);
		
		//P-301-00
		pump_img(context, 230, y+155, "/image/singleline/P-107-01.gif", 40, 40);
		//T-303-00
		tank_img(context, 320, y+70, "/image/singleline/T-303-00.gif", 100, 130);
		
		context.strokeRect(x+170, y+50, 300, 180);
		
		//우측 화살표
		context.moveTo(x+360, y+70);
		context.lineTo(x+360, y+20);
		context.lineTo(x+450, y+20);
		context.lineTo(x+460, y+10);
		context.lineTo(x+605, y+10);
		context.lineTo(x+605, y+30);
		context.lineTo(x+460, y+30);
		context.lineTo(x+450, y+20);
		
		y += 230;
		i++;
	}
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("#1~5 Engine", x+15, 225);
	context.fillText("#6~10 Engine", x+15, 455);
	context.fillText("WATER TREATMENT UNIT", x+460, 55);
	context.fillText("WATER TREATMENT UNIT", x+460, 285);
	context.fillText("M-301-00", x+480, 160);
	context.fillText("#1 CW MAINTENANCE", x+480, 175);
	context.fillText("TANK & PUMP UNIT", x+480, 190);
	context.fillText("M-302-00", x+480, 390);
	context.fillText("#2 CW MAINTENANCE", x+480, 405);
	context.fillText("TANK & PUMP UNIT", x+480, 420);
	context.fillText("P-301-00", x+215, 240);
	context.fillText("P-302-00", x+215, 470);
	context.fillText("T-303-00", x+340, 245);
	context.fillText("T-304-00", x+340, 475);
}
function aux_lo(context, x) {
	//LUBE OIL SYSTEM START
	context.font = "bold 14px malgun gothic"
	context.fillStyle = "black";
	context.fillText("LUBE OIL SYSTEM", x+230, 10);
	
	//상단 가로선
	context.moveTo(x+40, 150);
	context.lineTo(x+70, 150);
	context.moveTo(x+170, 150);
	context.lineTo(x+440, 150);
	context.moveTo(x+540, 150);
	context.lineTo(x+605, 150);
	context.lineTo(x+605, 30);
	
	//상단 우측 화살표(Engine)
	context.moveTo(x+630, 20);
	context.lineTo(x+620, 10);
	context.lineTo(x+520, 10);
	context.lineTo(x+520, 30);
	context.lineTo(x+620, 30);
	context.lineTo(x+630, 20);
	
	var i=0;
	var init_x = x;
	while(i<2) {
		context.strokeRect(x+70, 105, 100, 85);
		//P-201A-00, P-202A-00
		pump_img(context, x+100, 70, "/image/singleline/P-107-01.gif", 40, 40);
		//P-201B-00, P-202B-00
		pump_img(context, x+100, 155, "/image/singleline/P-107-01.gif", 40, 40);
		context.strokeRect(x+50, 40, 170, 175);
		i++;
		x+= 370;
	}
	x=init_x;

	//T-201-00
	tank_img(context, x+250, 75, "/image/singleline/T-201-00.gif", 100, 130);
	context.strokeRect(x+245, 65, 150, 150);
	
	i=0;
	var y=0;
	while (i<2) { 
		//좌측 하단 화살표(LO PURIFIER01~05)
		context.moveTo(x, y+300);
		context.lineTo(x+75, y+300);
		context.lineTo(x+85, y+310);
		context.lineTo(x+75, y+320);
		context.lineTo(x, y+320);
		context.lineTo(x, y+300);
		
		//중앙 하단 화살표(Engine01~05)
		context.moveTo(x+85, y+310);
		context.lineTo(x+230, y+310);
		context.lineTo(x+230, y+320);
		context.lineTo(x+290, y+320);
		context.lineTo(x+300, y+310);
		context.lineTo(x+290, y+300);
		context.lineTo(x+230, y+300);
		context.lineTo(x+230, y+310);
		
		//P-205-00
		pump_img(context, x+175, y+283, "/image/singleline/P-205-00_reverse.gif", 30, 30);
		//T-203-00
		tank_img(context, x+110, y+260, "/image/singleline/T-303-00.gif", 50, 60);
		context.strokeRect(x+100, y+255, 120, 80);
		
		y+=120;
		i++;
	}
	
	context.moveTo(x+92, 310);
	context.lineTo(x+92, 480);
	context.lineTo(x+330, 480);
	context.lineTo(x+330, 330);
	context.lineTo(x+590, 330);
	context.lineTo(x+590, 390);
	//T-202-00
	tank_img(context, x+350, 280, "/image/singleline/T-201-00.gif", 100, 130);
	//P-203-00
	pump_img(context, x+525, 290, "/image/singleline/P-205-00_reverse.gif", 45, 45);
	context.strokeRect(x+345, 265, 150, 150);
	
	//TANK LORRY
	tank_img(context, x, 130, "/image/singleline/tanklorry.gif", 30, 30);
	
	//TANK LORRY
	tank_img(context, x+570, 380, "/image/singleline/tanklorry.gif", 30, 30);
	
	context.moveTo(x+360, 410);
	context.lineTo(x+360, 460);
	
	//우측 하단 화살표(TAKE FARM PIT)
	context.moveTo(x+345, 460);
	context.lineTo(x+435, 460);
	context.lineTo(x+445, 470);
	context.lineTo(x+435, 480);
	context.lineTo(x+345, 480);
	context.lineTo(x+345, 460);
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("TANK", x, 105);
	context.fillText("LORRY", x, 120);
	context.fillText("P-201A-00", x+90, 125);
	context.fillText("P-201B-00", x+90, 210);
	context.fillText("M-203-00", x+105, 230);
	context.fillText("LO UNLOADING UNIT", x+75, 245);
	context.fillText("P-202A-00", x+460, 125);
	context.fillText("P-202B-00", x+460, 210);
	context.fillText("M-204-00", x+475, 230);
	context.fillText("LO UNLOADING UNIT", x+445, 245);
	context.fillText("T-201-00", x+295, 230);
	context.fillText("LO STORAGE TANK", x+270, 245);
	context.fillText("Engine#1~10", x+535, 25);
	context.fillText("TAKE FARM PIT", x+350, 475);
	context.fillText("TANK LORRY", x+550, 425);
	context.fillText("P-203-00", x+527, 350);
	context.fillText("USED LO PUMP", x+500, 365);
	context.fillText("T-202-00", x+395, 430);
	context.fillText("LO USED TANK", x+380, 445);
	
	context.font = "9px malgun gothic"
	context.fillText("LO PURIFIER#1~5", x+3, 312);
	context.fillText("LO PURIFIER#6~10", x+3, 433);
	context.fillText("Engine#1~5", x+235, 312);
	context.fillText("Engine#6~10", x+235, 433);
	context.fillText("P-205-00", x+175, 325);
	context.fillText("T-203-00", x+120, 330);
	context.fillText("P-206-00", x+175, 445);
	context.fillText("T-204-00", x+120, 450);
	context.fillText("M-205-00", x+140, 345);
	context.fillText("#1 LO MAINTENANCE TANK & PUMP UNIT", x+100, 355);
	context.fillText("M-206-00", x+140, 465);
	context.fillText("#2 LO MAINTENANCE TANK & PUMP UNIT", x+100, 475);
	
}
function aux_water_treatment(context, x, y) {
	context.font = "bold 14px malgun gothic"
	context.fillStyle = "black";
	context.fillText("WATER TREATMENT SYSTEM", x+230, y+5);
	
	//좌측 상단 화살표(RAW WATER(TANK LORRY))
	context.moveTo(x, y+40);
	context.lineTo(x, y+60);
	context.lineTo(x+130, y+60);
	context.lineTo(x+140, y+50);
	context.lineTo(x+130, y+40);
	context.lineTo(x, y+40);
	
	context.moveTo(x+140, y+50);
	context.lineTo(x+160, y+50);
	context.strokeRect(x+160, y+50, 70, 70);
	//P-801A-00
	pump_img(context, x+180, y+93, "/image/singleline/P-107-01.gif", 30, 30);
	//P-801B-00
	pump_img(context, x+180, y+25, "/image/singleline/P-107-01.gif", 30, 30);
	
	
	context.moveTo(x+230, y+50);
	context.lineTo(x+245, y+50);
	context.lineTo(x+245, y+140);
	context.lineTo(x+50, y+140);
	context.lineTo(x+50, y+180);
	context.moveTo(x+175, y+140);
	context.lineTo(x+175, y+180);
	//T-802-00
	tank_img(context, x+15, y+170, "/image/singleline/T-201-00.gif", 75, 80);
	context.strokeRect(x+10, y+160, 110, 100);
	//T-801-00
	tank_img(context, x+140, y+170, "/image/singleline/T-201-00.gif", 75, 80);
	context.strokeRect(x+135, y+160, 110, 100);
	
	context.moveTo(x+245, y+210);
	context.lineTo(x+260, y+210);
	context.strokeRect(x+260, y+190, 120, 70);
	//P-802A-00
	pump_img(context, x+280, y+165, "/image/singleline/P-107-01.gif", 30, 30);
	//P-802B-00
	pump_img(context, x+280, y+235, "/image/singleline/P-107-01.gif", 30, 30);
	
	context.moveTo(x+380, y+210);
	context.lineTo(x+430, y+210);
	context.strokeRect(x+430, y+190, 70, 70);
	
	//P-804A-00
	pump_img(context, x+440, y+165, "/image/singleline/P-107-01.gif", 30, 30);
	//P-804B-00
	pump_img(context, x+440, y+235, "/image/singleline/P-107-01.gif", 30, 30);
	
	context.moveTo(x+500, y+190);
	context.lineTo(x+530, y+190);
	context.lineTo(x+530, y+230);
	context.lineTo(x+540, y+230);
	
	context.moveTo(x+580, y+180);
	context.lineTo(x+580, y+70);
	context.lineTo(x+550, y+70);
	
	//P-807-00
	pump_img(context, x+530, y+43, "/image/singleline/P-107-01.gif", 30, 30);

	context.moveTo(x+420, y+210);
	context.lineTo(x+420, y+85);
	context.lineTo(x+420, y+85);
	context.lineTo(x+400, y+85);
	
	//F-804-00 R/O UNIT
	tank_img(context, x+545, y+170, "/image/singleline/R-O-UNIT-R.gif", 80, 20);
	tank_img(context, x+545, y+190, "/image/singleline/R-O-UNIT-R.gif", 80, 20);
	tank_img(context, x+545, y+210, "/image/singleline/R-O-UNIT-R.gif", 80, 20);
	tank_img(context, x+545, y+230, "/image/singleline/R-O-UNIT-R.gif", 80, 20);
	tank_img(context, x+545, y+250, "/image/singleline/R-O-UNIT-R.gif", 80, 20);
	
	//P-806-00
	pump_img(context, x+380, y+58, "/image/singleline/P-107-01.gif", 30, 30);
	
	context.moveTo(x+580, y+260);
	context.lineTo(x+580, y+350);
	context.strokeRect(x+510, y+350, 110, 100);
	
	//T-804-00
	tank_img(context, x+515, y+365, "/image/singleline/T-201-00.gif", 75, 80);
	
	context.moveTo(x+510, y+430);
	context.lineTo(x+440, y+430);
	context.lineTo(x+440, y+490);
	context.strokeRect(x+440, y+490, 70, 65);
	
	//P-808A-00
	pump_img(context, x+460, y+463, "/image/singleline/P-107-01.gif", 30, 30);
	//P-808B-00
	pump_img(context, x+460, y+528, "/image/singleline/P-107-01.gif", 30, 30);
	
	//우측 하단 화살표(CONSUMER)
	context.moveTo(x+510, y+525);
	context.lineTo(x+520, y+525);
	context.lineTo(x+520, y+535);
	context.lineTo(x+600, y+535);
	context.lineTo(x+610, y+525);
	context.lineTo(x+600, y+515);
	context.lineTo(x+520, y+515);
	context.lineTo(x+520, y+525);
	
	context.moveTo(x+560, y+260);
	context.lineTo(x+560, y+340);
	context.lineTo(x+400, y+340);
	context.lineTo(x+400, y+390);
	context.lineTo(x+100, y+390);
	
	//T-805-00
	tank_img(context, x+30, y+320, "/image/singleline/default_tank.gif", 70, 80);
	
	context.moveTo(x+100, y+340);
	context.lineTo(x+340, y+340);
	context.lineTo(x+340, y+310);
	context.lineTo(x+500, y+310);
	context.lineTo(x+500, y+260);
	
	//P-805-00
	pump_img(context, x+150, y+313, "/image/singleline/P-107-01.gif", 30, 30);
	
	context.moveTo(x+35, y+390);
	context.lineTo(x+20, y+390);
	context.lineTo(x+20, y+500);
	context.lineTo(x+30, y+500);
	context.strokeRect(x+30, y+440, 110, 100);
	
	//T-803-00
	tank_img(context, x+35, y+450, "/image/singleline/T-201-00.gif", 75, 80);
	
	context.moveTo(x+140, y+500);
	context.lineTo(x+270, y+500);
	context.lineTo(x+270, y+550);

	//P-803-00
	pump_img(context, x+180, y+473, "/image/singleline/P-107-01.gif", 30, 30);
	
	
	
	context.font = "10px malgun gothic"
	context.fillStyle = "black";
	context.fillText("RAW WATER (TANK LORRY)", x+5, y+53);
	context.fillText("P-801A-00", x+170, y+65);
	context.fillText("P-801B-00", x+170, y+133);
	context.fillText("T-802-00", x+35, y+270);
	context.fillText("FIRE FIGHTING WATER", x+5, y+280);
	context.fillText("TANK", x+40, y+290);
	context.fillText("T-801-00", x+155, y+270);
	context.fillText("RAW WATER STORAGE", x+135, y+280);
	context.fillText("TANK", x+163, y+290);
	context.fillText("P-802A-00", x+272, y+205);
	context.fillText("P-802B-00", x+272, y+275);
	context.fillText("RAW WATER", x+268, y+290);
	context.fillText("TRANSFER PUMP", x+260, y+300);
	context.fillText("P-804A-00", x+433, y+205);
	context.fillText("P-804B-00", x+433, y+275);
	context.fillText("P-807-00", x+525, y+85);
	context.fillText("NaOH FEED", x+520, y+10);
	context.fillText("PUMP", x+530, y+20);
	context.fillText("ANTI SCALANT", x+365, y+25);
	context.fillText("FEED PUMP", x+370, y+35);
	context.fillText("P-806-00", x+375, y+100);
	context.fillText("T-804-00", x+540, y+460);
	context.fillText("TREATED WATER TANK", x+510, y+470);
	context.fillText("TREATED WATER", x+360, y+520);
	context.fillText("TRANSFER PUMP", x+358, y+530);
	context.fillText("P-808A-00", x+453, y+503);
	context.fillText("P-808B-00", x+453, y+567);
	context.fillText("CONSUMER", x+533, y+528);
	context.fillText("T-805-00", x+50, y+410);
	context.fillText("R/O CIP TANK", x+40, y+420);
	context.fillText("P-805-00", x+145, y+355);
	context.fillText("CIP PUMP", x+143, y+365);
	context.fillText("T-803-00", x+60, y+550);
	context.fillText("CONCENTRAED WATER TANK", x+15, y+560);
	context.fillText("P-803-00", x+175, y+515);
	context.fillText("CONCENTRAED WATER", x+145, y+525);
	context.fillText("TRANSFER PUMP", x+155, y+535);
	context.fillText("R/O UNIT", x+585, y+285);
	 
}
function aux_compressed_air(context, x, y) {
	context.font = "bold 14px malgun gothic"
	context.fillStyle = "black";
	context.fillText("COMPRESSED AIR", x+230, y+5);
	
	var i=0;
	var init_y = y;
	while(i<4) {
		context.strokeRect(x+30, y+20, 20, 15);
		context.strokeRect(x+30, y+40, 20, 15);
		
		//C-501A-00
		tank_img(context, x+30, y+60, "/image/singleline/C-501A-00.gif", 100, 60);
		
		context.moveTo(x+130, y+90);
		context.lineTo(x+230, y+90);
		
		//V-501A-00
		tank_img(context, x+225, y+40, "/image/singleline/V-501A-00.gif", 80, 80);
		
		context.moveTo(x+335, y+90);
		context.lineTo(x+400, y+90);
		
		context.font = "12px malgun gothic"
		context.fillStyle = "black";
		context.fillText("ALARM", x+55, y+32);
		context.fillText("SHUTDOWN", x+55, y+52);
		
		if (i==1) {
			y+=140;
		} else {
			y+=130;	
		}
		i++;
	}
	y=init_y;
	
	context.strokeRect(x+20, y+10, 130, 260);
	context.strokeRect(x+20, y+280, 130, 260);
	context.strokeRect(x+217, y+30, 130, 240);
	context.strokeRect(x+217, y+300, 130, 240);
	
	context.moveTo(x+400, y+90);
	context.lineTo(x+400, y+220);
	context.moveTo(x+400, y+360);
	context.lineTo(x+400, y+490);
	context.moveTo(x+400, y+155);
	context.lineTo(x+500, y+155);
	context.lineTo(x+500, y+425);
	context.lineTo(x+400, y+425);
	context.moveTo(x+450, y+155);
	context.lineTo(x+450, y+90);
	context.moveTo(x+450, y+425);
	context.lineTo(x+450, y+360);
	
	//우측 화살표(Engine)
	context.moveTo(x+500, y+300);
	context.lineTo(x+520, y+300);
	context.lineTo(x+520, y+310);
	context.lineTo(x+600, y+310);
	context.lineTo(x+610, y+300);
	context.lineTo(x+600, y+290);
	context.lineTo(x+520, y+290);
	context.lineTo(x+520, y+300);
	
	context.font = "12px malgun gothic"
	context.fillStyle = "black";
	context.fillText("C-501A-00", x+55, y+132);	
	context.fillText("C-501B-00", x+55, y+262);	
	context.fillText("C-502A-00", x+55, y+402);
	context.fillText("C-502B-00", x+55, y+532);
	context.fillText("Engine#1~10", x+527, y+303);
	context.fillText("V-501A-00", x+240, y+132);
	context.fillText("V-501B-00", x+240, y+262);
	context.fillText("V-502A-00", x+240, y+402);
	context.fillText("V-502B-00", x+240, y+532);
		
}
function aux_boiler(context, x, y) {
	context.font = "bold 14px malgun gothic"
	context.fillStyle = "black";
	context.fillText("EXHAUST GAS BOILER SYSTEM", x+230, y+5);
	
	var i=0;
	var init_y=y;
	while (i<4) {
		//좌측 상단 화살표(EXHAUST GAS IN)
		context.moveTo(x, y+20);
		context.lineTo(x, y+40);
		context.lineTo(x+80, y+40);
		context.lineTo(x+90, y+30);
		context.lineTo(x+80, y+20);
		context.lineTo(x, y+20);
		context.moveTo(x+90, y+30);
		context.lineTo(x+120, y+30);
		context.stroke();
		
		//좌측 상단 3-WAY 화살표
		context.beginPath();
		context.moveTo(x+110, y+30);
		context.lineTo(x+110, y+25);
		context.lineTo(x+120, y+30);
		context.lineTo(x+110, y+35);
		context.lineTo(x+110, y+30);
		context.moveTo(x+120, y+30);
		context.lineTo(x+130, y+25);
		context.lineTo(x+130, y+35);
		context.lineTo(x+120, y+30);
		context.moveTo(x+120, y+30);
		context.lineTo(x+125, y+40);
		context.lineTo(x+115, y+40);
		context.lineTo(x+120, y+30);
		
		context.stroke();
		context.fill();
	
		context.beginPath();
		//중앙 상단 화살표(EXHAUST GAS SILENCER)
		context.moveTo(x+130, y+30);
		context.lineTo(x+180, y+30);
		context.lineTo(x+180, y+20);
		context.lineTo(x+300, y+20);
		context.lineTo(x+310, y+30);
		context.lineTo(x+300, y+40);
		context.lineTo(x+180, y+40);
		context.lineTo(x+180, y+30);
		
		context.moveTo(x+120, y+30);
		context.lineTo(x+120, y+55);
		context.lineTo(x+120, y+55);
		context.lineTo(x+30, y+55);
		context.lineTo(x+30, y+85);
		context.lineTo(x+210, y+85);
		
		//M-701-02
		tank_img(context, x+50, y+65, "/image/singleline/M-701-02.gif", 80, 60);
		
		//중앙 상단 화살표2(FEED WATER PUMP)
		context.lineTo(x+220, y+75);
		context.lineTo(x+310, y+75);
		context.lineTo(x+310, y+95);
		context.lineTo(x+220, y+95);
		context.lineTo(x+210, y+85);
		
		context.moveTo(x+150, y+120);
		context.lineTo(x+330, y+120);
		
		context.font = "10px malgun gothic"
		context.fillStyle = "black";
		context.fillText("EXHAUST GAS IN", x+3, y+33);
		context.fillText("EXHAUST GAS SILENCER", x+185, y+33);
		context.fillText("FEED WATER PUMP", x+217, y+88);
		
		y+=120;
		i++;
	}
	y=init_y;
	
	context.moveTo(x+330, y+480);
	context.lineTo(x+330, y+120);
	context.lineTo(x+470, y+120);
	context.lineTo(x+470, y+130);
	
	//CP-D001-00
	pump_img(context, x+360, y+50, "/image/singleline/P-107-01.gif", 30, 30);
	//CP-D002-00
	pump_img(context, x+450, y+50, "/image/singleline/P-107-01.gif", 30, 30);
	
	context.moveTo(x+340, y+160);
	context.strokeRect(x+350, y+200, 70, 70);
	
	//FP-D001-00
	pump_img(context, x+370, y+173, "/image/singleline/P-107-01.gif", 30, 30);
	//FP-D002-00
	pump_img(context, x+370, y+243, "/image/singleline/P-107-01.gif", 30, 30);
	
	context.moveTo(x+420, y+270);
	context.lineTo(x+420, y+420);
	
	//M-706-00
	tank_img(context, x+365, y+290, "/image/singleline/M-706-00.gif", 100, 60);
	//DO DAY TANK
	tank_img(context, x+390, y+400, "/image/singleline/default_tank.gif", 50, 50);
	
	context.moveTo(x+420, y+200);
	context.lineTo(x+500, y+200);
	
	//T-701(FEED WATER TANK)
	tank_img(context, x+500, y+190, "/image/singleline/default_tank.gif", 120, 60);
	
	//STEAM HEADER
	tank_img(context, x+420, y+130, "/image/singleline/R-O-UNIT.gif", 120, 40);
	
	
	//CHEMICAL DO SING
	context.moveTo(x+555, y+250);
	context.lineTo(x+555, y+330);
	context.strokeRect(x+538, y+330, 35, 35);
	
	context.stroke();
	
	context.beginPath();
	context.arc(x+556, y+347, 13, 0, Math.PI * 2);
	
	context.font = "10px malgun gothic"
	context.fillStyle = "black";
	context.fillText("CP-D001-00", x+350, y+90);
	context.fillText("CP-D002-00", x+440, y+90);
	context.fillText("STEAM HEADER", x+440, y+180);
	context.fillText("FP-D001-00", x+360, y+213);
	context.fillText("FP-D002-00", x+360, y+283);
	context.fillText("T-701", x+560, y+260);
	context.fillText("FEED WATER", x+560, y+270);
	context.fillText("TANK", x+560, y+280);
	context.fillText("M-706-00", x+370, y+360);
	context.fillText("OIL FIRED", x+370, y+370);
	context.fillText("BOILER", x+370, y+380);
	context.fillText("DO DAY TANK", x+385, y+460);
	context.fillText("CHEMICAL", x+533, y+375);
	context.fillText("DO SING", x+535, y+385);
	
}
function aux_sludge(context, x, y) {
	context.font = "bold 14px malgun gothic"
	context.fillStyle = "black";
	context.fillText("SLUDGE DISPLOSAL SYSTEM", x+230, y+5);
	
	var i=0;
	var init_y=y;
	while(i<4) {
		tank_img(context, x+30, y+70, "/image/singleline/P-604-00.gif", 70, 60);
		pump_img(context, x+55, y+30, "/image/singleline/P-107-01.gif", 30, 30);
		tank_img(context, x+150, y+70, "/image/singleline/P-604-00.gif", 70, 60);
		pump_img(context, x+175, y+30, "/image/singleline/P-107-01.gif", 30, 30);
		i++;
		y+=140;
	}
	y=init_y;
	
	tank_img(context, x+330, y+90, "/image/singleline/T-603A-00.gif", 100, 140);
	tank_img(context, x+460, y+90, "/image/singleline/T-603A-00.gif", 100, 140);
	
	setTimeout(function() {
		pump_img(context, x+367, y+195, "/image/singleline/P-107-01.gif", 30, 30);
		pump_img(context, x+497, y+195, "/image/singleline/P-107-01.gif", 30, 30);
		}, 100);
	
	
	
	context.font = "10px malgun gothic"
	context.fillStyle = "black";
	context.fillText("P-604-00", x+50, y+70);
	context.fillText("P-605-00", x+170, y+70);
	context.fillText("P-602-00", x+50, y+210);
	context.fillText("P-606-00", x+170, y+210);
	context.fillText("P-607-00", x+50, y+350);
	context.fillText("P-601-00", x+170, y+350);
	context.fillText("P-608-00", x+50, y+490);
	context.fillText("P-603-00", x+170, y+490);
	context.fillText("#1 POWER HOUSE PIT PUMP", x+0, y+140);
	context.fillText("#2 POWER HOUSE PIT PUMP", x+140, y+140);
	context.fillText("OIL FIRED BOILER", x+30, y+280);
	context.fillText("CW DRAIN PIT PUMP", x+140, y+280);
	context.fillText("PUMP HOUSE PIT PUMP", x+10, y+420);
	context.fillText("HFO PURIFIER HOUSE PIT PUMP", x+130, y+420);
	context.fillText("STEP-UP TR PIT PUMP", x+20, y+560);
	context.fillText("TANK FARM PIT PUMP", x+140, y+560);
	context.fillText("P-607A-00", x+360, y+240);
	context.fillText("SLUDGE UNLOADING", x+335, y+250);
	context.fillText("PUMP A", x+367, y+260);
	context.fillText("P-607B-00", x+490, y+240);
	context.fillText("SLUDGE UNLOADING", x+465, y+250);
	context.fillText("PUMP B", x+495, y+260);
	context.fillText("T-603A-00", x+350, y+50);
	context.fillText("SLUDGE", x+354, y+60);
	context.fillText("STROAGE TANK A", x+337, y+70);
	context.fillText("T-603B-00", x+485, y+50);
	context.fillText("SLUDGE", x+489, y+60);
	context.fillText("STROAGE TANK B", x+474, y+70);
	
}

function pump_img(context, x, y, src, width, height) {
	var img_src = new Image();
	img_src.src = src
	img_src.onload = function(e) {
		context.drawImage(img_src, x+3, y, width, width);
	}
}

function tank_img(context, x, y, src, width, height) {
	var img_src = new Image();
	img_src.src = src
	img_src.onload = function(e) {
		context.drawImage(img_src, x+3, y, width, height);
	}
}
/*
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
}*/

//ElasticSearch 데이타 조회 - Common Analog
function elasticDataSearch(timeArea){
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
				closeProgressBar();
			}else if(result == "error"){
				alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");
				closeProgressBar();
			}else{
				//결과 파싱
				var analogData = JSON.parse(result);
				analogData = analogData.common01;
				//Discription 데이터 호출
				elasticDataSearch_discription(analogData,"common01_al");
			}
		}
	});
}

//ElasticSearch 데이타 조회 - Common Discription
function elasticDataSearch_discription(analogData,index){
	var data = {"startTime":analogData.DATE
			,"index":[index]};
	var jsonData = "false";
	$.ajax({
		url: "/web-elecStauts-common",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				alert("데이터가 없습니다. 시간을 다시 설정해 주세요.2");
				closeProgressBar();
			}else if(result == "error"){
				alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.2");
				closeProgressBar();
			}else{
				//결과 파싱
				var discriptionData = JSON.parse(result);
				discriptionData = discriptionData.common01_al;
				//analog, discription assign 해서 display 함수 호출
				fn_AuxDiagram(Object.assign(analogData,discriptionData));
			}
		}
	});
}

//ElasticSearch 데이타 조회 콜백
function fn_AuxDiagram(com_data){
	
	var canvas = document.getElementById("diagram_canvas");
	var context = canvas.getContext("2d");
	
	//시간정보 SearchBox영역에 뿌려주기
	displayDate(com_data.DATE);
	
	/*COOLING WATER SYSTEM*/
	//P-301-00
	run_status(context, com_data.CD0312, false, 220, 160);
	//P-302-00
	run_status(context, com_data.CD0315, false, 220, 390);
	
	/*LUBE OIL SYSTEM*/
	//P-201A-00
	run_status(context, com_data.CD0101, false, 742, 47);
	//P-201B-00
	run_status(context, com_data.CD0104, false, 742, 132);
	//P-202A-00
	run_status(context, com_data.CD0107, false, 1112, 47);
	//P-202B-00
	run_status(context, com_data.CD0115, false, 1112, 132);
	//PI-201-00
	lo_analog_value(context, com_data.CA0141, 807, 47, "PI-201-00");
	//PI-202-00
	lo_analog_value(context, com_data.CA0142, 1177, 47, "PI-202-00");
	//LI-201-00
	lo_analog_value(context, com_data.CA0142, 915, 160, "LI-201-00");
	//P-205-00
	mini_run_status(context, com_data.CD0126, false, 828, 265);
	//P-206-00
	mini_run_status(context, com_data.CD0129, false, 828, 385);
	//LI-202-00
	lo_analog_value(context, com_data.CA0122, 1015, 365, "LI-202-00");
	//P-203-00
	run_status(context, com_data.CD0123, com_data.CD0491, 1175, 268);
	
	/*WATER TREATMENT SYSTEM*/
	//P-801A-00
	mini_run_status(context, com_data.CD0208, false, 185, 517);
	//P-801B-00
	mini_run_status(context, com_data.CD0211, false, 185, 585);
	//LI-802-00
	wt_analog_value(context, com_data.CA0126, 30, 725,"LI-802-00");
	//LI-801-00
	wt_analog_value(context, com_data.CA0125, 155, 725,"LI-801-00");
	//P-802A-00
	mini_run_status(context, com_data.CD0214, false, 285, 657);
	//P-802B-00
	mini_run_status(context, com_data.CD0224, false, 285, 727);
	//PI-003-00
	wt_analog_value(context, com_data.CA0151, 337, 705,"PI-003-00");
	//P-804A-00
	mini_run_status(context, com_data.CD0242, false, 445, 657);
	//P-804B-00
	mini_run_status(context, com_data.CD0252, false, 445, 727);
	//PI-001-00
	wt_analog_value(context, com_data.CA0149, 490, 667,"PI-001-00");
	//P-807-00
	mini_run_status(context, com_data.CD0278, false, 535, 535);
	//P-806-00
	mini_run_status(context, com_data.CD0270, false, 385, 550);
	//LI-804-00
	wt_analog_value(context, com_data.CA0128, 530, 920,"LI-804-00");
	//P-808A-00
	mini_run_status(context, com_data.CD0286, false, 465, 955);
	//P-808B-00
	mini_run_status(context, com_data.CD0296, false, 465, 1020);
	//P-805-00
	mini_run_status(context, com_data.CD0262, false, 157, 805);
	//LI-803-00
	wt_analog_value(context, com_data.CA0127, 50, 1005,"LI-803-00");
	//P-803-00
	mini_run_status(context, com_data.CD0234, false, 187, 965);
	
	/*COMPRESSED AIR*/
	//#1 AIR COMPRESSOR A ALARM
	AIR_COMP_ALARM(context, com_data.CD0494, 683, 530);
	//#1 AIR COMPRESSOR A SHUTDOWN
	AIR_COMP_ALARM(context, com_data.CD0495, 683, 550);
	//#1 AIR COMPRESSOR B ALARM
	AIR_COMP_ALARM(context, com_data.CD0496, 683, 660);
	//#1 AIR COMPRESSOR B SHUTDOWN
	AIR_COMP_ALARM(context, com_data.CD0497, 683, 680);
	//#2 AIR COMPRESSOR A ALARM
	AIR_COMP_ALARM(context, com_data.CD0498, 683, 800);
	//#2 AIR COMPRESSOR A SHUTDOWN
	AIR_COMP_ALARM(context, com_data.CD0499, 683, 820);
	//#2 AIR COMPRESSOR B ALARM
	AIR_COMP_ALARM(context, com_data.CD0500, 683, 930);
	//#2 AIR COMPRESSOR B SHUTDOWN
	AIR_COMP_ALARM(context, com_data.CD0501, 683, 950);
	//PI-501A-00
	aircompressed_analog_value(context, com_data.CA0143, 895, 578,"PI-501A-00");
	//PI-501B-00
	aircompressed_analog_value(context, com_data.CA0144, 895, 708,"PI-501B-00");
	//PI-501A-00
	aircompressed_analog_value(context, com_data.CA0145, 895, 848,"PI-502A-00");
	//PI-502B-00
	aircompressed_analog_value(context, com_data.CA0146, 895, 978,"PI-502B-00");
	//PI-509-00
	aircompressed_analog_value(context, com_data.CA0147, 1075, 560,"PI-509-00");
	//PI-513-00
	aircompressed_analog_value(context, com_data.CA0148, 1075, 830,"PI-513-00");
	
	/*EXHAUST GAS BOILER SYSTEM*/
	//LI-001-00
	gasboiler_analog_value(context, com_data.CA0129, 1363, 80,"LI-001-00");
	//LI-002-00
	gasboiler_analog_value(context, com_data.CA0130, 1363, 200,"LI-002-00");
	//LI-003-00
	gasboiler_analog_value(context, com_data.CA0131, 1363, 320,"LI-003-00");
	//LI-004-00
	gasboiler_analog_value(context, com_data.CA0132, 1363, 440,"LI-004-00");
	//FI-001-00
	gasboiler_analog_value(context, com_data.CA0163, 1440, 55,"FI-001-00");
	//FI-002-00
	gasboiler_analog_value(context, com_data.CA0164, 1440, 175,"FI-002-00");
	//FI-003-00
	gasboiler_analog_value(context, com_data.CA0165, 1440, 295,"FI-003-00");
	//FI-004-00
	gasboiler_analog_value(context, com_data.CA0166, 1440, 415,"FI-004-00");
	//PI-002
	gasboiler_analog_value(context, com_data.CA0150, 1850, 150,"PI-002");
	//CP-D001-00
	mini_run_status(context, com_data.CD0312, false, 1653, 43);
	//CP-D002-00
	mini_run_status(context, com_data.CD0314, false, 1743, 43);
	//FP-D001-00
	mini_run_status(context, com_data.CD0316, false, 1662, 165);
	//FP-D002-00
	mini_run_status(context, com_data.CD0318, false, 1662, 235);
	
	/*SLUDGE DISPOSAL SYSTEM*/
	//P-604-00
	mini_run_status(context, com_data.CD0162, false, 1348, 520);
	//P-605-00
	mini_run_status(context, com_data.CD0164, false, 1468, 520);
	//P-602-00
	mini_run_status(context, com_data.CD0146, false, 1348, 660);
	//P-606-00
	mini_run_status(context, com_data.CD0178, false, 1468, 660);
	//P-607-00
	mini_run_status(context, com_data.CD0186, false, 1348, 800);
	//P-601-00
	mini_run_status(context, com_data.CD0138, false, 1468, 800);
	//P-608-00
	mini_run_status(context, com_data.CD0194, false, 1348, 940);
	//P-603-00
	mini_run_status(context, com_data.CD0154, false, 1468, 940);
	//P-607A-00
	mini_run_status(context, com_data.CD0202, false, 1657, 687);
	//P-607B-00
	mini_run_status(context, com_data.CD0205, false, 1787, 687);
	//LI-601-00
	sludge_analog_value(context, com_data.CA0123, 1652, 620,"LI-601-00");
	//LI-602-00
	sludge_analog_value(context, com_data.CA0124, 1782, 620,"LI-602-00");
	//TI-603-00
	sludge_analog_value(context, com_data.CA0159, 1652, 650,"TI-603-00");
	//TI-604-00
	sludge_analog_value(context, com_data.CA0160, 1782, 650,"TI-604-00");
	
	
	
	context.stroke();
	//progressbar 종료
		closeProgressBar();
}

function run_status(context, data, fault_signal, x, y) {
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

function mini_run_status(context, data, fault_signal, x, y) {
	context.beginPath();
	context.rect(x, y, 40, 15);
	context.strokeStyle = "black"; //사각형 선 색
	context.lineWidth = 1.5; //사각형 선 두께
	context.lineJoin = "miter"; //사각형 모서리 모양
	context.fillStyle = "white";
	/*context.fillStyle = "#32CD32";*/ //사각형 안의 채울 색
	context.fill(); //색 채우기
	
	context.font = "10px malgun gothic"
	context.fillStyle = "black";
	if(fault_signal) {
		context.fillText("FAULT",x+5,y+11);
	} else {
		if(data) {
			context.fillText("RUN",x+11,y+11);
		} else {
			context.fillText("STOP",x+9,y+11);
		}
	}
	context.stroke();
}

//LUBE OIL SYSTEM Analog Data Display
function lo_analog_value(context, analog_data, x, y, key) {
	var data = new Array();
	data[0] = new Array();
	
	switch(key) {
		case "PI-201-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		case "PI-202-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		case "LI-201-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "LI-202-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
	}		
	context.clearRect(x, y, 60, 40);
	context.beginPath();

	var sw = 0;
	var x_init=x;
	var x_w = 60;
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
				context.fillText(data[i][0],x+5,y+14);
				context.fillText(data[i][2],x+35,y+15);
				x += 60
				x_w = 60;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "11px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+5,y+14);
				x_w = 60;
				x += 60;
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

//WATER TREATMENT SYSTEM Analog Data Display
function wt_analog_value(context, analog_data, x, y, key) {
	var data = new Array();
	data[0] = new Array();
	
	switch(key) {
		case "LI-802-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "LI-801-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "PI-003-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		case "PI-001-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		case "LI-804-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "LI-803-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
	}		
	context.clearRect(x, y, 50, 30);
	context.beginPath();

	var sw = 0;
	var x_init=x;
	var x_w = 50;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 2) {
		while (x_i < 1) {
			context.beginPath();
			context.rect(x, y, x_w, 15);
			context.strokeStyle = "black"; //사각형 선 색
			context.lineWidth = 1.5; //사각형 선 두께
			context.lineJoin = "miter"; //사각형 모서리 모양
			if(sw == 1) {
				context.fillStyle = "white";
				/*context.fillStyle = "#32CD32";*/ //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "10px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][0],x+5,y+12);
				context.fillText(data[i][2],x+34,y+12);
				x += 50
				x_w = 50;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "10px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+3,y+10);
				x_w = 50;
				x += 50;
				sw = 1;
			}
			x_i++;
		}
		x_i = 0;
		x = x_init;
		y += 15;
		y_i++;
	}
}

//WATER TREATMENT SYSTEM Analog Data Display
function aircompressed_analog_value(context, analog_data, x, y, key) {
	var data = new Array();
	data[0] = new Array();
	
	switch(key) {
		case "PI-501A-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		case "PI-501B-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		case "PI-502A-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		case "PI-502B-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		case "PI-509-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		case "PI-513-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
		
	}
	
	context.clearRect(x, y, 60, 40);
	context.beginPath();

	var sw = 0;
	var x_init=x;
	var x_w = 60;
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
				context.font = "11px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][0],x+3,y+13);
				context.fillText(data[i][2],x+35,y+13);
				x += 60
				x_w = 60;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "11px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+3,y+14);
				x_w = 60;
				x += 60;
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

function gasboiler_analog_value(context, analog_data, x, y, key) {
	var data = new Array();
	data[0] = new Array();
	
	switch(key) {
		case "LI-001-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "LI-002-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "LI-003-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "LI-004-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "FI-001-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "FI-002-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "FI-003-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "FI-004-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "PI-002": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "bar"; break;
	}		
	context.clearRect(x, y, 50, 30);
	context.beginPath();

	var sw = 0;
	var x_init=x;
	var x_w = 50;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 2) {
		while (x_i < 1) {
			context.beginPath();
			context.rect(x, y, x_w, 15);
			context.strokeStyle = "black"; //사각형 선 색
			context.lineWidth = 1.5; //사각형 선 두께
			context.lineJoin = "miter"; //사각형 모서리 모양
			if(sw == 1) {
				context.fillStyle = "white";
				/*context.fillStyle = "#32CD32";*/ //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "10px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][0],x+5,y+12);
				context.fillText(data[i][2],x+34,y+12);
				x += 50
				x_w = 50;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "10px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+3,y+10);
				x_w = 50;
				x += 50;
				sw = 1;
			}
			x_i++;
		}
		x_i = 0;
		x = x_init;
		y += 15;
		y_i++;
	}
}

function sludge_analog_value(context, analog_data, x, y, key) {
	var data = new Array();
	data[0] = new Array();
	
	switch(key) {
		case "TI-603-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "℃"; break;
		case "TI-604-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "℃"; break;
		case "LI-601-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
		case "LI-602-00": data[0][0] = analog_data; data[0][1] = key; data[0][2] = "%"; break;
	}		
	context.clearRect(x, y, 50, 30);
	context.beginPath();

	var sw = 0;
	var x_init=x;
	var x_w = 50;
	var x_i = 0 ;
	var y_i = 0 ;
	var i = 0;
	while (y_i < 2) {
		while (x_i < 1) {
			context.beginPath();
			context.rect(x, y, x_w, 15);
			context.strokeStyle = "black"; //사각형 선 색
			context.lineWidth = 1.5; //사각형 선 두께
			context.lineJoin = "miter"; //사각형 모서리 모양
			if(sw == 1) {
				context.fillStyle = "white";
				/*context.fillStyle = "#32CD32";*/ //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "10px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][0],x+5,y+12);
				context.fillText(data[i][2],x+34,y+12);
				x += 50
				x_w = 50;
				sw = 0;
				i++;
			} else {
				context.fillStyle = "white"; //사각형 안의 채울 색
				context.fill(); //색 채우기
				context.stroke();
				context.font = "10px malgun gothic"
				context.fillStyle = "black";
				context.fillText(data[i][1],x+3,y+10);
				x_w = 50;
				x += 50;
				sw = 1;
			}
			x_i++;
		}
		x_i = 0;
		x = x_init;
		y += 15;
		y_i++;
	}
}


function AIR_COMP_ALARM(context, data, x, y, key) {
	if(data) {
		context.fillStyle = "Grey";
		context.fillRect(x, y, 19, 14);
	} else {
		context.fillStyle = "White";
		context.fillRect(x, y, 19, 14);
	}
}
