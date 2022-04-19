<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<link href="<c:url value='/resources/mes/css/fragments/left.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/mes/css/fragments/header.css'/>" rel="stylesheet">

<script>
	var treeJson = [];
	var selectedItem;
	
	window.onload = function(){
		var $cfgDropLi = $("<li>");
		$cfgDropLi.append('<span><spring:message code = "top_greet"></spring:message> </span>');
		$cfgDropLi.append('<span><sec:authentication property="principal.userInfo.userNm"/>(<sec:authentication property="principal.username"/>)님!</span>');
		
		var $cfgDropUi = $("<ul>");
		
		$cfgDropUi.append('<li id="btnMyInfo"><i class="fas fa-user-cog"></i> <spring:message code = "html_updateInfo" ></spring:message></li>');
		
		console.log(libUtil);
		
		if(!gfn_isEmpty(libUtil._myInfo.userInfo.roles.find(element => element.roleId == "admin"))){
			$cfgDropUi.append('<li id="btnAdminSign"><i class="fas fa-sign-out-alt"></i> <spring:message code = "html_adminPage" text="관리자 페이지"></spring:message></li>');
		}
		
		$cfgDropUi.append('<li id="btnLogout"><i class="fas fa-sign-out-alt"></i> <spring:message code = "html_logOut"></spring:message></li>');
		
		$cfgDropLi.append($cfgDropUi);
		
		$("#user-config-dropdown").html($cfgDropLi);
		
		$("#user-config-dropdown").kendoMenu();
		
		//로그아웃 이벤트
		$("#btnLogout").click(function(){
			gfn_logout();
		});
		
		//정보수정 이벤트
		$("#btnMyInfo").click(function(){
			gfn_myConfigMod();
		});
		
		//관리자 페이지
		if(!gfn_isEmpty(libUtil._myInfo.userInfo.roles.find(element => element.roleId == "admin"))){ //admin 권한있는지체크
			$("#btnAdminSign").click(function(){
				location.href = "/admin/main";
			});			
		}
		
	}
	
	$(document).ready(function(){
		if(gfn_getCode("alarmYN").cdVal == "Y"){
			//알람 최소 생성(10분마다 리로드)
			gfn_getMyAlarm();
			setInterval(function(){gfn_getMyAlarm()},600 * 1000)
			$("#alarmArea").show();
		}
		//좌측메뉴 툴바
		$("#toolbar").kendoToolBar({
			items: [
				{ type: "button", icon: "menu", attributes: { "class": "k-flat" }, click: toggleDrawer},
				{ template: "<img src='resources/mes/img/logo.png' style='margin-left: 20px; height:35px; margin:5px; margin-top: 7px;'>" }, /* template: "<img src='resources/mes/img/sinmyeong_logo_png.png' style='margin-left: 20px; height:35px; margin:5px;'>" 여기서 로고 수정 */
				{ template: "<a class='header-manual' href="+gfn_getCode("manualPath").cdVal+" download>매뉴얼 다운로드</a>" }
			],
			style:{background:"blue"}
		});
		
		//overlay layout load
		$("#overlay-drawer").kendoDrawer({
		template: "<div class='left-area'>"+
			"<div id='panelbar' data-role='drawer-item'>메뉴없음</div>"+
			"<div id='menuPathNaviTop' style='display:none;'>Mes / <span>Loading...</span></div>"+
		"</div>",
		position: 'left',
		//모바일에서는 제거
		mode:"push",
		//itemClick, hide - 메뉴선택 시 레이아웃이 닫히는 문제 해결 하기 위함
		itemClick:function(e){
			selectedItem = e.item.find(".item-text").text()
		},
		hide: function(e) {
			if(typeof selectedItem == "string"){
				e.preventDefault();
			}
			selectedItem = null;
			$("#grid-content").css("max-width",'');
		},
		swipeToOpen: false
		}).data("kendoDrawer");
		
		
		
		//penelBar에 들어갈 메뉴 데이터 생성 - tree구조 데이터  - 2021-03-09
		var myRole = libUtil._myInfo.userInfo.roles;
		
		for(key in libUtil.menuList){
			var menu = libUtil.menuList[key];
			
			var roleInclude = false;
			for(key in myRole){
				if(menu.roleId.includes(myRole[key].roleId)){
					roleInclude = true; 
					break;
				}
			}
			
			if(roleInclude){
				//폴더인 경우 아이콘	
				var folderIcon = menu.menuCd == "F"? '<i class="fas fa-folder"></i>' : '';
				
				var insertNode = {
						"id" : menu.menuId,
						"text" : folderIcon + "<span id='menuViewId_"+menu.menuId+"' class='menuCd-"+menu.menuCd+"'>"+menu.menuNm+"</span>",
						"encoded": false,
						"expanded" : true,
						"items":''
				}
				//메뉴인 경우 클릭이벤트 추가
				if(menu.menuCd == "M"){
					insertNode.src ="javascript:goMenuToBody({menuId:\""+menu.menuId+"\", svcUrl:\""+menu.svcUrl+"\", msgId:\""+menu.menuNm+"\", msgView:\""+menu.menuNm+"\", menuCd:\""+menu.menuCd+"\", msgIdPath:\""+menu.menuNm+"\", msgViewPath:\""+menu.menuNm+"\", duplYn:\""+menu.duplYn+"\"})"; 
				}
				
				if(ufn_isNull(menu.upMenuId) ||menu.upMenuId == ""){
					treeJson.push(insertNode);
				}else{
					var node = ufn_findNode(treeJson, menu.upMenuId);
					if(!ufn_isNull(node)){
						node.push(insertNode);
					}
				}
			}
		}
		
		//데이터 할당
		var inlineDefault = new kendo.data.HierarchicalDataSource({
			data: treeJson
		});
		
		
		$("#panelbar").kendoTreeView({
			dataSource: inlineDefault,
			dataUrlField: "src"
		});

		
		$("#panelbar").prepend("<div id='menuFilterArea'>검색 : <input id= 'menuFilterText' type='text' class='k-textbox' style=''><button type='button' id= 'menuFilterBtn' class='k-button k-primary'>조회</button></div>");
		
		//setTimeout(function(){$('#menuViewId_productWork').click();}, 500); //Main
		setTimeout(function(){$('#menuViewId_home').click();},500); //Main
		
		
		//메뉴 검색 텍스트 엔터, 초기화 이벤트
		$("#menuFilterText").keyup(function(e) {
			if (e.keyCode == 13) {
				menuSearch();
			}else{
				if($("#menuFilterText").val().trim() == ""){
					menuSearch();
				}
			}
		});
		//매뉴 검색 버튼
		$("#menuFilterBtn").click(function() {
			menuSearch();
		});
	});
	
	//드로어 토글버튼 이벤트
	function toggleDrawer() {
		var drawerInstance = $("#overlay-drawer").data().kendoDrawer;
		var drawerContainer = drawerInstance.drawerContainer;

		if(drawerContainer.hasClass("k-drawer-expanded")) {
			drawerInstance.hide();
			$("#grid-content").css("max-width",'');
		} else {
			drawerInstance.show();
			setTimeout(function() { $("#grid-content").css("max-width",$(window).width() - ($("#panelbar").outerWidth(true)))}, 500);
		}
	}
	
	// tree구조 node 찾기
	function ufn_findNode(data, id){
		for(var i = 0; i < data.length; i++){
			if(data[i].id == id){
				if(typeof(data[i].items) == 'string'){
					data[i].items = [];
				}
				
				return data[i].items;
			}else if(typeof(data[i].items) == 'object'){
				var rtn = ufn_findNode(data[i].items, id);
				
				if(!ufn_isNull(rtn)){
					return rtn;
				}
			}
		}
		
		return null;
	}
	
	
	//null check
	function ufn_isNull(data){
		if(data == null || data == 'undefined'){
			return true;
		}else{
			return false;
		}
	}
	
	//메뉴검색 
	function menuSearch(){
		var query = $("#menuFilterText").val().toLowerCase().replace(/ /gi,'');
		var dataSource = $("#panelbar").data("kendoTreeView").dataSource;
		menuSearchfilter(dataSource, query);
		
		//좌측메뉴 selected 선택
		$("#panelbar .k-state-selected").each(function(index, item){
			$(this).removeClass("k-state-selected")
		});
		$("#menuViewId_"+$("#_currentMenuId").val()).closest("a").addClass("k-state-selected");
	}
	
	//메뉴 검색
	function menuSearchfilter(dataSource, query) {
		var hasVisibleChildren = false;
		var data = dataSource instanceof kendo.data.HierarchicalDataSource && dataSource.data();

		for (var i = 0; i < data.length; i++) {
		var item = data[i];
		var text = item.text.toLowerCase().replace(/ /gi,'');
		var itemVisible = query === true // parent already matches
			|| query === "" // query is empty
			|| text.indexOf(query) >= 0; // item text matches query

		var anyVisibleChildren = menuSearchfilter(item.children, itemVisible || query); // pass true if parent matches

		hasVisibleChildren = hasVisibleChildren || anyVisibleChildren || itemVisible;

		item.hidden = !itemVisible && !anyVisibleChildren;
		}

		if (data) {
			// Re-apply the filter on the children.
			dataSource.filter({ field: "hidden", operator: "neq", value: true });
		}
		
		return hasVisibleChildren;
	}
	
	//알람카운트
	this.gfn_getMyAlarm = function(){
		
		$("#alarmArea").html("");
		
		var alarmList = [];
		$.ajax({
			async:false,
			url : "alarm/getMyAlarmList",
			type: "POST",
			data: {alarmReceiver : "jkkim"},
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data.result != null){
					$(data.result).each(function(index, item){
						alarmItem = {};
						alarmItem.text = "<div>"+
											"<div style='font-size:16px; font-weight:600'>" + item.alarmTitle + "</div>" +
											"<div style='font-size:13px; font-weight:450'>" + item.alarmContent + "</div>" +
											"<div style='font-size:11px; font-weight:300; text-align: right;'>" + item.alarmSendDate + "</div>" +
										"</div>";
						alarmItem.encoded = false;
						
						if(item.alarmStatus != "NEW"){
							alarmItem.cssClass =  "alarmUnit-read";
						}else{
							alarmItem.cssClass =  "alarmUnit";
						}
						
						alarmItem.attr = {alarmId : item.alarmId, mnUrl : item.alarmUrl};
						alarmList.push(alarmItem);
					});
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		var alarmDataSource = new kendo.data.HierarchicalDataSource({
			encoded: false,
			data: [{
				text: '<span class="k-icon k-i-email"></span> <span id="alarmBadge"></span>',
				encoded : false,
				items: alarmList
			}]
			
		});
		
		$("#alarmArea").kendoMenu({
			dataSource: alarmDataSource,
			openOnClick: {
				rootMenuItems: true
			},
			select : function(e){
				var mnUrl = $(e.item).attr("mnUrl");
				if(!gfn_isNull(mnUrl)){
					//메뉴이동
					$('#menuViewId_'+mnUrl).click();
					//알람 읽음 표시
					$.ajax({
						async:false,
						url : "alarm/setMyAlarmRead",
						type: "POST",
						data: JSON.stringify({
							alarmId : $(e.item).attr("alarmId"),
							alarmStatus : "READ"
						}),
						traditional :true,
						contentType : 'application/json',
						dataType : 'json',
						success: function(data){
							if(data != null){
								if(data > -1){
									gfn_getMyAlarm();
								}
							}
						},error: function(ex){
							gfn_loading(false);
							console.error(gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요."));
						}
					});
				
				}
			}
		});
		
		$.ajax({
			async:false,
			url : "alarm/getMyAlarmCount",
			type: "POST",
			data: {alarmReceiver : "jkkim"},
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != null){
					if($("#alarmBadge").attr("data-role") == "badge"){
						$("#alarmBadge").html(data);
					}else{
						 $('#alarmBadge').kendoBadge({
							color: 'primary',
							shape: 'rectangle',
							size : 99
						});
						 
						$("#alarmBadge").html(data > 99 ? "99+" : data);
					}
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
</script>

<!-- 	최상단 -->
	<div class="my-config-area" >
		<ul id = "user-config-dropdown">
<!-- 			<li> -->
<%-- 				<span><spring:message code = "top_greet"></spring:message> </span> --%>
<!-- 				<span><sec:authentication property="principal.userInfo.userNm"/>(<sec:authentication property="principal.username"/>)님!</span> -->
<!-- 				<ul> -->
<!-- 					<li id="btnMyInfo"> -->
<!-- 					정보수정 -->
<%-- 						<i class="fas fa-user-cog"></i> <spring:message code = "html_updateInfo" ></spring:message> --%>
<!-- 					</li> -->
<!-- 					<li id="btnLogout"> -->
<!-- 					로그아웃 -->
<%-- 						<i class="fas fa-sign-out-alt"></i> <spring:message code = "html_logOut"></spring:message> --%>
<!-- 					</li> -->
<!-- 					<li id="btnAdminSign"> -->
<!-- 					관리자 페이지 -->
<%-- 						<i class="fas fa-sign-out-alt"></i> <spring:message code = "html_adminPage" text="관리자 페이지"></spring:message> --%>
<!-- 					</li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
		</ul>
		<ul id="alarmArea" style="display:none;"><li><span class="k-icon k-i-email" ></span><span id="alarmBadge"></span></li></ul>
		<div style="float:right;">
			<a id="btnTimeAdd">사용시간 연장</a>		
			<span id="sessionCountdown"></span>
		</div>
		
		<spring:eval expression="T(jin.mes.common.cache.CacheUtil).getCode('sys.flag.reflash', 600)" var="cacheTimeout" />
	</div>
	<!-- 	툴바	 -->
	<div id ="toolbar"></div>
	<!-- 	좌측메뉴 -->
	<div id="overlay-drawer">
		<div class="drawer-content" style="width:100%;">
		
			<!--가로 고정값 삭제(kos-임베딩)-->
			<div class="container-fluid text-center" style=" width:100%;max-width:1920px;margin: 0 auto; position: relative;">
				<div id="bodyContents">
					<div id="subContents"></div>
				</div>
				<div id="_commonPopup"></div>
			</div>
		</div>
	</div>