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

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/mfgplanMgt/mrcalMgt/mrcalMgtForm_JJW.css' rel="stylesheet">
<!-- 내부 스타일 외부로 이동_200806 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//서브그리드에서 사용될 Object

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
	lfo_common.ctrlUrl = "/form/orderMgt/orderDetailMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getOrderList", auth:"", prmt:{}},
		//create:{url:"/setOrderInfoSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave},
		//update:{url:"/setOrderInfoSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave},
		//destroy:{url:"", auth:"", callback:""}
	};
	
	//5.
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
			compNm: { type: "string" }
			}
	};
	
	//6.
	lfo_common.columns = [
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'NEW\',this); " style="min-width:60px;">' + "보기" + '</button>',
			title:gfn_getMsg("col_detailInfo"), width: "90px"},															//상세정보
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "110px"},											//수주코드
		//2020.05.14|ymlee|수주명 주석(신명기계 사용x)
		{template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "160px"},					//수주명 */
		{field: "orderManagerNm", title:gfn_getMsg("col_manager"), width: "120px;"},										//관리자
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "100px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "100px"},			//납기일
		{field: "orderCost", format: "{0:n0}", title:gfn_getMsg("col_cost"), width: "100px"},							//비용
		{field: "orderState",template:"# var item = gfn_isNull(orderState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(orderState).cdId , gfn_getCode(orderState).cdNm) # #= item #",
			title:gfn_getMsg("col_proceedStatus"), width: "150px"},														//수주진행상태
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "260px"},												//업체명
		{field: "description", title:gfn_getMsg("col_desc"), width: "320px"}											//설명
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_orderNm"), value: "orInfo.order_nm" },			//수주명
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },			//관리자
		{ text: gfn_getMsg("col_orderCd"), value: "orInfo.order_id" }			//수주코드
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
		title: gfn_getMsg("pop_mtrlResourceSrh"),			//자재소요량조회
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
	
	//2.
	lfo_popGrd.popId = "jtePopAddForm";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/mfgMgt/mfgplanMgt/mrcalMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlUseCalList", auth:"", prmt:{orderId : lfo_common.gridSelected.orderId}}, 
// 		create:{url:"/setLotInfoSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
// 		update:{url:"/setLotInfoSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
// 		destroy:{url:"/setLotInfoDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
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
	
	//6.
	lfo_popGrd.columns = [
		{field: "lotId", title : gfn_getMsg("col_lotCd"), width: "140px;"},													//LoT코드
		//2020.05.14|ymlee|LoT명 주석(신명기계 사용x)
		/* {field: "lotNm", title : "Lot 명", width: "180px;"}, */
		{field: "lotQty", format:"{0:n0}", title : gfn_getMsg("col_lotQty"), width: "120px;"},								//LoT수량
		{field: "itemId", title : gfn_getMsg("col_itemCd"), width: "160px;"},												//부품코드
		{field: "itemNm", title : gfn_getMsg("col_itemNm"), width: "180px;"},												//부품명
		//{field: "mtrlDiv", title : gfn_getMsg("col_mtrlDiv"), width: "120px;"},												//자재구분
		{field: "mtrlId", title : gfn_getMsg("col_mtrlCd"), width: "140px;"},												//자재코드
		{field: "mtrlNm", title : gfn_getMsg("col_mtrlNm"), width: "160px;"},												//자재명
		{field: "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd"), width: "180px;"},										//자재개별코드
		{field: "mtrlMgtCnt", format:"{0:n0}", title : gfn_getMsg("col_mtrlStockQty"), width: "125px;"},					//자재재고량
		{field: "prodAsmDate", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_workOrderDate"), width: "120px;"},			//작업지시일
		{field: "prodWorkId", title : gfn_getMsg("col_workOrderCd"), width: "160px;"},										//작업지시코드
		{field: "eqmtMgtNm", title : gfn_getMsg("col_eqmtDetailNm"), width: "180px;"},										//설비명
		{field: "eqmtMgtId", title : gfn_getMsg("col_eqmtIndivCd"), width: "170px;"},										//설비개별코드
		{field: "prodWorkUserNm", title : gfn_getMsg("col_worker"), width: "130px;"},										//작업자
		/* {field: "prodWorkUser", title : "작업자 아이디", width: "115px;"}, */
		{field: "prodWorkQty", format:"{0:n0}", title : gfn_getMsg("col_wrkAsmQty"), width: "120px;"},						//작업지시량
		{field: "bomTargetCnt", format:"{0:n0}", title : gfn_getMsg("col_standardQty"), width: "110px;"},					//표준량
		{field: "mtrlNeedQty", format:"{0:n0}", title : gfn_getMsg("col_needQty"), width: "110px;"},						//필요수량
		{field: "mtrlUseInput", format:"{0:n0}", title : gfn_getMsg("col_inputQuan"), width: "110px;"},						//투입량
		{field: "mtrlUseCnt", format:"{0:n0}", title : gfn_getMsg("col_useQuan"), width: "110px;"}							//사용량
	];
	
	//7.
	lfo_popGrd.selectBox = [
		//{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },				//자재구분
		{ text: gfn_getMsg("col_eqmtDetailNm"), value: "eqmt.eqmt_mgt_nm" },			//설비명
		{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },					//자재명
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" },						//부품명
		{ text: gfn_getMsg("col_worker"), value: "userInfo.user_nm" }					//작업자
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>