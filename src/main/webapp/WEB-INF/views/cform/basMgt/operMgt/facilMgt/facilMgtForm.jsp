<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="facilMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="facilMgtForm"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="facilMgtForm" enctype="multipart/form-data">
			<div class="pop_title"><spring:message code = "pop_eqmtInfo" text = "설비정보"/></div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:30%;">
				<col style="width:22%;">
				<col style="width:30%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtCd" text = "설비코드"/> : </td>
					<td><input type="text" id="eqmtMgtId" name="eqmtMgtId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력"/>" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtDiv" text = "설비구분"/> : </td>
					<td><input id="eqmtGbn" name="eqmtMgtGbn"  format = "selBox" msg="eqmt_div"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtDetailNm" text = "설비명"/> : </td>
					<td><input type="text" id="eqmtMgtNm" name="eqmtMgtNm" format="text"/>
					</td> 
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtnc" text ="정비주기"/> : </td>
					<td><input id="eqmtMgtMtnc" name="eqmtMgtMtnc" format="currency" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate" text = "수령일"/> : </td>
					<td><input id="eqmtMgtPurchase" name="eqmtMgtPurchase" format="datepicker"  /></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_verifyPeriod" text = "검증기간"/>
					<i class="fas fa-info-circle jte-tooltip" title="<spring:message code = "pop_noValEnter" text = "값을 입력하지 않으면 등록된 정비주기로 계산됩니다."/>"></i> :
					</td>
					<td><input id="eqmtMgtVerif" name="eqmtMgtVerif" format="datepicker"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_attachment" text = "첨부파일"/> : </td>
					<td colspan="3">
						<input name="attachFile" type="file" format="file" code="eqmtMgtId" />
						<input type="hidden" id="insertAttach" value = "[]"/>
						<input type="hidden" id="deleteAttach" value = "[]"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "비고"/> : </td>
					<td colspan="3"><input type="text" id="eqmtMgtDesc" name="eqmtMgtDesc" class="k-textbox"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="action"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area facilMgtForm-final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"></spring:message></button>
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"></spring:message></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소"></spring:message></button>
			</div>
		</form>
	</div>
</div>

<link href='/resources/mes/css/contents/basMgt/operMgt/facilMgt/facilMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200428 LYM  -->

<script>
var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/facilMgt"

	lfo_common.crud  = {
		read:{url:"/getEqmtMgtList", auth:"", prmt:{}}, 
		create:{url:"/setEqmtMgtSave", auth:"", openFunc : lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setEqmtMgtSave", auth:"", openFunc:"", callback:lfn_popSave}, 
		destroy:{url:"/setEqmtMgtDelete", auth:"", callback:lfn_jteGrid_delete}
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
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "compAddr",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\', this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},	
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd", "설비코드"), width: "150px"},	
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtNm", "설비명"), width: "170px"},
		{field: "eqmtMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(eqmtMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(eqmtMgtGbn).cdId , gfn_getCode(eqmtMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_eqmtDiv", "설비구분"), width: "130px;"},	
		{field: "eqmtMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate", "입고일"), width: "120px"},
		{field: "eqmtMgtVerif" , format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod", "검증기간"), width: "120px"},
		{field: "eqmtMgtMtnc", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_mtnc", "정비주기"), width: "100px"},
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc", "비고"), width: "300px"},	
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse", "사용유무"), width:"100px",
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic", "기본")+" : Y";	
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_eqmtNm", "설비명"), value: "eqmtMgt.eqmt_mgt_nm" },
		{ text: gfn_getMsg("col_eqmtIndivCd", "설비코드"), value: "eqmtMgt.eqmt_mgt_id" }
	];
	
	//8.
	lfo_common.validation ={
		eqmtMgtNm:{
			messages : "설비명을 입력하세요",
			rules : function(input){
				if(input.is("[name=eqmtMgtNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		eqmtMgtPurchase:{
			messages : "수령일을 입력하세요",
			rules : function(input){
				if(input.is("[name=eqmtMgtPurchase]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		}
	}
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "760px",
		height: "485px",
		id : lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]  
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_eqmtRegist", "설비 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_eqmtUpdate", "설비 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {eqmtMgtId : selectedItem};
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {eqmtMgtId :lfo_common.gridSelected.eqmtMgtId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		var formId = lfo_common.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
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
				if(data != ""){
					gfn_closePop(lfo_common.popId);
					//lfn_jtePop_set('EDT',data);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});	
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}
//사용유무
this.lfn_jteSubGrd_changeIsUse = function(rows){
	
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {eqmtMgtId : dataItem.eqmtMgtId, action : "USE", use : dataItem.use};
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
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}
//삭제 콜백
this.lfn_jteGrid_delete = function(){
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
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}
</script>
