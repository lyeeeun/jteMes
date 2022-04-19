<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="toolMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="toolMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="toolMgtForm">
			<div class="pop_title"><spring:message code = "pop_toolInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:32%;">
				<col style="width:18%;">
				<col style="width:32%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolCd" text = "공구코드"/> : </td>
					<td><input type="text" id="toolId" name="toolId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력"/>" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolType" text = "공구유형"/> : </td>
					<td><input id="toolType" name="toolType" format="selBox" msg="tool_div"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolNm" text = "공구명"/> : </td>
					<td colspan="4">
						<input type="text" id="toolNm" name="toolNm" format="text"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_useLimit" text = "사용한도"/> : </td>
					<td><input type="text" id="toolLimit" name="toolLimit" format="currency"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "비고"/> : </td>
					<td colspan="3"><input type="text" id="toolDesc" name="toolDesc" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use" class="use"/>
						<input type="hidden" name="action" id="tool_action" class="tool_action"/>
					</td>
				</tr>
			</table>

		<!-- 업체관리 -->
			<div class="pop_title"><spring:message code = "pop_compMgt" text = "업체관리"/></div>
			<div id="jtePopForm_grid" class="toolMgtForm" style="height: 222px; width: 98%; margin: auto; display: flex;" ></div>

			<div class="final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
			</div>
		</form>
		
	</div>
</div>

<link href='/resources/mes/css/contents/basMgt/operMgt/toolMgt/toolMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200410 LYM  -->

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

	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/toolMgt"

	lfo_common.crud  = {
		read:{url:"/getToolInfoList", auth:"", prmt:{}}, 
		create:{url:"/setToolInfoSave", auth:"", openFunc: lfn_toolPop_open, callback:lfn_popSave}, 
		update:{url:"/setToolInfoSave", auth:"", openFunc: "", callback:lfn_popSave}, 
		destroy:{url:"/setToolInfoDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	lfo_common.model = {
		id: "toolId",
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

	lfo_common.columns = [
		{selectable : true, width:"40px"},
		{field: "toolId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolPop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},
		{field: "toolId", title:gfn_getMsg("col_toolCd", "공구코드"), width: "120px"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm", "공구명"), width: "210px"},
		{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolType", "공구유형"), width: "100px;"},
		{field: "toolLimit", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit", "사용한도"), width: "140px"},
		{field: "toolDesc", title:gfn_getMsg("col_desc", "비고"), width: "400px"},
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse", "사용유무"), width:"100px",
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic", "기본")+" : Y";
				}
			}
		}
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_toolNm", "공구명"), value: "toolInfo.tool_nm" },
		{ text: gfn_getMsg("col_toolCd", "공구코드"), value: "toolInfo.tool_id" }
	];

	lfo_common.validation ={
		toolNm:{
			messages : "공구명을 입력하세요",
			rules : function(input){
				if(input.is("[name=toolNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		toolLimit:{
			messages : "사용한도를 입력하세요",
			rules : function(input){
				if(input.is("[name=toolLimit]")){
					return input.val().length != 0;
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_toolPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "705px", 
		height: "615px",
		id:lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_toolRegist", "공구 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_toolSrh", "공구 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	var childItems = [];
	
	if(mode=='NEW'){
		selectedItem = {
			toolId : lfo_common.gridSelected.toolId
		}
		gfn_popform_set(lfo_common, mode, selectedItem);
	}else if(mode == 'EDT'){
		gfn_resizePop(lfo_common.popId,{width:705,height:615});
		$("#"+lfo_common.popId+"_gridArea").show();
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {toolId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + '/getOrderPop',
			type: "POST",
			data: {toolId:lfo_common.gridSelected.toolId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows);
				childItems = data.rows.childCompMgtList;
				
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
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
		
		savePrmt.childCompMgtList = lfo_popGrd.childItems;
		
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
					lfn_jtePop_set('EDT',data);
					gfn_closePop(lfo_common.popId);
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
					
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
this.lfn_jtePopGrd_setGrd = function(childItems){
	$("#jtePopForm_grid").html("");
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";

	lfo_popGrd.ctrlUrl = "/cform/basMgt/operMgt/toolMgt"

	lfo_popGrd.crud  = {
		read:{url:"/getMtrlRtlCompList", auth:"", prmt:{}}, 
		create:{url:"/setMtrlRtlCompSave", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"", auth:"", openFunc:"", callback:lfn_jtePopGrd_save},
		destroy:{url:"/setMtrlRtlCompDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};

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
			description: { type: "string" },
			isUse: { type: "bool" },
			compStdStr02: { type : "string" }
		}
	};

	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '' : '에러' #",
			title:"액션", width: "95px"},
		{field: "compStdStr02", title:gfn_getMsg("col_compStdStr02", "거래처코드"), width: "130px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "190px"},
		{field: "compNumber", title:gfn_getMsg("col_busiNum", "사업자번호"), width: "160px"}
	];

	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "comp.comp_nm" },
		{ text: gfn_getMsg("col_compCd", "업체코드"), value: "comp.comp_id" }
	];
	
	//order에 포함된 LOT 정보 담아주기(order-child)
	lfo_popGrd.childItems = childItems;
	
	//Object형 그리드 세팅 호출(order-child)
	lfo_popGrd.grid = gfn_objectDatagrid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(selectedItem){
	//여기부터 공통팝업 띄우기
	gfn_openCustomPop('supplier',lfn_jtePopGrd_save);
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(savePrmt){

	var childItems = gfn_objectDataGrid_save({tgObj : lfo_popGrd, prmt : savePrmt, pk : "compId", autokey : false });
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
			gfn_objectDataGrid_delete({tgObj : lfo_popGrd, prmt : delPrmt, pk : "compId"});
		}
	});
	
	//그리드 리로드
	lfo_popGrd.grid.dataSource.read();
}
</script>