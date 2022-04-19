<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="claimMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="claimMgtForm"></div>
</div>

<div style="display:none;">
	<div id="jtePopAddForm">
		<form id="jtePopAddForm_form" class="claimMgtForm">
			<div class="pop_title"><spring:message code = "pop_claimInfo" text = "클레임정보"/></div>
			<table style="width:100%;" id="jtePopAddForm_master" class="BasicTable">
			<colgroup>
				<col style="width:16%;">
				<col style="width:34%;">
				<col style="width:16%;">
				<col style="width:34%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimNm" text = "클레임명"/> : </td>
					<td colspan="3"><input type="text" id="claimNm" name="claimNm"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimQty" text = "클레임수량"/> : </td>
					<td><input id="claimQty" name="claimQty" format="currency"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_compNm" text = "업체명"/> :  </td>
					<td>
						<input type="text" id="compNm" class="right-input btn-input" name="compNm" format="text" readonly/> 
						<input type="hidden" id="compId" class="right-input btn-input" name="compId"/>
						<button class="k-button k-primary search-btn" type="button" id="claim_search_btn" onclick="lfn_companyPop_Open()">
						<spring:message code="btn_search" text = "조회"/></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimCause" text = "발생원인"/> : </td>
					<td colspan="3"><input type="text" id="claimCause" name="claimCause"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="orderId" id="claimOrderId"/>
						<input type="hidden" name="action" id="claimAction"/>
						<input type="hidden" name="claimId" id="claimId"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="claimMgtForm final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/orderMgt/claimMgt/claimMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_claimDate = {};
//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteAggrDate_dateSave();
};


//날짜 정보 매핑 후 그리드 로드
this.lfn_jteAggrDate_dateSave = function(){
	
	if(gfn_isNull(lfo_claimDate.stdt) || gfn_isNull(lfo_claimDate.eddt)){
		//현재날짜
		var nowDate = new Date();
		
		lfo_claimDate.stdt = gfn_getDate(nowDate,"yyyy-MM-01");
		lfo_claimDate.eddt = gfn_getDate(nowDate,"yyyy-MM-dd");
	}else{
		lfo_claimDate.stdt = $("#searchStartDate").val();
		lfo_claimDate.eddt = $("#searchEndDate").val();
	}
	
	//초기화
	$("#jteSingleGrid").html("");
	lfn_jteSgGrd_setGrd();
}

//기간검색을 위한 date 세팅
this.lfn_jteAggrDate_set = function(){
	
	//현재날짜
	var nowDate = new Date();
	
	//초기 이번달 1일 데이터 세팅(start)
	if($("#searchStartDate").attr("data-role") != "datepicker"){
		$("#searchStartDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_isNull(lfo_claimDate.stdt) == true ? gfn_getDate(nowDate,"yyyy-MM-01") : lfo_claimDate.stdt,
			change : function(){
				lfn_jteAggrDate_dateSave();
			}
		});
	}
	
	//초기 오늘날짜 세팅(end)
	if($("#searchEndDate").attr("data-role") != "datepicker"){
		$("#searchEndDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_isNull(lfo_claimDate.eddt) == true ? gfn_getDate(nowDate,"yyyy-MM-dd") : lfo_claimDate.eddt,
			change : function(){
				lfn_jteAggrDate_dateSave();
			}
		});
	}
}

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopAddForm";

	lfo_common.ctrlUrl = "/cform/orderMgt/claimMgt" ;

	lfo_common.crud  = {
		read:{url:"/getLotClaimList", auth:"", prmt:{"searchStartDate" : lfo_claimDate.stdt, "searchEndDate" : lfo_claimDate.eddt}},
		create:{url:"/setClaimInfoSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"/setClaimInfoSave", auth:"", openFun: "" ,callback:lfn_jtePopGrd_save},
		destroy : {url:"/setClaimInfoDelete", auth: "" , callback:lfn_claimPopGrd_delete}
	}
	
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
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html:'<span class="pop_title">' + "기간검색" + '</span>'+ 
		'<input id="searchStartDate" name="searchStartDate" /><span class="pop_title">' + "~" + '</span><input id="searchEndDate" name="searchEndDate" />',
		callback : lfn_jteAggrDate_set
	}
	
	lfo_common.model = {
			id: "claimId",
			fields: {
				claimId : { type: "string" },
				claimNm : { type: "string" },
				claimQty : { type: "int" },
				claimState : { type: "string" },
				claimDesc : { type: "text" },
				claimCause : { type: "text" },
				claimResult : { type: "text" },
				lotId : { type: "string" },
				createdAt : { type : "string" },
				creatorId : { type : "string" },
				compId : { type : "string" },
				compNm : { type : "string" },
				accountNum : { type : "string" },
				compNumber : { type : "string" }
			}
		};

	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "claimId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this)" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px;"},
		{field: "claimId", title:gfn_getMsg("col_claimId", "클레임코드"), width: "160px;"},
		{field: "claimNm", title:gfn_getMsg("col_claimNm", "클레임명"), width: "160px;"},
		{field: "createdAt", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_createdAt", "클레임날짜"), width:"180px;"},
		{field: "claimQty", title:gfn_getMsg("col_quantity", "클레임수량"), width: "90px;"},
		{field: "compStdStr02", title:gfn_getMsg("col_accountNum", "거래처번호"), width: "140px;"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "거래처명"), width: "160px;"},
		{field: "compNumber", title:gfn_getMsg("col_compNum", "사업자 번호"), width: "130px;"},
		{field: "claimCause", title:gfn_getMsg("col_claimCause", "발생 원인"), width: "160px;"}
	];
	
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_accountNum", "거래처코드"), value: "compInfo.comp_std_str02"},
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	
	var options = {
		modal:true, 
		width: "770px", 
		height: "410px",
		id: lfo_common.popId, 
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"],
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_claimRegist", "클레임정보 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_claimSrh", "클레임정보 수정");
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePopGrd_popSet(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_popSet = function(mode, selectedItem){
	
	lfo_common.gridSelected = {};
	
	if(mode=='NEW'){
		
		$("#claim_search_btn").show();
		
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		
		$("#claim_search_btn").hide();
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {offerId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {claimId :lfo_common.gridSelected.claimId},
			success: function(data){
				gfn_popform_set(lfo_common, mode, data.rows[0]);
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
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != "") {
					//마스터 그리드 리로드
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_common.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", gfn_getMsg("pop_successSave"))});			//성공
				} else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", gfn_getMsg("pop_failedCheck"))});				//실패
				} 
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});			//오류가 발생했습니다.
			}
		});
	}
}

//삭제 콜백
this.lfn_claimPopGrd_delete = function(){
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
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});			//오류가 발생했습니다.
		}
	});
}

this.lfn_companyPop_Open = function(){
	gfn_openCustomPop('company',lfn_companyPop_callback);
}

this.lfn_companyPop_callback = function(rtnObj){
	$("#compNm").val(rtnObj["compNm"]);
	$("#compId").val(rtnObj["compId"]);
	$("#compNumber").val(rtnObj["compNumber"]);
	$("#compStdStr02").val(rtnObj["compStdStr02"]);
}


</script>