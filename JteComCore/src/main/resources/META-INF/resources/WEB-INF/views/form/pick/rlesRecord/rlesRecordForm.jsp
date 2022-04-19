<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="rlesPlanForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<span class="jte-search-aria"><label>LoT ID : </label></span>
		<input class="k-textbox" id="lotId" readonly/>
		<button class="k-button k-primary" type="button"  onclick="lfn_lotStock('custom');"><spring:message code = "btn_search"/></button>
		<label class="nc-pro-title">부품 명 : </label>
		<input class="k-textbox" id="itemNm" style="width:150px;" readonly/>
		<label class="nc-pro-title">생산 재고량 : </label>
		<input class="k-textbox" id="itemStock" style="width:100px;" readonly/>
	</div>
	<div id="grid-content" class="rlesPlanForm" style="width:100%;">
		<div id="jteSingleGrid" class="rlesPlanForm"></div>
	</div>
</div>

<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="rlesMgtForm">
		<!-- 출고 진행 정보 -->
			<table id="jtePopForm_master" class="jtePopForm_master">
				<colgroup>
					<col style="width: 12%;">
					<col style="width: 15%;">
					<col style="width: 12%;">
					<col style="width: 15%;">
				</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_rlesMgtCd" text = "출고작업코드" /> : </td>
					<td><input type="text" id="rlesMgtId" name="rlesMgtId"  readonly/></td>
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_lotCd" text = "LoT 코드"/> : </td>
					<td><input type="text" id="lotId"  name="lotId" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_itemNm" text = "부품명"/> : </td>
					<td><input id="itemNm" name="itemNm" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemStockQty" text = "생산재고량" />: </td>
					<td><input id="itemStock" name="itemStock" format="numeric" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_releasePlanQty" text = "출고계획수량" />: </td>
					<td><input id="rlesPlanQty" name="rlesPlanQty"  format="numeric"  readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_rlesWorkQty" text = "출고 작업 수량" />: </td>
					<td><input id="rlesMgtQty" name="rlesMgtQty"  format="numeric" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_rlesStartDate" text = "출고 작업 시작"/> : </td>
					<td ><input id="rlesWorkStart" name="rlesWorkStart" format="datetimepicker" style="width:90%" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_rlesEndDate" text = "출고 작업 종료"/> : </td>
					<td><input id="rlesWorkEnd" name="rlesWorkEnd" format="datetimepicker" style="width:90%" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="rlesMgtDesc"  class="center-input" name="rlesMgtDesc" style="width:88%" readonly/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="action"/>
						<input type="hidden" name="rlesPlanState" id="rlesPlanState"/>
						<input type="hidden" name="rlesPlanId" id="rlesPlanId"/>
						<input type="hidden" name="itemId" id="itemId"/>
						<input type="hidden" name="itemMgtId" id="itemMgtId"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>

<link href='/resources/mes/css/contents/ship/rlesMgt/rlesMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

this.lfn_jteSgGrd_setGrd = function(target){
	
	lfo_common = {};//Form 내부에서 사용될 Object 

	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/pick/rlesRecord";

	//4.
	lfo_common.crud  = {
		read:{url:"/getRlesRecordList", auth:"", prmt:{}, dynamicPrmt : {lotId : "lotId" }},
	};
	
	//5.
	lfo_common.model = {
		id: "rlesPlanId",
		fields: {
			rlesPlanId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotId : { type: "string" },
			itemStock : { type: "int" },
			rlesPlanQty : { type: "int" },
			rlesPlanDate : { type: "date" },
			rlesPlanDesc : { type: "string" },
			rlesPlanState : { type: "string" },
			rlesMgrId : { type: "string" },
			rlesWorkStart : { type: "string" },
			rlesWorkEnd : { type: "string" },
			rlesWorker : { type: "string" },
			rlesMgrQty : { type: "int" },
			rlesMgtDesc : { type: "string" }
		}
	};
	lfo_common.customTitle = {
			html:
				'<label class="nc-pro-title">출고 예정 수량 : </label>'+
				'<input class="k-textbox" id="rlesExceptQty" style="width:70px;" readonly/>'+
				'<label class="nc-pro-title">출고 완료 수량 : </label>'+
				'<input class="k-textbox" id="rlesWorkQty" style="width:70px;" readonly/>'
		};
	//6.
	lfo_common.columns = [
		{field: "rlesPlanId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" text = "보기"/>" + '</button>',
			title:gfn_getMsg("btn_update"), width: "90px"},		
		{field: "rlesMgtId", title: gfn_getMsg("col_releaseMgtCd", "출고 작업 코드"), width: "110px"},
		{field: "itemNm", title: gfn_getMsg("col_itemNm", "부품명"), width: "80px"},
		{field: "rlesPlanState",  template:"# var item = gfn_isNull(gfn_getCode(rlesPlanState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(rlesPlanState).cdId , gfn_getCode(rlesPlanState).cdNm) # #= item #",
				title: gfn_getMsg("col_rlesState", "출고 진행 상태"), width: "100px"},
		{field: "rlesPlanQty",  attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_rlesPlanQty", "출고 계획 수량"), width: "95px"},
		{field: "rlesMgtQty",  attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_rlesWorkQty", "출고 작업 수량"), width: "95px"},
		{field: "rlesWorkStart",  format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_rlesStartDate", "작업시작시간"), width: "100px"},
		{field: "rlesWorkEnd",  format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_rlesEndDate", "작업종료시간"), width: "100px"},
		{field: "rlesWorker",  title:gfn_getMsg("col_worker"), width: "120px"}
	
	];
	
	//7.
	lfo_common.selectBox = [
	 	{ text: gfn_getMsg("col_releaseCd", "출고 계획 코드"), value: "rlesPlan.rles_plan_id" }
	];
	
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//출고 계획 팝업 오픈
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "900px", 
		height: "330px",
		id:lfo_common.popId, 
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	if(mode=="EDT"){
		options.title = gfn_getMsg("col_rlesInfo", "출고진행정보");
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);
}

//출고 계획 팝업 셋팅
this.lfn_jtePop_set = function(mode, selectedItem){
	lfo_common.gridSelected = {};
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {rlesPlanId : selectedItem};
			
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {rlesPlanId :lfo_common.gridSelected.rlesPlanId,lotId :lfo_common.gridSelected.lotId },
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}


//LoT별 출고 계획 조회
this.lfn_lotStock = function(mode){
	if(mode == 'custom'){
		var callback = function(selectedItem){
			$('#lotNm').val(selectedItem.lotNm);
			$('#lotId').val(selectedItem.lotId);
			$('#itemNm').val(selectedItem.itemNm);
			$('#itemStock').val(selectedItem.itemStock);
			$('#rlesExceptQty').val(selectedItem.rlesExceptQty);
			$('#rlesWorkQty').val(selectedItem.rlesWorkQty);
			lfo_common.grid.dataSource.read();
		};
		
		gfn_openCustomPop("lotStock", callback);
	} else{
		var callback = function(rtnObj){
			$("#" + lfo_common.popId + " [name=lotId]").val(rtnObj["lotId"]);
			$("#" + lfo_common.popId + " [name=itemNm]").val(rtnObj["itemNm"]);
			$("#" + lfo_common.popId + " [name=itemId]").val(rtnObj["itemId"]);
		}
		gfn_openCustomPop("lotStock", callback);
	} 	
}

</script>