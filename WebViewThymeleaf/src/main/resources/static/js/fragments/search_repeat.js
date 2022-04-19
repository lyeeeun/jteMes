/*
 * 반복실행 관련 함수 시작(autoRefresh가 있는 경우) 
 */
//한국시간 표시, 반복실행 실행시키기
function play_repeat(){
	setInterval(function(){$("#kor_time").text(getWorldTime(9))}, 1000);
	startSubmit('eng_Search',true);
}

//Auto Refresh관련 --jkkim
var playSubmit;
function startSubmit(timeArea, isSession){
	$("#search_loading").show();
	//1회 최초실행
	var prmtDate;
	//세션여부체크
	if(sessionStorage.getItem("DATE") != null && isSession){
		$("#engSearch_CHECK").checkbox("check");
		prmtDate = sessionStorage.getItem("DATE");
	}else{
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
	}
	//세션 삭제 
	sessionStorage.removeItem("DATE");
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
				sessionStorage.removeItem("DATE");
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
/*
 * 반복실행 관련 함수 종료
*/

 /*
  * '일반'실행 관련 함수 시작(trendView, alarm종류)
 */
 function startSearch(){
	//한국시간 표시, 실행시키기
	setInterval(function(){$("#kor_time").text(getWorldTime(9))}, 1000);
	play_noRepeat('eng_Search', true);
}

//검색 버튼 눌렀을때(auto가 '없는' 경우) > 한국시간 표시, 실행 시키기
function play_noRepeat(timeArea, isSession){
	var prmtDate;
	//세션여부체크
	if(sessionStorage.getItem("DATE") != null && isSession){
		prmtDate = sessionStorage.getItem("DATE");
	}else{ 
		//Search영역 지정된 날자 검색
		if(dateValidation(timeArea)){
			//Date 조각 합치기
			if(new Date(getWorldTime(-6).replace(/-/g,'/')) < new Date(dateCombine(timeArea).replace(/-/g,'/'))){
				alert("데이터가 없습니다.(현지시간기준)\n 최대 설정 가능 시간 : "+getWorldTime(-6));
				return false;
			}else{
				prmtDate = dateCombine(timeArea);
			}
		}else{
			prmtDate = getWorldTime(-6);
		}
	}
	//세션 삭제 
	sessionStorage.removeItem("DATE");
	//실행
	elasticDataSearch(prmtDate);
}
/*
 * 일반실행 관련 함수 종료
 */

//Search영역 DATE 표시
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
	$("#trans_time").text(getWorldTime(-5));
	
	/*세션 설정
	1.체크박스가 존재하지 않는 경우 세션값 입력(DATE)
	2.체크박스가 존재하는 경우 체크되어 있어야지만 세션값 입력(DATE)*/
	if($("#engSearch_CHECK").length){
		if($("#engSearch_CHECK").checkbox("options")["checked"]){
			sessionStorage.setItem("DATE",search_date);
		}
	}else{
		sessionStorage.setItem("DATE",search_date);
	}
}