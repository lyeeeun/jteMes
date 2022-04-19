<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="orderDetailMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="orderDetailMgtForm"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm" class="jtePopForm">  <!-- style="margin-top: 5px;" -->
		<form id="jtePopForm_form" class="jtePopForm_form orderDetailMgtForm orderDetailMgtForm_jtePopForm_form">
			<div class="pop_title"><spring:message code = "pop_orderInfo"></spring:message></div>
			<table id="jtePopForm_master" class="jtePopForm_master">  <!-- style="width:100%;" -->
			<colgroup>  <!-- 200507 원래는 col 4개에 각각의 width가 15 35 15 35였으나 col 6개로 변경_LYM -->
				<col class="col-left-title"> 
				<col class="col-left-content-1">
				<col class="col-left-content-2">
				<col class="col-right-title">
				<col class="col-right-content-1">
				<col class="col-right-content-2">
			</colgroup>
				<tr>
				<!-- 수주코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_orderCd" /> : </td>
					<td colspan="2"><input type="text" id="orderId" class="left-input" name="orderId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td> 		<!-- 자동생성 -->
				<!-- 업체명 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_compNm" /> :  </td>
					<td>
						<input type="text" id="compNm" class="right-input btn-input" name="compNm" format="text" readonly/> 
						<input type="hidden" id="compId" class="right-input btn-input" name="compId"/>
						<input type="hidden" id="compInitials" class="right-input btn-input" name="compInitials"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_supplierPop_Open()">
				<!-- 조회 -->
						<spring:message code="btn_search" /></button>
					</td>
				</tr>
 				<tr>
				<!-- 수주명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_orderNm" /> : </td>
					<td colspan="5"><input type="text" id="orderNm" class="center-input" name="orderNm" format="text"/></td> 
				</tr>
				<tr>
				<!-- 수주일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_orderDate" /> : </td>
					<td colspan="2"><input id="orderStdt" class="left-input" name="orderStdt" format="datepicker"/></td> 
				<!-- 납기일 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_deliveryDate" /> : </td>
					<td colspan="2"><input id="orderEddt" class="right-input" name="orderEddt" format="datepicker"/></td> 
				</tr>
				<tr>
				<!-- 비용 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_cost" /> : </td>
					<td colspan="2"><input id="orderCost" class="left-input" name="orderCost"  format="currency"/></td> 
				<!-- 관리자 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_manager" /> : </td>
					<td>
						<input type="text" id="orderManagerNm" class="right-input btn-input" name="orderManagerNm" format="text" readonly/> 
						<input type="hidden" id="orderManager" class="right-input btn-input" name="orderManager"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
				<!-- 조회 -->
						<spring:message code="btn_search" /></button>
					</td>
					
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_desc" /> : </td>
					<td colspan="5"><input type="text" id="description" class="center-input" name="description" class="k-textbox"/></td>  
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="orderAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		<div id="jtePopForm_gridArea" style="display:none;">
			<div class="pop_title"><spring:message code = "pop_lotInfo"></spring:message></div>			<!-- LoT정보 -->
			<div id="jtePopForm_grid" class="orderDetailMgtForm"></div>
		</div>
	</div>
</div>

<div style="display:none;"> <!-- 수주 관리 그리드 더블클릭 → 팝업창 하단 그리드 더블 클릭 혹은 추가 버튼 클릭 시의 팝업창-->
	<div id="jtePopAddForm" class="jtePopAddForm">
		<form id="jtePopAddForm_form" class="jtePopAddForm_form orderDetailMgtForm orderDetailMgtForm_jtePopAddForm_form">
			<div class="pop_title"><spring:message code = "col_interimLotInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopAddForm_master" class="jtePopAddForm_master">
			<colgroup>  <!-- 200507 원래는 col 4개에 각각의 width가 15 35 15 35였으나 col 6개로 변경_LYM -->
				<col class="popsc-col-left-title"> 
				<col class="popsc-col-left-content-1">
				<col class="popsc-col-left-content-2">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content-1">
				<col class="popsc-col-right-content-2">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_interimLotCd"></spring:message> : </td>
					<td colspan="5"><input type="text" id="midlotId" class="left-input" name="midlotId" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_productionLine"></spring:message> : </td>
					<td>
						<input id="placeId" class="left-input" name="placeId" format = "selBox" custom="true" keyGbn="placeId" keyText="placeNm" func="lfn_placeParentOrder_get()" />
						<input type="hidden" id="placeNm" name="placeNm"/>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_orderCd"></spring:message> : </td>
					<td><input type="text" id="orderId" class="left-input" name="orderId" readonly/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="orderId" id="lotOrderId"/>
						<input type="hidden" name="action" id="midlotAction"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 중간분류 LOT POP -->
<div style="display:none;">
	<div id="jtePopRelDoc">   <!-- style="height:100%" -->
		<div class="pop_title"><spring:message code = "pop_lotSrh"></spring:message></div>
		<div id="jtePopBaseLot_grid" class="baseLotMgtForm" style="height:350px;"></div>
	</div>
</div>

<!-- 중간분류 LOT 등록/수정 팝업(서브 그리드 > 관련문서조회 버튼 클릭) -->
<div style="display:none;">
	<div id="jtePopQcDocAdd">
		<form id="jtePopQcDocAdd_form" class="orderDetailMgtForm baseLotMgtForm">
		<div class="pop_title"><spring:message code = "pop_lotInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopQcDocAdd_master" class="jtePopQcDocAdd_master">
			<colgroup>
				<col class="poptr-col-left-title"> <!-- 15 25 15 25 --> <!-- 200511 JJW 조회버튼을 위해 col 하나 더 추가 -->
				<col class="poptr-col-left-content-1">
				<col class="poptr-col-left-content-2">
				<col class="poptr-col-right-title">
				<col class="poptr-col-right-content-1">
				<col class="poptr-col-right-content-2">				
			</colgroup>
				<tr>
				<!-- Lot코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotCd" />
					<i class="fas fa-info-circle" title="중간LoT ID값이 앞에 입력되어 LoT ID값이 부여됩니다."></i> : </td>   <!-- style="background:yellow;" -->
					<td colspan="2">
						<input type="text" id="lotId" class="left-input" name="lotId" />			<!-- 자동생성 placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly-->
						<input type="hidden" id="lotSeq" class="left-input" name="lotSeq"/>
					</td>
				<!-- 관리자 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_manager" /> : </td>
					<td>
						<input type="text" id="lotPmNm" class="right-input btn-input"name="lotPmNm" format="text" readonly/>
						<input type="hidden" id="lotPm" name="lotPm"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_lotUserInfoPop_callback)">
				<!-- 조회 -->
						<spring:message code="btn_search" /></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotWrkNm" /> : </td>
					<td colspan="2">
						<input type="text" id="lotNm" class="left-input" name="lotNm"/>	
					<td class="td-right-title">
				<!-- 부품명 -->
						<i class="fas fa-caret-right left-caret"></i><spring:message code="col_itemNm" /> : 
					</td>
					<td>
						<input type="text" id="itemNm" class="right-input btn-input" name="itemNm" format="text" readonly/>
						<input type="hidden" id="itemId" name="itemId"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  id="itemInfoBtn" onclick="lfn_itemInfoPop_Open(lfn_itemInfoPop_callback)">
						<!-- 조회 -->
						<spring:message code="btn_search" /></button>
					</td>						
				</tr>
				<tr>
					<td>
						<!-- Lot수량 -->
						<i class="fas fa-caret-right"></i><spring:message code="col_lotQty" /> : 
					</td>
					<td colspan="2">
						<input id="lotQty" class="left-input" name="lotQty" format="currency"/>
					</td>
					
					<td class="td-right-title">
				<!-- 부품명 -->
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_orderCd"></spring:message> : 
					</td>
					<td colspan="2">
						<input id="orderId" class="left-input" name="orderId" format="text" readonly/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="lotAction"/>
						<input type="hidden" name="midlotId" id="lotMidlotId"/>
						<input type="hidden" name="placeId" id="placeId"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopQcDocAdd');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/orderMgt/orderDetailMgt/orderDetailMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/orderMgt/orderDetailMgt/orderDetailMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200508 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//서브그리드에서 사용될 Object

var lfo_baseLotGrd = {};//Third그리드에서 사용될 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


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
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/orderMgt/orderDetailMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getOrderList", auth:"", prmt:{}},
		create:{url:"/setOrderInfoSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave},
		update:{url:"/setOrderInfoSave", auth:"", openFunc:"", callback:lfn_popSave},
		//destroy:{url:"", auth:"", callback:""}
	};
	
	//5.
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
				compNm: { type: "string" }
				}
		};
	
	//6.
		//6.
	lfo_common.columns = [
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update"), width: 60},																	//수정
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "110px"},											//수주코드
		{template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "160px"},					//수주명
		{field: "orderManagerNm", title:gfn_getMsg("col_manager"), width: "80px;"},										//관리자
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "80px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "80px"},			//납기일
		{field: "orderCost", format: "{0:n0}", title:gfn_getMsg("col_cost"), width: "100px"},							//비용
		{field: "description", title:gfn_getMsg("col_desc"), width: "250px"},											//설명
		{field: "orderState",template:"# var item = gfn_isNull(orderState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(orderState).cdId , gfn_getCode(orderState).cdNm) # #= item #",
			title:gfn_getMsg("col_proceedStatus"), width: "80px"},														//수주진행상태
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "120px"}												//업체명 
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_orderNm"), value: "orInfo.order_nm" },			//수주명
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },			//담당자
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },			//업체명
		{ text: gfn_getMsg("col_orderCd"), value: "orInfo.order_id" }			//수주코드


	];
	//8.
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
}
//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px",
		height: "375px", // 200810 youmi 320->340px, 200820 350->375px
		id : lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),			//추가팝업
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_orderRegist");				//수주 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_orderSrh");				//수주 수정
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
		//납기일 자동세팅 이벤트 바인딩(납기일 = 수주일  + 60)
// 		var orderStdt = $("#"+lfo_common.popId+"_form [name = 'orderStdt']").data("kendoDatePicker");
// 		orderStdt.bind("change", function() {
// 			var orderEddt = kendo.date.addDays(kendo.parseDate(orderStdt.value()),60);
// 			$("#"+lfo_common.popId+"_form [name = 'orderEddt']").data("kendoDatePicker").value(orderEddt);
// 		});
	};
	
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode,selectedItem);
	}else if(mode == 'EDT'){
		
		gfn_resizePop(lfo_common.popId,{width:750,height:580}); /** 700->580으로 height 변경_200821 youmi **/
		$("#"+lfo_common.popId+"_gridArea").show();
		
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
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});
			}
		});
	}
	//그리드 세팅
	$("#jtePopForm_grid").html("");
	lfn_jtePopGrd_setGrd();
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = gfn_serializeObject(lfo_common.popId+"_form");
		
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
					lfn_jtePop_set('EDT',data);
					
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

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(){
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
	lfo_popGrd.ctrlUrl = "/cform/orderMgt/orderDetailMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMidLotList", auth:"", prmt:{orderId : lfo_common.gridSelected.orderId}}, 
		create:{url:"/setMidLotInfoSave", auth:"", openFunc : lfn_jteMidlotGrd_popOpen, callback : lfn_jteMidlotGrd_save}, 
		update:{url:"/setMidLotInfoSave", auth:"", openFunc : lfn_jteMidlotGrd_popOpen, callback : lfn_jteMidlotGrd_save}, 
		//destroy:{url:"/setMidLotInfoDelete", auth:"", callback : lfn_baseLotPop_delete}	
	};
	
	//5.
	lfo_popGrd.model = {
			id: "midlotId",
			fields: {
				lotSeq : { type: "int" },
				lotId : { type: "string" },
				orderId : { type: "string" },
				orderNm : { type: "string" },
				orderManager: { type: "string" },
				orderStdt: { type: "date" },
				orderEddt: { type: "date" },
				orderCost: { type: "int" },
				orderState: { type: "string" },
				compId: { type: "string" },
				description: { type: "string" },
				midlotQty : { type: "int"},
				midlotId : { type: "string" },
				midlotType : { type: "string" },
				createdAt : { type: "date" },
				creatorId : { type: "string" },
				updatedAt : { type: "date" },
				updatorId : { type: "string" },
				placeId : { type: "string" },
				placeNm : { type: "string" }
				
			}
		};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "midlotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_midLotPop(\'EDT\',this); " style="min-width:70px;"><spring:message code = "btn_orderDetail"></spring:message></button>',
			title:gfn_getMsg("pop_view"), width: "120px;"},
		{field: "midlotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jteMidlotGrd_popOpen(\'EDT\',this); " style="min-width:60px;"><spring:message code = "btn_update"></spring:message></button>',
			title:gfn_getMsg("btn_update"), width: "100px;"},									//수정
		{field: "midlotId", title:gfn_getMsg("col_interimLotCd"), width: "200px;"},
		{field: "placeNm", title:"생산라인", width: "180px;"}
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_interimLotCd"), value: "midLot.midlot_id" }
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
		
}

//더블클릭 콜백(팝업)
this.lfn_jteMidlotGrd_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "750px",  //200507 수주 관리 그리드 더블클릭 → 팝업창 하단 그리드 더블 클릭 혹은 추가 버튼 클릭 시의 팝업창 width 변경_610->710px LYM 
		height: "244px",  ///200507 팝업창 height 변경_280->290px LYM 200810 youmi 440->450px 200820 290->302px 201020 youmi 330->290_201102 YUMI 290->244
		id: lfo_popGrd.popId, 
		//title:gfn_getMsg("pop_addPop"),			//추가팝업
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_lotRegist");				//LoT 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_lotUpdate");				//LoT 수정
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	lfo_popGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			orderId: lfo_common.gridSelected.orderId,
			midlotId: lfo_popGrd.gridSelected.midlotId,
			placeId: lfo_popGrd.gridSelected.placeId
		}
		gfn_popform_set(lfo_popGrd, mode, selectedItem);
		
	}else if(mode == 'EDT'){

		if(typeof(selectedItem) == "object"){
			lfo_popGrd.gridSelected = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_popGrd.gridSelected = {midlotId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.read.url,
			type: "POST",
			data: {
				orderId : lfo_common.gridSelected.orderId,
				midlotId : lfo_popGrd.gridSelected.midlotId},
			success: function(data){
				gfn_popform_set(lfo_popGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_jteMidlotGrd_save = function(mode){
	var flag;
	
	var searchPrmt = {};
	searchPrmt.midlotId = $('#midlotId').val();
	if(mode == "create"){
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + '/selectMidlotDupleKeyCount' ,
			type: "POST",
			data: JSON.stringify(searchPrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data > 0) {
					kendo.confirm("중복 된  중간LoT코드가 존재합니다. 다른 ID를 입력하여 주십시오.")
					flag = true
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
		if(flag) {
			return false;
		}
	}
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		//입력폼 serialize 
		var savePrmt = gfn_serializeObject(lfo_popGrd.popId+"_form");
		savePrmt.orderId = $("#lotOrderId").val();
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
					//마스터 그리드 리로드
					lfo_common.grid.dataSource.read();
					//이전 팝업화면 리로드
					lfn_jtePop_set('EDT', lfo_common.gridSelected.orderId);
					//팝업종료
					gfn_closePop(lfo_popGrd.popId);
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", gfn_getMsg("pop_successSave"))});
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});
			}
		});
	}
}

//삭제 콜백
this.lfn_jtePopGrd_delete = function(){
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
			
			lfn_jtePop_set('EDT',lfo_common.gridSelected);
			
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});
		}
	});
}

//상세 LoT 버튼 클릭(팝업 오픈)
this.lfn_midLotPop = function(mode, target){
	var options = {
		modal:true, 
		width: "800px", 
		height: "395px", //200519 JJW 400-> 395
		id : "jtePopRelDoc", 
		title:gfn_getMsg("col_orderDetail"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_popGrd.grid.dataItem($(target).closest("tr"));
	

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteBaseLotGrd_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}

//입고검사 관련문서 그리드 세팅
this.lfn_jteBaseLotGrd_setGrd = function(dataItem){
	
	/* $('#midlotId').val(dataItem.midlotId); */
	lfo_popGrd.gridSelected = {};
	lfo_popGrd.gridSelected.midlotId = dataItem.midlotId;
	lfo_popGrd.gridSelected.placeId = dataItem.placeId;
	
	lfo_baseLotGrd = {};//Form 내부에서 사용될 Object
	
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
	lfo_baseLotGrd.layoutId = "jtePopBaseLot_grid";
	
	//2.
	lfo_baseLotGrd.popId = "jtePopQcDocAdd";
	
	//3.
	lfo_baseLotGrd.ctrlUrl = "/cform/orderMgt/orderDetailMgt";

	//4.
	lfo_baseLotGrd.crud  = {
		read:{url:"/getLotList", auth:"", prmt:{midlotId: dataItem.midlotId}}, 
		create:{url:"/setLotInfoSave", auth:"", openFunc: lfn_baseLotPop_open, callback: lfn_baseLotPop_save},
		update:{url:"/setLotInfoSave", auth:"", openFunc: lfn_baseLotPop_open, callback: lfn_baseLotPop_save}
		//destroy:{url:"/setLotInfoDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};

	//5.
	lfo_baseLotGrd.model = {
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
			itemNm: { type: "string" },
			placeId: { type: "string" },
			placeNm: { type: "string" },
			mtrlNm: { type: "string" },
			mtrlQty: { type: "string" },
			mtrlDiv: { type: "string" },
			mtrlDesc: { type: "string" },
			midlotId: { type: "string" }
		}
	};
	
	//6.
	lfo_baseLotGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "lotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_baseLotPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title:gfn_getMsg("btn_update"), width: "100px;"},							//수정
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},				//Lot코드
		{field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "220px;"},			//Lot명 
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px;"},				//부품명
		{field: "lotQty", title:gfn_getMsg("col_lotQty"), width: "120px;"},				//Lot수량
		{field: "lotPmNm", title:gfn_getMsg("col_manager"), width: "120px;"},			//담당자
		{field: "lotType",  template:"# var item = gfn_isNull(lotType)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotType).cdId , gfn_getCode(lotType).cdNm) # #= item #", 
			title:gfn_getMsg("col_orderType"), width: "120px;"},						//수주유형
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title:gfn_getMsg("col_orderStatus"), width: "120px;"}					//수주상태
	];
	//7.
	lfo_baseLotGrd.selectBox = [
		{ text: gfn_getMsg("col_lotWrkNm"), value: "lot.lot_nm" },
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" },
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },
		{ text: gfn_getMsg("col_lotCd"), value: "lot.lot_id" }
	];

	//공통 그리드 세팅 호출 
	lfo_baseLotGrd.grid = gfn_grid_set(lfo_baseLotGrd);
}
//입고검사 관련문서 등록/수정 팝업 호출
this.lfn_baseLotPop_open = function(mode, selectedItem){
	
	var options = {
		modal:true, 
		width: "670px",
		height: "285px", //201020 youmi 290 -> 325_201102 YUMI 325->285
		//title : gfn_getMsg("pop_mtncRegist"),
		id:lfo_baseLotGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[ /*"Minimize", "Maximize", */ "Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("col_orderDetailRegist")
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("col_orderDetailUpdate")
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteBaseLotGrd_popset(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}
//입고검사 관련문서 등록/수정 팝업 내용 세팅
this.lfn_jteBaseLotGrd_popset = function(mode,selectedItem){
	lfo_baseLotGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
				orderId : lfo_common.gridSelected.orderId,
				midlotId : lfo_popGrd.gridSelected.midlotId,
				lotId : lfo_baseLotGrd.gridSelected.lotId,
				lotSeq : lfo_baseLotGrd.gridSelected.lotSeq,
				placeId : lfo_popGrd.gridSelected.placeId
			};
		gfn_popform_set(lfo_baseLotGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_baseLotGrd.gridSelected = lfo_baseLotGrd.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_baseLotGrd.gridSelected = {lotId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_baseLotGrd.ctrlUrl + lfo_baseLotGrd.crud.read.url,
			type: "POST",
			data: {
				orderId: lfo_common.gridSelected.orderId,
				midlotId: lfo_popGrd.gridSelected.midlotId,
				lotSeq: lfo_baseLotGrd.gridSelected.lotSeq,
				lotId: lfo_baseLotGrd.gridSelected.lotId
					},
			success: function(data){
				gfn_popform_set(lfo_baseLotGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_baseLotPop_save = function(mode){
 	var flag;
	
	var searchPrmt = {};
	searchPrmt.lotId = $("#lotMidlotId").val() + $('#lotId').val()
	
	if(mode == "create"){
		$.ajax({
			async:false,
			url : lfo_baseLotGrd.ctrlUrl + '/selectLotDupleKeyCount' ,
			type: "POST",
			data: JSON.stringify(searchPrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data > 0) {
					kendo.confirm("중복 된 Lot코드가 존재합니다. 다른 ID를 입력하여 주십시오.")
					flag = true
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
		if(flag) {
			return false;
		}
	}
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_baseLotGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_baseLotGrd.popId+"_form").serializeObject();
		if(mode == "create"){
			savePrmt.lotId = $("#lotMidlotId").val() + $("#lotId").val()
		}else if(mode == "update"){
			savePrmt.lotId = $("#lotId").val()
		}
		savePrmt.placeId = $("#placeId").val();
		$.ajax({
			async:false,
			url : lfo_baseLotGrd.ctrlUrl + lfo_baseLotGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//lfn_jtePop_set('EDT',data);
					//입고검사 관련문서 그리드 리로드
					lfo_baseLotGrd.grid.dataSource.read();
					//입고검사 상세 그리드 리로드
					lfo_popGrd.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_baseLotGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}
//pop - 공급처 팝업 오픈
this.lfn_supplierPop_Open = function(){
	//2020.05.14|ymlee|신명기계=>고객+공급사 존재
	gfn_openCustomPop('company',lfn_supplierPop_callback);
}

//pop - 공급처 팝업 콜백
this.lfn_supplierPop_callback = function(rtnObj){
	$("#compNm").val(rtnObj["compNm"]);
	$("#compId").val(rtnObj["compId"]);
	$("#compInitials").val(rtnObj["compInitials"]);
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

//LOT-pop - 유저정보 팝업 콜백
this.lfn_lotUserInfoPop_callback = function(rtnObj){
	$("#lotPm").val(rtnObj["userId"]);
	$("#lotPmNm").val(rtnObj["userNm"]);
}

//pop - 부품정보 팝업 오픈
this.lfn_itemInfoPop_Open = function(call){
	gfn_openCustomPop('item', call, {"itemStdStr02": lfo_popGrd.gridSelected.placeId});
}

//pop - 부품정보 팝업 콜백
this.lfn_itemInfoPop_callback = function(rtnObj){
	$("#itemId").val(rtnObj["itemId"]);
	$("#itemNm").val(rtnObj["itemNm"]);
	$("#itemStdStr02").val(rtnObj["placeId"]);
	$("#placeNm").val(rtnObj["placeNm"]);
}

this.lfn_placeParentOrder_get = function(){
	return gfn_ajaxCallByList("place",{placeStrStd01 : "ParentWorkLine"});
}
</script>