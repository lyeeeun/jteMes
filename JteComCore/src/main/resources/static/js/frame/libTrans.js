/**
 *  /Mes/lib/libTrans.js
 */

var libTrans = {};

/*******************************************************************************
 * 페이지로드시 최초실행. 
 *******************************************************************************/


window.onkeydown = function(event) {
	event = event || window.event;
	var kcode = event.keyCode;
	if (kcode == 8 /* || kcode == 116 */ || (kcode == 37 || kcode == 39) && event.altKey) { // 8(백스페이스), 116(F5), 37(<), 39(>) // PrintScreen과 Alt_TAB을 제외하고 모두 막을 수 있다.
		if(!(event.srcElement!=undefined&&event.srcElement!=null
				&&event.srcElement.readOnly!=undefined&&!event.srcElement.readOnly)){
			try{
				if(!+"\v1"){ // IE.11이하
					event.returnValue = 0;
					event.keyCode= 2;
				}else{ // IE.11 or Other...
					event.returnValue = false;
					event.keyCode= 2;
					event.preventDefault();
				}
			}catch(err){
				console.warn(JSON.stringify(err));
			}
		}
	}else if(kcode == 27){
		// ESC를 눌렀을때... 지정된 시각 이후에 로딩Process를 OFF 한다.
		setTimeout(function(){gfn_loading(false);}, 5000);
	}
};
// 뒤로가기를 금지시킨다.
// 뒤로가기 구현함수를 변경한다.
// window.history.backFn = window.history.back;
// window.history.back = function(){
history.pushState(null, document.title, location.href); // 현재 페이지를 추가해놓는다.
window.onPopstate = function(){
	history.pushState(null, document.title, location.href); // 현재 페이지를 추가해놓는다.
	// history.replaceState(null, document.title, location.href); // 현재 페이지를 교체한다.
	libTabs._fnMoveL(); // Tabs 메뉴에서는 뒤로가기를 왼쪽으로 로테이션 한다.
	return; // 2019.01.13 메뉴히스토리 구현은 의사결정 후 적용한다.(적용제외)
	if(libFrame.menuHistory.length<=1 || libFrame.menuHistIdx <= 0){
		// windows.history.backFn();
		// 아무것도 안한다.
		console.log("페이지이동을 막는다.");
	}else{
		--libFrame.menuHistIdx;
		// libFrame.menuHistory.pop(libFrame.menuHistory.length-1); // 현재 메뉴의 히스토리를 삭제하고...
		// var beforeMenuId = libFrame.menuHistory.pop(libFrame.menuHistory.length-1); // 이전 메뉴를 가져올때 삭제해줘야... 다시 열리면서 히스토리가 들어간다.
		var beforeMenuId = libFrame.menuHistory[libFrame.menuHistIdx];
		--libFrame.menuHistIdx; // 메뉴 호출 처리내에서 증가될 것이므로 뒤로가기시에는 한번더 --해준다.
		goMenuToBody(beforeMenuId
				, undefined // iCrm연동으로 들어오는케이스의 경우 정보를 전달해준다.
				, true // TR중이라도 강제로 메뉴를 연다.
				); // 기본화면정보(메뉴ID)가 있으면 해당 메뉴를 초기화면으로 열어준다.
	}
};
window.addEventListener('popstate', window.onPopstate);

/**
 * 서버에서 myInfo를 한번만 가져오고, 해당 서비스의 반환값으로 sessionUniqId를 받아온다.
 * 해당 값은 서버의 세션ID + "," + 유일한값 으로 구성되어 있다. 탭 별로 별도 제어하기 위해서 화면과 세션저장정보에서 사용한다.
 */
this.gfn_mySessionId = function(){
	if(libTabs._nowTabNum<0){
		return libUtil._myInfo.sessionUniqId + "," + libTabs._nowTabNum; // 2019.08.30 동일세션인 탭별로 별도제어를 가져오기 위한 동일창에 대한 브라우져 탭관리
	}else{
		return libUtil._myInfo.sessionUniqId + "," + libTabs._tabs[libTabs._nowTabNum].id; // 2019.08.30 동일세션인 탭별로 별도제어를 가져오기 위한 동일창에 대한 브라우져 탭관리
	}
}

libUtil._commonError401Fn = function(XMLHttpRequest, textStatus, errorThrown){
	var doNotChkUrls = [gfn_getUri("/common")/*, gfn_getUri("/common/message/getComMsg")*/]; // 401결과를 체크예외할 주소 시작부분들...
	var ajaxObj = this;
	if(XMLHttpRequest.status == 401 && doNotChkUrls.filter(function(data){return ajaxObj.url && ajaxObj.url.startsWith(data);}).length <= 0 ){
		$.showClosingMessage();
		var errMsgObj = {code:"401", title:"에러 ("+errorThrown+")" // 에러타이틀
			, detail : XMLHttpRequest.responseText // 에러상세메시지
			// , callback:function(data){window._isShowSessionExfireMessage = true;}
			, done:function(data){
				// window._isShowSessionExfireMessage = true;
				location.href = encodeURI(gfn_getUri("/login")); // document.referrer;
		}};
		if(typeof window._isShowSessionExfireMessage == "undefined"){
			if(typeof XMLHttpRequest === "object" && typeof XMLHttpRequest.responseJSON === "object" && typeof XMLHttpRequest.responseJSON.message === "string"){
				errMsgObj.msg = XMLHttpRequest.responseJSON["message"]; // 에러메시지
				errMsgObj.showMsg = XMLHttpRequest.responseJSON["showMsg"]; // 접근금지에 따른 화면 표현 불가 시 alert표시함.
			} else {
				// alert('로그인을 하지 않았거나 세션정보가 만료되었습니다! 다시 로그인을 하십시요!');
				errMsgObj.msg = '로그인을 하지 않았거나 세션정보가 만료되었습니다! 다시 로그인을 하십시요!'; // 에러메시지
			}
			window._isShowSessionExfireMessage = true;
			if(errMsgObj.showMsg=="true"){
				gfn_errBox(errMsgObj);
			}else{
				alert(errMsgObj.msg);
				location.href = encodeURI(gfn_getUri("/login")); // document.referrer;
			}
		} else {
			// errMsgObj.done(); // 이미 페이지만료 메시지가 떠있음. .... 알림없이 홈페이지로... (로그인전이면 자동으로 로그인창 이동함)
		}
	}else if(typeof ajaxObj.errorBiz == "function"){
		ajaxObj.errorBiz.apply(this,arguments);
	}
};
// 2019.12.13 동일세션인 탭별로 별도제어를 가져오기 위한 동일창에 대한 브라우져 탭관리
$.ajaxPrefilter(function(options, orginalOptions, jqXHR){
//	if(gfn_getUri("/")=="/om/"){
//		/*** typeOf options.data 를 이용하여 string, object, array 일때의 parameter에 따라 post로 값을 넣어주도록 한다. options.type도 체크한다. ***/
//		if(options.url.indexOf("?")>0){
//			options.url = options.url + "&_mySessionId=" + gfn_mySessionId();
//		}else{
//			options.url = options.url + "?_mySessionId=" + gfn_mySessionId();
//		}

		/************ 2019.10.04 모든 Ajax 호출에 대해서 401에러에 대해서만 error처리를 공통으로 하고, 이외의 경우만 BusinessError로 처리하게 해준다.. *****************/
		if(typeof options.error === "function"){
			options.errorBiz = options.error;
			options.error = libUtil._commonError401Fn;
		}
//	}
});
/*******************************************************************************
 * 로그인 성공시 최초 1회 실행 - 개발자 사용금지
 ******************************************************************************/
libUtil._initFirst = function(){
	
	// 탭 초기화
	libTabs._fnTabInit();

	$.ajax({
		url: gfn_getUri('/common/myInfo'),
		type:'GET',
		async: false, // true,
		success:function(data, statusText, xhr){
			libUtil._myInfo = data;
			
			// 2019.08.30 동일세션인 탭별로 별도제어를 가져오기 위한 동일창에 대한 브라우져 탭관리
			$.ajaxPrefilter(function(options, orginalOptions, jqXHR){
				if(gfn_getUri("/")=="/om/"){
					/*** typeOf options.data 를 이용하여 string, object, array 일때의 parameter에 따라 post로 값을 넣어주도록 한다. options.type도 체크한다. ***/
					if(options.url.indexOf("?")>0){
						options.url = options.url + "&_mySessionId=" + gfn_mySessionId();
					}else{
						options.url = options.url + "?_mySessionId=" + gfn_mySessionId();
					}

					/************ 2019.10.04 모든 Ajax 호출에 대해서 401에러에 대해서만 error처리를 공통으로 하고, 이외의 경우만 BusinessError로 처리하게 해준다.. *****************/
					if(typeof options.error === "function"){
						options.errorBiz = options.error;
						options.error = libUtil._commonError401Fn;
					}
				}
			});

			/*******************************************************************************
			 *  2019.07.05 보안성 검토에 의해서 Ajax로 가져오던 로그인사용자의 개인정보를 jsp화면으로 변경함.
			 *******************************************************************************/
			try{
				libUtil._myInfo.user.username = $("#_loginUserInfo #_loginUserUsername").val();
				libUtil._myInfo.user.name = $("#_loginUserInfo #_loginUserName").val();
				libUtil._myInfo.user.movTelNo = $("#_loginUserInfo #_loginUserMovTelNo").val();
				libUtil._myInfo.user.email = $("#_loginUserInfo #_loginUserEmail").val();
			}catch (e) {
				console.error(JSON.stringify(e));
			}
			
			/*******************************************************************************
			 * 공지성 알리미 중 강제팝업알림 / 일반팝업알림이 있으면 최초 로그인 시 
			 * 표시해준다.
			 * ㅇ. 강제팝업알림(FPOP) : 모든것에 우선하여 표시하고 확인/닫기를 누르기 전까지 다른 작업을 하지 못한다. - 한 개만 제공된다.
			 * ㅇ. 일반팝업알림 (POP) : 상단에 알림창이 뜨지만, 업무진행여부와는 관련없다.
			 *******************************************************************************/
			
			// 성공적으로 내 정보를 가져왔을때만 메뉴를 그린다.
			libFrame._displayMenu.call(window);
			if(typeof goMenuToBody == "function" && libUtil._myInfo.defMenu && typeof libUtil._myInfo.defMenu == "object" && libUtil._myInfo.defMenu.menuId){
				if(gfn_getMenu(libUtil._myInfo.defMenu.menuId)){
					goMenuToBody(libUtil._myInfo.defMenu.menuId
							, undefined // iCrm연동으로 들어오는케이스의 경우 정보를 전달해준다.
							, true // TR중이라도 강제로 메뉴를 연다.
							); // 기본화면정보(메뉴ID)가 있으면 해당 메뉴를 초기화면으로 열어준다.
				}else{
					// 메뉴권한이 없습니다.
					if(document.getElementById("menuPathNaviTop"))
						document.getElementById("menuPathNaviTop").innerHTML = "Mes / <span>Default</span>";
					gfn_msgBox({msg:"해당 메뉴 접근 권한이 없습니다."});
				}
			}else if(libUtil._myInfo.defMenu == null){
				gfn_msgBox({msg:"해당 메뉴 접근 권한이 없습니다."});
			}else if(typeof goMenuToBody == "function" && typeof libUtil._myInfo.defMenuId == "string" && gfn_getMenu(libUtil._myInfo.defMenuId)){
			
				goMenuToBody(libUtil._myInfo.defMenuId
						, undefined // 연동으로 들어오는케이스의 경우 정보를 전달해준다.
						, true // TR중이라도 강제로 메뉴를 연다.
						); // 기본화면정보(메뉴ID)가 있으면 해당 메뉴를 초기화면으로 열어준다.
			}else{
				if(document.getElementById("menuPathNaviTop"))
					document.getElementById("menuPathNaviTop").innerHTML = "Mes / <span>Default</span>";
			}
			
			/************ 2019.10.04 적용하지 않고 다른방법으로 처리하기로 함 ::: 타이머로 주기적으로 서버를 호출하여 정상적인 접속인지 확인한다. *****************/
//			libUtil._loginLifeChk = setInterval(function(){
//				$.ajax({url: this.gfn_getUri('/common/loginLifeChk'), data:{sessionId:this.gfn_mySessionId()}, success:function(data){console.log(data);}, error:function(xhr){
//					clearInterval(libUtil._loginLifeChk);
//					gfn_errBox({title:"로그인정보 확인불가", msg:"로그아웃 되었거나, 로그인이 만료되었습니다.\n로그인 페이지로 이동합니다."
//							, done:function(){
//								location.href = gfn_getUri('/login'); // location.reload();
//							}
//					});
//				}});
//			}, 10000);
			
		},
		error:function(){
			if(document.getElementById("menuPathNaviTop"))
				document.getElementById("menuPathNaviTop").innerHTML = "Mes / <span>Loading...Failed.</span>";
		}
	});

};


/*************************** Ajax기본값 설정 ***************************/
$.ajaxSetup({
	type:'POST',
	dataType:'json',
	async: true, // async: false,
	/*headers : {
		Accepts: "application/json; charset=utf-8",
		"Content-Type": "application/json; charset=utf-8" 
	},*/
	beforeSend :function(XMLHttpRequest){
//		if(this.async){
//			this.__loadingCloseTimer = setTimeout(function(){gfn_loading(false);clearTimeout(this.__loadingCloseTimer);}, 300000); // 5분후 실행.
			gfn_loading(true);
//		}
	},
	complete : function(data){
		// gfn_loading(false);
	},
	error:function(XMLHttpRequest, textStatus, errorThrown){
		
		$.showClosingMessage();
		if(XMLHttpRequest.status == 401){
			if(typeof window._isShowSessionExfireMessage == "undefined"){
				alert('로그인을 하지 않았거나 세션정보가 만료되었습니다! 다시 로그인을 하십시요!');
				window._isShowSessionExfireMessage = true;
			}
			var form = $("form").get(0);
			$(form).attr("target","_self");
			$(form).attr("action",location.href = encodeURI(gfn_getUri("/login")));
			$(form).submit();
		}else if(XMLHttpRequest.status == 701){
			var result = eval("(" + XMLHttpRequest.responseText + ")");
			libTrans._ajaxSetupError(result);
//		}if(XMLHttpRequest.status == 200 && textStatus == 'parsererror'){
//			// load for html
//			// XMLHttpRequest.responseText
		}else {
			// var result = eval("(" + XMLHttpRequest.responseText + ")");
			var result = {};
			try {
				result = JSON.parse(XMLHttpRequest.responseText);
			} catch (e) {
				console.error(e)
				result.code = XMLHttpRequest.status;result.message=XMLHttpRequest.statusText;result.trace=XMLHttpRequest.responseText;
			}
			libTrans._ajaxSetupError(result);
		}
	}
});
libTrans._ajaxSetupError = function(data){
	// 에러표시 화면을 alert과 공통으로 맞춘다.
	console.log(data["trace"]); // 개발자가 확인할 수 있게 개발자도구에서 보이게 한다.(PROD는 서버에서 보내지 않으므로 보이지 않는다.)
	gfn_errBox({
		msg:data["message"] + " (code:" + data["code"] + ")" // 에러메시지
		, title:"에러"//"에러["+data["code"]+"]" // 에러타이틀
		, detail:data["trace"] // 에러상세메시지
		, code:data["code"] // 에러코드
	});
	gfn_loading(false);
}

/********* ajax 콜백에서 다시 ajax를 실행하면 타지 않는다.(다중호출에서는 한번만 실행됨.) before에서 구현함.  **********/
//$(document).ajaxStart(function(event){
////	if(event && typeof event == "object"){
////		event.__loadingCloseTimer = setTimeout(function(){gfn_loading(false);clearTimeout(event.__loadingCloseTimer);}, 300000); // 5분후 실행.
//		gfn_loading(true);
////	}
//});
$(document).ajaxComplete(function(event, xhr, settings){
//	if(event && typeof event.__loadingCloseTimer == "number"){
//		clearTimeout(event.__loadingCloseTimer);
		gfn_loading(false);
//	}
});


libTrans._showOpenMessage = function(obj){
				if(obj == undefined){
					kendo.ui.progress($("body"), true);
				}else{
					kendo.ui.progress(obj, true);
				}
			};

libTrans._showClosingMessage = function(obj){
		    	if(obj == undefined){
		    		kendo.ui.progress($("body"), false);
		    	}else{
		    		kendo.ui.progress(obj, false);
		    	}
		    };