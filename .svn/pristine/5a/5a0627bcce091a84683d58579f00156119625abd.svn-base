<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="costMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="costMgtForm"></div>
</div>
<div style="display:none;">
	<div id="jtePopForm">
		<!-- 수주정보 -->
		<div class="pop_title"><spring:message code = "pop_orderInfo"></spring:message></div>
		<form id="jtePopForm_form">
			<table style="width:100%;" id="jtePopForm_master" class="costMgtForm jtePopForm_master">
			<colgroup>
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr>
				<!-- 수주코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_orderCd" /> : </td>
					<td><input type="text" id="orderId" class="left-input" name="orderId" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_compNm" /> :  </td>
					<td>
						<input type="text" id="compNm" class="right-input" name="compNm" format="text" readonly/>
						<input type="hidden" id="compId" name="compId"/>
					</td> 
				</tr>
				<tr>
				<!-- 수주일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_orderDate" /> : </td>
					<td><input id="orderStdt" class="left-input" name="orderStdt" format="datepicker" readonly/></td>
				<!-- 납기일 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_deliveryDate" /> : </td>
					<td><input id="orderEddt" class="right-input" name="orderEddt" format="datepicker" readonly/></td>
				</tr>
				<tr>
				<!-- 비용 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_cost" /> : </td>
					<td><input id="orderCost" class="left-input" name="orderCost"  format="currency" readonly/></td>
				<!-- 관리자 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_manager" /> : </td>
					<td>
						<input type="text" id="orderManagerNm" class="right-input" name="orderManagerNm" format="text" readonly/>
						<input type="hidden" id="orderManager" class="right-input" name="orderManager"/>
					</td>
					
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_desc" /> : </td>
					<td colspan="3"><input type="text" id="description" class="k-textbox center-input" name="description" readonly/></td>
				</tr>
			</table>
		</form>
		<div class="pop_title"><spring:message code = "pop_lotCostMgt"></spring:message></div>
		<div id="jtePopForm_grid"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_close"/></button>			<!-- 닫기 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/orderMgt/costMgt/costMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/orderMgt/costMgt/costMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200430 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//서브그리드에서 사용될 Object

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
	lfo_common.ctrlUrl = "/form/orderMgt/costMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getOrderCostList", auth:"", prmt:{}},
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
			compNm: { type: "string" },
			orderCostBefore: { type: "int" },
			orderCostAfter: { type: "int" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + ""+gfn_getMsg("pop_detailView")+"" + '</button>',
			title:gfn_getMsg("col_detailList"), width: "140px"},														//상세내역
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "150px"},											//수주코드
		//2020.05.14|ymlee|수주명 주석(신명기계 사용x)
		/* {template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "200px"},*/
		{field: "orderManagerNm",format:"{0:yyyy-mm-dd}", title:gfn_getMsg("col_manager"), width: "110px"},				//담당자
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_startDate"), width: "130px"},				//착수일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "130px"},			//납기일
		{field: "orderCost", format: "{0:n0}", title:gfn_getMsg("col_cost"), width: "120px"},							//금액
		{field: "orderState",template:"# var item = gfn_isNull(orderState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(orderState).cdId , gfn_getCode(orderState).cdNm) # #= item #",
			title:gfn_getMsg("col_proceedStatus"), width: "150px"},														//수주진행상태
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "140px"},												//업체명
		{field: "orderCostBefore", format: "{0:n0}", title:gfn_getMsg("col_manufactCost"), width: "150px"},				//제조원가
		{field: "orderCostAfter", format: "{0:n0}", title:gfn_getMsg("col_postCost"), width: "150px"},					//사후원가
		{field: "description", title:gfn_getMsg("col_desc"), width: "250px%"}											//설명
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },			//담당자
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },			//업체명
		{ text: gfn_getMsg("col_orderCd"), value: "orInfo.order_id" }			//수주코드
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "950px",
		height: "590px", //200504 그리드 더블클릭시 나오는 팝업 550px_LYM 200511 JJW 550px -> 560px
		id : lfo_common.popId, 
		title:gfn_getMsg("pop_costInfo"),			//수주원가 정보
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode,selectedItem);
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
				gfn_popform_set(lfo_common, mode, data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
	//그리드 세팅
	$("#jtePopForm_grid").html("");
	lfn_jtePopGrd_setGrd();
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
	lfo_popGrd.ctrlUrl = "/form/orderMgt/costMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getLotCostList", auth:"", prmt:{orderId : lfo_common.gridSelected.orderId}}, 
		//create:{url:"/setLotInfoSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		//update:{url:"/setClaimInfoSave", auth:"", callback:lfn_jtePopGrd_save}
		//destroy:{url:"/setClaimInfoDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
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
			prodId : { type: "string" },
			cliamId : { type: "string" },
			orderId : { type: "string" },
			prodNm: { type: "string" },
			lotItemId: { type: "string" },
			itemNm : {type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{title:"No.", width:"50px;", template: "#=++record #"},
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},										//Lot코드
		//2020.05.14|ymlee|LoT명 주석(신명기계 사용x)
		/* {field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "220px;"},									//Lot명 */
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px;"},										//부품명
		{field: "lotQty", title:gfn_getMsg("col_lotQty"), width: "120px;"},										//Lot수량
		{field: "lotType", template:"# var item = gfn_isNull(lotType)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotType).cdId , gfn_getCode(lotType).cdNm) # #= item #", 
				title:gfn_getMsg("col_orderType"), width: "130px;"},											//수주유형
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title:gfn_getMsg("col_orderStatus"), width: "130px;"},											//수주상태
		{field: "lotPersonCost", format: "{0:n0}", title:gfn_getMsg("col_laborCost"), width: "120px;"},			//인건비
		{field: "lotPersonCostAfter", format: "{0:n0}", title:gfn_getMsg("col_laborCost"), width: "120px;"},			//인건비
		{field: "lotMtrlCost", format: "{0:n0}", title:gfn_getMsg("col_mtrlCost"), width: "120px;"},				//자재비
		{field: "lotMtrlCostAfter", format: "{0:n0}", title:gfn_getMsg("col_mtrlCost"), width: "120px;"}				//자재비
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" },			//부품명
		{ text: gfn_getMsg("col_lotCd"), value: "lot.lot_id" }				//Lot코드
	];
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

</script>