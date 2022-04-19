<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="shipMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<label>프로젝트 : </label>
		<input type="text" class="k-textbox" id="orderId" readonly/>
		<!-- <input type="hidden" id="orderId" value="None"> -->
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_orderInfo()"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="shipMgtForm-gird"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="shipPlanPop">
		<div id="shipPlanInfo_grid"></div>
	</div>
</div>
<div style="display:none;">
	<div id="planAddPop">
		<form id="planAddPop_form">
		<!-- 출하계획 -->
			<div class="pop_title"><spring:message code = "pop_shipPlan"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master shipMgtForm">
				<colgroup>
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-title">
					<col class="col-right-content">
				</colgroup>
				<tr>
					<!-- 총 주문수량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_totalOrderQty"></spring:message>: </td>
					<td><input id="lotQty" class="left-input" name="lotQty"  format="numeric" readonly/></td>
					<!-- 납품 완료 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_deliveryFinishQty"></spring:message> : </td>
					<td><input id="shipCompleteQty" class="right-input" name="shipCompleteQty"  format="numeric" readonly/></td>
				</tr>
				<tr>
					<!-- 출하예정일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipExceptDate"></spring:message> : </td>
					<td><input type="text" id="shipPlanDate" class="left-input" name="shipPlanDate" format="datepicker"/></td>
					<!-- 출하량 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_shipQty"></spring:message>: </td>
					<td><input id="shipQty" class="right-input" name="shipQty"  format="numeric"/></td>
				</tr>
				<tr>
					<!-- 배송지정보 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipAddrInfo"></spring:message></td>
					<td>
						<input type="text" id="compNm" class="left-input" class="center-input" name="compNm" readonly/>
						<input type="hidden" id="compId" class="center-input" name="compId" />
					</td>
					<td colspan="2">
					<!-- 배송지정보조회 -->
						<button class="k-button k-primary search-btn" type="button" onclick = "lfn_companyInfo()"><spring:message code = "col_shipAddrInfoSrh"></spring:message></button>
					</td>
				</tr>
				<tr>
					<!-- 연락처 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_contact"></spring:message> : </td>
					<td colspan="3"><input type="text" class="center-input" id="compNumber" name="compNumber" readonly/></td>
				</tr>
				<tr>
					<!-- 배송지 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipAddr"></spring:message> : </td>
					<td colspan="3">
						<input type="text" class="center-input" id="compAddrDetail" name="compAddrDetail" readonly/>
						<input type="hidden" class="center-input" id="compAddrId" name="compAddrId" />
					</td>
				</tr>
				<tr>
					<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="shipDesc" class="center-input" name="shipDesc"/></td>
				</tr>
			</table>
			<input type="hidden" id="shipId" name="shipId"/>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/compMgt/compMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/ship/shipMgt/shipMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200501 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_orderInfo = function() {
	var callback = function(selectedItem){
		$('#jteSingleGrid').empty();
		$('#orderId').val(selectedItem.orderId);
		/* $('#orderNm').val(selectedItem.orderNm); */
		
		lfn_jteSgGrd_setGrd();
	};
	gfn_openCustomPop('orderInfo', callback);
}


// 그리드 세팅
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
	lfo_common.popId = "shipPlanPop";
	
	//3.
	lfo_common.ctrlUrl = "/cform/ship/shipPlanMgt";
	
	//4.
	lfo_common.crud  = {
			read:{url:"/getShipPlanList", auth:"", prmt: {orderId : $('#orderId').val(), programId: "shipMgt"}} 
	};
	
	//5.
	lfo_common.model = {
		id: "shipId",
		fields: {
			shipId : { type: "string" },
			shipPlanDate : { type: "date" },
			shipDate : { type: "date" },
			shipState : { type: "string" },
			shipQty : { type: "int" },
			shipType : { type: "string" },
			shipUser : { type: "string" },
			shipOrder : { type: "string" },
			shipDesc : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			compNumber : { type: "string" },
			compAddrId : { type: "string" },
			compAddrDetail : { type: "string" },
			lotId : { type: "string" },
			lotSeq : { type: "int" },
			itemId : { type: "string" },
			itemNm : { type: "string" }
		}
	};
	 
	//6.
	lfo_common.columns = [
		{field: "shipId", title:gfn_getMsg("col_shipCd"), width: "140px;"},													//출하코드
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "120px;"},													//LoT코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "120px;"},													//품목명
		{field: "shipPlanDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_shipExceptDate"), width: "150px;"},			//출하예쩡일
		{field: "shipDate", format:"{0: yyyy-MM-dd hh:mm:ss}", title:gfn_getMsg("col_shipDate"), width: "150px;"},			//출하일자
		//20.05.11|ymlee|출하옵션에서 납기관련상태를 보여주기에 주석
/* 		{field: "shipState", template:"# var item = gfn_isNull(gfn_getCode(shipState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(shipState).cdVal , gfn_getCode(shipState).cdNm) # #= item #",
				title:gfn_getMsg("col_shipStatus"), width: "120px;"}, */
		{field: "shipQty", title:gfn_getMsg("col_shipQty"), width: "100px;"},												//출하수량
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "150px;"},													//업체명
		{field: "compNumber", title:gfn_getMsg("col_compNum"), width: "100px;"},											//업체번호
		{field: "compAddrDetail", title:gfn_getMsg("col_compAddr"), width: "200px;"},										//업체주소
		{field: "shipDesc", title:gfn_getMsg("col_desc"), width: "120px;"},													//설명
		{field: "shipOption", title:gfn_getMsg("col_shipOption"), width: "100px",											//출하옵션
			template : function(rows) {
				if(rows.shipState == 'ship_dvry01'){
					return '<button class="k-button k-primary" type="button" onclick="lfn_shipAction(\'ship_dvry02\', this)">출하 진행</button>';
				} else if(rows.shipState == 'ship_dvry02'){
					return '<button class="k-button k-primary" type="button" onclick="lfn_shipAction(\'ship_dvry03\', this)">납품 확인</button>';
				} else {
					return '납품 완료';
				}
			}
		} 
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "itemInfo.item_nm" },			//품목명
		{ text: gfn_getMsg("col_lotCd"), value: "pkgWork.lot_id" }				//Lot코드
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_shipAction = function(state, rows){
	var flag = true;
	
	var selectedShip = {};
	selectedShip.shipId = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr")).shipId;
	selectedShip.lotId = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr")).lotId;
	selectedShip.lotSeq = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr")).lotSeq;
	selectedShip.shipQty = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr")).shipQty;
	selectedShip.itemId = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr")).itemId;
	selectedShip.shipState = state;
	
	if(state == "ship_dvry02") {
		kendo.confirm("출하 진행 시, 포장 수량이 차감되며 되돌릴 수 없습니다.\n계속 진행하시겠습니까?")
		.done(function(){
			$.ajax({
				async:false,
				url : '/cform/ship/shipMgt/getPackageStock',
				type: "POST",
				data: JSON.stringify(selectedShip),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					if(data < selectedShip.shipQty) {
						kendo.confirm("해당 Lot의 포장 수량이 출하량보다 적습니다.");
						flag = false;
					}
					lfo_common.grid.dataSource.read();
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
			if(!flag) {
				return flag;
			}

			$.ajax({
				async:false,
				url : '/cform/ship/shipMgt/shipAction',
				type: "POST",
				data: JSON.stringify(selectedShip),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					lfo_common.grid.dataSource.read();
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
			
		}).fail(function(){return false;});
	} else {
		$.ajax({
			async:false,
			url : '/cform/ship/shipMgt/shipAction',
			type: "POST",
			data: JSON.stringify(selectedShip),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
}

</script>