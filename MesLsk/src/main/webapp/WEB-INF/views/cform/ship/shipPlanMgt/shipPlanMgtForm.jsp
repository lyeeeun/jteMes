<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="shipPlanMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<label><spring:message code = "lb_project"></spring:message> : </label>
		<input type="text" class="k-textbox" id="orderId" readonly/>
		<!-- <input type="hidden" id="orderId" value="None"> -->
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_orderInfo()"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="shipPlanMgtForm-gird" > <!-- style="width: 100%;" -->
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
		<form id="planAddPop_form" class="shipPlanMgtForm">
		<!-- 출하 계획 정보 -->
			<div class="pop_title"><spring:message code = "pop_shipPlanInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
				<colgroup>
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-title">
					<col class="col-right-content">
				</colgroup>
				<tr>
				<!-- 총 주문수량-->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_totalOrderQty"></spring:message> : </td>
					<td>
						<input id="lotQty" class="left-input" name="lotQty"  format="numeric" readonly/>
						<input type="hidden" id="pkgWorkId" name="pkgWorkId" readonly/>
						<input type="hidden" id="lotId" name="lotId" readonly/>
					</td>
				<!-- 납품 완료 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_deliveryFinishQty"></spring:message> : </td>
					<td><input id="shipTotalQty" class="right-input" name="shipTotalQty"  format="numeric" readonly/></td>
				</tr>
				<tr>
				<!-- 출하 예정일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipExceptDate"></spring:message> : </td>
					<td><input type="text" id="shipPlanDate" class="left-input" name="shipPlanDate" format="datepicker"/></td>
				<!-- 출하 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_shipQty"></spring:message> : </td>
					<td><input id="shipQty" class="right-input" name="shipQty"  format="numeric" readonly/></td>
				</tr>
				<tr>
				<!-- 배송지 정보 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipAddrInfo"></spring:message> : </td>
					<td colspan="2">
						<input type="text" id="compNm" class="left-input btn-input" name="compNm" readonly/>
						<input type="hidden" id="compId" name="compId" />
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick = "lfn_companyInfo()">
				<!-- 조회 -->
						<spring:message code = "btn_search"></spring:message></button>
					</td>
				</tr>
				<tr>
				<!-- 연락처 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_contact"></spring:message>: </td>
					<td colspan="3"><input type="text" class="center-input" id="compNumber" name="compNumber" readonly/></td>
				</tr>
				<tr>
				<!-- 배송지 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipAddr"></spring:message>: </td>
					<td colspan="3">
						<input type="text" class="center-input" id="compAddrDetail" name="compAddrDetail" readonly/>
						<input type="hidden" class="center-input" id="compAddrId" name="compAddrId" />
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="shipDesc" name="shipDesc" style = "width: 100%"/></td>
				</tr>
			</table>
			<input type="hidden" id="shipId" name="shipId"/>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "lfn_saveShipPlan()"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('planAddPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="pop_bundleInfo" class="bundleForm">
		<form id="pop_bundleInfo_Form" class="toolInfoPopup_form bundleForm">
			<div id="bundleInfoOption" class="plus-minus-btn-area">
				<button class="k-button k-primary plus-minus-btn" type="button" id="bundleAdd">+</button>
				<button class="k-button k-primary plus-minus-btn" type="button" id="bundleRemove">-</button>
			</div>
			<div>
				<table id="toolInfo-title" class="toolInfo toolInfo-title bundleForm bundleForm-toolInfo-title">
					<colgroup>
						<col class="col-toolInfo-check">  <!-- style="width: 4%;" -->
						<col class="col-toolInfo1">  <!-- style="width: 24%;" -->
						<col class="col-toolInfo2">  <!-- style="width: 24%;" -->
					</colgroup>
					<tr>
						<td><span style="visibility: hidden;" 체크></span></td>
					<!-- 포장 단위 -->
						<td><spring:message code = "col_bundleUnit"></spring:message></td>
					<!-- 포장 수량 -->
						<td><spring:message code = "col_bundleQty"></spring:message></td>
					</tr>
				</table>
			</div>
			<div class="toolInfo-div">
				<table id="bundleInfo" class="toolInfo toolInfo-content bundleForm bundleForm-toolInfo-content">
				</table>
			</div>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" onclick = "lfn_saveRtlBundleList()"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('pop_bundleInfo')"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/compMgt/compMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/ship/shipPlanMgt/shipPlanMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200511 JJW  -->

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
	
	lfo_common = {};

	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "planAddPop";
	
	//3.
	lfo_common.ctrlUrl = "/cform/ship/shipPlanMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getShipPlanList", auth:"", prmt: {orderId : $('#orderId').val()}}, 
		/* create:{url:"/setShipPlan", auth:"", openFunc: lfn_planAddPop_open, callback:lfn_planAddPop_save},
		update:{url:"/updateShipPlan", auth:"", openFunc: lfn_planAddPop_open, callback:lfn_planAddPop_save},
		destroy:{url:"/deleteShipPlan", auth:"", callback: lfn_shipPlan_delete} */
	};
	
	//5.
	lfo_common.model = {
		id: "shipId",
		fields: {
			lotId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotQty : { type: "int" },
			shipTotalQty : { type: "int" },
			prsPackageQty : { type: "int" },
			shipId : { type: "string" },
			shipPlanDate : { type: "date" },
			shipDate : { type: "date" },
			shipState : { type: "string" },
			shipType : { type: "string" },
			shipDesc : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			compNumber : { type: "string" },
			compAddrId : { type: "string" },
			compAddrDetail : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "shipPlan", title: gfn_getMsg("col_shipPlan"), width:"120px",												//포장작업
			template : function(rows) {
				if(rows.shipState != "ship_dvry02" && rows.shipState != "ship_dvry03") {
					return '<button class="k-button k-primary" type="button" onclick="lfn_shipPlanPop_open(this)">' + "<spring:message code = "col_shipPlan" />" + '</button>';
				} else {
					return '<span></span>'
				}
			}
		},
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "160px;"},													//LoT코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "160px;"},													//품목명
		{field: "lotQty", title:gfn_getMsg("col_orderQty"), width: "110px;"},												//주문수량
		{field: "shipTotalQty", title:gfn_getMsg("col_deliveryFinishQty"), width: "160px;"},								//납품 완료 수량
		{field: "prsPackageQty", title:gfn_getMsg("col_releaseQty"), width: "110px;"},										//출고 재고 수량
		{field: "shipPlanDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_shipExceptDate"), width: "180px;"},			//출하예정일
		{field: "shipDate", format:"{0: yyyy-MM-dd hh:mm:ss}", title:gfn_getMsg("col_shipDate"), width: "180px;"},			//출하일자
		{field: "shipState", template:"# var item = gfn_isNull(gfn_getCode(shipState))== true ? '출하 계획 미정' : gfn_getMsg('bc_'+ gfn_getCode(shipState).cdVal , gfn_getCode(shipState).cdNm) # #= item #", 
				title:gfn_getMsg("col_shipStatus"), width: "120px;"},														//출하상태
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "130px;"},													//업체명
		{field: "compNumber", title:gfn_getMsg("col_compNum"), width: "120px;"},											//업체번호
		{field: "compAddrDetail", title:gfn_getMsg("col_compAddr"), width: "260px;"},										//업체주소
		{field: "shipDesc", title:gfn_getMsg("col_desc"), width: "180px;"}													//설명
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "itemInfo.item_nm" },
		{ text: gfn_getMsg("col_lotCd"), value: "pkgWork.lot_id" }
	];
	
	//공통 그리드 세팅 호출
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_companyInfo = function(){
	var callback = function(selectedItem){
		$('#compNm').val(selectedItem.compNm);
		$('#compId').val(selectedItem.compId);
		$('#compNumber').val(selectedItem.compNumber);
		$('#compAddrDetail').val(selectedItem.compAddrDetail);
		$('#compAddrId').val(selectedItem.compAddrId);
	};
	gfn_openCustomPop('shipComp', callback, {lotId: $('#lotId').val()});
}

//삭제 콜백
this.lfn_shipPlan_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_popGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			lfo_popGrd.grid.dataSource.read();
			
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});		//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}



this.lfn_shipPlanPop_open = function(rows) {
	var dataItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr"));
	
	var options = {
		modal:true, 
		width: "750px", // 200511 JJW 출하 계획 그리드 추가 버튼 클릭 시 나타나는 팝업 너비 기본 값 750px
		height: "412px", // 200511 JJW 출하 계획 그리드 추가 버튼 클릭 시 나타나는 팝업 높이 기본 값 550px -> 440px 200810 youmi 440->412px
		id : lfo_common.popId, 
		title:gfn_getMsg("pop_shipPlanRegist"),			//출하 계획 등록
		resizable:false,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	options.callback = function(){
		gfn_popform_set(lfo_common, 'NEW', dataItem);
		$("#shipQty").data("kendoNumericTextBox").value(dataItem.prsPackageQty);
	};	
		
	this.gfn_winOpen(options);
}

this.lfn_saveShipPlan = function() {
	var savePrmt = $("#planAddPop_form").serializeObject();
	if($('#shipId').val() == null || $('#shipId').val() == undefined || $('#shipId').val() == "") {
		$.ajax({
			async:false,
			url : "/cform/ship/shipPlanMgt/setShipPlan",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				//마스터 그리드 리로드
				lfo_common.grid.dataSource.read();
				
				//팝업종료
				gfn_closePop("planAddPop");
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	} else {
		$.ajax({
			async:false,
			url : "/cform/ship/shipPlanMgt/updateShipPlan",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				//마스터 그리드 리로드
				lfo_common.grid.dataSource.read();
				
				//팝업종료
				gfn_closePop("planAddPop");
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
}

</script>