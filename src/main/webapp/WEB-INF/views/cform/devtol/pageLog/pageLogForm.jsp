<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" style="width:100%;">
	<div id="jteSingleGrid"></div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/compMgt/compMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/operMgt/compMgt/compMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200410 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/devtol/pageLog"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getPageLogList", auth:"", prmt:{}}
	};
	
	//5.
	lfo_common.model = {
		id: "pageLogId",
		fields: {
			pageLogId: { type: "string" },
			pageLogAt: { type: "date" },
			pageId: { type: "string" },
			pagePath: { type: "string" },
			userId: { type: "string" },
			userNm: { type: "string" },
			pageLogIp: { type: "string" },
			pageLogDevice: { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "pageLogId", title : gfn_getMsg("col_logCode"), width: "170px"},
		{field: "userNm", title : gfn_getMsg("col_user"), width: "150px"},
		{field: "pageLogAt", format:"{0: yyyy-MM-dd HH:mm:ss}", title : gfn_getMsg("col_connectTime"), width: "180px"},
		{field: "pageId", title : gfn_getMsg("col_acctionMenu"), template:"#= gfn_getMsg('mn_'+ pageId) #",width: "130px"},
		{field: "pagePath", title : gfn_getMsg("col_path"), width: "250px"},
		{field: "pageLogIp", title : gfn_getMsg("col_connectIp"), width: "250px"},
		{field: "pageLogDevice", title : gfn_getMsg("col_connectDevice"), width: "100px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_user"), value: "userInfo.user_nm" },
		{ text: gfn_getMsg("col_connectDevice"), value: "pageLog.page_log_device" }
	];
	
	//8.
// 	lfo_common.validation ={
// 		compNm:{
// 			messages : "업체명을 입력하세요",
// 			rules : function(input){
// 				if(input.is("[name=compNm]")){
// 					return input.val().length != 0 && input.val().trim().length != "";
// 				}
// 				return true;
// 			}
// 		}
// 	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
</script>