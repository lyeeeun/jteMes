<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="orderDetailMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="orderDetailMgtForm"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm" class="jtePopForm">  <!-- style="margin-top: 5px;" -->
		<form id="jtePopForm_form" class="jtePopForm_form orderDetailMgtForm orderDetailMgtForm_jtePopForm_form">
			<div class="pop_title"><spring:message code = "pop_orderInfo" text = "수주정보"/></div>
			<table id="jtePopForm_master" class="jtePopForm_master">
			<colgroup>
				<col class="col-left-title"> 
				<col class="col-left-content-1">
				<col class="col-left-content-2">
				<col class="col-right-title">
				<col class="col-right-content-1">
				<col class="col-right-content-2">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_slipNum" text = "전표번호"/> : </td>
					<td colspan="2"><input type="text" id="slipNum" class="left-input" name="slipNum" format="text"/></td> 
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_compNm" text = "업체명"/> :  </td>
					<td>
						<input type="text" id="compNm" class="right-input btn-input" name="compNm" format="text" readonly/> 
						<input type="hidden" id="compId" class="right-input btn-input" name="compId"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" id="compInfoBtn" onclick="lfn_supplierPop_Open()" style="display:none;">
						<spring:message code="btn_search" text = "조회"/></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_ordDate" text = "일자"/> : </td>
					<td colspan="2"><input id="orderStdt" class="left-input" name="orderStdt" format="datepicker"/></td> 
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_delDate" text = "납품 예정일"/> : </td>
					<td colspan="2"><input id="orderEddt" class="right-input" name="orderEddt" format="datepicker"/></td> 
				</tr>
				<tr>
					<td>
						<i class="fas fa-caret-right"></i><spring:message code="col_lotQty" text = "LoT수량"/> : 
					</td>
					<td colspan="2">
						<input id="lotQty" class="left-input" name="lotQty" format="currency"/>
					</td>
					
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code="col_itemNm" text = "제품명"/> : 
					</td>
					<td>
						<input type="text" id="itemNm" class="right-input btn-input" name="itemNm" format="text" readonly/>
						<input type="hidden" id="itemId" class="right-input btn-input" name="itemId"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  id="itemInfoBtn" onclick="lfn_itemInfoPop_Open(lfn_itemInfoPop_callback)" style="display:none;">
						<spring:message code="btn_search" text = "조회"/></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_manager" text = "관리자"/> : </td>
					<td>
						<input type="text" id="orderManagerNm" class="right-input btn-input" name="orderManagerNm" format="text" readonly/> 
						<input type="hidden" id="orderManager" class="right-input btn-input" name="orderManager"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
						<spring:message code="btn_search" text = "조회"/></button>
					</td>
					
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_desc" text = "설명"/> : </td>
					<td colspan="5"><textarea id="description" class="center-input" name="description" class="k-textbox" rows="3"></textarea></td>  
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="orderId" id="orderId"/>
						<input type="hidden" name="action" id="orderAction"/>
						<input type="hidden" name="compNm" id="compNm"/>
						<input type="hidden" name="compStdStr02" id="compStdStr02"/>
						<input type="hidden" name="itemNm" id="itemNm"/>
						<input type="hidden" name="itemStdStr01" id="itemStdStr01"/>
						<input type="hidden" name="itemStdStr02" id="itemStdStr02"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
			</div>
		</form>
	
	</div>
</div>

	<!-- 발주주문서 팝업 -->
	<div id="jteOrderTiePop" class="mtrlOdplanMgtForm">
		<form id="jteOrderTiePop_form" class="mtrlOdplanMgtForm">
		<!-- 발주주문서 -->
			<div class="pop_title"><spring:message code = "col_orderTieForm" text="묶음주문서" /></div>
			<table id="jteOrderTiePop_master" class="BasicTable">
			<colgroup> <!-- 13 27 13 27 -->
				<col style="width: 24%;">
				<col style="width: 28%;">
				<col style="width: 20%;">
				<col style="width: 28%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_orderTieCd" text="수주묶음코드" /> : </td>
					<td><input type="text" id="tieId" name="tieId" placeholder="<spring:message code = "pop_autoInput" text='자동입력'/>" readonly/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="orderForm_use"/>
						<input type="hidden" name="action" id="orderForm_action"/>
						<input type="hidden" name="orderId" id="orderId"/>
					</td>
				</tr>
			</table>
		</form>
		<!-- 발주리스트 -->
		<div class="pop_title mtrlOdplanMgtForm"><spring:message code = "pop_orderList" text="수주리스트" /></div>
		<div id="jteOrderTieGrid" class="mtrlOdplanMgtForm" style="height:300px; width:98%; margin:auto;"></div>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"/></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"/></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteOrderTiePop');"><spring:message code = "pop_cancel"/></button>
		</div>
	</div>

<div style="display:none;">
	<div id="searchItemMgt">
		<div id="itemMgt_grid"></div>
	</div>
</div>

<link href='/resources/mes/css/contents/orderMgt/orderDetailMgt/orderDetailMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {}; 

var lfo_orderTiePopForm = {};

var lfo_orderTiePopGrd = {};
//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/orderMgt/orderDetailMgt";

	lfo_common.crud  = {
		read:{url:"/getOrderList", auth:"", prmt:{}, dynamicPrmt:{itemId : "itemId"}},
		create:{url:"/setOrderInfoSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave},
		update:{url:"/setOrderInfoSave", auth:"", openFunc:"", callback:lfn_popSave},
		destroy:{url:"/setOrderInfoDelete", auth:"", callback:lfn_jtePop_delete}
	};

	lfo_common.model = {
		id: "orderId",
		fields: {
			orderId: { type: "string" },
			orderNm: { type: "string" },
			orderManager: { type: "string" },
			orderStdt: { type: "date" },
			orderEddt: { type: "date" },
			orderCost: { type: "int" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			description: { type: "string" },
			orderState: { type: "string" },
			compId: { type: "string" },
			orderManagerNm: { type: "string" },
			compNm: { type: "string" },
			lotId: { type: "string" },
			lotState: { type: "string" },
			itemId: { type : "string" },
			itemNm : { type : "string" },
			lotQty : { type : "string" }
		}
	};

	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "80px"},
		{field: "slipNum", title:gfn_getMsg("col_slipNum", "전표번호"), width:"110px"},
		//{field: "orderId", title:gfn_getMsg("col_orderCd", "수주코드"), width: "120px"},
		//{template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm", "수주명"), width: "180px"},
		//{field: "orderManagerNm", title:gfn_getMsg("col_manager", "관리자"), width: "100px"},
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_ordDate", "일자"), width: "100px"},
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_delDate", "납품예정일"), width: "100px"},
		{field: "itemStdStr02", title:gfn_getMsg("col_itemStdStr02", "제품번호"), width: "110px;"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm", "제품명"), width: "150px;"},
		{field: "itemStdStr01", title:gfn_getMsg("col_itemStdStr01", "제품규격"), width: "150px;"},
		{field: "lotQty", title:gfn_getMsg("col_lotQty", "LoT수량"), width: "110px;"},
		{field: "compStdStr02", title:gfn_getMsg("col_compStdStr02", "거래처번호"), width: "110px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "150px"},
/*		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
			title:gfn_getMsg("col_lotStatus", "LoT상태"), width: "120px;"}, */
		{field: "description", title:gfn_getMsg("col_desc", "설명"), width: "240px"}
	];
	
	lfo_common.customTitle = {
		html :	'<button class="k-button k-primary" type="button" onclick = "gfn_excelUplodePop(\'orderDetailMgt\'); " style="min-width:60px; float: right;">엑셀 업로드</button>'
	}
	
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm", "제품명"), value: "itemInfo.item_nm" },
		{ text: gfn_getMsg("col_orderNm", "수주명"), value: "orInfo.order_nm"},
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_orderCd", "수주코드"), value: "orInfo.order_id" }
	];

	lfo_common.validation ={
		orderStdt:{
			messages : "수주일을 등록하세요",
			rules : function(input){
				if(input.is("[name=orderStdt]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		orderEddt:{
			messages : "납기일을 등록하세요",
			rules : function(input){
				if(input.is("[name=orderEddt]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		orderManager:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=orderManager]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 담당자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		},
		compId:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=compId]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 업체를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	//엑셀 업로드 갱신을 위해 30초마다 그리드 load
	//setInterval(function(){lfo_common.grid.dataSource.read();}, 30 * 1000);
	
	//발주주문서 버튼추가
/*  	$("#"+lfo_common.layoutId + " .k-grid-toolbar").append('<a role="button" class="k-button k-button-icontext jte-order" style="float: right !important"></span>수주묶음정보</a>')
	
	$("#"+lfo_common.layoutId + " .k-grid-toolbar").find(".jte-order").on("click",function(){
		//팝업오픈
		this.lfn_orderTieForm_open();
	}); */
}

//그리드 세팅
this.lfn_mtrlMgtGrid = function(){
	
	lfo_itemMgtGrd = {};//Form 내부에서 사용될 Object

	//1.
	lfo_itemMgtGrd.layoutId = "itemMgt_grid";
	
	//2.
	lfo_itemMgtGrd.popId = "searchItemMgt";
	
	//3.
	lfo_itemMgtGrd.ctrlUrl = "/cform/basMgt/operMgt/itemMgt";

	//4.
	lfo_itemMgtGrd.crud  = {
		read:{url:"/getItemList", auth:"", prmt:{}, search: false}
	};
	
	//5.
	lfo_itemMgtGrd.model = {
		fields: {
			itemId: { type: "string" },
			itemNm: { type: "string" },
			itemPrice: { type: "int" },
			itemMtrlCost: { type: "int" },
			itemPersonCost: { type: "int" },
			itemType: { type: "string" },
			itemStd01: { type: "int" },
			itemStd02: { type: "int" },
			itemStd03: { type: "int" },
			itemStd04: { type: "int" },
			itemStd05: { type: "int" },
			itemStdStr01: { type: "string" },
			itemStdStr02: { type: "string" },
			itemStdStr03: { type: "string" },
			itemStdStr04: { type: "string" },
			itemStdStr05: { type: "string" },
			itemStdStr06: { type: "string" },
			description: { type: "string" },
			isUse: { type: "bool" }
		},
	};
	
	//6.
	lfo_itemMgtGrd.columns = [
		{field: "itemId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_itemMgt_callback(this,\'EDT\') " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},
		{field: "itemId", title:gfn_getMsg("col_itemCd", "부품코드"), width: "120px"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm", "부품명"), width: "220px"},
		{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
			title:gfn_getMsg("col_itemType", "부품유형"), width: "110px"},
		{field: "itemStd05", title : "최소재고", attributes: { style: "color: red; font-weight:bold;  text-align:right;" }, width: "160px"},
		{field: "description", title:"사용 목적", width: "270px"}
	];
	
	//공통 그리드 세팅 호출 
	lfo_itemMgtGrd.grid = gfn_grid_set(lfo_itemMgtGrd);

}

this.lfn_itemMgt_callback = function(selectedItems){
	
	var selectedItem = lfo_itemMgtGrd.grid.dataItem($(selectedItems).closest('tr'));

	$("#itemId").val(selectedItem.itemId);
	$("#itemNm").val(selectedItem.itemNm);
	
	gfn_closePop("searchItemMgt");
	
	lfo_common.grid.dataSource.read();
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "860px",
		height: "580px",
		id : lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_orderRegist", "수주 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_orderSrh", "수주 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = {};
	
	if(mode=='NEW'){
		$("#itemInfoBtn").show();
		$("#compInfoBtn").show();
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {orderId : selectedItem};
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {orderId : lfo_common.gridSelected.orderId},
			success: function(data){
				//주문 form setting
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});
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
		savePrmt.compStdStr02 = $("#compStdStr02").val();
		savePrmt.compNm = $("#compNm").val();
		savePrmt.itemNm = $("#itemNm").val();
		savePrmt.itemStdStr01 = $("#itemStdStr01").val();
		savePrmt.itemStdStr02 = $("#itemStdStr02").val();
		//savePrmt.orderNm = ($("#slipNum") + $("#orderStdt")).val();
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
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
					//lfn_jtePop_set('EDT',data);
					
					gfn_closePop(lfo_common.popId);
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", gfn_getMsg("pop_successSave"))});
					
					lfo_common.grid.dataSource.read();
				}else{
					gfn_errBox(gfn_getMsg("pop_failedConfirm", gfn_getMsg("pop_failedCheck")));
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});
			}
		});
	}
}

//삭제 콜백
this.lfn_jtePop_delete = function(){
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
			if(data == "bad"){//에러
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}else if(data == "workBad"){//작업진행중(삭제진행X)
				gfn_warnBox({title : "경고", msg:"작업이 이미 진행중."});
			}
			else if(data == "workBad1"){//작업진행중(삭제진행X)
				gfn_warnBox({title : "경고", msg:"작업이 이미 시작된 주문이 존재합니다."});
			}else if(data == "success"){//성공
				lfo_common.grid.dataSource.read();
				gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});	
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//발주주문서 팝업 오픈
this.lfn_orderTieForm_open = function(){
	var options = {
		modal:true, 
		width: "800px", 
		height: "580px", 
		id : "jteOrderTiePop", 
		title: gfn_getMsg("pop_tieRegist", "수주묶음등록"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_orderTieForm_set();};
	this.gfn_winOpen(options);
}

//발주주문서 팝업ui 세팅
this.lfn_orderTieForm_set = function(){
	lfo_orderTiePopForm = {
		popId : "jteOrderTiePop",
		ctrlUrl : "/cform/orderMgt/orderDetailMgt",
		crud  : {
			create:{url:"/setOrderTieSave", auth : "", openFunc : "", callback : lfn_orderTieForm_save}, 
		}
		//data : {mtrlOfDate : new Date(), mtrlOfCost : 0}
	};
	
	//선택된 데이터 배열에 담기
	var orderTieList = [];
	
	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var selectedItems = lfo_common.grid.dataItem($(this).closest('tr'))
			//선택된 데이터 저장
			orderTieList.push(selectedItems);
		}
	});
	
	//발주주문서 팝업 세팅
	gfn_popform_set(lfo_orderTiePopForm, 'NEW',lfo_orderTiePopForm.data);
	
	//발주주문서 그리드생성
	this.lfn_orderTie_dataSet(orderTieList);
}


//커스텀 버튼팝업 데이터 준비(Object data) 일반 그리드 데이터와 조금 차이가 있다.
//발주주문서 데이터 세팅
this.lfn_orderTie_dataSet = function(orderTieList){
	lfo_orderTiePopGrd = {};//Form 내부에서 사용될 Object

	lfo_orderTiePopGrd.layoutId = "jteOrderTieGrid";

	lfo_orderTiePopGrd.ctrlUrl = "/cform/orderMgt/orderDetailMgt"

	lfo_orderTiePopGrd.crud  = {
	};

	lfo_orderTiePopGrd.model = {
		id: "orderId",
		fields: {
			orderId: { type: "string" },
			orderNm: { type: "string" },
			orderManager: { type: "string" },
			orderStdt: { type: "date" },
			orderEddt: { type: "date" },
			orderCost: { type: "int" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			description: { type: "string" },
			orderState: { type: "string" },
			compId: { type: "string" },
			compNm: { type: "string" },
			compStdStr02: { type: "string" },
			compNumber: { type: "string" },
			orderManagerNm: { type: "string" },
			compNm: { type: "string" },
			lotId: { type: "string" },
			lotState: { type: "string" },
			itemId: { type : "string" },
			itemNm : { type : "string" },
			lotQty : { type : "string" }
		}
	};

	lfo_orderTiePopGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "orderId", title:gfn_getMsg("col_orderCd", "수주코드"), width: "120px"},
		{template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm", "수주명"), width: "180px"},
		{field: "orderManagerNm", title:gfn_getMsg("col_manager", "관리자"), width: "100px"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm", "제품명"), width: "150px;"},
		{field: "lotQty", title:gfn_getMsg("col_lotQty", "LoT수량"), width: "120px;"},
		/*{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
			title:gfn_getMsg("col_lotStatus", "LoT상태"), width: "120px;"},*/
		{field: "description", title:gfn_getMsg("col_desc", "설명"), width: "220px"},
		{field: "compStdStr02", title:gfn_getMsg("col_compStdStr02", "거래처코드"), width: "130px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "190px"},
		{field: "compNumber", title:gfn_getMsg("col_busiNum", "사업자번호"), width: "160px"}
	];

	lfo_orderTiePopGrd.selectBox = [
	];
	
	lfo_orderTiePopGrd.childItems = orderTieList;
	
	//grid 생성
	lfo_orderTiePopGrd.grid = gfn_objectDatagrid_set(lfo_orderTiePopGrd);
}

//발주 주문서 Form내용 입력/저장
this.lfn_orderTieForm_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_orderTiePopForm.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_orderTiePopForm.popId+"_form").serializeObject();
		
		//선택되었던 발주목록 매핑
		savePrmt.orderTieList = lfo_orderTiePopGrd.childItems;
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_orderTiePopForm.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_orderTiePopForm.ctrlUrl + lfo_orderTiePopForm.crud.create.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_orderTiePopForm.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
					
					//마스터그리드 리로드
					lfo_common.grid.dataSource.read();
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
//pop - 공급처 팝업 오픈
this.lfn_supplierPop_Open = function(){
	gfn_openCustomPop('customer',lfn_supplierPop_callback);
}

//pop - 공급처 팝업 콜백
this.lfn_supplierPop_callback = function(rtnObj){
	$("#compNm").val(rtnObj["compNm"]);
	$("#compId").val(rtnObj["compId"]);
	$("#compStdStr02").val(rtnObj["compStdStr02"]);
}

//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

//pop - 유저정보 팝업 콜백
this.lfn_userInfoPop_callback = function(rtnObj){
	$("#orderManager").val(rtnObj["userId"]);
	$("#orderManagerNm").val(rtnObj["userNm"]);
}

//pop - 부품정보 팝업 오픈
this.lfn_itemInfoPop_Open = function(call){
	gfn_openCustomPop('item',call);
}

//pop - 부품정보 팝업 콜백
this.lfn_itemInfoPop_callback = function(rtnObj){
	$("#itemId").val(rtnObj["itemId"]);
	$("#itemNm").val(rtnObj["itemNm"]);
	$("#itemStdStr01").val(rtnObj["itemStdStr01"]);
	$("#itemStdStr02").val(rtnObj["itemStdStr02"]);
}

</script>