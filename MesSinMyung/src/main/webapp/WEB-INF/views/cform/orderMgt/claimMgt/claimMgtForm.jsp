<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content"  style="width:100%;">
	<div id="jteSingleGrid"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm"> <!-- style="margin-top: 5px;" -->
		<form id="jtePopForm_form" class="claimMgtForm">
		<!-- 수주정보 -->
			<div class="pop_title"><spring:message code = "pop_orderInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
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
				<!-- 업체명 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code="col_compNm" /> :  </td>
					<td>
						<input type="text" id="compNm" class="right-input" name="compNm" format="text" readonly/>
						<input type="hidden" id="compId" class="right-input" name="compId"/>
					</td>
				</tr>
<%-- 				<tr>
				<!-- 수주명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_orderNm" /> : </td>
					<td colspan="3"><input type="text" id="orderNm" class="center-input" name="orderNm" format="text" readonly/></td>
				</tr> --%>
				<tr>
				<!-- 수주일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_orderDate" /> : </td>
					<td><input id="orderStdt" class="left-input" name="orderStdt" format="datepicker" readonly/></td>
				<!-- 납기일 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code="col_deliveryDate" /> : </td>
					<td><input id="orderEddt" class="right-input" name="orderEddt" format="datepicker" readonly/></td>
				</tr>
				<tr>
				<!-- 비용 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_cost" /> : </td>
					<td><input id="orderCost" class="left-input" name="orderCost"  format="currency" readonly/></td>
				<!-- 관리자 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code="col_manager" /> : </td>
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
		<!-- LoT 및 클레임 정보 -->
		<div class="pop_title"><spring:message code = "pop_lotClaimInfo"></spring:message></div>
		<div id="jtePopForm_grid"></div>
	</div>
</div>

<div style="display:none;">  <!-- 클레임 관리 그리드 더블클릭 → 팝업창 하단 그리드 좌측의 클레임 정보 입력 버튼 클릭 했을 시의 팝업창_LYM-->
	<div id="jtePopAddForm">
		<form id="jtePopAddForm_form" class="claimMgtForm claimMgtForm-popsc">
			<table style="width:100%;" id="jtePopAddForm_master" class="jtePopAddForm_master">
			<colgroup>
				<col class="popsc-col-left-title">  <!-- style="width:15%;" -->
				<col class="popsc-col-left-content">  <!-- style="width:35%;" -->
				<col class="popsc-col-right-title">  <!-- style="width:15%;" -->
				<col class="popsc-col-right-content">  <!-- style="width:35%;" -->
			</colgroup>
				<tr>
				<!-- LoT정보 -->
					<td colspan="4" class="pop_title"><spring:message code = "pop_lotInfo"></spring:message></td>
				</tr>
				<tr>
				<!-- Lot코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotCd" /> : </td>
					<td>
						<input type="text" id="lotId" class="left-input" name="lotId" readonly/>
						<input type="hidden" id="lotSeq" class="left-input" name="lotSeq"/>
					</td>
				<!-- 부품명 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_itemNm" /> :  </td>
					<td>
						<input type="text" id="itemNm" class="right-input" name="itemNm" format="text" readonly/>
						<input type="hidden" id="itemId" name="itemId">
					</td>
				</tr>
<%-- 				<tr>
				<!-- Lot명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotWrkNm" /> : </td>
					<td colspan="3"><input type="text" id="lotNm" class="center-input" name="lotNm" format="text" readonly/></td>
				</tr> --%>
			</table>
			<table style="width:100%;" id="jtePopAddForm_master" class="jtePopAddForm_master jtePopAddForm_master_sc">
			<colgroup>
				<col class="popsc-col-left-title">  <!-- style="width:15%;" -->
				<col class="popsc-col-left-content">  <!-- style="width:35%;" -->
				<col class="popsc-col-right-title">  <!-- style="width:15%;" -->
				<col class="popsc-col-right-content">  <!-- style="width:35%;" -->
			</colgroup>
				<tr>
				<!-- 클레임정보 -->
					<td colspan="4" class="pop_title"><spring:message code = "pop_claimInfo"></spring:message></td>
				</tr>
				<tr>
				<!-- 클레임코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimCd" /> : </td>
					<td colspan="3"><input type="text" id="claimId" class="center-input" name="claimId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 클레임명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimNm" /> : </td>
					<td colspan="3"><input type="text" id="claimNm" class="center-input" name="claimNm"/></td>
				</tr>
				<tr>
				<!-- 클레임수량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimQty" /> : </td>		
					<td colspan="2">
						<input id="claimQty" class="center-input btn-input" name="claimQty"  format="currency" readonly/>
					</td>
					<td><button class="k-button k-primary popsc-btn" type="button" onclick = "lfn_defectPop_open()">
				<!-- 불량 정보 등록 -->
					<spring:message code = "pop_badInfoRegist"></spring:message></button></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_desc" /> : </td>
					<td colspan="3"><input type="text" id="claimDesc" class="center-input" name="claimDesc"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="orderId" id="claimOrderId"/>
						<input type="hidden" name="action" id="claimAction"/>
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

<div style="display:none;">  <!-- 클레임 관리 그리드 더블클릭 → 팝업창 하단 그리드 좌측의 재수주 버튼 클릭 시의 팝업창_LYM-->
	<div id="jteClaimReorderForm">
		<form id="jteClaimReorderForm_form" class="claimMgtForm claimMgtForm-poptr">
			<table style="width:100%;" id="jteClaimReorderForm_master" class="jteClaimReorderForm_master">
			<colgroup>
				<col class="poptr-col-left-title">  <!-- style="width:15%;" -->
				<col class="poptr-col-left-content-1">  <!-- 원래 1 2 합쳐서 style="width:35%;" -->
				<col class="poptr-col-left-content-2">
				<col class="poptr-col-right-title">  <!-- style="width:15%;" -->
				<col class="poptr-col-right-content-1">  <!-- 원래 1 2 합쳐서 style="width:35%;" -->
				<col class="poptr-col-right-content-2">
			</colgroup>
				<tr>
				<!-- 클레임 재발주 -->
					<td colspan="6" class="pop_title"><spring:message code = "pop_RemtrlOrder"></spring:message></td>
				</tr>
				<tr>
				<!-- Lot코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotCd" /> : </td>
					<td colspan="5">
						<input type="text" id="reLotId" class="left-input" name="lotId" readonly/>
						<input type="hidden" id="reLotSeq" class="left-input" name="lotSeq"/>
					</td>
<%-- 				<!-- Lot내부코드 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_lotInsideCd" /> :  </td>
					<td colspan="2">
						<input type="text" id="reLotCode" class="right-input" name="lotCode" format="text"/>
					</td> --%>
				</tr>
<%-- 				<tr>
				<!-- Lot명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotWrkNm" /> : </td>
					<td colspan="5"><input type="text" id="reLotNm" class="center-input" name="lotNm" format="text"/></td>
				</tr> --%>
				<tr>
				<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_itemNm" /> : </td>
					<td colspan="2">
						<input type="text" id="reItemNm" class="left-input" name="itemNm"/>
						<input type="hidden" id="reItemId" class="left-input" name="itemId"/>
					</td>
				<!-- 관리자 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code="col_manager" /> : </td>
					<td>
						<input type="text" id="reLotPmNm" class="right-input btn-input" name="lotPmNm" format="text" readonly/>
						<input type="hidden" id="reLotPm" class="right-input btn-input" name="lotPm"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
				<!-- 조회 -->
						<spring:message code="btn_search" /></button>
					</td>
					
				</tr>
				<tr>
				<!-- Lot수량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotQty" /> : </td>
					<td colspan="2"><input id="leLotQty" class="left-input" name="lotQty" format="currency"/></td>
				<!-- 공제량 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_deduction"></spring:message> : </td>
					<td colspan="2"><input id="reItemDeduction" class="right-input" name="itemDeduction" format="currency"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="orderId" id="reOrderId"/>
						<input type="hidden" name="claimId" id="reClaimId"/>
						<input type="hidden" name="action" id="reLotAction"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteClaimReorderForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>
<%-- 
<div style="display:none;">
	<div id="defectPopup">
		<form id="defectPopup_form">
			<div id="defectInfoOption">
				<button class="k-button k-primary" type="button" id="defectAdd" >+</button>
				<button class="k-button k-primary" type="button" id="defectRemove" >-</button>
			</div>
			<ul id="defectInfo">
			</ul>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary" type="button" onclick = "lfn_saveDefectList()"><spring:message code = "pop_save"></spring:message></button>									<!-- 저장 -->
				<button class="k-button k-primary" type="button" onclick = "gfn_closePop('defectPopup');"><spring:message code = "pop_cancel"></spring:message></button>				<!-- 취소 -->
			</div>
		</form>
	</div>
</div> --%>

<div style="display:none;">  <!-- 클레임 관리 그리드 더블클릭 → 팝업창 하단 그리드 좌측의 클레임 정보 입력 버튼 클릭 → 불량 정보 등록 버튼 클릭 시의 팝업창_LYM-->
	<div id="pop_defectInfo" class="routingMgtForm">
		<form id="pop_defectInfo_Form" class="toolInfoPopup_form routingMgtForm claimMgtForm claimMgtForm-popfo">
			<div id="defectInfoOption" class="plus-minus-btn-area">
				<button class="k-button k-primary plus-minus-btn" type="button" id="defectAdd">+</button>
				<button class="k-button k-primary plus-minus-btn" type="button" id="defectRemove">-</button>
			</div>
			<div>
				<table id="toolInfo-title" class="toolInfo toolInfo-title claimMgtForm claimMgtForm-toolInfo-title">
					<colgroup>
						<col class="col-toolInfo-check">
						<col class="col-toolInfo1">
						<col class="col-toolInfo2">
					</colgroup>
					<tr>
						<td><span style="visibility: hidden;"></span></td>
						<td><spring:message code ="col_badCause"></spring:message></td>
						<td><spring:message code = "col_badProdQuan"></spring:message></td>
					</tr>
				</table>
			</div>
			<div class="toolInfo-div">
				<table id="defectInfo" class="toolInfo toolInfo-content claimMgtForm claimMgtForm-toolInfo-content">
				</table>
			</div>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary final-btn" type="button" onclick = "lfn_saveRtlDefectList()"><spring:message code = "pop_save"></spring:message></button>									<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('pop_defectInfo');"><spring:message code = "pop_cancel"></spring:message></button>				<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<div style="display:none;">
	<div id="claimRegistry">
		<div id="claimRegistry_grid"></div>
	</div>
</div>
<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/orderMgt/claimMgt/claimMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/orderMgt/claimMgt/claimMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200428 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//서브그리드에서 사용될 Object

var lfo_claimReorder ={};

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
		read:{url:"/getOrderClaimList", auth:"", prmt:{}}
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
				claimCnt:{ type:"int" }
				}
		};
	
	//6.
	lfo_common.columns = [
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_detailView"/>" + '</button>',
			title:gfn_getMsg("btn_search"), width: "120px"},															//조회
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "150px"},											//수주코드
		//2020.05.14|ymlee|수주명 주석(신명기계 사용x)
		/* {template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "200px"},					//수주명 */
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "130px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "130px"},			//납기일
		{field: "orderCost", format: "{0:n0}", title:gfn_getMsg("col_cost"), width: "140px"}, 							//비용
		{field: "orderManagerNm",format:"{0:yyyy-mm-dd}", title:gfn_getMsg("col_manager"), width: "120px"}, 			//담당자
		{field: "orderState",template:"# var item = gfn_isNull(orderState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(orderState).cdId , gfn_getCode(orderState).cdNm) # #= item #", 
			title:gfn_getMsg("col_proceedStatus"), width: "130px"},														//수주진행상태
		{field: "compNm", title:"업체명", width: "150px"},																	//업체명
		{field: "claimCnt", format: "{0:n0}", title:gfn_getMsg("col_claimCount"), width: "100px"}						//클레임 건수
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },			//관리자
		{ text: gfn_getMsg("col_orderCd"), value: "orInfo.order_id" }			//수주코드
		/* { text: gfn_getMsg("col_orderNm"), value: "orInfo.order_nm" },			//수주명 */
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
//lfo_common.gridSelected = {orderId : selectedItem["orderId"]};
//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px",
		height: "560px", //200504 그리드 더블클릭시 나오는 팝업 550px_LYM 200511 JJW 550px -> 560px
		id : lfo_common.popId, 
		title:gfn_getMsg("pop_claimInfoSrh"),			// 클레임 관련정보 조회
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
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
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
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
	lfo_popGrd.ctrlUrl = "/cform/orderMgt/claimMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getLotClaimList", auth:"", prmt:{orderId : lfo_common.gridSelected.orderId}},
		update:{url:"/setClaimInfoSave", auth:"", callback:lfn_jtePopGrd_save}
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
				orderId : { type: "string" },
				itemNm: { type: "string" },
				itemDeduction : { type : "int"}
			}
		};
	
	//6.
	lfo_popGrd.columns = [
		{title:"No.", width:"50px;", template: "#=++record #"},
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"}, 				//Lot코드
		//2020.05.14|ymlee|LoT명 주석(신명기계 사용x)
		/* {field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "220px;"},			//Lot명 */
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px;"},				//부품명
		{field: "lotQty", title:gfn_getMsg("col_lotQty"), width: "120px;"},				//Lot수량
		{field: "lotType", template:"# var item = gfn_isNull(lotType)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotType).cdId , gfn_getCode(lotType).cdNm) # #= item #",
				title:gfn_getMsg("col_orderType"), width: "120px;"},					//수주유형
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title:gfn_getMsg("col_orderStatus"), width: "120px;"},					//수주상태
		{field: "claimInfo", title: gfn_getMsg("col_claimInfo"), width:"150px",			//클레임정보 
			template : function(rows) {
				return '<button class="k-button k-primary" type="button" onclick="lfn_claimRegistyPop(this)"><spring:message code = "pop_claimInfoInput"/></button>';			//클레임 정보 입력
			}
		}
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" },			//부품명
		{ text: gfn_getMsg("col_lotCd"), value: "lot.lot_id" }				//Lot코드
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_claimPopGrd_popOpen = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "720px",			//200504 첫번째 팝업창의 클레임 정보 입력 클릭시 나오는 팝업창 width 변경 620->720_LYM
		height: "490px", 		//200504 첫번째 팝업창의 클레임 정보 입력 클릭시 나오는 팝업창 height 변경 400->450_LYM 200506 JJW 400 -> 490
		id:lfo_claimPopGrd.popId, 
		//title:gfn_getMsg("pop_lotClaimMgt"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_claimRegist");			//클레임 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_claimSrh");				//클레임 수정
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_claimPopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}


//팝업내용 세팅
this.lfn_claimPopGrd_popSet = function(mode, selectedItem){
	
	lfo_popGrd.gridSelected = {};
	if(mode=='NEW'){
		selectedItem.orderId = lfo_common.gridSelected.orderId;
		gfn_popform_set(lfo_claimPopGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		gfn_popform_set(lfo_claimPopGrd, mode, selectedItem);
		//클레임은 추가/삭제를 모두 더블클릭 팝업을 이용하기 때문에 클레임아이디에 따라 분기처리
		if(gfn_isNull($("#"+lfo_claimPopGrd.popId+"_form [name=claimId]").val())){
			$("#"+lfo_claimPopGrd.popId+"_form [name=action]").val("C");
		} else{
			$("#"+lfo_claimPopGrd.popId+"_form [name=action]").val("U");
		}
	}
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		/* savePrmt.defectList = lfo_common.defectList; */
		savePrmt.defectInsertList = lfo_common.defectInsertList
		savePrmt.defectUpdateList = lfo_common.defectUpdateList
		savePrmt.defectDeleteList = lfo_common.defectDeleteList
		
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + "/setClaimInfoSave",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != "") {
					//마스터 그리드 리로드
					lfo_claimPopGrd.grid.dataSource.read();
					
					//팝업종료
					gfn_closePop(lfo_popGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				} else{
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
			
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});		//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//재수주 팝업 오픈
this.lfn_claimReorderPop = function(target){
	//재발주 object 세팅
	lfo_claimReorder = {
		popId:"jteClaimReorderForm",
		ctrlUrl:"/cform/orderMgt/claimMgt",
		crud:{ 
				create:{url:"/setClaimInfoSave", auth:"", openFunc:"", callback : lfn_claimReorder_save}
		}
	}
	var dataItem = lfo_claimPopGrd.grid.dataItem($(target).closest("tr"));
	dataItem.itemNm = lfo_claimPopGrd.selectedLot.itemNm;
	
	var options = {
			modal:true, 
			width: "720px", //200506 첫번째 팝업창의 그리드 재수주 버튼 클릭시 나오는 팝업창 width 변경 620->720_LYM
			height: "310px", //200504 첫번째 팝업창의 그리드 재수주 버튼 클릭시 나오는 팝업창 height 변경 250->320_LYM 200506 JJW 250 -> 310
			id : lfo_claimReorder.popId, 
			title:gfn_getMsg("pop_reorderRegist"),			//재수주 등록
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_claimReorder_popSet("NEW",dataItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_claimReorder_popSet = function(mode,selectedItem){
	gfn_popform_set(lfo_claimReorder, mode, selectedItem);
	//추가 매핑
	$("#"+lfo_claimReorder.popId+"_form [name=action]").val("RE");
	$("#"+lfo_claimReorder.popId+"_form [name=lotQty]").data("kendoNumericTextBox").value(selectedItem.claimQty);
}

//Form내용 입력/저장
this.lfn_claimReorder_save = function(mode){
	//입력폼 serialize 
	var savePrmt = $("#"+lfo_claimReorder.popId+"_form").serializeObject();
	
	kendo.confirm(gfn_getMsg("pop_reOrderConfirm"))
	.done(function(){
		$.ajax({
			async:false,
			url : lfo_claimReorder.ctrlUrl + lfo_claimReorder.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					lfo_popGrd.grid.dataSource.read();
					lfo_claimPopGrd.grid.dataSource.read();

					//팝업종료
					gfn_closePop(lfo_claimReorder.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}).fail(function(){return false;});
	
}
//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

//pop - 유저정보 팝업 콜백
this.lfn_userInfoPop_callback = function(rtnObj){
	$("#reLotPm").val(rtnObj["userId"]);
	$("#reLotPmNm").val(rtnObj["userNm"]);
}

this.lfn_claimInfo = function(mode, selectedItem) {
	if(mode == "NEW") {
		lfn_claimPopGrd_popOpen(mode, lfo_claimPopGrd.selectedLot);	
	} else {
		lfn_claimPopGrd_popOpen(mode, $("#claimRegistry_grid").data("kendoGrid").dataItem($(selectedItem).closest("tr")));
	}
	
}


this.lfn_defectPop_open = function(){
 	var options = {
		modal:true, 
		width: "650px", //200506 JJW 기본 너비  값 750 -> 650로 변경 LYM 750
		height: "510px",  //200506 첫번째 팝업창 그리드의 클레임 정보 입력 버튼 클릭 후 불량 정보 등록 버튼 클릭 시 나오는 팝업창 height 변경 550->555_LYM 200506 JJW 550-> 510
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

this.lfn_defectPopup = function() {
	lfo_common.defectRowCount = 1;
	
	lfo_common.defectCodeList = gfn_getCode("qual_ITEMCUT");
	
	
	var rtlDefectList = new Array();
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getRtlDefectList",
		type: "POST",
		data: {claimId: $('#claimId').val()},
		success: function(data){
			$.each(data.rows, function(index, item){
				rtlDefectList.push({
					"badCode": item.badCode, 
					"badQty": item.badQty
				});
			});
			
			lfo_common.beforeDefectList = rtlDefectList;
			
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	}); 
		
	if(lfo_common.defectList != undefined) {
		rtlDefectList = lfo_common.defectList;
	}
	
	if(rtlDefectList != undefined) {
		$.each(rtlDefectList, function(index, item) {
			lfn_defectAddRow();

			$("#pop_defectInfo_Form [name = badCode"+lfo_common.defectRowCount+"]").data("kendoDropDownList").select(function(dataItem) {
				return dataItem.cdId === item.badCode;
			});
			
			$("#pop_defectInfo_Form [name = badQty"+lfo_common.defectRowCount+"]").data("kendoNumericTextBox").value(item.badQty);
			
			lfo_common.defectRowCount++;
		});
	} else {
		lfn_defectAddRow();
		
		lfo_common.defectRowCount++;
	}
	
	$('#defectAdd').click(function() {
		lfo_common.defectRowCount++;
		
		lfn_defectAddRow();
	});
	
	$('#defectRemove').click(function() {
		lfo_common.defectRowCount--;
		$.each($('#defectInfo').find('tr'), function(index, item) {
			$(item).find("input[type='checkbox']:checked").closest("tr").remove();
		});
	});
	
}

this.lfn_defectAddRow = function() {
	$('#defectInfo').append('<tr>' +
			'<td style="width:6%; text-align:center"><input type="checkbox" name="checkbox' + lfo_common.rowCount + '"/></td>' +
			'<td style="width:65%"><input type="text" class="badCode" format="selBox" name="badCode' + lfo_common.defectRowCount + '" msg="qual_ITEMCUT"/></td>' +
			'<td style="width:29%"><input type="text" class="badQty" format="numeric" name="badQty' + lfo_common.defectRowCount + '" /></td>' +
			'</tr>'); // 200506 JJW 내부 스타일 변경 각각 100%->65%, 29% 로 &체크박스 추가

	$("#pop_defectInfo_Form [name = badCode"+lfo_common.defectRowCount+"]").kendoDropDownList({
		dataSource: lfo_common.defectCodeList,
		dataValueField: "cdId",
		valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
		template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
		index:0,
		autoWidth: true
	});
	
	$("#pop_defectInfo_Form [name = badQty"+lfo_common.defectRowCount+"]").kendoNumericTextBox({
		format: "0",
		value: 0
	});
}

this.lfn_saveRtlDefectList = function() {
	lfo_common.defectList = new Array();
	
	var duplicateCheck = new Array();
	var flag = true;
	
	var defectTotalCount = 0;
	$.each($('#defectInfo').children('tr'), function(index, item){
		if(duplicateCheck.indexOf($(item).find('input.badCode').val()) !== -1){
			kendo.confirm("동일한 불량 원인을 중복하여 선택할 수 없습니다.");
			flag = false;
			return flag;
		}
		duplicateCheck.push($(item).find('input.badCode').val());
		
		lfo_common.defectList.push({
			badCode: $(item).find('input.badCode').val(),
			badQty: $(item).find('input.badQty').val()
		})
		defectTotalCount += parseInt($(item).find('input.badQty').val());
	});
	
	if(!flag) {
		return flag;
	}
	
	var beforeDefectList = lfo_common.beforeDefectList.slice();
	var selDefectList = lfo_common.defectList.slice();
	
	$.each(beforeDefectList, function(index, item) {
		var idx = selDefectList.findIndex(x => x.badCode == item.badCode)
		if(idx != -1) {
			selDefectList.splice(idx, 1);
		}
	});
	lfo_common.defectInsertList = selDefectList;
	selDefectList = lfo_common.defectList.slice();
	
	lfo_common.defectUpdateList = new Array();
	
	$.each(selDefectList, function(index, item) {
		var idx = beforeDefectList.findIndex(x => x.badCode == item.badCode)
		if(idx != -1) {
			lfo_common.defectUpdateList.push(item);
			beforeDefectList.splice(idx, 1);
		}
	});
	
	lfo_common.defectDeleteList = beforeDefectList;
	
	$("#claimQty").data("kendoNumericTextBox").value(defectTotalCount);
	gfn_closePop('pop_defectInfo'); 
}

this.lfn_claimRegistyPop = function(rows) {
	var dataItem = $("#jtePopForm_grid").data("kendoGrid").dataItem($(rows).closest("tr"));
	lfn_claimRegistryPop_Open(dataItem);
}

this.lfn_claimRegistryPop_Open = function(selectedItem){
	var options = {
		modal:true, 
		width: "1250px", 
		height: "470px", //200520 JJW 470->
		id:"claimRegistry", 
		title:gfn_getMsg("pop_claimMgt"),			//클레임 관리
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_claimRegistryPop_setGrd(selectedItem);
		$('#claimRegistry_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}

this.lfn_claimRegistryPop_setGrd = function(selectedItem){
	
	lfo_claimPopGrd = {};
	lfo_claimPopGrd.selectedLot = selectedItem;
	//1.
	lfo_claimPopGrd.layoutId = "claimRegistry_grid";
	
	//2.
	lfo_claimPopGrd.popId = "jtePopAddForm";
	
	//3.
	lfo_claimPopGrd.ctrlUrl = "/cform/orderMgt/claimMgt";
	
	//4.
	lfo_claimPopGrd.crud  = {
		read:{url:"/selectClaimInfo", auth:"", prmt:{lotId: selectedItem.lotId}}, 
		create:{url:"/setClaimInfoSave", auth:"", openFunc:lfn_claimInfo, callback: lfn_jtePopGrd_save},
		update:{url:"/setClaimInfoSave", auth:"", callback:lfn_jtePopGrd_save}
	};
	
	//5.
	lfo_claimPopGrd.model = {
		id: "claimId",
		fields: {
			"claimId" : { type: "string" },
			"claimNm" : { type: "string" },
			"claimQty" : { type: "int" },
			"claimState" : { type: "string" },
			"claimDesc" : { type: "string" },
			"lotId" : { type: "string" }
		}
	};
	
	//6.
	lfo_claimPopGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "update", title:gfn_getMsg("btn_update"), width: "120px",											//수정
			template: function(rows) {
				if(rows.claimState =="ord_cla03") {
					return '<button class="k-button k-primary" type="button" onclick = "lfn_claimInfo(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>';
				} else {
					return "";
				}
			}
		},		
		{field: "claimId", title: gfn_getMsg("col_claimCd"), width: "170px;"},										//클레임코드
		{field: "claimNm", title: gfn_getMsg("col_claimNm"), width: "150px;"},										//클레임명
		{field: "claimQty", title: gfn_getMsg("col_claimQty"), width: "170px;"},									//클레임 수량
		{field: "claimState", template:"# var item = gfn_isNull(claimState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(claimState).cdId , gfn_getCode(claimState).cdNm) # #= item #", 
				title: gfn_getMsg("col_claimStatus"), width: "120px;"},												//클레임 상태
		{field: "claimDesc", title: gfn_getMsg("col_desc"), width: "120px;"},										//설명
		{field: "lotId", title: gfn_getMsg("col_lotCd"), width: "170px;"},											//LoT코드 
		{field: "reorder", editable: function(){return ''}, title:gfn_getMsg("col_reorder"), width:"120px",			//재수주
			template : function(rows) {
				if(!gfn_isNull(rows.claimId) && rows.claimState =="ord_cla03"){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_claimReorderPop(this) " style="width:60px;"><spring:message code = "col_reorder"/></button>';			//재수주
				} else{
					return "";
				}
			}
		}
	];
	
	
	//7.
	lfo_claimPopGrd.selectBox = [
 		{ text: gfn_getMsg("col_claimNm"), value: "claim_nm" }			//클레임 명
	];
	
	
	//공통 그리드 세팅 호출
	lfo_claimPopGrd.grid = gfn_grid_set(lfo_claimPopGrd);
}

</script>