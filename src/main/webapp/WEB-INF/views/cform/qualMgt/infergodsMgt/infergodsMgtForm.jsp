<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 마스터 그리드 영역 -->
<div style="width:100%;">
	<div class="infergodsMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<input class="radio-btn" type="radio" name="target" value="mtrl" checked><span class="radio-span">자재</span>
		<input class="radio-btn" type="radio" name="target" value="item"><span class="radio-span">제품</span>
	</div>
	<div id="grid-content" class="infergodsMgtForm"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="historyPop">
		<div id="history_grid"></div>
	</div>
</div>

<link href='/resources/mes/css/contents/qualMgt/infergodsMgt/infergodsMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

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


this.lfn_jteSgGrd_setGrd = function(gubun){
	lfo_common = {};//Form 내부에서 사용될 Object 

	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	/* lfo_common.popId = "jtePopForm"; */
	lfo_common.popId = "historyPop";
	
	//3.
	lfo_common.ctrlUrl = "/cform/qualMgt/infergodsMgt"
	
	lfo_common.crud  = {
			read:{url:"/getBadRate", auth:"", prmt:{selectTarget: gubun}},
	};

	if(gubun == "item") {
		lfo_common.model = {
			id: "lotId",
			fields: {
				lotId : { type: "string" },
				itemNm : { type: "string" },
				totalQty : { type: "int" },
				totalBadQty : { type: "int" },
				totalBadRate : { type: "float" }
			}
		};
		lfo_common.columns = [
			{field: "lotId", title : gfn_getMsg("col_lotCd", "LoT 코드"), width: "180px"},
			{field: "itemNm", title : gfn_getMsg("col_itemNm", "부품명"), width: "200px"},
			{field: "totalQty", title : gfn_getMsg("col_orderQty", "주문수량"), width: "160px"},
			{field: "totalBadQty", title : gfn_getMsg("col_badProdQuan", "불량량"), width: "160px"},
			{field: "totalBadRate", template:"#= totalBadRate.toFixed(2) # %", title : gfn_getMsg("col_badRate", "불량률"), width: "160px"},
			{field: "historyPop", title:gfn_getMsg("col_option", "옵션"), width: "180px",
				template : function(rows) {
					return '<button class="k-button k-primary" type="button" onclick="lfn_historyPop_open(\'item\', this)"><spring:message code = "col_historyConfirm"/></button>';
				}
			}
		];
		
		lfo_common.selectBox = [
			{ text: gfn_getMsg("col_itemNm", "부품명"), value: "itemNm" }
		];
	} else if(gubun == "mtrl") {
		lfo_common.model = {
			id: "mtrlMgtId",
			fields: {
				mtrlMgtId : { type: "string" },	
				mtrlNm : { type: "string" },
				mtrlDiv : { type: "string" },
				totalQty : { type: "int" },
				totalBadQty : { type: "int" },
				totalBadRate : { type: "float" }
			}
		};
		
		lfo_common.columns = [
			{field: "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd", "자재개별코드"), width: "180px"},
			{field: "mtrlNm", title : gfn_getMsg("col_mtrlNm", "자재명"), width: "160px"},
			{field: "totalQty", title : gfn_getMsg("col_orderQty", "주문수량"), width: "160px"},
			{field: "totalBadQty", title : gfn_getMsg("col_badProdQuan", "불량량"), width: "160px"},
			{field: "totalBadRate", template:"#= totalBadRate.toFixed(2) # %", title : gfn_getMsg("col_badRate", "불량률"), width: "160px"},
			{field: "historyPop", title:gfn_getMsg("col_history", "옵션"), width: "180px",
				template : function(rows) {
					return '<button class="k-button k-primary" type="button" onclick="lfn_historyPop_open(\'mtrl\', this)"><spring:message code = "col_historyConfirm"/></button>';
				}
			}
		];
		
		lfo_common.selectBox = [
			{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlQty.mtrl_nm" }
		];
	}

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_historyPop_open = function(selectTarget, param) {
	
	var selectedItem; 
	if(selectTarget == "item") {
		selectedItem = lfo_common.grid.dataItem($(param).closest('tr')).lotId;
	} else if(selectTarget == "mtrl") {
		selectedItem = lfo_common.grid.dataItem($(param).closest('tr')).mtrlMgtId;
	}
	
	var options = {
		modal:true, 
		width: "1250px", 
		height: "470px", 
		id:lfo_common.popId, 
		title:gfn_getMsg("pop_badHisSrh", "불량 이력 조회"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	options.callback = function(){
		lfn_historyPop_gridSet(selectTarget, selectedItem);
		$('#history_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
	
}

this.lfn_historyPop_gridSet = function(selectTarget, selectedItem){
	//1.
	lfo_popGrd.layoutId = "history_grid";
	
	//2.
	lfo_popGrd.popId = "historyPop";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/qualMgt/infergodsMgt";
	
	//4.
	if(selectTarget == "item") {
		lfo_popGrd.crud  = {
			read:{url:"/getItemBadList", auth:"", prmt:{lotId: selectedItem}},
		};
	} else if(selectTarget == "mtrl") {
		lfo_popGrd.crud  = {
			read:{url:"/getMtrlBadList", auth:"", prmt:{mtrlMgtId: selectedItem}}, 
		};
	}
	
	if(selectTarget == "item") {
		lfo_popGrd.model = {
			id: "lotId",
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
				itemId : { type: "string" },
				itemNm : { type: "string" },
				lotId : { type: "string" },
				badDesc : { type: "text" },
				badPgUser : { type: "string" },
				badPgUserNm : { type: "string" },
				badPgDate : { type: "date" }
			}
		};
		lfo_popGrd.columns = [
			{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
				title : gfn_getMsg("col_badCd", "불량코드"), width: "160px;"},
			{field: "badId", title : gfn_getMsg("col_badId", "불량아이디"), width: "170px"},
			{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
				title : gfn_getMsg("col_badInfo", "불량정보"), width: "220px;"},
			{field: "badQty",format: "{0:n0}", title : gfn_getMsg("col_badProdQuan", "불량량"), width: "110px"},
			{field: "chkUserNm", format: "{0:n0}", title : gfn_getMsg("col_inspector", "검사자"), width: "130px"},
			{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate", "검사일"), width: "120px"},
			{field: "badPgDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_workDate", "작업일"), width: "120px"},
			{field: "badPgUserNm", title : gfn_getMsg("col_representative", "담당자"), width: "130px"},
			{field: "badPgNm", title : gfn_getMsg("col_progNm", "프로그램명"), width: "180px"},
			{field: "badPgCd", title : gfn_getMsg("col_progCd", "프로그램코드"), width: "180px"},
			{field: "badDesc", title : gfn_getMsg("col_desc", "설명"), width: "250px"}
		];
		
		lfo_popGrd.selectBox = [
			{ text: gfn_getMsg("col_itemNm", "부품명"), value: "itemNm" }
		];
	} else if(selectTarget == "mtrl") {
		lfo_popGrd.model = {
			id: "mtrlMgtId",
			fields: {
				chkDate : { type: "date" },
				badTarget : { type: "string" },
				badTargetCode : { type: "string" },
				badTargetNm : { type: "string" },
				badDesc : { type: "string" },
				mtrlId : { type: "string" },
				mtrlNm : { type: "string" },
				mtrlMgtId : { type: "string" },
				badPgUser : { type: "string" },
				badPgUserNm : { type: "string" },
				badPgDate : { type: "date" },
				badPgCd : { type: "string" },
				badPgNm : { type: "string" },
				mtrlDiv : { type: "string" }
			}
		};
		
		lfo_popGrd.columns = [
			{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
				title : gfn_getMsg("col_badCd", "불량코드"), width: "160px;"},
			{field: "badId", title : gfn_getMsg("col_badId", "불량아이디"), width: "170px"},
			{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
				title : gfn_getMsg("col_badInfo", "불량정보"), width: "220px;"},
			{field: "badQty",format: "{0:n0}", title : gfn_getMsg("col_badProdQuan", "불량량"), width: "110px"},
			{field: "chkUserNm", format: "{0:n0}", title : gfn_getMsg("col_inspector", "검사자"), width: "130px"},
			{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate", "검사일"), width: "120px"},
			{field: "badPgDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_workDate", "작업일"), width: "120px"},
			{field: "badPgUserNm", title : gfn_getMsg("col_representative", "담당자"), width: "130px"},
			{field: "badPgNm", title : gfn_getMsg("col_progNm", "프로그램명"), width: "180px"},
			{field: "badPgCd", title : gfn_getMsg("col_progCd", "프로그램코드"), width: "180px"},
			{field: "badDesc", title : gfn_getMsg("col_desc", "설명"), width: "250px"}
		];
		
		lfo_popGrd.selectBox = [
			{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlNm" }
		];
	}
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>