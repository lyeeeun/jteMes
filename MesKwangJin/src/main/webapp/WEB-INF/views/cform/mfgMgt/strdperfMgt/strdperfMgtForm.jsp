<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="shipMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<label>수주 : </label>
		<input type="text" class="k-textbox" id="orderId" readonly/>
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_orderInfo()"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="strdperfMgtForm" style="width:100%;">
		<div id="jteSingleGrid" class="strdperfMgtForm strdperfMgtForm-jteSingleGrid"></div>
		<div id="jteSubGrid" class="strdperfMgtForm strdperfMgtForm-jteSubGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="jtePopAddForm" class="jtePopAddForm" style="height:100%">
		<div id="jtePopForm_grid" style="height:340px;"></div>
	</div>
</div>
<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/strdperfMgt/strdperfMgtForm_JJW.css' rel="stylesheet">

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
		$('#jteSingleGrid').empty();
		$('#orderId').val(selectedItem.orderId);

		lfn_jteSgGrd_setGrd();
	};
	gfn_openCustomPop('orderInfo', callback);
}


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.ctrlUrl = "/cform/mfgMgt/strdperfMgt";

	lfo_common.crud  = {
		read:{url:"/getStrdperfList", auth:"", prmt:{orderId : $('#orderId').val()}, search:false},
		update:{url:"", auth:"", openFunc : "", callback:""}
	};

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

	lfo_common.columns = [
		{field: "lotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jteSgGrid_dblclick(\'EDT\',this); " style="min-width:60px;">' + "상세" + '</button>',
			title : gfn_getMsg("btn_search", "조회") , width: "100px"},
		{field: "lotNm", title : gfn_getMsg("col_lotWrkNm", "LoT명"), width: "190px;"},
		{field: "lotQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_lotQty", "LoT수량"), width: "100px;"},	
		{field: "itemNm", title : gfn_getMsg("col_itemNm"), width: "170px;"},
		{field: "baseHour", format: "{0:n1}", title : "표준공수(분)" , width: "130px;"},
		{field: "realTime", format: "{0:n1}", title : "실적공수(분)" , width: "130px;"}
	];

	lfo_common.selectBox = [
		{ text: "수주명", value: "odr.order_nm" },
		{ text: "부품명", value: "item.item_nm" }
	];
	
	//공통 그리드 세팅 호출
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//상세버튼클릭 콜백(팝업)
this.lfn_jteSgGrid_dblclick = function(mode, selectedItem){
	lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
	//그리드 세팅
	if($("#jteSubGrid").html() !=""){
		$("#jteSubGrid").html("");
	}
	lfn_jteSubGrd_setGrd();
	

	$("[name='delToolChk']").change(function(e){
		$("#delStat").val($("[name='delToolChk']:checked").val());
		lfo_subGrd.grid.dataSource.read();
	});
}


//서브 그리드 세팅
this.lfn_jteSubGrd_setGrd = function(){
	lfo_subGrd = {};//Form 내부에서 사용될 Object 

	lfo_subGrd.layoutId = "jteSubGrid";

	lfo_subGrd.popId = "jtePopAddForm";

	lfo_subGrd.ctrlUrl = "/cform/mfgMgt/strdperfMgt";

	lfo_subGrd.crud  = {
		read:{url:"/getAssignList", auth:"", prmt:{lotId : lfo_common.gridSelected.lotId}, dynamicPrmt : {del : "delStat"}, search:false},
		update:{url:"", auth:"", openFunc : "", callback:""}
	};

	lfo_subGrd.model = {
		id: "prodAsmId",
		fields: {
			orderId : { type: "string" },
			lotId : { type: "string" },
			prodAsmId : { type: "string" },
			prodAsmNm : { type: "string" },
			prodAsmDate : { type: "string" },
			prodAsmQty : { type: "int" },
			prodAsmDesc : { type: "string" },
			prodAsmType : { type: "string" },
			prodAsmUser : { type: "string" },
			prodAsmUserNm : { type: "string" },
			prodAsmState : { type: "string" },
			createdAt : { type: "string" },
			creatorId : { type: "string" }
		}
	};

	lfo_subGrd.columns = [
		{field: "prodAsmId", template:'<button class="k-button k-primary" type="button" onclick = "lfn_strdPerfPop(this)" style="width:70px;">조회</button>',
			title: gfn_getMsg("btn_search", "조회"), width: "90px"},
		{field: "prodAsmId", title:gfn_getMsg("col_prodAsmId", "작업지시코드"), width: "170px"},
		{field: "prodAsmNm", title:gfn_getMsg("col_prodAsmNm", "작업지시명"), width: "160px"},
		{field: "prodAsmDate", format: "{0:yyyy-MM-dd}", title:gfn_getMsg("col_prodAsmDate", "작업지시일"), width: "160px"},
		{field: "prodAsmUserNm", title:gfn_getMsg("col_prodAsmUserNm", "작업지시자"), width: "150px"},
		{field: "prodAsmQty", title:gfn_getMsg("col_prodAsmQt", "작업지시량"), width: "150px"}
	];

	//공통 그리드 세팅 호출 compId
	lfo_subGrd.grid = gfn_grid_set(lfo_subGrd);
}

//더블클릭 콜백(팝업)
this.lfn_strdPerfPop = function(target){
	var options = {
		modal:true, 
		width: "1150px",
		height: "350px",
		id : "jtePopAddForm", 
		title:gfn_getMsg("col_routingSt", "표준/실적 공수"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:["Close"]
	};
	
	var dataItem = lfo_subGrd.grid.dataItem($(target).closest("tr"));
	
	lfo_subGrd.gridSelected ={
		prodAsmId : dataItem.prodAsmId
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(dataItem);
	};
	
	this.gfn_winOpen(options);
}

//팝업내부 그리드 
this.lfn_jtePop_set = function(dataItem){
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";

	lfo_popGrd.popId = "";

	lfo_popGrd.ctrlUrl = "/cform/mfgMgt/strdperfMgt";

	lfo_popGrd.crud  = {
		read:{url:"/getStrdperfDetailList", auth:"", prmt:{prodAsmId : dataItem.prodAsmId}, search:false}
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

	lfo_popGrd.columns = [
		{field: "routingId", title : "라우팅 코드" , width: "180px;"},
		{field: "routingType",template:"# var item = gfn_isNull(routingType)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
				title : "공정" , width: "140px;"},
		//{field: "eqmtMgtNm", title : "설비" , width: "200px;"},
		{field: "prodWorkUserNm", title : "작업자" , width: "100px;"},
		{field: "prodWorkGood", format: "{0:n0}", attributes : { style : "text-align : right;"},title : "생산량" , width: "100px;"},
		{field: "prodWorkStart", format: "{0:yyyy-MM-dd hh:mm:ss}",title : "시작시간" , width: "160px;"},
		{field: "prodWorkEnd", format: "{0:yyyy-MM-dd hh:mm:ss}", title : "종료시간" , width: "160px;"},
		{field: "baseHour", format: "{0:n1}", title : "표준공수(분)" , width: "140px;"},
		{field: "realTime", format: "{0:n1}", title : "실적공수(분)" , width: "140px;"}
	];

	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

</script>