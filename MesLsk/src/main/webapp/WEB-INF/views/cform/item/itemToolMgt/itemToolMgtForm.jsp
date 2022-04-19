<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="itemToolMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<input type="text" class="k-textbox" id="itemNm" readonly/>
		<input type="hidden" id="itemId">
		<button class="k-button k-primary page-search-btn" type="button" onclick= "lfn_itemInfo();"><spring:message code = "btn_itemSearch"></spring:message></button>
		<input id="rtlEqmtSelBox">
		<!-- <button class="k-button k-primary page-search-btn" type="button" onclick= "lfn_jteSgGrd_setGrd();">관련 공구 조회</button> -->
		
	</div>
	<div id="grid-content" class="mqsToolMgtForm-grid" style="width:100%;"> <!-- style="width: 100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="shipPlanPop">
		<div id="shipPlanInfo_grid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="toolListPop">
		<div id="toolListPop_grid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="toolRegForm" class="itemToolMgtForm">
		<form id="toolRegForm_form" class="itemToolMgtForm" style="width:100%;">
			<table id="toolRegForm_master" class="itemToolMgtForm" style="width:100%;">
				<colgroup>
					<col class="col-left-title"> 
					<col class="col-right-content-1">
					<col class="col-right-content-2">
				</colgroup>
				<tr>
				<!-- 기술문서 그룹 구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "mn_toolMgt"></spring:message> : </td>
					<td>
						<input type="text" id="toolMgtId" class="left-input btn-input" name="toolMgtId" readonly/>
						<input type="hidden" name="action" id="toolInfoAction"/>
					</td>
					<td><button class="k-button k-primary search-btn" id="btnToolInfo" type="button" onclick= "lfn_toolInfo();"><spring:message code = "btn_toolSearch"></spring:message></button></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspectItem"></spring:message> : </td>
					<td colspan="2"><input id="questionId" class="center-input" name="questionId" msg="qual_tool_insp" format="selBox"></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspectStandard"></spring:message> : </td>
					<td colspan="2"><input id="inspectStandard" class="center-input" name="inspectStandard" format="text"></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolLife"></spring:message> : </td>
					<td colspan="2"><input id="toolChange" class="center-input" name="toolChange" format="currency"></td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('toolRegForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- CSS -->
<link href='/resources/mes/css/contents/item/itemToolMgt/itemToolMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_selBoxBind();
	//그리드 생성
};

this.lfn_itemInfo = function() {
	var callback = function(selectedItem){
		$('#itemId').val(selectedItem.itemId);
		$('#itemNm').val(selectedItem.itemNm);
		
		lfn_selBoxBind();
		lfn_jteSgGrd_setGrd();
	};
	gfn_openCustomPop('item', callback);
}

this.lfn_toolInfo = function() {
	var callback = function(selectedItem){
		$("#toolMgtId").val(selectedItem.toolMgtId)
	};
	gfn_openCustomPop('toolMgt', callback);
}

this.lfn_selBoxBind = function(){
	if($("#rtlEqmtSelBox").parent().hasClass("k-dropdown") === true) {
		$("#rtlEqmtSelBox").data("kendoDropDownList").destroy();
	}

	var selBoxItem = new Array();
	
	$.ajax({
		async:false,
		url : "/cform/item/itemToolMgt/selectAllRtlToolInfo",
		type: "POST",
		data: { itemId: $('#itemId').val()},
		success: function(data){
			$.each(data.rows, function(index, item){
				selBoxItem[index] = {"eqmtMgtId": item.eqmtMgtId, "eqmtMgtNm": item.eqmtMgtNm };
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	$("#rtlEqmtSelBox").kendoDropDownList({
		dataTextField: "eqmtMgtNm",
		dataValueField: "eqmtMgtId",
		dataSource: selBoxItem,
		index: 0,
		change: function(e) {
			lfo_common.grid.dataSource.read();
		}
	});
}

// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	$("#jteSingleGrid").empty();
	
	lfo_common = {};//Form 내부에서 사용될 Object
	lfo_common.count = 0;
	
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
		6. gridObject.columns = fieldColumns
		7. gridObject.selectBox = SelectBox 매핑 값 
	*/
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "toolRegForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/item/itemToolMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/selectRtlToolInfo", auth:"", prmt:{}, dynamicPrmt:{itemId: "itemId", eqmtMgtId: "rtlEqmtSelBox"}, search : false},
		create:{url:"/saveRtlToolInfo", auth:"", openFunc: lfn_toolRegPop_open, callback: lfn_toolRegPop_save},
		update:{url:"/saveRtlToolInfo", auth:"", callback: lfn_toolRegPop_save},
		destroy:{url:"/deleteRtlToolInfo", auth:"", callback: lfn_rtlToolInfo_delete}
	};
	
	//5.
	lfo_common.model = {
		fields: {
			itemId : { type: "string" },
			itemNm : { type: "string" },
			placeId : { type: "string" },
			placeNm : { type: "string" },
			eqmtMgtId : { type: "string" },
			eqmtMgtNm : { type: "string" },
			toolMgtId : { type: "string" },
			inspectStandard : { type: "string" },
			toolChange: { type: "int" },
			questionId : { type: "string" }
		},
	};
	
	//6.
	lfo_common.columns = [
		// {field: "itemId", title: "제품 번호", width: "140px"},
		// {field: "itemNm", title: "제품 명칭", width: "140px"},
		// {field: "placeId", title: "차수", width: "160px"},
		// {field: "placeNm", title: "위치 명", width: "160px"},
		// {field: "eqmtMgtId", title: "NC PGMNO", width: "130px"},
		// {field: "eqmtMgtNm", title: "설비 명", width: "130px"},
		{selectable : true, width:"40px"},
		{field: "questionId", template:"# var item = gfn_isNull(gfn_getCode(questionId))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(questionId).cdId , gfn_getCode(questionId).cdNm) # #= item #", 
			title: gfn_getMsg("col_inspectItem"), width: "140px;"},									//점검 항목 		//발주상황 구분
		{field: "toolMgtId", title: gfn_getMsg("col_toolNum"), width: "130px"},						//공구 번호
		{field: "inspectStandard", title: gfn_getMsg("col_inspectStandard"), width: "130px"},		//점검 기준
		{field: "toolChange",  title: gfn_getMsg("col_toolLife"), width: "130px"},					//공구 수명
		{field: "editOption", title:gfn_getMsg("col_update"), width: "120px;",		//수정
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolRegPop_open(\'EDT\',this); " style="min-width:60px;">' + gfn_getMsg("col_update") + '</button>'
		}
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}

this.lfn_toolRegPop_open = function(mode, rows){
	//초기화
 	var options = {
		modal: true, 
		width: "430px", /* 201015 JJW 1000-> 430 */
		height: "280px",  /* 201015 JJW 580-> 280 */
		id : "toolRegForm", 
		title: gfn_getMsg("mn_toolMgt"),
		resizable: true,
		animation: {open :{effects:"expand:vertical fadeIn"},
		close : {effects:"expand:vertical fadeIn", reverse: true}},
		actions: [/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		gfn_popform_set(lfo_common, mode, $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest('tr')));
		
		if(mode == "EDT") {
			$("#questionId").data("kendoDropDownList").readonly();
			$("#btnToolInfo").hide();
		}
	};
	this.gfn_winOpen(options);
}

this.lfn_toolRegPop_save = function(mode){
	var formId = lfo_common.popId+"_form";
	var savePrmt = gfn_serializeObject(formId);
	
	savePrmt.itemId = $('#itemId').val();
	savePrmt.eqmtMgtId = $('#rtlEqmtSelBox').val();
	
	var flag = lfn_validationCheck(savePrmt);

	if(flag && mode == "create") {
		kendo.confirm("해당 항목은 이미 설정되어 있습니다.");
		return false;
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			
			gfn_closePop(lfo_common.popId);
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

this.lfn_validationCheck = function(pSavePrmt) {
	var key = {itemId: pSavePrmt.itemId, eqmtMgtId: pSavePrmt.eqmtMgtId, questionId: pSavePrmt.questionId};
	
	var flag;
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + '/selectDupleKeyCheck',
		type: "POST",
		data: JSON.stringify(key),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			flag = data;
		},error: function(ex){
			gfn_loading(false);
		}
	});
	
	return flag;
}

this.lfn_rtlToolInfo_delete = function(){
	var delPrmt = [];

	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_common.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}


</script>