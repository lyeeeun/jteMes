/**
 *  /Mes/lib/libUtil.js
 */

var libUtil = {};


if (typeof String.prototype.startsWith != 'function') {
	String.prototype.startsWith = function(str) {
		if(!str)
			return false;
		return this.substring(0, str.length) === str;
	};
};
if (typeof String.prototype.endsWith != 'function') {
	String.prototype.endsWith = function(str) {
		if(!str)
			return false;
		return this.substr(str.length * -1) === str;
	};
};

/** 배열에서 중복된 element는 삭제하고 반환한다. **/
this.gfn_rmDupArr = function(args){
	if(args && typeof args === "object" && args.constructor === Array && args.length !== 0){
		var result = new Array();
		for (var i in args) {
			if(result.filter(function(value){return value == args[i]}).length<=0){
				result.push(args[i]);
			}
		}
		return result;
	}else{
		return args;
	}
}

/** 서버 URI 제공 **/
this.gfn_getUri = function(bizUri){
		// return (document.location.pathname + "/" + bizUri).replace(/[^://]\/\//g, "/");  // biz화면 기본URL
		return (document.location.pathname + "/" + bizUri)
				.replace(/\/\/\//g, function(arg){return arg.replace("//","/")})
				.replace(/[^:\/\/]\/\//g, function(arg){return arg.replace("/","")})
				.replace(/[^:\/\/]\/\//g, function(arg){return arg.replace("/","")})
				.replace(":///", "://").replace("//", "/").replace("/login/", "/").replace("/main.do/", "/").replace("/main/", "/").replace("/home.do/", "/").replace("/home/", "/").replace("/tabMain.do/", "/").replace("/tabMain/", "/");  // biz화면 기본URL
};

/** 로그인된 사용자 정보 제공 **/
this.gfn_getMyInfo = function(id){
	return gfn_objCopy(libUtil._myInfo.user);
};

/** 로그인된 사용자의 메뉴정보 제공 **/
this.gfn_getMenu = function(menuId){
	if(typeof menuId == "string" || typeof menuId == "number"){
		var menu = libUtil._myInfo.menu.filter(function(menu){return menu.menuId == menuId+""});
		if(menu.length>=1)
			return gfn_objCopy(menu[0]);
		menu = libUtil._myInfo.menu.filter(function(menu){return menu.svcUrl == menuId+""});
		if(menu.length>=1)
			return gfn_objCopy(menu[0]);
		menu = libUtil._myInfo.menu.filter(function(menu){return menu.svcUrl && menu.svcUrl.replace(/\//,"").replace(/(\/[a-z])/g, function(arg){return arg.toUpperCase().replace('/','');}) == menuId+""});
		if(menu.length>=1)
			return gfn_objCopy(menu[0]);
		return null;
	}
	return menuId; // gfn_objCopy(libUtil._myInfo.menu);
}

/** 권한을 가지고 있는지 체크 **/
this.gfn_hasAuth = function(permission){
	if(permission && libUtil._myInfo && libUtil._myInfo  && libUtil._myInfo.myAuthIds  && libUtil._myInfo.myAuthIds.length > 0)
		for (var i = 0; i < libUtil._myInfo.myAuthIds.length; i++)
			if(permission == libUtil._myInfo.myAuthIds[i])
				return true;
	return false;
};

/** 그룹코드ID로 코드리스트를 가져온다. 두번째 인수가 주어질 경우 해당 그룹내에서 코드ID를 검색하여 해당 코드정보만 반환한다. **/
this.gfn_getCode = function(grpId){
	var codeId = arguments[1];
	var codeList = null;
	if(!gfn_isNull(grpId)){
		if(gfn_isNull(libUtil.__arrCodeCache)){
			libUtil.__arrCodeCache = new Array();
		}
		if(typeof grpId == "number") grpId += "";
		for(var i = 0 ; i<libUtil.__arrCodeCache.length; i++){
			if(libUtil.__arrCodeCache[i].cdId==grpId){
//				var result = [];
//				for(var j=0; j<libUtil.__arrCodeCache[i].subComnCodeList.length; j++){
//					result = result.concat([{code:libUtil.__arrCodeCache[i].subComnCodeList[j].code, name:libUtil.__arrCodeCache[i].subComnCodeList[j].name, descSbst:libUtil.__arrCodeCache[i].subComnCodeList[j].descSbst}]);
//				}
//				return result;
				if(typeof libUtil.__arrCodeCache[i].cacheSaveTime == "number" && new Date().getTime() > libUtil.__arrCodeCache[i].cacheSaveTime + libUtil._cacheTimeout /*1 * 60 * 60 * 1000*/){
					// 저장시간이 없거나, 캐쉬저장시간이 만료된 경우 다시 가져온다.
					libUtil.__arrCodeCache.splice(i,1); // 해당코드그룹을 삭제.
					break;
				}
				if(gfn_isEmpty(libUtil.__arrCodeCache[i].subComnCodeList)){//하위코드가 없는 경우 입력코드의 정보를 반환한다. jkkim 2020-03-27
					return gfn_objCopy(libUtil.__arrCodeCache[i]);
				}else{
					if(codeId){
						return gfn_objCopy(libUtil.__arrCodeCache[i].subComnCodeList.filter(function(codes){return codes.cdId == codeId+""}))[0];
					}else{
						return gfn_objCopy(libUtil.__arrCodeCache[i].subComnCodeList);
					}
				}
				
			}
		}
		$.ajax({async: false, url: this.gfn_getUri('/common/code/get'), data:{code:grpId}, error:function(data){console.warn(grpId+"그룹의 코드정보 요청이 실패해도 에러는 표시하지 않는다.\n"+JSON.stringify(data));}
				, success:function(data){
					if(data && data.result && typeof data.result == "object"){
						data.result.cacheSaveTime = new Date().getTime();
						libUtil.__arrCodeCache.push(data.result);
						if(gfn_isEmpty(data.result.subComnCodeList)){//하위코드가 없는 경우 입력코드의 정보를 반환한다. jkkim 2020-03-27
								codeList = gfn_objCopy(data.result);
						}else{
							if(codeId){
								/******** 두번째 인수가 주어진 경우 그룹리스트 내에서 해당 코드만 추출하여 반환한다. ********/
								codeList = gfn_objCopy(data.result.subComnCodeList.filter(function(codes){return codes.cdId == codeId+""}))[0];
							}else{
								codeList = gfn_objCopy(data.result.subComnCodeList);
							}
						}
					}else{
						console.warn(grpId+" 코드가 없음");
					}
		}});
	}
	return codeList;
};

/** 공유데이터 In/Out = KEY로 제어한다. **/
this.gfn_setSharedData = function(key, data){
	// console.debug(arguments.callee.toString().split(" get")[1].split("(")[0]); // getter Name 찾기
	// console.debug(arguments.callee.toString().split(" set")[1].split("(")[0]); // setter Name 찾기
	if(libUtil._shareData[key]){
		console.warn("Already exist data! Are you overwrite? - Just comment...")
	}
	libUtil._shareData[key] = data;
};
/** 공유데이터 In/Out = KEY로 제어한다. 가져올 데이터가 없을 경우 초기셋팅값이 있으면 넣어서 저장해준다.**/
this.gfn_getSharedData = function(key){
	return libUtil._shareData[key];
};

/** 공통 메시지박스 **/
this.gfn_msgBox = function(msg, var0, var1, var2, var3){
	var options = msg;
	if(typeof msg != "object"){
		// options = {msg:msg,title:title,detail:detail,code:code};
		if(gfn_getComMsg(msg)) msg = gfn_getComMsg.apply(this,arguments);
		var body = msg; // "["+code+"] "+title+"\n\n" + msg + "\n----------------------------\n" + detail;
		alert(body);
	}else{
		if(gfn_getComMsg(options.msg)) options.msg = gfn_getComMsg.apply(this,arguments);
		if(!options.title){
			options.title = gfn_getMsg("pop_notice");			//알림
		}
		options.typeCd="I";
		__gfn_allMsgBox(options);
	}
};

/** 공통 에러박스 **/
this.gfn_errBox = function(msg, var0, var1, var2, var3){
	var options = msg;
	if(typeof msg != "object"){
		// options = {msg:msg,title:title,detail:detail,code:code};
		if(gfn_getComMsg(msg)) msg = gfn_getComMsg.apply(this,arguments);
		var body = msg; // "["+code+"] "+title+"\n\n" + msg + "\n----------------------------\n" + detail;
		alert(body);
	}else{
		if(gfn_getComMsg(options.msg)) options.msg = gfn_getComMsg.apply(this,arguments);
		if(!options.title){
			options.title = gfn_getMsg("pop_notice");			//알림
		}
		options.typeCd="E";
		__gfn_allMsgBox(options);
	};
};

/** 공통 경고 박스 **/
this.gfn_warnBox = function(msg, var0, var1, var2, var3){
	var options = msg;
	if(typeof msg != "object"){
		// options = {msg:msg,title:title,detail:detail,code:code};
		if(gfn_getComMsg(msg)) msg = gfn_getComMsg.apply(this,arguments);
		var body = msg; // "["+code+"] "+title+"\n\n" + msg + "\n----------------------------\n" + detail;
		alert(body);
	}else{
		if(gfn_getComMsg(options.msg)) options.msg = gfn_getComMsg.apply(this,arguments);
		if(!options.title){
			options.title = gfn_getMsg("pop_notice");			//알림
		}
		options.typeCd="W";
		__gfn_allMsgBox(options);
	};
};

/** 공통 Confirm박스 **/
this.gfn_conBox = function(msg, var0, var1, var2, var3){
	var options = msg;
	if(typeof msg != "object"){
		// options = {msg:msg,title:title,detail:detail,code:code};
		if(gfn_getComMsg(msg)) msg = gfn_getComMsg.apply(this,arguments);
		var body = msg; // "["+code+"] "+title+"\n\n" + msg + "\n----------------------------\n" + detail;
		if(confirm(body)){
			return true;
		}else{
			return false;
		}
	}else{
		if(gfn_getComMsg(options.msg)) options.msg = gfn_getComMsg.apply(this,arguments);
		if(!options.title){
			options.title = gfn_getMsg("pop_confirm");			//확인
		}
		options.typeCd="Q";
		__gfn_allMsgBox(options);
	}
};

/** 공통 Dialog박스 **/
this.gfn_dialBox = function(msg, var0, var1, var2, var3){
	var options = msg;
	if(typeof msg != "object"){
		// options = {msg:msg,title:title,detail:detail,code:code};
		if(gfn_getComMsg(msg)) msg = gfn_getComMsg.apply(this,arguments);
		var body = msg; // "["+code+"] "+title+"\n\n" + msg + "\n----------------------------\n" + detail;
		return prompt(body);
	}else{
		if(gfn_getComMsg(options.msg)) options.msg = gfn_getComMsg.apply(this,arguments);
		if(!options.title){
			options.title = gfn_getMsg("pop_confirm");			//확인
		}
		options.typeCd="P";
		__gfn_allMsgBox(options);
	}
};

this.__gfn_allMsgBox = function(options){
	options.url = "/common/popup/comPopup";
	options.width = "300px";
	options.height = "200px";
	options.resizable = false;
	options.modal = true;
	options.animation  = {open :{effects:"expand:vertical fadeIn"},close :{effects:"expand:vertical fadeIn", reverse: true}};
	options.visible = false;
	options.actions = [/*"Minimize", "Maximize", */"Close"];
	options.id = "_comn_popup_layer";
	options.closeCallback =function(data){
		if(typeof data != "object") return;
		var callObj = this;
		if(data.result=="NO" && typeof data.no == "function"){
			gfn_loading(true);
			setTimeout(function(){gfn_loading();data.no.call(callObj, data);}, 100);
		}else if((data.result=="YES" || data.typeCd=="P") && typeof data.yes == "function"){
			gfn_loading(true);
			setTimeout(function(){gfn_loading();data.yes.call(callObj, data);}, 100);
		}
		if(typeof data.done == "function"){
			gfn_loading(true);
			setTimeout(function(){gfn_loading();data.done.call(callObj, data);}, 100);
		}
	};
	if(gfn_getComMsg(options.title)){
		options.title = gfn_getComMsg.call(this,options.title);
	}
	if(!options.title){
		options.title = gfn_getMsg("pop_notice");			//알림
	}else if(options.code){
		options.title += " [" + options.code + "]"
	}
	switch (options.typeCd) {
		case 'E':{
			options.width = "500px";
			if(options.detail){
				options.height = 202;
			}else{
				options.height = 175;
			}
			options.title = {encoded:false, text:"<i class='fas fa-exclamation-circle' style='color:red;'></i> 에러"};
			break;
		}
		case 'W':{
			options.width = "500px";
			if(options.detail){
				options.height = 202;
			}else{
				options.height = 175;
			}
			options.title = {encoded:false, text:"<i class='fas fa-exclamation-triangle' style='color:#f77830;'></i> 경고"};
			break;
		}
		case 'Q':{ 
			options.width = "500px";
			options.height = 175;
			break;
		}
		case 'P':{
			options.width = "500px";
			options.height = 190;
			break;
		}
		default: { // like 'I'
			options.width = "500px";
			options.height = 175;
			break;
		}
	}
	if(document.location.pathname!="/main" && document.location.pathname!="/main/"){
		options.height += 20;
	}
	options.height += "px";
	gfn_winOpen(options);
};

/** modal로딩 프로세스 **/
this.gfn_loading = function(isView,targetIdClassObj,title,msg){
	//함수 호출 시 isView 파라미터만 사용됨.. PGW
	var targetObj = $("#mainBody");
	
	if(typeof targetIdClassObj == "object"){
		targetObj = targetIdClassObj;
	}else if(typeof targetIdClassObj == "string"){
		if($("#" + targetIdClassObj).length>=1){
			targetObj = $("#" + targetIdClassObj);
		}else if($("." + targetIdClassObj).length>=1){
			targetObj = $("." + targetIdClassObj);
		}
	}
	// jQuery 3.x에서부터 미지원됨 : if(!targetObj.length && typeof targetObj.selector!="string" || targetObj.selector == "#mainBody"){ // 대상이 존재하지 않거나, 단순 Object면 전체 Body 를 대상으로 progress를 그린다.
	if(!targetObj.length && typeof targetObj!="object" || !gfn_isEmpty(targetObj) && typeof targetObj.attr == "function" && targetObj.attr("id") == "mainBody"){ // 대상이 존재하지 않거나, 단순 Object면 전체 Body 를 대상으로 progress를 그린다.
		/*******************************************************************************************************************
		 * 화면전체를 대상으로 프로세스바를 그린다. 최종 지워질땐 하위영역의 div에 걸린 프로세스바도 삭제된다.
		 *******************************************************************************************************************/
		if(!targetObj.length || targetObj.attr("id") != "mainBody"){ 
			targetObj = $("body");
		}
		if(!libUtil.__loadingDepthCount){
			libUtil.__loadingDepthCount = 0;
		}
		if(isView==true){ // 처리 프로시저를 isView기준으로 토글한다.
			++libUtil.__loadingDepthCount;
			//console.warn(" *********** LoadingProcess for Body... DepthCount PLUS ++ : " + libUtil.__loadingDepthCount);
			kendo.ui.progress(targetObj, true); // 처리 프로세스 보여주고 modal처리 한다.
			return libUtil.__loadingDepthCount;
		}else{
			--libUtil.__loadingDepthCount;
			//console.warn(" *********** LoadingProcess for Body... DepthCount MINUS -- : " + libUtil.__loadingDepthCount);
			if(libUtil.__loadingDepthCount<=0){
				libUtil.__loadingDepthCount = 0;
				kendo.ui.progress(targetObj, false); // 처리 프로세스를 hide한다.
				// 모든 하위 progress가 삭제되므로 하위 progress의 depthCount를 0로 처리한다.(그냥 삭제하면 됨.)
				delete libUtil.__loadingDepthCountForChild;
			}
			return libUtil.__loadingDepthCount;
		}
	}
	
	//targetIdClassObj가 Undefined로 들어올 경우 libUtil.__loadingDepthCount를 return한다. _PGW
	if(!libUtil.__loadingDepthCountForChild){
		libUtil.__loadingDepthCountForChild = new Array();
	}
	if(!libUtil.__loadingDepthCountForChild[targetObj.attr("id")]){
		libUtil.__loadingDepthCountForChild[targetObj.attr("id")] = 0;
	}
	
	if(isView==true){
		++libUtil.__loadingDepthCountForChild[targetObj.attr("id")];
		//console.warn(" *********** LoadingProcess for Child["+targetObj.attr("id")+"]... DepthCount PLUS ++ : " + libUtil.__loadingDepthCountForChild[targetObj.attr("id")]);
		kendo.ui.progress(targetObj, true); // 처리 프로세스 보여주고 modal처리 한다.
		return libUtil.__loadingDepthCountForChild[targetObj.attr("id")];
	}else{
		--libUtil.__loadingDepthCountForChild[targetObj.attr("id")];
		//console.warn(" *********** LoadingProcess for Child["+targetObj.attr("id")+"]... DepthCount MINUS -- : " + libUtil.__loadingDepthCountForChild[targetObj.attr("id")]);
		if(libUtil.__loadingDepthCountForChild[targetObj.attr("id")]<=0){
			libUtil.__loadingDepthCountForChild[targetObj.attr("id")] = 0;
			kendo.ui.progress(targetObj, false); // 처리 프로세스를 hide한다.
			// 모든 하위 progress가 삭제되므로 하위 progress의 depthCount를 0로 처리한다.
		}
		return libUtil.__loadingDepthCountForChild[targetObj.attr("id")];
	}
	
//	// 처리 프로시저를 isView기준으로 토글한다.
//	if(isView==true){
//		// 처리 프로세스 보여주고 modal처리 한다.
//		++libUtil.__loadingDepthCount;
//		console.warn(" *********** LoadingProcess DepthCount PLUS : " + libUtil.__loadingDepthCount);
//		$.showLoadingMessage(targetObj);
//	}else{
//		--libUtil.__loadingDepthCount;
//		console.warn(" *********** LoadingProcess DepthCount MINUS : " + libUtil.__loadingDepthCount);
//		if(libUtil.__loadingDepthCount<=0){
//			libUtil.__loadingDepthCount = 0;
//			// 처리 프로세스를 hide한다.
//			$.showClosingMessage(targetObj);
//		}
//	}
//	return libUtil.__loadingDepthCount;
};

/** 바인딩 함수에 대한 로컬Scope를 보장하여 실행. **/
this.gfn_callFn = function(){
	if(arguments.length>0){
		return eval("libFrame._FRAME[libTabs._nowTabName]."+arguments[0]+".apply(libFrame._FRAME[libTabs._nowTabName], gfn_arrCopy(arguments).slice(1))");
	}
};

/** 해당 tabId(화면ID=code/listForm)가 로딩되었는지 체크 **/
this.gfn_isExistTab = function(tabId){
	tabId=tabId.replace(/\//,"").replace(/(\/[a-z])/g, function(arg){return arg.toUpperCase().replace('/','');});
	return libFrame._FRAME[tabId]
};

/** 메시지 코드로 메시지를 가져온다. 
 *  2019.08.28 : Spring의 messageSourceAccessor에서 먼저 가져오며, 존재하지 않거나, 실패할 경우 기존방식인 static에서 다운로드 받아 사용한다.
 */
this.gfn_getMsg = this.gfn_getComMsg = function(){
	if(arguments.length<=0) return;
	var params = gfn_arrCopy(arguments);
	var result = null;
	try {
		if(!libUtil._MESSAGE_SRC){
			libUtil._MESSAGE_SRC = {};
		}
		var key = params[0];
		if(gfn_isObject(key)){
			key = key.msg; // 첫인수가 Object인경우 msg키만 추출하여 key로 사용한다.
		}
		if(gfn_isArray(key)){
			for(var index=1;index<key.length;index++){
				params.splice(1, 0, key[index]); // 첫인수가 Array인 경우 0번 인덱스는 msg키로, 이외에는 파라메터로 사용한다.
			}
			key = key[0];
		}
		if(gfn_isEmpty(key)){
			return result;
		}
		result = libUtil._MESSAGE_SRC[key];
		if(gfn_isEmpty(result)){
			// params.splice(0,1); // 배열 첫번째 요소 삭제.
			$.ajax({async:false, url: gfn_getUri("/common/msg/getComMsg"), data:{code:key, /*params:params,*/ def:params[1]}
			, success:function(data){
				if(!gfn_isEmpty(data)&&!gfn_isEmpty(data.value)){
					result = data.value;
					libUtil._MESSAGE_SRC[data.key] = data.value;
				}
			}, error:function(xhr){
				console.warn(xhr);
			},complete:function(){}});
		}
		/*if(result && result.split("&").length>1){
			result = result.split("&")[1];
		}
		for (var i = 0; i < params.length - 1; i++) {
			result = result.split("{"+i+"}").join(params[i+1]);
		}*/
		return result;
	} catch (e) {
		console.warn(e);
	}
	return result;
};

/** 다양한 날자 오브젝트를 반환한다. **/
this.gfn_getDate = function(){
	var args = gfn_arrCopy(arguments);
	var workCd = "TO_DATE";
	var dateStd = new Date();
	var dateTgt = dateStd;
	var dateFar = 0;
	var dateFarCd = 'D';
	var dateFormat = 'yyyy-MM-dd HH:mm:ss.SSS';
	var weekName = [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ];
	try {
		switch (args.length) {
		case 1:
			if(typeof args[0] == "string"){
				if(/^[0-9]*$/.test(args[0])){
					var year = dateStd.getFullYear()
					, month = ("0" + (dateStd.getMonth() + 1)).substr(-2)
					, day = ("0" + dateStd.getDate()).substr(-2)
					, hour = ("0" + dateStd.getHours()).substr(-2)
					, minte = ("0" + dateStd.getMinutes()).substr(-2)
					, second = ("0" + dateStd.getSeconds()).substr(-2)
					, mill = ("00" + dateStd.getMilliseconds()).substr(-3);
					try {
						args[0]+="0000000000000000000";
						year = args[0].substr(0,4);
						month = args[0].substr(4,2) - 1;
						day = args[0].substr(6,2);
						hour = args[0].substr(8,2);
						minte = args[0].substr(10,2);
						second = args[0].substr(12,2);
						mill = args[0].substr(14,2);
					} catch (e) {
						console.error(e);
					}
					dateStd = new Date(year,month,day,hour,minte,second,mill);
					workCd = "TO_DATE";
				}else if(/^[-:_. TZ0-9]*$/.test(args[0])){
					if(args[0].indexOf(' ')>=4){
						args[0] = args[0].substring(0, args[0].indexOf(' ')) + 'T' + args[0].substring(args[0].indexOf(' ')+1);
					}
					// 시분초 지정도 정의할것.
					dateStd = new Date(args[0]);
					workCd = "TO_DATE";
				}else {
					dateFormat = args[0];
					workCd = "TO_FORMAT";
				}
			}else if(typeof args[0] == "number"){
				/*현재날짜로부터 day차이를 구한다.*/ // return this.gfn_getDate(new Date(), "D", args[0]);
				dateFar = args[0];
				workCd = "DAY_FAR";
			}else if(typeof args[0] == "object" && typeof args[0].getTime == "function"){ // Date Object
				// 미정의....
				dateStd = new Date(args[0]);
			}
			break;
		case 2:
			if(typeof args[0] == "object" && typeof args[0].getTime == "function"){ // 첫번째 인수가 Date
				if(typeof args[1] == "string"){ // 두번째 인수가 문자열
					workCd = "TO_FORMAT";
					dateStd = new Date(args[0]);
					dateFormat = args[1];
				}else if(typeof args[1] == "number"){
					workCd = "DAY_FAR";
					dateStd = new Date(args[0]);
					dateFar = args[1];
				}else if(typeof args[1] == "object" && typeof args[1].getTime == "function"){
					workCd = "DAY_GAP";
					dateStd = new Date(args[0]);
					dateTgt = new Date(args[1]);
				}
				break;
//			}else if(typeof args[0] == "string" && typeof args[1] == "string"){
//				workCd = "TO_FORMAT";
//				dateStd = new Date(args[0]);
//				dateFormat = args[1];
//				break;
//			}else if(typeof args[0] == "number"){ // yyyy|yy|MM|dd|E|HH|hh|mm|SSS|ss|a\/p
//				if(typeof args[1] == "string" && /^[YMDEHSadhmpsy :-_.\/]*$/.test(args[1])){ // 두번째 인수가 문자열
//					workCd = "TO_FORMAT";
//					dateStd = new Date(args[0]);
//					dateFormat = args[1];
//					break;
//				}
			}
			return this.gfn_getDate(new Date(), args[0], args[1]);
//			if(args[0].length==1)
//				return this.gfn_getDate(new Date(), args[0], args[1]);
//			var dayCnt = 24 * 60 * 60 * 1000;
//			return parseInt( parseInt(new Date(args[0]) - new Date(args[1])) / dayCnt )
		case 3:
			if(typeof args[0] == "object" && typeof args[0].getTime == "function"){ // 첫번째 인수가 Date
				dateStd = new Date(args[0]);
				if(typeof args[1] == "string"){ // 두번째 인수가 문자열
					if(typeof args[2] == "number"){ // 세번째 인수가 숫자형
						workCd = "DAY_FAR";
						dateFarCd = args[1];
						dateFar = args[2];
					}
				}else if(typeof args[1] == "number"){ // 두번째 인수가 숫자형
					if(typeof args[2] == "string"){ // 세번째 인수가 문자열
						workCd = "TO_FORMAT";
						dateStd = this.gfn_getDate(dateStd, args[1]);
						dateFormat = args[2];
					}
				}
				break;
			}
//			var date = new Date(args[0]);
//			if(args[1]=='d'||args[1]=='D'){
//				return new Date(date.getTime() + (args[2] * 1 * 24 * 60 * 60 * 1000));
//			}else if(args[1]=='m'||args[1]=='M'){
//				var newMonth = (date.getMonth() + (args[2] * 1));
//				var addYear = parseInt(newMonth/12);
//				newMonth %= 12;
//				if(newMonth<=0){
//					newMonth+=12;
//					addYear--;
//				}
//				return new Date(date.getFullYear()+addYear + "-" + newMonth + "-" + date.getDate());
//			}else if(args[1]=='y'||args[1]=='Y'){
//				return new Date((date.getFullYear() + (args[2] * 1)) + "-" + date.getMonth() + "-" + date.getDate());
//			}else{
//				
//			}

		default:
			break;
		}
		
		
		switch (workCd) {
		case "TO_DATE":
			return dateStd;
		case "TO_FORMAT":
			var result = dateFormat.replace(/(yyyy|yy|MM|dd|E|HH|hh|mm|SSS|ss|a\/p)/gi, function($1) {
				switch ($1) {
				case "yyyy": return dateStd.getFullYear();
				case "yy": return ("0" + (dateStd.getFullYear() % 1000)).substr(-2);
				case "MM": return ("0" + (dateStd.getMonth() + 1)).substr(-2);
				case "dd": return ("0" + dateStd.getDate()).substr(-2);
				case "E": return weekName[dateStd.getDay()];
				case "HH": return ("0" + dateStd.getHours()).substr(-2);
				case "hh": return ("0" + ((h = dateStd.getHours() % 12) ? h : 12)).substr(-2);
				case "mm": return ("0" + dateStd.getMinutes()).substr(-2);
				case "ss": return ("0" + dateStd.getSeconds()).substr(-2);
				case "SSS": return ("00" + dateStd.getMilliseconds()).substr(-3);
				case "a/p": return dateStd.getHours() < 12 ? "오전" : "오후";
				default: return $1;
				}
			});
			return result;
		case "DAY_GAP": // 날짜 차이를 구한다.
			return parseInt( parseInt(dateTgt.getTime() - dateStd.getTime()) / (24 * 60 * 60 * 1000) );
		case "DAY_FAR": // 날짜로부터 차이만큼의 날짜를 구한다.
			switch (dateFarCd) {
			case "D":case "d": // 기준날자부터 날짜차이를 구한다.
				return new Date(dateStd.getTime() + (dateFar * 1 * 24 * 60 * 60 * 1000));
			case "M":case "m": // 기준날자부터 월차이를 구한다.
				var newMonth = (dateStd.getMonth() + (dateFar * 1));
				var addYear = parseInt(newMonth/12);
				newMonth %= 12;
				if(newMonth<=0){
					newMonth+=12;
					addYear--;
				}
				return new Date(dateStd.getFullYear()+addYear + "-" + newMonth + "-" + dateStd.getDate());
			case "Y":case "y": // 기준날자부터 연도차이를 구한다.
				return new Date((dateStd.getFullYear() + (dateFar * 1)) + "-" + dateStd.getMonth() + "-" + dateStd.getDate());
			default:
				break;
			}
			break;

		default:
			return dateStd;
		}
	} catch (e) {console.error(e);gfn_errBox({msg:"날짜변환 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.", detail:JSON.stringify(e)});}
	return dateStd;
};

/** 자바스크립트단에서 로그아웃하고 로그인창으로 이동 **/
this.gfn_sessionLogout = function(){
	gfn_logout();
};

/** 자바스크립트단에서 로그아웃하고 로그인창으로 이동 **/
this.gfn_logout = function(){
	$.ajax({
		url: "/form/basMgt/devtol/userConn/setUserConn",
		type:'POST',
		data: JSON.stringify({userId : "jkkim",connId : $("#_loginSessionId").val(),action : "U"}),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success:function(data){
			location.href = gfn_getUri('/logout');
		},error:function(ex){
			console.log(ex);
		}
	});
};

/** 정보수정창 **/ /**20.08.04 JJW 수정**/
this.gfn_myConfigMod = function(){
	var options = {
		modal:true, 
		width: "450px", 
		height: "200px", /*원래 350, 230*/
		id:"jteConfigForm", 
		title:"", 
		workCd:"", 
		bdSeq:"",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	options.callback = function(){
		var selBoxItem = gfn_getCode($("#t_langCd").attr("msg"));
		$("#t_langCd").kendoDropDownList({
			dataSource: selBoxItem,
			dataValueField: "cdVal",
			valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"
				+ "#= item #",
			template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"
				+ "#= item #"
		});
		$("#t_langCd").data("kendoDropDownList").select(function(dataItem) {
				return dataItem.cdVal === $("#_loginUserLang").val();
		});
		$("#t_passwordYN").change(function(e){
			if($("#t_passwordYN").is(":checked")){
				$(".jteConfigFomr_pwZone").show();
				gfn_resizePop('jteConfigForm',{width : 450, height:330}); /*원래 510, 290*/
			}else{
				$(".jteConfigFomr_pwZone").hide();
				gfn_resizePop('jteConfigForm',{width : 450, height:200}); /*원래 350, 230*/
			}
		});
	}
	this.gfn_winOpen(options);	
};
this.gfn_myConfigSave = function(formID){
	var prmtObj ={};
	var formObj = $("#"+formID).serializeObject();
	prmtObj={
		'userId' : $("#_loginUserId").val(),
		'langCd' : formObj.langCd,
		'action' : 'MYCFG'
	}
	if($("#t_passwordYN").is(":checked")){
		prmtObj.passwordPrev =formObj.passwordPrev;
		prmtObj.password =formObj.password;
		
		var pwdPtn = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}/;
		
		if(!pwdPtn.test(formObj.password)){
			alert(gfn_getMsg("pop_pwLetterChar"));			//패스워드는8~16글자 특수문자 1글자 이상 포함되어야 합니다.
			$("#t_password").focus();
			return false;
			
		}else if(formObj.password != formObj.passwordCheck){
			alert(gfn_getMsg("pop_pwMismatch"));			//패스워드가 일치하지 않습니다.
			$("#t_password").focus();
			return false;
		}
	}
	
	$.ajax({
		async:false,
		url : "/form/basMgt/userMgt/userInfo/setUserSave",
		type: "POST",
		data: JSON.stringify(prmtObj),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data > 0){
				gfn_closePop(formID);
				gfn_msgBox({msg :  gfn_getMsg("pop_successReLogin", "성공하였습니다. 다시 로그인해 주세요.")});				//성공하였습니다. 다시 로그인해 주세요.
			}else{
				gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});				//성공적으로 삭제되었습니다.
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

/** Object Copy **/
this.gfn_objCopy = function (obj){
	if(typeof obj=="object" && typeof obj.getTime == "function"){
		return new Date(obj);
	}
	var result = JSON.parse(JSON.stringify(obj));
//	if(typeof obj == "object"){
//		for ( var key in obj) {
//			if(typeof obj[key] == "function"){
//				result.key = obj[key];
//			}
//		}
//	}
	return result;
};
/** Array Copy **/
this.gfn_arrCopy = function (arr, start, end){
	var result = [];
	try {
		if(start!=0 && !start) start=0;
		if(end!=0 && !end) end=arr.length;
		for (var i = start; i < end; i++) {
			result.push(gfn_objCopy(arr[i]));
		}
	} catch (e) {
		console.error(e);
		return null;
	}
	return result;
};

this.gfn_isObj = this.gfn_isObject = function(checkValue) {
	return (checkValue !== null && typeof checkValue === "object" && checkValue.constructor === Object);
};
this.gfn_isArr = this.gfn_isArray = function(checkValue) {
	return (checkValue !== null && typeof checkValue === "object" && checkValue.constructor === Array);
};
/** null or empty value is return true **/
this.gfn_isEmpty = this.gfn_isNull = function(checkValue) {
	return (checkValue === null
			|| typeof checkValue === "undefined"
			|| (typeof checkValue === "string" && checkValue === "")
			|| (checkValue && typeof checkValue === "object" && checkValue.constructor === Array && checkValue.length === 0)
			|| (checkValue && typeof checkValue === "object" && checkValue.constructor === Object && Object.keys(checkValue).length === 0)
			)
};

/** isNull to defValue(Defalut "") **/
this.gfn_nvl = function(checkValue, defValue) {
	defValue = (arguments.length === 2 && typeof defValue !== "undefined") ? defValue : "";
	return gfn_isEmpty(checkValue) ? defValue : checkValue;
};

/** 문자열 바이트단위로 길이계산 : 두번째 인수는 ascii이외의 문자를 몇자리씩으로 읽을지의 수치임 **/
this.gfn_chkByteLen = function(chr, charset){
	charset = gfn_isNull(charset) ? "MS949" : charset;
	var b, i, c, charSize=2;
	if(typeof charset == "number")
		charSize = charset;
	switch ((charset+"").toUpperCase()) {
	case "UTF8":case "UTF-8":case "UTF_8":
		charSize=3;
	default:
		for(b=i=0; c=chr.charCodeAt(i++); b+=c>>11?charSize:c>>7?2:1);
		return b;
	}
};



libUtil._shareData = {};







/**
 * 개인정보의 마스킹을 해제하여 호출한다. 사전에 이력을 저장한다.
 * 전달할 필수인수 : isMasking : boolean 마스킹여부 ,   callback : function---실행할 TR
 * 전달할 옵션인수 : maskingId : kendoMobileSwitch TAG_ID
 * 이외 사용할 Ajax인수들로 사용됨.
 */
this.go_isOnMaskWin="";
this.gfn_maskingReq = function(reqParams){
	if(!reqParams || typeof reqParams.callback != "function"){
		gfn_msgBox({msg:"code.validation.field.required"}, "조회조건");
		return false;
	}
	if(!gfn_isEmpty(go_isOnMaskWin)){
		return false;
	}
	gfn_loading(true);
	go_isOnMaskWin="true";
	setTimeout(function(){gfn_loading();go_isOnMaskWin=undefined;},1000);

	var thisInstance = this;
	var isMasking = reqParams.isMasking;
	var callbackFn = reqParams.callback;
	var cancelCallbackFn = reqParams.cancelCallback;
	var maskingId = reqParams.maskingId;
	delete reqParams.isMasking;
	delete reqParams.callback;
	delete reqParams.cancelCallback;
	delete reqParams.maskingId;
	reqParams.isMasking = true; // 기본값 Masking ON.

	if(isMasking != false || isMasking && isMasking != "false"){
		if(maskingId){
			$("#" + maskingId).data("kendoMobileSwitch").check(true);
			$("#" + maskingId).val("true");
		}
		$.ajax({
			url: gfn_getUri('/common/session/time'),
			data:{isMasking:true},
			type:'POST',
			async: false,
			success:function(data, statusText, xhr){
				$('#countdown').timeTo(data['remainTime'], function(){
					fnLogOut();
				});
			}
		});
		return callbackFn.call(thisInstance, reqParams);
	}
	var initMaskingFn = function(data){
		$("input:radio[name='_comn_rdWhySbst']").click(function(){
			if($(this).val() == "05"){		
				$("input[name='_comn_textWhySbst']").prop("disabled",false);
			}else{
				$("input[name='_comn_textWhySbst']").val("");
				$("input[name='_comn_textWhySbst']").prop("disabled",true);
			}
		});
		
		$("#_comn_btnMaskingSave").click(function(){
			if($("input:radio[name='_comn_rdWhySbst']:checked").val() == "05"){
				if($.trim($("input[name='_comn_textWhySbst']").val()) == ""){
					gfn_msgBox({msg:"code.validation.field.required"}, "개인정보 열람사유");
					$("input[name='_comn_textWhySbst']").focus();
					return false;
				}
			}
			
			var retvWhySbst = $("input:radio[name='_comn_rdWhySbst']:checked").val();
			var textRetvWhySbst = $.trim($("input[name='_comn_textWhySbst']").val()); // $("#" + data.target + " #_comn_textWhySbst").val();
			
			if(gfn_isEmpty(retvWhySbst)){
				gfn_msgBox({msg:"code.validation.field.required"}, "개인정보 열람사유");
				return false;
			}
			reqParams.isMasking = false; // 마스킹을 해제한다.
			reqParams.retvWhySbst=retvWhySbst;
			reqParams.textRetvWhySbst=textRetvWhySbst;
			reqParams._msgView=gfn_getMenu(libTabs._nowTabName).msgView
			reqParams._isKeepMasking = true;

			parent.$("#" + data.target).data("kendoWindow").close();

			$.ajax({
				url: gfn_getUri('/common/session/time'),
				data:reqParams,
				type:'POST',
				async: false,
				success:function(data, statusText, xhr){
					$('#countdown').timeTo(data['remainTime'], function(){
						fnLogOut();
					});
				}
			});
			delete reqParams._isKeepMasking;

			// alert('개인정보를 MaskingOff하여 호출테스트 합니다.\n' + JSON.stringify(reqParams));
			callbackFn.call(thisInstance, reqParams);
			
		});
		
		$("#_comn_btnMaskingClose").click(function(){
			// parent.$("#chkMasking").data("kendoMobileSwitch").check(true);
//			if(cancelCallbackFn != null && typeof cancelCallbackFn == "function")
//				cancelCallbackFn.call(thisInstance, reqParams);
			parent.$("#" + data.target).data("kendoWindow").close();
		});
	};
	var options = {modal:true, width: "510px", height: "330px"
			, id:"_comn_maskingPopupLayer", title:"개인정보 열람사유 등록"
			, callback:function(data){
				initMaskingFn.call(thisInstance, data);
			} 
			, closeCallback:function(data){
				try {
					if(maskingId){
						$("#" + maskingId).data("kendoMobileSwitch").check(true);
						$("#" + maskingId).val("true");
					}
				} catch (e) {
					console.log(e);
				}
				if(reqParams.isMasking && cancelCallbackFn != null && typeof cancelCallbackFn == "function"){
					cancelCallbackFn.call(thisInstance, reqParams);
				}
			}
	};
	if(!libUtil._comn_mask_tag){
		libUtil._comn_mask_tag = $("#_comn_mask_tag").html();
	}
	$("#_comn_mask_tag").html(libUtil._comn_mask_tag);
	gfn_winOpen(options);
};

function setCookie(cookieName, value, days){
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + days);
	var cookieValue = escape(value) + ((days == null) ? '' : '; expires=' + exdate.toUTCString());
	document.cookie = cookieName + '=' + cookieValue;
}
function getCookie(cookieName){
	var x,y;
	var val=document.cookie.split(';');
	for(var i=0;i<val.length;i++){
		x=val[i].substr(0,val[i].indexOf('='));
		y=val[i].substr(val[i].indexOf('=')+1);
		x=x.replace(/^\s+|\s+$/g,''); //앞뒤공백제거.
		if(x==cookieName){
			return unescape(y); // unescape로 디코딩 후 반환.
		}
	}
}

/**
 * Cookie를 key=value로 추가한다. 추가된 Cookie값은 expireDate(기본값 24시간)까지 보존된다. : 기본 저장 Path::/om/
 */
this.gfn_setCookie = function(key, value, expireDate){
	if(typeof date === "number"){
		expireDate = gfn_getDate(expireDate);
	}else if(typeof expireDate === "object" && typeof expireDate.getTime() === "number" && typeof expireDate.getTime === "function"){
		// expireDate = expireDate;
	}else{
		console.warn("Cookie adding warn[not expireDate setting] : key("+key+"), value("+value+"), expireDate("+expireDate+"::default[oneDay])");
		expireDate = gfn_getDate(1);
	}
	document.cookie = key + "=" + escape(value) + "; path=/om/; expires=" + expireDate.toGMTString() + ";";
}
/**
 * 저장중인 Cookie에서 key에 해당하는 value를 읽어온다.
 */
this.gfn_getCookie = function(key){
	let result = "";
	try {
		let cookies = document.cookie.split(";");
		let cookieObj = {};
		for (var i = 0; i < cookies.length; i++) {
			cookieObj[cookies[i].split("=")[0].trim()] = cookies[i].split("=")[1].trim();
		}
		result = cookieObj[key];
	} catch (e) {}
	return result;
}
/**
 * 저장중인 Cookie에서 key에 value가 동일하게 있는지 체크한다.
 */
this.gfn_isCookie = function(key, value){
	return gfn_getCookie(key)===""+value;
}

/**
 * undefined와 null인 경우 "" 으로 리턴한다.
 */
this.gfn_toPrint = function(val) {
	return gfn_nvl(val, "");
}

/**
 * input type = number 의 경우 maxlength 체크 기능
 * maxlength="20" : 필수
 * <input type="number" maxlength="20" oninput="gfn_maxLength(this)">
 */
this.gfn_maxLength = function(obj) {
	if (obj.maxLength) {
		if (obj.value.length > obj.maxLength) {
			obj.value = obj.value.slice(0, obj.maxLength);
		}
	} else {
		console.log("[libUtil.gfn_maxLength()] maxlength Attribute 는 필수 입니다.");
	}
}

/**
 * input type이 text 일때 사용
 * $("#popLineVal").on("oninput", gfn_onlyNumber);
 * 혹은
 * oninput=\"lfn_onlyNumberKeyUp(this)\"
 */
this.gfn_onlyNumber = function(input) {
	if(/\D/g.test(input.value) && input.value) {
		input.value = input.value.replace(/\D/g, "");
	}
}



/**
 * 테스트용....
 * 초 분 시 일 월 요일
 */
this.cronDescripter = function(crontab){
	var result = "";
	if(/^[0-9]*$/.test(crontab*1)){
		var time = crontab * 1;
		var days = parseInt(time / 24 / 60 / 60 / 1000);
		var hours = parseInt(time % (24 * 60 * 60 * 1000) / 60 / 60 / 1000);
		var minites = parseInt(time % (60 * 60 * 1000) / 60 / 1000);
		var seconds = parseInt(time  % (60 * 1000) / 1000);
		var millseconds = parseInt(time % (1000));
		if(days!=0){
			result+=" "+days+"일";
		}
		if(hours!=0){
			result+=" "+hours+"시간";
		}
		if(minites!=0){
			result+=" "+minites+"분";
		}
		if(seconds!=0){
			result+=" "+seconds+"초";
		}
		if(millseconds!=0){
			result+=" "+millseconds+"밀리초";
		}
		return "매" + result + "마다 실행합니다.";
	}
	
	var second;
	var minite;
	var hour;
	var day;
	var moon;
	var week;
	var arrCron = crontab.split(" ");
	for(var i=0; i<arrCron.length; ++i){
		if(arrCron[i]==""){
			arrCron.splice(i,1);
			--i;
			continue;
		}
	}
	if(arrCron.length>=6 && arrCron[5]!="?" && arrCron[5]!="*"){ // 요일처리
		var weekName = [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ];
		// 콤마로구분,
		// 하이픈으로 구분,
	}
	if(arrCron.length>=5){
		// *, 숫자, 슬러시로 구분
		second = libUtil._switchEachCronValue(arrCron[0], "초");
		if(second==-1){
			return "초단위 값이 cron표현식에 맞지 않습니다.["+crontab+"]";
		}

		minite = libUtil._switchEachCronValue(arrCron[1], "분");
		if(minite==-1){
			return "분단위 값이 cron표현식에 맞지 않습니다.["+crontab+"]";
		}

		hour = libUtil._switchEachCronValue(arrCron[2], "시간");
		if(hour==-1){
			return "시간단위 값이 cron표현식에 맞지 않습니다.["+crontab+"]";
		}

		day = libUtil._switchEachCronValue(arrCron[3], "일");
		if(day==-1){
			return "일단위 값이 cron표현식에 맞지 않습니다.["+crontab+"]";
		}

		moon = libUtil._switchEachCronValue(arrCron[4], "월");
		if(moon==-1){
			return "월단위 값이 cron표현식에 맞지 않습니다.["+crontab+"]";
		}

		return moon + day + hour + minite + second;
	}
	
	return "해당 값은 cron표현식에 맞지 않습니다.["+crontab+"]";
};

/**
 * 초/분/시간 은 0을 처리하며, 일/월은 0을 처리하지 않고 에러나게 해야한다. 0일/0월은 없으니...
 */
libUtil._switchEachCronValue = function(cron, type){
	var result = "";
	if(cron=="*"){
		result = "매 "+type+" 마다, ";
	}else if(/^[0-9]*$/.test(cron*1)){
		result = "매 "+cron+type+" 마다, ";
	}else if(cron.indexOf("/")>-1){
		if(cron.split("/")[0].trim()=="*" || cron.split("/")[0].trim()=="0" || cron.split("/")[0].trim()==""){
			result = "매 " + cron.split("/")[1] + type+" 간격으로, "
		}else{
			result = cron.split("/")[0] + ""+type+" 후부터, 매 " + cron.split("/")[1] + type+" 간격으로, "
		}
	}else{
		return -1;
	}
	return result;
}

/**
 * Grid Resize 공통
 */
this.gfn_gridResize = function() {
	
	//좌측메뉴 높이 지정
	$(".k-drawer-container").height($(window).height() - ($(".my-config-area").height()+ $("#toolbar").height()));
	
	//컨텐츠 영역 전체 높이 지정
	$(".ui-tabs .ui-tabs-panel").height($(window).outerHeight() - ($(".my-config-area").outerHeight(true)+ $("#toolbar").outerHeight(true) + $("#_tabControl").outerHeight(true) + 20));
	
	//grid 영역 높이 지정
	if($('#grid-content').length !=0) {
		$("#grid-content").height($(window).height() - ($("#grid-content").prev().offset().top + $("#grid-content").prev().outerHeight(true)+10));
	}
	
	//활성화된 그리드 리로드 
	if($('#grid-content .k-grid').children().length !=0) {
		$("#grid-content .k-grid").each(function(){
			$(this).data("kendoGrid").resize();
		})
	}
}


this.gfn_popupTemplate = function(e){	
	var popupLangCd = gfn_getCode('msg.langCd');
	popupLangCd.sort(function(a,b) {
		return parseFloat(a.sortNum) - parseFloat(b.sortNum);
	});
	
	var headerTemplate = "<div class='popupHeader'>"
		+"<span>Message ID : </span><input type='text' id='msgId' class='k-textbox'><br /><br />"
		+"</div>";
	
	var contentTemplate = "<div class='popupContent'>";
	$.each(popupLangCd, function(index, item) {
		contentTemplate += "<div class='msgRow'><input type='text' class='popupLangCd k-textbox' value=" + item.cdVal + " disabled></span><input type='text' class='popupMsgView k-textbox' placeholder='입력'></div>"
	});
	contentTemplate += "</div>";
	
	var footerTemplate = "<div class='k-edit-buttons k-state-default'>"
	+ "<a role='button' class='k-button k-button-icontext k-primary' onclick='gfn_popupUpdate()'><span class='k-icon k-i-check'></span>Update</a>"
	+ "<a role='button' id='popupCancel' class='k-button k-button-icontext k-primary k-grid-cancel'><span class='k-icon k-i-cancel'></span>Cancel</a></div>";	
	
	$('.k-edit-form-container').html(headerTemplate + contentTemplate + footerTemplate);		
	
	if($('#regMsgList').val() == "") {
		$('.k-window-title').text("Create");
	} else {
		$('.k-window-title').text("Modify");
		
		var regMsgList = JSON.parse($('#regMsgList').val());
		$('#msgId').val(regMsgList['msgList[0].msgViewPk.msgId']);
		
		$.each($(".msgRow"), function(index, item) {
			$(item).find(".popupLangCd").val(regMsgList['msgList[' + index + '].msgViewPk.langCd']);
			$(item).find(".popupMsgView").val(regMsgList['msgList[' + index + '].msgView']);
		});
	}
}

this.gfn_popupUpdate = function() {
	var saveData = {};
	
	$.each($(".msgRow"), function(index,item) {
		saveData['msgList[' + index + '].msgViewPk.msgId'] = $('#msgId').val();
		saveData['msgList[' + index + '].msgViewPk.langCd'] =  $(item).find(".popupLangCd").val();
		saveData['msgList[' + index + '].msgView'] = $(item).find(".popupMsgView").val();
	}); 
	
	kendo.confirm("저장하시겠습니까?").done(function(){
		$("#regMsgList").val(JSON.stringify(saveData));
		$('#popupCancel').click();
	});
}

//padLeft 구현
this.gfn_padLeft = function(n,fillText, width) {
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join(fillText)+ n;
}

//팝업종료
this.gfn_closePop = function(popID){
	var layoutID = $("#"+popID).closest(".k-window-content").attr("id");
	$("#"+layoutID).data("kendoWindow").close();
}

//팝업 리사이즈(kendo 내부함수 안됨)
//option = width,height
this.gfn_resizePop = function(popId,option){
	var popLayer = $("#"+popId).closest(".k-window");
	
	var p_height = option.height;
	var p_top = ($(window).outerHeight()-p_height)/2
	var p_width = option.width;
	var p_left = ($(window).outerWidth()-p_width)/2
	popLayer.css({height:p_height, width:p_width, top: p_top, left:p_left});
	
}

//object 쿼리전달시  ""값 null처리
this.gfn_serializeObject = function(param){
	var rtnObj = $("#"+param).serializeObject();
	
	//메뉴아이디 보내줌
	rtnObj.currentMenuId = $("#_currentMenuId").val();
	
	//첨부파일이 있는 경우 말아줌
	if($("#"+param + " #insertAttach").length > 0 && $("#"+param + " #insertAttach").val() != ""){
		rtnObj.insertAttach = JSON.parse($("#"+param + " #insertAttach").val());
	}
	if($("#"+param + " #deleteAttach").length > 0 && $("#"+param + " #deleteAttach").val() != ""){
		rtnObj.deleteAttach = JSON.parse($("#"+param + " #deleteAttach").val());
	}
	
	for(key in rtnObj){
		if(rtnObj[key] == ""){
			rtnObj[key] = null;
		}
	}

	return rtnObj;
}