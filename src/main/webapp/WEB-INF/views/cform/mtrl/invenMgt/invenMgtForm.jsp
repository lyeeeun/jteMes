<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="width:100%;">
	<div class="infergodsMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<input class="k-radio" type="radio" name="target" value="mtrl" checked><span class="radio-span"><spring:message code = "mn_mtrl"/></span>
		<input class="k-radio" type="radio" name="target" value="item"><span class="radio-span"><spring:message code = "mn_item"/></span>
	</div>
	<div id="grid-content" class="infergodsMgtForm"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="jtePopAddForm">
		<div id="jtePopForm_grid"></div>
	</div>
</div>

<link href='/resources/mes/css/contents/qualMgt/infergodsMgt/infergodsMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {}; 

var lfo_popGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd("mtrl");
	lfn_radioBtn_event();
};

this.lfn_radioBtn_event = function(){
	$("input:radio[name=target]").click(function(e){
		$('#jteSingleGrid').empty();
		lfn_jteSgGrd_setGrd($(this).val());
	}); 
}

// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(gubun){
	lfo_common = {};

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopAddForm";

	lfo_common.ctrlUrl = "/cform/mtrl/invenMgt";

	lfo_common.crud  = {
		read:{url:"/getInvenMgtList", auth:"", prmt:{selectTarget: gubun}}
	};

	if(gubun == "item"){
		
		lfo_common.model = {
			id: "itemMgtId",
			fields: {
				itemId : { type: "string" },
				itemNm : { type: "string" },
				itemType : { type: "string" },
				itemMgtId : { type: "string" },
				itemStock: { type: "int" },
				updatedAt: { type: "date" }
			}
		};
		
		lfo_common.columns = [
			{field: "itemNm", title:gfn_getMsg("col_itemNm", "제품명"), width: "200px"},
			{field: "itemMgtId", title:gfn_getMsg("col_itemIndivCd", "제품입고코드"), width: "200px"},
			{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
				title:gfn_getMsg("col_itemType", "제품유형"), width: "160px"},	
			{field: "itemStock", format: "{0:n0}", attributes : { style : "color: blue; font-weight:bold; text-align : right;"}, title:gfn_getMsg("col_indivStockQty", "제품 수량"), width: "160px"},
			{field: "itemMgtId", title:gfn_getMsg("col_invenHistory", "재고 히스토리"), width: "100px",	
				template : function(rows) {
					return '<button class="k-button k-primary" type="button" onclick="lfn_jtePop_open(\'item\', this)"><spring:message code = "pop_view"/></button>';
				}
			}
		];
	
		lfo_common.selectBox = [
			{ text: gfn_getMsg("col_itemNm", "제품명"), value: "itemInfo.item_nm" },
			{ text: gfn_getMsg("col_itemIndivCd", "제품입고코드"), value: "itemMgt.item_mgt_id" }
		];
		
	} else if(gubun == "mtrl") {
		
		lfo_common.model = {
			id: "mtrlMgtId",
			fields: {
				mtrlId: { type: "string" },
				mtrlNm: { type: "string" },
				mtrlStd04 : { type: "string" },
				mtrlMgtId : { type: "string" },
				mtrlMgtCnt: { type: "int" },
				updatedAt: { type: "date" }
			}
		};
		
		lfo_common.columns = [
			{field : "mtrlNm", title : gfn_getMsg("col_mtrlNm", "자재명"), width: "200px"},
			{field : "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd", "자재입고코드"), width: "200px"},
			{field : "mtrlMgtCnt", format: "{0:n0}", attributes : { style : "color: blue; font-weight:bold; text-align : right;"}, title:gfn_getMsg("col_mtrlCnt", "자재수량"), width: "180px"},
			{field : "mtrlStd04", title: "최소재고",   attributes: { style: "color: red; font-weight:bold;  text-align:right;" }, width: "180px"},
			{field : "mtrlMgtId", title:gfn_getMsg("col_invenHistory", "재고 히스토리"), width: "100px",
				template : function(rows) {
					return '<button class="k-button k-primary" type="button" onclick="lfn_jtePop_open(\'mtrl\', this)"><spring:message code = "pop_view"/></button>';
				}
			}
		];

		lfo_common.selectBox = [
			{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlInfo.mtrl_nm" },
			{ text: gfn_getMsg("col_mtrlIndivCd", "자재입고코드"), value: "mtrlMgt.mtrl_mgt_id" }
		];
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(selectTarget, param){
	
	var selectedItem; 
	if(selectTarget == "item") {
		selectedItem = lfo_common.grid.dataItem($(param).closest('tr')).itemMgtId;
	} else if(selectTarget == "mtrl") {
		selectedItem = lfo_common.grid.dataItem($(param).closest('tr')).mtrlMgtId;
	}
	
	var options = {
		modal:true, 
		width: "1050px", 
		height: "430px", 
		id : lfo_common.popId,
		title : gfn_getMsg("col_invenHistory", "재고 히스토리"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_gridSet(selectTarget, selectedItem);
		$('#jtePopForm_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}

//팝업내부 그리드 
this.lfn_jtePop_gridSet = function(selectTarget, selectedItem){
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";

	lfo_popGrd.ctrlUrl = "/cform/mtrl/invenMgt";

	if(selectTarget == "item") {
		lfo_popGrd.crud  = {
			read:{url:"/getItemHisList", auth:"", prmt:{itemMgtId: selectedItem}}
		};
	} else if(selectTarget == "mtrl") {
		lfo_popGrd.crud  = {
			read:{url:"/getMtrlHisList", auth:"", prmt:{mtrlMgtId: selectedItem}}
		};
	}
	
	if(selectTarget == "item") {
		
		lfo_popGrd.model = {
			id: "qmParent",
			fields: {
				itemId : { type: "string" },
				itemMgtId : { type: "string" },
				itemQtyTarget : { type: "string" },
				itemQtyTargetCode : { type: "string" },
				itemQtyTotal : { type: "string" },
				itemQtyDesc : { type: "string" },
				itemQtyPgCd : { type: "string" },
				itemQtyPgNm : { type: "string" },
				itemQtyDate : { type: "string" },
				itemQtyUser : { type: "string" },
				itemQtyUserNm : { type: "string" }
			}
		};
		
		lfo_popGrd.columns = [
			{field: "itemQtyTarget",  template:"# var item = gfn_isNull(gfn_getCode(itemQtyTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemQtyTarget).cdId , gfn_getCode(itemQtyTarget).cdNm) # #= item #",
				title:gfn_getMsg("col_targetDiv", "업무구분"), width: "120px"},
			{field: "itemQtyTargetCode", title:gfn_getMsg("col_divCd", "업무코드"), width: "190px"},
			{field: "itemQtyTotal", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity", "수량"), width: "100px"},
			{field: "itemQtyDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate", "등록일"), width: "180px"},
			{field: "itemQtyUserNm", title:gfn_getMsg("col_registUser", "등록자"), width: "120px"},
			{field: "itemQtyDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
		];
	
		lfo_popGrd.selectBox = [
			{ text: gfn_getMsg("col_registUser", "등록자"), value: "u_table.itemQtyUserNm" },
			{ text: gfn_getMsg("col_divCd", "업무코드"), value: "u_table.itemQtyTargetCode" }
		];
	} else if(selectTarget == "mtrl") {
		lfo_popGrd.model = {
			id: "qmParent",
			fields: {
				mtrlMgtId : { type: "string" },
				mtrlQtyTarget : { type: "string" },
				mtrlQtyTargetCode : { type: "string" },
				mtrlQtyTotal : { type: "string" },
				mtrlQtyDesc : { type: "string" },
				mtrlQtyPgCd : { type: "string" },
				mtrlQtyPgNm : { type: "string" },
				mtrlQtyDate : { type: "string" },
				mtrlQtyUser : { type: "string" }
			}
		};
		
		lfo_popGrd.columns = [
			{selectable : true, width:"45px"},
			{field: "mtrlQtyTarget",  template:"# var item = gfn_isNull(gfn_getCode(mtrlQtyTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlQtyTarget).cdId , gfn_getCode(mtrlQtyTarget).cdNm) # #= item #",
				title:gfn_getMsg("col_targetDiv", "업무구분"), width: "120px"},
			{field: "mtrlQtyTargetCode", title:gfn_getMsg("col_divCd", "업무코드"), width: "190px"},
			{field: "mtrlQtyTotal", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity", "수량"), width: "100px"},
			{field: "mtrlQtyDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate", "등록일"), width: "175px"},
			{field: "mtrlQtyUserNm", title:gfn_getMsg("col_registUser", "등록자"), width: "130px"},
			{field: "mtrlQtyDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
		];

		lfo_popGrd.selectBox = [
			{ text: gfn_getMsg("col_registUser", "등록자"), value: "u_table.mtrlQtyUserNm" },
			{ text: gfn_getMsg("col_divCd", "업무코드"), value: "u_table.mtrlQtyTargetCode" }
		];
	}
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>