<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

	<div id="grid-content" class="shipMgtForm" style="width:100%;">
		<div id="jteSingleGrid"></div>
	</div>

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
					<td><input type="text" id="shipId" name="shipId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly/></td>
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
					<td><input id="shipPlanDate" name="shipPlanDate" format="datepicker"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipPlanQty" text = "출하 계획 수량" />: </td>
					<td><input id="shipPlanQty" name="shipPlanQty"  format="numeric"  readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipQty" text = "출하 완료 수량" />: </td>
					<td><input id="shipQty" name="shipQty"  format="numeric"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipDate" text = "출하 완료일"/> : </td>
					<td><input id="shipCompleteDate" name="shipCompleteDate" format="datetimepicker" style="width:80%"/></td>
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
						<input type="text" id="compNm" name="compNm" format="text" readonly/> 
						<input type="hidden" id="compId" class="right-input btn-input" name="compId"/>
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
	lfo_common.ctrlUrl = "/form/ship/shipMgt";

	//4.
	lfo_common.crud  = {
			read:{url:"/getShipPlanList", auth:"", prmt:{shipPlanState:"shipSta03"}},
			update:{url:"/setShipSave", auth:"", openFunc : "", callback:lfn_popSave}
	};
	
	//5.
	lfo_common.model = {
		id: "shipPlanId",
		fields: {
			userNm : { type: "string" },
			shipPlanId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotId : { type: "string" },
			itemStock : { type: "int" },
			shipPlanQty : { type: "int" },
			shipPlanDate : { type: "date" },
			shipPlanDesc : { type: "string" },
			shipPlanState : { type: "string" },
			shipCompleteDate : { type: "string" },
			shipTransport : { type: "string" },
			shipQty : { type: "int" },
			shipDesc : { type: "string" }
		}
	};
	 
	//6.
	lfo_common.columns = [
		{field: "shipPlanId", title: gfn_getMsg("mn_ship", "출하"), width:"140px",
			template : function(rows) {
					return '<button class="k-button k-primary" type="button" onclick="lfn_jtePop_open(\'EDT\',this)">출하 진행</button>';
			}
		},
		{field: "shipPlanId", title: gfn_getMsg("col_shipPlanCd", "출하 계획 코드"), width: "110px"},
		{field: "itemNm", title: gfn_getMsg("col_itemNm", "부품명"), width: "80px"},
		{field: "shipPlanState",  template:"# var item = gfn_isNull(gfn_getCode(shipPlanState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(shipPlanState).cdId , gfn_getCode(shipPlanState).cdNm) # #= item #",
				title: gfn_getMsg("col_shipStatus", "출하 진행 상태"), width: "100px"},
		{field: "rlesStockQty", attributes : { style : "text-align : right;"}, title: gfn_getMsg("col_rlesStockQty", "출고완료재고"), width: "90px"},
		{field: "shipPlanQty",  attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_shipPlanQty", "출하 계획 수량"), width: "95px"},
		{field: "shipQty",  attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_shipQty", "출하 완료 수량"), width: "95px"},
		{field: "shipPlanDate",  format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_shipExceptDate", "출하 예정일"), width: "100px"},
		{field: "shipPlanDesc",  title:gfn_getMsg("col_desc"), width: "120px"}
	];
	
	
	//7.
	lfo_common.selectBox = [
	 	{ text: gfn_getMsg("col_itemNm"), value: "itemInfo.item_nm" },			//부품명
		{ text: gfn_getMsg("col_lotCd"), value: "shipPlan.lot_id" }, 			//LoT코드
	];
	
	//8.
	lfo_common.validation ={
		userNm:{
			messages : "출하작업자를 입력하세요",
			rules : function(input){
				if(input.is("[name=userNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		shipTransport:{
			messages : "운송수단을 입력하세요",
			rules : function(input){
				if(input.is("[name=shipTransport]")){
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
		height: "470px",
		id:lfo_common.popId, 
		title:gfn_getMsg("mn_shipMgt", "출하 진행"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
	if(lfo_common.gridSelected.shipQty == 0){
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
	var date = new Date()
	var year = date.getFullYear()
	var month = date.getMonth() + 1
	month = month >= 10 ? month : '0' + month
	var day = date.getDate()
	day = day >= 10 ? day : '0' + day
	var hour = date.getHours()
	hour = hour >= 10 ? hour : '0' + hour
	var min = date.getMinutes()
	var sec = date.getSeconds()
	sec = sec >= 10 ? sec : '0' + sec
	var dateTime = year + '-' + month + '-' + day + ' ' + hour + ':' + min + ':' + sec
	
	lfo_common.gridSelected = {};
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode,selectedItem);
	}else if(mode == "EDT"){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {shipPlanId : selectedItem};
		}
	}	
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {shipPlanId :lfo_common.gridSelected.shipPlanId},
			success: function(data){
				if(lfo_common.gridSelected.shipQty == 0){
					gfn_popform_set(lfo_common, mode,data.rows[0]);
					$("#shipQty").data("kendoNumericTextBox").value($("#shipPlanQty").val());
					$("#jtePopForm #shipPlanState").val(gfn_getCode(lfo_common.gridSelected.shipPlanState).cdNm);
					$("#shipCompleteDate").val(dateTime);
				} else {
					gfn_popform_set(lfo_common, mode,data.rows[0]);
					$("#jtePopForm #shipPlanState").val(gfn_getCode(lfo_common.gridSelected.shipPlanState).cdNm);
					$("#shipCompleteDate").val(dateTime);

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
				}else if(data == "ing"){//계획 수량보다 적은 수량 출하
					gfn_closePop(lfo_common.popId);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg : "입력하신 수량만큼 부분출하가 완료되었습니다."});
				}else if(data == "end"){//계획 수량 이상의 수량으로 출하 완료. 출하 상태가 출하 완료로 변경됨
					gfn_closePop(lfo_common.popId);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg : "해당 출하 계획의 출하가 완료되었습니다."});
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}	
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