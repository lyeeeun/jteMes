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
				<!-- 공구코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolCd"></spring:message> : </td>
					<td><input type="text" id="toolId" name="toolId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 공구유형 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolType"></spring:message> : </td>
					<td><input id="toolType" name="toolType" format="selBox" msg="tool_div"/></td>
				</tr>
			<%--
				<tr>				
				<!-- 예비1 -->
					<td><i class="fas fa-caret-right"></i>예비1 :</td>
					<td><input type="text" id="toolStd01" class="left-input" name="toolStd01" format="numeric"/></td>
				<!-- 예비1(str) -->
					<td><i class="fas fa-caret-right"></i>예비1(str) :</td>
					<td><input type="text" id="toolStdStr01" class="right-input" name="toolStdStr01"  /></td>
				</tr>
			 --%>
				
				<tr>
				<!-- 공구명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolNm"></spring:message> : </td>
					<td colspan="4">
						<input type="text" id="toolNm" name="toolNm" format="text"/>
					</td>
<%-- 					<td>
						<button class="k-button k-primary jte-msgBox" type="button" prefix = "tool" defId="toolId" defNm="toolNm" >
				<!-- 다국어 -->
						<spring:message code = "pop_msgLang"></spring:message></button>
						<input type="hidden" id="msg_toolId" />
					</td> --%>
				</tr>
				<tr>
				<!-- 금액 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_cost"></spring:message> : </td>
					<td><input type="text" id="toolPrice" name="toolPrice" format="currency" /></td>
				<!-- 사용한도 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_useLimit"></spring:message> : </td>
					<td><input type="text" id="toolLimit" name="toolLimit" format="currency"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
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
			<div class="pop_title"><spring:message code = "pop_compMgt"></spring:message></div>
			<div id="jtePopForm_grid" class="toolMgtForm" style="height: 222px; width: 98%; margin: auto; display: flex;" ></div>

			<div class="final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/toolMgt/toolMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
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
	/* 
		1. gridObject.layoutId = gridId
		2. gridObject.popId = popId
		3. gridObject.ctrlUrl = 조회 url
		4. gridObject.crud  = {
			read:{url:"",auth:"", prmt:{}}, 
			create:{url:"",auth:"",openFunc:function, callback:function}, 
			update:{url:"",auth:"",openFunc:function, callback:function}, 
			delete:{url:"",auth:"", callback:function}}
		5. gridObject.model = fieldType
		6. gridObject.columns = foeldColumns
		7. gridObject.selectBox = SelectBox 매핑 값 
	*/
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/toolMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getToolInfoList", auth:"", prmt:{}}, 
		create:{url:"/setToolInfoSave", auth:"", openFunc: lfn_toolPop_open, callback:lfn_popSave}, 
		update:{url:"/setToolInfoSave", auth:"", openFunc: "", callback:lfn_popSave}, 
		destroy:{url:"/setToolInfoDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
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
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"40px"},
		{field: "toolId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolPop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update"), width: "90px"},															//수정
		{field: "toolId", title:gfn_getMsg("col_toolCd"), width: "120px"},											//공구코드
		{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: "210px"},											//공구명
		{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolType"), width: "80px;"},														//공구유형
		{field: "toolPrice",format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost"), width: "140px"},						//비용
		{field: "toolLimit", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit"), width: "140px"},					//사용한도
		{field: "toolDesc", title:gfn_getMsg("col_desc"), width: "400px"},											//설명
		//{field: "toolStd01", title:"예비1", format: "{0:n}", width: "100px"},										//예비1
		//{field: "toolStd02", title:"예비1", format: "{0:n}", width: "100px"},										//예비2
		//{field: "toolStd03", title:"예비1", format: "{0:n}", width: "100px"},										//예비3
		//{field: "toolStd04", title:"예비1", format: "{0:n}", width: "100px"},										//예비4
		//{field: "toolStd05", title:"예비1", format: "{0:n}", width: "100px"},										//예비5
		//{field: "toolStdStr01", title : "예비1(Str)", width: "100px"},												//예비1(Str)
		//{field: "toolStdStr02", title : "예비1(Str)", width: "100px"},												//예비2(Str)
		//{field: "toolStdStr03", title : "예비1(Str)", width: "100px"},												//예비3(Str)
		//{field: "toolStdStr04", title : "예비1(Str)", width: "100px"},												//예비4(Str)
		//{field: "toolStdStr05", title : "예비1(Str)", width: "100px"},												//예비5(Str)
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"100px",			//사용유무
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic")+" : Y";														//기본
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_toolNm"), value: "toolInfo.tool_nm" },				//공구명
		{ text: gfn_getMsg("col_toolCd"), value: "toolInfo.tool_id" },				//공구코드
		{ text: gfn_getMsg("col_desc"), value: "toolInfo.tool_desc" }				//설명
	];
	
	//8.
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
		height: "615px", /* 20.12.22 JJW POP 고려 X 500 -> 615  */
		id:lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_toolRegist");			//공구 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_toolSrh");				//공구 조회
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
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
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
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					lfo_common.grid.dataSource.read();
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
	/* 
	1. gridObject.layoutId = gridId
	2. gridObject.popId = popId
	3. gridObject.ctrlUrl = 조회 url
	4. gridObject.crud  = {
		read:{url:"",auth:"", prmt:{}}, 
		create:{url:"",auth:"",openFunc:function, callback:function}, 
		update:{url:"",auth:"",openFunc:function, callback:function}, 
		delete:{url:"",auth:"", callback:function}}
	5. gridObject.model = fieldType
	6. gridObject.columns = foeldColumns
	7. gridObject.selectBox = SelectBox 매핑 값 
*/
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	//lfo_popGrd.popId = "";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/basMgt/operMgt/toolMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlRtlCompList", auth:"", prmt:{}}, 
		create:{url:"/setMtrlRtlCompSave", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"", auth:"", openFunc:"", callback:lfn_jtePopGrd_save},
		destroy:{url:"/setMtrlRtlCompDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
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
			isUse: { type: "bool" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '' : '에러' #",
			title:"액션", width: "95px"},
		{field: "compId", title:gfn_getMsg("col_compCd"), width: "140px"},				//업체코드
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "180px"},				//업체명
		{field: "description", title:gfn_getMsg("col_desc"), width: "250px"}			//비고
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_compNm"), value: "comp.comp_nm" },					//업체명
		{ text: gfn_getMsg("col_compCd"), value: "comp.comp_id" },					//업체코드
		{ text: gfn_getMsg("col_desc"), value: "comp.description" }					//비고
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