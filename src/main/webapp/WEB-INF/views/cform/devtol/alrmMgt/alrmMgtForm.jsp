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
	lfo_common.ctrlUrl = "/alarm"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getAlarmList", auth:"", prmt:{}}
	};
	
	//5.
	lfo_common.model = {
		id: "alarmId",
		fields: {
			alarmId: { type: "string" },
			alarmTarget: { type: "string" },
			alarmCode: { type: "string" },
			alarmTitle: { type: "string" },
			alarmContent: { type: "string" },
			alarmUrl: { type: "string" },
			alarmSender: { type: "string" },
			alarmSenderNm: { type: "string" },
			alarmSendDate: { type: "date" },
			alarmReceiver: { type: "string" },
			alarmReceiverNm: { type: "string" },
			alarmReceiveDate: { type: "date" },
			alarmStatus: { type: "string" },
			alarmDevice: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "alarmId", title : "알람코드", width: "170px"},
		{field: "alarmTarget", title : "알람 서비스", width: "150px"},
		{field: "alarmCode", title : "서비스 코드", width: "150px"},
		{field: "alarmTitle", title : "알람제목", width: "250px"},
		{field: "alarmContent", title : "알람내용", width: "400px"},
		{field: "alarmSenderNm", title : "송신자", width: "100px"},
		{field: "alarmSendDate", format:"{0: yyyy-MM-dd HH:mm:ss}", title : "송신날짜", width: "150px"},
		{field: "alarmReceiverNm", title : "수신자", width: "100px"},
		{field: "alarmReceiveDate", format:"{0: yyyy-MM-dd HH:mm:ss}", title : "수신날짜", width: "150px"},
		{field: "alarmStatus", title : "확인", width: "100px"},
		{field: "alarmDevice", title : "확인기기", width: "100px"},
		{field: "createdAt", format:"{0: yyyy-MM-dd HH:mm:ss}", title : "등록자", width: "150px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "알람코드", value: "alarm.alarmId" },
		{ text: "알람 서비스", value: "alarm.alarmTarget" },
		{ text: "서비스 코드", value: "alarm.alarmCode" },
		{ text: "송신자", value: "sender.alarmSenderNm" },
		{ text: "수신자", value: "receiver.alarmReceiverNm" }
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