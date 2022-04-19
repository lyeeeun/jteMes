<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 마스터 그리드 영역 -->
<div style="width:100%;">
	<div class="infergodsMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<input class="radio-btn" type="radio" name="target" value="mtrl" checked><span class="radio-span">자재</span>
		<input class="radio-btn" type="radio" name="target" value="item"><span class="radio-span">부품</span>
	</div>
	<div id="grid-content" class="infergodsMgtForm"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="infergodsMgtForm">
			<div class="pop_title"><spring:message code = "pop_badItemInfo" text = "불량정보" /></div>
			<table id="jtePopForm_master"> <!-- style="width:100%;" -->
			<colgroup>
				<col class="col-left-title"> <!-- style="width:23%;" -->
				<col class="col-left-content"> <!-- style="width:27%;" -->
				<col class="col-right-title"> <!-- style="width:23%;" -->
				<col class="col-right-content"> <!-- style="width:27%;" -->
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i>불량 발생 Lot :</td>
					<td colspan="2">
						<input type="text" id="lotId" class="left-input btn-input" name="lotId" format="text">
						<input type="hidden" id="lotSeq" name="lotSeq">
						<input type="hidden" id="lotState" name="lotState">
						<input type="hidden" id="itemId" name="itemId">
						<input type="hidden" id="badId" name="badId">
					</td>
					<td><button class="k-button k-primary search-btn" type="button" onclick="lfn_lotInfo()">불량 발생 부품 선택</button></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>부품 명 :</td>
					<td><input type="text" id="itemNm" class="left-input" name="itemNm" format="text"></td>
					<td><i class="fas fa-caret-right left-caret"></i>불량 수 :</td>
					<td><input type="text" id="badQty" class="right-input" name="badQty" format="numeric"></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>불량 원인 :</td>
					<td colspan="3">
						<input type="text" id="badCode" class="center-input" name="badCode" format="selBox" msg="qual_ITEMCUT"/> <!-- style="width:98%" -->
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명" /> : </td><td colspan="3"><input type="text" id="badDesc" class="center-input" name="badDesc" format="text"/></td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소" /></button>
			</div>
		</form>
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
	lfo_common.ctrlUrl = "/form/qualMgt/infergodsMgt"
	
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


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "705px", 
		height: "350px",
		id:lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_badItemRegist", "불량정보 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_badItemSrh", "불량정보 수정");
		
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem) {
	lfo_common.gridSelected = "";
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode, selectedItem);
	}else if(mode == 'EDT'){
		gfn_popform_set(lfo_common, mode, lfo_common.grid.dataItem($(selectedItem).closest('tr')));
	}
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//입력폼 serialize 
	var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
	
	//저장된 다국어가 있다면 추가
	var msgId = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
	var msgList = $("#msg_"+ msgId).val();
	if(!gfn_isNull(msgList)){
		savePrmt.msgList = JSON.parse(msgList);
	}
	if(mode == 'update') {
		savePrmt.action = 'U';
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
			gfn_closePop('jtePopForm');
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
			
			lfo_common.grid.dataSource.read();
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//삭제 콜백
this.lfn_jteGrid_delete = function(){
	var delPrmt = [];

	var flag = true;
	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_common.grid.dataItem($(this).closest('tr')));
			if(lfo_common.grid.dataItem($(this).closest('tr')).badTargetCode != "ADMIN") {
				kendo.confirm("관리자가 입력한 항목만 삭제가 가능합니다.");
				flag = false;
				return flag;
			}
		}
	});
	
	if(!flag) {
		return flag
	}
	
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
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}


//사용유무
this.lfn_jteSgGrd_changeIsUse = function(rows){
	
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {toolId : dataItem.toolId, action : "USE", use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.update.url,
		type: "POST",
		data: JSON.stringify(prmt),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				lfo_common.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}



//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	//lfo_popGrd.popId = "";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/basMgt/operMgt/toolMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlRtlCompList", auth:"", prmt:{toolId:lfo_common.gridSelected}}, 
		create:{url:"/setMtrlRtlCompSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"", auth:"", openFunc:"", callback:""},
		destroy:{url:"/setMtrlRtlCompDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "compId",
		fields: {
			compId: { type: "string" },
			toolId: { type: "string" },
			compNm: { type: "string" },
			compManagr: { type: "string" },
			compNumber: { type: "string" },
			compType: { type: "string" },
			compAddr: { type: "string" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			isUse: { type: "bool" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "compId", title:gfn_getMsg("col_compCd", "업체코드"), width: 120},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: 150},
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_compCd", "업체코드"), value: "comp.comp_id" },
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "comp.comp_nm" },
	];
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(selectedItem){

	//여기부터 공통팝업 띄우기
	gfn_openCustomPop('supplier',lfn_jtePopGrd_save);
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(savePrmt){
	
	savePrmt.toolId = lfo_common.gridSelected;
	
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.create.url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//마스터 그리드 리로드
				lfo_common.grid.dataSource.read();
				//이전 팝업화면 리로드
				lfn_jtePop_set('EDT',lfo_common.gridSelected);
				
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

//삭제 콜백
this.lfn_jtePopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_popGrd.grid.dataItem($(this).closest('tr')));
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
			lfo_popGrd.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

this.lfn_lotInfo = function() {
	var callback = function(selectedItem){
		$('#lotId').val(selectedItem.lotId);
		$('#lotSeq').val(selectedItem.lotSeq);
		$('#lotState').val(selectedItem.lotState);
		$('#itemId').val(selectedItem.itemId);
		$('#itemNm').val(selectedItem.itemNm);
	}
	
	gfn_openCustomPop('lotInfo', callback);
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
	lfo_popGrd.ctrlUrl = "/form/qualMgt/infergodsMgt";
	
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