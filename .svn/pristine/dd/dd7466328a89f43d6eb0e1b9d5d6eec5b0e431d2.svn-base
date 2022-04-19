<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="mqsToolMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<input type="text" class="k-textbox" id="itemNm" readonly/>
		<input type="hidden" id="itemId">
		<button class="k-button k-primary page-search-btn" type="button" onclick= "lfn_itemInfo();"><spring:message code = "btn_itemSearch"></spring:message></button>
		<input id="rtlEqmtSetSelBox">
	</div>
	<div id="grid-content" class="mqsToolMgtForm-grid" style="width:100%;"> <!-- style="width: 100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="shipPlanPop" class="toolQualMgtForm">
		<div id="shipPlanInfo_grid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="toolListPop" class="toolQualMgtForm">
		<div id="toolListPop_grid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="toolInspForm" class="toolQualMgtForm toolInspForm">
		<form id="toolInspForm_form" class="toolQualMgtForm toolInspForm mtrlOdcursitMgtForm" >
			<div id="rtlEqmtSelBox_area" class="toolQualMgtForm_rtlEqmtSelBox_area">
				<i class="fas fa-caret-right"></i><label><spring:message code = "eqmt_selection"></spring:message> : </label> <!-- 설비 선택 > 설비 선택 : 으로 기호 추가_201015 youmi -->
				<input id="rtlEqmtSelBox">
				<input type="hidden" id="toolInspId" />
			</div>
			<table id="toolInspForm_tb" style="width:100%;" class="toolInspForm_tb mtrlOdcursitMgtForm-table">  <!-- style="width:100%;" -->
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('toolInspForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/toolQualMgt/toolQualMgtForm.css' rel="stylesheet">

<!-- CSS 경로 수정_201014 youmi -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용d

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
	if($("#rtlEqmtSetSelBox").parent().hasClass("k-dropdown") === true) {
		$("#rtlEqmtSetSelBox").data("kendoDropDownList").destroy();
	}
	
	var selBoxItem = new Array();
	
	$.ajax({
		async:false,
		url : "/cform/qualMgt/qualPec/toolQualMgt/selectRtlPlaceInfo",
		type: "POST",
		data: { itemId: $('#itemId').val()},
		success: function(data){
			$.each(data.rows, function(index, item){
				selBoxItem[index] = {"placeId": item.placeId, "placeNm": item.placeNm };
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	$("#rtlEqmtSetSelBox").kendoDropDownList({
		dataTextField: "placeNm",
		dataValueField: "placeId",
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
	lfo_common.popId = "toolInspForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/qualMgt/qualPec/toolQualMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/selectToolInspInfo", auth:"", prmt:{}, dynamicPrmt:{itemId: "itemId", placeId: "rtlEqmtSetSelBox"}, search : false},
		create:{url:"/saveRtlToolInfo", auth:"", openFunc: lfn_toolInspPop_open, callback: lfn_toolRegPop_save},
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
			questionId : { type: "string" },
			toolInspId : { type: "string" },
			inspectDate : { type: "string" },
			inspectorId : { type: "string" },
			inspectorNm : { type: "string" }
		},
	};
	
	//6.
	lfo_common.columns = [
		{field: "itemNm", title: gfn_getMsg("col_itemNm"), width: "140px"},				//제품명
		{field: "eqmtMgtNm", title: gfn_getMsg("col_eqmtNm"), width: "130px"},			//설비명
		{field: "inspectDate", title: gfn_getMsg("col_inspectDate"), width: "130px"},	//검사시간
		{field: "inspectorNm", title: gfn_getMsg("col_inspector"), width: "130px"},		//검사자
		{field: "editOption", title:gfn_getMsg("col_inspectInfo"), width: "120px;",		//검사 정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolInspPop_open(\'EDT\',this); " style="min-width:60px;">' + gfn_getMsg("html_updateInfo") + '</button>' //정보확인/수정
		}
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}

this.lfn_toolInspPop_open = function(mode, rows){
	//초기화
 	var options = {
		modal: true, 
		width: "1000px",
		height: "580px",  
		id : "toolInspForm", 
		title: gfn_getMsg("mn_toolQualMgt"),
		resizable: true,
		animation: {open :{effects:"expand:vertical fadeIn"},
		close : {effects:"expand:vertical fadeIn", reverse: true}},
		actions: [/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode == "NEW") {
			lfn_setPopupSelBox();
		} else {
			lfn_toolInspPop_set(lfo_common.grid.dataItem($(rows).closest("tr")), "EDT");
			$("#toolInspId").val(lfo_common.grid.dataItem($(rows).closest("tr")).toolInspId);
			$("#rtlEqmtSelBox_area").hide();
		}
	
		$(".jte-create").attr("onclick", "lfn_toolInspPop_save('" + mode + "')")
	};
	this.gfn_winOpen(options);
}

this.lfn_setPopupSelBox = function() {
	var selBoxItem = new Array();
	
	$.ajax({
		async:false,
		url : "/cform/item/itemToolMgt/selectAllRtlToolInfo",
		type: "POST",
		data: { itemId: $('#itemId').val()},
		success: function(data){
			var i=0;
			$.each(data.rows, function(index, item){
				if(item.placeId == $("#rtlEqmtSetSelBox").val()) {
					selBoxItem[i] = {"eqmtMgtId": item.eqmtMgtId, "eqmtMgtNm": item.eqmtMgtNm };
					i++;
				}
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
			lfn_toolInspPop_set(this.value(), "NEW");
		}
	});
	
	lfn_toolInspPop_set($("#rtlEqmtSelBox").val(), "NEW");
}

this.lfn_toolInspPop_set = function(target, mode) {
	$("#toolInspForm_tb").empty();
	var pToolInspId = "";
	if(mode == "EDT") {
		pToolInspId = target.toolInspId;
		target = target.eqmtMgtId;
	}
	
	$.ajax({
		async:false,
		url : "/cform/item/itemToolMgt/selectAllRtlToolInfo",
		type: "POST",
		data: { itemId: $('#itemId').val(), eqmtMgtId: target },
		success: function(data){
			
			if(data.rows.length == 0) {
				$(".jte-create").hide();
				kendo.confirm("해당 품목-설비에 설정된 공구 정보가 없습니다.");
				return false;
			} else {
				$(".jte-create").show();
				$("#toolInspForm_tb").append("" +
						"<colgroup>" +
						"<col class='col-input-list-1'>" +
						"<col class='col-input-list-2'>" +
						"<col class='col-input-list-3'>" +
						"<col class='col-input-list-4'>" +
						"<col class='col-input-list-5'>" +
						"<col class='col-input-list-6'>" +
						"<col class='col-input-list-7'>" +
						"</colgroup>" +
						"<tr class='mtrlOdcursitMgtForm input-list pop_selfInspect_Form_title'>" +
						"<td>" + gfn_getMsg("col_inspectItem") + "</td>" +			//검사항목
						"<td>" + gfn_getMsg("col_toolNum") + "</td>" +				//공구 번호
						"<td>" + gfn_getMsg("col_inspectStandard") + "</td>" +		//점검 기준
						"<td>" + gfn_getMsg("col_toolLife") + "</td>" +				//공구 수명	
						"<td>" + gfn_getMsg("col_state") + "</td>" +				//상태
						"<td>" + gfn_getMsg("col_before") + "</td>" +				//전	
						"<td>" + gfn_getMsg("col_after") + "</td>" +				//후
						"</tr>");
				
				$.each(data.rows, function(index, item){
					$('#toolInspForm_tb').append("<tr id=" + item.questionId + ">" +
							"<td>" + gfn_getMsg('bc_'+ item.questionId) + "</td>" +
							"<td>" + item.toolMgtId + "</td>" +
							"<td>" + item.inspectStandard + "</td>" +
							"<td>" + item.toolChange + "</td>" +
							"<td><input class='k-textbox center-input' name='stateValue' type='text' \></td>" +
							"<td><input id='beforeValue" + index + "' name='beforeValue' \></td>" +
							"<td><input id='afterValue" + index + "' name='afterValue' \></td>" +
							"</tr>");
					
					$("#beforeValue" + index).kendoNumericTextBox({
						format: "n",
						value: 0
					});
					
					$("#afterValue" + index).kendoNumericTextBox({
						format: "n",
						value: 0
					});
					
				});
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	if(mode == "EDT") {
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/selectInspHistory",
			type: "POST",
			data: {toolInspId: pToolInspId},
			traditional :true,
			success: function(data){
				$.each(data.rows, function(index, item) {
					$('#' + item.questionId).find('input[name=stateValue]').val(item.stateValue);
					$('#' + item.questionId).find('input[name=beforeValue]').data("kendoNumericTextBox").value(item.beforeValue);
					$('#' + item.questionId).find('input[name=afterValue]').data("kendoNumericTextBox").value(item.afterValue);
				})
			}, error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
}

this.lfn_toolInspPop_save = function(mode){
	var insertInspectList = new Array();
	var updateInspectList = new Array();
	
	var svcUrl = "";
	var savePrmt = {};
	
	var itemId = $("#itemId").val();
	var eqmtMgtId = $("#rtlEqmtSelBox").val();
	
	if(mode == "NEW") {
		$("#toolInspForm_tb").find('tr').each(function(index, item) {
			if(index == 0) {
				return true
			}
			insertInspectList.push({ 
				itemId: itemId,
				eqmtMgtId: eqmtMgtId,
				questionId: $(item).attr('id'), 
				stateValue: $(item).find('input[name=stateValue]').val(), 
				beforeValue: $(item).find('input[name=beforeValue]').val(),
				afterValue: $(item).find('input[name=afterValue]').val(),
			});
		});
		svcUrl = "/insertToolInspInfo";
		savePrmt.toolInspectList = insertInspectList;
	} else if(mode == "EDT") {
		$("#toolInspForm_tb").find('tr').each(function(index, item) {
			if(index == 0) {
				return true
			}
			updateInspectList.push({
				toolInspId: $("#toolInspId").val(),
				questionId: $(item).attr('id'), 
				stateValue: $(item).find('input[name=stateValue]').val(), 
				beforeValue: $(item).find('input[name=beforeValue]').val(),
				afterValue: $(item).find('input[name=afterValue]').val()
			});
		});
		svcUrl = "/updateToolInspInfo";
		savePrmt.toolInspectList = updateInspectList;
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + svcUrl,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			gfn_closePop(lfo_common.popId);
			kendo.confirm("성공적으로 저장되었습니다.");
			lfo_common.grid.dataSource.read();
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

</script>