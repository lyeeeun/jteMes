<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div id="lotSearch" class="shipPlanForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<span class="jte-search-aria"><label>LoT ID : </label></span>
		<input class="k-textbox" id="lotId" readonly/>
		<button class="k-button k-primary" type="button"  onclick="lfn_searchPopOpen();"><spring:message code = "btn_search"/></button>
		<span class="jte-search-aria"><label>LoT명 : </label></span>
		<input class="k-textbox" id="lotNm" readonly/>
		<label class="nc-pro-title">부품 명 : </label>
		<input class="k-textbox" id="itemNm" style="width:150px;" readonly/>
		<label class="nc-pro-title">LoT 수량 : </label>
		<input class="k-textbox" id="lotQty" style="width:120px;" readonly/>
		<input type="hidden" name="itemId" id="itemId"/>
	</div>

	<div id="grid-content" class="shipMgtForm" style="width:100%;">
		<div id="jteSingleGrid"></div>
	</div>

</div>

<!-- LoT 선택 커스텀 팝업 -->
<div id="lotInfoPop">
	<div id="lotInfo_grid"></div>
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
					<td><spring:message code="col_checkReturn" text = "체크"/></td>
				</tr>
			</table>
			<div class="shipPectMgtForm final-btn-area" style="text-align: center;" id="pop_shipInspectBtn"></div>
			<div style ="float:right; padding-right:20px;" id="allCheckBtn">
				<input type='checkbox' id='allCheck' name='allCheck' class='k-checkbox config-checkbox'>&nbsp<spring:message code ='col_allCheck'></spring:message>	
			</div>
		</form>
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
	lfo_common.ctrlUrl = "/cform/ship/shipPlanMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/getShipPlanList", auth:"", prmt:"", dynamicPrmt : {lotId : "lotId" }}
	};
	
	//5.
	lfo_common.model = {
		id: "shipPlanId",
		fields: {
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotId : { type: "string" },
			shipPlanId : { type: "string" },
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
		{field: "shipPlanId", title: "검사항목", width: "150px",
			template : function(rows){
				if (rows.shipInspect == 'shipInspectWait'){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_inspectPop(\'NEW\', this) " style="width:80px;">'+ "<spring:message code = "col_checkList" />" +'</button>';					//내역보기
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_inspectPop(\'EDT\', this) " style="width:80px;">'+ "<spring:message code = "col_checkList" />" +'</button>';					//내역보기
				}
				
			}
		},
		{field: "shipInspect", title:gfn_getMsg("col_inspectState"), width: "90px;",
			template:
				function(rows){
				if (rows.shipInspect == 'shipInspectEnd'){
					return '<span style="color:blue">'+gfn_getMsg("bc_"+ gfn_getCode(rows.shipInspect).cdId , gfn_getCode(rows.shipInspect).cdNm)+'</span>';
				}else{
					return '<span style="color:red">'+gfn_getMsg("bc_"+ gfn_getCode(rows.shipInspect).cdId , gfn_getCode(rows.shipInspect).cdNm)+'</span>';					//내역보기
				}
				
			}
		},	
		{field: "shipPlanId", title: gfn_getMsg("col_shipPlanCd", "출하 계획 코드"), width: "100px"},
		{field: "shipPlanQty",  title:gfn_getMsg("col_shipPlanQty", "출하 계획 수량"), width: "120px"},
		{field: "shipPlanState",  template:"# var item = gfn_isNull(gfn_getCode(shipPlanState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(shipPlanState).cdId , gfn_getCode(shipPlanState).cdNm) # #= item #",
			title: gfn_getMsg("col_shipStatus", "출하 진행 상태"), width: "100px"},
		{field: "shipPlanDate",  format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_shipExceptDate", "출하 예정일"), width: "120px"},
		{field: "shipPlanDesc",  title:gfn_getMsg("col_desc"), width: "220px"}		
	];
	
	//7.
	lfo_common.selectBox = [
	 	{ text: gfn_getMsg("col_releaseCd", "출하 계획 코드"), value: "shipPlan.ship_plan_id" }
	];
	
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}



//LoT 조회 팝업 오픈
this.lfn_searchPopOpen = function() {
		
	var options = {
			modal:true, 
			width: "1250px", 
			height: "470px",
			id:"lotInfoPop", 
			title:"LoT 정보",	
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:["Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			$("#lotInfo_grid").empty();
			
			lfn_jtePopGrd_setGrd();
			$('#lotInfo_grid').parent().css('height', '100%');
		};
		this.gfn_winOpen(options);
}

//LoT 조회 팝업 그리드 세팅
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
	
	lfo_popGrd.layoutId = "lotInfo_grid";
	
	lfo_popGrd.ctrlUrl = "/cform/orderMgt/orderDetailMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getLotList", auth:"", prmt:{}, dynamicPrmt : {orderId : "orderId"}}, 
	};
	
	//5.
	lfo_popGrd.model = {
		id: "lotSeq",
		fields: {
			lotSeq : { type: "int" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			lotCode : { type: "string" },
			lotType : { type: "string" },
			lotQty : { type: "int" },
			lotMtrlCost : { type: "int" },
			lotMtrlCostAfter : { type: "int" },
			lotPersonCost : { type: "int" },
			lotPersonCostAfter : { type: "int" },
			lotPm : { type: "string" },
			lotPmNm : { type: "string" },
			lotState : { type: "string" },
			lotDesc : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			updatedAt : { type: "date" },
			updatorId : { type: "string" },
			itemId : { type: "string" },
			cliamId : { type: "string" },
			orderId : { type: "string" },
			itemNm: { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{field: "lotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_searchPop_callback(this);" style="min-width:60px;">' + "<spring:message code = "btn_select"/>" + '</button>',
			title:"선택", width: 90},	
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},				//Lot코드
		{field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "220px;"},			//Lot명			
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px;"},				//부품명
		{field: "lotQty", title:gfn_getMsg("col_lotQty"), width: "120px;"},				//Lot수량
		{field: "lotType",  template:"# var item = gfn_isNull(lotType)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotType).cdId , gfn_getCode(lotType).cdNm) # #= item #", 
			title:gfn_getMsg("col_orderType"), width: "120px;"},							//수주유형
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title:gfn_getMsg("col_orderStatus"), width: "120px;"}			
	];
	
	lfo_popGrd.customTitle = {
		html: '<button class="k-button k-primary" type="button" onclick = "lfn_lotOrder(\'all\');" style="min-width:60px;">전체 검색</button> &nbsp; <button class="k-button k-primary" type="button" onclick = "lfn_lotOrder(\'order\');" style="min-width:60px;">수주 검색</button>' +
		'<input class="k-textbox" id="orderNm" readonly/><input type="hidden" id="orderId" /> '
	};
	
	
	//7.
	lfo_popGrd.selectBox = [ 
		{ text: gfn_getMsg("col_lotCd"), value: "lot.lot_id" },				//Lot코드
		{ text: gfn_getMsg("col_lotWrkNm"), value: "lot.lot_nm" },			//Lot명
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" }			//부품명
	];
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
//수주별 LoT 조회
this.lfn_lotOrder = function(mode){
	
	if(mode == 'order') {
		var callback = function(selectedItem){
			$('#orderNm').val(selectedItem.orderNm);
			$('#orderId').val(selectedItem.orderId);
			
			lfo_popGrd.grid.dataSource.read();
		};
		
		gfn_openCustomPop("orderInfo", callback);
	} else {
		$('#orderNm').val(null);
		$('#orderId').val(null);
		
		lfo_popGrd.grid.dataSource.read();
	}	
}

//LoT정보 콜백
this.lfn_searchPop_callback = function(selectedItems){
	
	var selectedItem = lfo_popGrd.grid.dataItem($(selectedItems).closest('tr'));
	
	$('#lotNm').val(selectedItem.lotNm);
	$('#lotId').val(selectedItem.lotId);
	$('#lotQty').val(selectedItem.lotQty);
	$('#itemNm').val(selectedItem.itemNm);
	$('#itemId').val(selectedItem.itemId);
	
	lfo_common.grid.dataSource.read();
	gfn_closePop("lotInfoPop");
	
	
}

//출하검사 체크리스트 팝업 
this.lfn_inspectPop = function(mode, selectedItem) {
	
	lfo_inspect = {};
	
	//2.
	lfo_inspect.popId = "pop_shipInspect";
	
	//3.
	lfo_inspect.ctrlUrl = "/cform/qualMgt/qualCheckList"
	
	//4.
	lfo_inspect.crud  = {
		read:{url:"/selectCheckList", auth:"", prmt:{} }, 
		create:{url:"/insertCheckList", auth:"", openFunc: "", callback: lfn_inspectPop_save}, 
		update:{url:"/updateCheckList", auth:"", openFunc: "", callback : lfn_inspectPop_save}
	};
	var option = {
			width: "660px", 
			height: "360px",
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
				"<td><input class='k-checkbox' name='questionValue' type='checkbox' value = '' \></td>" +
				"</tr>");
		lfn_check_event(item.cdId);
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
	 			data: {targetId: lfo_common.gridSelected.shipPlanId},
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
	 			data: {targetId: lfo_common.gridSelected.shipPlanId},
	 			traditional :true,
	 			success: function(data){	
	 				$.each(data.rows, function(index, item) {
	 					$('#' + item.questionId).find('[name=questionValue]').val(item.questionValue);
	 					if(item.questionValue == "check"){
	 						$('#' + item.questionId).find('[name=questionValue]').prop('checked',true);
	 					}
	 					lfn_check_event(item.questionId);
	 				})
	 				gfn_popform_set(lfo_common, mode, data.rows[0]);
	 			}, error: function(ex){
	 				gfn_loading(false);
	 				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
	 			}
	 		});		 
	 }
	 
	 $(document).ready(function() { 
			$("#allCheck").on('click', function() { //전부 체크 클릭시
				if($("input:checkbox[name=questionValue]:checked").length == $("input:checkbox[name=questionValue]").length){
					$("input[name=questionValue]:checkbox").prop("checked", false);  
				}else {
					 $("input[name=questionValue]:checkbox").prop("checked", true);  
				}
			});
		});

}

//체크리스트 선택시 value값 지정
this.lfn_check_event = function(chkId){
	$('#' + chkId).find('[name=questionValue]').click(function(e){
		if($('#' + chkId).find('[name=questionValue]').is(":checked")){
			$('#' + chkId).find('[name=questionValue]').val("check")
		}else{
			$('#' + chkId).find('[name=questionValue]').val("")
		}
	}); 
}

//체크리스트 저장
this.lfn_inspectPop_save = function(mode){

	var insertInspectList = new Array();
	var updateInspectList = new Array();
	var svcUrl = lfo_inspect.ctrlUrl;
	var savePrmt = {};
	//if()
	if(mode == "NEW") {
		$("#pop_shipInspect_form_tb").find('tr').each(function(index, item) {
			if(index == 0) {
				return true
			}
			insertInspectList.push({ questionId: $(item).attr('id'), questionValue: $(item).find('input').val(), targetId: lfo_common.gridSelected.shipPlanId , category: "ship_inspect"});
		});
		svcUrl += "/insertCheckList";
		savePrmt.insertInspectList = insertInspectList;
		savePrmt.currentMenuId = gfn_serializeObject().currentMenuId;
		savePrmt.targetId = lfo_common.gridSelected.shipPlanId;
	} else if(mode == "EDT") {
		$("#pop_shipInspect_form_tb").find('tr').each(function(index, item) {
			if(index == 0) {
				return true
			}
			updateInspectList.push({ questionId: $(item).attr('id'), questionValue: $(item).find('input').val(), targetId: lfo_common.gridSelected.shipPlanId});
		});
		svcUrl += "/updateCheckList";
		savePrmt.updateInspectList = updateInspectList;
		savePrmt.currentMenuId = gfn_serializeObject().currentMenuId;
		savePrmt.targetId = lfo_common.gridSelected.shipPlanId;
	}
	if($("input:checkbox[name=questionValue]:checked").length == $("input:checkbox[name=questionValue]").length){
		savePrmt.shipInspect = "shipInspectEnd";
	} else {
		savePrmt.shipInspect = "shipInspectHolding";
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