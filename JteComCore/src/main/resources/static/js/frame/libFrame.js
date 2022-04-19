/**
 *  /bizNaru/lib/libFrame.js
 */

var libFrame = {};

libFrame.menuHistIdx = -1;
libFrame.menuHistory = [];
libFrame._menuObj = {};
libFrame._popUpLayerObj = {};
libFrame._FRAME = {};
libFrame._beforeTabNmWithPopupWindow;
libFrame._popupDepth = 0;

this.gfn_getMenuUri = function(menu, fileType){
	//if(menu.indexOf("/jsp/")==0){
		return this.gfn_getUri(menu + "." + fileType); // jsp화면을 지정한다. /webapp/WEB-INF/views/form/common/popup/commonPopup...
	//}else{
	//	return this.gfn_getUri("/tif/" + menu + "." + fileType); // thyemLeaf화면을 지정한다. /templates/tif/form/common/popup/commonPopup...
	//}
};

this.gfn_getUrlToId = function(url){
	return url.replace(/\//g,"").replace(/\./g,"_").replace(/(\/[a-z_])/g, function(arg){return arg.toUpperCase().replace('/','');});
};
this.gfn_clearNodes = function(id){
	if(gfn_isNull(id)){
		id = "errorLayer"; // "lastDivTagLineIfMenuMovedThenClearAfter";
		var positionNode = $("#" + id).parent();
	}else if(typeof id == "object"){
		var positionNode = id;
	}else if(typeof id == "string"){
		var positionNode = $("#" + id);
	}
// 	while(!gfn_isNull(positionNode.next().attr("class")))
	while(!gfn_isNull(positionNode.next()) && !gfn_isNull(positionNode.next().length) && positionNode.next().length > 0 && typeof positionNode.next().remove == "function"){
		if(positionNode.next()[0].getElementsByClassName("altBoardDetailViewTitle").length>0){ // if(positionNode.next()[0].textContent.startsWith("공지사항")){
			positionNode = positionNode.next(); // 공지사항은 메뉴이동시 삭제에서 제외한다.
			continue;
		}
		positionNode.next().remove();
	}
}

/** 공통 내부팝업 윈도우 지원함수 **/
this.gfn_winOpen = function(data){
	var menu = "";
	/*** 상대경로는 페이지별로 별도 구현할때 필요함. ***/
//	if(libTabs._nowTabName){ // 로그인된 상태 및 현재 페이지가 존재하는 경우.
//		menu = libFrame._menuObj[libTabs._nowTabName].menu.split("/").slice(0,-1).join("/");
//	}
	var targetId = "_commonPopup";
	var targetDivId = "PopFormLayer_" + new Date().getTime();
	var targetClass = $("#_currentMenuId").val() + "Pop";
	var popTitleNm = gfn_getMsg("pop_comnPop");			//공통팝업
	if(typeof data == "string"){
		if(data.indexOf("//")==0 || data.indexOf("../")==0){
			menu = data;
		}else if(data.indexOf("/")==0){
			menu += "/" + data.substring(1);
		}else{
			menu += "/" + data;
		}
	}else if(typeof data == "object" && typeof data.url == "string"){
		targetId = data.id;
		if(data.url.indexOf("//")==0 || data.url.indexOf("../")==0){
			menu = data.url;
		}else if(data.url.indexOf("/")==0){
			menu += "/" + data.url.substring(1);
		}else{
			menu += "/" + data.url;
		}
		if(data.title==undefined || data.title==null){
			data.title = popTitleNm;
		}
	}else if(typeof data == "object" && typeof data.id == "string"){
		var contents = $("#"+data.id);
		menu = libTabs._nowTabName;
		if(gfn_isNull(contents.html())){
			if(gfn_isNull(libFrame._popUpLayerObj[menu+"_"+data.id])){
				// 해당 화면이 없습니다.
				if(typeof data == "object" && typeof data.callback == "function"){
					data.code=false;
					data.error="대상 팝업ID의 화면이 없습니다.";
					data.callback(data);
				}
				this.gfn_loading(false);
				return;
			}else{
				// 내부 팝업을 한번 사용해서 없어진 상태이므로 미리 저장한 영역에서 tag를 불러와 붙여준다.
				$("#"+targetId).append("<div id='"+data.id+"' style='overflow: hidden; padding: 0;' class'"+targetClass+"'>"+libFrame._popUpLayerObj[menu+"_"+data.id]+"</div>");
				contents = $("#"+targetId + " #"+data.id);
			}
		}else{
			// 내부 팝업은 최초 로드시 데이터가 존재하며... 해당데이터는 팝업닫기 시 사라지므로 재사용을 위해 저장해놓는다. ::: 재사용 시 내부 내용이 변경되지 않기위해서도 이렇게 처리함.
			libFrame._popUpLayerObj[menu+"_"+data.id] = contents.html(); // 향후 재로드를 위해서 저장. // 화면전환시 초기화 할지 ???
		}
		data.target = targetDivId;
		data.title = data.title ? data.title : popTitleNm;
		$("#_commonPopup").html("");
		$("#_commonPopup").append("<div id='"+targetDivId+"' style='overflow: hidden; padding: 0;' class'"+targetClass+"'></div>");
		var kendoWin = $("#"+targetDivId).kendoWindow(
				gfn_getKendoWindowOptions(data)).data("kendoWindow");
		// 안먹는다. kendoWin.setOptions(data);
		kendoWin.center().open().content(contents);
		if(typeof data == "object" && typeof data.callback == "function"){
			data.callback(data);
		}
		this.gfn_loading(false);
		return kendoWin;
	}
	var jsNm = "Popup_" + gfn_getUrlToId(menu);
	var htmlUrl = this.gfn_getMenuUri(menu, "html") // 화면구조 패턴.!
	var jsUrl = this.gfn_getMenuUri(menu, "js") // 화면구조 컨트롤 JS패턴.!

	if(!libFrame._menuObj[jsNm])
		libFrame._menuObj[jsNm] = {isLoad:false, menu:menu, menuType:"I", htmlUrl:htmlUrl, jsUrl:jsUrl, baseUrl:jsUrl.split("/").slice(0,-1).join("/")+"/"};

	if(typeof data == "object"){
		data.target = targetDivId;
		// kendoWin.setOptions(data);
	}else{
		data = {id:data, target:targetDivId};
	}

	$("#_commonPopup").append("<div id='"+targetDivId+"' style='overflow: hidden; padding: 0;' class'"+targetClass+"'></div>");
	var kendoWin = $("#"+targetDivId).kendoWindow(
			gfn_getKendoWindowOptions(data)).data("kendoWindow");

	libFrame._loadHtmlJs.call(this,targetId,jsNm,htmlUrl,jsUrl,function(menuObj){

//		if(typeof data == "object"){
//			data.target = targetDivId;
//			// kendoWin.setOptions(data);
//		}else{
//			data = {id:data, target:targetDivId};
//		}
		
		document.getElementById(targetId).innerHTML = '<div class="k-list-container k-popup k-group k-reset" id="'+jsNm+'" data-role="popup"  class"'+targetClass+'">\n\t' + menuObj.htmlData + '\n</div>';
//		$("#_commonPopup").append("<div id='"+targetDivId+"' style='overflow: hidden; padding: 0;'></div>");
		var contents = $("#"+targetId + " #" + jsNm);
//		var kendoWin = $("#"+targetDivId).kendoWindow(
//				gfn_getKendoWindowOptions(data)).data("kendoWindow");
		kendoWin.center().open().content(contents);

		libFrame._importJs.call(this, jsNm, data, data.callback); // setLayer등과 마찬가지로 팝업화면 호출자의 callback을 실행해준다. 2018.11.28 추가함.

		this.gfn_loading(false);
	});
	return kendoWin;
};

/** Kendo Window의 옵션을 사용자옵션으로 대체한다. **/
this.gfn_getKendoWindowOptions = function(data){
	var arrDef = ["position","width","height","resizable","modal","animation","visible","actions","title","iframe","close"];
	var options = {
			url:data.url,
			width: "600px",
			height: "400px",
			resizable: false,
			modal: true,
			animation : {open :{effects:"expand:vertical fadeIn"},close :{effects:"expand:vertical fadeIn", reverse: true}},
			visible : false,
			actions: ["Minimize", "Maximize", "Close"],
			title: "공통 팝업",
//			content : htmlUrl, // 실데이터를 넣는게 아니라 JQuery ID를 넣는것으로 적용되는듯...
			iframe: false // iframe 영역내부에 js를 붙이는 방법을 못찾겠다.
		};
	for(var i=0; i<arrDef.length;i++){
		if(!gfn_isNull(data[arrDef[i]])){
			options[arrDef[i]] = data[arrDef[i]];
		}
	}
	// 모달에 따라 흔적을 지우고 안지우고 한다.
	if(gfn_isNull(options.modal) || options.modal == false){
		options.close = function() {
			if(typeof data == "object" && typeof data.closeCallback == "function"){
				// gfn_loading(true);
				setTimeout(function(data, element){try{data.closeCallback(data, this.element);}catch(e){console.error(e);}finally{/*gfn_loading(false);*/}}, 300, data, this.element);
				// data.closeCallback(data, this.element);
			}
			if(typeof data == "object" && data.isNewWin == true && libFrame._beforeTabNmWithPopupWindow){
				libTabs._nowTabName = libFrame._beforeTabNmWithPopupWindow;
				libFrame._beforeTabNmWithPopupWindow = undefined;
			}
		};
	}else{
		++libFrame._popupDepth;
		options.close = function() {
			--libFrame._popupDepth; // 모달팝업의 깊이를 제거한다.(최종 0인 상태가 최상위 팝업임)
			if(typeof data == "object" && typeof data.closeCallback == "function"){
				// gfn_loading(true);
				setTimeout(function(data, element){try{data.closeCallback(data, this.element);}catch(e){console.error(e);}finally{/*gfn_loading(false);*/}}, 300, data, this.element);
				// data.closeCallback(data, this.element);
			}
			// $(this.element).parent().remove();
			try {
				/*** 공통팝업의 경우 업무혼선을 제거하기 위해 Node흔적을 지우지 않는다. ***/
				if(gfn_isEmpty(options.url) || !options.url.endsWith("/common/popup/comPopup")){
					gfn_clearNodes($(this.element).parent());
				}
				if(libFrame._popupDepth<=0){
					// 모달팝업의 최상위 팝업인 경우만 하위 모든 Elements들을 삭제한다.
					libFrame._popupDepth=0;
					$(".k-overlay").remove();
					$("#" + data.target).parent().remove();
				}else{
					$("#" + data.target).remove();
				}
			} catch (e) {
				console.error(e);// gfn_errBox(JSON.stringify(e));
			}
			if(typeof data == "object" && data.isNewWin == true && libFrame._beforeTabNmWithPopupWindow){
				libTabs._nowTabName = libFrame._beforeTabNmWithPopupWindow;
				libFrame._beforeTabNmWithPopupWindow = undefined;
			}
		};
	}
	return options;
};

/** 공통 내부 추가 Layer 지원함수 data{id:"유일한DIV_ID", url:"확장자와 부모메뉴경로를 제외한 경로", ... "이외 lfn_init에 전달할 인수"} **/
this.gfn_setLayer = function(data, callback){
		var targetId = data.id;
		var menu = libFrame._menuObj[libTabs._nowTabName].menu.split("/").slice(0,-1).join("/");
		if(data.url.indexOf("//")==0){
			menu = data.url;
		}else if(data.url.indexOf("/")==0){
			menu += "/" + data.url.substring(1);
		}else{
			menu += "/" + data.url;
		}
		// menu += "/" + (data.url.indexOf("/")==0 ? data.url.substring(1) : data.url);

		var jsNm = "Layer_" + gfn_getUrlToId(menu);
		var htmlUrl = this.gfn_getMenuUri(menu, "html") // 화면구조 패턴.!
		var jsUrl = this.gfn_getMenuUri(menu, "js") // 화면구조 컨트롤 JS패턴.!

		if(!libFrame._menuObj[jsNm])
			libFrame._menuObj[jsNm] = {isLoad:false, menu:menu, menuType:"L", htmlUrl:htmlUrl, jsUrl:jsUrl, baseUrl:jsUrl.split("/").slice(0,-1).join("/")+"/"};

		libFrame._loadHtmlJs.call(this,targetId,jsNm,htmlUrl,jsUrl,function(menuObj){
			document.getElementById(targetId).innerHTML = libFrame._menuObj[jsNm].htmlData;
			libFrame._importJs.call(this, jsNm, data, callback);
			gfn_loading(false);
		});
};

/** 메뉴화면 로드시 최초 초기화 함수 호출 **/
libFrame._runFirstInit = function(jsNm, data, callback){

	if(!document.getElementById(jsNm)){
		var div = document.createElement('div');
		div.setAttribute("id", jsNm);
		div.setAttribute("name", jsNm);
		document.getElementById(libFrame._menuObj[jsNm].targetId).appendChild(div);
	}

	if(typeof data == "object"){
		data.isMenu = true;
	}else{
		data = {isMenu:true};
	}

	// document.getElementById(libFrame._menuObj[jsNm].targetId).innerHTML = libFrame._menuObj[jsNm].htmlData;
	document.getElementById(jsNm).innerHTML = libFrame._menuObj[jsNm].htmlData;
	libFrame._importJs.call(this, jsNm, data, callback);
};

libFrame._importJs = function(jsNm, data, callback){
	libFrame._FRAME[jsNm] = {}; // 존재하면 안해도 되는지 확인할것.(이줄과 다음줄만...)
	libFrame._menuObj[jsNm].jsFn.call(libFrame._FRAME[jsNm]); // 자바스크립트 로컬윈도우(메뉴) 화면 전용함수 생성.
	if(!gfn_isEmpty(libFrame._menuObj[jsNm].jsMember)){
		for(var key in libFrame._menuObj[jsNm].jsMember){
			try {
				eval("libFrame._FRAME[jsNm][key] = " + libFrame._menuObj[jsNm].jsMember[key]);
			} catch (e) {
				console.error("FormId[", jsNm, "], 전역변수Loading중 에러, errorPosition : libFrame._FRAME['"+jsNm+"']['"+key+"'] = \"libFrame._menuObj['"+jsNm+"'].jsMember['"+key+"']\"");
				throw e;
			}
		}
	}
	if(typeof data != "object" || data.isMenu != true){
		libFrame._menuObj[jsNm].jsFn.call(gfn_myTab()); // 소속 화면의 서브load이면 소속 화면에 한번더 import한다.
		if(!gfn_isEmpty(libFrame._menuObj[jsNm].jsMember)){
			for(var key in libFrame._menuObj[jsNm].jsMember){
				try {
					eval("gfn_myTab()[key] = " + libFrame._menuObj[jsNm].jsMember[key]);
				} catch (e) {
					console.error("FormId[", jsNm, "], 전역변수Loading중 에러, errorPosition : gfn_myTab()['"+key+"'] = \"libFrame._menuObj['"+jsNm+"'].jsMember['"+key+"']\"");
					throw e;
				}
			}
		}
	}
	data.tabId = jsNm;
	data.formId = jsNm;

/*** JSP적용을위한 ***/
//	// 전역과 공유할 수 있게 패턴에 맞는 함수/오브젝트에 대한 주소공유.
//	for(var item in libFrame._FRAME[jsNm]){
//		// console.debug(item + ":::::>" + libFrame._FRAME["codeListForm"][json]);
//		if(item && typeof item == "string" && item.length>=7 && item!="lfn_init"  && item!="lfn_close" 
//				&& (item.substring(0,4) == "lfn_" 
//					|| item.substring(0,3) == "lo_") 
//				&& libFrame._FRAME[jsNm][item] 
//				// 전역변수 빈값을 인정해준다.
////				&& (typeof libFrame._FRAME[jsNm][item] == "function" 
////					|| typeof libFrame._FRAME[jsNm][item] == "object")
//					){
//			this[item] = libFrame._FRAME[jsNm][item];
//			// eval("this."+item+" = libFrame._FRAME['codeListForm']['"+item+"']");
//		}
//	}

	/******************************************************************
	 * 메뉴접근에 대한 이력 남기기... @Async 이지만 처리순서의 
	 * "일반적보장"을 위해서 화면오픈 처리 이후에 초기화를 수행한다.
	 * 향 후 JSP로 변경시 Controller에서 처리하고 삭제해야 한다.
	 ******************************************************************/
	if(typeof data == "object" && data.isMenu == true && libFrame._menuObj[jsNm] && libFrame._menuObj[jsNm].srcType != "JSP" && libFrame._menuObj[jsNm].menu)
		$.ajax({url: this.gfn_getUri('/onmCommon/addUseHist'+libFrame._menuObj[jsNm].menu)});

	/******************************************************************
	 * 대상화면에 초기화함수가 있으면 실행해준다. 메뉴오픈시 전달한 인수도 넣어준다.
	 ******************************************************************/
	if(typeof libFrame._FRAME[jsNm].lfn_init == 'function'){
/*** JSP적용을위한 ***/
//		libFrame._FRAME[jsNm].lfn_init.call(this, data);//(libFrame._FRAME[jsNm]);
		if(typeof data != "object" || data.isMenu != true){
			try {
				libFrame._FRAME[jsNm].lfn_init.call(gfn_myTab(), data); // 소속 화면의 서브load이면 소속 화면에 한번더 import한다.
			} catch (e) {
				console.error("FormId[", jsNm, "], SUB_화면초기화 함수 실행 중 에러, errorPosition : libFrame._FRAME['"+jsNm+"'].lfn_init.call(gfn_myTab(), "+JSON.stringify(data)+"");
				throw e;
			}
		}else{
			try {
				libFrame._FRAME[jsNm].lfn_init.call(libFrame._FRAME[jsNm], data);
			} catch (e) {
				console.error("FormId[", jsNm, "], MAIN_화면초기화 함수 실행 중 에러, errorPosition : libFrame._FRAME['"+jsNm+"'].lfn_init.call(libFrame._FRAME['"+jsNm+"'], "+JSON.stringify(data)+"");
				throw e;
			}
		}
	}

	/******************************************************************
	 * 콜백함수가 있으면 실행해준다. 메뉴오픈시 전달한 인수를 다시 넣어준다. 
	 * 그런데 lfn_init함수에서 해당 인수(Object)를 변경(수정)한 내용이 있다면 콜백에서 변경된 인수를 확인할 수 있다.
	 ******************************************************************/
	if(typeof callback == 'function'){
		try {
			callback.call(this, data);
		} catch (e) {
			console.error("FormId[", jsNm, "], Loading화면 초기화 후 호출단 콜백에서 에러, errorPosition : callback.call(this, "+JSON.stringify(data)+")");
			throw e;
		}
	}
	return true;
};

libFrame._drawMenuView = function(jsNm, data, callback){
	if(typeof data == "object" && data.isNewWin == true) {
		/******************************************************************
		// 내부 팝업에 메뉴윈도우를 띄우는 경우이다.
		// 이때는 Modal만 가능하며, 내부 팝업에서 작동되게끔 하기 위해서 
		// libTabs._nowTabNum를 현재 jsNm으로 변경하고 
		 ******************************************************************/
		libFrame._beforeTabNmWithPopupWindow = libTabs._nowTabName;
	}else{
		if(libTabs._nowTabNum>=0 && libTabs._nowTabNum+1 >= libTabs._tabMax){
			var closeResult = libFrame._closeMenuView(libTabs._nowTabName);
			if(closeResult==false){
				return false; // 화면을 열지 않는다.
			}
			libTabs._tabs[libTabs._nowTabName] = null;
		}else{
			// 탭을 하나 추가한다.(최초에는 첫화면(Dashboard)에 표시한다.)
			libTabs._nowTabNum++;
		}
	}
	libTabs._nowTabName = jsNm;
	libTabs._tabs[libTabs._nowTabNum] = {name:jsNm};
	libFrame._runFirstInit.call(this, jsNm, data, callback);
	this.gfn_loading(false);
	// 2019.01.13 히스토리 이동을 위해서 새로 연 메뉴를 기억하고 이후 backward시 이동한다.
	libFrame.menuHistory.push(libFrame._menuObj[libTabs._nowTabName].menu);
	return true;
};

libFrame._closeMenuView = function(jsNm){
	if(typeof libFrame._FRAME[jsNm].lfn_close == 'function'){
		var closeResult = libFrame._FRAME[jsNm].lfn_close.call(this); // (libFrame._FRAME[jsNm]);
		if(closeResult==false)
			return false; // 새로운 화면을 열지 않고 이전(현재)화면에서 멈춘다.
	}
	gfn_clearNodes(); // 컴포넌트 삭제
	var parent = document.getElementById(libFrame._menuObj[jsNm].targetId);
	parent.removeChild(document.getElementById(jsNm));
	eval("libFrame._FRAME['"+jsNm+"'] = null");
	return true;
};

/**
 * 실시간 업무 JS 가져오기 --- 사용안함.
 */ 
libFrame.loadJs = function(menu, callback){
	
	var jsNm = gfn_getUrlToId(menu);
	// var jsUrl = this.gfn_getMenuUri(menu.split("/").slice(0,-1).join("/")+"/"+jsNm, "js") // 화면구조 컨트롤 JS패턴.!
	var jsUrl = this.gfn_getMenuUri(menu, "js") // 화면구조 컨트롤 JS패턴.!

	/***********다중탭이 아니므로 모두 삭제하고 추가한다.*************/
	document.getElementById(libFrame._menuObj[jsNm].targetId).innerHTML = "";
	// document.getElementById(libFrame._menuObj[jsNm].targetId).childNodes[0].id; // 하위에 대상을 찾아서 지운다.

	if(!document.getElementById(jsNm)){
		var div = document.createElement('div');
		div.setAttribute("id", jsNm);
		div.setAttribute("name", jsNm);
		document.getElementById(libFrame._menuObj[jsNm].targetId).appendChild(div);
	}

	if(!libFrame._menuObj[jsNm])
		libFrame._menuObj[jsNm] = {isLoad:false};
	
	/***********다중탭이 아니므로 JS도 계속 받는다.*************/
	libFrame._menuObj[jsNm].isLoad = false;

	if(libFrame._menuObj[jsNm].isLoad==false){
		this.gfn_loading(true);
		libFrame.loadJavascript(
				jsUrl
				, jsNm
				, function(jsNm){
					libFrame._menuObj[jsNm].isLoad=true;
					libTabs._tabs[0] = {name:jsNm};
					libFrame._runFirstInit(jsNm);
					this.gfn_loading(false);
				}
				, "UTF-8");
	}else{
		libFrame._runFirstInit(jsNm);
	}
}
/**
 * 실시간 업무 HTML 가져오기. 
 * 4번 5번 인수는 둘중에 하나는 콜백function 이며, 하나는 lfn_init함수를 초기실행할때 전달할 인수로 작동한다.
 */
this.gfn_goMenu = function(menuInfo, targetIdParam, dataNcallback, callbackNdata){
	gfn_goMenu_condition(menuInfo, targetIdParam, dataNcallback, callbackNdata, true);
}
this.gfn_goMenu_condition = function(menuInfo, targetIdParam, dataNcallback, callbackNdata, force){

	if(force || libUtil.__loadingDepthCount<=1){
		console.warn(" *********** Menu Move Acess : " + libUtil.__loadingDepthCount + ", force : " + force);
	}else{
		console.warn(" *********** Menu Move Denied : " + libUtil.__loadingDepthCount + ", force : " + force);
		gfn_msgBox({msg:"작업 진행중인 정보 "+libUtil.__loadingDepthCount+"건 있습니다.\n잠시 후 재시도 해주세요."});
		// 타이머 처리해서 홀딩작업중인 경우 얼마간 기다렸다가 강제로 이동을 허용해 줘야 한다.
		return;
	}

	/************ 둘다 Function 또는 둘다 Object을 넣는 경우는 없겠지... ************/
//	var data = typeof dataNcallback == "object" ? dataNcallback : (typeof callbackNdata == "object" ? callbackNdata : {}) ;
//	var callback = typeof callbackNdata == "function" ? callbackNdata : dataNcallback ;
	var data = typeof targetIdParam == "object" ? targetIdParam : 
			(	typeof dataNcallback == "object" ? dataNcallback : 
					(	typeof callbackNdata == "object" ? callbackNdata : {} ) );
	var callback = typeof targetIdParam == "function" ? targetIdParam : 
			(	typeof dataNcallback == "function" ? dataNcallback : 
					(	typeof callbackNdata == "function" ? callbackNdata : callbackNdata ) );
	data.isMenu = true;
	
	var menuId = menuInfo.menuId;
	var targetId = typeof targetIdParam == "string" ? targetIdParam : "subContents"; // 탭이 여러개가 아니므로...
	var svcUrl = menuInfo.svcUrl;
	var menuType = menuInfo.menuCd;
			
	var jsNm = svcUrl.replace(/\//,"").replace('..','_').replace(/(\/[a-z_])/g, function(arg){return arg.toUpperCase().replace('/','');}) + menuId;
	// var htmlUrl = this.gfn_getMenuUri(svcUrl.split("/").slice(0,-1).join("/")+"/"+jsNm, "html") // 화면구조 패턴.!
	var htmlUrl = this.gfn_getMenuUri(svcUrl, "html") // 화면구조 패턴.!
	var jsUrl = this.gfn_getMenuUri(svcUrl, "js") // 화면구조 컨트롤 JS패턴.!
	menuInfo.jsNm = jsNm;
	menuInfo.htmlUrl = htmlUrl;
	menuInfo.jsUrl = jsUrl;

	if(!libFrame._menuObj[jsNm])
		libFrame._menuObj[jsNm] = {isLoad:false, menu:svcUrl, menuType:menuType, htmlUrl:htmlUrl, jsUrl:jsUrl, baseUrl:jsUrl.split("/").slice(0,-1).join("/")+"/", tabsIdList:new Array()};

	if(targetId=="subContents" && libTabs._tabMax>1){
		targetId = libTabs._fnAddTab.call(this, menuInfo, data, callback);
		if(!targetId || typeof targetId != "string"){
			// 이미 열린창이 존재하고 중복으로 열수없는 경우이므로 해당 탭을 선택해주고 탈출한다. 해당탭 선택은 libTabs._fnAddTab에서 진행한다.
			return;
		}
		return; // 화면을 그리는 방식이 다르므로 libTabs에서 처리하고 완료한다.
	}

	libFrame._loadHtmlJs.call(this,targetId,jsNm,htmlUrl,jsUrl,function(menuObj){
		if(jsNm!=libTabs._nowTabName){
			var menuResult = libFrame._drawMenuView.call(this, jsNm, data, callback);
			if(menuResult && !(data && data.isNewWin)){
				if(document.getElementById("menuSelectedName"))
					document.getElementById("menuSelectedName").innerHTML = menuInfo.msgView; /* menu.msgViewPath 선택경로를 표시할지 메뉴이름을 표시할지 ? */
				if(document.getElementById("menuPathNaviTop")){
					if(menuInfo.msgViewPath.split(" > ").length<=1){
						document.getElementById("menuPathNaviTop").innerHTML = "MENU / <span>" + menuInfo.msgViewPath + "</span>";
					} else {
						document.getElementById("menuPathNaviTop").innerHTML = menuInfo.msgViewPath.split(" > ").join(" / <span>") + "</span>";
					}
				}
			}
		}else{
			this.gfn_loading(false);
		}
	});
};

libFrame._loadHtmlJs = function(targetId,jsNm,htmlUrl,jsUrl,callback){
	this.gfn_loading(true);
	if(libFrame._menuObj[jsNm].isLoad==false 
			|| !libFrame._menuObj[jsNm].htmlData
			|| !libFrame._menuObj[jsNm].jsFn){
		/***************************************************************
		 * HTML/JS 파일을 로드한다. (srcType = "JS")
		 * 향후 JSP파일을 먼저 로드하는 것으로 변경할 예정임. (srcType = "JSP")
		 ***************************************************************/
/*** JSP적용을위한 ***/
		var jspUrl = libFrame._menuObj[jsNm].menu;
		if(jspUrl.split("/bizNaru/").length>1){
			jspUrl = '/' + jspUrl.split("/bizNaru/")[1];
		}
		// jspUrl = '/onmCommon/getMenuForm'+jspUrl; JSP or ThyemLeaf Resolver Controller.services
		
		libFrame._webGet(
				this.gfn_getUri(jspUrl)+"?uniq="+new Date().toDateString()
				, "GET", function(recvJspData){
					if(recvJspData&&recvJspData.result&&(!recvJspData.responseURL || !recvJspData.responseURL.endsWith("/login"))){
						//menuName 추가. Content 상단에 메뉴명 표시 위해 _191212_PGW
						libFrame._menuObj[jsNm].htmlData = "<div class='menuName'></div>" + libFrame._resetJsData(libFrame._getHtmlData(recvJspData.data));
						libFrame._menuObj[jsNm].jsData = libFrame._getJsData(recvJspData.data);
						libFrame._menuObj[jsNm].jsMember = libFrame._getFormMemberList(libFrame._menuObj[jsNm].jsData);
						libFrame._menuObj[jsNm].targetId = targetId;
						try {
							eval("libFrame._menuObj['"+jsNm+"'].jsFn = function(){\n" + libFrame._menuObj[jsNm].jsData + "\n};\n");
						} catch (e) {
							console.error("FormId[", jsNm, "], JSP에서 화면 로직 Loading중 에러, errorPosition : libFrame._menuObj['"+jsNm+"'].jsData");
							throw e;
						}
						libFrame._menuObj[jsNm].srcType = "JSP";
						libFrame._menuObj[jsNm].isLoad = true;
						if(callback&&typeof callback == "function")
							callback(libFrame._menuObj[jsNm]);
					}else{
						this.gfn_goMenuFail(recvJspData, jsNm);
//						libFrame._webGet(htmlUrl, "GET", function(recvHtmlData){
//							if(recvHtmlData&&recvHtmlData.result){
//								libFrame._webGet(jsUrl, "GET", function(recvJsData){
//									if(recvJsData&&recvJsData.result){
//										libFrame._menuObj[jsNm].htmlData = libFrame._resetJsData(recvHtmlData.data);
//										// Frame._menuObj[jsNm].jsData = libFrame._clearRemarkStr(libFrame._clearRemarkStr(libFrame._resetJsData(recvJsData.data), "/*", "*/", 0), "//", null, 0);
//										libFrame._menuObj[jsNm].jsData = libFrame._clearRemarkAll(libFrame._resetJsData(recvJsData.data));
//										// libFrame._menuObj[jsNm].jsData = libFrame._resetJsData(recvJsData.data);
//										libFrame._menuObj[jsNm].jsMember = libFrame._getFormMemberList(libFrame._menuObj[jsNm].jsData);
//										libFrame._menuObj[jsNm].targetId = targetId;
//										try {
//											eval("libFrame._menuObj['"+jsNm+"'].jsFn = function(){\nvar root = this;\n" + libFrame._menuObj[jsNm].jsData + "\n};\n");
//										} catch (e) {
//											console.error("FormId[", jsNm, "], JS에서 화면 로직 Loading중 에러, errorPosition : libFrame._menuObj['"+jsNm+"'].jsData");
//											throw e;
//										}
//										libFrame._menuObj[jsNm].srcType = "JS";
//										libFrame._menuObj[jsNm].isLoad = true;
//										if(callback&&typeof callback == "function")
//											callback(libFrame._menuObj[jsNm]);
//									}else{
//										this.gfn_goMenuFail(recvJsData, jsNm);
//									}
//								});
//							}else{
//								this.gfn_goMenuFail(recvHtmlData, jsNm);
//							}
//						});
					}
				});
	}else{
		if(callback&&typeof callback == "function"){
			libFrame._menuObj[jsNm].targetId = targetId;
			callback(libFrame._menuObj[jsNm]);
		}
	}
};
this.gfn_myTab = function(tabNm){
	if(gfn_isEmpty(tabNm)){
// 		return libFrame._FRAME[libTabs._nowTabName]; // 왜 이게 아닌지 잘 생각해보자.
		if(libTabs._nowTabNum<0)
			return libFrame._FRAME[libTabs._tabs[0].id];
		return libFrame._FRAME[libTabs._tabs[libTabs._nowTabNum].id];
	}
	return libFrame._FRAME[tabNm];
}
libFrame._getHtmlData = function(data){
	var result = "";
	while(true){
		var target = data.toUpperCase();
		var start = 0;
		var end = target.indexOf("<SCRIPT");
		if(end<0){
			result += data.substring(start);
			break;
		} else {
			result += data.substring(start, end);
			data = data.substring(target.indexOf("</SCRIPT>", end) + 9);
		}
	}
	return result;
};
libFrame._getJsData = function(data){
	var result = "";
	while(true){
		var target = data.toUpperCase();
		var start = target.indexOf("<SCRIPT");
		if(start<0){
			break;
		}
		start = target.indexOf(">", start)+1;
		var end = target.indexOf("</SCRIPT>");
		if(end<0){
			result += data.substring(start);
			break;
		} else {
			result += data.substring(start, end);
			data = data.substring(end + 9);
		}
	}
	// return libFrame._resetJsData(result);
	// return libFrame._clearRemarkStr(libFrame._clearRemarkStr(libFrame._resetJsData(result), "/*", "*/", 0), "//", null, 0);
	// return libFrame._clearRemarkAll(libFrame._resetJsData(result));
	return libFrame._resetJsData(libFrame._clearRemarkAll(result));
};
libFrame._resetJsData = function(data){
	var depth = 0;
	for(var index=0; index<data.length; index++){
		var chr = data.charAt(index);
		if("({[<".indexOf(chr)>-1){
			depth++;continue;
		}
		if(")}]>".indexOf(chr)>-1){
			depth--;continue;
		}
		if      (index>=5&&chr=='.'&&depth==0&&data.charAt(index-4)=='t'&&data.charAt(index-3)=='h'&&data.charAt(index-2)=='i'&&data.charAt(index-1)=='s'&& data.charAt(index-5)!='\n' && data.charAt(index-5)!='\r' ){
			data = data.substring(0,index-4) + "\n" + data.substring(index-4);
			index++;
		}else if(index>=5&&chr=='.'&&depth>0 &&data.charAt(index-4)=='t'&&data.charAt(index-3)=='h'&&data.charAt(index-2)=='i'&&data.charAt(index-1)=='s'&&(data.charAt(index-5)=='\n' || data.charAt(index-5)=='\r')){
			data = data.substring(0,index-4) + " " + data.substring(index-4);
			index++;
		}
	}
	var focus = 0;
	while(true){
		focus = data.indexOf("lfn_", focus);
		if(focus<0){
			focus=0;
			break;
		}else if(data.substring(focus-25, focus).indexOf("gfn_myTab") < 0 
				&& data.substring(focus-25, focus).indexOf("this") > 0 
				&& data.substring(focus-25, focus).replace(/[^A-Za-z'"(){}\[\]]/g, "").endsWith("this") 
				&& !(data.substring(focus-6, focus).indexOf("\nthis.")==0 || data.substring(focus-6, focus).indexOf("\rthis.")==0)){
			data=data.substring(0, data.substring(0, focus).lastIndexOf("this")) + "gfn_myTab()." + data.substring(focus);
//		}else if("function "!=data.substring(focus-9, focus) && "this."!=data.substring(focus-5, focus)){
		}else if(!data.substring(focus-29, focus).replace(/[^A-Za-z{]/g, "").endsWith("function") 
				&& !data.substring(focus-29, focus).replace(/[^A-Za-z_]/g, "").endsWith("gfn_myTab")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("this")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("var")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("let")
//				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("\"")
//				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("'")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z= ]/g, "").trim().endsWith(" id=")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z= ]/g, "").trim().endsWith(" name=")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z= ]/g, "").trim().endsWith(" class=")
				&& /[^A-Za-z_]/g.test(data.substring(focus-1, focus))){
			data=data.substring(0, focus) + "gfn_myTab()." + data.substring(focus);
			focus += 5;
		}
		++focus;
	}
	while(true){
		focus = data.indexOf("lo_", focus);
		if(focus<0){
			focus=0;
			break;
		}else if(data.substring(focus-25, focus).indexOf("gfn_myTab") < 0 
				&& data.substring(focus-25, focus).indexOf("this") > 0 
				&& data.substring(focus-25, focus).replace(/[^A-Za-z'"(){}\[\]]/g, "").endsWith("this") 
				&& !(data.substring(focus-6, focus).indexOf("\nthis.")==0 || data.substring(focus-6, focus).indexOf("\rthis.")==0)){
			data=data.substring(0, data.substring(0, focus).lastIndexOf("this")) + "gfn_myTab()." + data.substring(focus);
//		}else if("this."!=data.substring(focus-5, focus)){
		}else if(!data.substring(focus-29, focus).replace(/[^A-Za-z_]/g, "").endsWith("gfn_myTab")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("this")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("var")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("let")
//				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("\"")
//				&& !data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("'")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z= ]/g, "").trim().endsWith(" id=")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z= ]/g, "").trim().endsWith(" name=")
				&& !data.substring(focus-25, focus).replace(/[^A-Za-z= ]/g, "").trim().endsWith(" class=")
				&& /[^A-Za-z_]/g.test(data.substring(focus-1, focus))){
			data=data.substring(0, focus) + "gfn_myTab()." + data.substring(focus);
			focus += 5;
		}
		++focus;
	}
	while(true){
		focus = data.indexOf("gfn_", focus);
		if(focus<0){
			focus=0;
			break;
		}else if(data.substring(focus-25, focus).replace(/[^A-Za-z]/g, "").endsWith("this")){
			data=data.substring(0, data.substring(0, focus).lastIndexOf("this")) + data.substring(focus);
			focus += 5;
		}
		++focus;
	}
	return data;
};
/**
 * Load된 js데이터에서 Member변수(Object-해당FORM의 전역변수)만을 map으로 추출한다. 모두 String이며, eval로 해당 메모리에 lfn_init(...)전에 올려줘야 한다.
 */
libFrame._getFormMemberList = function(data){
	let fnDepth1 = 0;
	let fnDepth2 = 0;
	let fnDepth3 = 0;
//	let fnDepth4 = 0;
	let fnDepth = 0;
	
	let isSlush = false;
	let isBSlush = false;
	let isSConst = false;
	let isDConst = false;
	let isConst = false;
	
	let nowDepth = 0;
	let isKeyReady = false;
	let vars = "";
	let key = null;
	let result = {};
	if(gfn_isEmpty(data)||typeof data != "string"){
		return result;
	}
	// 최초 로드시 정제됨.
//	data = libFrame._clearRemarkStr(data, "/*", "*/");
//	data = libFrame._clearRemarkStr(data, "//", null);
	for(var i=0;i<data.length;i++){
		var chr = data.charAt(i);
		vars+=chr;
		if(!isKeyReady && !key && fnDepth==0 && (
				// vars.split("\n")[vars.split("\n").length-1].endsWith("var")||vars.split("\n")[vars.split("\n").length-1].endsWith("let"))
				vars.split("\n")[vars.split("\n").length-1].trim()=="var" || vars.split("\n")[vars.split("\n").length-1].trim()=="let"
				)){
			isKeyReady = true;
			vars = "";
			continue;
		}
		if(isKeyReady && !key && !gfn_isEmpty(vars.trim()) && fnDepth==0 && (chr=="=")){
			key = vars.split("=")[0].trim();
			vars = "";
			continue;
		}
		if(isKeyReady && key && !gfn_isEmpty(vars.trim()) && (fnDepth==0 && chr==";" || fnDepth==1 && chr=="}")){
			isKeyReady = false;
			result[key] = vars.trim();
			vars = "";
			key = null;
			// continue;
		}
		
		if(!isConst && chr=="/")
			isSlush != isSlush;
		if(!isBSlush && chr=="\\"){
			isBSlush = true;
		}else if(isBSlush){
			isBSlush = false;
			continue;
		}
		if(isSConst && chr=="'"){
			isSConst = isConst = false;
			continue;
		}
		if(isDConst && chr=='"'){
			isDConst = isConst = false;
			continue;
		}
		if(isConst || isSlush) continue;

		if(!isConst && chr=="'"){
			isSConst = isConst = true;
			continue;
		}
		if(!isConst && chr=='"'){
			isDConst = isConst = true;
			continue;
		}
		
		if("{}()[]".indexOf(chr)>-1){
			if(chr == '('){
				fnDepth1 ++;
			}else if(chr=='{'){
				fnDepth2 ++;
			}else if(chr=='['){
				fnDepth3 ++;
//			}else if(chr=='<'){
//				fnDepth4 ++;
			}else if(chr==')'){
				fnDepth1 --;
			}else if(chr=='}'){
				fnDepth2 --;
			}else if(chr==']'){
				fnDepth3 --;
//			}else if(chr=='>'){
//				fnDepth4 --;
			}
//			if("{([<".indexOf(chr)>-1){
//				fnDepth ++;
//			}else if("})]>".indexOf(chr)>-1){
//				fnDepth --;
//			}
			fnDepth = fnDepth1 + fnDepth2 + fnDepth3;
			continue;
		}
	}
	return result;
};
libFrame._clearRemarkStr = function(data, startRemark, endRemark, position) {
	if(gfn_isEmpty(data)) return data;
	// data=data.replace(/[\r]/g, "");
	if(gfn_isEmpty(position)){
		position = 0;
	}
	var start = data.indexOf(startRemark, position);
	if(start>=0) {
		var startAt = data.lastIndexOf("\n", start)+1;
		var endAt = data.indexOf("\n", start);
		if(endAt<0)
			endAt = data.length;
		if(startAt>=0 && startAt<endAt && libFrame._getWithoutConstStr(data.substring(startAt, endAt)).indexOf(startRemark)<0){
			return libFrame._clearRemarkStr(data, startRemark, endRemark, start+startRemark.length);
		}

		if(gfn_isEmpty(endRemark)) {
			var end = data.indexOf("\n", start);
			if(start<end) {
//				if(data.lastIndexOf("\n", start)>=0){
					return libFrame._clearRemarkStr(data.substring(0, start) + (data.substring(startAt, start).trim()!="" ? "\n" : "") + data.substring((end+1)>data.length?data.length:end+1), startRemark, endRemark, position);
//				}else{
//					return libFrame._clearRemarkStr(data.substring(0, start) + /*(data.charAt(start-1)!="\n" ? "\n" : "") + */data.substring((end+1)>data.length?data.length:end+1), startRemark, endRemark, position);
//				}
			} else {
				return data.substring(0, start);
			}
		} else {
			var end = data.indexOf(endRemark, start+startRemark.length);
			var startAt = data.lastIndexOf("\n", end)+1;
			var endAt = data.indexOf("\n", end);
			if(endAt<0)
				endAt = data.length;
			while (start<end && startAt>=0 && startAt<endAt && libFrame._getWithoutConstStr(data.substring(startAt, endAt)).indexOf(endRemark)<0) {
				end = data.indexOf(endRemark, endAt+1);
				startAt = data.lastIndexOf("\n", end)+1;
				endAt = data.indexOf("\n", end);
				if(endAt<0)
					endAt = data.length;
			}
			if(start<end){
				return libFrame._clearRemarkStr(data.substring(0, start) + data.substring(end+endRemark.length), startRemark, endRemark, position);
			} else {
				return data.substring(0, start);
			}
		}
	}
	return data;
};
libFrame._getWithoutConstStr = function(row){
	// 상수로 선언된 데이터는 제외한다. 단일라인에서...
//	var startAt = data.lastIndexOf("\n", start)+1;
//	var endAt = data.indexOf("\n", start);
//	var row = data.substring(startAt, endAt);
	var keptRow = "";
	var isSlush = false;
	var isBSlush = false;
	var isSConst = false;
	var isDConst = false;
	var isConst = false;
	for (var i = 0; i < row.length; i++) {
		if(!isConst && row.charAt(i)=="/")
			isSlush != isSlush;
		if(!isBSlush && row.charAt(i)=="\\"){
			isBSlush = true;
		}else if(isBSlush){
			isBSlush = false;
			continue;
		}
		if(isSConst && row.charAt(i)=="'"){
			isSConst = isConst = false;
			continue;
		}
		if(isDConst && row.charAt(i)=='"'){
			isDConst = isConst = false;
			continue;
		}
		if(isConst || isSlush) continue;

		if(row.charAt(i)=="'"){
			isSConst = isConst = true;
			continue;
		}
		if(row.charAt(i)=='"'){
			isDConst = isConst = true;
			continue;
		}
		keptRow+=row.charAt(i);
	}
	console.log(keptRow);
	return keptRow;
};

libFrame._webGet = function(url,type,callback, isAsync){
	if(!type)type="GET";
	if(isAsync!=false){
		isAsync = true;
	}
	var xhr = new XMLHttpRequest();
	xhr.open(type, url, isAsync); // 마지막인수가 true이거나, 생략하면 비동기로 작동한다.
	xhr.onreadystatechange = function() {
		if (this.readyState!==4)
			return;
		if(this.status==401){
			libUtil._commonError401Fn.call(this,this,this.status,this.statusText);
		}else if(typeof callback == 'function'){
			try {
				callback({result:this.status==200
					, data:this.responseText
					, readyState:this.readyState
					, response:this.response
					, responseURL:this.responseURL
					, status:this.status
					, statusText:this.statusText
					, timeout:this.timeout}
				);
			} catch (e) {
				console.error(e);
				callback();
			}
		}
	};
	if( url.indexOf(".htm")<0 && url.indexOf(".js")<0 && url.indexOf(".css")<0 && url.indexOf(".properties")<0 && url.indexOf(".cfg")<0 && url.indexOf(".txt")<0 ){
	// if(isAsync!=false){
		// xhr.setRequestHeader('Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8'); // Chrome
		// xhr.setRequestHeader('Accept', 'text/html, application/xhtml+xml, */*'); // IE
		xhr.setRequestHeader('Accept', 'text/html'); // 페이지자체를 가져온다. ::: JSP를 가져오려고 Ajax통신하면 JSON데이터만 가져올 수 있다.(페이지는 안가져오고)
		// xhr.setRequestHeader('Content-Type', 'application/xml'); // xml.데이터
		/*Accept를 지정하면 스프링시큐리티의 히스토리가 변경된다. : Session().getAttribute("SPRING_SECURITY_SAVED_REQUEST")*/
	}
	xhr.setRequestHeader('Cache-Control', 'no-cache'); // 캐쉬처리안함.
	xhr.send(null);
};

/**
 * 실시간 HTML 가져오기 실패 및 화면에 append 실패시 표시할 공통팝업.
 */
this.gfn_goMenuFail = function(data, target){
	// alert(data.status + " to TARGET["+target+"]\n------------------------------------------\n" + data);
	gfn_errBox({title:"메뉴에러", msg:"화면로딩에 실패했습니다.\n잠시후 다시 시도해주세요.", detail:("target["+target+"]\n" + /*JSON.stringify(*/data).replace(/\r\n/gi,"<br>").replace(/\n/gi,"<br>").replace(/</gi,"&lt;").replace(/>/gi,"&gt;")});
	this.gfn_loading(false);
	if(!gfn_isEmpty(data)&&!gfn_isEmpty(data.responseURL)&&data.responseURL.endsWith("/login")){
		location.href = encodeURI(gfn_getUri("/login"));
	}
};



/*************.실시간.JS.파일가져오기.***************/
libFrame.loadJavascript = function (url, jsNm, callback, charset) {
	if(libFrame._menuObj[jsNm].isLoad)
		return;
	/*********.CSS.동적LOADING.**********/
	// $('').appendTo('head').attr({rel: 'stylesheet',type: 'text/css',href: 'dynamic.css'});
	// var head = document.getElementsByTagName('head')[0];
	var head = document.getElementById(jsNm);
	// head = eval("head." + jsNm + " = {}");
	var script = document.createElement('script');
	script.type = 'text/javascript';
	if (charset != null) {
		script.charset = "UTF-8";
	}
	var loaded = false;
	script.onreadystatechange = function() {
		if (this.readyState == 'loaded' || this.readyState == 'complete') {
			if (loaded) {
				return;
			}
			loaded = true;
			if(callback) callback(jsNm);
		}
	};
	script.onload = function() {
		if(callback) callback(jsNm);
	};
	script.src = url;
	head.appendChild(script);
};

/*************.실시간.JS.파일삭제하기.***************/
libFrame.removeJavascript = function (url, jsNm, callback) {
	var count = 0;
	var targetelement="script";
	var targetattr="src";
	var allsuspects=document.getElementsByTagName(targetelement);
	for (var i=allsuspects.length; i>=0; i--){
		if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(url)!=-1){
			allsuspects[i].parentNode.removeChild(allsuspects[i]);
			count++;
		}
	}
	if(callback) {
		if(count>0){
			callback({result:"success",remove:count,url:url,name:jsNm,desc:"Remove count ["+count+"] JS file["+url+"] Name : " + jsNm});
		}else{
			calback({result:"fail",remove:count,url:url,name:jsNm,desc:"Not found JS file["+url+"] Name : " + jsNm});
		}
	}
};

/*************.실시간.JS.CSS.파일가져오기.***************/
libFrame.loadjscssfile = function (filename, filetype){
	var fileref=undefined;
	if (filetype == "js") { // if filename is a external JavaScript file
		fileref = document.createElement('script');
		fileref.setAttribute("type", "text/javascript");
		fileref.setAttribute("src", filename);
	}else if(filetype == "css") { // if filename is an external CSS file
		fileref = document.createElement("link");
		fileref.setAttribute("rel", "stylesheet");
		fileref.setAttribute("type", "text/css");
		fileref.setAttribute("href", filename);
	}
	if (typeof fileref != "undefined")
		document.getElementsByTagName("head")[0].appendChild(fileref);
};
//loadjscssfile("myscript.js", "js"); //dynamically load and add this .js file
//loadjscssfile("javascript.php", "js"); //dynamically load "javascript.php" as a JavaScript file
//loadjscssfile("mystyle.css", "css"); ////dynamically load and add this .css file

/*************.실시간.JS.CSS.파일삭제하기.***************/
libFrame.removejscssfile = function (filename, filetype){
	 var targetelement=(filetype=="js")? "script" : (filetype=="css")? "link" : "none"; //determine element type to create nodelist from
	 var targetattr=(filetype=="js")? "src" : (filetype=="css")? "href" : "none"; //determine corresponding attribute to test for
	 var allsuspects=document.getElementsByTagName(targetelement);
	 for (var i=allsuspects.length; i>=0; i--){ //search backwards within nodelist for matching elements to remove
		 if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(filename)!=-1)
			 allsuspects[i].parentNode.removeChild(allsuspects[i]); //remove element by calling parentNode.removeChild()
	 }
};
//removejscssfile("somescript.js", "js"); //remove all occurences of "somescript.js" on page
//removejscssfile("somestyle.css", "css"); //remove all occurences "somestyle.css" on page

/** Check Callback function and execute **/
libFrame._checkCallbackFnAndRun = function(){
	if(arguments.length>0 && typeof arguments[0] == "function"){
		arguments[0](gfn_arrCopy(arguments).slice(1));
	}else if(arguments.length>0 && typeof arguments[0] == "object" && typeof arguments[0].callback == "function"){
		arguments[0].callback(gfn_arrCopy(arguments).slice(1));
	}
};

/** 최초 권한에 허용된 메뉴리스트를 표시한다. 화면에 그리는것은 화면로드가 모두 끝난다음에 한다. **/
libFrame._displayMenu = function(){
	var arrMyMenu = this.gfn_getMenu();
	if(document.getElementById("menuTreeView") && document.getElementById("menuTreeView").nodeName == "UL" && arrMyMenu){
		var menuHtml = "";
		var depth;
		for (var i = 0; i < arrMyMenu.length; i++) {
			var menu = arrMyMenu[i];
			if(menu.upMenuId=="1" && menu.menuCd=="M"){
				if(depth==1){
					menuHtml += '\n							</ul>\n<span class="dd-trigger"></span></li>';
				}
				menuHtml += '						<li class="cn-dropdown-item has-down"><a class="cur-po">'+menu.msgView+'<i class="fas fa-angle-down padd-l-5"></i></a>';
				depth=0;
			}else if(menu.menuCd=="F" || menu.menuCd=="P" || menu.menuCd=="T"){
				if(depth==0){
					menuHtml += '\n							<ul class="dropdown txt-w">';
				}
				menuHtml += "\n								<li><a href=\"javascript:goMenuToBody('"+menu.menuId/*svcUrl+"', '"+menu.menuCd+"', '"+menu.msgView*/+"')\">· "+menu.msgView+"</a></li>";
				depth=1;
			}
		}
		if(depth==1){
			menuHtml += '\n							</ul>\n<span class="dd-trigger"></span></li>';
		}else if(depth==0){
			menuHtml += "\n					</li>";
		}
		document.getElementById("menuTreeView").innerHTML = menuHtml;
		// $("#menuTreeView").html(menuHtml);
	}
};

/** Object Component의 value속성에 대한 한글입력 방지 처리 **/
this.gfnKeyBlock = function(obj, kind){
	// 좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
	if (event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46)
		return;

	obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
};

/** Object Component의 value속성에 대한 한글입력 방지 처리 **/
this.gfnKeyBlock = function(obj, kind){
	// 좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
	if (event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46)
		return;
	obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
};

/** Object Component의 value속성에 대한 한글입력 방지 처리 **/
this.gfnKeyCheck = function(obj, kind){
	// 좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
	if (event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46)
		return;
	obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
};

libFrame._clearRemarkAll = function(src){
	
	var result = "";
	var isSConst = false;  // '.....' Single String
	var isDConst = false;  // "....." Duble String
	var isExConst = false; // \? Exceptor String
	var isRegular = false; // /..../g Reqular Expression
	var isSRemark = false; // //      Single-line-Remark.
	var idxMRemark = -1; // /*...*/ Multi-line-Remark.
	for(var index=0; index<src.length; index++){
		var chr = src.charAt(index);
		var beChr = index<=0?"":src.charAt(index-1);
		var afChr = index+1>=src.length?"":src.charAt(index+1);
		if(isSRemark && chr=="\n"){
			isSRemark = false;result+=chr;continue;
		}
		if(idxMRemark>1 && beChr+chr=="*/"){
			idxMRemark = -1;continue;
		}
		if(isSRemark){
			continue;
		}else if(idxMRemark>-1){
			++idxMRemark;continue;
		}
		if(isExConst){
			isExConst = false;result+=chr;continue;
		}else if((isSConst || isDConst || isRegular) && chr=="\\"){
			isExConst = true;result+=chr;continue;
		}
		if(isSConst && beChr!="\\" && chr=="'"){
			isSConst = false;result+=chr;continue;
		}
		if(isDConst && beChr!="\\" && chr=='"'){
			isDConst = false;result+=chr;continue;
		}
		if(isRegular && beChr=="/" && chr=="g"){
			isRegular = false;result+=chr;continue;
		}
		if(!(isSConst || isDConst || isRegular)){
			if(chr=="/" && afChr=="/"){
				isSRemark = true;continue;
			}
			if(chr=="/" && afChr=="*"){
				idxMRemark = 0;continue;
			}
			if(chr=="'"){
				isSConst = true;
			}else if(chr=='"'){
				isDConst = true;
			}else if(chr=="/"){
				isRegular = true;
			}
			result+=chr;continue;
		}
		result+=chr;continue;
	}
	return result;
};

