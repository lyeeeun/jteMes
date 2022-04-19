<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="description" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Mes Homepage</title>

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
	<script src="<c:url value='/static/js/pop/libPop.js'/>"></script>
 	<script src="<c:url value='/static/js/pop/libPopTree.js'/>"></script>
<%-- 	<script src="<c:url value='/static/js/pop/libPop2.js'/>"></script> --%>
	<%-- <script src="<c:url value='/static/js/pop/libPopTree2.js'/>"></script> --%>
	<script src="<c:url value='/static/js/pop/msgPop.js'/>"></script>
	
</head>

<script type="text/javascript">
//창닫기, 새로고침, 다른페이지 이동시 로그아웃 처리(안된다..)
// 	jQuery(window).on("close", function () {
// 		if (self.screenTop > 9000) {
// 			gfn_logout();
// 		} else {
// 			if(document.readyState == "complete") {
// 			} else if(document.readyState == "loading") {
// 				gfn_logout();
// 			}
// 		}
// 		return "나가시겠습니까?";
// 	});

	
	//Grid Resize 공통
	$(window).resize(function(){
		gfn_gridResize();
		
		//메뉴영역 높이 조정
		gfn_menuResize();
	});
	
	
	//현재 세션 남은시간 조회
	function getSessionTime(){
		$.ajax({
			url: "<c:url value='/common/session/time'/>",
			type:'POST',
			async: false,
			success:function(data, statusText, xhr){
				//$('#sessionCountdown').timeTo(new Date(data.lastTime+(data.maxTime*1000)), function(){
				$('#sessionCountdown').timeTo(data.maxTime, function(){
					gfn_logout('session');
					//버튼을 눌러야만 로그아웃 처리됨.. 새로고침시 세션유지되는현상
					/* gfn_msgBox({
						msg:"사용시간이 만료되어 로그아웃합니다.", 
						yes : function(){gfn_sessionLogout();},
						done : function(){gfn_sessionLogout();} 
					}); */
				});
			}
		});
	}
		
	//사용시간 연장
	function resetSessionTime(){
		$.ajax({
			url: "<c:url value='/common/session/reset'/>",
			type:'POST',
			async: false,
			success:function(data, statusText, xhr){
				$('#sessionCountdown').timeTo(data.maxTime, function(){
					gfn_logout('session');
					//버튼을 눌러야만 로그아웃 처리됨.. 새로고침시 세션유지되는현상
					/* gfn_msgBox({
						msg:"사용시간이 만료되어 로그아웃합니다.", 
						yes : function(){gfn_sessionLogout();},
						done : function(){gfn_sessionLogout();} 
					}); */
				});
			}
		});
	}

	$(document).ready(function(){
		gfn_cacheSet();
		
		// 구현미정. getSessionTime();
// 		$("#menuBtnLogout").click(function(){
// 			fnLogOut();
// 		});
	
		$.ajax({
			url: gfn_getUri('/common/myInfo'),
			type:'POST',
			async: false, // true,
			success:function(data, statusText, xhr){
				libUtil._myInfo = data;
			},
			error:function(ex){
			}
		});
		
		// 6개월 이상 비밀번호 교환 안했을 경우, 비밀번호 변경창 오픈, gfn_ajaxCallByList 함수 호출 문제로 500ms timer
		// 6개월->3개월 (210831)
		setTimeout(function(){
			var userInfo = gfn_ajaxCallByList('user', {userId: libUtil._myInfo.userInfo.userId});
			var hideCookieUser = $("#_loginUserId").val()+ "Hide";
			var pwHide = getCookie(hideCookieUser);
			var monthCookieUser = $("#_loginUserId").val()+ "Month";
			var pwHideMonth = getCookie(monthCookieUser);			
			
			if(gfn_getDate(gfn_getDate(new Date(), "M", -2), gfn_getDate(userInfo.rows[0].pwChangeAt)) < 0) {
				
				if(pwHide != "todayHide" && pwHideMonth != "monthHide"){ //하루동안 열지 않기 선택한 경우 뜨지 않음
					$('#p_langCd').val(userInfo.rows[0].langCd);
					gfn_pwChangePop();
				}
			} 
		},500)
		
		
		//세션종료처리
		getSessionTime();
		$("#btnTimeAdd").click(function(){
			getSessionTime();
		});
		// 탭 초기화
		libTabs._fnTabInit();

		libUtil._cacheTimeout = parseInt($("#_cacheTimeout").val());
	});
		
	var goMenuToBody = function(menuInfo/* , menuType, msgView */, data, force){
		var menuInfo = this.gfn_getMenu(menuInfo);
		if(typeof menuInfo == "object"){
			this.gfn_loading(true);
			try{
				//현재 선택된 menuId 저장
				$("#_currentMenuId").val(menuInfo.menuId);
				
				this.gfn_goMenu_condition(menuInfo, 'subContents', data, undefined, force);
				//, function(data){
				//	// alert(data);
				//	document.getElementById("menuSelectedName").innerHTML = menu.msgView; /* menu.msgViewPath 선택경로를 표시할지 메뉴이름을 표시할지 ? */
				//	document.getElementById("menuPathNaviTop").innerHTML = menu.msgViewPath.split(" > ").join(" / <span>") + "</span>";
				//	this.gfn_loading();
				//}
				
				//페이지 이동로그
				$.ajax({
					async:false,
					url : "/form/devtol/pageLog/setPageLog",
					type: "POST",
					traditional :true,
					contentType : 'application/json',
					dataType : 'json',
					data: JSON.stringify({pageId : menuInfo.menuId, pagePath : menuInfo.svcUrl}),
					success: function(data){
					},error: function(ex){
						gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
					}
				});
			} catch (ex) {
				console.error(ex);
				this.gfn_loading();
			}
			this.gfn_loading();
		}
	};
</script>
<body>
<sec:authentication var="principal" property="principal"/>
	<div id="mainBody">
		<%@ include file="./layout/left.jsp" %>	
		<!--히든레이어 -->
		<div class="hiddenLayer">
			<!--팝업레이어 -->
			<div id="_comn_popup_layer"></div>
						
				<!-- Error Popup Layer -->
			<div id="errorLayer" class="layerPop" style="display:none;">
				<div class="layerContent">
				<div id="libPopBox"></div>
				<div id="libExcelUploadPop"></div>
				<div id="msgPopBox"></div>
					<div class="erorrBox" style="height:100px">
						<p id="errorMessage" class="title"></p>
						<span class="btnError btnLarge blue"><button>Detail Views</button></span>
					</div>
				<!--<div id="errorTrace" class="detailView"></div> -->
					<textarea id="errorTrace" class="detailView" style="width:785px" rows="24" readonly></textarea>
				</div>
			</div>
		</div>
		<!-- 첨부파일 공통 Target -->
		<iframe name="attachDownloadIframe" style="display: none;"></iframe>
	</div>
	
	<div style="display:none;">
		<div id="jteMsgForm">
			<form id="_disable_jteMsgForm_form">
				<table id="_disable_jteMsgForm_master">
				<colgroup>
					<col class="msg-col-left-title">
					<col class="msg-col-right-title">
				</colgroup>
					<tr>
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_msgId"></spring:message> : </td>																							<!-- 메시지아이디 -->
						<td><input type="text" id="_disable_msg_msgId" name="msgId" class="k-textbox msg-input"/></td>
					</tr>
					<tbody id = "_disable_jteMsgForm_body">
					</tbody>
				</table>
			</form>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_setMsgSave('jteMsgForm_form')"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('msgPop');"><spring:message code = "pop_cancel"></spring:message></button>					<!-- 취소 -->
			</div>
		</div>
	</div>
	<div style="display:none;">		<!-- 200429 libUtil.js에서 팝업창 높이 변경_LYM&JJW --> <!-- 정보수정-비번변경 0831-->
		<div id="jteConfigForm">
			<form id="jteConfigForm_form">
				<table style="width:100%;" id="jteConfigForm_master" class="tabMain_jteConfigForm">
				<colgroup>
					<col class="Config-col-left">
					<col class="Config-col-right">
				</colgroup>
					<tr>
						<td class="jteConfigForm-title"><i class="fas fa-globe"></i><spring:message code ="html_langChange"></spring:message> :</td>																								<!-- 언어수정 --> 
						
						<div class="tester">
						<td class="Config-lang-inputBox">
							<input id="t_langCd" name="langCd" msg="msgLangCode" class="Config-lang-input"/>
						</td>
					</tr>
					<tr>
						<td class="jteConfigForm-title">
							<i class="fas fa-lock"></i>
							<spring:message code ="html_changePw"></spring:message>
						</td>
						<td class="Config-password-inputBox">
							<input type="checkbox" id="t_passwordYN" name="passwordYN" class="k-checkbox config-checkbox">
							<label class="config-label" for="t_passwordYN"><span style="visibility: hidden;">|</span></label>								<!-- 20.04.29 LYM JJW 체크박스 정렬을 위해 span 추가 --><!-- 비밀번호수정 -->
						</td>
					</tr>
					<tr class="jteConfigFomr_pwZone">
						<td class="Config-password-title"><i class="fas fa-caret-right"></i><spring:message code ="html_pwExisting"></spring:message> :</td>																								<!-- 기존 비밀번호 -->
						<td class="Config-password-inputBox">
							<input type="password" name="passwordPrev" id="t_passwordPrev" class="k-textbox Config-password-input" maxlength="16"/>
						</td>
					</tr>
					<tr class="jteConfigFomr_pwZone">
						<td class="Config-password-title"><i class="fas fa-caret-right"></i><spring:message code ="html_pwChange"></spring:message> :</td>																								<!-- 변경 비밀번호 -->
						<td class="Config-password-inputBox">
								<input type="password" name="password" id="t_password" class="k-textbox Config-password-input" maxlength="16"/> 
						</td>
					</tr>
					<tr class="jteConfigFomr_pwZone">
						<td class="Config-password-title"><i class="fas fa-caret-right"></i><spring:message code ="html_pwConfirm"></spring:message> :</td>																								<!-- 비밀번호 확인 -->
						<td class="Config-password-inputBox">
							<input type="password" name="passwordCheck" id="t_passwordCheck" class="k-textbox Config-password-input" maxlength="16"/> <br/>
						</td>
					</tr>
				</table>
			</form>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_myConfigSave('jteConfigForm_form')"><spring:message code ="pop_change"></spring:message></button>			<!-- 변경 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteConfigForm');"><spring:message code ="pop_cancel"></spring:message></button>					<!-- 취소 -->
			</div>
		</div>
	</div>
	<div style="display:none;">		<!-- 비번변경 3개월 경과 -->
		<div id="jtePwChangeForm">
			<form id="jtePwChangeForm_form">
				<table id="jtePwChangeForm_master" class="tabMain_jtePwChangeForm">
				<colgroup>
					<col class="Config-col-left">
					<col class="Config-col-right">
				</colgroup>
					<tr>
						<td class="Config-password-title"><i class="fas fa-caret-right"></i><spring:message code ="html_pwExisting"></spring:message> :</td>																								<!-- 기존 비밀번호 -->
						<td class="Config-password-inputBox">
							<input type="password" name="passwordPrev" id="p_passwordPrev" class="k-textbox Config-password-input" maxlength="16"/>
						</td>
					</tr>
					<tr>
						<td class="Config-password-title"><i class="fas fa-caret-right"></i><spring:message code ="html_pwChange"></spring:message> :</td>																								<!-- 변경 비밀번호 -->
						<td class="Config-password-inputBox">
								<input type="password" name="password" id="p_password" class="k-textbox Config-password-input" maxlength="16"/> 
						</td>
					</tr>
					<tr>
						<td class="Config-password-title"><i class="fas fa-caret-right"></i><spring:message code ="html_pwConfirm"></spring:message> :</td>																								<!-- 비밀번호 확인 -->
						<td class="Config-password-inputBox">
							<input type="password" name="passwordCheck" id="p_passwordCheck" class="k-textbox Config-password-input" maxlength="16"/> <br/>
							<input type="hidden" name="langCd" id="p_langCd">
						</td>
					</tr>
				</table>
			</form>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_myConfigSave('jtePwChangeForm_form')"><spring:message code ="pop_change"></spring:message></button>			<!-- 변경 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePwChangeForm');"><spring:message code ="pop_cancel"></spring:message></button>					<!-- 취소 -->
			</div>
			<div style ="float : right; padding-right : 20px;">
				<input type="checkbox" id="p_pwMonth" name="pwMonth" class="k-checkbox config-checkbox">
				<spring:message code ="html_pw3month"></spring:message>&nbsp;
				<input type="checkbox" id="p_pwToday" name="pwToday" class="k-checkbox config-checkbox">
				<spring:message code ="html_pwToday"></spring:message>						
			</div>
		</div>
	</div>
	<!-- 유저정보 -->
	<div id="_loginUserInfo">
		<input type="hidden" id="_loginUserUsername" value="<sec:authentication property='principal.username'/>" />
		<input type="hidden" id="_loginUserId" value="<sec:authentication property='principal.userInfo.userId'/>" />
		<input type="hidden" id="_loginUserName" value="<sec:authentication property='principal.userInfo.userNm'/>" />
		<input type="hidden" id="_loginUserLang" value="<sec:authentication property='principal.userInfo.langCd'/>" />
		<input type="hidden" id="_loginUserMovTelNo" value="<sec:authentication property='principal.username'/>" />
		<input type="hidden" id="_loginUserEmail" value="<sec:authentication property='principal.username'/>" />
		<input type="hidden" id="_loginSessionId" value="<sec:authentication property='principal.sessionId'/>" />
		<input type="hidden" id="_cacheTimeout" value="${cacheTimeout.cdVal * 1000}" />
	</div>
	<div style = "display:none;">
		<input id="_currentMenuId" type="hidden" />
	</div>
</body>

</html>
