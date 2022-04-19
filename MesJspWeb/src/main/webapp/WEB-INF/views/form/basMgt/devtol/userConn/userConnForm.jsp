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

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	/* 
	1. gridObject.layoutId = gridId
	2. gridObject.popId = popId
	3. gridObject.ctrlUrl = 조회 url
	4. gridObject.crud  = {
		read:{url:"",auth:"", prmt:{}}, 
		create:{url:"",auth:"",openFunc:function, callback:function}, 
		update:{url:"",auth:"",openFunc:function, callback:function}, 
		delete:{url:"",auth:"", callback:function}}
	5. gridObject.model = fieldType
	6. gridObject.columns = foeldColumns
	7. gridObject.selectBox = SelectBox 매핑 값 
*/
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/devtol/userConn"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getUserConnList", auth:"", prmt:{}}
	};
	
	//5.
	lfo_common.model = {
		id: "connId",
		fields: {
			connId: { type: "string" },
			userId: { type: "string" },
			userNm: { type: "string" },
			connStdt: { type: "date" },
			connEddt: { type: "date" },
			connIp: { type: "string" },
			connDevice: { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "connId", title : "기록코드", width: "170px"},
		{field: "userNm", title : "사용자", width: "150px"},
		{field: "connStdt", format:"{0: yyyy-MM-dd HH:mm:ss}", title : "접속시작", width: "180px"},
		{field: "connEddt", format:"{0: yyyy-MM-dd HH:mm:ss}", title : "접속종료", width: "180px"},
		{field: "connIp", title : "접속 아이피", width: "250px"},
		{field: "connDevice", title : "접속기기", width: "100px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "사용자", value: "userInfo.userNm" },
		{ text: "접속기기", value: "conn.connDevice" }
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