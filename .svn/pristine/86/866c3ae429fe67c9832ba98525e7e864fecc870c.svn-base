//프로그레스바 생성
function showProgressBar(){
	$.messager.progress({
		title:'Please waiting',
		msg:'Loading data...'
	});
}
//프로그레스바 종료
function closeProgressBar(){
	setTimeout(function(){
		$.messager.progress('close');
	},200);
}

//date Validation
function dateValidation(prmtArea) {
	var returnBool = true;
	if($("#" + prmtArea).find(".jint_date").datebox('getValue')==""||$("#" + prmtArea).find(".jint_hour").combobox('getValue')==""||
			$("#" + prmtArea).find(".jint_min").combobox('getValue')==""||$("#" + prmtArea).find(".jint_sec").combobox('getValue')==""){
		returnBool = false;
	}
	return returnBool;
}

//date 합치기
function dateCombine(prmtArea) {
	return $("#" + prmtArea).find(".jint_date").datebox('getValue') + ' '
			+ $("#" + prmtArea).find(".jint_hour").combobox('getValue') + ':'
			+ $("#" + prmtArea).find(".jint_min").combobox('getValue') + ':'
			+ $("#" + prmtArea).find(".jint_sec").combobox('getValue');
}

// date 계산(prmt1(string format yyyy-MM-dd hh:mm:ss), prmt2 = int(계산 될 시간초))
function dateCalc(baseDate, calVal) {
	var dType = new Date(baseDate.replace(/-/g, '/'));
	dType.setSeconds(dType.getSeconds() + calVal);
	var tDate = dType.getFullYear() + '-' + padLeft(dType.getMonth() + 1, 2)
			+ '-' + padLeft(dType.getDate(), 2) + ' '
			+ padLeft(dType.getHours(), 2) + ':'
			+ padLeft(dType.getMinutes(), 2) + ':'
			+ padLeft(dType.getSeconds(), 2);
	return tDate;
}

/*
 타임존 시간 가져오기
한국시간 +9
데이테 타임 -6(한국시간에서 timezone(-14), 인덱싱 간격(-1) )
*/
function getWorldTime(tzOffset) { // 24시간제
	var now = new Date();
	var tz = now.getTime() + (now.getTimezoneOffset() * 60000)
			+ (tzOffset * 3600000);
	now.setTime(tz);
	var s = padLeft(now.getFullYear(), 4) + '-'
			+ padLeft(now.getMonth() + 1, 2) + '-' 
			+ padLeft(now.getDate(), 2) + ' ' 
			+padLeft(now.getHours(), 2) + ':' 
			+ padLeft(now.getMinutes(), 2)+ ':' 
			+ padLeft(now.getSeconds(), 2);
	return s;
}

//JSON stringify시 data변환문제
function dateUTC(date){
	var utcDate = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds()))
	return utcDate;
}

//Date to String 변환
function dateToString(transdate){
	date = new Date(transdate);
	return padLeft(date.getFullYear(), 4) + '-'
	+ padLeft(date.getMonth() + 1, 2) + '-' 
	+ padLeft(date.getDate(), 2) + ' ' 
	+padLeft(date.getHours(), 2) + ':' 
	+ padLeft(date.getMinutes(), 2)+ ':' 
	+ padLeft(date.getSeconds(), 2); 
	
}

// padLeft 구현
function padLeft(n, width) {
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join('0')+ n;
}

//URI 파라미터 읽기
function getParameterByName(name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	results = regex.exec(location.search);
	return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}