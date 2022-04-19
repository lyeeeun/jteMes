<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="mrplanForm" style="width:100%;">
	<div id="jteSingleGrid" class="mrplanForm"></div>
</div>

<!-- 팝업(마스터 그리드> 더블클릭)  -->
<div style="display:none;">
	<div id="jtePopForm" class="mrplanForm jtePopForm">
		<div class="pop_title">신규 프로젝트 필요 발주량 산출</div>
		<div id="jtePopForm_grid" style="height:350px;"></div>
	</div>
</div>

<div style="display:none;">
	<div id="jtePopAddForm" class="jtePopAddForm">
		<form id="jtePopAddForm_form" class="mrplanForm jtePopAddForm_form">
		<!-- 발주계획 -->
			<div class="pop_title"><spring:message code = "pop_mtrlOrderPlan"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
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
					<td>
						<input type="text" id="mtrlNm" class="left-input btn-input" name="mtrlNm" readonly/> <!-- style="width: 60%;" -->
						<input type="hidden" id="mtrlId" name="mtrlId" />
						<input type="hidden" id="mtrlCost" name="mtrlCost" />
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="gfn_openCustomPop('material',lfn_mtrlPop_callback);" >
				<!-- 조회 -->
							<spring:message code = "btn_search"></spring:message></button>
					</td>
				<!-- 자재구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlDiv"></spring:message> : </td>
					<td colspan="2"><input id="mtrlDiv" class="right-input" name="mtrlDiv" placeholder="<spring:message code = "pop_mtrlSrhAuto"/>" format="text" readonly/></td>
				</tr>
				<tr>
				<!-- 업체명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm"></spring:message> : </td>
					<td>
						<input type="text" id="compNm" class="left-input btn-input" name="compNm" readonly/> <!-- style="width: 60%;" -->
						<input type="hidden" id="compId" name="compId" />
					</td>
					<td>
					<button class="k-button k-primary search-btn" type="button" onclick="lfn_openMtrlCompPop()" >
				<!-- 조회 -->
							<spring:message code = "btn_search"></spring:message></button>
					</td>
				<!-- 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_quantity"></spring:message> : </td>
					<td colspan="2"><input id="mtrlOrderQty" class="left-input" name="mtrlOrderQty" format="currency" onkeyup="lfn_mtrlTotlCostCalc()"/></td>					
				</tr>
				<tr>
				<!-- 배송비용 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_deliveryCost"></spring:message> : </td><!-- 배송비용 -->
					<td colspan="2"><input id="mtrlOrderDelivery" class="right-input" name="mtrlOrderDelivery" format="currency"/></td>
				<!-- 금액 -->	
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_cost"></spring:message>
				<!-- 자재와 수량을 입력하면 기본적으로 자동계산됩니다. -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_mtrlQtyAuto"></spring:message>"></i> : </td>
					<td colspan="2"><input id="mtrlOrderCost" class="right-input" name="mtrlOrderCost" format="currency"/></td>
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
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/mfgplanMgt/mrplanMgt/mrplanMgtForm.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200827 youmi  -->


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
	lfo_common.ctrlUrl = "/cform/mfgMgt/mfgplanMgt/mrplanMgt"
	
	//4.
		lfo_common.crud  = {
			read:{url:"/getLotList", auth:"", prmt:{}}
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
		{field: "orderId", title:gfn_getMsg("btn_search") ,width: "80px",
			template: function(rows){
				return '<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); "><spring:message code = "btn_search"/></button>';
			}
		},
		{field: "orderId", title:gfn_getMsg("col_orderId"), width: "170px;"},				//프로젝트코드
		{field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "170px;"},				//프로젝트명
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},				//수주코드
		{field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "170px;"},				//수주명
		{field: "lotQty", format: "{0:n0}", title:gfn_getMsg("col_lotQty"), width: "120px;"},				//수주수량
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px;"}				//부품명
		
		
	];
	
	//7
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" },						//부품명
		{ text: gfn_getMsg("col_lotNm"), value: "lot.lot_nm" },							//수주명
		{ text: gfn_getMsg("col_orderNm"), value: "orderInfo.order_nm" }				//프로젝트명
	];
	
	
	
	//공통 그리드 세팅 호출
	lfo_common.grid = gfn_grid_set(lfo_common);
}



this.lfn_jtePop_open = function(mode, target){

	var options = {
			modal:true, 
			width: "1200px",
			height: "392px", /* 400 -> 392px_200827 youmi */
			id : lfo_common.popId, 
			title: "신규 프로젝트 필요 발주량 산출",
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

//팝업 내부 그리드
this.lfn_jtePopGrd_setGrd = function(){
	
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	lfo_popGrd.popId = "jtePopAddForm";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/mfgMgt/mfgplanMgt/mrplanMgt";
	
	//4.
	lfo_popGrd.crud = {
		read:{url:"/getMrpMtlList", auth:"",search:false, prmt:{orderId: lfo_common.gridSelected.orderId,lotId: lfo_common.gridSelected.lotId }},
		update:{url:"/setMtrlOrderSave", auth:"", openFunc : "", callback:lfn_jtePopGrd_save}
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
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "140px;"},									//제품명
		{field: "lotQty",format: "{0:n0}", title:gfn_getMsg("col_lotQty"), width: "90px;"},				//주문량
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "140px;"},									//자재명
		{field: "bomTargetCnt", title:gfn_getMsg("col_standardQty"), width: "90px;"},						//표준량
		{field: "mtrlNeed", format: "{0:n0}",title:gfn_getMsg("col_needQty"), width: "110px;"},				//필요량
		{field: "mtrlMgtCnt",format: "{0:n0}", title:gfn_getMsg("col_mtrlStockQty"), width: "120px;"},		//자재 재고량
		{field: "mtrlOrderQty",format: "{0:n0}", title:gfn_getMsg("col_mtrlOrderExpect"), width: "110px;"},							//입고 예정
		{field: "mtrlUseNeed",format: "{0:n0}", title:gfn_getMsg("col_mtrlUseExpect"), width: "110px;"},							//사용예정
		{field: "mtrlCanUse", format: "{0:n0}",title: gfn_getMsg("col_mtrlCanUse"),width: "90px;"},									//가용량
		{field: "mtrlOdCnt",format: "{0:n0}", title: gfn_getMsg("col_mtrlOdQty"), width:"90px"},									//발주량
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this); " style="min-width:60px;"><spring:message code = "pop_mtrlOrderRegist"/></button>',
			title:gfn_getMsg("pop_mtrlOrderRegist"), width: "110px"}
	];
	
	//공통 팝업 내부 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
//조회 버튼 클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "710px",  
		height: "392px",  /* 400 -> 392px_200827 youmi */
		id:lfo_popGrd.popId, 
		
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlPlanRegist");			//발주계획 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlPlanRegist");				//발주계획 수정
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	
	//팝업 object 데이터맵핑
	lfo_popGrd.gridSelected = lfo_popGrd.grid.dataItem($(selectedItem).closest('tr'));
	lfo_popGrd.gridSelected.mtrlOrderQty = lfo_popGrd.gridSelected.mtrlOdCnt;
	lfo_popGrd.gridSelected.mtrlOrderState = "mtrl_order_temp";
	
	//팝업 내용 채우기
	gfn_popform_set(lfo_popGrd, mode,lfo_popGrd.gridSelected);
	
	//자재비용 계산 호출
	lfn_mtrlTotlCostCalc();
}

//자재정보 콜백
this.lfn_mtrlPop_callback = function(callbackObj){
	$("#"+ lfo_popGrd.popId + "_form [name='mtrlId']").val(callbackObj.mtrlId);
	$("#"+ lfo_popGrd.popId + "_form [name='mtrlNm']").val(callbackObj.mtrlNm);
	$("#"+ lfo_popGrd.popId + "_form [name='mtrlCost']").val(callbackObj.mtrlCost);
	$("#"+ lfo_popGrd.popId + "_form [name='mtrlDiv']").val(callbackObj.mtrlDiv);
	lfn_mtrlTotlCostCalc();
}
//자재구매가능 업체조회 팝업
// 20.05.07|ymlee|업체 리스트 불러오도록 수정
this.lfn_openMtrlCompPop= function(){
	var compCode = $("#"+ lfo_popGrd.popId + "_form [name='compId']").val();
	if(gfn_isNull(compCode)){
		gfn_openCustomPop('company',lfn_compPop_callback,{compId:compCode});
	}
	
}
//업체정보 콜백
this.lfn_compPop_callback = function(callbackObj){
	$("#"+ lfo_popGrd.popId + "_form [name='compId']").val(callbackObj.compId);
	$("#"+ lfo_popGrd.popId + "_form [name='compNm']").val(callbackObj.compNm);
}

//자재비용 계산
this.lfn_mtrlTotlCostCalc = function(){
	var mtrlCost = parseInt($("#"+ lfo_popGrd.popId +" [name=mtrlCost]").val());
	var mtrlOrderQty = parseInt($("#"+ lfo_popGrd.popId +" [name=mtrlOrderQty]").val());
	if(!isNaN(mtrlCost) && !isNaN(mtrlOrderQty)){
		$("#"+ lfo_popGrd.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value(mtrlCost * mtrlOrderQty);
	}else{
		$("#"+ lfo_popGrd.popId + "_form [name=mtrlOrderCost]").data("kendoNumericTextBox").value("0");
	}
}

//Form내용 입력/저장

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
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					//마스터그리 리로드
					lfo_popGrd.grid.dataSource.read();
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