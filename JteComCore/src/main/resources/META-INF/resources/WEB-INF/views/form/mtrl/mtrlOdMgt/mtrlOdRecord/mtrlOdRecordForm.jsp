<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="mtrlOdcursitMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrlOdcursitMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrlOdcursitMgtForm">
			<div class="pop_title"><spring:message code = "col_mtrlOrderDoc" text = "발주주문서" /></div>
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup> <!-- 13 27 13 27 -->
				<col style="width: 24%;">
				<col style="width: 29%;">
				<col style="width: 18%;">
				<col style="width: 29%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDocCd" text = "발주주문코드" /> : </td>
					<td><input type="text" id="mtrlOfId" name="mtrlOfId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly/></td>			<!-- 자동입력 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderStatus" text = "발주상태" /> : </td>
					<td><input id="mtrlOfState" name="mtrlOfState"  format = "selBox" msg="mtrl_sta" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDocNm" text = "발주명" /> : </td>
					<td colspan="3">
						<input type="text" id="mtrlOfNm" name="mtrlOfNm" readonly/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_totalMtrlCost" text = "총 자재비용" /> 
					<i class="fas fa-info-circle" title="<spring:message code = "pop_DeliveryMtrlCost" text = "배송비+자재비용" />"></i> : </td>
					<td>
						<input id="mtrlOfCost" name="mtrlOfCost" format="currency" readonly/>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDate" text = "발주일" /> : </td>
					<td>
						<input id="mtrlOfDate" name="mtrlOfDate" format="datepicker" readonly/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명" /> : </td>
					<td colspan="3"><input type="text" id="mtrlOfDesc" name="mtrlOfDesc" format="text" readonly/></td>
				<tr>
					<td><i class="fas fa-caret-right"></i>클레임 : </td>
					<td colspan="3"><textarea id="mtrlOfDesc" name="mtrlOfClaim" format="text" rows="3" class="jtePopForm_onlyInsert"></textarea></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="orderForm_use"/>
						<input type="hidden" name="action" id="orderForm_action"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="pop_title"><spring:message code = "pop_orderingList" text = "발주리스트" /></div>
		<div id="jtePopForm_grid" class="mtrlOdcursitMgtForm" style="height: 270px; width: 98%; margin: auto; display: flex;"></div>
	</div>
</div>

<!-- 수령확인 팝업 -->
<div style="display:none;">
	<div id="jteMtrlOrdChkPop">
		<form id="jteMtrlOrdChkPop_form" class="mtrlOdcursitMgtForm">
			<div class="pop_title"><spring:message code = "pop_receiptInfo" text = "수령정보" /></div>
			<table id="jteMtrlOrdChkPop_master" class="BasicTable">
			<colgroup> <!-- 15 25 15 25 완료정보 조회 버튼 때문에 1행 추가-->
				<col style="width: 20%;">
				<col style="width: 28%;">
				<col style="width: 24%;">
				<col style="width: 28%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlItemCd" text = "발주계획코드" /> : </td>
					<td><input type="text" id="mtrlOrderId" name="mtrlOrderId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly/></td>			<!-- 자동입력 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_orderSitDiv" text = "발주상황구분" /> : </td>
					<td><input id="mtrlOrderState" name="mtrlOrderState"  format = "selBox" msg="mtrl_order" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm" text = "자재명" /> : </td>
					<td colspan="3">
						<input type="text" id="mtrlNm" name="mtrlNm" readonly/>
						<!-- <input type="hidden" id="mtrlId" name="mtrlId" /> -->
						<input type="hidden" id="mtrlCost" name="mtrlCost" />
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm" text = "업체명" /> : </td>
					<td colspan="3">
						<input type="text" id="compNm" name="compNm" readonly/>
						<input type="hidden" id="compId" name="compId" />
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_quantity" text = "수량" /> : </td>
					<td><input id="mtrlOrderQty" name="mtrlOrderQty" format="currency" onkeyup="lfn_mtrlTotlCostCalc()"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_deliveryCost" text = "배송비용" /> : </td>
					<td><input id="mtrlOrderDelivery" name="mtrlOrderDelivery" format="currency"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlCost" text = "자재비용" />
					<i class="fas fa-info-circle" title="<spring:message code = "pop_mtrlQtyAuto" text = "자재와 수량을 입력하면 기본적으로 자동계산됩니다." />"></i> :
					</td>
					<td><input id="mtrlOrderCost" name="mtrlOrderCost" format="currency"/></td>
					<td><i class="fas fa-caret-right"></i>예정일 : </td>
					<td><input id="mtrlOrderExpectex" name="mtrlOrderExpectex" format="datepicker"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명" /> : </td>
					<td colspan="3"><input type="text" id="mtrlOrderDesc" name="mtrlOrderDesc" format="text"/></td>
				</tr>
			</table>
			<div class="pop_title"><spring:message code = "pop_finishInfo" text = "완료정보" /></div>
			<table id="jteMtrlOrdChkPop_master-2" class="BasicTable">
			<colgroup> <!-- 15 25 15 25 완료정보 조회 버튼 때문에 1행 추가-->
				<col style="width: 20%;">
				<col style="width: 28%;">
				<col style="width: 24%;">
				<col style="width: 28%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_recipient" text = "수령자" /> : </td>
					<td>
						<input id="mtrlOrderUserNm" class="btn-input" name="mtrlOrderUserNm" format="text" readonly/>
						<input type="hidden" name="mtrlOrderUser" id="mtrlOrderUser"/>
						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
							<spring:message code="btn_search" /><!-- 조회 -->
						</button>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate" text = "수령일" /> : </td>
					<td>
						<input id="mtrlOrderDate" name="mtrlOrderDate" format="datepicker"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="mtrlId" id="qcMtrlId"/>
						<input type="hidden" name="mtrlOfId"/>
						<input type="hidden" name="mtrlMgtId" id="chkMtrlMgtId"/>
						<input type="hidden" name="use" id="chkUse"/>
						<input type="hidden" name="action" id="chkAction"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteMtrlOrdChkPop');"><spring:message code = "pop_cancel" text = "취소" /></button>
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/mtrl/mtrlOdMgt/mtrlOdcursitMgt/mtrlOdcursitMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

var lfo_mtrlBadGrd = {};//발주주문서 팝업 그리드에서 사용

var lfo_batchPickUp = {};//일괄수령 팝업

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/mtrl/mtrlOdMgt/mtrlOdcursitMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getMtrlOrderFormList", auth:"", prmt:{mtrlOfState: "mtrl_sta02"}}
	};
	
	//5.
	lfo_common.model = {
		id: "mtrlOfId",
		fields: {
			mtrlOfId : { type: "string" },
			mtrlOfNm : { type: "string" },
			mtrlOfDate : { type: "date" },
			mtrlOfCost : { type: "int" },
			mtrlOfState : { type: "string" },
			mtrlOfDesc : { type: "string" },
			createdAt : { type: "date" },
			updatedAt : { type: "date" },
			creatorId : { type: "string" },
			creatorNm : { type: "string" },
			updatorId : { type: "string" },
			mtrlClaim : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "mtrlOfId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlCurPop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "70px"},
		{field: "mtrlOfId", title:gfn_getMsg("col_mtrlOrderDocCd", "발주주문코드"), width: "170px"},
		{field: "mtrlOfState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOfState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOfState).cdId , gfn_getCode(mtrlOfState).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlOrderStatus", "발주상태"), width: "110px;"},
		{field: "mtrlOfNm", title:gfn_getMsg("col_mtrlOrderDocNm", "발주명"), width: "180px"},
		{field: "mtrlOfCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost", "비용"), width: "100px"},
		{field: "creatorNm", title:gfn_getMsg("col_registUser", "등록자"), width: "130px"},
		{field: "mtrlOfDate", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtrlOrderDate", "발주일"), width: "120px"},
		{field: "mtrlOfDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_mtrlOrderDocNm", "발주명"), value: "mtrlOrderForm.mtrl_of_nm" },
		{ text: gfn_getMsg("col_mtrlOrderDocCd", "발주주문코드"), value: "mtrlOrderForm.mtrl_of_id" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_mtrlCurPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px", // 200512 JJW 그리드 더블클릭 팝업 (발주주문서) 너비 700px
		height: "650px", /* 201223 JJW POP 고려 X 그리드 크기에 맞춰 팝업 높이 수정 712px  */
		id : lfo_common.popId, 
		title: gfn_getMsg("pop_mtrlOrderSrh"),			// 발주주문 수정
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = {};
	if(mode=='NEW'){
		selectedItem = {
				mtrlOfId : lfo_common.gridSelected.mtrlOfId
			}
		gfn_popform_set(lfo_common, mode, selectedItem);
	}else if(mode == 'EDT'){
		$(".jtePopForm_onlyInsert").attr('readonly', true);
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {mtrlOfId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {mtrlOfId :lfo_common.gridSelected.mtrlOfId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
	
	//그리드 세팅
	if($("#jtePopForm_grid").html() ==""){
		lfn_jtePopGrd_setGrd();
	}else{
		lfo_popGrd.grid.dataSource.read();
	}
}


//팝업내부 그리드 -  발주목록
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	lfo_popGrd.popId = "jteMtrlOrdChkPop";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/mtrl/mtrlOdMgt/mtrlOdplanMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlOrderList", auth:"", search:false, prmt:{mtrlOfId:lfo_common.gridSelected.mtrlOfId}}, 
		//create:{url:"/setMtrlOrderSave", auth:"", openFunc:"", callback : lfn_mtrlOrderCheckPop_save}, 
		update:{url:"/setMtrlOrderSave", auth:"", openFunc:"", callback : lfn_mtrlOrderCheckPop_save}, 
		excel:{url:"" ,auth:"", fileName: "발주이력_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
		//destroy:{url:"/setMtrlOrderDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "mtrlOrderId",
		fields: {
			mtrlOrderId : { type: "string" },
			mtrlOrderQty : { type: "int" },
			mtrlOrderUser : { type: "string" },
			mtrlOrderUserNm : { type: "string" },
			mtrlOrderDate : { type: "date" },
			mtrlOrderCost : { type: "int" },
			mtrlOrderExpectex : { type: "string" },
			mtrlOrderDelivery : { type: "int" },
			mtrlOrderState : { type: "string" },
			mtrlOrderDesc : { type: "string" },
			createdAt : { type: "date" },
			updatedAt : { type: "date" },
			creatorId : { type: "string" },
			creatorNm : { type: "string" },
			updatorId : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { tpye: "string" },
			mtrlCost : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			mtrlOfId : { type: "string" },
			mtrlChargeUser : { type: "string" },
			mtrlChargeUserNm : { type: "string" },
			mtrlQualSta : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm", "자재명"), width: "120px"},
		{field: "mtrlOrderQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity", "수량"), width: "90px"},
		{field: "mtrlOrderExpectex", format: "{0: yyyy-MM-dd}", title:"예정일", width: "110px"},
		{field: "mtrlOrderDate", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate", "수령일"), width: "110px"},
		{field: "compNm",  title:gfn_getMsg("col_compNm", "업체명"), width: "160px"},
		{field: "mtrlOrderUserNm", title:gfn_getMsg("col_recipient", "수령자"), width: "130px"},
		{field: "mtrlOrderId", title:gfn_getMsg("col_mtrlItemCd", "발주계획코드"), width: "180px"},
		{field: "mtrlOrderState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOrderState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOrderState).cdId , gfn_getCode(mtrlOrderState).cdNm) # #= item #", 
			title:gfn_getMsg("col_orderSitDiv", "발주상황구분"), width: "140px;"},
		{field: "mtrlId", title:"자재코드", width: 100},
		{field: "mtrlOrderCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost", "금액"), width: "90px"},
		{field: "mtrlOrderDelivery", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_deliveryCost", "베송비용"), width: "120px"},
		{field: "creatorNm", title:gfn_getMsg("col_registUser", "등록자"), width: "130px"},
		{field: "createdAt", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate", "등록일"), width: "110px"},
		{field: "mtrlOrderDesc", title:gfn_getMsg("col_desc", "설명"), width: "150px"}
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlInfo.mtrl_nm" },
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_mtrlItemCd", "발주계획코드"), value: "mtrlOrder.mtrl_order_id" }
	];

	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

//수령확인 버튼 클릭(팝업 오픈)
this.lfn_mtrlOrderCheckPop_open = function(target, mode){
	var options = {
		modal:true, 
		width: "650px", /* 20.12.18 JJW 650 */
		height: "720px", /* 20.12.18 JJW 565 -> 605 ---POP일시 고쳐야함   */
		id : lfo_popGrd.popId, 
		title : gfn_getMsg("pop_receiptConfirm", "수령확인"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_popGrd.grid.dataItem($(target).closest("tr"));

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_mtrlOrderCheckPop_set(mode, dataItem)};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_mtrlOrderCheckPop_set = function(mode, dataItem){
	lfo_popGrd.gridSelected = {};
	
	if(typeof(dataItem) == "object"){
		lfo_popGrd.gridSelected = dataItem;
	}else if(typeof(dataItem) == "string"){
		lfo_popGrd.gridSelected = dataItem;
	}
	
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.read.url,
		type: "POST",
		data: {
			mtrlOrderId :lfo_popGrd.gridSelected.mtrlOrderId,
			mtrlOfId :lfo_popGrd.gridSelected.mtrlOfId
			},
		success: function(data){
			gfn_popform_set(lfo_popGrd, mode,data.rows[0]);
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
	
	if(mode=='NEW'){
		//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
		$("#" + lfo_popGrd.popId + " [name=mtrlOrderDate]").data("kendoDatePicker").value(new Date());
		$("#" + lfo_popGrd.popId + " [name=mtrlOrderUserNm]").val($("#_loginUserName").val())
		$("#" + lfo_popGrd.popId + " [name=mtrlOrderUser]").val($("#_loginUserId").val())
		
		//저장시 action을 수령완료로 변경
		$("#" + lfo_popGrd.popId + " [name=action]").val("END");
		
		//불량코드 조회문제로 빈값 넣어주기(빈값은 if test문에 걸려서 제외 > false로 대체)
		lfo_popGrd.gridSelected= {
				mtrlOrderId : false
		}
	}else if(mode == 'EDT'){
		//저장시 action을 수령변경 으로 변경
		$("#" + lfo_popGrd.popId + " [name=action]").val("ENDUP");
	}	
}

//자재비용 계산
this.lfn_mtrlTotlCostCalc = function(){
	var mtrlCost = parseInt($("#"+ lfo_popGrd.popId +" [name=mtrlCost]").val());
	var mtrlOrderQty = parseInt($("#"+ lfo_popGrd.popId +" [name=mtrlOrderQty]").val());
	if(!isNaN(mtrlCost) && !isNaN(mtrlOrderQty)){
		$("#"+ lfo_popGrd.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value(mtrlCost * mtrlOrderQty);
	}else{
		$("#"+ lfo_popGrd.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value("0");
	}
}

//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

//pop - 수령확인 완료정보 유저 팝업 콜백
this.lfn_userInfoPop_callback = function(rtnObj){
	$("#" + lfo_popGrd.popId + " [name=mtrlOrderUser]").val(rtnObj["userId"]);
	$("#" + lfo_popGrd.popId + " [name=mtrlOrderUserNm]").val(rtnObj["userNm"]);
}

</script>