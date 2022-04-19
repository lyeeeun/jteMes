// easy-ui DateBox 포맷1
$.fn.datebox.defaults.formatter = function(date) {
	var y = date.getFullYear();
	var m = padLeft(date.getMonth() + 1, 2);
	var d = padLeft(date.getDate(), 2);
	return y + '-' + m + '-' + d;
}
// easy-ui DateBox 포맷2
$.fn.datebox.defaults.parser = function(s) {
	var t = Date.parse(s);
	if (!isNaN(t)) {
		return new Date(t);
	} else {
		return new Date();
	}
}

$(document).ready(
		function() {

			$("input").each(
					function() {
						// 시간
						if ($(this).attr("jintformat") == "HOUR") {
							$(this).addClass("jint_hour");

							var hourList = new Array();

							for (i = 0; i <= 23; i++) {
								var objHour = new Object();
								objHour.id = padLeft(i, 2);
								objHour.text = padLeft(i, 2);
								hourList.push(objHour);
							}
							$(this).combobox({
								data : hourList,
								valueField : 'id',
								textField : 'text',
								method : 'get'
							});
						}

						// 분
						if ($(this).attr("jintformat") == "MIN"
								|| $(this).attr("jintformat") == "SEC") {
							$(this).addClass("jint_min");

							var minList = new Array();

							for (i = 0; i <= 59; i++) {
								var objMin = new Object();
								objMin.id = padLeft(i, 2);
								objMin.text = padLeft(i, 2);
								minList.push(objMin);
							}

							$(this).combobox({
								data : minList,
								valueField : 'id',
								textField : 'text',
								method : 'get'
							});
						}

						// 초
						if ($(this).attr("jintformat") == "SEC") {
							$(this).addClass("jint_sec");

							var secList = new Array();

							for (i = 0; i <= 59; i++) {
								var objSec = new Object();
								objSec.id = padLeft(i, 2);
								objSec.text = padLeft(i, 2);
								secList.push(objSec);
							}

							$(this).combobox({
								data : secList,
								valueField : 'id',
								textField : 'text',
								method : 'get'
							});
						}

					});
		});


/*반복실행 관련 함수 시작 */
//한국시간 표시, 반복실행 실행시키기(최초 실행 시)
function play_repeat(){
	setInterval(function(){$("#kor_time").text(getWorldTime(9))}, 1000);
	startSubmit('eng_Search');
}

//Auto Refresh관련 --jkkim
var playSubmit;
function startSubmit(timeArea){
	$("#search_loading").show();
	//1회 최초실행
	var prmtDate;
	//조회날짜 최근, 지정날짜
	if($("#" + timeArea).find("input[type=checkbox]").is(":checked")){
		//Date 조각 합치기
		if(new Date(getWorldTime(-6).replace(/-/g,'/')) < new Date(dateCombine(timeArea).replace(/-/g,'/'))){
			alert("데이터가 없습니다.(현지시간기준)\n 최대 설정 가능 시간 : "+getWorldTime(-6));
			return false;
		}else{
			prmtDate = dateCombine(timeArea);
		}
	}else{
		//월드타임-6
		prmtDate = getWorldTime(-6);
	}
	//실행
	elasticDataSearch(prmtDate);
	
	//반복실행
	var playSec = parseInt($('#engSearch_repeat').val());
	try{
		clearInterval(playSubmit);
		//지정된 시간이 5초보다 적으면
		if(playSec >= 5){
			playSubmit  = setInterval(function(){	
				//조회날짜 최근, 지정날짜
				if($("#" + timeArea).find("input[type=checkbox]").is(":checked")){
					//Date 조각 합치기
					var SearchDate = dateCombine(timeArea);
					var SearchCalcDate = dateCalc(SearchDate,playSec);
					prmtDate = SearchCalcDate;
				}else{
					prmtDate = getWorldTime(-6);
				}
				
				//실행
				elasticDataSearch(prmtDate);
			}, (playSec * 1000));
		}else{
			alert("5초이상 설정하세요.");
		}
	}catch(err){
		alert("숫자만 입력하세요");
	}
}

//반복실행 중지
 function stopSubmit(){
	clearInterval(playSubmit);
	$("#search_loading").hide();
}
/*반복실행 관련 함수 종료*/
 
//한국시간 표시, 실행 시키기(최초 실행 시)
 function play_Search(){
	//한국시간 표시, 반복실행 실행시키기
	setInterval(function(){$("#kor_time").text(getWorldTime(9))}, 1000);
	startSearch('eng_Search');
}
 
//실행시키기
function startSearch(timeArea){
	var prmtDate;
	//조회날짜 최근, 지정날짜
	if($("#" + timeArea).find("input[type=checkbox]").is(":checked")){
		//Date 조각 합치기
		if(new Date(getWorldTime(-6).replace(/-/g,'/')) < new Date(dateCombine(timeArea).replace(/-/g,'/'))){
			alert("데이터가 없습니다.(현지시간기준)\n 최대 설정 가능 시간 : "+getWorldTime(-6));
			return false;
		}else{
			prmtDate = dateCombine(timeArea);
		}
	}else{
		//월드타임-6
		prmtDate = getWorldTime(-6);
	}
	//실행
	elasticDataSearch(prmtDate);
}

 function displayDate(search_date){
	//시간 표시하기
		var engSearch_TEMP = search_date.split(' ');
		//날짜
		$("#engSearch_DATE").datebox('setValue', engSearch_TEMP[0]);
		var engSearch_TIME = engSearch_TEMP[1].split(":");
		//시간
		$("#engSearch_HOUR").combobox('setValue',engSearch_TIME[0]);
		//분
		$("#engSearch_MIN").combobox('setValue',engSearch_TIME[1]);
		//초
		$("#engSearch_SEC").combobox('setValue',engSearch_TIME[2]);
		$("#trans_time").text(dateCalc(search_date,50400));
}