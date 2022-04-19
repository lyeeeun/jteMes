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

<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="shipPlanForm">
		<!-- 출하 계획 정보 -->
			<table id="jtePopForm_master" class="jtePopForm_master">
				<colgroup>
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-title">
					<col class="col-right-content">
				</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipPlanCd" text = "출하계획코드" /> : </td>
					<td><input type="text" id="shipPlanId" name="shipPlanId" placeholder="<spring:message code = "pop_autoInput" text = "자동 입력"/>" readonly/></td>
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_lotCd" text = "LoT 코드"/> : </td>
					<td>
						<input type="text" id="lotId"  name="lotId" readonly/>
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_searchPopOpen();">
						<spring:message code="btn_search" text = "조회"/></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemCd" text = "부품코드" />: </td>
					<td><input type="text" id="itemId"  name="itemId"  readonly/></td>
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_itemNm" text = "부품명"/> : </td>
					<td><input id="itemNm" name="itemNm" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipPlanQty" text = "출하계획수량" />: </td>
					<td><input id="shipPlanQty" class="left-input btn-input" name="shipPlanQty"  format="numeric" /></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipExceptDate" text = "출하예정일"/> : </td>
					<td><input id="shipPlanDate" name="shipPlanDate" format="datepicker"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="shipPlanDesc" class="center-input" name="shipPlanDesc"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="action"/>
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
	lfo_common.ctrlUrl = "/cform/ship/shipPlanMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/getShipPlanList", auth:"", prmt:"", dynamicPrmt : {lotId : "lotId" }},
		create:{url:"/setShipPlanSave", auth:"", openFunc : lfn_jtePop_open, callback:lfn_popSave},
		update:{url:"/setShipPlanSave", auth:"", openFunc : "", callback:lfn_popSave},
		destroy:{url:"/setShipPlanDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "shipPlanId",
		fields: {
			shipPlanId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotId : { type: "string" },
			shipPlanQty : { type: "int" },
			shipPlanDate : { type: "date" },
			shipPlanDesc : { type: "string" },
			shipPlanState : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"30px"},
		{field: "shipPlanId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" text = "보기"/>" + '</button>',
			title:gfn_getMsg("btn_update"), width: "50px"},		
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

//출하 계획 팝업 오픈
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px", 
		height: "330px",
		id:lfo_common.popId, 
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_shipPlanRegist", "출하계획등록");			
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_shipPlanInfo", "출하계획수정");
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);
}

//출하 계획 팝업 셋팅
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
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		var formId = lfo_common.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);
		
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
					gfn_closePop(lfo_common.popId);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
				}
			},error : function(ex){
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
			if(data == "shipping"){ //진행중인 출하계획
				gfn_warnBox({title : "경고", msg:"출하가 이미 시작되었습니다."});
			}else if( data == "error"){ //에러
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}else if(data == "success"){ //성공
				lfo_common.grid.dataSource.read();
				gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});	
			}
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.", "오류가 발생했습니다.")});
		}
	});
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

</script>