<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="toolMainRecordForm" style="width:100%;">
	<div id="jteSingleGrid" class="toolMainRecordForm"></div>
</div>

<!-- 정비이력 팝업  -->
<div style="display:none;">
	<div id="jtePopForm" class="toolMainRecordForm jtePopForm">
		<div class="pop_title">공구 정비 이력</div>
		<div id="jtePopForm_grid" style="height:350px;"></div>
	</div>
</div>

<!-- 정비이력 등록/수정 팝업(서브 그리드 > 정비이력 버튼 클릭) -->
<div style="display:none;">
	<div id="jtePopToolAdd">
		<form id="jtePopToolAdd_form" class="mtrltoolMgtForm">
			<div class="pop_title"><spring:message code = "pop_mtncList" text = "정비내역" /></div>
			<table id="jtePopToolAdd_master" class="BasicTable">
			<colgroup>
				<col style="width:22%;">
				<col style="width:26%;">
				<col style="width:26%;">
				<col style="width:26%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolMtnc" text = "공구정비코드" /> : </td>
					<td colspan="3"><input type="text" id="toolMtncId" name="toolMtncId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtncStartDate" text = "정비시작일" /> : </td>
					<td><input id="toolMtncStart" name="toolMtncStart" format="datepicker"/></td> 
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtncEndDate" text = "정비종료일" />
					<i class="fas fa-info-circle" title="<spring:message code = "pop_periodAutoChange" text = "최초 등록시 검증기간이 자동 변경됩니다." />"></i>  : </td> 
					<td><input id="toolMtncEnd" name="toolMtncEnd" format="datepicker"/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager" text = "관리자" /> : </td>
					<td>
						<input type="text" id="toolMtncUserNm" class="btn-input" name="toolMtncUserNm" readonly/> 
						<input type="hidden" id="toolMtncUser" name="toolMtncUser" />
						<button class="k-button k-primary" type="button" onclick="gfn_openCustomPop('userInfo',lfn_userPop_callback);" >
						<spring:message code = "btn_search" text = "조회" /></button>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_cost" text = "금액" /> : </td>
					<td>
						<input id="toolMtncCost" name="toolMtncCost" format="currency"/> 
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명" /> : </td>
					<td colspan="3"><input type="text" id="toolMtncDesc" name="toolMtncDesc"/></td> 
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="toolId" id="parentToolId"/>
						<input type="hidden" name="toolMgtId" id="parentToolMgtId"/>
						<input type="hidden" name="toolLimit" id="parentToolMaintenance"/>
						<input type="hidden" name="use" id="toolMtncUse"/>
						<input type="hidden" name="action" id="toolMtncAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopToolAdd');"><spring:message code = "pop_cancel" text = "취소" /></button>
			</div>
		</form>
	</div>
</div>

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	lfn_radioBtn_event();
};

//사용여부 라디오 버튼
this.lfn_radioBtn_event = function(){
	$("[name='delTmrChk']").change(function(e){
		$("#delStat").val($("[name='delTmrChk']:checked").val());
		lfo_common.grid.dataSource.read();
	});
}

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/tool/mtrltoolMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getToolMgtList", auth:"", search:false, prmt:{toolId:""}, dynamicPrmt : {del : "delStat", toolId : "toolId"}},
		
	};
	
	//커스텀 타이틀
 	lfo_common.customTitle = {
		html :	 '<button class="k-button k-primary" type="button" onclick = "lfn_tool_info(\'tool\');" style="min-width:60px;">공구 검색</button>' +
				'<input class="k-textbox" id="toolNm" readonly/><input type="hidden" id="toolId" />'+
				'<span style="margin : 10px 10px 0 10px ;">사용가능 여부 : '+
				'<input type="radio" name="delTmrChk" id="delFalse" class="k-radio" checked="checked" value=false style="margin : 0 5px 0 5px;">' +
			 	'<label class="mtrltoolMgtForm-label" for="delFalse">가능</label>'+
				'<input type="radio" name="delTmrChk" id="delTrue" class="k-radio"  value=true style="margin : 0 5px 0 5px;">'+
				'<label class="mtrltoolMgtForm-label" for="delTrue">불가</label>'+
				'<input type="hidden" id="delStat" value="false"></span>'
	} 
	
	//5.
	lfo_common.model = {
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
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMgtId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + gfn_getMsg("pop_mtncHis") + '</button>',
			title : gfn_getMsg("col_history", "조회") , width: "110px"},
		{field: "toolMgtId", title:gfn_getMsg("col_toolIndivCd", "공구개별코드"), width: "160px"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm", "공구명"), width: "140px"},
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolStatus", "공구상태"), width: "160px"},
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolDiv", "공구구분"), width: "140px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "160px"},
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate", "등록일"), width: "120px"},
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod", "검증기간"), width: "120px"},
		{field: "toolMgtUse", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_toolUse", "사용량"), width: "120px"},
		{field: "toolMgtLimit", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit", "사용제한"), width: "120px"},
		{field: "toolMgtDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_toolNm", "공구명"), value: "toolInfo.tool_nm" },
		{ text: gfn_getMsg("col_toolIndivCd", "공구개별코드"), value: "toolMgt.tool_mgt_id" },
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_desc", "설명"), value: "toolMgt.tool_mgt_desc" }
	];
	//8.
	lfo_common.validation ={
		toolMgtUse:{
			messages : "사용량을 입력하세요",
			rules : function(input){
				if(input.is("[name=toolMgtUse]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		toolMgtLimit:{
			messages : "사용한도를 입력하세요",
			rules : function(input){
				if(input.is("[name=toolMgtLimit]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		toolMgtPurchase:{
			messages : "수령일을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMgtPurchase]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		toolMgtVerif:{
			messages : "검증기간을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMgtVerif]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		compId:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=compId]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 업체를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 compId
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//공구 선택 팝업
this.lfn_tool_info = function(mode){
	
	if(mode == 'tool') {
		var callback = function(selectedItem){
			$('#toolNm').val(selectedItem.toolNm);
			$('#toolId').val(selectedItem.toolId);
			
			lfo_common.grid.dataSource.read();
		};
		
		gfn_openCustomPop("tool", callback);
	}
	
}

//공구 정비 이력 팝업 오픈
this.lfn_jtePop_open = function(mode, target){

	var options = {
			modal:true, 
			width: "850px",
			height: "388px", 
			id : lfo_common.popId, 
			title: "공구 정비 이력",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		lfo_common.gridSelected = lfo_common.grid.dataItem($(target).closest("tr"));
		
	
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	};
	this.gfn_winOpen(options);
}

//정비이력 그리드 세팅
this.lfn_jtePopGrd_setGrd = function(dataItem){
	lfo_popGrd = {};//Form 내부에서 사용될 Object

	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	lfo_popGrd.popId = "jtePopToolAdd";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/tool/mtrltoolMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getToolMtncList", auth:"", prmt:{toolMgtId : lfo_common.gridSelected.toolMgtId}}, 
		create:{url:"/setToolMtncSave", auth:"", openFunc:lfn_toolMtncPop_open, callback : lfn_toolMtncPop_save}, 
		update:{url:"/setToolMtncSave", auth:"", callback : lfn_toolMtncPop_save}, 
		destroy:{url:"/setToolMtncDelete", auth:"", callback : lfn_toolMtncPop_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "toolMtncId",
		fields: {
			toolMtncId : { type: "string" },
			toolMtncStart : { type: "date" },
			toolMtncEnd : { type: "date" },
			toolMtncUser : { type: "string" },
			toolMtncCost : { type: "int" },
			toolMtncDesc : { type: "string" },
			creatorId : { type: "string" },
			createdAt : { type: "date" },
			updatorId : { type: "string" },
			updatedAt : { type: "date" },
			toolMgtId : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMtncId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolMtncPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("btn_search", "조회") , width: "110px"},			
		{field: "toolMtncId", title:gfn_getMsg("col_toolMtnc","공구정비코드"), width: "160px"},
		{field: "toolMtncStart", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncStartDate", "정비시작일"), width: "120px"},
		{field: "toolMtncEnd", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncEndDate", "정비종료일"), width: "120px"},
		{field: "toolMtncCost", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost", "금액"), width: "100px"},
		{field: "toolMtncUserNm", title:gfn_getMsg("col_manager", "관리자"), width: "130px"},
		{field: "toolMtncDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_manager", "관리자"), value: "urInfo.user_nm" },
		{ text: gfn_getMsg("col_toolMtnc", "공구정비코드"), value: "toolMtnc.tool_mtnc_id" },
		{ text: gfn_getMsg("col_desc", "설명"), value: "toolMtnc.tool_mtnc_desc" }
	];
	//8.
	lfo_popGrd.validation ={
		toolMtncStart:{
			messages : "정비시작일을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMtncStart]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		toolMtncEnd:{
			messages : "정비종료일을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMtncEnd]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		toolMtncUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=toolMtncUser]")){
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
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

//정비이력 등록/수정 팝업 호출
this.lfn_toolMtncPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "730px",
		height: "380px",
		id:lfo_popGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtncRegist", "정비내역 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtncSrh", "정비내역 수정");
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_toolMtncPop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//정비이력 등록/수정 팝업 내용 세팅
this.lfn_toolMtncPop_set = function(mode,selectedItem){
	
	var gridSelected = "";
	
	if(mode=='NEW'){
		gridSelected = {
			toolMgtId : lfo_common.gridSelected.toolMgtId
		};
		
	}else if(mode == 'EDT'){
		gridSelected = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr"));
		gridSelected.toolMgtId = lfo_popGrd.toolMgtId;
	}
	gfn_popform_set(lfo_popGrd, mode,gridSelected);
}

//유저정보 팝업 콜백
this.lfn_userPop_callback = function(callbackObj){
	$("[name='toolMtncUser']").val(callbackObj.userId);
	$("[name='toolMtncUserNm']").val(callbackObj.userNm);
}

//Form내용 입력/저장
this.lfn_toolMtncPop_save = function(mode){
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
					//공구 정비이력 그리드 리로드
					lfo_popGrd.grid.dataSource.read();
					//공구관리 그리드 리로드
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_popGrd.popId);
					
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
this.lfn_toolMtncPop_delete = function(){
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
			lfo_common.grid.dataSource.read();
			//공구정비코드 삭제 후 리로드
			lfo_popGrd.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

</script>