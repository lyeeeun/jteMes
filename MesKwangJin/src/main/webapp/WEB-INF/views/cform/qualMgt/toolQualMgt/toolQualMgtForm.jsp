<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="inputQualMgtForm" style="width: 100%;">
	<div id="jteSingleGrid" class="inputQualMgtForm"></div>
</div>

<div style="display:none;">
	<div id="jtePopForm">
	<form id="jtePopForm_form" class="inputQualMgtForm" style="display:none;">
		<!-- 발주주문서 -->
			<div class="pop_title"><spring:message code = "col_toolQual" text="검사"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup> <!-- 13 27 13 27 -->
				<col style="width: 24%;">
				<col style="width: 27%;">
				<col style="width: 22%;">
				<col style="width: 27%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolCd" text = "자재코드"/> : </td>
					<td colspan="3"><input type="text" id="toolId" name="toolId" format="text" readonly /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolNm" text = "자재명"/> : </td>
					<td colspan="3"><input type="text" id="toolNm" name="toolNm" format="text" readonly /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="toolMgtDesc" name="toolMgtDesc" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="toolMgtId" id="toolMgtId"/>
						<input type="hidden" name="use" id="toolMgtUse"/>
						<input type="hidden" name="action" id="toolMgtAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		<div class="pop_title"><spring:message code = "col_toolQuqalInfo" text="검사정보"></spring:message></div>
		<div id="toolQualMgt_grid" style="height:390px"></div>
	</div>
</div>

<!-- 불량품 관리 팝업 -->
<div style="display: none;">
	<div id="jteToolQualChkPop">
		<form id="jteToolQualChkPop_form" class="inputQualMgtForm">
			<table id="jteToolQualChkPop_master"
				class="BasicTable">
				<colgroup>
					<col style="width: 19%;">
					<col style="width: 31%;">
					<col style="width: 19%;">
					<col style="width: 31%;">
				</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_inspectId" text = "검사아이디" /> :</td>
					<td><input type="text" id="inspectId" name="inspectId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />"readonly /></td>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_toolIndivCd" text = "공구입고코드" /> :</td>
					<td><input id="targetId" name="targetId" format="text" readonly /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_inspector" text = "검사자" /> :</td>
					<td><input id="inspectorNm" class="btn-input" name="inspectorNm" format="text" readonly /> 
						<input type="hidden" name="inspectorId" id="inspectorId" />
						<button class="k-button k-primary" type="button" onclick="lfn_userInfoPop_Open()">
							<spring:message code="btn_search" text = "조회" />
						</button>
					</td>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_inspectDate" text = "검사일" /> :</td>
					<td><input id="inspectDate" name="inspectDate" format="datetimepicker" /></td>
				</tr>
				
				<tr>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_attachment" text = "첨부파일" /> :</td>
					<td colspan="3">
						<input name="attachFile" id="attachFiles" type="file" aria-label="files" format="file" code="inspectId" /> 
						<input type="hidden" id="insertAttach" value="[]" /> 
						<input type="hidden" id="deleteAttach" value="[]" />
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_questionValue" text = "점검내용" /> :</td>
					<td colspan="3"><input id="questionValue" name="questionValue" type="text" /></td>
				</tr>
				<tr style="display: hidden;">
					<td>
						<input type="hidden" name="toolMgtId" id="toolMgtId"/>
						<input type="hidden" name="use" id="toolQual_use" /> 
						<input type="hidden" name="action" id="toolQual_action" />
					</td>
				</tr>
			</table>
		</form>
		<div class="inputQualMgtForm final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display: none;"><spring:message code="pop_save" text = "저장" /></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display: none;"><spring:message code="pop_save" text = "저장" /></button>
			<button class="k-button k-primary final-btn" type="button" onclick="gfn_closePop('jteToolQualChkPop');"><spring:message code="pop_cancel" text = "취소" /></button>
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="searchToolMgt">
		<div id="toolMgt_grid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="toolQualPop" style="height:100%">
		<div class="pop_title"><spring:message code = "pop_asdf" text = "검사정보" /></div>
		<div id="toolQualPop_grid" style="height:350px;"></div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/toolQualMgt/toolQualMgtForm.css' rel="stylesheet">



<script>

var lfo_common = {}; 

var lfo_toolQualGrd = {};

var lfo_toolInfoGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/qualMgt/toolQualMgt"

	lfo_common.crud  = {
		read:{url:"/getToolMgtList", auth:"", prmt:{}, dynamicPrmt:{toolId : "toolId"}, search:false}

	};

	lfo_common.model = {
		id: "toolMgtId",
		fields: {
			toolMgtId : { type: "string" },
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
			isUse : { type: "bool" },
			compNumber: { type: "string" },
			compStd01: { type: "int" },
			compStd02: { type: "int" },
			compStd03: { type: "int" },
			compStd04: { type: "int" },
			compStd05: { type: "int" },
			compStdStr01: { type: "string" },
			compStdStr02: { type: "string" },
			compStdStr03: { type: "string" },
			compStdStr04: { type: "string" },
			compStdStr05: { type: "string" }
		}
	};
	
	lfo_common.columns = [
		{field: "toolMgtId", template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolQual_popOpen(this)" style="width:90px;">검사현황</button>',
			title: gfn_getMsg("btn_search", "조회"), width: "110px"},
		{field: "toolMgtId", title:gfn_getMsg("col_toolIndivCd", "공구개별코드"), width: "160px"},
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolStatus", "공구상태"), width: "160px"},
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolDiv", "공구구분"), width: "140px"},
		{field: "compStdStr02", title:gfn_getMsg("col_compStdStr02", "거래처코드"), width: "130px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "190px"},
		{field: "compNumber", title:gfn_getMsg("col_busiNum", "사업자번호"), width: "160px"},
		{field: "toolMgtUse", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_toolUse", "사용량"), width: "120px"},
		{field: "toolMgtLimit", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit", "사용제한"), width: "120px"},
		{field: "toolMgtDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];
	
	lfo_common.customTitle = {
			html : '<span class="jte-search-aria"><label>'+"공구"+' : </label>'
			+ '<input class="k-textbox" id="toolNm" style="width:200px;" readonly/>'
			+ '<input id="toolMgtId" type="hidden">'
			+ '<button class="k-button k-primary" type="button" onclick="lfn_toolMgtPop_open(\'tool\')">공구 조회</button>',
			callback : lfn_customTltle_set
		};

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_toolMgtPop_open = function(mode){
	
	if(mode == "tool") {
		var options = {
				modal:true, 
				width: "850px", 
				height: "500px",
				id: "searchToolMgt", 
				title: "공구 정보",
				resizable: true,
				animation: {open :{effects:"expand:vertical fadeIn"},
				close : {effects:"expand:vertical fadeIn", reverse: true}},
				actions: [/*"Minimize", "Maximize", */"Close"]
			};

		options.callback = function(){
			$("#toolMgt_grid").empty();
			
			lfn_toolInfoGrid();
			$('#toolMgt_grid').parent().css('height', '100%');
		};
		
		this.gfn_winOpen(options);
	}
}

//그리드 세팅
this.lfn_toolInfoGrid = function(){
	
	lfo_toolInfoGrd = {};//Form 내부에서 사용될 Object

	//1.
	lfo_toolInfoGrd.layoutId = "toolMgt_grid";
	
	//2.
	lfo_toolInfoGrd.popId = "searchToolMgt";
	
	//3.
	lfo_toolInfoGrd.ctrlUrl = "/cform/qualMgt/toolQualMgt";

	//4.
	lfo_toolInfoGrd.crud  = {
		read:{url:"/getToolInfoList", auth:"", prmt:{}, search: false}
	};
	
	//5.
	lfo_toolInfoGrd.model = {
		fields: {
			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolType : { type: "string" },
			toolPrice : { type: "int" },
			toolLimit : { type: "int" },
			toolDesc : { type: "string" },
			isUse : { type: "bool" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" }
		}
	};
	
	//6.
	lfo_toolInfoGrd.columns = [
		{field: "toolId",template : '<button class="k-button k-primary" type="button" onclick = "lfn_toolInfo_callback(this,\'EDT\') " style="width:80px;">조회</button>',
			title:"조회" , width:"100px"},
		{field: "toolId", title:gfn_getMsg("col_toolCd", "공구코드"), width: "160px"},
		{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolType", "공구유형"), width: "140px;"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm", "공구명"), width: "180px"},
		{field: "toolLimit", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit", "사용한도"), width: "120px"},
		{field: "toolDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];

	//공통 그리드 세팅 호출 
	lfo_toolInfoGrd.grid = gfn_grid_set(lfo_toolInfoGrd);

}

this.lfn_toolInfo_callback = function(selectedItems){
	
	var selectedItem = lfo_toolInfoGrd.grid.dataItem($(selectedItems).closest('tr'));

	$("#toolId").val(selectedItem.toolId);
	$("#toolNm").val(selectedItem.toolNm);
	
	gfn_closePop("searchToolMgt");
	
	lfo_common.grid.dataSource.read();
}


this.lfn_toolQual_popOpen = function(target){
	
	var options = {
		modal:true, 
		width: "1200px", 
		height: "430px",
		id: "toolQualPop", 
		title: "검사 정보",
		resizable: true,
		animation: {open :{effects:"expand:vertical fadeIn"},
		close : {effects:"expand:vertical fadeIn", reverse: true}},
		actions: [/*"Minimize", "Maximize", */"Close"]
	};

	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	
	lfo_common.gridSelected = {
		toolMgtId : dataItem.toolMgtId,
		toolNm : dataItem.toolNm
	}
	options.callback = function(){
		lfn_toolQualGrd_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}


//그리드 세팅
this.lfn_toolQualGrd_setGrd = function(dataItem){
	
	lfo_toolQualGrd = {};//Form 내부에서 사용될 Object

	//1.
	lfo_toolQualGrd.layoutId = "toolQualPop_grid";
	
	//2.
	lfo_toolQualGrd.popId = "jteToolQualChkPop";
	
	//3.
	lfo_toolQualGrd.ctrlUrl = "/cform/qualMgt/toolQualMgt";

	//4.
	lfo_toolQualGrd.crud  = {
		read:{url:"/getToolQualList", auth:"", prmt:{targetId : dataItem.toolMgtId}, search : false}, 
		create:{url:"/setToolQualSave", auth:"", openFunc : lfn_toolQualMgtGrd_open, callback : lfn_toolQualMgtGrd_save}, 
		update:{url:"/setToolQualSave", auth:"", openFunc : "", callback : lfn_toolQualMgtGrd_save}, 
		destroy:{url:"/setToolQualDelete", auth:"", callback : lfn_toolQualMgtGrd_delete}
	};
	
	//5.
	lfo_toolQualGrd.model = {
		id: "inspectId",
		fields: {
			toolId : { type : "string" },
			toolMgtId : { type : "string" },
			inspectId : { type : "string" },
			questionId : { type : "string" },
			questionValue : { type : "string" },
			targetId : { type : "string" },
			inspectDate : { type : "string" },
			inspectorId : { type : "string" },
			inspectorNm : { type : "string" },
			category : { type : "string" }
		}
	};
	
	//6.
	lfo_toolQualGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "inspectId", title:gfn_getMsg("btn_update", "수정"), width: "90px",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolQualMgtGrd_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "btn_search" text = "조회"/>" + '</button>',
		},		
		{field: "inspectId", title : gfn_getMsg("col_questionId", "검사아이디"), width: "150px"},
		{field: "toolNm", title : gfn_getMsg("col_toolNm", "공구명"), width: "150px"},
		{field: "targetId", title : gfn_getMsg("col_toolIndivCd", "공구개별코드"), width: "170px"},
		{field: "inspectDate",format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate", "검사일"), width: "170px"},
		{field: "inspectorNm", title : gfn_getMsg("col_inspector", "검사자"), width: "110px"},
		{field: "questionValue", title : gfn_getMsg("col_questionValue", "점검내용"), width: "300px"}
	];

	//공통 그리드 세팅 호출 
	lfo_toolQualGrd.grid = gfn_grid_set(lfo_toolQualGrd);

}

//불량정보 팝업 오픈
this.lfn_toolQualMgtGrd_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "770px",
		height: "340px",
		id : "jteToolQualChkPop",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:["Close"]
	};
	
	if(mode =="NEW"){
		options.title = "공구검사 정보등록"
	}else if(mode=="EDT"){
		options.title = "공구검사 정보수정"
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_toolQualGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//불량정보 팝업내용 세팅
this.lfn_toolQualGrd_popSet = function(mode,selectedItem){
	lfo_toolQualGrd.gridSelected = {};
	if(mode=='NEW'){
		selectedItem = {
				targetId : lfo_common.gridSelected.toolMgtId,  
				inspectDate : new Date(),
				inspectorNm : $("#_loginUserName").val(),
				inspectorId : $("#_loginUserId").val(),
				category : "tool_inspect"
		}
		//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
		gfn_popform_set(lfo_toolQualGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_toolQualGrd.gridSelected = lfo_toolQualGrd.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_toolQualGrd.gridSelected = {inspectId : selectedItem};
			
		}
		$.ajax({
			async:false,
			url : lfo_toolQualGrd.ctrlUrl + lfo_toolQualGrd.crud.read.url,
			type: "POST",
			data: {inspectId :lfo_toolQualGrd.gridSelected.inspectId},
			success: function(data){
				gfn_popform_set(lfo_toolQualGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//불량정보 Form내용 입력/저장
this.lfn_toolQualMgtGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_toolQualGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		
		var formId = lfo_toolQualGrd.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_toolQualGrd.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_toolQualGrd.ctrlUrl + lfo_toolQualGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_toolQualGrd.popId);
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
					
					//내역보기 팝업 리로드
					lfo_toolQualGrd.grid.dataSource.read();
					//발주주문조회 리로드
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
}

//불량정보 삭제 콜백
this.lfn_toolQualMgtGrd_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_toolQualGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_toolQualGrd.grid.dataItem($(this).closest('tr')));
		}
	}); 
	
	$.ajax({
		async:false,
		url : lfo_toolQualGrd.ctrlUrl + lfo_toolQualGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//내역보기 팝업 리로드
			lfo_toolQualGrd.grid.dataSource.read();
			
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});	
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
} 

//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}
</script>