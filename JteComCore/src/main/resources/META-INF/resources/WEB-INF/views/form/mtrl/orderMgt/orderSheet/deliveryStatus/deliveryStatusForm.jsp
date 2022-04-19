<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="deliveryStatusForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
	<input type="text" class="k-textbox" id="orderId" readonly style="margin-left: 10px;"/>
	<!-- <input type="hidden" id="orderId"> -->
	<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_orderInfo();"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="deliveryStatusForm deliveryStatusForm-gird"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="jtePopForm" class="jtePopForm">  <!-- style="margin-top: 5px;" -->
		<div id="jtePopForm_grid" style="height:520px;"></div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/orderMgt/orderSheet/orderDetailMgt/orderDetailMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//서브그리드에서 사용될 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

this.lfn_orderInfo = function() {
	var callback = function(selectedItem){
		$('#orderId').val(selectedItem.orderId);
		$('#orderNm').val(selectedItem.orderNm);
		lfn_jteSgGrd_setGrd();
	};
	gfn_openCustomPop('orderShipInfo',callback);
}

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
	lfo_common.ctrlUrl = "/form/orderMgt/orderSheet/deliveryStatus";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getDeliveryStaLotList", auth:"", prmt:{orderId: $('#orderId').val()}},
		//create:{url:"/setOrderInfoSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave},
		update:{url:"", auth:"", openFunc : lfn_jtePop_open, callback:lfn_popSave},
		//destroy:{url:"", auth:"", callback:""}
	};
	
	//5.
	lfo_common.model = {
		id: "lotId",
		fields: {
			lotSeq : { type: "int" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			lotQty : { type: "int" },
			lotPm : { type: "string" },
			lotPmNm : { type: "string" },
			lotState : { type: "string" },
			lotDesc : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			updatedAt : { type: "date" },
			updatorId : { type: "string" },
			itemId : { type: "string" },
			cliamId : { type: "string" },
			orderId : { type: "string" },
			orderNm : { type: "string" },
			orderState : { type: "string" },
			itemNm : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "lotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:90px;">' + "납품현황" + '</button>',
			title:gfn_getMsg("btn_update"), width: 85},									//수정
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},				//Lot코드
		{field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "220px;"},			//Lot명 
		{field: "lotQty", title:gfn_getMsg("col_lotQty"), width: "100px;"},				//Lot수량
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px;"},				//부품명
		{field: "lotPmNm", title:gfn_getMsg("col_manager"), width: "120px;"},			//담당자
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title:gfn_getMsg("col_lotStatus"), width: "120px;"}						//LoT상태
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" },			//부품명
		{ text: gfn_getMsg("col_lotWrkNm"), value: "lot.lot_nm" },			//Lot명
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },		//담당자
		{ text: gfn_getMsg("col_lotCd"), value: "lot.lot_id" }				//Lot코드
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//보기버튼 팝업
this.lfn_jtePop_open = function(mode, target){
	var options = {
		modal:true, 
		width: "850px",
		height: "525px", 
		id : lfo_common.popId, 
		title: "납품현황",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		lfo_common.gridSelected = lfo_common.grid.dataItem($(target).closest("tr"));
		
		//납품 현황 조회
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	};
	this.gfn_winOpen(options);
}

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	lfo_popGrd.popId = "jtePopAddForm";
	
	lfo_popGrd.ctrlUrl = "/form/orderMgt/orderSheet/deliveryStatus";
	
	lfo_popGrd.crud  = {
		read:{url:"/getDeliveryStatusList", auth:"", prmt:{lotId : lfo_common.gridSelected.lotId}, search : false}, 
	};
	
	lfo_popGrd.model = {
		id: "lotId",
		fields: {
			lotSeq : { type: "int" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			lotQty : { type: "int" },
			lotPm : { type: "string" },
			lotPmNm : { type: "string" },
			lotState : { type: "string" },
			lotDesc : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			updatedAt : { type: "date" },
			updatorId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			orderId : { type: "string" },
			orderState : { type: "string" },
			itemNm : { type: "string" },
			shipId : { type: "string" },
			shipStartDate : { type: "date" },
			compId : { type : "string" },
			compNm : { type : "string" },
			shipQty : { type : "string" },
			shipState : { type : "string" },
		}
	};
	
	lfo_popGrd.columns = [
		{field: "itemNm", title : "부품명", width: "120px;"},
		{field: "shipQty", title : "납품수량", width: "60px;"},
		{field: "shipCompleteDate", format:"{0: yyyy-MM-dd}", title : "납품완료일", width: "110px;"},
		{field: "shipPlanState", template:"# var item = gfn_isNull(shipPlanState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(shipPlanState).cdId , gfn_getCode(shipPlanState).cdNm) # #= item #",
				title : "출하현황", width: "90px;"}
		

	];
	
	lfo_popGrd.selectBox = [
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

</script>