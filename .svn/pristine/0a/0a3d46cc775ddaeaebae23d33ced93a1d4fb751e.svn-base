<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="claimMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="claimMgtForm"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm" class="jtePopForm">  <!-- style="margin-top: 5px;" -->
		<div id="jtePopForm_gridArea" style="display:none;">
			<div class="pop_title"><spring:message code = "pop_lotInfo"></spring:message></div>			<!-- LoT정보 -->
			<div id="jtePopForm_grid" class="claimMgtForm" style="height : 400px;"></div>
		</div>
	</div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm_Claim" class="jtePopForm">  <!-- style="margin-top: 5px;" -->
		<div id="jtePopForm_Claim_gridArea" style="display:none;">
			<div class="pop_title"><spring:message code = "col_claimInfo"></spring:message></div>			
			<div id="jtePopForm_Claim_grid" class="claimMgtForm" style="height : 330px;"></div>
		</div>
	</div>
</div>

<div style="display:none;">  <!-- 클레임 관리 > Lot 정보 >클레임정보 > 클레임등록 팝업창_LYM-->
	<div id="jtePopAddForm">
		<form id="jtePopAddForm_form" class="claimMgtForm">
			<div class="pop_title"><spring:message code = "pop_lotInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopAddForm_master" class="BasicTable">
			<colgroup>
				<col style="width:16%;">
				<col style="width:34%;">
				<col style="width:16%;">
				<col style="width:34%;">
			</colgroup>
				<tr>
				<!-- Lot코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotCd" /> : </td>
					<td>
						<input type="text" id="lotId" name="lotId" readonly/>
						<input type="hidden" id="lotSeq" name="lotSeq"/>
					</td>
				<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_itemNm" /> :  </td>
					<td>
						<input type="text" id="itemNm" name="itemNm" format="text" readonly/>
						<input type="hidden" id="itemId" name="itemId">
					</td>
				</tr>
<%-- 				<tr>
				<!-- Lot명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotWrkNm" /> : </td>
					<td colspan="3"><input type="text" id="lotNm" class="center-input" name="lotNm" format="text" readonly/></td>
				</tr> --%>
			</table>
			<div class="pop_title"><spring:message code = "pop_claimInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopAddForm_master" class="BasicTable">
			<colgroup>
				<col style="width:16%;">
				<col style="width:34%;">
				<col style="width:16%;">
				<col style="width:34%;">
			</colgroup>
				<tr>
				<!-- 클레임코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimCd" /> : </td>
					<td colspan="3"><input type="text" id="claimId" name="claimId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 클레임명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimNm" /> : </td>
					<td colspan="3"><input type="text" id="claimNm" name="claimNm"/></td>
				</tr>
				<tr>
				<!-- 클레임수량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimQty" /> : </td>		
					<td colspan="3">
						<input id="claimQty" name="claimQty" format="currency"/>
					</td>
					<!-- 관리자 -->
					<!--  <td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="" />작성자 : </td>
					<td>
						<input type="text" id="orderManagerNm" class="right-input btn-input" name="orderManagerNm" format="text" readonly/> 
						<input type="hidden" id="orderManager" class="right-input btn-input" name="orderManager"/>
					</td>-->
<%-- 					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
						<spring:message code="btn_search" /></button>
					</td> --%> <!-- 201020 youmi 조회 버튼 주석 처리 -->
			
				</tr>
				<tr>
				<!-- 발생원인 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimCause" /> : </td>
					<td colspan="3"><input type="text" id="claimCause" name="claimCause"/></td>
				</tr>
				<tr>
				<!-- 처리결과 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimResult" /> : </td>
					<td colspan="3"><input type="text" id="claimResult" name="claimResult"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_reason" /> : </td>
					<td colspan="3"><input type="text" id="claimDesc" name="claimDesc"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="orderId" id="claimOrderId"/>
						<input type="hidden" name="action" id="claimAction"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="claimMgtForm final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/orderMgt/claimMgt/claimMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200508 LYM  -->

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
	lfo_common.ctrlUrl = "/cform/orderMgt/claimMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getOrderList", auth:"", prmt:{}, dynamicPrmt:{orderState : "orderState"}},
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html :	'<div style="margin : 0 14px 0 5px; float:right;">수주상태 : '+
				'<input name="orderState" id="orderState" value="ord_prcd01"></div>'

	}
	
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
				claimCnt:{ type:"int" }
				}
		};
	
	//6.
	lfo_common.columns = [
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update"), width: 90},																	//수정
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "110px"},											//수주코드
		{template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "160px"},					//수주명
		{field: "orderManagerNm", title:gfn_getMsg("col_manager"), width: "80px;"},										//관리자
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "90px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "90px"},			//납기일
		{field: "orderCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost"), width: "100px"},							//비용
		{field: "description", title:gfn_getMsg("col_desc"), width: "250px"},											//설명
		{field: "orderState",template:"# var item = gfn_isNull(orderState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(orderState).cdId , gfn_getCode(orderState).cdNm) # #= item #",
			title : "수주상태", width: "100px"},														//수주진행상태
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "120px"},												//업체명 
		{field: "claimCnt", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_claimCount"), width: "80px"},						//클레임 건수
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_orderNm"), value: "orInfo.order_nm" },			//수주명
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },			//담당자
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },			//업체명
		{ text: gfn_getMsg("col_orderCd"), value: "orInfo.order_id" }			//수주코드


	];
	//8.
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	var selBoxItem = gfn_getCode('ord_prcd');
	
	$("#orderState").kendoDropDownList({
		dataSource: selBoxItem,
		dataValueField: "cdId",
		dataTextField: "cdNm",
	//	valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
	//	template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
		index:0,
		change: function(e) {
			/* $('#orderState').val(this.value()); */
			lfo_common.grid.dataSource.read();
		}
	});
}

//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
			modal:true, 
			width: "750px",
			height: "440px",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_orderRegist");
		options.id = "jtePopAddForm";
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_lotInfo");	
		options.id = "jtePopForm";
	}else if(mode =="LOT"){
		options.width = "800px;";
		options.height = "390px;";
		options.title = gfn_getMsg("pop_claimInfo");
		options.id = "jtePopForm_Claim";
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
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
	
	lfo_popGrd.popId = "jtePopForm";
	//3.
	lfo_popGrd.ctrlUrl = "/cform/orderMgt/claimMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getLotList", auth:"", prmt:{orderId : lfo_common.gridSelected.orderId}}, 
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
				itemId : { type: "string" },
				cliamId : { type: "string" },
				orderId : { type: "string" },
				itemNm: { type: "string" },
				itemDeduction: { type: "int" },
				mtrlNm: { type: "string" },
				mtrlQty: { type: "string" },
				mtrlDiv: { type: "string" },
				mtrlDesc: { type: "string" },
				claimCnt: { type: "int"}
			}
		};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "lotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'LOT\',this)" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update"), width: 90},									//수정
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},				//Lot코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px;"},				//부품명
		{field: "lotQty", title:gfn_getMsg("col_lotQty"), width: "120px;"},				//Lot수량
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title : "작업상태", width: "120px;"},					//수주상태
		{field: "claimCnt", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_claimCount"), width: "100px"},						//클레임 건수
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" },			//부품명
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },		//담당자
		{ text: gfn_getMsg("col_lotWrkNm"), value: "lot.lot_nm" },			//Lot명
		{ text: gfn_getMsg("col_lotCd"), value: "lot.lot_id" }				//Lot코드
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);

}

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd_claim = function(prmt){
	lfo_claimPopGrd = {};


	lfo_claimPopGrd.prmt = prmt;
	
	//1.
	lfo_claimPopGrd.layoutId = "jtePopForm_Claim_grid";
	
	//2.
	lfo_claimPopGrd.popId = "jtePopAddForm";
	
	//3.
	lfo_claimPopGrd.ctrlUrl = "/cform/orderMgt/claimMgt" ;
	
	//4.
	lfo_claimPopGrd.crud  = {
		read:{url:"/getLotClaimList", auth:"", prmt:{lotId : lfo_popGrd.gridSelected.lotId}},
		create:{url:"/setClaimInfoSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"/setClaimInfoSave", auth:"", openFun: "" ,callback:lfn_jtePopGrd_save},
		destroy : {url:"/setClaimInfoDelete", auth: "" , callback:lfn_claimPopGrd_delete}
	};
	
	//5.
	lfo_claimPopGrd.model = {
			id: "claimId",
			fields: {
				claimId : { type: "string" },
				claimNm : { type: "string" },
				claimQty : { type: "int" },
				claimState : { type: "string" },
				claimDesc : { type: "text" },
				claimCause : { type: "text" },
				claimResult : { type: "text" },
				lotId : { type: "string" }
			}
		};
	lfo_claimPopGrd.selectBox = ["이름"];
	
	//6.
	lfo_claimPopGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "claimId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this)" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update"), width: "90px;"},
		{field: "claimId", title:gfn_getMsg("col_cdId"), width: "150px;"},				
		{field: "claimNm", title:gfn_getMsg("col_userNm"), width: "150px;"},				
		{field: "claimQty", title:gfn_getMsg("col_quantity"), width: "120px;"},
// 		{field: "claimState", template:"# var item = gfn_isNull(claimState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(claimState).cdId , gfn_getCode(claimState).cdNm) # #= item #", 
// 			title: gfn_getMsg("col_claimStatus"), width: "150px;"},	
		{field: "claimCause", title:gfn_getMsg("col_claimCause"), width: "120px;"},
		{field: "claimResult", title:gfn_getMsg("col_claimResult"), width: "120px;"},
		{field: "claimDesc", title:gfn_getMsg("col_reason"), width: "150px;"}
	];

	//공통 그리드 세팅 호출
	lfo_claimPopGrd.grid = gfn_grid_set(lfo_claimPopGrd);

}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	
	lfo_common.gridSelected = "";
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode, selectedItem);
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
		
	}else if(mode == 'EDT'){
		
		$("#jtePopForm_gridArea").show();
		
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
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
		
		lfn_jtePopGrd_setGrd();
	}else if(mode == 'LOT'){
		$("#jtePopForm_Claim_gridArea").show();
		lfo_popGrd.gridSelected = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr"));
		/* $("#jtePopForm_grid").html(""); */
		lfn_jtePopGrd_setGrd_claim(lfo_popGrd.gridSelected);
	}
	//그리드 세팅
}
//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	/* //작업종료된 lot만 등록, 수정 가능하도록 (감리 사항)
	if(lfo_popGrd.gridSelected.lotState != "ord_sta02"){
		gfn_warnBox({msg : "작업이 종료된 LOT만 클레임 등록이 가능합니다."});
		return false;
	} */
	
	var options = {
		modal:true, 
		width: "710px",  //200507 수주 관리 그리드 더블클릭 → 팝업창 하단 그리드 더블 클릭 혹은 추가 버튼 클릭 시의 팝업창 width 변경_610->710px LYM 
		height: "500px",  ///200507 팝업창 height 변경_280->290px LYM 200810 youmi 440->450px 200820 290->302px // 201020 youmi 490->410
		id: lfo_claimPopGrd.popId, 
		//title:gfn_getMsg("pop_addPop"),			//추가팝업
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"],
		title : gfn_getMsg("pop_claimRegist")
	};
	
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_popSet = function(mode, selectedItem){
	
	var gridSelected = "";
	
	if(mode =='NEW'){
		gridSelected = {
				lotId : lfo_claimPopGrd.prmt.lotId,
				itemNm : lfo_claimPopGrd.prmt.itemNm
		};
	}else if(mode == 'EDT'){
		gridSelected = lfo_claimPopGrd.grid.dataItem($(selectedItem).closest("tr"));
		gridSelected.lotId = lfo_claimPopGrd.prmt.lotId;
		gridSelected.itemNm = lfo_claimPopGrd.prmt.itemNm
	}

	gfn_popform_set(lfo_claimPopGrd, mode, gridSelected);
		//부품등록, 자재등록 버튼 활성화
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(mode){
	
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_claimPopGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_claimPopGrd.popId+"_form").serializeObject();
		/* savePrmt.defectList = lfo_common.defectList; */
		savePrmt.defectInsertList = lfo_common.defectInsertList
		savePrmt.defectUpdateList = lfo_common.defectUpdateList
		savePrmt.defectDeleteList = lfo_common.defectDeleteList
		$.ajax({
			async:false,
			url : lfo_claimPopGrd.ctrlUrl + lfo_claimPopGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != "") {
					//마스터 그리드 리로드
					lfo_claimPopGrd.grid.dataSource.read();
					lfo_popGrd.grid.dataSource.read();
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_claimPopGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", gfn_getMsg("pop_successSave"))});			//성공
				} else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", gfn_getMsg("pop_failedCheck"))});				//실패
				} 
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});			//오류가 발생했습니다.
			}
		});
	}
}

this.lfn_userInfoPop_callback = function(rtnObj){
	$("#orderManager.right-input.btn-input").val(rtnObj["userId"]);
	$("#orderManagerNm.right-input.btn-input").val(rtnObj["userNm"]);
}
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}
this.lfn_defectPop_open = function(){
 	var options = {
		modal:true, 
		width: "650px", //200506 JJW 기본 너비  값 750 -> 650로 변경 LYM 750
		height: "460px",  //200506 첫번째 팝업창 그리드의 클레임 정보 입력 버튼 클릭 후 불량 정보 등록 버튼 클릭 시 나오는 팝업창 height 변경 550->555_LYM 200506 JJW 550-> 510
		id : "pop_defectInfo", 
		title:gfn_getMsg("pop_badInfoRegist"),			// 불량정보등록
		resizable:false,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_defectPopup();};
	this.gfn_winOpen(options);
}

//삭제 콜백
this.lfn_claimPopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_claimPopGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_claimPopGrd.grid.dataItem($(this).closest('tr')));
		}
	});

	$.ajax({
		async:false,
		url : lfo_claimPopGrd.ctrlUrl + lfo_claimPopGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_claimPopGrd.grid.dataSource.read();
			lfo_popGrd.grid.dataSource.read();
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed",gfn_getMsg("pop_errorFailed"))});			//오류가 발생했습니다.
		}
	});
}

</script>