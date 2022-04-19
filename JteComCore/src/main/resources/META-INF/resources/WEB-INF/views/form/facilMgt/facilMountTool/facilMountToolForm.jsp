<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="facilMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="facilMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="toolMgtForm">
			<div class="pop_title"><spring:message code = "pop_eqmtInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:30%;">
				<col style="width:22%;">
				<col style="width:30%;">
			</colgroup>
				<tr>
				<!-- 설비코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtCd"></spring:message> : </td>
					<td><input type="text" id="eqmtMgtId" name="eqmtMgtId" readonly/></td>
				<!-- 설비구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtDiv"></spring:message> : </td>
					<td><input id="eqmtGbn" name="eqmtMgtGbn"  format = "selBox" msg="eqmt_div" readonly/></td>
				</tr>
				<tr>
				<!-- 설비명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtDetailNm"></spring:message> : </td>
					<td><input type="text" id="eqmtMgtNm" name="eqmtMgtNm" format="text" readonly/>
					</td> 
				<!-- 정비주기 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtnc"></spring:message> : </td>
					<td><input id="eqmtMgtMtnc" name="eqmtMgtMtnc" format="currency" readonly/></td>
				</tr>
				<tr>
				<!-- 수령일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate"></spring:message> : </td>
					<td><input id="eqmtMgtPurchase" name="eqmtMgtPurchase" format="datepicker" readonly/></td>
				<!-- 검증기간 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_verifyPeriod"></spring:message>
					</td>
					<td><input id="eqmtMgtVerif" name="eqmtMgtVerif" format="datepicker" readonly/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="eqmtMgtDesc" name="eqmtMgtDesc" class="k-textbox" readonly/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="toolId" id="toolId"/>
						<input type="hidden" name="toolMgtId" id="toolMgtId"/>
						<input type="hidden" name="action" id="action"/>
					</td>
				</tr>
			</table>
		<!-- 업체관리 -->
			<div class="pop_title"><spring:message code = "pop_toolInfo"></spring:message></div>
			<div id="jtePopForm_grid" class="toolMgtForm" style="height: 340px; width: 98%; margin: auto; display: flex;" ></div>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		
	</div>
</div>

<!--  -->
<div style="display:none;">
	<div id="jtePopToolMgt">   <!-- style="height:100%" -->
		<div class="pop_title"></div>
		<div id="jtePopToolMgt_grid" class="toolMgtForm" style="height:350px;"></div>
	</div>
</div>

<div style="display:none;">
	<div id="jtePopAddTool">
		<form id="jtePopAddTool_form" class="toolMgtForm">
			<div class="pop_title"><spring:message code = "pop_eqmtInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopAddTool_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:30%;">
				<col style="width:22%;">
				<col style="width:30%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i>공구개별코드 : </td>
					<td colspan="3">
						<input type="text" id="toolMgtId" class="btn-input" name="toolMgtId" readonly/>
						<button class="k-button k-primary" type="button" onclick="lfn_jteToolMgt_popOpen()" >
							<spring:message code = "btn_search"></spring:message></button>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="action"/>
						<input type="hidden" name="eqmtMgtId" id="eqmtMgtId"/>
						<input type="hidden" name="toolId" id="toolId"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddTool');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		
	</div>
</div>

<div style="display:none;">
	<div id="toolMgtPop">
		<div id="toolMgt_grid"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/toolMgt/toolMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/operMgt/facilMgt/facilMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200410 LYM  -->

<script>
var lfo_common = {};//Form 내부에서 사용될 Object

var lfo_popGrd = {};

var lfo_toolMgtGrd = {};

var lfo_toolSearchGrd = {};


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//main - grid 생성
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/form/facilMgt/facilMountTool";

	lfo_common.crud  = {
		read:{url:"/getEqmtToolRtlList", auth:"", prmt:{}}, 
		//create:{url:"/setEqmtTool", auth:"", openFunc : lfn_jtePop_open, callback : lfn_popSave}, 
		update:{url:"/setEqmtTool", auth:"", openFunc : lfn_jtePop_open, callback : lfn_popSave}
		/* destroy:{url:"/", auth:"", callback:lfn_jteGrid_delete} */
	};

	lfo_common.model = {
			id: "eqmtMgtId",
			fields: {
				eqmtMgtId : { type: "string" },
				eqmtMgtGbn : { type: "string" },
				eqmtMgtMtnc : { type: "int" },
				eqmtMgtNm : { type: "string" },
				eqmtMgtPurchase : { type: "date" },
				eqmtMgtVerif : { type: "date" },
				eqmtMgtDesc : { type: "string" },
				eqmtMgtFile : { type: "string" },
				isUse : { type: "bool" },
				creatorId : { type: "string" },
				createdAt : { type: "string" },
				updatorId : { type: "string" },
				updatedAt : { type: "string" },
				placeId : { type: "string" },
				placeNm : { type: "string" },
				compId : { type: "string" },
				compNm : { type: "string" },
				eqmtMgtStd01: { type: "int" },
				eqmtMgtStd02: { type: "int" },
				eqmtMgtStd03: { type: "int" },
				eqmtMgtStd04: { type: "int" },
				eqmtMgtStd05: { type: "int" },
				eqmtMgtStdStr01: { type: "string" },
				eqmtMgtStdStr02: { type: "string" },
				eqmtMgtStdStr03: { type: "string" },
				eqmtMgtStdStr04: { type: "string" },
				eqmtMgtStdStr05: { type: "string" }
			}
		};

	lfo_common.columns = [
		{field: "eqmtMgtId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\', this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update"), width: "95px"},	
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: "150px"},
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtNm"), width: "170px"},
		{field: "eqmtMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(eqmtMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(eqmtMgtGbn).cdId , gfn_getCode(eqmtMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_eqmtDiv"), width: "130px;"},
		{field: "eqmtMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "120px"},
		{field: "eqmtMgtVerif" , format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: "120px"},
		{field: "eqmtMgtMtnc", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_mtnc"), width: "100px"},
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc"), width: "300px"}
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_eqmtNm"), value: "eqmtMgt.eqmt_mgt_nm" },				//설비명
		{ text: gfn_getMsg("col_eqmtIndivCd"), value: "eqmtMgt.eqmt_mgt_id" },			//설비개별코드
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


this.lfn_jtePop_open = function(mode, selectedItem){

	var options = {
			modal:true, 
			width: "800px",
			height: "715px",
			id : lfo_common.popId, 
			//title:gfn_getMsg("pop_addPop"),
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		if(mode =="NEW"){
			options.title = "설비 장착 공구"
		}else if(mode=="EDT"){
			options.title = "설비 장착 공구"
		}
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){lfn_jtePopGrd_set(mode, selectedItem);};
		this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_set = function(mode, selectedItem){
	
	lfo_common.gridSelected = {};	
	var childItems = [];
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.eqmtMgtId = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/getEqmtToolPop",
			type: "POST",
			data: {eqmtMgtId : lfo_common.gridSelected.eqmtMgtId},
			success: function(data){
				gfn_popform_set(lfo_common, mode, data.rows);
				
				//업체 정보를 담는다.
				childItems = data.rows.childToolList;
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	lfn_jtePopGrd_setGrd(childItems);
}


//Form내용 입력/저장
this.lfn_popSave = function(mode){

	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){	
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		savePrmt.childToolList = lfo_popGrd.childItems;
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfn_jtePopGrd_set('EDT', data);
				
				lfo_common.grid.dataSource.read();
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		lfo_common.ToolList = {};
	}
}

this.lfn_jtePopGrd_setGrd = function(childItems){
	$("#jtePopForm_grid").html("");
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";

	//lfo_popGrd.popId = "";

	lfo_popGrd.ctrlUrl = "/form/facilMgt/facilMountTool";

	lfo_popGrd.crud  = {
		read:{url:"", auth:"", prmt:{}}, 
		create:{url:"", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback: lfn_toolMgtGrd_save},
		update:{url:"", auth:"", openFunc: "", callback: lfn_toolMgtGrd_save},
		destroy:{url:"", auth:"", callback: lfn_jtePopGrd_delete}
	};
	
	lfo_popGrd.model = {
		id: "toolId",
		fields: {
			action : { type: "string" },
			toolId : { type: "string" },
			itemId : { type: "string"},
			toolNm : { type: "string" },
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

	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '' : '에러' #",
			title:"액션", width: "95px"},
		{field: "toolId", template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolMgtPop_open(\'EDT\', this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("col_toolCd"), width: "160px"},
		{field: "toolId", title:gfn_getMsg("col_toolCd"), width: "160px"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: "180px"},
		{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolType"), width: "110px;"},
		{field: "toolLimit", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit"), width: "110px"},
		{field: "toolDesc", title:gfn_getMsg("col_desc"), width: "200px"}
	];

	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_toolNm"), value: "tool.tool_nm" },					//업체명
		{ text: gfn_getMsg("col_toolCd"), value: "tool.tool_id" },					//업체코드
		{ text: gfn_getMsg("col_desc"), value: "tool.tool_desc" }					//비고
	];
	
	//order에 포함된 LOT 정보 담아주기(order-child)
	lfo_popGrd.childItems = childItems;
	
	//Object형 그리드 세팅 호출(order-child)
	lfo_popGrd.grid = gfn_objectDatagrid_set(lfo_popGrd);
}

this.lfn_jtePopGrd_popOpen = function(selectedItem){
	//여기부터 공통팝업 띄우기
	gfn_openCustomPop('tool',lfn_toolMgtGrd_save);
}

this.lfn_toolMgtGrd_save = function(savePrmt){

	var childItems = gfn_objectDataGrid_save({tgObj : lfo_popGrd, prmt : savePrmt, pk : "toolId", autokey : false});
	if(!childItems){
		return false;
	}
	lfo_popGrd.childItems = childItems;
	lfo_popGrd.grid.dataSource.read();
}
//삭제 콜백
this.lfn_jtePopGrd_delete = function(){
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delPrmt = lfo_popGrd.grid.dataItem($(this).closest('tr'));
			
			//데이터 object에 저장 - 부모요소 저장시 저장(삭제)된다.
			gfn_objectDataGrid_delete({tgObj : lfo_popGrd, prmt : delPrmt, pk : "toolId"});
		}
	});
	
	//그리드 리로드
	lfo_popGrd.grid.dataSource.read();
}


//정비이력 버튼 클릭(팝업 오픈)
this.lfn_toolMgtPop_open = function(mode, target){
	var options = {
		modal:true, 
		width: "840px", 
		height: "380px", //200519 JJW 400-> 390
		id : "jtePopToolMgt", 
		title: "뭘까",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_popGrd.grid.dataItem($(target).closest("tr"));
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteEqmtMtnc_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}

//정비이력 그리드 세팅
this.lfn_jteEqmtMtnc_setGrd = function(dataItem){
	lfo_toolMgtGrd = {};

	lfo_toolMgtGrd.layoutId = "jtePopToolMgt_grid";

	lfo_toolMgtGrd.popId = "jtePopAddTool";

	lfo_toolMgtGrd.ctrlUrl = "/form/facilMgt/facilMountTool";

	lfo_toolMgtGrd.crud  = {
		read:{url:"/getToolEqipList", prmt:{toolId : dataItem.toolId, eqmtMgtId : lfo_common.gridSelected.eqmtMgtId}, search:false}, 
		create:{url:"/setToolMgtRtl", openFunc : lfn_toolIndivPop_open, callback : lfn_toolIndivPopSave}, 
		update:{url:"/setToolMgtRtl", openFunc : lfn_toolIndivPop_open, callback : lfn_toolIndivPopSave}, 
		destroy:{url:"/delUpdateTool", auth:"", callback : lfn_toolIndivPop_delete}
	};

	lfo_toolMgtGrd.model = {
		id: "toolMgtId",
		fields: {
			toolMgtId : { type: "string" },
			toolId : { type: "string" },
			toolNm : { type: "string" },
			eqmtMgtId : { type: "string" },
			toolMgtLimit : { type: "int" },
			toolMgtUse : { type: "int"}
		}
	};

	lfo_toolMgtGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMgtId", title:gfn_getMsg("col_toolIndivCd"), width: "170px"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: "150px"},
		{field: "toolMgtLimit", format:"{0:n0}", title:gfn_getMsg("col_useLimit"), width: "120px"},
		{field: "toolMgtUse", format:"{0:n0}", title:gfn_getMsg("col_toolUse"), width: "120px"}
		
	];
	

	//공통 그리드 세팅 호출 
	lfo_toolMgtGrd.grid = gfn_grid_set(lfo_toolMgtGrd);
}
//정비이력 등록/수정 팝업 호출
this.lfn_toolIndivPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px",
		height: "385px",
		id: lfo_toolMgtGrd.popId,
		//title: "개별공구 등록",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	if(mode =="NEW"){
		options.title = "개별공구 등록"
		selectedItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		if($("#jtePopToolMgt_grid").data("kendoGrid").dataSource.total() == 1){
			gfn_warnBox({msg:"개별공구등록은 한개만 가능합니다"});			//수동입력된 데이터만 변경하실 수 있습니다.
			return false;
		}
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_eqmtMtncPop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//정비이력 등록/수정 팝업 내용 세팅
this.lfn_eqmtMtncPop_set = function(mode,selectedItem){
	lfo_toolMgtGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			toolId : lfo_popGrd.childItems.toolId
		}
		gfn_popform_set(lfo_toolMgtGrd, mode, selectedItem);
		console.log(lfo_popGrd.childItems);
		console.log(childToolList);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_toolMgtGrd.gridSelected = lfo_toolMgtGrd.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_toolMgtGrd.gridSelected = selectedItem;
		}
		$.ajax({
			async:false,
			url : lfo_toolMgtGrd.ctrlUrl + lfo_toolMgtGrd.crud.read.url,
			type: "POST",
			data: {toolId : lfo_toolMgtGrd.gridSelected.toolId},
			success: function(data){
				gfn_popform_set(lfo_toolMgtGrd, mode,data.rows);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_toolIndivPopSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_toolMgtGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = gfn_serializeObject(lfo_toolMgtGrd.popId+"_form");
		savePrmt.eqmtMgtId = $("#eqmtMgtId").val();
		console.log(savePrmt);
		$.ajax({
			async:false,
			url : lfo_toolMgtGrd.ctrlUrl + lfo_toolMgtGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					
					//lfn_jtePop_set('EDT',data);
					//설비 정비이력 그리드 리로드
					lfo_toolMgtGrd.grid.dataSource.read();
					//설비상세 그리드 리로드
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_toolMgtGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//삭제 콜백
this.lfn_toolIndivPop_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_toolMgtGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_toolMgtGrd.grid.dataItem($(this).closest('tr')));
		}
	}); 
	
	$.ajax({
		async:false,
		url : lfo_toolMgtGrd.ctrlUrl + lfo_toolMgtGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){

			lfo_toolMgtGrd.grid.dataSource.read();

			//lfo_popGrd.grid.dataSource.read();

			//lfo_common.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
} 
this.lfn_jteToolMgt_popOpen = function(mode, target){
	var options = {
		modal:true, 
		width: "1250px", 
		height: "470px",
		id:"toolMgtPop", 
		title:"공구 상세정보",	
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:["Close"]
	};
	
	var dataItem = lfo_toolMgtGrd.grid.dataItem($(target).closest("tr"));
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		$("#toolMgt_grid").empty();
		
		lfn_jteToolMgtGrd_setGrd(dataItem);
		$('#toolMgt_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}


this.lfn_jteToolMgtGrd_setGrd = function(dataItem){
	lfo_toolSearchGrd = {};
	
	lfo_toolSearchGrd.layoutId = "toolMgt_grid";
	
	lfo_toolSearchGrd.ctrlUrl = "/form/facilMgt/facilMountTool";

	lfo_toolSearchGrd.crud  = {
		read:{url:"/getToolMgtMountList", auth:"", prmt:{toolId : lfo_popGrd.childItems.toolId}} 
	};

	lfo_toolSearchGrd.model = {
		id: "toolMgtId",
		fields: {
			toolMgtId : { type: "string" },
			toolMgtPurchase : { type: "date" },
			toolMgtState : { type: "string" },
			toolMgtLimit : { type: "int" },
			toolMgtUse : { type: "int" },
			toolMgtVerif : { type: "date" },
			toolMgtGbn : { type: "string" },
			toolMgtDesc : { type: "string" },
			creatorId : { type: "string" },
			createdAt : { type: "date" },
			updatorId : { type: "string" },
			updatedAt : { type: "date" },
			compId : { type: "string" },
			compNm : { type: "string" },
			isDel : {type:"bool"},

			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolType : { type: "string" },
			toolPrice : { type: "int" },
			toolLimit : { type: "int" },
			toolDesc : { type: "string" },
			isUse : { type: "bool" }
		}
	};

	lfo_toolSearchGrd.columns = [
		{field: "toolMgtId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlPop_callback(this);" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
		title:gfn_getMsg("btn_update"), width: 90},	
		{field: "toolMgtId", title:gfn_getMsg("col_toolIndivCd"), width: "160px"},											//공구개별코드
		{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: "140px"},													//공구명
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolStatus"), width: "160px"},															//공구상태
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolDiv"), width: "140px"},																//공구구분
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "160px"},													//업체명
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "120px"},			//등록일
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: "120px"},			//검증기간
		{field: "toolMgtUse", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_toolUse"), width: "120px"},							//사용량
		{field: "toolMgtLimit", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit"), width: "120px"},							//사용제한
		{field: "toolMgtDesc", title:gfn_getMsg("col_desc"), width: "250px"}												//설명
	];

	lfo_toolSearchGrd.selectBox = [
		{ text: gfn_getMsg("col_toolNm"), value: "toolInfo.tool_nm" },					//공구명
		{ text: gfn_getMsg("col_toolIndivCd"), value: "toolMgt.tool_mgt_id" }			//공구개별코드
		
	];
	
	//공통 그리드 세팅 호출 
	lfo_toolSearchGrd.grid = gfn_grid_set(lfo_toolSearchGrd);
}

//콜백
this.lfn_mtrlPop_callback = function(selectedItems){
	
	var selectedItem = lfo_toolSearchGrd.grid.dataItem($(selectedItems).closest('tr'));
	
	$("#"+ lfo_toolMgtGrd.popId + "_form [name='toolMgtId']").val(selectedItem.toolMgtId);
	$("#"+ lfo_toolMgtGrd.popId + "_form [name='toolNm']").val(selectedItem.toolNm);
	$("#"+ lfo_toolMgtGrd.popId + "_form [name='toolId']").val(selectedItem.toolId);
	
	gfn_closePop("toolMgtPop");

}

</script>