<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="offerMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="offerMgtForm"></div>
</div>


<div style="display:none;">
	<div id="jteOfferForm" style="height:100%">
		<div class="pop_title"><spring:message code = "col_offerInfo" text = "견적서정보" /></div>
		<div id="jteOfferForm_grid" class="offerMgtForm"  style="height:330px;"></div>
	</div>
</div>

<div style="display:none;">
	<div id="jtePopOfferForm">
		<form id="jtePopOfferForm_form" class="offerMgtForm">
		<div class="pop_title"><spring:message code = "col_offerInfo" text = "견적서정보" /></div>
			<table style="width:100%;" id="jtePopOfferForm_master" class="BasicTable">
			<colgroup>
				<col style="width:16%;">
				<col style="width:34%;">
				<col style="width:16%;">
				<col style="width:34%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_offerNm" text = "견적서명" /> : </td>
					<td colspan="3"><input type="text" id="offerNm" name="offerNm"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_descr" text = "비고"/> : </td>
					<td colspan="3"><input type="text" id="offerDesc" name="offerDesc"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_attachment" text = "첨부파일" /> : </td>
					<td colspan="3">
						<input name="attachFile" type="file" format="file" code="offerId" />
						<input type="hidden" id="insertAttach" value = "[]"/>
						<input type="hidden" id="deleteAttach" value = "[]"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="offerAction"/>
						<input type="hidden" name="compId" id="compId"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="offerMgtForm final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopOfferForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
		</div>
	</div>
</div>

<!-- <link href='/resources/mes/css/contents/orderMgt/offerMgt/offerMgtForm_JJW.css' rel="stylesheet"> -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_offerPopGrd = {};//서브그리드에서 사용될 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/compMgt"

	lfo_common.crud  = {
		read:{url:"/getCompList", auth:"", prmt:{}}, 
	};

	lfo_common.model = {
		id: "compId",
		fields: {
			compId: { type: "string" },
			compNm: { type: "string" },
			compInitials: { type: "string" },
			compManagr: { type: "string" },
			compNumber: { type: "string" },
			compType: { type: "string" },
			compAddr: { type: "string" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			description: { type: "string" },
			isUse: { type: "bool" },
			compStd01: { type: "int" },
			compStd02: { type: "int" },
			compStd03: { type: "int" },
			compStd04: { type: "int" },
			compStd05: { type: "int" },
			compStdStr01: { type: "string" },
			compStdStr02: { type: "string" },
			compStdStr03: { type: "string" },
			compStdStr04: { type: "string" },
			compStdStr05: { type: "string" },
			compNumber: { type: "string" }
		}
	};

	lfo_common.columns = [
		{selectable : true, width:"40px"},
		{field: "compId", title:gfn_getMsg("btn_update", "수정"), width: "90px",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_offerPop(this); " style="">' + "<spring:message code = "pop_view" />" + '</button>'
		},
		{field: "compStdStr02", title:gfn_getMsg("col_accountNum", "거래처코드"), width:"130px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "220px"},
		{field: "compType", template:"# var item = gfn_isNull(gfn_getCode(compType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(compType).cdId , gfn_getCode(compType).cdNm) # #= item #", 
			title:gfn_getMsg("col_compType", "업체유형"), width: "120px;"},
		{field: "compNumber", title:gfn_getMsg("col_compNum", "업체번호"), width: "130px"},
		{field: "description", title:gfn_getMsg("col_desc", "비고"), width: "350px"}
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_accountNum", "거래처코드"), value: "compInfo.comp_std_str02"},
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_compCd", "업체코드"), value: "compInfo.comp_id" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
//더블클릭 콜백(팝업)
this.lfn_offerPop = function(target){
	var options = {
		modal:true, 
		width: "910px",
		height: "400px",
		id: "jteOfferForm",
		title: gfn_getMsg("pop_offerInfo", "견적서정보"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	
	lfo_common.gridSelected = {
		compId : dataItem.compId
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteOfferGrd_setGrd(dataItem);
	};
	
	this.gfn_winOpen(options);
}

//팝업내부 그리드 
this.lfn_jteOfferGrd_setGrd = function(dataItem){
	lfo_offerPopGrd = {};

	lfo_offerPopGrd.layoutId = "jteOfferForm_grid";

	lfo_offerPopGrd.popId = "jtePopOfferForm";

	lfo_offerPopGrd.ctrlUrl = "/cform/orderMgt/offerMgt" ;

	lfo_offerPopGrd.crud  = {
		read:{url:"/getOfferList", auth:"", prmt:{compId : dataItem.compId},search :false},
		create:{url:"/setOfferSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"/setOfferSave", auth:"", openFun: "" ,callback:lfn_jtePopGrd_save},
		destroy : {url:"/setOfferDelete", auth: "" , callback:lfn_offerPopGrd_delete}
	};

	lfo_offerPopGrd.model = {
			id: "offerId",
			fields: {
				offerId : { type : "string" },
				offerNm : { type : "string" },
				offerFile : { type : "string" },
				offerDesc : { type : "string" },
				creatorId : { type : "string" },
				createdAt : { type : "string" },
				updatorId : { type : "string" },
				updatedAt : { type : "string" },
				compId : { type : "string" }
			}
		};
	
	lfo_offerPopGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "offerId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this)" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "100px;"},
		{field: "offerNm", title:gfn_getMsg("col_offerNm", "견적서명"), width: "180px;"},
		{field: "createdAt", title:gfn_getMsg("col_createdAt", "견적서 작성날짜"), width:"180px;"},
		{field: "offerDesc", title:gfn_getMsg("col_descr", "비고"), width: "250px;"}
	];
	
	lfo_offerPopGrd.selectBox = [
	
	];
	
	//공통 그리드 세팅 호출
	lfo_offerPopGrd.grid = gfn_grid_set(lfo_offerPopGrd);

}

//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	
	var options = {
		modal:true, 
		width: "770px", 
		height: "435px",
		id: lfo_offerPopGrd.popId, 
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"],
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_offerRegist", "견적서 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_offerSrh", "견적서 수정");
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePopGrd_popSet(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_popSet = function(mode, selectedItem){
	
	lfo_offerPopGrd.gridSelected = {};
	
	if(mode=='NEW'){
		selectedItem = {
			compId : lfo_common.gridSelected.compId
		}
		gfn_popform_set(lfo_offerPopGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_offerPopGrd.gridSelected = lfo_offerPopGrd.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_offerPopGrd.gridSelected = {offerId : selectedItem};
		}
		
		$.ajax({
			async:false,
			url : lfo_offerPopGrd.ctrlUrl + lfo_offerPopGrd.crud.read.url,
			type: "POST",
			data: {offerId :lfo_offerPopGrd.gridSelected.offerId},
			success: function(data){
				gfn_popform_set(lfo_offerPopGrd, mode,data.rows[0]);
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(mode){
	
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_offerPopGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		var formId = lfo_offerPopGrd.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);
		
		savePrmt.compId = $("#compId").val();
		$.ajax({
			async:false,
			url : lfo_offerPopGrd.ctrlUrl + lfo_offerPopGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != "") {
					//마스터 그리드 리로드
					lfo_offerPopGrd.grid.dataSource.read();
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_offerPopGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", gfn_getMsg("pop_successSave"))});
				} else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", gfn_getMsg("pop_failedCheck"))});
				} 
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});
			}
		});
	}
}

//삭제 콜백
this.lfn_offerPopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_offerPopGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_offerPopGrd.grid.dataItem($(this).closest('tr')));
		}
	});

	$.ajax({
		async:false,
		url : lfo_offerPopGrd.ctrlUrl + lfo_offerPopGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_offerPopGrd.grid.dataSource.read();
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});
		}
	});
}
</script>