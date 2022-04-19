<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div style="width:100%;">
	<div class="lotProStatusForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
	<input type="text" class="k-textbox" id="orderId" readonly style="margin-left: 10px;"/>
	<!-- <input type="hidden" id="orderId"> -->
	<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_orderInfo();"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="lotProStatusForm lotProStatusForm-gird"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/perform/performItem/performItemForm_JJW.css' rel="stylesheet">

<script>
var lfo_common = {};//Form 내부에서 사용될 Object 

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
	gfn_openCustomPop('orderInfo',callback);
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
	

	lfo_common.layoutId = "jteSingleGrid";
	
	lfo_common.popId = "jtePopForm";
	
	lfo_common.ctrlUrl = "/form/perform/workStaMgt/lotProStatus"
	
	lfo_common.crud  = {
		read:{url:"/getLotProgressList", auth:"", prmt:{orderId: $('#orderId').val()}, search : false}
	};
	
	lfo_common.model = {
		id: "lotId",
		fields: {
			lotSeq : { type: "int" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			lotCode : { type: "string" },
			lotType : { type: "string" },
			lotQty : { type: "int" },
			shipQty : { type: "int" },
			lotShipQty : { type: "int"},
			lotShipRate : { type: "number"},
			lotMtrlCost : { type: "int" },
			lotMtrlCostAfter : { type: "int" },
			lotPersonCost : { type: "int" },
			lotPersonCostAfter : { type: "int" },
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
			itemNm: { type: "string" }
		}
	};
	
	lfo_common.columns = [
		{field: "lotId", title: "LoT코드", width: "150px"},
		{field: "lotNm", title: "LoT명", width: "170px"},
		{field: "itemNm", title: "제품 명", width: "150px"},
		{field: "lotQty", title:"LoT수량", width:"110px"},
		{field: "shipQty", title:"출하수량", width:"110px"},
		{field: "lotShipQty", title:"남은수량", width:"110px"},
		{field: "lotShipRate", title:"달성률", format: "{0:0.000'%'}", width: "120px"},
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
			title:gfn_getMsg("col_lotStatus"), width: "120px;"}
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
</script>