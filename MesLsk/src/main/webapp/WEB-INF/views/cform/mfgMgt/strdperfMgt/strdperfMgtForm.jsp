<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="orderDetailMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="orderDetailMgtForm"></div>
</div>
<div style="display:none;">
	<div id="jtePopAddForm" class="jtePopAddForm" style="height:100%">
		<div id="jtePopForm_grid" style="height:100%"></div>
	</div>
</div>
<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/orderMgt/orderDetailMgt/orderDetailMgtForm_JJW.css' rel="stylesheet">

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
	lfo_common.popId = "jtePopAddForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mfgMgt/strdperfMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getStrdperfList", auth:"", prmt:{}}
	};
	
	//5.
	lfo_common.model = {
			id: "lotId",
			fields: {
				orderId : { type: "string" },
				orderNm : { type: "string" },
				lotId : { type: "string" },
				lotNm : { type: "string" },
				lotQty : { type: "int" },
				itemId : { type: "string" },
				itemNm : { type: "string" },
				routingId : { type: "string" },
				routingType : { type: "string" },
				routingSeq : { type: "int" },
				pordWorkId : { type: "string" },
				prodWorkUser : { type: "string" },
				prodWorkUserNm : { type: "string" },
				prodWorkStart : { type: "date" },
				prodWorkEnd : { type: "date" },
				prodWorkQty : { type: "int" },
				prodWorkGood : { type: "int" },
				prodWorkBad : { type: "int" },
				eqmtMgtId : { type: "string" },
				eqmtMgtNm : { type: "string" },
				placeId : { type: "string" },
				placeNm : { type: "string" },
				baseHour : { type: "int" },
				realTime : { type: "int" }
			}
		};
	
	//6.
	lfo_common.columns = [
		{field: "lotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update"), width: 85},							//수정
		{field: "orderNm", title : gfn_getMsg("col_orderNm"), width: "220px;"},					//프로젝트명
		{field: "lotNm", title : gfn_getMsg("col_lotWrkNm"), width: "220px;"},	//Lot명
		{field: "lotQty", format: "{0:n0}", title : gfn_getMsg("col_itemNm"), width: "220px;"},	//수주량
		{field: "itemNm", title : gfn_getMsg("col_itemNm"), width: "220px;"},	//부품명
		{field: "baseHour", format: "{0:n1}", title : gfn_getMsg("col_baseHour") , width: "140px;"},
		{field: "realTime", format: "{0:n1}", title : gfn_getMsg("col_realTime") , width: "140px;"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_orderNm"), value: "odr.order_nm" },
		{ text: gfn_getMsg("col_lotWrkNm"), value: "lot.lot_nm" },
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" }
	];
	
	//공통 그리드 세팅 호출
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "850px",
		height: "350px", // 200810 youmi 320->340px
		id : lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),			//추가팝업
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_orderRegist");				//수주 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_orderSrh");				//수주 수정
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		lfn_jtePop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//팝업내부 그리드 
this.lfn_jtePop_set = function(){
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
	lfo_popGrd.popId = "";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/mfgMgt/strdperfMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getStrdperfDetailList", auth:"", prmt:{lotId : lfo_common.gridSelected.lotId}}
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
				routingId : { type: "string" },
				routingType : { type: "string" },
				routingSeq : { type: "int" },
				pordWorkId : { type: "string" },
				prodWorkUser : { type: "string" },
				prodWorkUserNm : { type: "string" },
				prodWorkStart : { type: "date" },
				prodWorkEnd : { type: "date" },
				prodWorkQty : { type: "int" },
				prodWorkGood : { type: "int" },
				prodWorkBad : { type: "int" },
				eqmtMgtId : { type: "string" },
				eqmtMgtNm : { type: "string" },
				placeId : { type: "string" },
				placeNm : { type: "string" },
				baseHour : { type: "int" },
				realTime : { type: "int" }
			}
		};
	
	//6.
	lfo_popGrd.columns = [
		{field: "routingId", title : gfn_getMsg("col_routCd") , width: "180px;"}, 			//라우팅코드
		{field: "routingType",template:"# var item = gfn_isNull(routingType)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
				title : gfn_getMsg("col_routType") , width: "140px;"},						//라우팅 타입
		{field: "eqmtMgtNm", title : gfn_getMsg("col_eqmtNm") , width: "200px;"},			//설비명	
		{field: "prodWorkUserNm", title : gfn_getMsg("col_worker") , width: "100px;"},		//작업자명
		{field: "prodWorkGood", format: "{0:n0}",title : gfn_getMsg("col_productionQuan") , width: "100px;"},		//생산량
		{field: "prodWorkStart", format: "{0:yyyy-MM-ss hh:mm:ss}",title : gfn_getMsg("col_startTime") , width: "160px;"},		//시작시간
		{field: "prodWorkEnd", format: "{0:yyyy-MM-ss hh:mm:ss}", title : gfn_getMsg("col_endTime") , width: "160px;"},			//종료시간
		{field: "baseHour", format: "{0:n1}", title : gfn_getMsg("col_baseHour") , width: "140px;"},							//표준공수
		{field: "realTime", format: "{0:n1}", title : gfn_getMsg("col_realTime") , width: "140px;"}								//실적공수
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_routCd"), value: "rout.routing_id" },		//라우팅코드
		{ text: gfn_getMsg("col_eqmtNm"), value: "workBase.eqmt_mgt_nm" },	//설비명
		{ text: gfn_getMsg("col_worker"), value: "workBase.user_nm" }
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

</script>