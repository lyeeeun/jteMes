<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="mrcalMgtForm">
	<div id="jteSingleGrid" class="mrcalMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드> 더블클릭)  -->
<div style="display:none;">
	<div id="jtePopForm" class="mrcalMgtForm jtePopForm">
		<div class="pop_title">LoT 별 자재소요량 산출</div>
		<div id="jtePopForm_grid" style="height:350px;"></div>
	</div>
</div>

<!-- 발주 계획 등록 팝업 -->
<div style="display:none;">
	<div id="jtePopAddForm" class="jtePopAddForm">
		<form id="jtePopAddForm_form" class="mrcalMgtForm jtePopAddForm_form">
			<div class="pop_title"><spring:message code = "pop_mtrlOrderPlan" text = "발주계획" /></div>
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width: 20%;">
				<col style="width: 28%;">
				<col style="width: 24%;">
				<col style="width: 28%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlItemCd" text = "발주계획코드" /> : </td>
					<td><input type="text" id="mtrlOrderId" name="mtrlOrderId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly/></td>			<!-- 자동입력 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_orderSitDiv" text = "발주상황 구분" /> : </td>
					<td><input id="mtrlOrderState" name="mtrlOrderState" format="selBox" msg="mtrl_order" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm" text = "자재명" /> : </td>
					<td colspan="3">
						<input type="text" id="mtrlNm" name="mtrlNm" readonly/>
						<input type="hidden" id="mtrlId" name="mtrlId" />
						<input type="hidden" id="mtrlCost" name="mtrlCost" />
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm" text = "업체명" /> : </td>
					<td colspan="3">
						<input type="text" id="compNm" class="btn-input" name="compNm" readonly/>
						<input type="hidden" id="compId" name="compId" />
					<button class="k-button k-primary" type="button" onclick="lfn_openMtrlCompPop()" >
							<spring:message code = "btn_search" text = "조회" /></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_quantity" text = "수량" /> : </td>
					<td><input id="mtrlOrderQty" name="mtrlOrderQty" format="currency"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_cost" text = "금액" />
					<i class="fas fa-info-circle" title="<spring:message code = "pop_mtrlQtyAuto" text = "자재와 수량을 입력하면 기본적으로 자동계산됩니다." />"></i> : </td>
					<td><input id="mtrlOrderCost" name="mtrlOrderCost" format="currency"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_deliveryCost" text = "배송비용" /> : </td>
					<td><input id="mtrlOrderDelivery" name="mtrlOrderDelivery" format="currency"/></td>
					<td><i class="fas fa-caret-right"></i>예정일 : </td>
					<td><input id="mtrlOrderExpectex" name="mtrlOrderExpectex" format="datepicker"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명" /> : </td>
					<td colspan="3"><input type="text" id="mtrlOrderDesc" name="mtrlOrderDesc" format="text"/></td>
				</tr>
				</div>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="order_use"/>
						<input type="hidden" name="action" id="order_action"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel" text = "취소" /></button>
			</div>
		</form>
	</div>
</div>

<link href='/resources/mes/css/contents/mfgMgt/mfgplanMgt/mrplanMgt/mrplanMgtForm.css' rel="stylesheet">

<script>
var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {}; //Form 내부에서 사용될 Object
	

	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/mtrl/mrcalMgt"
	
	//4.
		lfo_common.crud  = {
			read:{url:"/getLotList", auth:"", prmt:{}, dynamicPrmt : {orderId : "orderId" }}
		};
	
	//5. 
	lfo_common.model = {
			id: "orderId",
			fields : {
				orderId : { type: "String" },
				orderNm : { type: "String" },
				lotId : { type: "String" },
				lotNm : { type: "String" },
				itemNm : { type: "String" },
				lotQty : { type: "int" }
			}
	};
	
	//6.
	lfo_common.columns = [
		{field: "orderId", title:gfn_getMsg("btn_search", "조회") ,width: "80px",
			template: function(rows){
				return '<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); "><spring:message code = "btn_search"/></button>';
			}
		},
		{field: "lotId", title:gfn_getMsg("col_lotCd", "LoT 코드"), width: "170px;"},
		{field: "lotNm", title:gfn_getMsg("col_lotWrkNm", "LoT 명"), width: "170px;"},
		{field: "lotQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_lotQty", "LoT 수량"), width: "120px;"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm", "부품명"), width: "220px;"}
		
		
	];
	
	lfo_common.customTitle = {
			html: '<button class="k-button k-primary" type="button" onclick = "lfn_order(\'all\');" style="min-width:60px;">전체 검색</button> &nbsp; <button class="k-button k-primary" type="button" onclick = "lfn_order(\'order\');" style="min-width:60px;">수주 검색</button>' +
			'<input class="k-textbox" id="orderNm" readonly/><input type="hidden" id="orderId" /> '
		};
	
	//7
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm", "부품명"), value: "item.item_nm" },
		{ text: gfn_getMsg("col_lotNm", "LoT명"), value: "lot.lot_nm" },
	];
	
	//공통 그리드 세팅 호출
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//자재소요량 산출 팝업 오픈
this.lfn_jtePop_open = function(mode, target){

	var options = {
			modal:true, 
			width: "1250px",
			height: "388px", 
			id : lfo_common.popId, 
			title: "LoT 별 자재소요량 산출",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		lfo_common.gridSelected = lfo_common.grid.dataItem($(target).closest("tr"));
		
	
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	};
	this.gfn_winOpen(options);
}

//수주별 LoT 조회
this.lfn_order = function(mode){
	
	if(mode == 'order') {
		var callback = function(selectedItem){
			$('#orderNm').val(selectedItem.orderNm);
			$('#orderId').val(selectedItem.orderId);
			
			lfo_common.grid.dataSource.read();
		};
		
		gfn_openCustomPop("orderInfo", callback);
	} else {
		$('#orderNm').val(null);
		$('#orderId').val(null);
		
		lfo_common.grid.dataSource.read();
	}
	
}

//자재소요량 팝업 내부 그리드
this.lfn_jtePopGrd_setGrd = function(){
	
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	lfo_popGrd.popId = "jtePopAddForm";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/mtrl/mrcalMgt";
	
	//4.
	lfo_popGrd.crud = {
		read:{url:"/getMrpMtlList", auth:"",search:false, prmt:{orderId: lfo_common.gridSelected.orderId,lotId: lfo_common.gridSelected.lotId }},
		update:{url:"/setMtrlOrderSave", auth:"", openFunc : "", callback: lfn_jtePopGrd_save}
	};
	
	//5.
	lfo_popGrd.model = {
		id : "mtrlId",
		fields: {
			itemNm : { type : "string" },
			lotQty : { type : "int" },
			mtrlNm : { type : "string" },
			bomTargetCnt: { type : "int" },
			mtrlNeed: { type : "int" },
			mtrlMgtCnt: { type : "int " },
			mtrlOrderQty: { type : "int"},
			mtrlUseNeed: { type : "int" },
			mtrlCanUse: { type: "int" },
			mtrlOdCnt: { type: "int" },
			mtrlCost: { type: "int" },
			mtrlDiv: {type: "string "}
		}
	};
	
	//6. 
	lfo_popGrd.columns = [
		{field: "itemNm", title:gfn_getMsg("col_itemNm", "제품명"), width: "140px;"},
		{field: "lotQty",format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_lotQty", "주문량"), width: "100px;"},
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm","자재명"), width: "140px;"},
		{field: "bomTargetCnt", title:gfn_getMsg("col_standardQty", "표준량"), width: "90px;"},
		{field: "mtrlNeed", format: "{0:n0}", attributes : { style : "text-align : right;"},title:gfn_getMsg("col_needQty", "필요량"), width: "110px;"},
		{field: "mtrlMgtCnt",format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_mtrlStockQty", "자재재고량" ), width: "120px;"},
		{field: "mtrlOrderQty",format: "{0:n0}", attributes : { style : "text-align : r, ight;"}, title:gfn_getMsg("col_mtrlOrderExpect","입고예정"), width: "110px;"},
		{field: "mtrlUseNeed",format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_mtrlUseExpect", "사용예정"), width: "110px;"},
		{field: "mtrlCanUse", format: "{0:n0}", attributes : { style : "text-align : right;"},title: gfn_getMsg("col_mtrlCanUse", "가용량"),width: "90px;"},
		{field: "mtrlOdCnt",format: "{0:n0}", attributes : { style : "text-align : right;"}, title: gfn_getMsg("col_mtrlOdQty", "발주필요량"), width:"120px;",
			template : function(rows) {
				if(rows.mtrlOdCnt < 0){
					return 0;			
				} else {
					return rows.mtrlOdCnt;
				}
			}},									
		{field: "orderId", title:gfn_getMsg("pop_mtrlOrderRegist", "발주등록"), width: "110px",
			template : function(rows) {
				if(rows.mtrlOdCnt < 0){
					return "";			
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this); " style="min-width:60px;"><spring:message code = "pop_mtrlOrderRegist"/></button>';
				}
			}
		}
	];
	
	//공통 팝업 내부 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
//발주 등록  버튼 클릭 콜백(발주계획 등록 팝업)
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "720px",  
		height: "430px",
		id:lfo_popGrd.popId, 
		
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlPlanRegist", "발주계획 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlPlanRegist", "발주계획 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//발주 계획 등록 팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	
	//팝업 object 데이터맵핑
	lfo_popGrd.gridSelected = lfo_popGrd.grid.dataItem($(selectedItem).closest('tr'));
	lfo_popGrd.gridSelected.mtrlOrderQty = lfo_popGrd.gridSelected.mtrlOdCnt;
	lfo_popGrd.gridSelected.mtrlOrderState = "mtrl_order_temp";
	lfo_popGrd.gridSelected.mtrlCost = "";
	
	//팝업 내용 채우기
	gfn_popform_set(lfo_popGrd, mode,lfo_popGrd.gridSelected);
	//수량에 따라 금액 계산
	lfn_changeEvent_bind();
}

//자재정보 콜백
this.lfn_mtrlPop_callback = function(callbackObj){
	$("#"+ lfo_popGrd.popId + "_form [name='mtrlId']").val(callbackObj.mtrlId);
	$("#"+ lfo_popGrd.popId + "_form [name='mtrlNm']").val(callbackObj.mtrlNm);
}

//자재구매가능 업체조회 팝업
this.lfn_openMtrlCompPop= function(){
	var mtrlId = $("#"+ lfo_popGrd.popId + "_form [name='mtrlId']").val();
	
	if(!gfn_isNull(mtrlId)){
		gfn_openCustomPop('company',lfn_compPop_callback,{mtrlId: mtrlId});
	}else{
		gfn_msgBox({msg:"자재정보를 선택해주세요"});
	}
}

//업체정보 콜백
this.lfn_compPop_callback = function(callbackObj){
	$("#"+ lfo_popGrd.popId + "_form [name='compId']").val(callbackObj.compId);
	$("#"+ lfo_popGrd.popId + "_form [name='compNm']").val(callbackObj.compNm);
	
	//금액 계산
	lfn_mtrlTotlCostCalc();
}

//업체별 자재비용 조회
this.lfn_mtrlTotlCostCalc = function(){
	var pMtrlId = $("#"+ lfo_popGrd.popId + "_form [name='mtrlId']").val();
	var pCompId = $("#"+ lfo_popGrd.popId + "_form [name='compId']").val();
	
	var mtrlCost = 0;
	$.ajax({
		async:false,
		url : "/form/basMgt/operMgt/mtrlInfo/getMtrlRtlCompList",
		type: "POST",
		data: {mtrlId : pMtrlId, compId : pCompId},
		success: function(data){
			mtrlCost = parseInt(data.rows[0].mtrlPrice);
			mtrlQty = $("#"+ lfo_popGrd.popId + "_form [name='mtrlOrderQty']").val();
			$("#"+ lfo_popGrd.popId + "_form [name='mtrlCost']").val(mtrlCost);
			
			//업체 선택(변경)시 입력되어 있는 수량에 맞게 금액 계산됨
			if(!isNaN(mtrlCost) && !isNaN(mtrlQty)){
				$("#"+ lfo_popGrd.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value(mtrlCost * mtrlQty);
			}else {
				$("#"+ lfo_popGrd.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value(0);
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
	
	
}

//자재가격 * 자재수량 = 총가격 입력 이벤트 (수량 변경시 수량에 맞게 금액 변경됨)
this.lfn_changeEvent_bind = function() {
	var numerictextbox = $("#"+ lfo_popGrd.popId +" [name=mtrlOrderQty]").data("kendoNumericTextBox");
	var mtrlCost = "";
	
	numerictextbox.bind("change", function() {
		mtrlCost = $("#"+ lfo_popGrd.popId + "_form [name='mtrlCost']").val();
		
			if(!isNaN(mtrlCost) && !isNaN(this.value())){
				$("#"+ lfo_popGrd.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value(mtrlCost * this.value());
			} else{
				$("#"+ lfo_popGrd.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value("0");
			}
		
	});
}

//발주 계획 등록 Form내용 입력/저장
this.lfn_jtePopGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		
		savePrmt.action ="C";
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_popGrd.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_popGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
					
					//마스터그리 리로드
					lfo_popGrd.grid.dataSource.read();
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

</script>