<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="offerMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="offerMgtForm"></div>
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
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_compNm" text = "업체명"/> :  </td>
					<td>
						<input type="text" id="compNm" class="right-input btn-input" name="compNm" format="text" readonly/> 
						<input type="hidden" id="compId" class="right-input btn-input" name="compId"/>
						<button class="k-button k-primary search-btn" type="button" id="offer_search_btn" onclick="lfn_companyPop_Open()">
						<spring:message code="btn_search" text = "조회"/></button>
					</td>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_offerDate" text = "작성날짜"/> : </td>
					<td><input id="offerDate" class="left-input" name="offerDate" format="datetimepicker"/></td> 
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
						<input type="hidden" name="use" id="offerUse"/>
						<!-- <input type="hidden" name="offerId" id="offerId"/> -->
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

<link href='/resources/mes/css/contents/orderMgt/orderDetailMgt/orderDetailMgtForm_JJW.css' rel="stylesheet">
<!-- <link href='/resources/mes/css/contents/orderMgt/offerMgt/offerMgtForm_JJW.css' rel="stylesheet"> -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_offerDate = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	lfn_jteAggrDate_dateSave();

};

//날짜 정보 매핑 후 그리드 로드
this.lfn_jteAggrDate_dateSave = function(){
	
	if(gfn_isNull(lfo_offerDate.stdt) || gfn_isNull(lfo_offerDate.eddt)){
		//현재날짜
		var nowDate = new Date();
		
		lfo_offerDate.stdt = gfn_getDate(nowDate,"yyyy-MM-01");
		lfo_offerDate.eddt = gfn_getDate(nowDate,"yyyy-MM-dd");
	}else{
		lfo_offerDate.stdt = $("#searchStartDate").val();
		lfo_offerDate.eddt = $("#searchEndDate").val();
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
			value : gfn_isNull(lfo_offerDate.stdt) == true ? gfn_getDate(nowDate,"yyyy-MM-01") : lfo_offerDate.stdt,
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
			value : gfn_isNull(lfo_offerDate.eddt) == true ? gfn_getDate(nowDate,"yyyy-MM-dd") : lfo_offerDate.eddt,
			change : function(){
				lfn_jteAggrDate_dateSave();
			}
		});
	}
}

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopOfferForm";

	lfo_common.ctrlUrl = "/cform/orderMgt/offerMgt" ;

	lfo_common.crud  = {
		read:{url:"/getOfferList", auth:"", prmt:{"searchStartDate" : lfo_offerDate.stdt, "searchEndDate" : lfo_offerDate.eddt}},
		create:{url:"/setOfferSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"/setOfferSave", auth:"", openFun: "" ,callback:lfn_jtePopGrd_save},
		destroy : {url:"/setOfferDelete", auth: "" , callback:lfn_offerPopGrd_delete}
	}
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html:'<span class="pop_title">' + "기간검색" + '</span>'+ 
		'<input id="searchStartDate" name="searchStartDate" /><span class="pop_title">' + "~" + '</span><input id="searchEndDate" name="searchEndDate" />',
		callback : lfn_jteAggrDate_set
	}
	
	lfo_common.model = {
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
	
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "offerId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this)" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "100px;"},
		{field: "offerNm", title:gfn_getMsg("col_offerNm", "견적서명"), width: "180px;"},
		{field: "offerDate", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("offerDate", "작성날짜"), width:"180px;"},
		{field: "compStdStr02", title:gfn_getMsg("col_accountNum", "거래처코드"), width: "110px;"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "160px;"},
		{field: "compNumber", title:gfn_getMsg("col_compNum", "업체번호"), width: "130px;"},
		{field: "offerDesc", title:gfn_getMsg("col_descr", "비고"), width: "250px;"}
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_accountNum", "거래처코드"), value: "comp.comp_std_str02"},
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "comp.comp_nm" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	
	var options = {
		modal:true, 
		width: "800px", 
		height: "525px",
		id: lfo_common.popId, 
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
	
	lfo_common.gridSelected = {};
	
	if(mode=='NEW'){
		$("#offer_search_btn").show();
		selectedItem = {
			offerDate : new Date()
		}
		gfn_popform_set(lfo_common, mode, selectedItem);
	}else if(mode == 'EDT'){
		$("#offer_search_btn").hide();
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {offerId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {offerId :lfo_common.gridSelected.offerId},
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
		var formId = lfo_common.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);

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
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});
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