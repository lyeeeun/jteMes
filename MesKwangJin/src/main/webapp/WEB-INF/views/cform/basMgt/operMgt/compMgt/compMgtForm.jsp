<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="compMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="compMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="compMgtForm">
		<!-- 업체정보 -->
			<div class="pop_title"><spring:message code = "pop_compInfo" text = "업체정보"/></div>
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:19%;">
				<col style="width:30%;">
				<col style="width:21%;">
				<col style="width:30%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_accountNum" text = "거래처번호"/></td>
					<td>
						<input type="text" id="compStdStr02" name="compStdStr02">
						<input type="hidden" id="compId" name="compId">
						</td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compType" text = "업체유형"/> : </td>
					<td><input id="compType" name="compType" format="selBox" msg="corp_div"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm" text = "업체명"/> : </td>
					<td colspan="3">
						<input type="text" id="compNm" name="compNm" format="text"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_busiNum" text = "사업자번호"/> : </td>
					<td><input type="text" id="compNumber" name="compNumber" format="text" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "비고"/> : </td>
					<td colspan="4"><input type="text" id="description" name="description" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="comp_action"/>
					</td>
				</tr>
			</table>
			<!-- 업체주소 -->
			<div class="pop_title"><spring:message code = "pop_compAddr" text = "업체주소"/></div>
			<div id="jtePopForm_grid" class="compMgtForm" style="height: 256px; width: 98%; margin: auto; display: flex;"></div>
		
			<div class="final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
			</div>
		</form>
	</div>
</div>

<!-- 팝업(마스터그리드 > 팝업창 내부 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopAddForm">
		<form id = "jtePopAddForm_form" class="compMgtForm">
			<table id="jtePopAddForm_master" class="BasicTable">
			<colgroup>
				<col style="width:35%;">
				<col style="width:65%;">
			</colgroup>
				<tr><td colspan="2"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compAddrCd" text = "업체주소코드"/> : </td>
					<td>
						<input type="text" id="compAddrId" name="compAddrId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력"/>" readonly/>
						<input type="hidden" id="compId" name="compId">
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compDetailAddr" text = "업체상세주소"/> : </td>
					<td>
						<input type="text" id="compAddrDetail" name="compAddrDetail"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager" text = "관리자"/> : </td>
					<td>
						<input type="text" id="compAddrUser" name="compAddrUser" format="text"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNum" text = "업체번호"/> : </td>
					<td>
						<input type="text" id="compAddrNumber" name="compAddrNumber" format="text"/>
					</td>
				</tr>
				<tr>
				<!-- 비고 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "비고"/> : </td>
					<td>
						<input type="text" id="compDesc" name="compDesc" format="text"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="compAddr_action"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area compMgtForm-final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
		</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/operMgt/compMgt/compMgtForm_JJW.css' rel="stylesheet">

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

	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/compMgt"

	lfo_common.crud  = {
		read:{url:"/getCompList", auth:"", prmt:{}}, 
		create:{url:"/setCompSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setCompSave", auth:"", openFunc:"", callback:lfn_popSave}, 
		destroy:{url:"/setCompDelete", auth:"", callback:lfn_jteGrid_delete}
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
			compStdStr05: { type: "string" }
		}
	};

	lfo_common.columns = [
		{selectable : true, width:"40px"},
		{field: "compId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},
		{field: "compStdStr02", title:gfn_getMsg("col_accountNum", "거래처번호"), width:"110px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "220px"},
		{field: "compType", template:"# var item = gfn_isNull(gfn_getCode(compType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(compType).cdId , gfn_getCode(compType).cdNm) # #= item #", 
			title:gfn_getMsg("col_compType", "업체유형"), width: "120px;"},
		{field: "compNumber", title:gfn_getMsg("col_busiNum", "사업자번호"), width: "140px"},
		{field: "description", title:gfn_getMsg("col_desc", "비고"), width: "350px"},
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"110px",
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
	
 	lfo_common.customTitle = {
		html :	'<button class="k-button k-primary" type="button" onclick = "gfn_excelUplodePop(\'compMgt\'); " style="min-width:60px; float: right;">Excel Upload</button>'
	}
	
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_compCd"), value: "compInfo.comp_id" },
		{ text: gfn_getMsg("col_compAddr"), value: "compInfo.comp_addr" }
	];

	lfo_common.validation ={
		compNm:{
			messages : "업체명을 입력하세요",
			rules : function(input){
				if(input.is("[name=compNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		compManagr:{
			messages : "담당자명을 입력하세요",
			rules : function(input){
				if(input.is("[name=compManagr]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "705px", 
		height: "690px",
		id:lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_compRegist", "업체 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_compSrh", "업체 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode, selectedItem){
	lfo_common.gridSelected = {};
	
	var childItems = [];
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.compId = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/getCompPop",
			type: "POST",
			data: {compId : lfo_common.gridSelected.compId},
			success: function(data){
				gfn_popform_set(lfo_common, mode, data.rows);
				
				childItems = data.rows.childAddrList;
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	//그리드 세팅
	lfn_jtePopGrd_setGrd(childItems);
	
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		//저장된 다국어가 있다면 추가
		
		var msgId = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		savePrmt.childAddrList = lfo_popGrd.childItems;
		
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
					lfn_jtePop_set('EDT', data);
					
					lfo_common.grid.dataSource.read();
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
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
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//사용유무
this.lfn_jteSgGrd_changeIsUse = function(rows){
	
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {compId : dataItem.compId, action : "USE", use : dataItem.use};
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
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(childItems){
	$("#jtePopForm_grid").html("");
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";

	lfo_popGrd.popId = "jtePopAddForm";

	lfo_popGrd.ctrlUrl = "/cform/basMgt/operMgt/compMgt"

	lfo_popGrd.crud  = {
		read:{url:"/getCompAddrList", auth:"", prmt:lfo_common.gridSelected}, 
		create:{url:"/setCompAddrSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save}, 
		update:{url:"/setCompAddrSave", auth:"", openFunc:"", callback:lfn_jtePopGrd_save}, 
		destroy:{url:"/setCompAddrDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};

	lfo_popGrd.model = {
		id: "compAddrId",
		fields: {
			compId : { type: "string" },
			compAddrId : { type: "string" },
			compAddrDetail : { type: "string" },
			compAddrUser : { type: "string" },
			compAddrNumber : { type: "string" },
			compDesc : { type: "string" },
			createdAt : { type: "string" },
			updatedAt : { type: "string" },
			creatorId : { type: "string" },
			updatorId : { type: "string" },
			action : {type:"string"},
			isUse : { type: "bool" }
		}
	};

	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "compAddr",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '기존' : '에러' #",
			title:"액션", width: "95px"},
		{field: "compAddrId", title:gfn_getMsg("col_compAddrCd", "업체주소코드"), width: "170px;"},
		{field: "compAddrDetail", title:gfn_getMsg("col_compDetailAddr", "업체상세주소"), width: "300px;"},
		{field: "compAddrUser", title:gfn_getMsg("col_manager", "관리자"), width: "130px;"},
		{field: "compAddrNumber", title:gfn_getMsg("col_compNum", "업체번호"), width: "150px;"},
		{field: "compDesc", title:gfn_getMsg("col_desc", "비고"), width: "220px;"},
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse", "사용유무"), width:"110px",
				template : function(rows) {
					if(rows.use == true){
						return "<a onclick='lfn_jtePopGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
					}else if (rows.use == false){
						return "<a onclick='lfn_jtePopGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
					}else{
						return ""+gfn_getMsg("val_basic", "기본")+" : Y";
					}
				}
		}
	];

	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_compAddrCd", "업체주소코드"), value: "compAddr.comp_addr_id" },
		{ text: gfn_getMsg("col_compDetailAddr", "업체상세주소"), value: "compAddr.comp_addr_detail" },
		{ text: gfn_getMsg("col_manager", "관리자"), value: "compAddr.comp_addr_user" },
		{ text: gfn_getMsg("col_compNum", "업체번호"), value: "compAddr.comp_addr_number" },
		{ text: gfn_getMsg("col_desc", "비고"), value: "compAddr.comp_desc" }	
	];

	lfo_popGrd.validation ={
		compAddrUser:{
			messages : "담당자명을 입력하세요",
			rules : function(input){
				if(input.is("[name=compAddrUser]")){
					return input.val().length != 0 ;
				}
				return true;
			}
		}
	}
	
	lfo_popGrd.childItems = childItems;
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_objectDatagrid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "480px",
		height: "370px",
		id:lfo_popGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_compAddrRegist", "업체주소 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_compAddrSrh", "업체주소 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	lfo_popGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {compId : lfo_common.gridSelected.compId}
		gfn_popform_set(lfo_popGrd, mode, selectedItem, selectedItem.action);
	}else if(mode == 'EDT'){
		var dataItem = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr"));
		gfn_popform_set(lfo_popGrd, mode, dataItem, dataItem.action);
	}
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(mode){
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		
		//저장된 다국어가 있다면 추가
		var msgBox = $("#"+lfo_popGrd.popId+"_form").find(".jte-msgBox").val();
		if(!gfn_isNull(msgBox)){
			savePrmt.msgList = JSON.parse(msgBox);
		}
		
		//중복키 예외 처리
		var childItems = gfn_objectDataGrid_save({tgObj : lfo_popGrd, prmt : savePrmt, pk : "compAddrId", autokey : true});
		if(!childItems){
			return false;
		}
		
		//데이터 object에 저장 - 부모요소 저장시 저장된다.
		lfo_popGrd.childItems = childItems;
		
		//그리드 리로드 후 팝업창 닫기
		lfo_popGrd.grid.dataSource.read();
		gfn_closePop(lfo_popGrd.popId);
	}
}
//삭제 콜백
this.lfn_jtePopGrd_delete = function(){
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delPrmt = lfo_popGrd.grid.dataItem($(this).closest('tr'));
			
			//데이터 object에 저장 - 부모요소 저장시 저장(삭제)된다.
			gfn_objectDataGrid_delete({tgObj : lfo_popGrd, prmt : delPrmt, pk : "compAddrId"});
		}
	});
	
	lfo_popGrd.grid.dataSource.read();
}

//사용유무
this.lfn_jtePopGrd_changeIsUse = function(rows){
	var dataItem = lfo_popGrd.grid.dataItem($(rows).closest("tr"));
	var prmt = {compId : dataItem.compId, compAddrId : dataItem.compAddrId, action : "USE", use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.update.url,
		type: "POST",
		data: JSON.stringify(prmt),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != 0){
				lfo_popGrd.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
</script>