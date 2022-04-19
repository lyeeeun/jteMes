<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="toolMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="toolMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="toolMgtForm">
			<div class="pop_title"><spring:message code = "pop_toolInfo" text = "공구정보"/></div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:32%;">
				<col style="width:18%;">
				<col style="width:32%;">
			</colgroup>			
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolNm" text = "공구명"/> : </td>
					<td colspan="4">
						<input type="text" id="toolNm" name="toolNm" format="text" readonly/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolType" text = "공구유형"/> : </td>
					<td><input id="toolType" name="toolType" format="selBox" msg="tool_div" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_useLimit" text = "사용한도"/> : </td>
					<td><input type="text" id="toolLimit" name="toolLimit" format="currency" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "비고"/> : </td>
					<td colspan="3"><input type="text" id="toolDesc" name="toolDesc" readonly/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use" class="use"/>
						<input type="hidden" name="action" id="tool_action" class="tool_action"/>
					</td>
				</tr>
			</table>
			<div class="pop_title"><spring:message code = "pop_qtyMgt" text = "수량관리"/></div>
			<div id="jtePopForm_grid" class="toolMgtForm" style="height: 310px; width: 98%; margin: auto; display: flex;" ></div>
		</form>
		
	</div>
</div>

<!-- 팝업(마스터그리드 > 팝업창 내부 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopAddForm">
		<form id = "jtePopAddForm_form" class="toolQtyForm">
			<table style="width:100%;" id="jtePopAddForm_master" class="BasicTable">
			<colgroup>
				<col style="width: 17%;">
				<col style="width: 30%;">
				<col style="width: 20%;">
				<col style="width: 33%;">
			</colgroup>
				<tr><td colspan="4"></td></tr>
				<tr>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_targetDiv" text = "업무구분"/> : </td>
					<td>
						<input id="toolMgtGbn" name="toolMgtGbn" format="selBox" msg="toolMgtGbn" />
					</td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_quantity" text = "수량"/> : </td>
					<td><input id="toolMgtQty" name="toolMgtQty" format = "currency" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_registDate" text = "등록일"/> : </td>
					<td><input id="toolMgtDate" name="toolMgtDate" format="datetimepicker" /></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_registUser" text = "등록자"/> : </td>
					<td>
						<input type="text" id="toolQtyUserNm" class="btn-input" name="toolQtyUserNm" class="k-textbox" readonly />
						<input type="hidden" id="toolQtyUser" name="toolQtyUser" />
						<button class="k-button k-primary" type="button"  onclick= "lfn_addFormUserPop_open()">
						<spring:message code = "btn_search" text = "조회"/></button>
					</td>
				</tr>
				<tr>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_compNm" text = "업체명"/> : </td>
					<td>
						<input type="text" id="compNm" class="btn-input" name="compNm" class="k-textbox" readonly />
						<input type="hidden" id="compId" name="compId" />
						<button class="k-button k-primary" type="button"  onclick= "lfn_addFormCompPop_open()">
						<spring:message code = "btn_search" text = "조회"/></button>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="toolMgtDesc" name="toolMgtDesc" /></td>
				</tr>
				<tr style="display:hidden;">
					<td><input type="hidden" name="action" id="toolQty_action" class="toolQty_action"/>
						<input type="hidden" id="toolId" name="toolId">
					</td>
				</tr>
			</table>
		</form>
		<div class="mtrlMgtForm final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/basMgt/operMgt/toolMgt/toolMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200410 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/facilMgt/mtrltoolMgt"

	lfo_common.crud  = {
		read:{url:"/getToolInfoList", auth:"", prmt:{}}
	};

	lfo_common.model = {
		id: "toolId",
		fields: {
			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolQty: { type: "int" },
			toolType : { type: "string" },
			toolPrice : { type: "int" },
			toolLimit : { type: "int" },
			toolDesc : { type: "string" },
			isUse : { type: "bool" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" },
			toolStd01: { type: "int" },
			toolStd02: { type: "int" },
			toolStd03: { type: "int" },
			toolStd04: { type: "int" },
			toolStd05: { type: "int" },
			toolStdStr01: { type: "string" },
			toolStdStr02: { type: "string" },
			toolStdStr03: { type: "string" },
			toolStdStr04: { type: "string" },
			toolStdStr05: { type: "string" }
		}
	};

	lfo_common.columns = [
		{selectable : true, width:"40px"},
		{field: "toolId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm", "공구명"), width: "210px"},
		{field: "toolQty", format:"{0:n0}", attributes : { style : "text-align : right; color:red;"}, title:gfn_getMsg("col_quantity", "수량"), width: "70px"},
		{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolType", "공구유형"), width: "100px;"},
		{field: "toolLimit", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit", "사용한도"), width: "140px"},
		{field: "toolDesc", title:gfn_getMsg("col_desc", "비고"), width: "300px"}
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_toolNm", "공구명"), value: "toolInfo.tool_nm"}
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "705px", 
		height: "700px",
		id:lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_toolRegist", "공구 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_toolSrh", "공구 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			toolId : lfo_common.gridSelected.toolId
		}
		gfn_popform_set(lfo_common, mode, selectedItem);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {toolId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {toolId :lfo_common.gridSelected.toolId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		//그리드 세팅
		gfn_resizePop(lfo_common.popId, {width:750,height:650});
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();		
	}
}

//공구 수량 정보 팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";

	lfo_popGrd.popId = "jtePopAddForm";

	lfo_popGrd.ctrlUrl = "/cform/facilMgt/mtrltoolMgt"

	lfo_popGrd.crud  = {
		read:{url:"/getToolRecevingHisList", auth:"", prmt:{toolId : lfo_common.gridSelected.toolId}, search : false}, 
		create:{url:"/setToolMgtSave", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback: lfn_jtePopGrd_save},
		update:{url:"/setToolMgtSave", auth:"", openFunc:"", callback: lfn_jtePopGrd_save},
		destroy:{url:"/setToolMgtDelete", auth:"", callback: lfn_jtePopGrd_delete}
	};

	lfo_popGrd.model = {
		id: "toolId",
		fields: {
			toolId: { type: "string" },
			toolMgtId: { type: "string" },
			toolMgtGbn: { type: "string" },
			toolMgtQty: { type: "int" },
			toolMgtDesc: { type: "string" },
			toolMgtDate: { type: "date" },
			compId: { type: "string" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" }
		}
	};

	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMgtId",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("col_update", "수정"), width: "95px"},
		{field: "toolMgtDate", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_registDate", "등록일"), width: "175px"},
		{field: "toolMgtGbn",  template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #",
			title:"사용 구분", width: "120px"},
		{field: "toolMgtQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity", "수량"), width: "90px"},
		{field: "toolMgtDesc", title:gfn_getMsg("col_desc", "비고"), width: "250px"}
	];

	//Object형 그리드 세팅 호출(order-child)
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}


//공구 수량 정보 더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "780px",
		height: "360px",
		id:lfo_popGrd.popId, 
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_toolQtyRegist", "공구 수량 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_toolQtyUp", "공구 수량 수정");
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//공구 수량 정보 팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	lfo_popGrd.gridSelected = {};
	if(mode=='NEW'){
		selectedItem={ 
				toolId : lfo_common.gridSelected.toolId,
				toolMgtDate : new Date(),
				toolQtyUser : $("#_loginUserId").val(),
				toolQtyUserNm :  $("#_loginUserName").val()
		};
		gfn_popform_set(lfo_popGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_popGrd.gridSelected = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_popGrd.gridSelected = {toolMgtId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.read.url,
			type: "POST",
			data: {
				toolId : lfo_common.gridSelected.toolId,  
				toolMgtId:lfo_popGrd.gridSelected["toolMgtId"]
			},
			success: function(data){
				qty = data.rows[0].toolMgtQty;
				if(qty < 0){
					data.rows[0].toolMgtQty = qty * (-1);
				}
				gfn_popform_set(lfo_popGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//공구 수량 정보 Form내용 입력/저장
this.lfn_jtePopGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_popGrd.popId);
					
					//공구 수량 그리드 리로드
					lfo_popGrd.grid.dataSource.read();
					
					//공구 정보 그리드 리로드
					lfo_common.grid.dataSource.read();
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}

}

//공구 수량 정보 삭제 콜백
this.lfn_jtePopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delTemp = lfo_popGrd.grid.dataItem($(this).closest('tr'))
			delPrmt.push(delTemp);
		}
		
	});
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});	
			//공구 수량 그리드 리로드
			lfo_popGrd.grid.dataSource.read();
			
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//업체정보 팝업 -콜백시 유저정보를 매핑해준다.
this.lfn_addFormCompPop_open = function(){
	var callback = function(selectedItem){
		$("#" + lfo_popGrd.popId + "_form").find("[name=compId]").val(selectedItem["compId"]);
		$("#" + lfo_popGrd.popId + "_form").find("[name=compNm]").val(selectedItem["compNm"]);
	}
	gfn_openCustomPop('company',callback, {toolId: $('#toolId').val()});
}

//유저정보 팝업 -콜백시 유저정보를 매핑해준다.
this.lfn_addFormUserPop_open = function(){
	var callback = function(selectedItem){
		$("#" + lfo_popGrd.popId + "_form").find("[name=toolQtyUser]").val(selectedItem["userId"]);
		$("#" + lfo_popGrd.popId + "_form").find("[name=toolQtyUserNm]").val(selectedItem["userNm"]);
	}
	gfn_openCustomPop('userInfo',callback);
}
</script>