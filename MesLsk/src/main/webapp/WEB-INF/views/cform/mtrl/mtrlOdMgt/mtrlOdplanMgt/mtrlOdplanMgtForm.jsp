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
		<!-- 발주계획 -->
			<div class="pop_title"><spring:message code = "pop_mtrlOrderPlan"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master">
			<colgroup> <!-- 13 27 13 27, 2200512 조회버튼 때문에 행 2개 추가-->
				<col class="col-left-title">
				<col class="col-left-content-1">
				<col class="col-left-content-2">
				<col class="col-right-title">
				<col class="col-right-content-1">
				<col class="col-right-content-2">
			</colgroup>
				<tr>
				<!-- 발주계획코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlItemCd"></spring:message> : </td>
					<td colspan="2"><input type="text" id="mtrlOrderId" class="left-input" name="mtrlOrderId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 발주상황 구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_orderSitDiv"></spring:message> : </td>
					<td colspan="2"><input id="mtrlOrderState" class="right-input" name="mtrlOrderState"  format = "selBox" msg="mtrl_order" readonly/></td>
				</tr>
				<tr>
				<!-- 자재명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="mtrlNm" class="center-input btn-input" name="mtrlNm" readonly/> <!-- style="width: 60%;" -->
						<input type="hidden" id="mtrlId" name="mtrlId" />
						<input type="hidden" id="mtrlCost" name="mtrlCost" />
					</td>
					<td colspan="2">
						<button class="k-button k-primary search-btn" type="button" onclick="gfn_openCustomPop('material',lfn_mtrlPop_callback);" >
				<!-- 조회 -->
							<spring:message code = "btn_search"></spring:message></button>
					</td>
<%-- 				<!-- 자재구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlDiv"></spring:message> : </td>
					<td colspan="2"><input id="mtrlDiv" class="right-input" name="mtrlDiv" placeholder="<spring:message code = "pop_mtrlSrhAuto"/>" format="text" readonly/></td> --%>
				</tr>
				<tr>
				<!-- 업체명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="compNm" class="center-input btn-input" name="compNm" readonly/> <!-- style="width: 60%;" -->
						<input type="hidden" id="compId" name="compId" />
					</td>
					<td colspan="2">
					<button class="k-button k-primary search-btn" type="button" onclick="lfn_openMtrlCompPop()" >
				<!-- 조회 -->
							<spring:message code = "btn_search"></spring:message></button>
					</td>
				</tr>
				<tr>
				<!-- 수량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_quantity"></spring:message> : </td>
					<td colspan="2"><input id="mtrlOrderQty" class="left-input" name="mtrlOrderQty" format="currency" onkeyup="lfn_mtrlTotlCostCalc()"/></td>
				<!-- 금액 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_cost"></spring:message>
				<!-- 자재와 수량을 입력하면 기본적으로 자동계산됩니다. -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_mtrlQtyAuto"></spring:message>"></i> : </td>
					<td colspan="2"><input id="mtrlOrderCost" class="center-input" name="mtrlOrderCost" format="currency"/></td>
				</tr>
				<tr>
				<!-- 배송비용 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_deliveryCost"></spring:message> : </td><!-- 배송비용 -->
					<td colspan="2"><input id="mtrlOrderDelivery" class="right-input" name="mtrlOrderDelivery" format="currency"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="5"><input type="text" id="mtrlOrderDesc" class="center-input" name="mtrlOrderDesc" format="text"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="order_use"/>
						<input type="hidden" name="action" id="order_action"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 발주주문서 팝업 -->
<div style="display:none;">
	<div id="jteMtrlOrderPop">
		<form id="jteMtrlOrderPop_form" class="mtrlOdplanMgtForm">
		<!-- 발주주문서 -->
			<div class="pop_title"><spring:message code = "col_mtrlOrderDoc"></spring:message></div>
			<table style="width:100%;" id="jteMtrlOrderPop_master">
			<colgroup> <!-- 13 27 13 27 -->
				<col class="popsc-col-left-title">
				<col class="popsc-col-left-content">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr>
				<!-- 발주주문코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDocCd"></spring:message> : </td>
					<td><input type="text" id="mtrlOfId" class="left-input" name="mtrlOfId" placeholder="<spring:message code = "pop_autoInput" ></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 발주상태 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderStatus"></spring:message>: </td>
					<td><input id="mtrlOfState" class="right-input" name="mtrlOfState"  format = "selBox" msg="mtrl_sta" readonly/></td>
				</tr>
				<tr>
				<!-- 발주명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDocNm"></spring:message> : </td>					
					<td colspan="3">
						<input type="text" id="mtrlOfNm" class="center-input" name="mtrlOfNm"/>
					</td>
				</tr>
				<tr>
				<!-- 총 자재비용 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_totalMtrlCost"></spring:message>
				<!-- 배송비  + 자재비용 -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_deliveryMtrlCost"></spring:message>"></i> : </td>
					<td>
						<input id="mtrlOfCost" class="left-input" name="mtrlOfCost" format="currency"/>
					</td>
				<!-- 발주일 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDate"></spring:message> : </td>
					<td>
						<input id="mtrlOfDate" class="right-input" name="mtrlOfDate" format="datepicker"/>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="mtrlOfDesc" class="center-input" name="mtrlOfDesc" format="text"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="orderForm_use"/>
						<input type="hidden" name="action" id="orderForm_action"/>
					</td>
				</tr>
			</table>
		</form>
		<!-- 발주리스트 -->
		<div class="pop_title"><spring:message code = "pop_mtrlOrderList"></spring:message></div>
		<div id="jteMtrlOrderGrid"></div>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteMtrlOrderPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!--  <link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_lym.css' rel="stylesheet">  -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mtrl/mtrlOdMgt/mtrlOdplanMgt/mtrlOdplanMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200512 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_mtrlOrderPop = {};//발주주문서 팝업 그리드에서 사용

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
	lfo_common.ctrlUrl = "/cform/mtrl/mtrlOdMgt/mtrlOdplanMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getMtrlOrderList", auth:"", prmt:{mtrlOrderState:"mtrl_order_temp"}}, 
		create:{url:"/setMtrlOrderSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setMtrlOrderSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
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
			mtrlDiv : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlOrderId", title:gfn_getMsg("col_mtrlItemCd"), width: "150px"},										//발주계획코드
		{field: "mtrlOrderState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOrderState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOrderState).cdId , gfn_getCode(mtrlOrderState).cdNm) # #= item #", 
			title:gfn_getMsg("col_orderSitDiv"), width: "120px;"},														//발주상황 구분
		//{field: "mtrlId", title:"자재코드", width: 100},
		//{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "110px"},											//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "240px"},												//자재명
		{field: "mtrlOrderQty", format: "{0:n0}", title:gfn_getMsg("col_quantity"), width: "80px"},						//수량
		{field: "mtrlOrderCost", format: "{0:n0}", title:gfn_getMsg("col_cost"), width: "90px"},						//금액
		{field: "mtrlOrderDelivery", format: "{0:n0}", title:gfn_getMsg("col_deliveryCost"), width: "100px"},			//배송비용
		//{field: "compId",  title:"업체코드", width: 100},
		{field: "compNm",  title:gfn_getMsg("col_compNm"), width: "220px"},												//업체명
		//{field: "mtrlOrderUser", title:"수령자 아이디", width: 100},
		//{field: "mtrlOrderUserNm", title:"수령자", width: 100},
		//{field: "mtrlOrderDate", format: "{0: yyyy-MM-dd}", title:"수령일", width: 100},
		//{field: "creatorId", title:"등록자 코드", width: 100},
		{field: "creatorNm", title:gfn_getMsg("col_registUser"), width: "110px"},										//등록자
		{field: "createdAt", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate"), width: "120px"},			//등록일
		{field: "mtrlOrderDesc", title:gfn_getMsg("col_desc"), width: "250px"}											//설명
		
	];
	
	//7.
	lfo_common.selectBox = [
		//{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },					//자재구분
		{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },						//자재명
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },						//업체명
		{ text: gfn_getMsg("col_mtrlItemCd"), value: "mtrlOrder.mtrl_order_id" }			//발주계획코드
	];
	
	//8.
	lfo_common.validation ={
		mtrlId:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=mtrlId]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 자재를 등록하세요");
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
		this.lfn_mtrlOrderForm_dataSet();
	});
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "730px", // 200512 JJW 그리드 더블 클릭 팝업 너비 700px, 200902 ymlee 700-> 730px
		height: "425px", // 200512 JJW 그리드 더블 클릭 팝업 높이 320px -> 380px, 200810 youmi 400->430px, 200828 youmi 430-> 382px, 200902 ymlee 382-> 395px, 200902 youmi 395 -> 425px 
		id:lfo_common.popId, 
		//title: gfn_getMsg("pop_addPop")
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlPlanRegist");			//발주계획 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlPlanSrh");				//발주계획 수정
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = {};
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected.mtrlOrderId = selectedItem["mtrlOrderId"];
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.mtrlOrderId = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {eqmtId :lfo_common.gridSelected.mtrlOrderId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}
//자재정보 콜백
this.lfn_mtrlPop_callback = function(callbackObj){
	$("#"+ lfo_common.popId + "_form [name='mtrlId']").val(callbackObj.mtrlId);
	$("#"+ lfo_common.popId + "_form [name='mtrlNm']").val(callbackObj.mtrlNm);
	$("#"+ lfo_common.popId + "_form [name='mtrlCost']").val(callbackObj.mtrlCost);
	//$("#"+ lfo_common.popId + "_form [name='mtrlDiv']").val(callbackObj.mtrlDiv);
	lfn_mtrlTotlCostCalc();
}
//자재구매가능 업체조회 팝업
// 20.05.07|ymlee|업체 리스트 불러오도록 수정
this.lfn_openMtrlCompPop= function(){
	//var compCode = $("#"+ lfo_common.popId + "_form [name='compId']").val();
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
}

//자재비용 계산
this.lfn_mtrlTotlCostCalc = function(){
	var mtrlCost = parseInt($("#"+ lfo_common.popId +" [name=mtrlCost]").val());
	var mtrlOrderQty = parseInt($("#"+ lfo_common.popId +" [name=mtrlOrderQty]").val());
	if(!isNaN(mtrlCost) && !isNaN(mtrlOrderQty)){
		$("#"+ lfo_common.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value(mtrlCost * mtrlOrderQty);
	}else{
		$("#"+ lfo_common.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value("0");
	}
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
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					//마스터그리 리로드
					lfo_common.grid.dataSource.read();
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
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//커스텀 버튼팝업 데이터 준비(Object data) 일반 그리드 데이터와 조금 차이가 있다.
/* 
	1. gridObject.layoutId = 팝업안에 있는 gridId
	2. gridObject.popId = 현재popId
	3. gridObject.selectedItems = 조회데이타(Object)
	4. gridObject.ctrlUrl = 베이스 url
	5. gridObject.crud  = { // 쓰기, 수정, 삭제
		create:{url:"",auth:"",openFunc:function, callback:function}, 
		update:{url:"",auth:"",openFunc:function, callback:function}, 
		delete:{url:"",auth:"", callback:function}}
	6. gridObject.model = fieldType
	7. gridObject.columns = foeldColumns
	8. gridObject.selectBox = SelectBox 매핑 값 
*/

//발주주문서 데이터 세팅
this.lfn_mtrlOrderForm_dataSet = function(){
	lfo_mtrlOrderPop = {};//Form 내부에서 사용될 Object
	
	//발주일 현재시간으로 세팅
	lfo_mtrlOrderPop.data={mtrlOfDate : new Date(), mtrlOfCost : 0};
	
	//선택된 데이터 배열에 담기
	var mtrlOrderList = [];
	
	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var selectedItems = lfo_common.grid.dataItem($(this).closest('tr'))
			mtrlOrderList.push(selectedItems);	
			
			//총자재비용 계산
			lfo_mtrlOrderPop.data.mtrlOfCost += (parseInt(selectedItems.mtrlOrderCost)+parseInt(selectedItems.mtrlOrderDelivery));
		}
	});
	
	//1.
	lfo_mtrlOrderPop.layoutId = "jteMtrlOrderGrid";
	
	//2.
	lfo_mtrlOrderPop.popId = "jteMtrlOrderPop";
	
	//3.
	lfo_mtrlOrderPop.selectedItems = mtrlOrderList;
	
	//4.
	lfo_mtrlOrderPop.ctrlUrl = "/cform/mtrl/mtrlOdMgt/mtrlOdcursitMgt"
	
	//5.
	lfo_mtrlOrderPop.crud  = {
		create:{url:"/setMtrlOrderFormSave", auth:"", openFunc:"", callback:lfn_mtrlOrderForm_save}, 
		//update:{url:"/setMtrlOrderFormSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		//destroy:{url:"/setMtrlOrderDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//6.
	lfo_mtrlOrderPop.model = {
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
	lfo_mtrlOrderPop.columns = [
		{field: "mtrlOrderId", title:gfn_getMsg("col_mtrlItemCd"), width: "180px"},										//발주계획코드
		{field: "mtrlOrderState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOrderState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOrderState).cdId , gfn_getCode(mtrlOrderState).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlOrderStatus"), width: "110px;"},													//발주상태
		//{field: "mtrlId", title:"자재코드", width: 100},
		//{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "110px"},											//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "110px"},												//자재명
		{field: "mtrlOrderQty", format: "{0:n0}", title:gfn_getMsg("col_quantity"), width: "80px"},						//수량
		{field: "mtrlOrderCost", format: "{0:n0}", title:gfn_getMsg("col_totalMtrlCost"), width: "130px"},				//총 자재비용
		{field: "mtrlOrderDelivery", format: "{0:n0}", title:gfn_getMsg("col_deliveryCost"), width: "110px"},			//배송비용
		//{field: "compId",  title:"업체코드", width: 100},
		{field: "compNm",  title:gfn_getMsg("col_compNm"), width: "180px"},												//업체명
		//{field: "mtrlOrderUser", title:"수령자 아이디", width: 100},
		//{field: "mtrlOrderUserNm", title:"수령자", width: 100},
		//{field: "mtrlOrderDate", format: "{0: yyyy-MM-dd}", title:"수령일", width: 100},
		//{field: "creatorId", title:"등록자 코드", width: 100},
		{field: "creatorNm", title:gfn_getMsg("col_registUser"), width: "90px"},										//등록자
		{field: "createdAt", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate"), width: "140px"},			//등록일
		{field: "mtrlOrderDesc", title:gfn_getMsg("col_desc"), width: "150px"}											//설명
		
	];
	
	//8.
	lfo_mtrlOrderPop.selectBox = [
		//{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },					//자재구분
		{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },						//자재명
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },						//업체명
		{ text: gfn_getMsg("col_mtrlItemCd"), value: "mtrlOrder.mtrl_order_id" }			//발주계획코드
	];
	//9.
	lfo_mtrlOrderPop.validation ={
		mtrlOfNm:{
			messages : "발주명을 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlOfNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		}
	}
	//팝업오픈
	this.lfn_mtrlOrderForm_open();
}

//발주주문서 팝업 오픈
this.lfn_mtrlOrderForm_open = function(){
	var options = {
		modal:true, 
		width: "800px", // 200512 JJW 발주주문서 팝업 너비 800px
		height: "580px", // 200519 JJw 발주주문서 팝업 높이 450px -> 600px, 600px->580px
		id : "jteMtrlOrderPop", 
		title: gfn_getMsg("pop_mtrlOrderRegist"),			//발주 등록
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
	
	gfn_popform_set(lfo_mtrlOrderPop, 'NEW',lfo_mtrlOrderPop.data);
	
	lfo_mtrlOrderPop.grid = gfn_objectDatagrid_set(lfo_mtrlOrderPop);
}

//Form내용 입력/저장
this.lfn_mtrlOrderForm_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_mtrlOrderPop.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_mtrlOrderPop.popId+"_form").serializeObject();
		
		//선택되었던 발주목록 매핑
		savePrmt.mtrlOrderList = lfo_mtrlOrderPop.selectedItems;
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_mtrlOrderPop.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_mtrlOrderPop.ctrlUrl + lfo_mtrlOrderPop.crud.create.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_mtrlOrderPop.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					//마스터그리드 리로드
					lfo_common.grid.dataSource.read();
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
</script>