<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="facilMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="facilMgtForm"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="toolMgtForm">
			<div class="pop_title"><spring:message code = "pop_eqmtInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:32%;">
				<col style="width:18%;">
				<col style="width:32%;">
			</colgroup>
				<tr>
				<!-- 설비코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtCd"></spring:message> : </td>
					<td><input type="text" id="eqmtMgtId" name="eqmtMgtId" readonly/></td>			<!-- 자동 입력 -->
				<!-- 설비구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtDiv"></spring:message> : </td>
					<td><input id="eqmtGbn" name="eqmtMgtGbn"  format = "selBox" msg="eqmt_div" readonly/></td>
				</tr>
				<tr>
				<!-- 설비명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtDetailNm"></spring:message> : </td>
					<td><input type="text" id="eqmtMgtNm" name="eqmtMgtNm" format="text" readonly/>
					</td> 
				<!-- 정비주기 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtnc"></spring:message> : </td>
					<td><input id="eqmtMgtMtnc" name="eqmtMgtMtnc" format="currency" readonly/></td>
				</tr>
				<tr>
				<!-- 수령일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate"></spring:message> : </td>
					<td><input id="eqmtMgtPurchase" name="eqmtMgtPurchase" format="datepicker" readonly/></td>
				<!-- 검증기간 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_verifyPeriod"></spring:message>
					</td>
					<td><input id="eqmtMgtVerif" name="eqmtMgtVerif" format="datepicker" readonly/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="eqmtMgtDesc" name="eqmtMgtDesc" class="k-textbox" readonly/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="action"/>
					</td>
				</tr>
			</table>
		<!-- 업체관리 -->
			<div class="pop_title"><spring:message code = "pop_toolInfo"></spring:message></div>
			<div id="jtePopForm_grid" class="toolMgtForm" style="height: 222px; width: 98%; margin: auto; display: flex;" ></div>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		
	</div>
</div>

<!--  -->
<div style="display:none;">
	<div id="jtePopToolMgt">   <!-- style="height:100%" -->
		<div class="pop_title"></div>
		<div id="jtePopToolMgt_grid" class="toolMgtForm" style="height:350px;"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/toolMgt/toolMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/operMgt/facilMgt/facilMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200410 LYM  -->

<script>
var lfo_common = {};//Form 내부에서 사용될 Object

var lfo_popGrd = {};//서브 그리드 내부에서 사용될 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//main - grid 생성
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/form/facilMgt/facilMountTool";

	lfo_common.crud  = {
		read:{url:"/getEqmtToolRtlList", auth:"", prmt:{}}, 
		//create:{url:"", auth:"", openFunc : "", callback : ""}, 
		update:{url:"/setEqmtTool", auth:"", openFunc : lfn_jtePop_open, callback : lfn_popSave}, 
		/* destroy:{url:"", auth:"", callback:""} */
	};

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
				compNm : { type: "string" },
				eqmtMgtStd01: { type: "int" },
				eqmtMgtStd02: { type: "int" },
				eqmtMgtStd03: { type: "int" },
				eqmtMgtStd04: { type: "int" },
				eqmtMgtStd05: { type: "int" },
				eqmtMgtStdStr01: { type: "string" },
				eqmtMgtStdStr02: { type: "string" },
				eqmtMgtStdStr03: { type: "string" },
				eqmtMgtStdStr04: { type: "string" },
				eqmtMgtStdStr05: { type: "string" }
			}
		};

	lfo_common.columns = [
		{field: "eqmtMgtId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\', this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update"), width: "95px"},	
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: "150px"},
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtNm"), width: "170px"},
		{field: "eqmtMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(eqmtMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(eqmtMgtGbn).cdId , gfn_getCode(eqmtMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_eqmtDiv"), width: "130px;"},
		{field: "eqmtMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "120px"},
		{field: "eqmtMgtVerif" , format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: "120px"},
		{field: "eqmtMgtMtnc", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_mtnc"), width: "100px"},
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc"), width: "300px"}
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_eqmtNm"), value: "eqmtMgt.eqmt_mgt_nm" },				//설비명
		{ text: gfn_getMsg("col_eqmtIndivCd"), value: "eqmtMgt.eqmt_mgt_id" },			//설비개별코드
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
//정비이력 버튼 클릭(팝업 오픈)
this.lfn_jtePop_open = function(mode, target){
	var options = {
		modal:true, 
		width: "840px", 
		height: "380px", //200519 JJW 400-> 390
		id : "jtePopToolMgt", 
		title: "뭘까",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteEqmtMtnc_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}

//정비이력 그리드 세팅
this.lfn_jteEqmtMtnc_setGrd = function(dataItem){
	lfo_toolMgtGrd = {};

	lfo_toolMgtGrd.layoutId = "jtePopToolMgt_grid";

	lfo_toolMgtGrd.popId = "jtePopAddTool";

	lfo_toolMgtGrd.ctrlUrl = "/form/facilMgt/facilMountTool";

	lfo_toolMgtGrd.crud  = {
		read:{url:"/getToolEqipList", prmt:{eqmtMgtId : $('#eqmtMgtId').val()}, search:false} 
		//create:{url:"", openFunc : "", callback : ""}, 
		//update:{url:"/setToolMgtRtl", openFunc : lfn_toolIndivPop_open, callback : lfn_toolIndivPopSave}, 
		//destroy:{url:"", auth:"", callback : ""}
	};

	lfo_toolMgtGrd.model = {
		id: "toolMgtId",
		fields: {
			toolMgtId : { type: "string" },
			toolId : { type: "string" },
			toolNm : { type: "string" },
			eqmtMgtId : { type: "string" },
		}
	};

	lfo_toolMgtGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMgtId", title:gfn_getMsg("col_toolIndivCd"), width: "170px"},
		{field: "eqmtMgtId", title:"설비개별코드", width: "170px"},
		{field: "toolId", title:gfn_getMsg("col_toolCd"), width: "170px"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: "150px"},
	];
	

	//공통 그리드 세팅 호출 
	lfo_toolMgtGrd.grid = gfn_grid_set(lfo_toolMgtGrd);
}

//정비이력 등록/수정 팝업 내용 세팅
this.lfn_eqmtMtncPop_set = function(mode,selectedItem){
	lfo_toolMgtGrd.gridSelected = "";
	if(mode=='NEW'){
		gfn_popform_set(lfo_toolMgtGrd, mode);
		selectedItem = {
			toolMgtId : lfo_toolSearchGrd.gridSelected.toolMgtId,
			toolId : lfo_toolSearchGrd.gridSelected.toolId,
			toolNm : lfo_toolSearchGrd.gridSelected.toolNm
		}
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_toolMgtGrd.gridSelected = lfo_toolMgtGrd.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_toolMgtGrd.gridSelected = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_toolMgtGrd.ctrlUrl + lfo_toolMgtGrd.crud.read.url,
			type: "POST",
			data: {toolMgtId : lfo_toolMgtGrd.gridSelected.toolMgtId},
			success: function(data){
				gfn_popform_set(lfo_toolMgtGrd, mode,data.rows);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

</script>