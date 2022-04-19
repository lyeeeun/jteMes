 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="smplPectMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="smplPectMgtForm"></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
</div>

<!-- 부품 불량 리스트  팝업-->
<div style="display:none;">
	<div id="jtePopForm" class="smplPectMgtForm itemBadListPop">
		<div class="smplPectMgtForm radio-btn-area">
			<input type="radio" name="badType" id="itemChk" class="k-radio" checked="checked" value="item" style="margin : 0 5px 0 15px;">
			<label for="itemChk" style="vertical-align:middle; margin-right: 10px;"><spring:message code = "pop_item"></spring:message></label>  <!-- 200810 youmi_margin-left:15px; 삭제 -->
			<input type="radio" name="badType" id="mtrlChk" class="k-radio"  value="mtrl" style="margin : 0 5px 0 15px;">
			<label for="mtrlChk" style="vertical-align:middle;"><spring:message code = "pop_material"></spring:message></label>
		</div>
		<div id="jtePopForm_grid" class="itemBadListPop-single-grid"></div>
		<div class="final-btn-area" style="text-align:center;">
			<!-- 취소 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>
		</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/smplPectMgt/smplPectMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200506 JJW  -->

<script>

var lfo_checkedDate = {};

var lfo_common = {};//메인 그리드 Object 

var lfo_popGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	//해당날짜의 작업정보를 조회하기 위한 date 세팅
	lfn_jteWorkDate_dateSave();
	
};


//해당날짜의 작업정보를 조회하기 위한 date 세팅
this.lfn_jteWorkDate_set = function(){
	//저장된 데이터가 있으면 지정한 날짜 세팅
	var savedDate = kendo.parseDate(lfo_checkedDate.year + "-" + lfo_checkedDate.month + "-" + lfo_checkedDate.day);
	
	//초기 오늘 데이터를 매핑
	if($("#prodWorkDate").attr("data-role") != "datepicker"){
		$("#prodWorkDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_isNull(savedDate) ==true ? new Date():savedDate,
			change : function(){
				lfn_jteWorkDate_dateSave();
			}
		});
	}
}


//날짜 정보 매핑 후 그리드 로드
this.lfn_jteWorkDate_dateSave = function(){
	//날짜 정보  쪼개서 변수에 저장
	var chkDate = ""
	
	if($("#prodWorkDate").attr("data-role") != "datepicker"){
		chkDate = gfn_getDate(new Date(),"yyyy-MM-dd");
	}else{
		chkDate = gfn_getDate($("#prodWorkDate").data("kendoDatePicker").value(),"yyyy-MM-dd");
	}
	
	lfo_checkedDate.user = $("#_loginUserId").val();
 	lfo_checkedDate.year = chkDate.split("-")[0];
	lfo_checkedDate.month = chkDate.split("-")[1];
	lfo_checkedDate.day = chkDate.split("-")[2];
	
	
	//그리드 리로드
	$("#jteSingleGrid").html("");
	lfn_jteSgGrd_setGrd();
	
}

//main-grid  현재 자신의 작업정보를 grid로 표시한다.
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jteProdWorkForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_common.crud  = {
		read:{url:"/getProdWorkList", auth:"", prmt:{
 			prodPlanYear : lfo_checkedDate.year,
 			prodPlanMonth : lfo_checkedDate.month,
 			prodPlanDay : lfo_checkedDate.day
			//prodWorkUser : lfo_checkedDate.user
		}}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		//update:{url:"", auth:"", openFunc : lfn_jteSgGrid_dblclick, callback:""},
		//destroy:{url:"", auth:"", callback:""}
		//excel:{url:"" ,auth:"", fileName: "작업지시서_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
	};
	
	//기존 검색창 제거, 커스텀타이틀 추가.
	lfo_common.customTitle = {html:"<input id='prodWorkDate' name='prodWorkDate' />", callback : lfn_jteWorkDate_set};
	
	//5.
	lfo_common.model = {
			id: "prodWorkId",
			fields: {
				orderId: { type: "string" },
				lotId: { type: "string" },
				lotNm: { type: "string" },
				
				itemId : { type: "string" },
				itemNm : { type: "string" },
				itemDeduction: { type: "int" },
				itemDayTarget: { type: "int" },
				itemTotalStock: { type: "int" },
				itemStd01: { type: "int" },
				itemStd02: { type: "int" },
				itemStd03: { type: "int" },
				itemStd04: { type: "int" },
				itemStd05: { type: "int" },
				
				itemStdStr01: { type: "string" },
				itemStdStr02: { type: "string" },
				itemStdStr03: { type: "string" },
				itemStdStr04: { type: "string" },
				itemStdStr05: { type: "string" },
				itemUnit: { type: "string" },
				itemMtrl: { type: "string" },
				
				prodPlanId: { type: "string" },
				prodPlanYear: { type: "int" },
				prodPlanMonth: { type: "int" },
				prodPlanDay: { type: "int" },
				prodPlanQty: { type: "int" },
				prodPlanDesc: { type: "string" },
				prodAsmId: { type: "string" },
				prodAsmNm: { type: "string" },
				prodAsmDate: { type: "date" },
				prodAsmQty: { type: "int" },
				prodAsmDesc: { type: "string" },
				prodAsmUser: { type: "string" },
				prodAsmUserNm: { type: "string" },
				prodAsmEmj: { type: "string" },
				prodAsmState: { type: "string" },
				createdAt: { type: "date" },
				creatorId: { type: "string" },
				deptId: { type: "string" },
				deptNm: { type: "string" },
				prodWorkId: { type: "string" },
				routingId: { type: "string" },
				routingSeq: { type: "int" },
				routingType: { type: "string" },
				bomTarget: { type: "string" },
				eqmtMgtId: { type: "string" },
				eqmtMgtNm: { type: "string" },
				placeId : { type: "string" },
				placeNm : { type: "string" },
				prodWorkUser: { type: "string" },
				prodWorkUserNm: { type: "string" },
				prodWorkQty: { type: "int" },
				prodWorkGood: { type: "int" },
				prodWorkBad: { type: "int" },
				prodWorkStart: { type: "date" },
				prodWorkEnd: { type: "date" },
				planAction: { type: "string" },
				workAction: { type: "string" }
			}
		};
	
	//6.
		//6.
	lfo_common.columns = [
		{field: "prodAsmId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'NEW\',this); " style="min-width:60px;">' + ""+gfn_getMsg("pop_view")+"" + '</button>',
			title:gfn_getMsg("col_badConfirm"), width: "120px"},																	//불량확인
 		{field: "prodAsmId", title:gfn_getMsg("col_workOrderCd"), width: "150px"},													//작업지시코드
 		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "160px"},															//부품명
 		{field: "prodAsmEmj", template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #",
 			title:gfn_getMsg("col_prodEmj"), width: "110px"},																		//긴급여부
		{field: "routingId", title:gfn_getMsg("col_routCd"), width: "180px"},														//라우팅코드
		{field: "routingType", template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #", 
			title:gfn_getMsg("col_routType"), width: "110px"},																		//공정유형
		{field: "routingSeq", format:"{0:n0}",title:gfn_getMsg("col_routSeq"), width: "100px"},										//차수
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: "150px"},													//설비명
		{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: "140px"},														//위치명
		{field: "prodWorkId", title:gfn_getMsg("col_workInfoCd"), width: "150px"},													//작업정보코드
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "130px"},													//작업자
		//{field: "prodAsmDesc", title:"생산지시 비고", width: 300},
		{field: "prodWorkStart", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_wrkStartTime"), width: "180px"},			//작업시작 시간
		{field: "prodWorkEnd", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_wrkEndTime"), width: "180px"},				//작업종료 시간
		{field: "prodWorkQty", format:"{0:n0}", title:gfn_getMsg("col_asmQuan"), width: "110px"},									//지시량
		{field: "prodWorkGood", format:"{0:n0}", title:gfn_getMsg("col_prodQuan"), width: "110px"},									//양품량
		{field: "prodWorkBad", format:"{0:n0}", title:gfn_getMsg("col_badProdQuan"), width: "110px"},								//불량량
		{field: "prodWorkEnd", template:"# var item = gfn_isNull(prodWorkEnd) == true ? '점검대기' : '점검완료' # #= item #",
				title:gfn_getMsg("col_checkWhe"), width: "120px"}																	//점검여부
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" },						//부품명
/* 		{ text: gfn_getMsg("col_routType"), value: "rut.routing_type" },				//공정유형 */
		{ text: gfn_getMsg("col_eqmtDetailNm"), value: "eqmt.eqmt_mgt_nm" },			//설비명
		{ text: gfn_getMsg("col_placeNm"), value: "place.place_nm" },					//위치명
		{ text: gfn_getMsg("col_worker"), value: "w_usr.user_nm" }						//작업자
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//폼묵 불량 조회 팝업 조회
this.lfn_jtePop_open = function(mode,target){
	var options = {
		modal:true, 
		width: "850px", 
		height: "400px", 
		id : "jtePopForm", 
		title : gfn_getMsg("pop_processBadSrh"),			//공정 불량 조회
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfo_popGrd = {};
		//필요데이터 담아주기
		lfo_common.gridSelected = lfo_common.grid.dataItem($(target).closest("tr"));
		
		//부품,자재 선택박스 선택값 저장
		lfo_popGrd.chkVal = $("[name='badType']:checked").val();
		
		$("[name='badType']").change(function(e){
			//부품,자재 선택박스 선택값 저장
			lfo_popGrd.chkVal = $("[name='badType']:checked").val();
			
			//부품 불량 리스트 조회 그리드 셋
			$("#jtePopForm_grid").html("");
			lfn_jtePopGrd_setGrd();
		});
		
		//부품 불량 리스트 조회 그리드 셋
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
		
	}
	this.gfn_winOpen(options);	
}

//부품 불량  --  그리드 세팅
this.lfn_jtePopGrd_setGrd = function(){
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	//lfo_popGrd.popId = "itemBadSavePop";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/qualMgt/infergodsMgt"

	if(lfo_popGrd.chkVal == "item"){
		//4.
		lfo_popGrd.crud  = {
			read:{url:"/getItemBadList",
				auth:"",
				prmt:{
					badTarget : 'qual_spec03',
					badTargetCode : lfo_common.gridSelected.prodWorkId,
				},
				search : false,
				paging:false
			},
		};
		
		//커스텀 타이틀
		lfo_popGrd.customTitle = {
			html : '<span class="pop_title">'+''+gfn_getMsg("pop_itemBad")+'' + '</span>'			//부품불량
		}
		
		//5.
		lfo_popGrd.model = {
			id: "badId",
			fields: {
				badId : { type: "string" },
				lotId : { type: "string" },	
				badCode : { type: "string" },
				badQty : { type: "string" },
				chkUser : { type: "string" },
				chkUserNm : { type: "string" },
				chkDate : { type: "string" },
				badTarget : { type: "string" },
				badTargetCode : { type: "string" },
				badTargetNm : { type: "string" },
				badDesc : { type: "string" },
				itemId : { type: "string" },
				itemNm : { type: "string" },
				badPgUser : { type: "string" },
				badPgUserNm : { type: "string" },
				badPgDate : { type: "string" }
			}
		};
		//6.
		lfo_popGrd.columns = [
			{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
				title : gfn_getMsg("col_badCause"), width: "130px;"},											//불량원인
			{field: "badId", title:gfn_getMsg("col_badId"), width: "170px"},									//불량아이디
			{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
				title : gfn_getMsg("col_badCause"), width: "220px"},											//불량원인
			{field: "badQty", format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},			//불량량
			{field: "badDesc", title : gfn_getMsg("col_desc"), width: "250px"}									//설명
		];
	}else{
		//4.
		lfo_popGrd.crud  = {
			read:{url:"/getMtrlBadList", auth:"", prmt:{badTargetCode : lfo_common.gridSelected.mtrlOrderId}, paging:false, search:false}, 
		};
		
		//커스텀 타이틀
		lfo_popGrd.customTitle = {
			html : '<span class="pop_title">'+''+gfn_getMsg("pop_mtrlBad")+'' + '</span>'			//자재불량
		}
		
		//5.
		lfo_popGrd.model = {
			id: "badId",
			fields: {
				badId : { type: "string" },	
				badCode : { type: "string" },
				badQty : { type: "int" },
				chkUser : { type: "string" },
				chkUserNm : { type: "string" },
				chkDate : { type: "date" },
				badTarget : { type: "string" },
				badTargetCode : { type: "string" },
				badTargetNm : { type: "string" },
				badDesc : { type: "string" },
				mtrlId : { type: "string" },
				mtrlNm : { type: "string" },
				mtrlDiv : { type: "string" },
				mtrlMgtId : { type: "string" },
				badPgUser : { type: "string" },
				badPgUserNm : { type: "string" },
				badPgDate : { type: "date" },
				badPgCd : { type: "string" },
				badPgNm : { type: "string" }
			}
		};
			
		//6.
		lfo_popGrd.columns = [
			{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
				title : gfn_getMsg("col_badCause"), width: "130px;"},														//불량원인
			{field: "badId", title : gfn_getMsg("col_badId"), width: "170px"},												//불량아이디
			{field: "mtrlDiv", title : gfn_getMsg("col_mtrlDiv"), width: "120px"},											//자재구분
			{field: "mtrlNm", title : gfn_getMsg("col_mtrlNm"), width: "120px"},											//자재명
			{field: "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd"), width: "170px"},									//자재개별코드
			{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
				title : gfn_getMsg("col_badInfo"), width: "220px;"},														//불량정보
			{field: "badTargetCode", title : gfn_getMsg("col_badCd"), width: "170px"},										//불량코드
			{field: "badPgUserNm", title : gfn_getMsg("col_worker"), width: "130px"},										//작업자
			{field: "badPgDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_workDate"), width: "120px"},			//작업일
			{field: "badQty",format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},						//불량량
			{field: "chkUserNm", format: "{0:n0}", title : gfn_getMsg("col_inspector"), width: "130px"},					//검사자
			{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate"), width: "120px"},			//검사일
			{field: "badPgNm", title : gfn_getMsg("col_progNm"), width: "200px"},											//프로그램명
			{field: "badPgCd", title : gfn_getMsg("col_progCd"), width: "180px"}											//프로그램코드
		];
	}
	
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>

