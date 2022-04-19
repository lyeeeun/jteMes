
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content"  style="width:100%;">
	<div id="jteSingleGrid" class="mrcalMgtForm"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm" class="jtePopForm">  <!-- style="margin-top: 5px;" -->
		<div class="pop_title">자재소요량</div>
		<div id="jtePopForm_grid" style="height:350px;"></div>
	</div>
</div>

<link href='/resources/mes/css/contents/mfgMgt/mfgplanMgt/mrcalMgt/mrcalMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {}; 

var lfo_popGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/orderMgt/orderDetailMgt";

	lfo_common.crud  = {
		read:{url:"/getOrderList", auth:"", prmt:{}}
	};

	lfo_common.model = {
		id: "orderId",
		fields: {
			orderId: { type: "string" },
			orderNm: { type: "string" },
			orderManager: { type: "string" },
			orderStdt: { type: "date" },
			orderEddt: { type: "date" },
			orderCost: { type: "int" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			description: { type: "string" },
			orderState: { type: "string" },
			compId: { type: "string" },
			orderManagerNm: { type: "string" },
			compNm: { type: "string" },
			compStdStr02: { type: "string" },
			compNumber: { type: "string" }
		}
	};

	lfo_common.columns = [
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'NEW\',this); " style="min-width:60px;">' + "보기" + '</button>',
			title:gfn_getMsg("col_detailInfo", "상세정보"), width: "90px"},
		{field: "orderId", title:gfn_getMsg("col_orderCd", "수주코드"), width: "110px"},
		{template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm", "수주명"), width: "160px"},
		{field: "orderManagerNm", title:gfn_getMsg("col_manager", "관리자"), width: "120px;"},
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate", "수주일"), width: "100px"},
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate", "납기일"), width: "100px"},
		{field: "orderState",template:"# var item = gfn_isNull(orderState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(orderState).cdId , gfn_getCode(orderState).cdNm) # #= item #",
			title:gfn_getMsg("col_proceedStatus", "수주진행상태"), width: "150px"},
		{field: "compStdStr02", title:gfn_getMsg("col_compStdStr02", "거래처코드"), width: "130px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "190px"},
		{field: "compNumber", title:gfn_getMsg("col_busiNum", "사업자번호"), width: "160px"},
		{field: "description", title:gfn_getMsg("col_desc", "설명"), width: "320px"}
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_orderNm", "수주명"), value: "orInfo.order_nm" },
		{ text: gfn_getMsg("col_manager", "관리자"), value: "urInfo.user_nm" },
		{ text: gfn_getMsg("col_orderCd", "수주코드"), value: "orInfo.order_id" }
	];
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//보기버튼 팝업
this.lfn_jtePop_open = function(mode, target){
	var options = {
		modal:true, 
		width: "900px",
		height: "400px", 
		id : lfo_common.popId, 
		title: gfn_getMsg("pop_mtrlResourceSrh", "자재소요량 조회"),
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

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";

	lfo_popGrd.popId = "jtePopAddForm";

	lfo_popGrd.ctrlUrl = "/cform/mfgMgt/mrcalMgt";

	lfo_popGrd.crud  = {
		read:{url:"/getMrpMtlList", auth:"", prmt:{orderId : lfo_common.gridSelected.orderId}}
	};

	lfo_popGrd.model = {
		id: "lotId",
		fields: {
			orderId : { type: "string" },
			orderNm : { type: "string" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			lotQty : { type: "int" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			bomTargetCnt : { type: "int" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlMgtId : { type: "string" },
			prodWorkId : { type: "string" },
			prodAsmDate : { type: "date" },
			prodWorkUser : { type: "string" },
			prodWorkUserNm : { type: "string" },
			eqmtMgtId : { type: "string" },
			eqmtMgtNm : { type: "string" },
			prodWorkQty : { type: "int" },
			mtrlNeedQty : { type: "int" },
			mtrlUseInput : { type: "int" },
			mtrlUseCnt : { type: "int" },
			mtrlMgtCnt : { type: "int" }
		}
	};

	lfo_popGrd.columns = [
		{field: "lotId", title : gfn_getMsg("col_lotCd", "LoT코드"), width: "140px;"},
		{field: "lotNm", title : gfn_getMsg("col_lotNm", "LoT명"), width: "180px;"},
		{field: "lotQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_lotQty", "LoT수량"), width: "120px;"},
		{field: "itemId", title : gfn_getMsg("col_itemCd", "제품코드"), width: "160px;"},
		{field: "itemNm", title : gfn_getMsg("col_itemNm", "제품명"), width: "180px;"},
		{field: "mtrlId", title : gfn_getMsg("col_mtrlCd", "자재코드"), width: "140px;"},
		{field: "mtrlNm", title : gfn_getMsg("col_mtrlNm", "자재명"), width: "160px;"},
		{field: "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd", "자재입고코드"), width: "180px;"},
		{field: "mtrlMgtCnt", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_mtrlStockQty", "자재수량"), width: "125px;"},
		{field: "prodAsmDate", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_workOrderDate", "작업지시일"), width: "120px;"},
		{field: "prodWorkId", title : gfn_getMsg("col_workOrderCd", "작업지시코드"), width: "160px;"},
		{field: "eqmtMgtNm", title : gfn_getMsg("col_eqmtDetailNm", "설비명"), width: "180px;"},
		{field: "eqmtMgtId", title : gfn_getMsg("col_eqmtIndivCd", "설비개별코드"), width: "170px;"},
		{field: "prodWorkUserNm", title : gfn_getMsg("col_worker", "작업자"), width: "130px;"},
		{field: "prodWorkQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_wrkAsmQty", "작업지시량"), width: "120px;"},
		{field: "bomTargetCnt", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_standardQty", "표준량"), width: "110px;"},
		{field: "mtrlNeedQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_needQty", "필요수량"), width: "110px;"},
		{field: "mtrlUseInput", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_inputQuan", "투입량"), width: "110px;"},
		{field: "mtrlUseCnt", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_useQuan", "사용량"), width: "110px;"}
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_eqmtDetailNm", "설비명"), value: "eqmt.eqmt_mgt_nm" },
		{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlInfo.mtrl_nm" },
		{ text: gfn_getMsg("col_itemNm", "제품명"), value: "item.item_nm" },
		{ text: gfn_getMsg("col_worker", "작업자"), value: "userInfo.user_nm" }
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>