<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content"  style="width:100%;">
	<div id="jteSingleGrid" style="width:100%;"></div>
</div>
<!-- 정비이력 POP -->
<div style="display:none;">
	<div id="jtePopEqmtMtnc" style="height:100%">
		<div class="pop_title"><spring:message code = "pop_mtncHis" text = "정비이력" /></div>
		<div id="jtePopEqmtMtnc_grid" style="height:350px;"></div>
	</div>
</div>
<!-- 정비이력 등록/수정 팝업(서브 그리드 > 정비이력 버튼 클릭) -->
<div style="display:none;">
	<div id="jtePopEqmtAdd" class="facilCorMgtForm">
		<form id="jtePopEqmtAdd_form" class="facilCorMgtForm">
			<div class="pop_title"><spring:message code = "pop_mtncList" text = "정비내역" /></div>
			<table id="jtePopEqmtAdd_master" class="jtePopEqmtAdd_master BasicTable">
			<colgroup>
				<col style="width:20%;">
				<col style="width:30%;">
				<col style="width:24%;">
				<col style="width:26%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtMtnc" text = "설비정비코드" /> : </td>
					<td colspan="3"><input type="text" id="eqmtMtncId" name="eqmtMtncId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly /></td>			<!-- 자동입력 -->
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtncStartDate" text = "정비시작일" /> : </td>
					<td><input id="eqmtMtncStart" name="eqmtMtncStart" format="datepicker" /></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_mtncEndDate" text = "정비종료일" /> 
						<i class="fas fa-info-circle" title="<spring:message code = "pop_periodAutoChange" text = "최초 등록시 검증기간이 자동 변경됩니다. (종료일 + 정비주기) " />" ></i>  : </td>   <!-- style="background:yellow;" -->
					<td><input id="eqmtMtncEnd" name="eqmtMtncEnd" format="datepicker" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager" text = "관리자" /> : </td>
					<td>
						<input type="text" id="eqmtMtncUserNm" class="btn-input" name="eqmtMtncUserNm" readonly />
						<input type="hidden" id="eqmtMtncUser" name="eqmtMtncUser" />
						<button class="k-button k-primary" type="button" onclick="gfn_openCustomPop('userInfo',lfn_userPop_callback);" >
						<spring:message code = "btn_search" text = "조회" /></button>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_cost" text = "금액" /> : </td>
					<td>
						<input id="eqmtMtncCost" name="eqmtMtncCost" format="currency" />
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_attachment" text = "첨부파일" /> : </td>
					<td colspan="3">
						<input name="attachFile" id="attachFiles" type="file" aria-label="files" format="file" code="eqmtMtncId" />
						<input type="hidden" id="insertAttach" value = "[]"/>
						<input type="hidden" id="deleteAttach" value = "[]"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명" /> : </td>
					<td colspan="3">
						<input type="text" id="eqmtMtncDesc" name="eqmtMtncDesc" class="k-textbox" />
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="eqmtId" id="parentEqmtId"/>
						<input type="hidden" name="eqmtMgtId" id="parentEqmtMgtId"/>
						<input type="hidden" name="eqmtMaintenance" id="parentEqmtMaintenance"/>
						<input type="hidden" name="use" id="eqmtMtncUse"/>
						<input type="hidden" name="action" id="eqmtMtncAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopEqmtAdd');"><spring:message code = "pop_cancel" text = "취소" /></button>
			</div>
		</form>
	</div>
</div>

<link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_eqmtMtncGrd = {};//정비이력 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//서브 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/operMgt/facilMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getEqmtMgtList", auth:"", prmt:{}}, 
	};
	
	//5.
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
			compNm : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		
		{ field: "eqmtMgtId", title: gfn_getMsg("col_history", "이력"), width: "80px",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_eqmtMtncPop(this) " style="">'+gfn_getMsg("pop_mtncHis", "정비이력")+'</button>'
		},
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm", "설비명"), width: "130px"},
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd", "설비개별코드"), width: "160px"},
		{field: "eqmtMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(eqmtMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(eqmtMgtGbn).cdId , gfn_getCode(eqmtMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_eqmtDiv", "설비구분"), width: "130px;"},
		{field: "eqmtMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate", "입고일"), width: "110px"},
		{field: "eqmtMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod", "검증기간"), width: "110px"},
		{field: "eqmtMgtMtnc", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_mtnc", "정비주기"), width: "110px"},
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc", "설명"), width: "280px"}
	];
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_eqmtDetailNm", "설비명"), value: "eqmtMgt.eqmt_mgt_nm" },
		{ text: gfn_getMsg("col_eqmtIndivCd", "설비개별코드"), value: "eqmtMgt.eqmt_mgt_id" },
		{ text: gfn_getMsg("col_placeNm", "위치명"), value: "place.place_nm" },
		{ text: gfn_getMsg("col_desc", "설명"), value: "eqmtMgt.eqmt_mgt_desc" }
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//정비이력 버튼 클릭(팝업 오픈)
this.lfn_eqmtMtncPop = function(target){
	var options = {
		modal:true, 
		width: "800px", 
		height: "390px", //200519 JJW 400-> 390
		id : "jtePopEqmtMtnc", 
		title:gfn_getMsg("pop_eqmtMtncHis"),			//설비 정비이력
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	
	//선택한 항목의 ID 가져옴
	lfo_common.gridSelected = { 
			eqmtId : dataItem.eqmtId, 
			eqmtMgtId:dataItem.eqmtMgtId, 
			eqmtMaintenance : dataItem.eqmtMaintenance,
			use : dataItem.use
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteEqmtMtnc_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}

//정비이력 그리드 세팅
this.lfn_jteEqmtMtnc_setGrd = function(dataItem){
	lfo_eqmtMtncGrd = {};//Form 내부에서 사용될 Object

	
	//1.
	lfo_eqmtMtncGrd.layoutId = "jtePopEqmtMtnc_grid";
	
	//2.
	lfo_eqmtMtncGrd.popId = "jtePopEqmtAdd";
	
	//3.
	lfo_eqmtMtncGrd.ctrlUrl = "/form/facilMgt/facilCorMgt";
	
	//4.
	lfo_eqmtMtncGrd.crud  = {
		read:{url:"/getEqmtMtncList", auth:"", prmt:{eqmtMgtId : dataItem.eqmtMgtId}}, 
		create:{url:"/setEqmtMtncSave", auth:"", openFunc : lfn_eqmtMtncPop_open, callback : lfn_eqmtMtncPopSave}, 
		update:{url:"/setEqmtMtncSave", auth:"", openFunc :"" , callback : lfn_eqmtMtncPopSave}, 
		destroy:{url:"/setEqmtMtncDelete", auth:"", callback : lfn_eqmtMtncPopDelete}
	};
	
	//5.
	lfo_eqmtMtncGrd.model = {
		id: "eqmtMtncId",
		fields: {
			eqmtMtncId : { type: "string" },
			eqmtMtncStart : { type: "date" },
			eqmtMtncEnd : { type: "date" },
			eqmtMtncUser : { type: "string" },
			eqmtMtncCost : { type: "int" },
			eqmtMtncDesc : { type: "string" },
			creatorId	 : { type: "string" },
			createdAt : { type: "date" },
			updatorId : { type: "string" },
			updatedAt : { type: "date" },
			eqmtMgtId : { type: "string" },
			eqmtMtncUserNm : {type: "string"}
		}
	};
	
	//6.
	lfo_eqmtMtncGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "eqmtMtncId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_eqmtMtncPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("btn_search", "조회") , width: "90px"},
		{field: "eqmtMtncId", title:gfn_getMsg("col_eqmtMtnc", "설비정비코드"), width: "170px"},
		{field: "eqmtMtncStart", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncStartDate", "정비시작일"), width: "120px"},
		{field: "eqmtMtncEnd", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncEndDate", "정비종료일"), width: "120px"},
		{field: "eqmtMtncCost", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost", "금액"), width: "100px"},
		{field: "eqmtMtncUserNm", title:gfn_getMsg("col_manager", "관리자"), width: "130px"},
		{field: "eqmtMtncDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];
	//7.
	lfo_eqmtMtncGrd.selectBox = [
		{ text: gfn_getMsg("col_manager", "관리자"), value: "urInfo.user_nm" }, 
		{ text: gfn_getMsg("col_eqmtMtnc", "설비정비코드"), value: "eqmtMtnc.eqmt_mtnc_id" },
		{ text: gfn_getMsg("col_desc", "설명"), value: "eqmtMtnc.eqmt_mtnc_desc" }
	];
	
	//8.
	lfo_eqmtMtncGrd.validation ={
		eqmtMtncStart:{
			messages : "정비시작일을 등록하세요",
			rules : function(input){
				if(input.is("[name=eqmtMtncStart]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		eqmtMtncEnd:{
			messages : "정비종료일을 등록하세요",
			rules : function(input){
				if(input.is("[name=eqmtMtncEnd]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		eqmtMtncUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=eqmtMtncUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 담당자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	
	//공통 그리드 세팅 호출 
	lfo_eqmtMtncGrd.grid = gfn_grid_set(lfo_eqmtMtncGrd);
}
//정비이력 등록/수정 팝업 호출
this.lfn_eqmtMtncPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px",
		height: "385px",
		id:lfo_eqmtMtncGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtncRegist", "정비내역 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtncListSrh", "정비내역 조회");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_eqmtMtncPop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//정비이력 등록/수정 팝업 내용 세팅
this.lfn_eqmtMtncPop_set = function(mode,selectedItem){
	var gridSelected = "";
	if(mode=='NEW'){
		gridSelected = {
				eqmtMgtId : lfo_common.gridSelected.eqmtMgtId
			};
	}else if(mode == 'EDT'){
		gridSelected = lfo_eqmtMtncGrd.grid.dataItem($(selectedItem).closest("tr"));
		gridSelected.eqmtMgtId = lfo_eqmtMtncGrd.eqmtMgtId;
	}
	gfn_popform_set(lfo_eqmtMtncGrd, mode, gridSelected);
}

//유저정보 팝업 콜백
this.lfn_userPop_callback = function(callbackObj){
	$("[name='eqmtMtncUser']").val(callbackObj.userId);
	$("[name='eqmtMtncUserNm']").val(callbackObj.userNm);
}

//Form내용 입력/저장
this.lfn_eqmtMtncPopSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_eqmtMtncGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = gfn_serializeObject(lfo_eqmtMtncGrd.popId+"_form");

		$.ajax({
			async:false,
			url : lfo_eqmtMtncGrd.ctrlUrl + lfo_eqmtMtncGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//설비 정비이력 그리드 리로드
					lfo_eqmtMtncGrd.grid.dataSource.read();
					//설비상세 그리드 리로드
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_eqmtMtncGrd.popId);
					
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
//삭제 콜백
this.lfn_eqmtMtncPopDelete = function(){
	var delPrmt = [];
	$("#"+ lfo_eqmtMtncGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_eqmtMtncGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_eqmtMtncGrd.ctrlUrl + lfo_eqmtMtncGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			//설비정비코드 삭제 후 리로드
			lfo_eqmtMtncGrd.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

</script>