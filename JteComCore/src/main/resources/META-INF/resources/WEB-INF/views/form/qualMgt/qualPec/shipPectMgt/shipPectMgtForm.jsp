<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- lot 검색 -->
<div style="width:100%;">
	<div id="lotSearch" class="shipPlanForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<span class="jte-search-aria"><label>LoT ID : </label></span>
		<input class="k-textbox" id="lotId" readonly/>
		<button class="k-button k-primary" type="button"  onclick="lfn_lotStock('custom');"><spring:message code = "btn_search"/></button>
		<label class="nc-pro-title">부품 명 : </label>
		<input class="k-textbox" id="itemNm" style="width:150px;" readonly/>
		<label class="nc-pro-title">LoT 수량 : </label>
		<input class="k-textbox" id="lotQty" style="width:150px;" readonly/>
		<label class="nc-pro-title">출하 완료 수량 : </label>
		<input class="k-textbox" id="shipEndQty" style="width:100px;" readonly/>
		<input type="hidden" name="itemId" id="itemId"/>
	</div>
	<div id="grid-content" class="shipPlanForm" style="width:100%;">
		<div id="jteSingleGrid" class="shipPlanForm"></div>
	</div>
</div>

<!-- 체크리스트 -->
<div style="display: none;">
	<div id="pop_shipInspect">
		<form id="pop_shipInspect_form" class="pop_shipInspect_Form">
			<table id="pop_shipInspect_form_tb" style="width: 94%;" class="shipPectMgtForm-table" style="display:none;">
				<colgroup>
					<col class='col-input-list-1'>
					<col class='col-input-list-2'>
					<col class='col-input-list-3'>
				</colgroup>
				<tr	class="shipPectMgtForm input-list pop_selfInspect_Form_title" >
					<td>No</td>
					<td><spring:message code="col_mtrlOdcursitItem" text = "항목"/></td>
					<td><spring:message code="col_valueInput" text = "입력"/></td>
				</tr>
			</table>
			<div class="shipPectMgtForm final-btn-area" style="text-align: center;" id="pop_shipInspectBtn"></div>
		</form>
	</div>
</div>


<!-- 출하정보 -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="shipMgtForm">
		<!-- 출하 진행 정보 -->
			<table style="width:95%;" id="jtePopForm_master" class="jtePopForm_master">
				<colgroup>
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-title">
					<col class="col-right-content">
				</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipCd" text = "출하코드" /> : </td>
					<td><input type="text" id="shipId" name="shipId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipStatus" text = "출하상태" /> : </td>
					<td><input type="text" id="shipPlanState" name="shipPlanState"  readonly/></td>
				</tr>
				<tr><td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_lotCd" text = "LoT 코드"/> : </td>
					<td><input type="text" id="lotId"  name="lotId" readonly/></td>
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_itemNm" text = "부품명"/> : </td>
					<td><input id="itemNm" name="itemNm" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_rlesStockQty" text = "출고 완료 재고" />: </td>
					<td><input id="rlesStockQty" name="rlesStockQty" format="numeric" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipExceptDate" text = "출하예정일"/> : </td>
					<td><input id="shipPlanDate" name="shipPlanDate" format="datepicker" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipPlanQty" text = "출하 계획 수량" />: </td>
					<td><input id="shipPlanQty" name="shipPlanQty"  format="numeric"  readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipQty" text = "출하 완료 수량" />: </td>
					<td><input id="shipQty" name="shipQty"  format="numeric" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipDate" text = "출하 완료일"/> : </td>
					<td><input id="shipCompleteDate" name="shipCompleteDate" format="datetimepicker" style="width:80%" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipWorker" text = "출하 작업자"/> : </td>
					<td>
						<input type="text" id="userNm"  name="userNm" readonly/>
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
						<spring:message code="btn_search" text = "조회"/></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_compNm" text="업체명" /> :  </td>
					<td>
						<input type="text" id="compNm" class="right-input btn-input" name="compNm" format="text" readonly/> 
						<input type="hidden" id="compId" class="right-input btn-input" name="compId"/>
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_supplierPop_Open()">
						<spring:message code="btn_search" /></button>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "" text = "운송수단"/> : </td>
					<td><input id="shipTransport" name="shipTransport" format="selBox" msg="ship_transport" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="shipDesc"  class="center-input" name="shipDesc" readonly/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="action"/>
						<input type="hidden" name="shipPlanId" id="rlesPlanId"/>
						<input type="hidden" name="itemId" id="itemId"/>
						<input type="hidden" name="lotState" id="lotState"/>
						<input type="hidden" name="shipWorker" id="shipWorker"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소" /></button>
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/ship/rlesMgt/rlesMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

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
	lfo_common.ctrlUrl = "/form/ship/shipMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/getShipPlanList", auth:"", prmt:{shipPlanState: "shipSta01"}, dynamicPrmt : {lotId : "lotId" }}
	};
	
	//5.
	lfo_common.model = {
		id: "shipPlanId",
		fields: {
			shipPlanId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotId : { type: "string" },
			itemStock : { type: "int" },
			shipId : { type: "string" },
			shipPlanQty : { type: "int" },
			shipPlanDate : { type: "date" },
			shipPlanDesc : { type: "string" },
			shipPlanState : { type: "string" },
			shipCompleteDate : { type: "string" },
			shipQty : { type: "int" },
			shipInspect : { type: "string" },
			shipDesc : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "shipId", title: "검사항목", width: "150px",
			template : function(rows){
				if (rows.shipInspect == 'shipInspectWait'){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "출하정보" + '</button>'+'<button class="k-button k-primary" type="button" onclick = "lfn_inspectPop(\'NEW\', this) " style="width:80px;">'+ "<spring:message code = "col_checkList" />" +'</button>';					//내역보기
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "출하정보" + '</button>'+'<button class="k-button k-primary" type="button" onclick = "lfn_inspectPop(\'EDT\', this) " style="width:80px;">'+ "<spring:message code = "col_checkList" />" +'</button>';					//내역보기
				}
				
			}
		},
		{field: "shipInspect", title:gfn_getMsg("col_inspectState"), width: "90px;",
			template:
				function(rows){
				if (rows.shipInspect == 'shipInspectWait'){
					return '<span style="color:red">'+gfn_getMsg("bc_"+ gfn_getCode(rows.shipInspect).cdId , gfn_getCode(rows.shipInspect).cdNm)+'</span>';
				}else{
					return '<span style="color:blue">'+gfn_getMsg("bc_"+ gfn_getCode(rows.shipInspect).cdId , gfn_getCode(rows.shipInspect).cdNm)+'</span>';					//내역보기
				}
				
			}
		},	
		{field: "shipId", title: gfn_getMsg("col_shipCd", "출하 코드"), width: "130px"},
		{field: "shipPlanQty",  title:gfn_getMsg("col_shipPlanQty", "출하 계획 수량"), width: "110px"},
		{field: "shipQty",  title:gfn_getMsg("col_shipQty", "출하 완료 수량"), width: "110px"},
		{field: "shipPlanState",  template:"# var item = gfn_isNull(gfn_getCode(shipPlanState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(shipPlanState).cdId , gfn_getCode(shipPlanState).cdNm) # #= item #",
			title: gfn_getMsg("col_shipStatus", "출하 진행 상태"), width: "100px"},
		{field: "shipCompleteDate",  format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_shipDate", "출하 완료일"), width: "120px"},
		{field: "shipPlanDesc",  title:gfn_getMsg("col_desc"), width: "220px"}		
	];
	
	//7.
	lfo_common.selectBox = [
	 	{ text: gfn_getMsg("col_releaseCd", "출하 계획 코드"), value: "shipPlan.ship_plan_id" }
	];
	
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//출하 정보 팝업 오픈
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "900px", 
		height: "470px",
		id:lfo_common.popId,
		title:"출하 정보",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);
}

//출하 정보 팝업 셋팅
this.lfn_jtePop_set = function(mode, selectedItem){
	lfo_common.gridSelected = {};
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
		$("#jtePopForm #lotId").val($("#lotSearch #lotId").val());
		$("#jtePopForm #itemId").val($("#lotSearch #itemId").val());
		$("#jtePopForm #itemNm").val($("#lotSearch #itemNm").val());
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {shipPlanId : selectedItem};
			
		}

		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {shipPlanId :lfo_common.gridSelected.shipPlanId,lotId :lfo_common.gridSelected.lotId },
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
				$("#jtePopForm #shipPlanState").val(gfn_getCode(lfo_common.gridSelected.shipPlanState).cdNm);
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}



//LoT별 출하 계획 조회
this.lfn_lotStock = function(mode){
	if(mode == 'custom'){
		var callback = function(selectedItem){
			$('#lotNm').val(selectedItem.lotNm);
			$('#lotId').val(selectedItem.lotId);
			$('#lotQty').val(selectedItem.lotQty);
			$('#itemNm').val(selectedItem.itemNm);
			$('#itemId').val(selectedItem.itemId);
			$('#shipEndQty').val(selectedItem.shipEndQty);
			lfo_common.grid.dataSource.read();
		};
		
		gfn_openCustomPop("lotStock", callback);
	}	
}

//출하검사 체크리스트 팝업 
this.lfn_inspectPop = function(mode, selectedItem) {
	
	lfo_inspect = {};
	
	//2.
	lfo_inspect.popId = "pop_shipInspect";
	
	//3.
	lfo_inspect.ctrlUrl = "/form/qualMgt/qualCheckList"
	
	//4.
	lfo_inspect.crud  = {
		read:{url:"/selectCheckList", auth:"", prmt:{} }, 
		create:{url:"/insertCheckList", auth:"", openFunc: "", callback: lfn_inspectPop_save}, 
		update:{url:"/updateCheckList", auth:"", openFunc: "", callback : lfn_inspectPop_save}
	};
	var option = {
			width: "760px", 
			height: "400px",
			id: lfo_inspect.popId, 
			resizable:false,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"],
			baseGroupCode: "ship_checkList",
			category: "ship_inspect",
			title: "출하검사"
			
	};
	
	$.each(gfn_getCode(option.baseGroupCode), function(index, item) {
		$("#pop_shipInspect_form_tb").append("<tr id=" + item.cdId + ">" +
				"<td class='shipPectMgtForm-index'>" + (index+1) + "</td>" +
				"<td>" + item.cdNm + "</td>" +
				"<td><input class='k-textbox center-input' name='questionValue' type='text' \></td>" +
				"</tr>");
	});
	

	//팝업이 생성된 뒤 동작해야할 함수 입력
	option.callback = function(){
		lfn_inspectPop_set(mode, selectedItem);
	};
	this.gfn_winOpen(option);
}

//체크리스트 팝업 셋팅
this.lfn_inspectPop_set = function(mode, selectedItem){

	 lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));

	 if(mode == 'NEW'){
		 $("#pop_shipInspectBtn").append(
					"<button class='k-button k-primary final-btn' type='button' onclick = "+"lfn_inspectPop_save('NEW')>"+"<spring:message code = 'pop_save'/>"+"</button>"+
	 				"<button class='k-button k-primary final-btn' type='button' onclick = "+"gfn_closePop('pop_shipInspect')>"+"<spring:message code = 'pop_cancel'/>"+"</button>"
		 );
		 $.ajax({
	 			async:false,
	 			url : lfo_inspect.ctrlUrl + lfo_inspect.crud.read.url,
	 			type: "POST",
	 			data: {targetId: lfo_common.gridSelected.shipId},
	 			success: function(data){
	 				gfn_popform_set(lfo_common, mode, data.rows[0]);
	 			}, error: function(ex){
	 				gfn_loading(false);
	 				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
	 			}
	 		});
	 }else if (mode == 'EDT'){
		 $("#pop_shipInspectBtn").append(
	 				"<button class='k-button k-primary final-btn' type='button' onclick = "+"lfn_inspectPop_save('EDT')>"+"<spring:message code = 'pop_save'/>"+"</button>"+
	 				"<button class='k-button k-primary final-btn' type='button' onclick = "+"gfn_closePop('pop_shipInspect')>"+"<spring:message code = 'pop_cancel'/>"+"</button>"
		 );
		 $.ajax({
	 			async:false,
	 			url : lfo_inspect.ctrlUrl + lfo_inspect.crud.read.url,
	 			type: "POST",
	 			data: {targetId: lfo_common.gridSelected.shipId},
	 			traditional :true,
	 			success: function(data){
	 				$.each(data.rows, function(index, item) {
	 					$('#' + item.questionId).find('[name=questionValue]').val(item.questionValue);
	 				})
	 				gfn_popform_set(lfo_common, mode, data.rows[0]);
	 			}, error: function(ex){
	 				gfn_loading(false);
	 				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
	 			}
	 		});		 
	 }

}

//체크리스트 저장
this.lfn_inspectPop_save = function(mode){

	var insertInspectList = new Array();
	var updateInspectList = new Array();
	var svcUrl = lfo_inspect.ctrlUrl;
	var savePrmt = {};
	
	if(mode == "NEW") {
		$("#pop_shipInspect_form_tb").find('tr').each(function(index, item) {
			if(index == 0) {
				return true
			}
			insertInspectList.push({ questionId: $(item).attr('id'), questionValue: $(item).find('input').val(), targetId: lfo_common.gridSelected.shipId , category: "ship_inspect"});
		});
		svcUrl += "/insertCheckList";
		savePrmt.insertInspectList = insertInspectList;
		savePrmt.currentMenuId = gfn_serializeObject().currentMenuId;
		savePrmt.targetId = lfo_common.gridSelected.shipId;
	} else if(mode == "EDT") {
		$("#pop_shipInspect_form_tb").find('tr').each(function(index, item) {
			if(index == 0) {
				return true
			}
			updateInspectList.push({ questionId: $(item).attr('id'), questionValue: $(item).find('input').val(), targetId: lfo_common.gridSelected.shipId});
		});
		svcUrl += "/updateCheckList";
		savePrmt.updateInspectList = updateInspectList;
	}
	
	$.ajax({
		async:false,
		url : svcUrl,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			gfn_closePop(lfo_inspect.popId);
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

</script>