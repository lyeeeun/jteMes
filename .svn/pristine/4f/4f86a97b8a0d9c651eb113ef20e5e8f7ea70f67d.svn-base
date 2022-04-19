<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="qualPectMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="qualPectMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<div id="jtePopForm_grid" style="height:325px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>


<!-- 이윤민 주임 작업 CSS -->
<!--  <link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_lym.css' rel="stylesheet">  -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/qualPectMgt/qualPectMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200512 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};

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
	lfo_common.ctrlUrl = "/form/qualMgt/qualPec/qualPectMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getMtrlOrderQualList", auth:"", prmt:{}}, 
		//create:{url:"/setMtrlOrderSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"", auth:"", openFunc : lfn_jtePop_open, callback:""}, 
		//destroy:{url:"/setMtrlOrderDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "mtrlOrderId",
		fields: {
			mtrlOfId : { type: "string" },
			mtrlOfNm : { type: "string" },
			mtrlOfDate : { type: "date" },
			mtrlOrderId : { type: "string" },
			mtrlOrderQty : { type: "int" },
			mtrlOrderUser : { type: "string" },
			mtrlOrderUserNm : { type: "string" },
			mtrlOrderDate : { type: "date" },
			mtrlOrderCost : { type: "int" },
			mtrlOrderDelivery : { type: "int" },
			mtrlOrderState : { type: "string" },
			mtrlOrderDesc : { type: "string" },
			createdAt : { type: "date" },
			updatedAt : { type: "date" },
			creatorId : { type: "string" },
			creatorNm : { type: "string" },
			updatorId : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlCost : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			badQty : { type: "int" },
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'NEW\',this); " style="min-width:60px;">' + ""+gfn_getMsg("pop_view")+"" + '</button>',
			title:gfn_getMsg("col_badConfirm"), width: "110px"},																//불량확인
		{field: "mtrlOfNm", title : gfn_getMsg("col_mtrlOrderDocNm"), width: "130px"},										//발주명
		//{field: "mtrlOfId", title : "주문서코드", width: 160},
		{field: "mtrlOrderId", title:gfn_getMsg("col_mtrlItemCd"), width: "150px"},											//발주계획코드
		{field: "mtrlOrderState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOrderState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOrderState).cdId , gfn_getCode(mtrlOrderState).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlOrderStatus"), width: "110px;"},													//발주상황 구분
		//{field: "mtrlId", title:"자재코드", width: 100},
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "100px"},												//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "100px"},													//자재명
		{field: "mtrlOrderQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity"), width: "80px"},							//수량
		//{field: "mtrlOrderCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost"), width: 100},
		//{field: "mtrlOrderDelivery", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_deliveryCost"), width: 100},
		//{field: "compId",  title:"업체코드", width: 160},
		{field: "compNm",  title:gfn_getMsg("col_compNm"), width: "160px"},													//업체명
		//{field: "mtrlOrderUser", title:"수령자 아이디", width: 100},
		{field: "mtrlOrderUserNm", title:gfn_getMsg("col_recipient"), width: "130px"},										//수령자
		{field: "mtrlOfDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_mtrlOrderDate"), width: "100px"},			//발주일
		{field: "mtrlOrderDate", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "100px"},			//수령일
		{field: "mtrlOrderDesc", title:gfn_getMsg("col_desc"), width: "110px"},												//설명
		{field: "mtrlOrderState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOrderState))== true ? '기초코드 없음' : gfn_getCode(mtrlOrderState).cdId == 'mtrl_order_end' ? '점검완료' : '점검대기' # #= item #", 
			title:gfn_getMsg("col_checkWhe"), width: "110px;"},																//점검여부
		{field: "badQty", title : gfn_getMsg("col_badProdQuan"), width: "100px"}											//불량량
		
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },					//자재구분
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },						//업체명
		{ text: gfn_getMsg("col_mtrlItemCd"), value: "mtrlOrder.mtrl_order_id" }			//발주계획코드
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//보기버튼 팝업
this.lfn_jtePop_open = function(mode, target){
	var options = {
		modal:true, 
		width: "900px",
		height: "430px", /* JJW 400-> 430 */
		id : lfo_common.popId, 
		title: gfn_getMsg("pop_importBadSrh"),			//수입 불량 조회
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		lfo_common.gridSelected = lfo_common.grid.dataItem($(target).closest("tr"));
		
		//자재소요량 조회 
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	};
	this.gfn_winOpen(options);
}

//입고 자재불량 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
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
	lfo_popGrd.layoutId = "jtePopForm_grid";
	//여기까지
	
	//2.
	//lfo_popGrd.popId = "jteMtrlBadChkPop";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/qualMgt/infergodsMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlBadList", auth:"", prmt:{badTargetCode : lfo_common.gridSelected.mtrlOrderId}}, 
		//create:{url:"/setMtrlBadSave", auth:"", openFunc : lfn_mtrlBadGrd_open, callback : lfn_mtrlBadGrd_save}, 
		//update:{url:"/setMtrlBadSave", auth:"", openFunc : lfn_mtrlBadGrd_open, callback : lfn_mtrlBadGrd_save}, 
		//destroy:{url:"/setMtrlBadDelete", auth:"", callback : lfn_mtrlBadGrd_delete}
	};
	
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
			mtrlDiv : { type: "string"},
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
		{selectable : true, width:"50px"},
		{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "130px;"},														//불량원인
		{field: "badId", title : gfn_getMsg("col_badId"), width: "160px"},												//불량아이디
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "110px"},											//자재구분
		{field: "mtrlNm", title : gfn_getMsg("col_mtrlNm"), width: "100px"},											//자재명
		{field: "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd"), width: "160px"},									//자재개별코드
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badInfo"), width: "160px;"},														//불량정보
		{field: "badTargetCode", title : gfn_getMsg("col_badCd"), width: "160px"},										//불량코드
		{field: "badPgUserNm", title : gfn_getMsg("col_worker"), width: "100px"},										//작업자
		{field: "badPgDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_workDate"), width: "120px"},			//작업일
		{field: "badQty",format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan"), width: "100px"},						//불량량
		{field: "chkUserNm", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_inspector"), width: "100px"},					//검사자
		{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate"), width: "120px"},			//검사일
		{field: "badPgNm", title : gfn_getMsg("col_progNm"), width: "180px"},											//프로그램명
		{field: "badPgCd", title : gfn_getMsg("col_progCd"), width: "160px"}											//프로그램코드
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlDiv" },				//자재구분
		{ text: gfn_getMsg("col_worker"), value: "badPgUserNm" },			//작업자
		{ text: gfn_getMsg("col_badId"), value: "badId" },					//불량아이디

	];
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>