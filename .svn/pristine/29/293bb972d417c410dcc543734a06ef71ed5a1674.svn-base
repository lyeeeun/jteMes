
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="pickMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<span class="jte-search-aria"><label>Lot ID : </label>
		<input class="k-textbox" id="itemMgtId" readonly/>
		<button class="k-button k-primary" type="button" id="itemMgtSelBtn" onclick="lfn_itemMgtInfo()"><spring:message code = "btn_search"/></button>
		<label class="nc-pro-title">제품 명 : </label>
		<input class="k-textbox" id="itemNm" style="width:150px;" readonly/>
		<label class="nc-pro-title">비 포장 수량 : </label>
		<input class="k-textbox" id="itemStock" style="width:100px;" readonly/>
		<label class="nc-pro-title">포장수량 : </label>
		<input class="k-textbox" id="itemPackageStock" style="width:100px;" readonly/>
		<input type="hidden" id="itemId" readonly/>
	</div>
	<div id="grid-content" class="pickMgtForm pickMgtForm-gird">
		<div id="jteSingleGrid"></div>
	</div>
</div>


<div style="display:none;">
	<div id="pickInfo">
		<form id="pickInfo_form" class="pickInfoForm">
		<!-- 포장 작업 정보 -->
			<div class="pop_title">출고 정보</div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
				<colgroup>
					<col style="width: 24%;">
					<col style="width: 26%;">
					<col style="width: 24%;">
					<col style="width: 26%;">
				</colgroup>
				<tr>
				<!-- LoT코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_lotCd"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="popItemMgtId" name="itemMgtId" readonly/>
						<input type="hidden" id="popItemId" name="itemId"/>
						<input type="hidden" id="pickId" name="pickId"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i> 재고량 : </td>
					<td><input id="popItemStock" name="itemStock"  format="numeric" readonly/></td>
					<td><i class="fas fa-caret-right"></i> 포장수량 : </td>
					<td>
						<input id="pickQty" name="pickQty"  format="numeric" readonly/>
						<input type="hidden" id="prevPickQty" name="prevPickQty" />
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="description" name="description"/></td>
				</tr>
			</table>
			<div style="display:none">
				<input type="hidden" id="action" name="action" />
			</div>
		</form>
		<div class="pop_title">제품 Barcode</div>
		<div id="jtePopForm_grid"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('pickInfo');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="barcodeInfo">
		<div id="barcodeInfo_grid"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<link href='/resources/mes/css/contents/ship/pickMgt/pickMgtForm.css' rel="stylesheet">


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
		$('#itemMgtId').val(selectedItem.itemMgtId);
		$('#itemPackageStock').val(selectedItem.itemPackageStock);
		$('#itemStock').val(selectedItem.itemStock);
		$('#itemNm').val(selectedItem.itemNm);
				
		lfo_common.grid.dataSource.read();
	};
	gfn_openCustomPop('itemMgt',callback);
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
	lfo_common.popId = "pickInfo";
	
	//3.
	lfo_common.ctrlUrl = "/cform/ship/pickMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/selectPickInfo", auth:"", prmt:{}, dynamicPrmt:{itemMgtId: "itemMgtId"}, search: false},
		create:{url:"/setPickInfo", auth:"", openFunc: lfn_pickInfoPop_open, callback: lfn_pickInfoPop_save},
		update:{url:"/setPickInfo", auth:"", callback: lfn_pickInfoPop_save},
		destroy:{url:"/deletePickInfo", auth:"", callback: lfn_pickInfoPop_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "pickId",
		fields: {
			pickId : { type: "string" },
			itemMgtId : { type: "string" },
			pickQty : { type: "int" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			description : { type: "string" }
		}
	};
	 
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "editBtn",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_pickInfoPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("btn_search") , width: "90px"},																	//조회																//조회
		{field: "pickId", title: "출고 코드", width: "100px"},
	//	{field: "itemMgtId", title: "개별 품목(Lot) 코드", width: "100px"},
		{field: "pickQty", title: "포장 수량", width: "80px"},
		{field: "creatorId", title: "출고 담당자", width: "100px"},
		{field: "createdAt", title: "출고 일시", width: "100px"},
		{field: "description",  title: "비고", width: "100px"},
/* 		{field: "barcodeInfo", title: "바코드 정보", width:"140px",				//묶음정보
			template : function(rows) {
				return '<button class="k-button k-primary" type="button" onclick="lfn_barcodeInfo(this)">조회</button>';
			}
		} */
	];
	
	//7.
	lfo_common.selectBox = [
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_pickInfoPop_open = function(mode, selectedItem){
	var childItems = [];
	
	if($("#itemMgtId").val() == "" || $("#itemMgtId").val() == undefined) {
		kendo.confirm("출고하고자 하는 제품을 선택하여 주십시오.");
		return false;
	}
	
 	var options = {
		modal:true, 
		width: "840px",
		height: "411px",  //200507 출고 관리 그리드의 포장 작업 버튼 클릭 → 추가 버튼 클릭 시의 팝업창 height 변경_550->360px LYM 200511 JJW 550-> 410px 200810 youmi 430->468px
		id : lfo_common.popId, 
		title: "출고 정보 등록",			//포장 작업 등록
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		
		if(mode == "NEW") {
			gfn_popform_set(lfo_common, mode, selectedItem);
			
			$("#popItemStock").data("kendoNumericTextBox").value($("#itemStock").val());
			$("#popItemMgtId").val($("#itemMgtId").val());
			$("#popItemId").val($("#itemId").val());
		} else if (mode == "EDT"){
			selectedItem = $("#" + lfo_common.layoutId).data("kendoGrid").dataItem($(selectedItem).closest("tr"));
			gfn_popform_set(lfo_common, mode, selectedItem);
			
			$("#popItemStock").data("kendoNumericTextBox").value($("#itemStock").val());
			$("#popItemMgtId").val($("#itemMgtId").val());
			$("#popItemId").val($("#itemId").val());
			$("#prevPickQty").val(selectedItem.pickQty);
			
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + "/selectBarcodeInfoAll",
				type: "POST",
				data: {pickId : selectedItem.pickId},
				success: function(data){
					childItems = data.rows;
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
	lfo_popGrd.ctrlUrl = "/cform/ship/pickMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"", auth:"", prmt:{}},
		// create:{url:"", auth:"", openFunc: lfn_jtePopGrd_popOpen, callback:""}, 
		destroy:{url:"", auth:"", callback: lfn_barcodeDelete},
		excel:{url:"" ,auth:"", fileName: "Barcode_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")},
		upload:{callback : lfn_excelImport}
	};
	
	//5.
	lfo_popGrd.model = {
		fields: {
			pickId : { type: "string" },
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
			html : '<input type="text" class="k-textbox" id="inputBarcode" placeholder="바코드 입력"/><button class="k-button k-primary" onclick="lfn_barcode_selfInput()">바코드 저장</button>'
	};
	
	lfo_popGrd.childItems = childItems;
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_objectDatagrid_set(lfo_popGrd);
	
	//바코드 입력창 엔터 이벤트
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

this.lfn_pickQtyCal = function() {
	var deleteRowCount = 0;
	$.each(lfo_popGrd.grid.dataSource.data(), function(index, item) {
		if(item.action == "D"){
			deleteRowCount++;
		}
	})
	
	return deleteRowCount;
}

this.lfn_barcodeSave = function(savePrmt) {
	
	var childItems = gfn_objectDataGrid_save({tgObj : lfo_popGrd, prmt : savePrmt, pk : "barcodeId", autokey : false});
	if(!childItems){
		return false;
	}
	
	//데이터 object에 저장 - 부모요소 저장시 저장된다.
	lfo_popGrd.childItems = childItems;
	
	lfo_popGrd.grid.dataSource.read();
	$("#pickQty").data("kendoNumericTextBox").value(lfo_popGrd.grid.dataSource.total() - lfn_pickQtyCal());
	$("#inputBarcode").val("");
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
	
	$("#pickQty").data("kendoNumericTextBox").value(lfo_popGrd.grid.dataSource.total() - lfn_pickQtyCal());
}


this.lfn_pickInfoPop_save = function(mode){
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		/* if(parseInt(lfo_popGrd.selected.itemStock) < (parseInt($('#defectQty').val()) + parseInt($('#prsPackageQty').val()))) {
			kendo.confirm('불량 수량과 포장 수량의 합이 보유 재고량보다 클 수 없습니다.');
			return false;
		} */
		
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		savePrmt.barcodeList = lfo_popGrd.childItems;
		savePrmt.updatePickQty = $("#pickQty").val() - $("#prevPickQty").val();
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				
				lfn_reload_stock();
				
				gfn_closePop(lfo_common.popId);
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//삭제 콜백
this.lfn_pickInfoPop_delete = function(){
	if($("#itemMgtId").val() == "" || $("#itemMgtId").val() == undefined) {
		kendo.confirm("삭제하고자 하는 제품을 선택하여 주십시오.");
		return false;
	}
	
	var delPrmt = [];
	var delPackageQty = 0;
	
	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delTemp = lfo_common.grid.dataItem($(this).closest('tr'))
			delTemp.itemId = $("#itemId").val();
			delTemp.itemMgtId = $("#itemMgtId").val();
			delPrmt.push(delTemp);
			
			delPackageQty += delTemp.pickQty;
		}
	});

/* 	if(lfo_popGrd.selected.itemPackageStock < delPackageQty) {
		kendo.confirm(gfn_getMsg("pop_toManyDelPackageStock"));
		return false;
	} */
	
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

this.lfn_reload_stock = function() {
	var returnVal = gfn_ajaxCallByList('itemMgt', {itemMgtId: $("#itemMgtId").val()});
	$("#itemStock").val(returnVal.rows[0].itemStock);
	$("#itemPackageStock").val(returnVal.rows[0].itemPackageStock);
}


// this.lfn_barcodeInfo = function(rows) {
// 	var dataItem = $("#" + lfo_common.layoutId).data("kendoGrid").dataItem($(rows).closest("tr"));
// 	lfn_barcodeInfo_popOpen("READ", dataItem);
// }

// this.lfn_barcodeInfo_popOpen = function(mode, selectedItem){
// 	var options = {
// 		modal:true, 
// 		width: "720px",
// 		height: "500px",
// 		id:"barcodeInfo", 
// 		title:"Barcode 정보",
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
// 	lfo_barcodeGrd.ctrlUrl = "/cform/ship/pickMgt";
	
// 	//4.
// 	lfo_barcodeGrd.crud  = {
// 		read:{url:"/selectBarcodeInfo", auth:"", prmt:{pickId: selectedItem.pickId}, paging: false},
// 		excel:{url:"" ,auth:"", fileName: "Barcode_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
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