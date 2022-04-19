<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="mtrlOdplanMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrlOdplanMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrlOdplanMgtForm">
			<div class="pop_title"><spring:message code = "pop_mtrlOrderPlan" text="발주계획"/></div>
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup> 
				<col style="width: 20%;">
				<col style="width: 28%;">
				<col style="width: 24%;">
				<col style="width: 28%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlItemCd" text = "발주 계획 코드" /> : </td>
					<td><input type="text" id="mtrlOrderId" name="mtrlOrderId" placeholder="<spring:message code = "pop_autoInput" text="자동입력" />" readonly/></td>	
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_orderSitDiv" text = "발주상황 구분" /> : </td>
					<td><input id="mtrlOrderState" name="mtrlOrderState" format="selBox" msg="mtrl_order" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm" text = "자재명" /> : </td>
					<td colspan="3">
						<input type="text" id="mtrlNm" class="btn-input" name="mtrlNm" readonly/> <!-- style="width: 60%;" -->
						<input type="hidden" id="mtrlId" name="mtrlId" />
						<input type="hidden" id="mtrlCost" name="mtrlCost" />
						<button class="k-button k-primary" type="button" onclick="lfn_jtePopGrd_popOpen()" >
							<spring:message code = "btn_search" text = "조회" /></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm" text = "업체명" /> : </td>
					<td colspan="3">
						<input type="text" id="compNm" class="btn-input" name="compNm" readonly/> <!-- style="width: 60%;" -->
						<input type="hidden" id="compId" name="compId" />
					<button class="k-button k-primary" type="button" onclick="lfn_openMtrlCompPop()" >
							<spring:message code = "btn_search" text = "조회" /></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_quantity" text = "수량" /> : </td>
					<td><input id="mtrlOrderQty" name="mtrlOrderQty" format="currency" onkeyup="lfn_mtrlTotlCostCalc()" /></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_cost" text = "금액" />
				<!-- 자재와 수량을 입력하면 기본적으로 자동계산됩니다. -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_mtrlQtyAuto"></spring:message>"></i> : </td>
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
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="order_use"/>
						<input type="hidden" name="action" id="order_action"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"/></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"/></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>
			</div>
		</form>
	</div>
	
	<!-- 발주주문서 팝업 -->
	<div id="jteMtrlOrderPop" class="mtrlOdplanMgtForm">
		<form id="jteMtrlOrderPop_form" class="mtrlOdplanMgtForm">
		<!-- 발주주문서 -->
			<div class="pop_title"><spring:message code = "col_mtrlOrderDoc" text="발주주문서" /></div>
			<table id="jteMtrlOrderPop_master" class="BasicTable">
			<colgroup> <!-- 13 27 13 27 -->
				<col style="width: 24%;">
				<col style="width: 28%;">
				<col style="width: 20%;">
				<col style="width: 28%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDocCd" text="발주주문코드" /> : </td>
					<td><input type="text" id="mtrlOfId" name="mtrlOfId" placeholder="<spring:message code = "pop_autoInput" text='자동입력'/>" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderStatus" text="발주상태" />: </td>
					<td><input id="mtrlOfState" name="mtrlOfState"  format = "selBox" msg="mtrl_sta" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDocNm" text="발주명" /> : </td>					
					<td colspan="3">
						<input type="text" id="mtrlOfNm" name="mtrlOfNm"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_totalMtrlCost"  text="총 자재비용" />
					<i class="fas fa-info-circle" title="<spring:message code = "pop_deliveryMtrlCost" text='배송비+자재비용'/>"></i> : </td>
					<td>
						<input id="mtrlOfCost" name="mtrlOfCost" format="currency"/>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDate"  text="발주일" /> : </td>
					<td>
						<input id="mtrlOfDate" name="mtrlOfDate" format="datepicker"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text="설명" /> : </td>
					<td colspan="3"><input type="text" id="mtrlOfDesc" name="mtrlOfDesc" format="text"/></td>
				</tr>
				<tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="orderForm_use"/>
						<input type="hidden" name="action" id="orderForm_action"/>
					</td>
				</tr>
			</table>
		</form>
		<!-- 발주리스트 -->
		<div class="pop_title mtrlOdplanMgtForm"><spring:message code = "pop_mtrlOrderList" text="발주리스트" /></div>
		<div id="jteMtrlOrderGrid" class="mtrlOdplanMgtForm" style="height:200px; width:98%; margin:auto;"></div>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"/></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"/></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteMtrlOrderPop');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
	
	<!-- 자재선택 커스텀 팝업 -->
	<div id="mtrlInfoPop">
		<div id="mtrlInfo_grid"></div>
	</div>
</div>


<link href='/resources/mes/css/contents/mtrl/mtrlOdMgt/mtrlOdplanMgt/mtrlOdplanMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_mtrlOrderPopForm = {};//발주주문서 팝업용

var lfo_mtrlOrderPopGrid = {};//발주주문서 팝업 그리드에서 사용


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
	lfo_common.ctrlUrl = "/form/mtrl/mtrlOdMgt/mtrlOdplanMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getMtrlOrderList", auth:"",paging : false, prmt:{mtrlOrderState:"mtrl_order_temp"}}, 
		create:{url:"/setMtrlOrderSave", auth:"", openFunc: lfn_mtrlPlanPop_open, callback:lfn_popSave}, 
		update:{url:"/setMtrlOrderSave", auth:"", openFunc: "" , callback:lfn_popSave}, 
		destroy:{url:"/setMtrlOrderDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "mtrlOrderId",
		fields: {
			mtrlOrderId : { type: "string" },
			mtrlOrderQty : { type: "int" },
			mtrlOrderUser : { type: "string" },
			mtrlOrderUserNm : { type: "string" },
			mtrlOrderDate : { type: "date" },
			mtrlOrderCost : { type: "int" },
			mtrlOrderDelivery : { type: "int" },
			mtrlOrderExpectex : { type: "date" },
			mtrlOrderState : { type: "string" },
			mtrlOrderDesc : { type: "string" },
			createdAt : { type: "date" },
			updatedAt : { type: "date" },
			creatorId : { type: "string" },
			creatorNm : { type: "string" },
			updatorId : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlCost : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			mtrlOfId : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlClaim : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlOrderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlPlanPop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},
		{field: "mtrlOrderId", title:gfn_getMsg("col_mtrlItemCd", "발주계획코드"), width: "150px"},
		{field: "mtrlOrderState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOrderState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOrderState).cdId , gfn_getCode(mtrlOrderState).cdNm) # #= item #", 
			title:gfn_getMsg("col_orderSitDiv", "발주상황구분"), width: "120px;"},
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm", "자재명"), width: "240px"},
		{field: "mtrlOrderQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity", "수량"), width: "80px"},
		{field: "mtrlOrderCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost", "금액"), width: "90px"},
		{field: "mtrlOrderExpectex", format: "{0: yyyy-MM-dd}", title:"예정일", width: "110px"},
		{field: "mtrlOrderDelivery", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_deliveryCost", "배송비용"), width: "100px"},
		{field: "compNm",  title:gfn_getMsg("col_compNm", "업체명"), width: "200px"},
		{field: "creatorNm", title:gfn_getMsg("col_registUser", "등록자"), width: "110px"},
		{field: "createdAt", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate", "등록일"), width: "120px"},
		{field: "mtrlOrderDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
		
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlInfo.mtrl_nm" },
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_mtrlItemCd", "발주계획코드"), value: "mtrlOrder.mtrl_order_id" }
	];
	
	//8.
	lfo_common.validation ={
		mtrlId:{
			messages : "조회버튼을 눌러 자재를 등록하세요",
			rules : function(input){
				if(input.is("[name=mtrlId]")){
					if(input.val().length == 0){
						gfn_warnBox({msg:"조회버튼을 눌러 자재를 등록하세요", title : "경고"});
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
						gfn_warnBox({msg : "조회버튼을 눌러 업체를 등록하세요", title : "경고"});
						return false;
					}
				}
				return true;
			}
		},
		mtrlOrderQty:{
			messages : "수량을 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlOrderQty]")){
					return input.val().length != 0;
				}
				return true;
			}
		}
	}
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	
	//발주주문서 버튼추가
	$("#"+lfo_common.layoutId + " .k-grid-toolbar").append('<a role="button" class="k-button k-button-icontext jte-order" style="float:right"></span>'+gfn_getMsg("col_mtrlOrderDoc")+'</a>')
	
	$("#"+lfo_common.layoutId + " .k-grid-toolbar").find(".jte-order").on("click",function(){
		//팝업오픈
		this.lfn_mtrlOrderForm_open();
	});
}

//더블클릭 콜백(팝업)
this.lfn_mtrlPlanPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "730px", 
		height: "470px",
		id : lfo_common.popId, 
		//title: gfn_getMsg("pop_addPop")
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlPlanRegist", "발주계획 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlPlanSrh", "발주계획 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = {};
	var childItems = [];
	
	if(mode=='NEW'){
		selectedItem = {
			mtrlOrderId : lfo_common.gridSelected.mtrlOrderId,
		}
		gfn_popform_set(lfo_common, mode, selectedItem);
		//수량에 따라 금액 계산
		lfn_changeEvent_bind();
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {mtrlOrderId : selectedItem};
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {mtrlOrderId :lfo_common.gridSelected.mtrlOrderId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
				childItems = data.rows[0].orderCompList;
				//수량에 따라 금액 계산
				lfn_changeEvent_bind();
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//자재정보 콜백
this.lfn_mtrlPop_callback = function(selectedItems){
	
	var selectedItem = lfo_popGrd.grid.dataItem($(selectedItems).closest('tr'));
	
	$("#"+ lfo_common.popId + "_form [name='mtrlId']").val(selectedItem.mtrlId);
	$("#"+ lfo_common.popId + "_form [name='mtrlNm']").val(selectedItem.mtrlNm);
	
	gfn_closePop("mtrlInfoPop");
	
	//업체정보 초기화
	$("#"+ lfo_common.popId + "_form [name='compId']").val("");
	$("#"+ lfo_common.popId + "_form [name='compNm']").val("");
}


//자재구매가능 업체조회 팝업
this.lfn_openMtrlCompPop= function(){
	var mtrlId = $("#"+ lfo_common.popId + "_form [name='mtrlId']").val();
	
	if(!gfn_isNull(mtrlId)){
		gfn_openCustomPop('company',lfn_compPop_callback,{mtrlId: mtrlId});
	}else{
		gfn_msgBox({msg:"자재정보를 선택해주세요"});
	}
}

//업체정보 콜백
this.lfn_compPop_callback = function(callbackObj){
	$("#"+ lfo_common.popId + "_form [name='compId']").val(callbackObj.compId);
	$("#"+ lfo_common.popId + "_form [name='compNm']").val(callbackObj.compNm);

	//업체별 자재비용 조회
	lfn_mtrlTotlCostCalc();
}

//업체별 자재비용 조회
this.lfn_mtrlTotlCostCalc = function(){
	var pMtrlId = $("#"+ lfo_common.popId + "_form [name='mtrlId']").val();
	var pCompId = $("#"+ lfo_common.popId + "_form [name='compId']").val();
	
	var mtrlCost = 0;
	$.ajax({
		async:false,
		url : "/form/basMgt/operMgt/mtrlInfo/getMtrlRtlCompList",
		type: "POST",
		data: {mtrlId : pMtrlId, compId : pCompId},
		success: function(data){
			mtrlCost = parseInt(data.rows[0].mtrlPrice);
			$("#"+ lfo_common.popId + "_form [name='mtrlCost']").val(mtrlCost);
			mtrlQty = $("#"+ lfo_common.popId + "_form [name='mtrlOrderQty']").val();
			
			//업체 선택(변경)시 입력되어 있는 수량에 맞게 금액 계산됨
			if(!isNaN(mtrlCost) && !isNaN(mtrlQty)){
				$("#"+ lfo_common.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value(mtrlCost * mtrlQty);
			}else {
				$("#"+ lfo_common.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value(0);
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//자재가격 * 자재수량 = 총가격 입력 이벤트 (수량 변경시 수량에 맞게 금액 변경됨)
this.lfn_changeEvent_bind = function() {
	var numerictextbox = $("#"+ lfo_common.popId +" [name=mtrlOrderQty]").data("kendoNumericTextBox"); 
	var mtrlCost = "";
	
	numerictextbox.bind("change", function() {
		mtrlCost = $("#"+ lfo_common.popId + "_form [name='mtrlCost']").val();
		if(!isNaN(mtrlCost) && !isNaN(this.value())){
			$("#"+ lfo_common.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value(mtrlCost * this.value());
		} else{
			$("#"+ lfo_common.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value("0");
		}
	});
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
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
					//팝업종료
					gfn_closePop(lfo_common.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
					
					//마스터그리 리로드
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

//삭제 콜백
this.lfn_jteGrid_delete = function(){
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
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess", "성공")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}


//발주주문서 팝업 오픈
this.lfn_mtrlOrderForm_open = function(){
	var options = {
		modal:true, 
		width: "800px", 
		height: "580px", 
		id : "jteMtrlOrderPop", 
		title: gfn_getMsg("pop_mtrlOrderRegist", "발주등록"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_mtrlOrderForm_set();};
	this.gfn_winOpen(options);
}

//발주주문서 팝업ui 세팅
this.lfn_mtrlOrderForm_set = function(){
	lfo_mtrlOrderPopForm = {
		popId : "jteMtrlOrderPop",
		ctrlUrl : "/form/mtrl/mtrlOdMgt/mtrlOdcursitMgt",
		crud  : {
			create:{url:"/setMtrlOrderFormSave", auth : "", openFunc : "", callback : lfn_mtrlOrderForm_save}, 
		},
		validation :{
			mtrlOfNm:{
				messages : "발주명을 입력하세요",
				rules : function(input){
					if(input.is("[name=mtrlOfNm]")){
						return input.val().length != 0 && input.val().trim().length != "";
					}
					return true;
				}
			}
		},
		data : {mtrlOfDate : new Date(), mtrlOfCost : 0}
	};
	
	//선택된 데이터 배열에 담기
	var mtrlOrderList = [];
	
	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var selectedItems = lfo_common.grid.dataItem($(this).closest('tr'))
			//선택된 데이터 저장
			mtrlOrderList.push(selectedItems);	
			
			//총자재비용 계산
			lfo_mtrlOrderPopForm.data.mtrlOfCost += (parseInt(selectedItems.mtrlOrderCost)+parseInt(selectedItems.mtrlOrderDelivery));
		}
	});
	
	//발주주문서 팝업 세팅
	gfn_popform_set(lfo_mtrlOrderPopForm, 'NEW',lfo_mtrlOrderPopForm.data);
	
	//발주주문서 그리드생성
	this.lfn_mtrlOrderForm_dataSet(mtrlOrderList);
}


//커스텀 버튼팝업 데이터 준비(Object data) 일반 그리드 데이터와 조금 차이가 있다.
//발주주문서 데이터 세팅
this.lfn_mtrlOrderForm_dataSet = function(mtrlOrderList){
	lfo_mtrlOrderPopGrid = {};//Form 내부에서 사용될 Object
	
	//1.
	lfo_mtrlOrderPopGrid.layoutId = "jteMtrlOrderGrid";
	
	//2.
	lfo_mtrlOrderPopGrid.popId = "jtePopForm";
	
	//4.
	lfo_mtrlOrderPopGrid.ctrlUrl = "/form/mtrl/mtrlOdMgt/mtrlOdcursitMgt"
	
	//5.
	lfo_mtrlOrderPopGrid.crud  = {
		//create:{url:"/setMtrlOrderFormSave", auth:"", openFunc : lfn_mtrlOrderGridPop_open, callback : lfn_mtrlOrderGridPop_save},
		//update:{url:"/setMtrlOrderFormSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		//destroy:{url:"/setMtrlOrderDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//6.
	lfo_mtrlOrderPopGrid.model = {
		id: "mtrlOrderId",
		fields: {
			mtrlOrderId : { type: "string" },
			mtrlOrderQty : { type: "int" },
			mtrlOrderUser : { type: "string" },
			mtrlOrderUserNm : { type: "string" },
			mtrlOrderDate : { type: "date" },
			mtrlOrderCost : { type: "int" },
			mtrlOrderDelivery : { type: "string" },
			mtrlOrderState : { type: "string" },
			mtrlOrderDesc : { type: "string" },
			createdAt : { type: "date" },
			updatedAt : { type: "date" },
			creatorId : { type: "string" },
			creatorNm : { type: "string" },
			updatorId : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlCost : { type: "string" },
			mtrlMgtId : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			mtrlOfId : { type: "string" },
			mtrlDiv : { type: "string" }
		}
	};
	
	//7.
	lfo_mtrlOrderPopGrid.columns = [
		{field: "mtrlOrderId", title:gfn_getMsg("col_mtrlItemCd", "발주계획코드"), width: "180px"},
		{field: "mtrlOrderState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOrderState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOrderState).cdId , gfn_getCode(mtrlOrderState).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlOrderStatus", "발주상태"), width: "110px;"},
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm", "자재명"), width: "110px"},
		{field: "mtrlOrderQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity", "수량"), width: "80px"},
		{field: "mtrlOrderCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_totalMtrlCost", "총 자재비용"), width: "130px"},
		{field: "mtrlOrderDelivery", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_deliveryCost", "배송비용"), width: "110px"},
		{field: "compNm",  title:gfn_getMsg("col_compNm", "업체명"), width: "180px"},
		{field: "creatorNm", title:gfn_getMsg("col_registUser", "등록자"), width: "90px"},
		{field: "createdAt", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate", "등록일"), width: "140px"},	
		{field: "mtrlOrderDesc", title:gfn_getMsg("col_desc", "설명"), width: "150px"}
	];
	
	//8.
	lfo_mtrlOrderPopGrid.selectBox = [
		{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlInfo.mtrl_nm" },
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_mtrlItemCd", "발주계획코드"), value: "mtrlOrder.mtrl_order_id" }
	];
	
	lfo_mtrlOrderPopGrid.childItems = mtrlOrderList;
	
	//grid 생성
	lfo_mtrlOrderPopGrid.grid = gfn_objectDatagrid_set(lfo_mtrlOrderPopGrid);
}

//발주 주문서 Form내용 입력/저장
this.lfn_mtrlOrderForm_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_mtrlOrderPopForm.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_mtrlOrderPopForm.popId+"_form").serializeObject();
		
		//선택되었던 발주목록 매핑
		savePrmt.mtrlOrderList = lfo_mtrlOrderPopGrid.childItems;
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_mtrlOrderPopForm.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_mtrlOrderPopForm.ctrlUrl + lfo_mtrlOrderPopForm.crud.create.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_mtrlOrderPopForm.popId);
					
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
//자재조회 팝업 오픈
this.lfn_jtePopGrd_popOpen = function(){
	var options = {
		modal:true, 
		width: "1250px", 
		height: "470px",
		id:"mtrlInfoPop", 
		title:"자재정보",	
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:["Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		$("#mtrlInfo_grid").empty();
		
		lfn_jtePopGrd_setGrd();
		$('#mtrlInfo_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}

//자재 조회 팝업 그리드 세팅
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
	
	lfo_popGrd.layoutId = "mtrlInfo_grid";
	
	lfo_popGrd.ctrlUrl = "/form/basMgt/operMgt/mtrlInfo"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlInfoList", auth:"", prmt:{}, dynamicPrmt : {itemId : "itemId"}}, 
	};
	
	//5.
	lfo_popGrd.model = {
		id: "mtrlId",
		fields: {
			mtrlId : { type: "string" },
			mtrlNm: { type: "string" },
			mtrlDesc: { type: "string" },
			mtrlType: { type: "string" },
			mtrlHCD: { type: "string" },
			mtrlStd01: { type: "int" },
			mtrlStd02: { type: "int" },
			mtrlStd03: { type: "int" },
			mtrlStd04: { type: "float" },
			mtrlStd05: { type: "int" },
			mtrlStdStr01 : { type: "string" },
			mtrlStdStr02 : { type: "string" },
			mtrlStdStr03 : { type: "string" },
			mtrlStdStr04 : { type: "string" },
			mtrlStdStr05 : { type: "string" },
			mtrlUseday: { type: "int" },
			mtrlCost: { type: "int" },
			createdAt: { type: "string" },
			updatedAt: { type: "string" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			mtrlDiv: { type: "string" },
			isUse: { type: "bool" },
			mtrlQual: { type: "string" },
			mtrlUnit: { type: "string" },
			compNm : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{field: "mtrlId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlPop_callback(this);" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: 90},	
		{field: "mtrlId", title:gfn_getMsg("col_mtrlCd","자재코드"), width: "140px"},
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm", "자재명"), width: "170px"},
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlType", "자재유형"), width: "95px;"},
		{field: "mtrlCost", format: "{0:n0}",attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_unitPrice", "단가"), width: "100px"},
		{field: "mtrlStdStr01", title : "자재규격", width: "150px"},
		{field: "mtrlStd04", title: "최소재고",   attributes: { style: "color: red; font-weight:bold;  text-align:right;" }, width: "105px"},
		{field: "mtrlDesc", title:gfn_getMsg("col_desc", "설명"), width: "300px"},
		{field: "compNm", title:"발주처", width: "300px"},
	];
	
	lfo_popGrd.customTitle = {
		html: '<button class="k-button k-primary" type="button" onclick = "lfn_bomMtrl(\'all\');" style="min-width:60px;">전체 검색</button> &nbsp; <button class="k-button k-primary" type="button" onclick = "lfn_bomMtrl(\'item\');" style="min-width:60px;">품목 검색</button>' +
		'<input class="k-textbox" id="itemNm" readonly/><input type="hidden" id="itemId" /> '
	};
	
	
	//7.
	lfo_popGrd.selectBox = [ 
		{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlInfo.mtrl_nm" },
		{ text: gfn_getMsg("col_mtrlCd", "자재코드"), value: "mtrlInfo.mtrl_id" },
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compNm" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

//품목별 자재 조회
this.lfn_bomMtrl = function(mode){
	
	if(mode == 'item') {
		var callback = function(selectedItem){
			$('#itemNm').val(selectedItem.itemNm);
			$('#itemId').val(selectedItem.itemId);
			
			lfo_popGrd.grid.dataSource.read();
		};
		
		gfn_openCustomPop("item", callback);
	} else {
		$('#itemNm').val(null);
		$('#itemId').val(null);
		
		lfo_popGrd.grid.dataSource.read();
	}	
}

</script>