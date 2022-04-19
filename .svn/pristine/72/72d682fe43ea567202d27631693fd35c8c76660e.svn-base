<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="orderCompleteMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<label>프로젝트 : </label>
		<input type="text" class="k-textbox" id="orderId" readonly/>
		<input type="hidden" id="orderState" readonly>
		<!-- <input type="hidden" id="orderId" value="None"> -->
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_orderInfo()"><spring:message code = "btn_search"/></button>
		<button class="k-button k-primary" type="button" id="orderCompleteBtn" onclick= "lfn_orderStateComplete()" style="float:right; margin-right:15px">프로젝트 완료</button>
	</div>
	<div id="grid-content" class="orderCompleteMgtForm orderCompleteMgtForm-gird"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/compMgt/compMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/ship/orderCompleteMgt/orderCompleteMgtForm_JJW.css' rel="stylesheet">

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
		if(selectedItem.orderState == "ord_prcd02") {
			$('#orderCompleteBtn').hide();
		} else {
			$('#orderCompleteBtn').show();
		}
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
	lfo_common.ctrlUrl = "/form/ship/orderCompleteMgt";
	
	//4.
	lfo_common.crud  = {
			read:{url:"/selectOrderList", auth:"", prmt: {orderId : $('#orderId').val()}} 
	};
	
	//5.
	lfo_common.model = {
		fields: {
			orderId : { type: "string" },
			lotId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotQty : { type: "int" },
			shipTotalQty : { type: "int" },
			lotState : {type: "string" }
		}
	};
	 
	//6.
	lfo_common.columns = [
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "130px;"},							//수주코드
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "140px;"},								//LoT코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "140px;"},								//부품명
		{field: "lotQty", title:gfn_getMsg("col_orderQty"), width: "130px;"},							//주문수량
		{field: "shipTotalQty", title:gfn_getMsg("col_deliveryFinishQty"), width: "120px;"},			//납품 완료 수량
		{field: "lotState", template: "# var item = gfn_isNull(gfn_getCode(lotState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title:gfn_getMsg("col_lotStatus"), width: "120px;"},									//LoT상태
		//20.05.11|ymlee|출하옵션에서 납기관련상태를 보여주기에 주석
		{field: "lotStateComplete", title:gfn_getMsg("col_deliveryFinish"), width: "110px",				//납품완료
			template : function(rows) {
				if(rows.lotState != "ord_sta02") {
					return '<button class="k-button k-primary" type="button" onclick="lfn_lotStateComplete(this)">납품 완료</button>';	
				} else {
					return '<span></span>';
				}
			}
		},
		{field: "procShiftTable", title:gfn_getMsg("col_processShift"), width: "140px",				//공정 이동표
			template : function(rows) {
					return '<button class="k-button k-primary" type="button" onclick="lfn_procShiftTable(this)">출력</button>';	
			}
		},
		{field: "returnMtrlReport", title:gfn_getMsg("col_returnMtrlList"), width: "140px",			//잉여 소재 반납 내역서
			template : function(rows) {
					return '<button class="k-button k-primary" type="button" onclick="lfn_returnSurplusMtrl(this)">출력</button>';	
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "itemInfo.item_nm" },			//품목명
		{ text: gfn_getMsg("col_lotCd"), value: "lotInfo.lot_id" },				//Lot코드
		{ text: gfn_getMsg("col_orderCd"), value: "orderInfo.order_id" }			//품목명
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_lotStateComplete = function(rows){
	var paramLotId = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr")).lotId;
	
	kendo.confirm("해당 Lot를 완료 처리 시 진행 상태로 되돌릴 수 없습니다. \n완료 하시겠습니까?")
	.done(function(){
		$.ajax({
			async:false,
			url : '/form/ship/orderCompleteMgt/lotStateUpdate',
			type: "POST",
			data: JSON.stringify({lotState: "ord_sta02", lotId: paramLotId}),
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
	
}

this.lfn_orderStateComplete = function(){
	if($('#orderId').val() == '' || $('#orderId').val() == null || $('#orderId').val() == undefined) {
		kendo.confirm("수주 정보를 선택하여 주십시오.")
		return false;
	}
	
	kendo.confirm("해당 수주를 완료 처리 시, 주문 정보가 모두 완료 처리 되며 되돌릴 수 없습니다. \n완료 하시겠습니까?")
	.done(function(){
		$.ajax({
			async:false,
			url : '/form/ship/orderCompleteMgt/orderStateUpdate',
			type: "POST",
			data: JSON.stringify({orderId: $('#orderId').val()}),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				$('#orderCompleteBtn').hide();
				gfn_msgBox({msg : gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}).fail(function(){return false;});
}

this.lfn_procShiftTable = function(rows){
	var paramLotId = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr")).lotId;
	var rowData = new Array();
	rowData.push({ cells: [ { value: "로트번호" }, { value: "부품코드" }, { value: "재질" }, { value: "수량(묶음 단위)" },
		{ value: "수량" }, { value: "포장 수량" }, { value: "일자" } ] });
	
	$.ajax({
		async:false,
		url : '/form/ship/orderCompleteMgt/selectProcShiftTable',
		type: "POST",
		data: {lotId: paramLotId},
		success: function(data){
			$.each(data.rows, function(index, item) {
				rowData.push({ cells: [ { value: item.lotId }, { value: item.itemNm }, { value: gfn_getMsg('bc_'+ gfn_getCode(item.itemMtrl).cdId , gfn_getCode(item.itemMtrl).cdNm) }, { value: item.bundleUnit + " EA" },
					{ value: item.bundleQty }, { value: (parseInt(item.bundleUnit)*parseInt(item.bundleQty)) }, { value: item.pkgWorkEnd } ] });
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	var fileName = gfn_getMsg("col_processShift") + "_" + gfn_getDate("yyyy_MM_dd") + ".xlsx"; 
	var workbook = new kendo.ooxml.Workbook({
		sheets: [
			{
				// The column settings (width).
				columns: [
					{ width: 150 },
					{ width: 100 },
					{ width: 100 },
					{ width: 100 },
					{ width: 100 },
					{ width: 100 },
					{ width: 100 },
				],
				// Th title of the sheet.
				title: gfn_getMsg("col_processShift"),
				// The rows of the sheet.
				rows: rowData
			}
		]
	});
	kendo.saveAs({
		dataURI: workbook.toDataURL(),
		fileName: fileName
	});
	
	
}

this.lfn_returnSurplusMtrl = function(rows){
	var paramLotId = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr")).lotId;
	var rowData = new Array();
	rowData.push({ cells: [ { value: "로트번호" }, { value: "부품코드" }, { value: "자재내역" }, { value: "재질" }, 
		{ value: "HCD" }, { value: "반납내역" }, { value: "잔재본수" }, { value: "반납량" }, { value: "반납일자" }, { value: "업체명" } ] });
	
	$.ajax({
		async:false,
		url : '/form/ship/orderCompleteMgt/selectReturnSurplusMtrl',
		type: "POST",
		data: {lotId: paramLotId},
		success: function(data){
			$.each(data.rows, function(index, item) {
				rowData.push({ cells: [ 
					{ value: item.lotId }, 
					{ value: item.itemNm },
					{ value: item.mtrlNm },
					{ value: gfn_getMsg('bc_'+ gfn_getCode(item.itemMtrl).cdId , gfn_getCode(item.itemMtrl).cdNm) },
					{ value: gfn_isNull(gfn_getCode(item.mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(item.mtrlHCD).cdId , gfn_getCode(item.mtrlHCD).cdNm) },
					{ value: item.receiveMtrlQty },
					{ value: item.receiveMtrlQty },
					{ value: item.mtrlMgtScrap },
					{ value: gfn_getDate("yyyy년 MM월 dd일") },
					{ value: "신 명 기 계" }]
				});
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	var fileName = gfn_getMsg("col_returnMtrlList") + "_" + gfn_getDate("yyyy_MM_dd") + ".xlsx"; 
	var workbook = new kendo.ooxml.Workbook({
		sheets: [
			{
				// The column settings (width).
				columns: [
					{ width: 150 },
					{ width: 100 },
					{ width: 100 },
					{ width: 100 },
					{ width: 100 },
					{ width: 100 },
					{ width: 100 },
					{ width: 100 },
					{ width: 120 },
					{ width: 100 },
				],
				// Th title of the sheet.
				title: gfn_getMsg("col_returnMtrlList"),
				// The rows of the sheet.
				rows: rowData
			}
		]
	});
	kendo.saveAs({
		dataURI: workbook.toDataURL(),
		fileName: fileName
	});
	
	
}

</script>