
/**
 *  /bizNaru/lib/libTabs.js
 */

var libTabs = {};

libTabs._tabObj;
//libTabs._nowTabCnt = -1; 의미 없을듯.
libTabs._tabIdPrefix = "__bnTabs_";
libTabs._tabMax = 15;
libTabs._tabs = new Array(libTabs._tabMax + 1); // 마지막의 항상 비어있는 인덱스를 제공한다.
for(var i=0;i<libTabs._tabMax;++i){
	libTabs._tabs[i] = {};
}
libTabs._nowTabNum = -1;
libTabs._nowTabName = null;

libTabs._fnAddTab = libTabs._fnMoveL = libTabs._fnMoveR = libTabs._fnDelTab = function(){}; // 함수 미리 선언.

libTabs._fnGetNowTabCnt = function(){
	for(var i=0;i<libTabs._tabs.length;++i){
		if(typeof libTabs._tabs[i] == "object" && typeof libTabs._tabs[i].id == "string" && $("#"+libTabs._tabs[i].id).length>0){
			continue;
		}
		return i;
	}
}


libTabs._fnTabInit = function(){
	
	// tabs.Initialize...
	if(libTabs._tabMax > 1){
		
		/*************************************************
		 * Tabs를 사용하면 Tabs DIV를 삽입한다.
		 *************************************************/
		if(!document.getElementById("subContentsTabMain")){
			document.getElementById("subContents").innerHTML = '<div id="subContentsTabMain" class="tabberlive"><ul id="_tabControl" class="tabbernav links_area"></ul><div id="_tabBody"></div></div>';
		}
		
		libTabs._tabObj = $( "#subContentsTabMain" ).tabs({
			activate: function( event, ui ) {
				var nowTotTabCnt = libTabs._fnGetNowTabCnt();
				for(var index=0;index<nowTotTabCnt;++index){
					if(libTabs._tabs[index].id==ui.newPanel[0].id){
						console.log("Change Tab to " + ui.newPanel[0].id + "  ||:::||  Change Index to [" + libTabs._nowTabNum + " >>> " + index + "]");
						
						/*** 이전 탭 Object 백업 ***/
						if(libTabs._nowTabNum>=0 && libTabs._tabs.length > libTabs._nowTabNum && typeof libTabs._tabs[libTabs._nowTabNum] == "object" && typeof libTabs._tabs[libTabs._nowTabNum].id == "string"){
							let tabId = libTabs._tabs[libTabs._nowTabNum].id;
//							for(var item in libFrame._FRAME[tabId]){
//								if(item && typeof item == "string" && item.length>=7
//										&& (item.substring(0,3) == "lo_") // 변수는 변경가능성이 있으므로 복구하면... ? localScope에서 작업하던 경우는 문제가 생김.
//										&& typeof libFrame._FRAME[tabId][item] == "object"
//										&& typeof eval("window." + item) == "object"
//											){
//									libFrame._FRAME[tabId][item] = eval("window." + item);
//								}
//							}
							//HTML테그기준으로 수정된 사항도 백업할 수 없으므로 소속모든 ID명을 {tab.Hide.원래ID명:value값} 으로 처리한다.
//							libFrame._FRAME[tabId]._savedHtml = document.getElementById(tabId).innerHTML; //  = libFrame._menuObj[menuInfo.jsNm].htmlData
//							document.getElementById(tabId).innerHTML = ""; //  = libFrame._menuObj[menuInfo.jsNm].htmlData
							
							var tabIdElements = $("#" + tabId);
							var arrInTab = tabIdElements.find("*");
							libFrame._FRAME[tabId].arrBackIds = [];
							libFrame._FRAME[tabId].arrBackClasses = {};
							for(var i=0;i<arrInTab.length;++i){
								var id = arrInTab[i].id;
								if(!gfn_isEmpty(id) && !gfn_isEmpty(id.replace(/[^A-Za-z_]/g, ""))){
									var backId = "_tabBack_" + id;
									libFrame._FRAME[tabId].arrBackIds.push(backId);
									//console.log("Tab[" + libTabs._nowTabNum + ":'" + tabId + "'] Changed backup id : " + id + " => " + backId);
									tabIdElements.find("#"+id).attr("id", backId);
//									var className = arrInTab[i].className;
//									if(!gfn_isEmpty(className) && !gfn_isEmpty(className.replace(/[^A-Za-z_]/g, "")) && className.indexOf("DateTmp")>-1){
//										libFrame._FRAME[tabId].arrBackClasses[backId] = className;
//										console.log("\t>>> Tab[" + libTabs._nowTabNum + ":'" + tabId + "'] Changed backup className : {" + backId + " : '" + className + "'}");
//										arrInTab[i].className = ""; // tabIdElements.find("#"+id).attr("className", "");
//									}
								}
							}
							
						}
						
						/*** 신규 탭 Object, Function 변경 ***/
						let tabId = libTabs._tabs[index].id;
//						for(var item in libFrame._FRAME[tabId]){
//							if(item && typeof item == "string" && item.length>=7 && item!="lfn_init"  && item!="lfn_close" 
//									&& (item.substring(0,4) == "lfn_" 
//										|| item.substring(0,3) == "lo_") // 변수는 문제가 생김.
//									&& libFrame._FRAME[tabId][item] 
//									// 전역변수 빈값을 인정해준다.
////									&& (typeof libFrame._FRAME[tabId][item] == "function" 
////										|| typeof libFrame._FRAME[tabId][item] == "object")
//										){
//								eval("window." + item + " = libFrame._FRAME[tabId][item]");
//								if(item=="lfn_fnSearch"){
//									console.log(eval("window." + item));
//								}
//							}
//						}
						if(gfn_isEmpty(document.getElementById(tabId).innerHTML)){
//							document.getElementById(tabId).innerHTML = libFrame._FRAME[tabId]._savedHtml; // 복구
//							// 원본 : document.getElementById(tabId).innerHTML = libFrame._menuObj[menuInfo.jsNm].htmlData
						}
						if(!gfn_isEmpty(libFrame._FRAME[tabId].arrBackIds)){
							//HTML테그기준으로 수정된 사항도 복구하면 기본값만 셋팅되므로 소속모든 ID명을 {tab.Hide.원래ID명:value값} 원래명으로 처리한다.
							for(var i=0;i<libFrame._FRAME[tabId].arrBackIds.length;++i){
								var id = libFrame._FRAME[tabId].arrBackIds[i];
								if(!gfn_isEmpty(id) && id.startsWith("_tabBack_")){
									var restoreId = id.substring(9);
									//console.log("Tab[" + index + ":'" + tabId + "'] Restored backup id : " + id + " => " + restoreId);
									$("#" + tabId).find("#"+id).attr("id", restoreId);
//									if(!gfn_isEmpty(libFrame._FRAME[tabId].arrBackClasses[id])){
//										console.log("Tab[" + index + ":'" + tabId + "'] Restored backup className : {" + id + " : '" + libFrame._FRAME[tabId].arrBackClasses[id] + "'}");
//										tabIdElements.find("#"+restoreId).className = libFrame._FRAME[tabId].arrBackClasses[id]; // $("#" + tabId).find("#"+id).attr("className", libFrame._FRAME[tabId].arrBackClasses[id]);
//									}
								}
							}
							libFrame._FRAME[tabId].arrBackIds = [];
							libFrame._FRAME[tabId].arrBackClasses = {};
							
						}
					
						libTabs._nowTabName = libTabs._tabs[libTabs._nowTabNum = index].jsNm
						$(".menuName").html(libTabs._tabs[index].msgView);
						if(document.getElementById("menuPathNaviTop"))
							document.getElementById("menuPathNaviTop").innerHTML = libTabs._tabs[index].msgViewPath.split(" > ").join(" / <span>") + "</span>";
						
						//탭 이동 시 Grid Resize
						gfn_gridResize();
						break;
					}
				}
			}
		});
		
//		// tab추가
//		$("#btnAddTab").click(function(){
//			libTabs._fnAddTab();
//		});
//		
//		// 왼쪽으로 탭이동
//		$("#btnMoveL").click(function(){
//			libTabs._fnMoveL();
//		});
//		
//		// 오른쪽으로 탭이동
//		$("#btnMoveR").click(function(){
//			libTabs._fnMoveR();
//		});
//		
//		$("#fragment-1-del").click(function(){
//			libTabs._fnDelTab("fragment-1");
//		});
//		
//		$("#fragment-2-del").click(function(){
//			libTabs._fnDelTab("fragment-2");
//		});
//		
//		$("#fragment-3-del").click(function(){
//			libTabs._fnDelTab("fragment-3");
//		});
	}
	
};


libTabs._fnAddTab = function(menuInfo, data, callback){
	
	// 인수정보 ::: 
	// "{"viewId":"004","upViewId":"002","menuId":"basMgt_codeMgt","msgView":"코드관리","stUrlNm":null,"childCount":null,"msgViewPath":"기본관리 > 코드관리"
	// ,"sortOdrg":1,"level":2,"idPath":",000,1000,1100","menuCd":"F","svcUrl":"/form/basMgt/codeMgt"}"
	
	var nowTotTabCnt = libTabs._fnGetNowTabCnt();
	
	// 1. 최대 TAB까지 왔는지 체크한다.
	if(nowTotTabCnt>=libTabs._tabMax){
		gfn_msgBox({msg:"탭은 최대 " + libTabs._tabMax + "개까지 열수있습니다.\n기존 탭을 종료하시고 다시 시도해주세요."});
		return;
	}
	
	// 2. 중복오픈 메뉴가 아니면 이미 열린 메뉴가 있는지 체크한다.
	// 2-1. 열린 메뉴가 있다면 해당 메뉴를 선택하고 null을 return한다.
	for(var index=0;index<nowTotTabCnt;++index){
		if(libTabs._tabs[index].jsNm == menuInfo.jsNm){
			// 이미 열려있다.
			if(menuInfo.duplYn=="Y"){
				// 중복오픈메뉴이므로 탭추가를 진행한다.
				break;
			}else{
				// 중복오픈 불가이므로 해당탭을 선택하고 탈출한다.
				libTabs._tabObj.tabs("option", "active", index); // 추가된 탭으로 이동.
				return;
			}
		}
	}
	
	
	var ul = libTabs._tabObj.find("#_tabControl"); // ( "ul" ); TAG로 찾으면 다른것들이 걸리므로 유일한 ID로 찾게 변경함.
	var tabBody = $( "#_tabBody" );
//	++libTabs._nowTabCnt; 의미 없을듯.
	// 추가하고자 하는 탭의 Index는 nowTotTabCnt의 값이 된다.
	var addIdx = nowTotTabCnt;
	libTabs._tabs[addIdx] = gfn_objCopy(menuInfo);
	
	// 추가탭의 고유ID
	var tabId = libTabs._tabs[addIdx].id = libTabs._tabIdPrefix+"_"+menuInfo.jsNm+"_"+new Date().getTime();
	data.tabId = tabId;
	data.formId = menuInfo.jsNm;

	// 컨트롤탭 추가                                   menuInfo.msgViewPath             style="cursor:pointer" 포인터만 변경하는 것도 고려해볼만함. id컨트롤 안하고 onclick이벤트 줌.
	var tabMenuCtrl = '<li id="'+tabId+'-li" class="link"><span><a href="#'+tabId+'" class="txt" title="'+menuInfo.msgViewPath+'">'+menuInfo.msgView+'</a>';
	
	//Home이 아닐 경우에만 메뉴명 표시 ( 임시로 HOME 하드코딩, 이후 HOME ICON으로 변경 예정 ) _191211_PGW
	if(menuInfo.jsNm == "formHome"){
		var tabMenuCtrl = '<li id="'+tabId+'-li" class="home_tab link" style="background: #00498c; border: none;"><span><a href="#'+tabId+'" class="txt" title="'+menuInfo.msgViewPath+'">'+
			'<img class="ui-icon-home" src="/resources/mes/img/ico_home.png"/ style="padding-top:0.03em; padding-bottom:0.05em;">'+'</a>';
	}else{ 
		var tabMenuCtrl = '<li id="'+tabId+'-li" class="txt link"><span><a href="#'+tabId+'" class="txt" title="'+menuInfo.msgViewPath+'">'+menuInfo.msgView+'</a>';
	}
	
	//Home이 아닐 경우만 Tab 삭제 가능하도록 _191211_PGW
	if(menuInfo.jsNm != "formHome"){ 
 		// class 추가 ui-icon ui-icon-circle-close -> jqueryUI 닫기 아이콘 사용 위해 _191211_PGW
		// class 변경 fas fa-times -> jqueryUI 닫기 아이콘 변경 _200410_LYM
		tabMenuCtrl += '<a href="javascript:void(0);" class="del fas fa-times" title="['+menuInfo.msgView+'] 닫기" onclick="libTabs._fnDelTab(\''+tabId+'\');"></a></span></li>';
	}
	
	$( tabMenuCtrl ).appendTo( ul );
	// 탭바디 추가
	$( "<div id='"+tabId+"'><br><br><br><span><p>...["+menuInfo.msgViewPath+"] 메뉴화면을 불러오는 중입니다...</p></span></div>" ).appendTo( tabBody );

	libTabs._tabObj.tabs( "refresh" );
//	$("#"+tabId+"-del").click(function(){ // id컨트롤 안하고 onclick이벤트 줌.
//		libTabs._fnDelTab(tabId);
//	});

//	libTabs._tabObj.tabs("option", "active", addIdx); // 추가된 탭으로 이동.

	// return tabId;
	// 화면이 그려질 Child영역 정의
	libFrame._FRAME[tabId] = {tabId:tabId, menuId:menuInfo.jsNm};// $("#"+tabId);

	/**********************************************************
	 * 해당 ID에 대해서 메뉴화면을 바로 붙여넣고 null을 반환하자.
	 * Single화면과 별도로 처리되게 구성하자.
	 **********************************************************/
	libFrame._menuObj[menuInfo.jsNm].tabsIdList.push(tabId);// 중복으로 열릴수있으므로 추가한다.
	libFrame._loadHtmlJs.call(this,tabId,menuInfo.jsNm,menuInfo.htmlUrl,menuInfo.jsUrl,function(menuObj){
		if(typeof menuInfo == "object" && menuInfo.isNewWin == true) {
			/******************************************************************
			 * 메뉴 클릭시 메뉴와 관련된 화면이 새창으로 뜨거나 
			 * 내부팝업등으로 띄울때 처리하는 케이스임.
			 * 구현 미정.
			 ******************************************************************/
			return;
		}

		/*** 화면을 삽입한다. ***/
		document.getElementById(tabId).innerHTML = libFrame._menuObj[menuInfo.jsNm].htmlData; // 화면을 삽입한다.
		
		libTabs._tabObj.tabs("option", "active", addIdx); // 초기화 전에 추가된 탭으로 이동한 후 로직을 수행해야 에러가 발생하지 않는다.
		
/*** ☆★☆★☆★☆★☆★☆ 여기서부터 현재탭이라는 정보가 필요하다. libTabs._tabs[libTabs._nowTabNum].id ★☆★☆★☆★☆★☆★ ***/
//setTimeout(function(menuInfo, tabId, data){
	
		/*** 화면의 로직을 삽입한다. ***/
		libFrame._menuObj[menuInfo.jsNm].jsFn.call(libFrame._FRAME[tabId]); // 자바스크립트 로컬윈도우(메뉴) 화면 전용함수 생성.
		if(!gfn_isEmpty(libFrame._menuObj[menuInfo.jsNm].jsMember)){
			for(var key in libFrame._menuObj[menuInfo.jsNm].jsMember){
				try {
					eval("libFrame._FRAME[tabId][key] = " + libFrame._menuObj[menuInfo.jsNm].jsMember[key]);
				} catch (e) {
					console.error("FormId[", menuInfo.jsNm, "], 전역변수Loading중 에러, errorPosition : libFrame._FRAME['"+tabId+"']['"+key+"'] = \"libFrame._menuObj['"+menuInfo.jsNm+"'].jsMember['"+key+"']\"");
					throw e;
				}
			}
		}
		if(typeof data != "object" || data.isMenu != true){
			libFrame._menuObj[menuInfo.jsNm].jsFn.call(gfn_myTab()); // 소속 화면의 서브load이면 소속 화면에 한번더 import한다.
			if(!gfn_isEmpty(libFrame._menuObj[menuInfo.jsNm].jsMember)){
				for(var key in libFrame._menuObj[menuInfo.jsNm].jsMember){
					try {
						eval("gfn_myTab()[key] = " + libFrame._menuObj[menuInfo.jsNm].jsMember[key]);
					} catch (e) {
						console.error("FormId[", menuInfo.jsNm, "], 전역변수Loading중 에러, errorPosition : gfn_myTab()['"+key+"'] = \"libFrame._menuObj['"+menuInfo.jsNm+"'].jsMember['"+key+"']\"");
						throw e;
					}
				}
			}
		}

		let addLetVar = "";

		/******************************************************************************************************/
		/******************************************************************************************************/
		/******************************************************************************************************/
		/*** 단일화면에서만 사용하던 전역변수화 로직을 일단 살려둔다. 
		 * 왜냐하면 화면로직내의 내부함수가 this.로 호출되어야 하는데 
		 * this.가 빠져서 전역으로 복사해줘야 당장 실행된다. 
		 * 여러 탭이 서로다른 변수/함수명을 사용하면 출돌하지 않치만 출돌할 여지가 있으며
		 * , 다중탭을 사용할땐 무조건 충돌한다. 
		 * 함수는 관련없지만, 변수/오브젝트는... ***/
/*** JSP적용을위한 ***/
//		console.debug("로컬화면의 로직을 ROOT로 올린다(임시) ::: libFrame._FRAME['"+tabId+"']");
//		for(var item in libFrame._FRAME[tabId]){
//			// console.debug(item + ":::::>" + libFrame._FRAME["codeListForm"][json]);
//			if(item && typeof item == "string" && item.length>=7 && item!="lfn_init"  && item!="lfn_close" 
//					&& (item.substring(0,4) == "lfn_" 
//						|| item.substring(0,3) == "lo_") // 변수는 문제가 생김.
//					&& libFrame._FRAME[tabId][item] 
//					// 전역변수 빈값을 인정해준다.
////					&& (typeof libFrame._FRAME[tabId][item] == "function" 
////						|| typeof libFrame._FRAME[tabId][item] == "object")
//						){
//
//				// 전역으로 올리는 행위를 안해도 되나? this[item] = libFrame._FRAME[tabId][item];
//
//				addLetVar += "let " + item + " = this." + item + ";\n";
//
//			}
//		}

//		// let 사용하여 화면Scope에 가두자... 함수 재선언.
//		eval("libFrame._menuObj['"+menuInfo.jsNm+"'].jsFn = function(){\nvar root = this;\n" + libFrame._menuObj[menuInfo.jsNm].jsData + "\n" + addLetVar + "};\n");
//		/*** 화면의 로직을 !!!재!!! 삽입한다. ***/
//		libFrame._menuObj[menuInfo.jsNm].jsFn.call(libFrame._FRAME[tabId]); // 자바스크립트 로컬윈도우(메뉴) 화면 전용함수 생성.
//		/*** 공통전역함수를 Local.Scope에 붙여준다.(호환성을 위해) ***/
//		for(var item in window){
//			if(item && typeof item == "string" && item.length>=7 && item.substring(0,4) == "gfn_"){
//				eval("libFrame._FRAME[tabId]."+item + " = window." + item);
//			}
//		}
		/******************************************************************************************************/
		/******************************************************************************************************/
		/******************************************************************************************************/

		/******************************************************************
		 * 메뉴접근에 대한 이력 남기기... @Async 이지만 처리순서의 
		 * "일반적보장"을 위해서 화면오픈 처리 이후에 초기화를 수행한다.
		 * 향 후 JSP로 변경시 Controller에서 처리하고 삭제해야 한다.
		 ******************************************************************/
		console.log("☆○★ 화면로드정보 : " + JSON.stringify(data));
		if(typeof data == "object" && data.isMenu == true && libFrame._menuObj[menuInfo.jsNm] && libFrame._menuObj[menuInfo.jsNm].srcType != "JSP" && libFrame._menuObj[menuInfo.jsNm].menu)
			$.ajax({url: this.gfn_getUri('/onmCommon/addUseHist'+libFrame._menuObj[menuInfo.jsNm].menu)});

		/******************************************************************
		 * 대상화면에 초기화함수가 있으면 실행해준다. 메뉴오픈시 전달한 인수도 넣어준다.
		 ******************************************************************/
		if(typeof libFrame._FRAME[tabId].lfn_init == 'function'){
			/*** JSP적용을위한 ***/
			//libFrame._FRAME[tabId].lfn_init.call(libFrame._FRAME[tabId], data);//(libFrame._FRAME[jsNm]);
			if(typeof data != "object" || data.isMenu != true){
				try {
					libFrame._FRAME[tabId].lfn_init.call(gfn_myTab(), data); // 소속 화면의 서브load이면 소속 화면에 한번더 import한다.
				} catch (e) {
					console.error("FormId[", menuInfo.jsNm, "], SUB_화면초기화 함수 실행 중 에러, errorPosition : libFrame._FRAME['"+tabId+"'].lfn_init.call(gfn_myTab(), "+JSON.stringify(data)+")");
					throw e;
				}
			}else{
				try {
					libFrame._FRAME[tabId].lfn_init.call(libFrame._FRAME[tabId], data);
				} catch (e) {
					console.error("FormId[", menuInfo.jsNm, "], MAIN_화면초기화 함수 실행 중 에러, errorPosition : libFrame._FRAME['"+tabId+"'].lfn_init.call(libFrame._FRAME['"+tabId+"'], "+JSON.stringify(data)+")");
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
				callback.call(libFrame._FRAME[tabId], data);
			} catch (e) {
				console.error("FormId[", menuInfo.jsNm, "], Loading화면 초기화 후 호출단 콜백에서 에러, errorPosition : callback.call(libFrame._FRAME['"+tabId+"'], "+JSON.stringify(data)+")");
				throw e;
			}
		}

		this.gfn_loading(false);

		
//}, 5300, menuInfo, tabId, data);

		return true;
	});

};

libTabs._fnDelTab = function(tabId, afterTabId){
	var nowTotTabCnt = libTabs._fnGetNowTabCnt();
	var index=0;
	for(;index<nowTotTabCnt;++index){
		if(libTabs._tabs[index].id==tabId){
			// 탭 삭제를 진행한다.
			break;
		}
	}
	if(index>=nowTotTabCnt){
		console.warn("삭제할 탭이 없습니다. "+tabId);
		return;
	}

	/**********************************************************
	 * 삭제대상 탭을 보고있지 않으면 삭제대상 탭으로 먼저 이동한다.
	 **********************************************************/
	if(gfn_myTab().tabId != tabId){
		for(var i=0;i<nowTotTabCnt;++i){
			if(libTabs._tabs[i].id==tabId){
				afterTabId = gfn_myTab().tabId;
				libTabs._tabObj.tabs("option", "active", i); // 삭제탭으로. -1로 이동하면 마지막 탭으로 이동됨.
				console.log("탭삭제시 삭제할 탭을 선택하지 않아 선택 후 탭삭제를 다시 시도함. 삭제대상탭ID["+tabId+"], 선택중인탭ID["+afterTabId+"]");
				setTimeout(function(){libTabs._fnDelTab(tabId, afterTabId);}, 50); // 0.05초 이후에 다시 삭제를 진행한다.
				return;
			}
		}
	}

	/**********************************************************
	 * 삭제해도 되는지 체크한다.(작업이 진행중인지 체크)
	 **********************************************************/
	if(typeof libFrame._FRAME[tabId].lfn_close == 'function'){
		var closeResult = libFrame._FRAME[tabId].lfn_close.call(libFrame._FRAME[tabId]); // (libFrame._FRAME[jsNm]);
		if(closeResult==false)
			return false; // 새로운 화면을 열지 않고 이전(현재)화면에서 멈춘다.
	}


	$('#'+tabId+'-li').remove(); // tab컨트롤러 삭제.
	$('#'+tabId).remove(); // tabBody삭제.
	libFrame._menuObj[libTabs._tabs[index].jsNm].tabsIdList.pop(tabId); // 타겟정보에서 해당 화면id 삭제.
	delete libFrame._FRAME[tabId] // 실제 메모리에서도 해당 화면 삭제.
	
//	--libTabs._nowTabCnt; 의미 없을듯.
	for(var i = index;i<libTabs._tabMax;++i){
		libTabs._tabs[i] = libTabs._tabs[i+1]; // 삭제에 의한 Index를 하나씩 줄여준다.
	}
	libTabs._tabObj.tabs( "refresh" );
	nowTotTabCnt = libTabs._fnGetNowTabCnt();
	if(nowTotTabCnt>0 && !gfn_isEmpty(afterTabId)){
		for(var i=0;i<nowTotTabCnt;++i){
			if(libTabs._tabs[i].id==afterTabId){
				libTabs._tabObj.tabs("option", "active", i); // 삭제탭으로. -1로 이동하면 마지막 탭으로 이동됨.
				console.log("탭삭제시 삭제할 탭을 선택하지 않아 선택 후 탭삭제한 후 원래 선택하던 탭으로 다시 돌아온다. 삭제대상탭ID["+tabId+"], 선택중인탭ID["+afterTabId+"]");
				return;
			}
		}
	}
	if(nowTotTabCnt>0){
		libTabs._tabObj.tabs("option", "active", index>=nowTotTabCnt?index-1:index); // 남은 탭으로 이동. -1로 이동하면 마지막 탭으로 이동됨.
	}else{
		libTabs._nowTabNum = -1;
	}
	// libTabs._nowTabNum = libTabs._tabObj.tabs( "option", "active" ); // 위 refresh에서 자동으로 activate 이벤트가 수행되어 현재index가 갱신되므로 이코드는 필요없다.
};





libTabs._fnMoveL = function(){
//	if(libTabs._nowTabNum<=0){
//		alert("더이상 움직일 수 없습니다.");
//		return;
//	};
	var nowTotTabCnt = libTabs._fnGetNowTabCnt();
	var nextTabNo = libTabs._nowTabNum - 1;
	if(nextTabNo<0){
		nextTabNo = nowTotTabCnt -1;
	}
	while(true){
		if( $('#'+libTabs._tabs[nextTabNo].id+'-li').length
			&& $('#'+libTabs._tabs[nextTabNo].id).length){
			libTabs._nowTabNum = nextTabNo;
			libTabs._tabObj.tabs("option", "active", libTabs._nowTabNum); // 해당 탭으로 이동.
			return;
		}else if(nextTabNo<=0){
			alert("삭제되어 더이상 움직일 수 없습니다.");
			return;
		}
		--nextTabNo;
	}
};

libTabs._fnMoveR = function(){
//	if(libTabs._nowTabNum+1>=libTabs._tabMax){
//		alert("더이상 움직일 수 없습니다.");
//		return;
//	};
	var nowTotTabCnt = libTabs._fnGetNowTabCnt();
	var nextTabNo = libTabs._nowTabNum + 1;
	if(nextTabNo>=nowTotTabCnt){
		nextTabNo=0;
	}
	while(true){
		if( $('#'+libTabs._tabs[nextTabNo].id+'-li').length
			&& $('#'+libTabs._tabs[nextTabNo].id).length){
			libTabs._nowTabNum = nextTabNo;
			libTabs._tabObj.tabs("option", "active", libTabs._nowTabNum); // 해당 탭으로 이동.
			// libTabs._tabObj.tabs( "refresh" );
			return;
		}else if(nextTabNo+1>=libTabs._tabMax){
			alert("삭제되어 더이상 움직일 수 없습니다.");
			return;
		}
		++nextTabNo;
	}
};





