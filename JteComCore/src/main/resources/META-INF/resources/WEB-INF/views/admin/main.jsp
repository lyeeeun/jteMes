<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html  style = "width: 100%; height: 100%;">
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
	<!-- 	아이콘	 -->
	<link href="<c:url value='/static/favicon.ico'/>" rel="shortcut icon">
	<!--	Font CSS    -->
	<link href="<c:url value='/static/font/nanumgothic.css'/>" rel="shortcut icon">
	
	
	<link href="<c:url value='/static/css/fontawesome/css/all.css'/>" rel="stylesheet" type="text/css">
	
<!-- 라이브러리 CSS -->
	<link href="<c:url value='/static/css/timeTo.css'/>" type="text/css" rel="stylesheet">
	<link href="<c:url value='/static/css/jqueryui/jquery-ui.css'/>" rel="stylesheet">
	<link href="<c:url value='/static/css/jqueryui/jquery-ui.theme.css'/>" rel="stylesheet">
	<link href="<c:url value='/static/css/kendoui/kendo.default.mobile.min.css'/>" rel="stylesheet">
	<link href="<c:url value='/static/css/kendoui/kendo.rtl.min.css'/>" rel="stylesheet">
	<link href="<c:url value='/static/css/kendoui/kendo.default.min.css'/>" rel="stylesheet">
	<link href="<c:url value='/static/css/kendoui/kendo.common.min.css'/>" rel="stylesheet">
	<link href="<c:url value='/static/css/kendoui/kendotheme.css'/>" rel="stylesheet">
	
<!-- 커스텀 공통  css(ComCore)	 -->
	<link href="<c:url value='/static/css/theme/theme.css'/>" rel="stylesheet">
	<link href="<c:url value='/static/css/theme/Basic_Form_theme.css'/>" rel="stylesheet">	
	<link href="<c:url value='/static/css/kendoui/customCommon.css'/>" rel="stylesheet">
	<link href="<c:url value='/static/css/kendoui/customDefault.css'/>" rel="stylesheet">
	
<!-- 프로젝트별 공통 CSS(resource) -->	
	<link href="<c:url value='/resources/mes/css/project/custom.css'/>" rel="stylesheet">
	
<!-- 라이브러리 js -->
	<script src="<c:url value='/static/js/jquery-3.4.1.min.js'/>"></script>
	<script src="<c:url value='/static/js/kendo.all.min.js'/>"></script>
	<script src="<c:url value='/static/js/tabber.js'/>"></script>
	<script src="<c:url value='/static/js/jquery-ui.min.js'/>"></script>
	<script src="<c:url value='/static/js/jszip.js'/>"></script>
	<script src="<c:url value='/static/js/jquery.form.js'/>"></script>
	<script src="<c:url value='/static/js/jquery-migrate-1.2.1.min.js'/>"></script>
	<script src="<c:url value='/static/js/jquery.inputmask.bundle.min.js'/>"></script>
	<script src="<c:url value='/static/js/jquery.serializeObject.js'/>"></script>
	
	<!--언어정보 -->
	<script src="/static/js/cultures/kendo.culture.ko-KR.js"></script>
<!-- 	<script src="/static/js/cultures/kendo.culture.en-US.js"></script> -->
	
	<!-- Countdown -->
	<script src="<c:url value='/static/js/jquery.time-to.js'/>"></script>
	<!-- RSA for Javascript -->
	<script type="text/javascript" src="<c:url value='/static/js/secure/jsencrypt.min.js'/>"></script>
	
	
	<!-- 공통 js	 -->
	<script src="<c:url value='/static/js/frame/libFrame.js'/>"></script>
	<script src="<c:url value='/static/js/frame/libUtil.js'/>"></script>
	<script src="<c:url value='/static/js/frame/libTabs.js'/>"></script>
	<script src="<c:url value='/static/js/frame/libTrans.js'/>"></script>
	<script src="<c:url value='/static/js/frame/libContent.js'/>"></script>
<%-- 	<script src="<c:url value='/static/js/pop/libPop.js'/>"></script> --%>
<%-- 	<script src="<c:url value='/static/js/pop/libPopTree.js'/>"></script> --%>
	<script src="<c:url value='/static/js/pop/libPop2.js'/>"></script>
	<script src="<c:url value='/static/js/pop/libPopTree2.js'/>"></script>
	<script src="<c:url value='/static/js/pop/msgPop.js'/>"></script>
</head>

<script>
	window.onload  = function() {
		//캐시 조회
		gfn_cacheSet();
		
		//
		$("#adminToolbar").kendoToolBar({
			items: [
				{ template : "<img src='/resources/mes/img/logo.png' style='height:100%;'>"},
				{ template : '<span id="adminLogout"><i class="fas fa-sign-out-alt"></i> <spring:message code = "html_logOut" text="로그아웃"></spring:message></span>', attributes : {"class" : "admin-toolBar-right"}},
				{ template : '<span id="adminReutrn"><i class="fas fa-sign-out-alt"></i> <spring:message code = "X" text="돌아가기"></spring:message></span>', attributes : {"class" : "admin-toolBar-right"} },
				{ template : '<span id="adminCacheClear"><i class="fas fa-user-cog"></i> <spring:message code = "X" text="캐시 초기화"></spring:message></span>', attributes : {"class" : "admin-toolBar-right"}}
				
				
			],
			style:{background:"blue"}
		});
		
		$.ajax({
			url : "/admin/menu",
			async :true,
			type:"POST",
			success : function(e){
				
				//penelBar에 들어갈 메뉴 데이터 생성 - tree구조 데이터  - 2021-03-09
				//var myRole = libUtil._myInfo.userInfo.roles;
				var treeJson = [];
				
				for(key in e.rows){
					var menu = e.rows[key];
					
// 					var roleInclude = false;
// 					for(key in myRole){
// 						if(menu.roleId.includes(myRole[key].roleId)){
// 							roleInclude = true; 
// 							break;
// 						}
// 					}
					
					//if(roleInclude){}
						//폴더인 경우 아이콘	
						var folderIcon = menu.menuCd == "F"? '<i class="fas fa-folder"></i>' : '';
						
						var insertNode = {
								"id" : menu.menuId,
								//"text" : folderIcon + "<span id='menuViewId_"+menu.menuId+"' class='menuCd-"+menu.menuCd+"'>"+menu.menuNm+"</span>",
								"text" : menu.menuNm,
								"items":''
						}
						//메뉴인 경우 클릭이벤트 추가
						if(menu.menuCd == "M"){
							insertNode.src ="javascript:menuLoad({menuId:\""+menu.menuId+"\", svcUrl:\""+menu.svcUrl+"\", msgId:\""+menu.menuNm+"\", msgView:\""+menu.menuNm+"\", menuCd:\""+menu.menuCd+"\", msgIdPath:\""+menu.menuNm+"\", msgViewPath:\""+menu.menuNm+"\", duplYn:\""+menu.duplYn+"\"})"; 
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
				
				//데이터 할당
				var inlineDefault = new kendo.data.HierarchicalDataSource({
					data: treeJson[0].items
				});
			
				$("#adminMenu").kendoMenu({
					dataSource: inlineDefault,
					dataTextField: "text",
					dataUrlField : "src",
					scrollable: true
				});
			}
		});
		
		//로그아웃버튼
		$("#adminLogout").click(function(){
			gfn_logout();
		});
		
		//돌아가기 화면
		$("#adminReutrn").click(function(){
			location.href = "/";
		});
		
		//캐시초기화 화면
		$("#adminCacheClear").click(function(){
			gfn_cacheRefresh();
		});
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
	
	function menuLoad(obj){
		gfn_loading(true);
		
		//메뉴아이디 저장
		$("#_currentMenuId").val(obj.menuId);
		$(".menuName").text(obj.msgId)
		$.ajax({
			url : obj.svcUrl,
			dataType : 'html', 
			async :true,
			type:"POST",
			success : function(e){
				$("#adminContent").html(e);
				//lfn_init함수가 있다면 실행
				if(typeof(lfn_init) == 'function') lfn_init();
			}
		});
		gfn_loading(false);
	}
	
</script>
<style>
	#grid-content{
		height: 100%;
	}
	
	#adminToolbar{
		display:block;
	}
	
	#adminToolbar > div{
		height:35px; 
		line-height:35px; 
		margin:5px; 
		margin-top: 7px;
	}
	
	.admin-toolBar-right{
		float:right;
	}
	#adminLogout,
	#adminReutrn,
	#adminCacheClear{
		cursor:pointer;
	}
	
	
</style>

<body style = "width: 100%; height: 100%;">
	<div id="mainBody" style="width: 100%; height: 100%; display:flex; flex-direction: column;">
		<div style="">
			<div id ="adminToolbar"  style= ""></div>
			<ul id="adminMenu" style= "background : darkgrey"></ul>
		</div>
<!-- 		<div class="bodyContents" style=" width:100%; max-width:1920px; padding : 5px; margin: 0 auto;"> -->
		<div class="bodyContents" style="flex : 1; padding : 5px; display:flex; flex-direction: column; overflow-y : auto;">
			<div class="menuName" style= ""></div>
			<div id="adminContent" style= "flex : 1;"></div>
			<div id="_commonPopup"></div>
		</div>
	</div>
	<div style="display:none;">
		<input type="hidden" id = "_currentMenuId"/>
	</div>
</body>
</html>

