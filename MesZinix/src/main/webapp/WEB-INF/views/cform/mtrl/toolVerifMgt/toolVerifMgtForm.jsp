<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="mtrltoolMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class=""></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
</div>

<!-- 정비이력 POP -->
<div style="display:none;">
	<div id="jtePopToolMtnc">   <!-- style="height:100%" -->
	<!-- 정비이력 -->
		<div class="pop_title"><spring:message code = "pop_mtncHis"></spring:message></div>
		<div id="jtePopToolMtnc_grid" style="height:350px;"></div>
	</div>
</div>

<!-- 정비이력 등록/수정 팝업(서브 그리드 > 정비이력 버튼 클릭) -->
<div style="display:none;">
	<div id="jtePopToolAdd">
		<form id="jtePopToolAdd_form" class="mtrltoolMgtForm">
		<!-- 정비내역 -->
			<div class="pop_title"><spring:message code = "pop_mtncList"></spring:message></div>
			<table style="width:100%;" id="jtePopToolAdd_master" class="jtePopToolAdd_master">
			<colgroup>
				<col class="popsc-col-left-title"> <!-- 15 25 15 25 --> <!-- 200511 JJW 조회버튼을 위해 col 하나 더 추가 -->
				<col class="popsc-col-left-content-1">
				<col class="popsc-col-left-content-2">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr>
				<!-- 공구정비코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolMtnc"></spring:message> : </td>
					<td colspan="4"><input type="text" id="toolMtncId" class="center-input" name="toolMtncId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td> 
				</tr>
				<tr>
				<!-- 정비시작일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtncStartDate"></spring:message> : </td>
					<td colspan="2"><input id="toolMtncStart" class="left-input" name="toolMtncStart" format="datepicker"/></td> 
				<!-- 정비종료일 -->
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_mtncEndDate"></spring:message>
				<!-- 최초 등록시 검증기간이 자동 변경됩니다. (종료일 + 정비주기) -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_periodAutoChange"></spring:message>"></i>  : </td>   <!-- style="background:yellow;" -->
					<td><input id="toolMtncEnd" class="right-input" name="toolMtncEnd" format="datepicker"/></td> 
				</tr>
				<tr>
				<!-- 관리자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager"></spring:message> : </td>
					<td>
						<input type="text" id="toolMtncUserNm" class="left-input btn-input" name="toolMtncUserNm" readonly/> 
						<input type="hidden" id="toolMtncUser" name="toolMtncUser" />
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="gfn_openCustomPop('userInfo',lfn_userPop_callback);" >
				<!-- 조회 -->
						<spring:message code = "btn_search"></spring:message></button>
					</td>
				<!-- 금액 -->
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_cost"></spring:message> : </td>
					<td>
						<input id="toolMtncCost" class="right-input" name="toolMtncCost" format="currency"/> 
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="4"><input type="text" id="toolMtncDesc" name="toolMtncDesc" class="k-textbox center-input"/></td> 
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
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopToolAdd');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/mtrl/mtrltoolMgt/mtrltoolMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
 <link href='/resources/mes/css/contents/mtrl/mtrltoolMgt/mtrltoolMgtForm_JJW.css' rel="stylesheet"> 

<!-- 내부 스타일 외부로 이동_200511 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_toolMtncGrd = {};//정비이력 Object

var lfo_toolUseGrd = {};//사용정보 Object

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
	//lfo_common.popId = "jtePopToolMtnc";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mtrl/toolVerifMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getToolMgtList", auth:"", prmt:{toolType : "tool_div03", del : false}}
	};
	
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
		{field: "toolId", title:gfn_getMsg("col_toolCd"), width: "160px"},											//공구개별코드
		{field: "toolMgtId", title:gfn_getMsg("col_toolIndivCd"), width: "160px"},											//공구개별코드
		{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: "140px"},													//공구명
		{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolType"), width: "140px;"},												//공구유형														//공구구분
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "160px"},													//업체명
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "120px"},			//등록일
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: "120px"},			//검증기간
		{field: "toolMgtDesc", title:gfn_getMsg("col_desc"), width: "250px"},
		{ field: "toolMgtId", title: gfn_getMsg("col_history"), width: "200px",												//이력
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolMtncPop(this) " style="width:60px;">'+gfn_getMsg("pop_mtncHis")+'</button>'			//정비이력
		}
	];
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_toolNm"), value: "toolInfo.tool_nm" },					//공구명
		{ text: gfn_getMsg("col_toolIndivCd"), value: "toolMgt.tool_mgt_id" },			//공구개별코드
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },					//업체명
		{ text: gfn_getMsg("col_desc"), value: "toolMgt.tool_mgt_desc" }				//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//정비이력 버튼 클릭(팝업 오픈)
this.lfn_toolMtncPop = function(target){
	var options = {
		modal:true, 
		width: "800px", 
		height: "395px", //200519 JJW 400-> 395
		id : "jtePopToolMtnc", 
		title:gfn_getMsg("pop_toolMtncHis"),			//공구 정비이력
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	
	//선택한 항목의 ID 가져옴
	lfo_common.gridSelected = { 
			toolId : dataItem.toolId, 
			toolMgtId : dataItem.toolMgtId,
			toolNm : dataItem.toolNm,
			toolLimit : dataItem.toolLimit,
			use : dataItem.use
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteToolMtnc_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}

//정비이력 그리드 세팅
this.lfn_jteToolMtnc_setGrd = function(dataItem){
	lfo_toolMtncGrd = {};//Form 내부에서 사용될 Object
	
	//1.
	lfo_toolMtncGrd.layoutId = "jtePopToolMtnc_grid";
	
	//2.
	lfo_toolMtncGrd.popId = "jtePopToolAdd";
	
	//3.
	lfo_toolMtncGrd.ctrlUrl = "/cform/mtrl/toolVerifMgt";
	
	//4.
	lfo_toolMtncGrd.crud  = {
		read:{url:"/getToolMtncList", auth:"", prmt:{toolMgtId : dataItem.toolMgtId}}, 
		create:{url:"/setToolMtncSave", auth:"", openFunc : lfn_eqmtMtncPop_open, callback : lfn_toolMtncPop_save}, 
		update:{url:"/setToolMtncSave", auth:"", callback : lfn_toolMtncPop_save}, 
		destroy:{url:"/setToolMtncDelete", auth:"", callback : lfn_toolMtncPop_delete}
	};
	
	//5.
	lfo_toolMtncGrd.model = {
		id: "eqmtMtncId",
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
	lfo_toolMtncGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "edit",template:'<button class="k-button k-primary" type="button" onclick = "lfn_eqmtMtncPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("btn_search") , width: "110px"},				
		{field: "toolMtncId", title:gfn_getMsg("col_toolMtnc"), width: "160px"},											//공구정비코드
		{field: "toolMtncStart", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncStartDate"), width: "120px"},			//정비시작일
		{field: "toolMtncEnd", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncEndDate"), width: "120px"},				//정비종료일
		{field: "toolMtncCost", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost"), width: "100px"},								//금액
		{field: "toolMtncUserNm", title:gfn_getMsg("col_manager"), width: "130px"},											//관리자
		{field: "toolMtncDesc", title:gfn_getMsg("col_desc"), width: "250px"}												//설명
	];
	//7.
	lfo_toolMtncGrd.selectBox = [
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },					//관리자
		{ text: gfn_getMsg("col_toolMtnc"), value: "toolMtnc.tool_mtnc_id" },			//공구정비코드
		{ text: gfn_getMsg("col_desc"), value: "toolMtnc.tool_mtnc_desc" }				//설명
	];
	//8.
	lfo_toolMtncGrd.validation ={
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
	lfo_toolMtncGrd.grid = gfn_grid_set(lfo_toolMtncGrd);
}
//정비이력 등록/수정 팝업 호출
this.lfn_eqmtMtncPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "650px", // 200511 JJW 오른쪽 그리드 정비이력 버튼 클릭 - 그리드 추가버튼 클릭 시 나타나는 팝업 너비 600px -> 650px
		height: "380px", // 200511 JJW 오른쪽 그리드 정비이력 버튼 클릭 - 그리드 추가버튼 클릭 시 나타나는 팝업 높이 LYM 230px -> 328px JJW 320 -> 380
		//title : gfn_getMsg("pop_mtncRegist"),
		id: lfo_toolMtncGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:["Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtncRegist");			//정비내역 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtncSrh");				//정비내역 수정
		selectedItem = lfo_toolMtncGrd.grid.dataItem($(selectedItem).closest("tr"));
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_toolMtncPop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//정비이력 등록/수정 팝업 내용 세팅
this.lfn_toolMtncPop_set = function(mode,selectedItem){
	lfo_toolMtncGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = lfo_common.gridSelected;
		gfn_popform_set(lfo_toolMtncGrd, mode,selectedItem);
	}else if(mode == 'EDT'){
		selectedItem.toolMgtId = lfo_common.gridSelected.toolMgtId;
		
		$.ajax({
			async:false,
			url : lfo_toolMtncGrd.ctrlUrl + lfo_toolMtncGrd.crud.read.url,
			type: "POST",
			data: {toolMgtId: selectedItem.toolMgtId, toolMtncId: selectedItem.toolMtncId},
			success: function(data){
				gfn_popform_set(lfo_toolMtncGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//유저정보 팝업 콜백
this.lfn_userPop_callback = function(callbackObj){
	$("[name='toolMtncUser']").val(callbackObj.userId);
	$("[name='toolMtncUserNm']").val(callbackObj.userNm);
}

//Form내용 입력/저장
this.lfn_toolMtncPop_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_toolMtncGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_toolMtncGrd.popId+"_form").serializeObject();
		
		$.ajax({
			async:false,
			url : lfo_toolMtncGrd.ctrlUrl + lfo_toolMtncGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//설비 정비이력 그리드 리로드
					lfo_toolMtncGrd.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_toolMtncGrd.popId);
					
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
this.lfn_toolMtncPop_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_toolMtncGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_toolMtncGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_toolMtncGrd.ctrlUrl + lfo_toolMtncGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//공구정비코드 삭제 후 리로드
			lfo_toolMtncGrd.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}


</script>