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
		<form id="jtePopForm_form" class="shipMgtForm">
		<!-- 출하 진행 정보 -->
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
				<colgroup>
				<col style="width:20%;">
				<col style="width:30%;">
				<col style="width:20%;">
				<col style="width:30%;">
				</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipCd" text = "출하코드" /> : </td>
					<td><input type="text" id="shipId" name="shipId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipStatus" text = "출하상태" /> : </td>
					<td><input type="text" id="shipPlanState" name="shipPlanState"  readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_itemNm" text = "부품명"/> : </td>
					<td><input id="itemNm" name="itemNm" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_compNm" text="업체명" /> :  </td>
					<td>
						<input type="text" id="compNm" name="compNm" format="text" readonly/> 
						<input type="hidden" id="compId" class="right-input btn-input" name="compId"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipExceptDate" text = "출하예정일"/> : </td>
					<td><input id="shipPlanDate" name="shipPlanDate" format="datepicker"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipPlanQty" text = "출하 계획 수량" />: </td>
					<td><input id="shipPlanQty" name="shipPlanQty"  format="numeric"  readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipDate" text = "출하 완료일"/> : </td>
					<td><input id="shipCompleteDate" name="shipCompleteDate" format="datetimepicker" style="width:80%"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipQty" text = "출하 완료 수량" />: </td>
					<td><input id="shipQty" name="shipQty"  format="numeric"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipWorker" text = "출하 작업자"/> : </td>
					<td>
						<input type="text" id="userNm"  name="userNm" readonly/>
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
						<spring:message code="btn_search" text = "조회"/></button>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "" text = "운송수단"/> : </td>
					<td><input id="shipTransport" name="shipTransport" format="selBox" msg="ship_transport" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="shipDesc"  class="center-input" name="shipDesc" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="action"/>
						<input type="hidden" name="shipPlanId" id="rlesPlanId"/>
						<input type="hidden" name="itemId" id="itemId"/>
						<input type="hidden" name="lotState" id="lotState"/>
						<input type="hidden" name="shipWorker" id="shipWorker"/>
						<input type="hidden" name="lotId" id="lotId"/>
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
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/ship/shipMgt";

	//4.
	lfo_common.crud  = {
			read:{url:"/getShipPlanList", auth:"", prmt:{}, dynamicPrmt: {lotId: "lotId"}},
			create:{url:"/setShipSave", auth:"", openFunc : lfn_jtePop_open, callback: lfn_popSave},
			update:{url:"/setShipSave", auth:"", openFunc : "", callback: lfn_popSave}
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
			shipPlanQty : { type: "int" },
			shipPlanDate : { type: "date" },
			shipPlanDesc : { type: "string" },
			shipPlanState : { type: "string" },
			shipInspect : { type: "string" },
			shipCompleteDate : { type: "string" },
			shipTransport : { type: "string" },
			shipDelivery : { type: "string" },
			shipQty : { type: "int" },
			shipDesc : { type: "string" }
		}
	};
	 
	//6.
	lfo_common.columns = [
		{field: "shipPlanId", title: gfn_getMsg("mn_ship", "출하"), width:"120px",
			template : function(rows) {
				if(rows.shipPlanState == 'shipSta01'){
					return '<button class="k-button k-primary" type="button" onclick="lfn_jtePop_open(\'NEW\',this)">출하 진행</button>'
				}else if (rows.shipPlanState == 'shipSta02'){
					return '<button class="k-button k-primary" style = "float: center" type="button" onclick="lfn_jtePop_open(\'EDT\',this)">출하 정보</button>'
				}else{
					return "";
				}
			}
		},
		{field: "shipPlanId", title: gfn_getMsg("col_shipPlanCd", "출하 계획 코드"), width: "150px"},
		{field: "itemNm", title: gfn_getMsg("col_itemNm", "부품명"), width: "100px"},
		{field: "shipPlanState", title: gfn_getMsg("col_shipStatus", "출하 진행 상태"), width: "120px", 
			template:
				function(rows){ 
					if (rows.shipPlanState == 'shipSta01'){
						return '<span style="color:red">'+gfn_getMsg("bc_"+ gfn_getCode(rows.shipPlanState).cdId , gfn_getCode(rows.shipPlanState).cdNm)+'</span>';
							}else{
						return '<span style="color:blue">'+gfn_getMsg("bc_"+ gfn_getCode(rows.shipPlanState).cdId , gfn_getCode(rows.shipPlanState).cdNm)+'</span>';					//내역보기
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
		{field: "shipPlanQty",  attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_shipPlanQty", "출하 계획 수량"), width: "100px"},
		{field: "shipQty",  attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_shipQty", "출하 완료 수량"), width: "100px"},
		{field: "shipPlanDate",  format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_shipExceptDate", "출하 예정일"), width: "100px"},
		{field: "shipPlanDesc",  title:gfn_getMsg("col_desc"), width: "150px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_releaseCd", "출하 계획 코드"), value: "shipPlan.ship_plan_id" }
	];
	//8.
	lfo_common.validation ={
			shipWorker:{
				messages : "출하작업자를 입력하세요",
				rules : function(input){
					if(input.is("[name=shipWorker]")){
						return input.val().length != 0 && input.val().trim().length != "";
					}
					return true;
				}
			}
		}
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//출하 작업 팝업 오픈(출고 작업 시작 후 출고 작업 종료 버튼 클릭)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "900px", 
		height: "440px",
		id:lfo_common.popId, 
		title:gfn_getMsg("mn_shipMgt", "출하 진행"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
	if(mode=="NEW"){
		options.title = gfn_getMsg("col_shipRegist", "출하 정보 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("col_shipUpdate", "출하 정보 수정");
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode,selectedItem);
	};
	this.gfn_winOpen(options);
	
}

//출하 작업 팝업 셋팅
this.lfn_jtePop_set = function(mode, selectedItem){
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	month = month >= 10 ? month : '0' + month;
	var day = date.getDate();
	day = day >= 10 ? day : '0' + day;
	var hour = date.getHours();
	hour = hour >= 10 ? hour : '0' + hour;
	var min = date.getMinutes();
	var sec = date.getSeconds();
	sec = sec >= 10 ? sec : '0' + sec;
	var dateTime = year + '-' + month + '-' + day + ' ' + hour + ':' + min + ':' + sec;
	
	lfo_common.gridSelected = {};
	if(mode=='NEW'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {shipId : selectedItem};
		}
		
	}else if(mode == "EDT"){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {shipId : selectedItem};
		}
	}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {shipPlanId :lfo_common.gridSelected.shipPlanId},
			success: function(data){
				if(lfo_common.gridSelected.shipInspect == "shipInspectWait")	{
					gfn_closePop(lfo_common.popId);	
					gfn_msgBox({msg : "출하 검사 완료 후 출하 정보 등록이 가능합니다."});
				} else {
					gfn_popform_set(lfo_common, mode,data.rows[0]);
					if(lfo_common.gridSelected.shipPlanState =="shipSta01" && lfo_common.gridSelected.shipInspect == "shipInspectEnd"){
						$("#shipCompleteDate").val(dateTime);
						$("#shipQty").data("kendoNumericTextBox").value($("#shipPlanQty").val());
					}
						$("#jtePopForm #lotId").val($("#lotSearch #lotId").val());
						$("#jtePopForm #shipPlanState").val(gfn_getCode(lfo_common.gridSelected.shipPlanState).cdNm);	
					
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
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
				if(data == ""){//에러
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다.")});
				}else {
					gfn_closePop(lfo_common.popId);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg : gfn_getMsg("pop_successSave", "성공적으로 저장되었습니다.")});
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}	
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

//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

//pop - 수령확인 완료정보 유저 팝업 콜백
this.lfn_userInfoPop_callback = function(rtnObj){
	$("#" + lfo_common.popId + " [name=shipWorker]").val(rtnObj["userId"]);
	$("#" + lfo_common.popId + " [name=userNm]").val(rtnObj["userNm"]);
}


</script>