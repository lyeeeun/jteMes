<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="mtrlInputStaForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrlInputStaForm"></div>
</div>

<!-- 팝업(마스터 그리드> 더블클릭)  -->
<div style="display:none;">
	<div id="jtePopForm" class="mtrlInputStaForm jtePopForm">
		<div class="pop_title">작업 지시별 자재 투입 현황</div>
		<div id="jtePopForm_grid" style="height:350px;"></div>
	</div>
</div>

<link href='/resources/mes/css/contents/mfgMgt/mfgplanMgt/mrplanMgt/mrplanMgtForm.css' rel="stylesheet">

<script>
var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {}; //Form 내부에서 사용될 Object
	

	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/mtrl/mtrlInputSta"
	
	//4.
		lfo_common.crud  = {
			read:{url:"/getLotList", auth:"", prmt:{}, dynamicPrmt : {orderId : "orderId" }}
		};
	
	//5. 
	lfo_common.model = {
			id: "orderId",
			fields : {
				orderId : { type: "String" },
				orderNm : { type: "String" },
				lotId : { type: "String" },
				lotNm : { type: "String" },
				itemNm : { type: "String" },
				lotQty : { type: "int" }
			}
	};
	
	//6.
	lfo_common.columns = [
		{field: "orderId", title:gfn_getMsg("btn_search") ,width: "80px",
			template: function(rows){
				return '<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); ">작업지시별</button>';
			}
		},
		{field: "lotId", title:gfn_getMsg("col_lotCd", "LoT코드"), width: "170px;"},
		{field: "lotNm", title:gfn_getMsg("col_lotWrkNm", "LoT명"), width: "170px;"},
		{field: "lotQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_lotQty", "LoT수량"), width: "120px;"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm", "부품명"), width: "220px;"}
		
		
	];
	
	lfo_common.customTitle = {
			html: '<button class="k-button k-primary" type="button" onclick = "lfn_order(\'all\');" style="min-width:60px;">전체 검색</button> &nbsp; <button class="k-button k-primary" type="button" onclick = "lfn_order(\'order\');" style="min-width:60px;">수주 검색</button>' +
			'<input class="k-textbox" id="orderNm" readonly/><input type="hidden" id="orderId" /> '
		};
	
	//7
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm", "부품명"), value: "item.item_nm" },
		{ text: gfn_getMsg("col_lotWrkNm", "LoT명"), value: "lot.lot_nm" }
	];
	
	
	
	//공통 그리드 세팅 호출
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//자재 투입 현황 팝업 오픈
this.lfn_jtePop_open = function(mode, target){

	var options = {
			modal:true, 
			width: "900px",
			height: "388px", 
			id : lfo_common.popId, 
			title: "작업지시별 자재 투입 현황",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		lfo_common.gridSelected = lfo_common.grid.dataItem($(target).closest("tr"));
		
	
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	};
	this.gfn_winOpen(options);
}

//수주별 LoT 조회
this.lfn_order = function(mode){
	
	if(mode == 'order') {
		var callback = function(selectedItem){
			$('#orderNm').val(selectedItem.orderNm);
			$('#orderId').val(selectedItem.orderId);
			
			lfo_common.grid.dataSource.read();
		};
		
		gfn_openCustomPop("orderInfo", callback);
	} else {
		$('#orderNm').val(null);
		$('#orderId').val(null);
		
		lfo_common.grid.dataSource.read();
	}
	
}


//자재 투입 현황 팝업 내부 그리드
this.lfn_jtePopGrd_setGrd = function(){
	
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	lfo_popGrd.popId = "jtePopAddForm";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/mtrl/mtrlInputSta";
	
	//4.
	lfo_popGrd.crud = {
		read:{url:"/getMtrlInputList", auth:"", search:false, paging:false, prmt:{lotId: lfo_common.gridSelected.lotId }}
	};
	
	//5.
	lfo_popGrd.model = {
		id : "prodAsmId",
		fields: {
			prodAsmId : { type : "string" },
			prodAsmNm : { type : "string" },
			mtrlNm : { type : "string" },
			prodWorkGood : { type : "string" },
			prodWorkBad : { type : "string" },
			bomTargetCnt: { type : "int" },
			inputQty : { type : "int" }
		}
	};
	
	//6. 
	lfo_popGrd.columns = [
		{field: "prodAsmId", title:"작업지시코드", width: "140px;"},
		{field: "prodAsmNm", title:"작업지시명", width: "140px;"},
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "140px;"},
		{field: "prodWorkGood",format: "{0:n0}", attributes : { style : "text-align : right;"}, title: "생산량", width:"85px;"},
		{field: "prodWorkBad",format: "{0:n0}", attributes : { style : "text-align : right;"}, title: "불량량", width:"85px;"},
		{field: "bomTargetCnt",format: "{0:n0}", attributes : { style : "text-align : right;"}, title: "표준량", width:"85px;"},
		{field: "inputQty",format: "{0:n0}", attributes : { style : "text-align : right;"}, title: "자재투입량", width:"100px;"}	
	];
	
	//공통 팝업 내부 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}



</script>