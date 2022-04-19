<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="shipMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<span class="jte-search-aria"><label>Lot ID : </label></span>
		<input class="k-textbox" id="itemMgtId" readonly/>
		<button class="k-button k-primary" type="button" id="itemMgtSelBtn" onclick="lfn_itemMgtInfo()"><spring:message code = "btn_search"/></button>
		<label class="nc-pro-title">제품 명 : </label>
		<input class="k-textbox" id="itemNm" style="width:150px;" readonly/>
		<label class="nc-pro-title">포장수량 : </label>
		<input class="k-textbox" id="itemPackageStock" style="width:100px;" readonly/>
		<input type="hidden" id="itemId" readonly />
		<input type="hidden" id="lotState" readonly />
		
		<button class="k-button k-primary" type="button" id="btnComplete" onclick="lfn_allShipComplete()" style="display:none;">전체 납품 완료</button>
	</div>
	<div id="grid-content" class="shipMgtForm shipMgtForm-gird" style="width:100%;">
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="shipInfo">
		<form id="shipInfo_form" class="shipInfoForm">
		<!-- 포장 작업 정보 -->
			<div class="pop_title">출하 정보</div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
				<colgroup>
					<col style="width: 22%;">
					<col style="width: 28%;">
					<col style="width: 25%;">
					<col style="width: 25%;">
				</colgroup>
				<tr>
				<!-- LoT코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_lotCd"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="popItemMgtId" name="itemMgtId" readonly/>
						<input type="hidden" id="shipId" name="shipId"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>출하 구분 : </td>
					<td><input id="shipType" name="shipType" format="selBox" msg="ship_type" /></td>
					<td><i class="fas fa-caret-right"></i>출하 수량 : </td>
					<td>
						<input id="shipQty" name="shipQty"  format="numeric" readonly/>
						<input type="hidden" id="prevShipQty" name="prevShipQty" />
					</td>
				</tr>
				<tr>
					<!-- 출하 예정일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipExceptDate"></spring:message> : </td>
					<td><input type="text" id="shipStartDate" name="shipStartDate" format="datetimepicker"/></td>
					<!-- 출하 완료일 -->
					<td class="completeDate" style="display:none"><i class="fas fa-caret-right"></i>출하 완료일 : </td>
					<td class="completeDate" style="display:none"><input type="text" id="shipCompleteDate" name="shipCompleteDate" format="datetimepicker"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>고객사 : </td>
					<td colspan="3">
						<input id="compNm" id="compNm" class="btn-input" name="compNm" readonly/>
						<input type="hidden" id="compId" name="compId" />
						<input type="hidden" id="compAddrId" name="compAddrId" />
						<button class="k-button k-primary" type="button"  onclick= "lfn_compInfo()"><spring:message code = "btn_search"/></button>			<!-- 조회 -->
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>고객사 주소 : </td>
					<td colspan="3"><input type="text" id="compAddrDetail" name="compAddrDetail" readonly/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="shipDesc" name="shipDesc"/></td>
				</tr>
			</table>
			<input type="hidden" name="action" id="shipAction"/>
		</form>
		
		<div class="pop_title">제품 Barcode</div>
		<div id="jtePopForm_grid"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('shipInfo');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="barcodeInfo">
		<div id="barcodeInfo_grid"></div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/ship/shipMgt/shipMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_jteSgGrd_setGrd();
};

this.lfn_itemMgtInfo = function() {
	var callback = function(selectedItem){
		$('#itemId').val(selectedItem.itemId);
		$('#itemNm').val(selectedItem.itemNm);
		$('#itemMgtId').val(selectedItem.itemMgtId);
		$('#itemPackageStock').val(selectedItem.itemPackageStock);
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/selectLotState",
			type: "POST",
			data: {itemMgtId : selectedItem.itemMgtId},
			success: function(data){
				$("#lotState").val(data.rows.lotState);
				
				if(data.rows.lotState != "ord_sta04") {
					$('#btnComplete').show();
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		
		lfo_common.grid.dataSource.read();
	};
	gfn_openCustomPop('itemMgt', callback);
}

this.lfn_compInfo = function() {
	var callback = function(selectedItem){
		$('#compId').val(selectedItem.compId);
		$('#compAddrId').val(selectedItem.compAddrId);
		$('#compNm').val(selectedItem.compNm);
		$('#compAddrDetail').val(selectedItem.compAddrDetail);
	};
	gfn_openCustomPop('shipComp', callback, {lotId: $("#itemMgtId").val()});
}

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
	lfo_common.popId = "shipInfo";
	
	//3.
	lfo_common.ctrlUrl = "/cform/ship/shipMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/selectShipInfo", auth:"", prmt:{}, dynamicPrmt:{itemMgtId: "itemMgtId"}, search: false},
		create:{url:"/setShipInfo", auth:"", openFunc: lfn_shipInfoPop_open, callback: lfn_shipInfoPop_save},
		update:{url:"/setShipInfo", auth:"", callback: lfn_shipInfoPop_save},
		destroy:{url:"/deleteShipInfo", auth:"", callback: lfn_shipInfoPop_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "shipId",
		fields: {
			shipId : { type: "string" },
			itemMgtId : { type: "string" },
			shipQty : { type: "int" },
			shipState : { type: "string" },
			shipType : { type: "string" },
			shipDesc : { type: "string" },
			shipStartDate : { type: "string" },
			shipCompleteDate : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			compAddrId : { type: "string" },
			compAddrDetail : { type: "string" },
			compAddrNumber : { type: "string" }
		}
	};
	 
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "search", title : gfn_getMsg("btn_search") , width: "90px",
			template : '<button class="k-button k-primary pop-off" type="button" onclick = "lfn_shipInfoPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'
		},																	//조회
		{field: "shipId", title: "출하 코드", width: "100px"},
	//	{field: "itemMgtId", title: "개별 품목(Lot) 코드", width: "100px"},
		{field: "shipQty", title: "출하 수량", width: "80px"},
		{field: "shipType",  template:"# var item = gfn_isNull(gfn_getCode(shipType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(shipType).cdId , gfn_getCode(shipType).cdNm) # #= item #",
			title : "출하 구분", width: "110px"},																//출하 구분
		{field: "shipDesc",  title: "비고", width: "100px"},
		{field: "shipStartDate",  title: "출하 시작일시", width: "100px"},
		{field: "shipCompleteDate",  title: "출하 완료일시", width: "100px"},
		{field: "compNm",  title: "고객사", width: "100px"},
		{field: "compAddrDetail",  title: "주소", width: "100px"},
		{field: "compAddrNumber",  title: "연락처", width: "100px"},
// 		{field: "barcodeInfo", title: "바코드 정보", width:"140px",				//묶음정보
// 			template : function(rows) {
// 				return '<button class="k-button k-primary" type="button" onclick="lfn_barcodeInfo(this)">조회</button>';
// 			}
// 		},
		{field: "shipOption", title:gfn_getMsg("col_shipOption"), width: "100px",											//출하옵션
			template : function(rows) {
				if(rows.shipState == 'ship_dvry02'){
					return '<button class="k-button k-primary" type="button" onclick="lfn_shipAction(this)">납품 확인</button>';
				} else {
					return '납품 완료';
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [];
	
	/* lfo_common.customTitle = {
			html : '<span class="jte-search-aria"><label>'+"Lot ID"+' : </label>'
			+ '<input class="k-textbox" id="itemMgtId" style="width:200px;" readonly/>'			//검색(UI)
			+ '<button class="k-button k-primary" type="button" id="itemMgtSelBtn" onclick="lfn_itemMgtInfo()"><spring:message code = "btn_search"/></button>'
			+ '<label class="nc-pro-title">'+"포장수량"+' : </label>'
			+ '<input class="k-textbox" id="itemPackageStock" style="width:100px;" readonly/>'
			+ '<input type="hidden" id="itemId" readonly/>'
		}; */
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_shipInfoPop_open = function(mode, selectedItem){
	var childItems = [];
	
	if($("#itemMgtId").val() == "" || $("#itemMgtId").val() == undefined) {
		kendo.confirm("출하하고자 하는 제품을 선택하여 주십시오.");
		return false;
	}
	
 	var options = {
		modal:true, 
		width: "900px",
		height: "470px",  /* JJW 300-> 470 */
		id : lfo_common.popId, 
		title: "출하 정보 등록",			//포장 작업 등록
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode == "NEW") {
			gfn_popform_set(lfo_common, mode, selectedItem);
			$("#popItemMgtId").val($("#itemMgtId").val());
		} else if (mode == "EDT"){
			
			selectedItem = $("#" + lfo_common.layoutId).data("kendoGrid").dataItem($(selectedItem).closest("tr"));
			gfn_popform_set(lfo_common, mode, selectedItem);
			
			$(".completeDate").show();
			$("#prevShipQty").val(selectedItem.shipQty);
			
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + "/selectShipRtlBarcode",
				type: "POST",
				data: {shipId : selectedItem.shipId},
				success: function(data){
					childItems = data.rows.shipRtlBarcodeList;
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		}
		
		lfn_jtePopGrd_setGrd(childItems);
	};
	this.gfn_winOpen(options);
}

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(childItems){
	$("#jtePopForm_grid").html("");
	lfo_popGrd = {};
	
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
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	lfo_popGrd.popId = "jtePopAddForm";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/ship/shipMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"", auth:"", prmt:{}},
		//create:{url:"", auth:"", openFunc: lfn_jtePopGrd_popOpen, callback:""}, 
		destroy:{url:"", auth:"", callback: lfn_barcodeDelete},
		excel:{url:"" ,auth:"", fileName: "Barcode_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")},
		upload:{callback : lfn_excelImport}
	};
	
	//5.
	lfo_popGrd.model = {
		fields: {
			shipId : { type: "string" },
			barcodeId : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '기존' : '에러' #",
			title:"액션", width: "95px"},
		{field: "barcodeId", title: "Barcode", width: "300px;"}
	];
	
	//7.
	lfo_popGrd.selectBox = [
	];
	
	lfo_popGrd.customTitle = {
			html : '<input type="text" class="k-textbox" id="inputBarcode" /><button class="k-button k-primary" onclick="lfn_barcode_selfInput()">Barcode Save</button>' 
		};
	
	lfo_popGrd.childItems = childItems;
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_objectDatagrid_set(lfo_popGrd);
	
	$("#inputBarcode").keydown(function(key) {
		if (key.keyCode == 13) {
			lfn_barcode_selfInput();
		}
	});
}

//바코드 수동입력 시 수행
this.lfn_barcode_selfInput = function(){
	if($("#inputBarcode").val() == "" || $("#inputBarcode").val() == undefined){
		kendo.confirm("Barcode 값이 입력되지 않았습니다.")
		return false;
	}
	
	savePrmt = {};
	savePrmt.action = "C";
	savePrmt.barcodeId = $("#inputBarcode").val();
	
	lfn_barcodeSave(savePrmt);
}

this.lfn_shipQtyCal = function() {
	var deleteRowCount = 0;
	$.each(lfo_popGrd.grid.dataSource.data(), function(index, item) {
		if(item.action == "D"){
			deleteRowCount++;
		}
	})
	
	return deleteRowCount;
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode, selectedItem){
	var callback = function(selectedItem){
		savePrmt = {};
		savePrmt.action = "C";
		savePrmt.barcodeId = selectedItem.barcodeId;
		
		var childItems = gfn_objectDataGrid_save({tgObj : lfo_popGrd, prmt : savePrmt, pk : "barcodeId", autokey : false});
		if(!childItems){
			return false;
		}
		
		//데이터 object에 저장 - 부모요소 저장시 저장된다.
		lfo_popGrd.childItems = childItems;
		
		lfo_popGrd.grid.dataSource.read();
		
		$("#shipQty").data("kendoNumericTextBox").value(lfo_popGrd.grid.dataSource.total() - lfn_shipQtyCal());
	};
	gfn_openCustomPop('Barcode', callback, {itemMgtId: $("#itemMgtId").val()});
}

this.lfn_barcodeSave = function(savePrmt) {
	
	$.ajax({
		async:false,
		url : "/cform/ship/pickMgt/selectBarcodeInfoAll",
		type: "POST",
		data: {itemMgtId : $("#itemMgtId").val(), barcodeId : savePrmt.barcodeId},
		success: function(data){
			// Lot에 포함 된 Barcode 정보인지 검사
			if(data.rows.length != 0) {
				
				var childItems = gfn_objectDataGrid_save({tgObj : lfo_popGrd, prmt : savePrmt, pk : "barcodeId", autokey : false});
				if(!childItems){
					return false;
				}
				
				//데이터 object에 저장 - 부모요소 저장시 저장된다.
				lfo_popGrd.childItems = childItems;
				
				lfo_popGrd.grid.dataSource.read();
				$("#shipQty").data("kendoNumericTextBox").value(lfo_popGrd.grid.dataSource.total() - lfn_shipQtyCal());
				$("#inputBarcode").val("");
			} else {
				// Enter Event를 통해 Kendo Confirm 호출 시, 팝업이 뜨지 않는 문제 있음.
				setTimeout(function(){kendo.confirm("해당 Lot와 관련 없는 Barcode 정보입니다.\n다시 입력하여 주십시오.");}, 200); //Main
				
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
}

this.lfn_barcodeDelete = function(){
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delPrmt = lfo_popGrd.grid.dataItem($(this).closest('tr'));
			
			//데이터 object에 저장 - 부모요소 저장시 저장(삭제)된다.
			gfn_objectDataGrid_delete({tgObj : lfo_popGrd, prmt : delPrmt, pk : "barcodeId"});
		}
	});
	
	lfo_popGrd.grid.dataSource.read();
	
	$("#shipQty").data("kendoNumericTextBox").value(lfo_popGrd.grid.dataSource.total() - lfn_shipQtyCal());
}

this.lfn_shipInfoPop_save = function(mode){
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		savePrmt.shipRtlBarcodeList = lfo_popGrd.childItems;
		savePrmt.updateShipQty = $("#shipQty").val() - $("#prevShipQty").val();
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				//마스터 그리드 리로드
				lfo_common.grid.dataSource.read();
				
				gfn_closePop(lfo_common.popId);
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				lfn_reload_stock();
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//삭제 콜백
this.lfn_shipInfoPop_delete = function(){
	if($("#itemMgtId").val() == "" || $("#itemMgtId").val() == undefined) {
		kendo.confirm("삭제하고자 하는 제품을 선택하여 주십시오.");
		return false;
	}
	
	var delPrmt = [];
	
	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delTemp = lfo_common.grid.dataItem($(this).closest('tr'))
			delPrmt.push(delTemp);
		}
	});

	kendo.confirm("계속 진행하시겠습니까?")
	.done(function(){
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.destroy.url,
			type: "POST",
			data: JSON.stringify(delPrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				lfn_reload_stock();
				
				gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});		//성공적으로 삭제되었습니다.
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}).fail(function(){return false;});
	
}

this.lfn_shipAction = function(selectedItem) {
	var shipActionPrmt = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
	shipActionPrmt.action = "U";
	shipActionPrmt.shipState = "ship_dvry03";
	shipActionPrmt.lotState = $("#lotState").val();
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/setShipInfo",
		type: "POST",
		data: JSON.stringify(shipActionPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			
			lfn_reload_stock();
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "정상적으로 납품 완료 처리 되었습니다.")});		//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

this.lfn_reload_stock = function() {
	var returnVal = gfn_ajaxCallByList('itemMgt', {itemMgtId: $("#itemMgtId").val()});
	$("#itemStock").val(returnVal.rows[0].itemStock);
	$("#itemPackageStock").val(returnVal.rows[0].itemPackageStock);
}

this.lfn_allShipComplete = function() {
	
	if($("#itemMgtId").val() == "" || $("#itemMgtId").val() == undefined) {
		kendo.confirm("생산된 제품을 먼저 선택하여 주십시오.");
		return false;
	}
	
	
	kendo.confirm("납품 완료 시, 이전 상태로 돌릴 수 없습니다. 계속 진행하시겠습니까?")
	.done(function(){

		var savePrmt = {};
		savePrmt.itemMgtId = $("#itemMgtId").val();
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/allShipComplete",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				$('#btnComplete').hide();
				$('#lotState').val('ord_sta04');
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "정상적으로 납품 완료 처리 되었습니다.")});		
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		
	}).fail(function(){return false;});
	
}


// this.lfn_barcodeInfo = function(rows) {
// 	var dataItem = $("#" + lfo_common.layoutId).data("kendoGrid").dataItem($(rows).closest("tr"));
// 	lfn_barcodeInfo_popOpen("READ", dataItem);
// }

// this.lfn_barcodeInfo_popOpen = function(mode, selectedItem){
// 	var options = {
// 		modal:true, 
// 		width: "631px", /* 201208 JJW 새로고침 줄바뀜 수정 */
// 		height: "500px",
// 		id:"barcodeInfo", 
// 		title:"Barcode 정보",			//포장 묶음 정보 등록
// 		resizable:true,
// 		animation:{open :{effects:"expand:vertical fadeIn"},
// 		close :{effects:"expand:vertical fadeIn", reverse: true}},
// 		actions:[/*"Minimize", "Maximize", */"Close"]
// 	};
	
// 	//팝업이 생성된 뒤 동작해야할 함수 입력
// 	options.callback = function(){
// 		lfn_barcodeInfo_setGrd(selectedItem);
// 		$('#barcodeInfo_grid').parent().css('height', '100%');
// 	};
// 	this.gfn_winOpen(options);
// }

// this.lfn_barcodeInfo_setGrd = function(selectedItem){
// 	lfo_barcodeGrd = {};
// 	//1.
// 	lfo_barcodeGrd.layoutId = "barcodeInfo_grid";
	
// 	//2.
// 	lfo_barcodeGrd.popId = "";
	
// 	//3.
// 	lfo_barcodeGrd.ctrlUrl = "/cform/ship/shipMgt";
	
// 	//4.
// 	lfo_barcodeGrd.crud  = {
// 		read:{url:"/selectBarcodeInfo", auth:"", prmt:{shipId: selectedItem.shipId}, paging: false},
// 		excel:{url:"" ,auth:"", fileName: "Barcode_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")},
// 	};
	
// 	//5.
// 	lfo_barcodeGrd.model = {
// 		fields: {
// 			barcodeId : { type: "string" }
// 		}
// 	};
	
// 	//6.
// 	lfo_barcodeGrd.columns = [
// 		{field: "barcodeId", title: "Barcode", width: "100px;"}			
// 	];
	
// 	lfo_barcodeGrd.selectBox = [
// 		{ text: "Barcode", value: "barcodeInfo.barcodeId" }, 		
// 	];
	
// 	//공통 그리드 세팅 호출
// 	lfo_barcodeGrd.grid = gfn_grid_set(lfo_barcodeGrd);
// }


//엑셀 업로드
this.lfn_excelImport = function(saveList){
	for(var key in saveList){
		var savePrmt = {};
		savePrmt.barcodeId = saveList[key].Barcode;
		savePrmt.action = 'C';
		lfn_barcodeSave(savePrmt);
	}
}

</script>