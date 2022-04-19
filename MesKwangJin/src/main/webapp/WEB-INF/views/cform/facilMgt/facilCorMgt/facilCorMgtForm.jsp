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
					<td><i class="fas fa-caret-right"></i><spring:message code="col_eqmtMgtNm" text = "설비명"/> :  </td>
					<td>
						<input type="text" id="eqmtMgtNm" class="right-input btn-input" name="eqmtMgtNm" format="text" readonly/> 
						<input type="hidden" id="eqmtMgtId" class="right-input btn-input" name="eqmtMgtId"/>
						<button class="k-button k-primary search-btn" type="button" id="eqmt_search_btn" onclick="lfn_eqmtMgtPop_Open()">
						<spring:message code="btn_search" text = "조회"/></button>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_manager" text = "관리자" /> : </td>
					<td>
						<input type="text" id="eqmtMtncUserNm" class="btn-input" name="eqmtMtncUserNm" readonly />
						<input type="hidden" id="eqmtMtncUser" name="eqmtMtncUser" />
						<button class="k-button k-primary" type="button" onclick="gfn_openCustomPop('userInfo',lfn_userPop_callback);" >
						<spring:message code = "btn_search" text = "조회" /></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtncStartDate" text = "정비시작일" /> : </td>
					<td><input id="eqmtMtncStart" name="eqmtMtncStart" format="datepicker" /></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_mtncEndDate" text = "정비종료일" /> 
						<i class="fas fa-info-circle" title="<spring:message code = "pop_periodAutoChange" text = "최초 등록시 검증기간이 자동 변경됩니다. (종료일 + 정비주기) " />" ></i>  : </td>
					<td><input id="eqmtMtncEnd" name="eqmtMtncEnd" format="datepicker" /></td>
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
						<input type="hidden" name="eqmtMtncId" id="eqmtMtncId"/>
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

var lfo_eqmtDate = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteAggrDate_dateSave();
};

//날짜 정보 매핑 후 그리드 로드
this.lfn_jteAggrDate_dateSave = function(){
	
	if(gfn_isNull(lfo_eqmtDate.stdt) || gfn_isNull(lfo_eqmtDate.eddt)){
		//현재날짜
		var nowDate = new Date();
		
		lfo_eqmtDate.stdt = gfn_getDate(nowDate,"yyyy-MM-01");
		lfo_eqmtDate.eddt = gfn_getDate(nowDate,"yyyy-MM-dd");
	}else{
		lfo_eqmtDate.stdt = $("#searchStartDate").val();
		lfo_eqmtDate.eddt = $("#searchEndDate").val();
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
			value : gfn_isNull(lfo_eqmtDate.stdt) == true ? gfn_getDate(nowDate,"yyyy-MM-01") : lfo_eqmtDate.stdt,
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
			value : gfn_isNull(lfo_eqmtDate.eddt) == true ? gfn_getDate(nowDate,"yyyy-MM-dd") : lfo_eqmtDate.eddt,
			change : function(){
				lfn_jteAggrDate_dateSave();
			}
		});
	}
}

//서브 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopEqmtAdd";

	lfo_common.ctrlUrl = "/cform/facilMgt/facilCorMgt";

	lfo_common.crud  = {
		read:{url:"/getEqmtMtncList", auth:"", prmt:{"searchStartDate" : lfo_eqmtDate.stdt, "searchEndDate" : lfo_eqmtDate.eddt}}, 
		create:{url:"/setEqmtMtncSave", auth:"", openFunc : lfn_eqmtMtncPop_open, callback : lfn_eqmtMtncPopSave}, 
		update:{url:"/setEqmtMtncSave", auth:"", openFunc :"" , callback : lfn_eqmtMtncPopSave}, 
		destroy:{url:"/setEqmtMtncDelete", auth:"", callback : lfn_eqmtMtncPopDelete}
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html:'<span class="pop_title">' + "기간검색" + '</span>'+ 
		'<input id="searchStartDate" name="searchStartDate" /><span class="pop_title">' + "~" + '</span><input id="searchEndDate" name="searchEndDate" />',
		callback : lfn_jteAggrDate_set
	}

	lfo_common.model = {
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

	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "eqmtMtncId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_eqmtMtncPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("btn_search", "조회") , width: "90px"},
		//{field: "eqmtMtncId", title:gfn_getMsg("col_eqmtMtnc", "설비정비코드"), width: "170px"},
		{field: "eqmtMtncStart", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncStartDate", "정비시작일"), width: "120px"},
		{field: "eqmtMtncEnd", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncEndDate", "정비종료일"), width: "120px"},
		{field: "createdAt", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_createdAt", "작성날짜"), width: "150px"},
		{field: "eqmtMtncUserNm", title:gfn_getMsg("col_manager", "관리자"), width: "130px"},
		{field: "eqmtMtncDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"},
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtMgtId", "설비코드"), width: "170px"},
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtMgtNm", "설비명"), width: "170px"},
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_manager", "관리자"), value: "urInfo.user_nm" }, 
		{ text: gfn_getMsg("col_eqmtMtnc", "설비정비코드"), value: "eqmtMtnc.eqmt_mtnc_id" }
	];

	lfo_common.validation ={
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
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//정비이력 등록/수정 팝업 호출
this.lfn_eqmtMtncPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px",
		height: "435px",
		id:lfo_common.popId, 
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
	
	lfo_common.gridSelected = {};
	
	if(mode=='NEW'){
		
		$("#eqmt_search_btn").show();
		
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		
		$("#eqmt_search_btn").hide();
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {eqmtMtncId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {eqmtMtncId :lfo_common.gridSelected.eqmtMtncId},
			success: function(data){
				gfn_popform_set(lfo_common, mode, data.rows[0]);
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//유저정보 팝업 콜백
this.lfn_userPop_callback = function(callbackObj){
	$("[name='eqmtMtncUser']").val(callbackObj.userId);
	$("[name='eqmtMtncUserNm']").val(callbackObj.userNm);
}

//Form내용 입력/저장
this.lfn_eqmtMtncPopSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = gfn_serializeObject(lfo_common.popId+"_form");
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
					//설비 정비이력 그리드 리로드
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_common.popId);
					
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
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

this.lfn_eqmtMgtPop_Open = function(){
	gfn_openCustomPop('eqmtMgt',lfn_eqmtMgtPop_callback);
}

this.lfn_eqmtMgtPop_callback = function(rtnObj){
	$("#eqmtMgtNm").val(rtnObj["eqmtMgtNm"]);
	$("#eqmtMgtId").val(rtnObj["eqmtMgtId"]);
}

</script>