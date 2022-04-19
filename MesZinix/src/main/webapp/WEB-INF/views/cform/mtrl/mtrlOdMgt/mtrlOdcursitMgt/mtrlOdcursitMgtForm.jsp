<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="mtrlOdcursitMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrlOdcursitMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrlOdcursitMgtForm">
		<!-- 발주주문서 -->
			<div class="pop_title"><spring:message code = "col_mtrlOrderDoc"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup> <!-- 13 27 13 27 -->
				<col style="width: 24%;">
				<col style="width: 29%;">
				<col style="width: 18%;">
				<col style="width: 29%;">
			</colgroup>
				<tr>
				<!-- 발주주문코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDocCd"></spring:message> : </td>
					<td><input type="text" id="mtrlOfId" name="mtrlOfId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!--발주상태 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderStatus"></spring:message> : </td>
					<td><input id="mtrlOfState" name="mtrlOfState"  format = "selBox" msg="mtrl_sta" readonly/></td>
				</tr>
				<tr>
				<!-- 발주명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDocNm"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="mtrlOfNm" name="mtrlOfNm"/>
					</td>
				</tr>
				<tr>
				<!-- 총 자재비용 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_totalMtrlCost"></spring:message> 
				<!-- 배송비 + 자재비용 -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_DeliveryMtrlCost"></spring:message>"></i> : </td>
					<td>
						<input id="mtrlOfCost" name="mtrlOfCost" format="currency"/>
					</td>
				<!-- 발주일 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDate"></spring:message> : </td>
					<td>
						<input id="mtrlOfDate" name="mtrlOfDate" format="datepicker"/>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="mtrlOfDesc" name="mtrlOfDesc" format="text"/></td>
				</tr>
				<tr>
				<!-- 클레임 -->
					<td><i class="fas fa-caret-right"></i>클레임 : </td>
					<td colspan="3"><textarea id="mtrlOfDesc" name="mtrlOfClaim" format="text" rows="3"></textarea></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="orderForm_use"/>
						<input type="hidden" name="action" id="orderForm_action"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		<!-- 발주리스트 -->
		<div class="pop_title"><spring:message code = "pop_orderingList"></spring:message></div>
		<div id="jtePopForm_grid" class="mtrlOdcursitMgtForm" style="height: 256px; width: 98%; margin: auto; display: flex;"></div>
	</div>
</div>

<!-- 수령확인 팝업 -->
<div style="display:none;">
	<div id="jteMtrlOrdChkPop">
		<form id="jteMtrlOrdChkPop_form" class="mtrlOdcursitMgtForm">
		<!-- 수령정보 -->
			<div class="pop_title"><spring:message code = "pop_receiptInfo"></spring:message></div>
			<table style="width:100%;" id="jteMtrlOrdChkPop_master" class="BasicTable">
			<colgroup> <!-- 15 25 15 25 완료정보 조회 버튼 때문에 1행 추가-->
				<col style="width: 20%;">
				<col style="width: 28%;">
				<col style="width: 24%;">
				<col style="width: 28%;">
			</colgroup>
				<tr>
				<!-- 발주계획코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlItemCd"></spring:message> : </td>
					<td><input type="text" id="mtrlOrderId" name="mtrlOrderId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 발주상황구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_orderSitDiv"></spring:message> : </td>
					<td><input id="mtrlOrderState" name="mtrlOrderState"  format = "selBox" msg="mtrl_order" readonly/></td>
				</tr>
				<tr>
				<!-- 자재명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="mtrlNm" name="mtrlNm" readonly/>
						<!-- <input type="hidden" id="mtrlId" name="mtrlId" /> -->
						<input type="hidden" id="mtrlCost" name="mtrlCost" />
					</td>
				</tr>
				<tr>
				<!-- 업체명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="compNm" name="compNm" readonly/>
						<input type="hidden" id="compId" name="compId" />
					</td>
				<%-- <!-- 자재구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlDiv"></spring:message> : </td>
					<td colspan="2">
						<input type="text "id="mtrlDiv" class="right-input" name="mtrlDiv" format="text" readonly/>
						<input type="hidden" id="mtrlId" name="mtrlId" readonly/>
					</td> --%>
				</tr>
				<tr>
				<!-- 수량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_quantity"></spring:message> : </td>
					<td><input id="mtrlOrderQty" name="mtrlOrderQty" format="currency" onkeyup="lfn_mtrlTotlCostCalc()"/></td>
				<!-- 배송비용 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_deliveryCost"></spring:message> : </td>
					<td><input id="mtrlOrderDelivery" name="mtrlOrderDelivery" format="currency"/></td>
				</tr>
				<tr>
				<!-- 자재비용 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlCost"></spring:message>
				<!-- 자재와 수량을 입력하면 기본적으로 자동계산됩니다. -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_mtrlQtyAuto"></spring:message>"></i> :
					</td>
					<td><input id="mtrlOrderCost" name="mtrlOrderCost" format="currency"/></td>
					<td><i class="fas fa-caret-right"></i>예정일 : </td>
					<td><input id="mtrlOrderExpectex" name="mtrlOrderExpectex" format="datepicker"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="mtrlOrderDesc" name="mtrlOrderDesc" format="text"/></td>
				</tr>
			</table>
			<div class="pop_title">경유지</div>
			<div id="jteStopOver_grid" style="height: 190px; width: 98%; margin: auto;"></div>
			
			<!-- 완료정보 -->
			<div class="pop_title"><spring:message code = "pop_finishInfo"></spring:message></div>
			<table style="width:100%;" id="jteMtrlOrdChkPop_master-2" class="BasicTable">
			<colgroup> <!-- 15 25 15 25 완료정보 조회 버튼 때문에 1행 추가-->
				<col style="width: 20%;">
				<col style="width: 28%;">
				<col style="width: 24%;">
				<col style="width: 28%;">
			</colgroup>
				<tr>
				<!-- 수령자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_recipient"></spring:message> : </td>
					<td>
						<input id="mtrlOrderUserNm" class="btn-input" name="mtrlOrderUserNm" format="text" readonly/>
						<input type="hidden" name="mtrlOrderUser" id="mtrlOrderUser"/>
						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
							<spring:message code="btn_search" /><!-- 조회 -->
						</button>
					</td>
				<!-- 수령일 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate"></spring:message> : </td>
					<td>
						<input id="mtrlOrderDate" name="mtrlOrderDate" format="datepicker"/>
					</td>
				</tr>
<!-- 				<tr> -->
<!-- 					<td><i class="fas fa-caret-right"></i>검사담당자 : </td> -->
<!-- 					<td colspan="3"> -->
<!-- 						<input id="mtrlChargeUserNm" class="btn-input" name="mtrlChargeUserNm" format="text" readonly/> -->
<!-- 						<input type="hidden" name="mtrlChargeUser" id="mtrlChargeUser"/> -->
<!-- 						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_userChargePop_callback)"> -->
<%-- 							<spring:message code="btn_search" /><!-- 조회 --> --%>
<!-- 						</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="mtrlId" id="qcMtrlId"/>
						<input type="hidden" name="mtrlOfId"/>
						<input type="hidden" name="mtrlMgtId" id="chkMtrlMgtId"/>
						<input type="hidden" name="use" id="chkUse"/>
						<input type="hidden" name="action" id="chkAction"/>
					</td>
				</tr>
			</table>
		</form>
<%-- 		<!-- 불량정보 -->
		<div class="pop_title"><spring:message code = "col_badInfo"></spring:message></div>
		<div id="jteMtrlOrdChkPop_grid"></div> --%>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteMtrlOrdChkPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 수령확인 팝업 -->
<div style="display:none;">
	<div id="jteBatchPickUpPop">
		<form id="jteBatchPickUpPop_form">
			<div class="pop_title">일괄수령</div>
			<table style="width:100%;" class="BasicTable">
			<colgroup>
				<col style="width: 35%;">
				<col style="width: 65%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_recipient" text="수령자"></spring:message> : </td>
					<td>
						<input class="btn-input" name="mtrlOrderUserNm" format="text" readonly/>
						<input type="hidden" name="mtrlOrderUser"/>
						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_batchPickUpPop_callback)">
							<spring:message code="btn_search" text="조회"/>
						</button>
					</td>
				</tr>
				<tr>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate" text="수령일"></spring:message> : </td>
					<td>
						<input name="mtrlOrderDate" format="datepicker"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use"/>
						<input type="hidden" name="action"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteBatchPickUpPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 접수 정보 팝업 -->
<div style="display:none;">
	<div id="jteReceiptForm">
		<form id="jteReceiptForm_form" class="mtrlOdcursitMgtForm" >
			<table style="width:100%;" id="jteReceiptForm_master" class="BasicTable">
			<colgroup>
				<col style="width:35%;">
				<col style="width:15%;">
				<col style="width:35%;">
				<col style="width:15%;">
			</colgroup>
				<tr><td colspan="4"></td></tr>					
				<tr>
				<!-- 접수자 -->
					<td><i class="fas fa-caret-right"></i>접수자 : </td>
					<td colspan="3">
						<input id="receiptUserNm" class="btn-input" name="receiptUserNm" format="text" readonly/>
						<input type="hidden" name="receiptUser" id="receiptUser"/>
						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_receiptPop_callback)">
							<spring:message code="btn_search" /><!-- 조회 -->
						</button>
					</td>
				</tr>
				<tr>
				<!-- 업체담당자 -->
					<td><i class="fas fa-caret-right"></i>업체담당자 :  </td>
					<td colspan="3"><input type="text" id="mtrlReceipt" name="mtrlReceipt" /></td>
				</tr>
				<tr>
				<!-- 접수방식 -->
					<td><i class="fas fa-caret-right"></i>접수방식 :</td>
					<td colspan="3"><input type="text" id="receiptWay" name="receiptWay" format="selBox" msg="receipt_way" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="mtrlOfId" id="mtrlOfId"/>
						<input type="hidden" name="receiptStatus" id="receiptStatus"/>
						<input type="hidden" name="action" id="receipt_action"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area">
			<button class="k-button k-primary final-btn" type="button" onclick = "lfn_receiptSave('jteReceiptForm_form')"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteReceiptForm');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
</div>


<!-- 이윤민 주임 작업 CSS -->
<!--  <link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_lym.css' rel="stylesheet">  -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mtrl/mtrlOdMgt/mtrlOdcursitMgt/mtrlOdcursitMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200512 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

var lfo_receipt = {}; //접수 

var lfo_mtrlBadGrd = {};//발주주문서 팝업 그리드에서 사용

var lfo_batchPickUp = {};//일괄수령 팝업

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
	lfo_common.ctrlUrl = "/cform/mtrl/mtrlOdMgt/mtrlOdcursitMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getMtrlOrderFormList", auth:"", prmt:{}}, 
		//create:{url:"/setMtrlOrderSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setMtrlOrderFormSave", auth:"", openFunc: "", callback : lfn_popSave}, 
		//destroy:{url:"/setMtrlOrderFormSave", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "mtrlOfId",
		fields: {
			mtrlOfId : { type: "string" },
			mtrlOfNm : { type: "string" },
			mtrlOfDate : { type: "date" },
			mtrlOfCost : { type: "int" },
			mtrlOfState : { type: "string" },
			mtrlOfDesc : { type: "string" },
			createdAt : { type: "date" },
			updatedAt : { type: "date" },
			creatorId : { type: "string" },
			creatorNm : { type: "string" },
			updatorId : { type: "string" },
			mtrlClaim : { type: "string" },
			mtrlReceipt : { type: "string" },
			receiptWay : { type: "string" },
			receiptStatus : { type: "string" },
			receiptUser : { type: "string" },
			receiptUserNm : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlOfId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlCurPop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update"), width: "70px"},																	//수정
		{field: "mtrlOfId", title:gfn_getMsg("col_mtrlOrderDocCd"), width: "170px"},										//발주주문코드
		{field: "mtrlOfState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOfState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOfState).cdId , gfn_getCode(mtrlOfState).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlOrderStatus"), width: "110px;"},														//발주상태
		{field: "mtrlOfNm", title:gfn_getMsg("col_mtrlOrderDocNm"), width: "180px"},										//발주명
		{field: "mtrlOfCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost"), width: "100px"},								//비용
		{field: "creatorNm", title:gfn_getMsg("col_registUser"), width: "130px"},											//등록자
		{field: "mtrlOfDate", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtrlOrderDate"), width: "120px"},			//발주일
		{field: "mtrlOfDesc", title:gfn_getMsg("col_desc"), width: "250px"},
		//{field: "receiptStatus", title:"주문 정보" , width: "250px"}
		{field: "receiptStatus",editable: function(){return false;}, title:"접수 정보" , width: "250px",
			template : function(rows) {
					if(rows.receiptStatus == "mtrl_not_receipt"){
						return '<span style = "color:red; font-weight: bold; margin-right: 10px;">미접수</span>&nbsp;&nbsp;<button class="k-button k-primary" type="button" onclick = "lfn_jteReceiptForm_open(\'EDT\',this);" style="min-width:60px;">접수정보</button>';			
					}else if (rows.receiptStatus == "mtrl_receipt_complete"){
						return '<span style = "color:blue; font-weight: bold;">접수완료</span>&nbsp;<button class="k-button k-primary" type="button" onclick = "lfn_jteReceiptForm_open(\'EDT\',this);" style="min-width:60px;">접수정보</button>';
					}else{
						return "";
					}
				}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_mtrlOrderDocNm"), value: "mtrlOrderForm.mtrl_of_nm" },			//발주명
		{ text: gfn_getMsg("col_mtrlOrderDocCd"), value: "mtrlOrderForm.mtrl_of_id" },			//발주주문코드
		{ text: gfn_getMsg("col_desc"), value: "mtrlOrderForm.mtrl_of_desc" }					//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_mtrlCurPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px", // 200512 JJW 그리드 더블클릭 팝업 (발주주문서) 너비 700px
		height: "712px", /* 201223 JJW POP 고려 X 그리드 크기에 맞춰 팝업 높이 수정 712px  */
		id : lfo_common.popId, 
		title: gfn_getMsg("pop_mtrlOrderSrh"),			// 발주주문 수정
		resizable:true,
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
	lfo_common.gridSelected = {};
	if(mode=='NEW'){
		selectedItem = {
				mtrlOfId : lfo_common.gridSelected.mtrlOfId
			}
		gfn_popform_set(lfo_common, mode, selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {mtrlOfId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {mtrlOfId :lfo_common.gridSelected.mtrlOfId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	//그리드 세팅
	if($("#jtePopForm_grid").html() ==""){
		lfn_jtePopGrd_setGrd();
	}else{
		lfo_popGrd.grid.dataSource.read();
	}
}
//발주계획 저장
this.lfn_popSave = function(mode){
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
				//gfn_closePop(lfo_common.popId);
				//팝업 리로드
				lfn_jtePop_set('EDT',data);
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				
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

//더블클릭 콜백(접수정보 팝업)
this.lfn_jteReceiptForm_open = function(mode, selectedItem){
	lfo_receipt = {};//Form 내부에서 사용될 Object 
	
	//2.
	lfo_receipt.popId = "jteReceiptForm";
	
	//3.
	lfo_receipt.ctrlUrl = "/cform/mtrl/mtrlOdMgt/mtrlOdcursitMgt"
	
	//4.
	lfo_receipt.crud  = {
		read:{url:"/getMtrlOrderFormList", auth:"", prmt:{}}, 
		//create:{url:"/setMtrlOrderSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setMtrlOrderFormSave", auth:"", openFunc: "", callback : lfn_popSave}, 
		//destroy:{url:"/setMtrlOrderFormSave", auth:"", callback:lfn_jteGrid_delete}
	};
	
	var options = {
		modal:true, 
		width: "380px", // 200512 JJW 그리드 더블클릭 팝업 (발주주문서) 너비 700px
		height: "300px", /* 201220 JJW */
		id : lfo_receipt.popId, 
		title: "접수 정보" ,			// 발주주문 수정
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jteReceiptForm_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//접수정보 팝업내용 세팅
this.lfn_jteReceiptForm_set = function(mode,selectedItem){
	lfo_common.gridSelected = {};
	if(mode == 'EDT'){
		var savePrmt = {};

		
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {mtrlOfId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_receipt.ctrlUrl + lfo_receipt.crud.read.url,
			type: "POST",
			data: {mtrlOfId :lfo_common.gridSelected.mtrlOfId},
			success: function(data){
				gfn_popform_set(lfo_receipt, mode, data.rows[0]);
				
				if(gfn_isNull(data.rows[0].receiptUser)){
					$("#" + lfo_receipt.popId + "_form [name=receiptUserNm]").val($("#_loginUserName").val());
					$("#" + lfo_receipt.popId + "_form [name=receiptUser]").val($("#_loginUserId").val()); 
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}
//접수정보 저장
this.lfn_receiptSave = function(mode){
	//입력폼 serialize 
	var savePrmt = $("#"+lfo_receipt.popId+"_form").serializeObject();
	savePrmt.receiptStatus = "mtrl_receipt_complete";
	$.ajax({
		async:false,
		url : lfo_receipt.ctrlUrl + "/setMtrlOrderFormSave",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				
				gfn_closePop('jteReceiptForm');
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

//팝업내부 그리드 -  발주목록
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
	lfo_popGrd.popId = "jteMtrlOrdChkPop";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/mtrl/mtrlOdMgt/mtrlOdplanMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlOrderList", auth:"", search:false, prmt:{mtrlOfId:lfo_common.gridSelected.mtrlOfId}}, 
		create:{url:"/setMtrlOrderSave", auth:"", openFunc:"", callback : lfn_mtrlOrderCheckPop_save}, 
		update:{url:"/setMtrlOrderSave", auth:"", openFunc:"", callback : lfn_mtrlOrderCheckPop_save}, 
		excel:{url:"" ,auth:"", fileName: "발주이력_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
		//destroy:{url:"/setMtrlOrderDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	lfo_popGrd.customTitle = {
			html:'<button class="k-button k-primary" type="button" onclick = "lfn_BatchPickUp_open()" style="width:60px;">일괄수령</button>'
	}
	
	//5.
	lfo_popGrd.model = {
		id: "mtrlOrderId",
		fields: {
			mtrlOrderId : { type: "string" },
			mtrlOrderQty : { type: "int" },
			mtrlOrderUser : { type: "string" },
			mtrlOrderUserNm : { type: "string" },
			mtrlOrderDate : { type: "date" },
			mtrlOrderCost : { type: "int" },
			mtrlOrderExpectex : { type: "string" },
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
			mtrlDiv : { tpye: "string" },
			mtrlCost : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			mtrlOfId : { type: "string" },
			mtrlChargeUser : { type: "string" },
			mtrlChargeUserNm : { type: "string" },
			mtrlQualSta : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlOrderState", editable: function(){return false;}, title:gfn_getMsg("col_receipt"), width:"95px",			//수령
			template : function(rows) {
				if(rows.mtrlOrderState == "mtrl_order_prs"){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_mtrlOrderCheckPop_open(this,\'NEW\') " style="width:60px;">'+gfn_getMsg("pop_receiptConfirm")+'</button>';			//수령확인
				}else if (rows.mtrlOrderState == "mtrl_order_end"){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_mtrlOrderCheckPop_open(this,\'EDT\') " style="width:60px;">'+gfn_getMsg("pop_viewHis")+'</button>';					//내역보기
				}else{
					return "";
				}
			}
		},
// 		{field: "mtrlQualSta", template:"# var item = gfn_isNull(gfn_getCode(mtrlQualSta))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlQualSta).cdId , gfn_getCode(mtrlQualSta).cdNm) # #= item #",
// 			title:"검사현황", width: "110px"},
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},													//자재명
		{field: "mtrlOrderQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity"), width: "90px"},							//수량
		{field: "mtrlOrderExpectex", format: "{0: yyyy-MM-dd}", title:"예정일", width: "110px"},			//예정일
		{field: "mtrlOrderDate", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "110px"},			//수령일
		{field: "compNm",  title:gfn_getMsg("col_compNm"), width: "160px"},													//업체명
		{field: "mtrlOrderUserNm", title:gfn_getMsg("col_recipient"), width: "130px"},										//수령자
		{field: "mtrlOrderId", title:gfn_getMsg("col_mtrlItemCd"), width: "180px"},											//발주계획코드
		{field: "mtrlOrderState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOrderState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOrderState).cdId , gfn_getCode(mtrlOrderState).cdNm) # #= item #", 
			title:gfn_getMsg("col_orderSitDiv"), width: "140px;"},															//발주상황 구분
		{field: "mtrlId", title:"자재코드", width: 100},
		{field: "mtrlOrderCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost"), width: "90px"},							//금액
		{field: "mtrlOrderDelivery", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_deliveryCost"), width: "120px"},				//배송비용
		//{field: "creatorId", title:"등록자 코드", width: 100},
		{field: "creatorNm", title:gfn_getMsg("col_registUser"), width: "130px"},											//등록자
		{field: "createdAt", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate"), width: "110px"},				//등록일
		{field: "mtrlOrderDesc", title:gfn_getMsg("col_desc"), width: "150px"}												//설명
	];
	
	//7.
	lfo_popGrd.selectBox = [
		//{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },					//자재구분
		{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },						//자재명
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },						//업체명
		{ text: gfn_getMsg("col_mtrlItemCd"), value: "mtrlOrder.mtrl_order_id" }			//발주계획코드
	];
	//8.
// 	lfo_popGrd.validation ={
// 		mtrlChargeUserNm :{
// 			messages : "alert",
// 			rules : function(input){
// 				if(input.is("[name=mtrlChargeUserNm]")){
// 					if(input.val().length == 0){
// 						gfn_msgBox({msg : "조회버튼을 눌러 검사담당자를 등록하세요"}); 
// 						return false;
// 					}
// 				}
// 				return true;
// 			}
// 		}
// 	}
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

//수령확인 버튼 클릭(팝업 오픈)
this.lfn_mtrlOrderCheckPop_open = function(target, mode){
	var options = {
		modal:true, 
		width: "650px", /* 20.12.18 JJW 650 */
		height: "720px", /* 20.12.18 JJW 565 -> 605 ---POP일시 고쳐야함   */
		id : lfo_popGrd.popId, 
		title : gfn_getMsg("pop_receiptConfirm"),			//수령확인
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_popGrd.grid.dataItem($(target).closest("tr"));

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_mtrlOrderCheckPop_set(mode, dataItem)};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_mtrlOrderCheckPop_set = function(mode, dataItem){
	lfo_popGrd.gridSelected = {};
	
	if(typeof(dataItem) == "object"){
		lfo_popGrd.gridSelected = dataItem;
	}else if(typeof(dataItem) == "string"){
		lfo_popGrd.gridSelected = dataItem;
	}
	
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.read.url,
		type: "POST",
		data: {
			mtrlOrderId :lfo_popGrd.gridSelected.mtrlOrderId,
			mtrlOfId :lfo_popGrd.gridSelected.mtrlOfId
			},
		success: function(data){
			gfn_popform_set(lfo_popGrd, mode,data.rows[0]);
			lfn_jtePopCompGrd_setGrd(data.rows[0].orderCompList);
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	if(mode=='NEW'){
		//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
		$("#" + lfo_popGrd.popId + " [name=mtrlOrderDate]").data("kendoDatePicker").value(new Date());
		$("#" + lfo_popGrd.popId + " [name=mtrlOrderUserNm]").val($("#_loginUserName").val())
		$("#" + lfo_popGrd.popId + " [name=mtrlOrderUser]").val($("#_loginUserId").val())
		
		//저장시 action을 수령완료로 변경
		$("#" + lfo_popGrd.popId + " [name=action]").val("END");
		
		//불량코드 조회문제로 빈값 넣어주기(빈값은 if test문에 걸려서 제외 > false로 대체)
		lfo_popGrd.gridSelected= {
				mtrlOrderId : false
		}
	}else if(mode == 'EDT'){
		//저장시 action을 수령변경 으로 변경
		$("#" + lfo_popGrd.popId + " [name=action]").val("ENDUP");
	}
	
	//그리드 세팅
// 	if($("#jteMtrlOrdChkPop_grid").html() ==""){
// 		lfn_mtrlBadGrd_setGrd();
// 	}else{
// 		lfo_popGrd.grid.dataSource.read();
// 	}
	
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
this.lfn_mtrlOrderCheckPop_save = function(mode){
	
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		savePrmt.mtrlId = $("#qcMtrlId").val();
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
					
					//발주목록 그리드 리로드
					lfo_popGrd.grid.dataSource.read();
					
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

this.lfn_jtePopCompGrd_setGrd = function(childItems){
	lfo_compGrd = {};
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
	lfo_compGrd.layoutId = "jteStopOver_grid";
	
	//2.
	//lfo_popGrd.popId = "";
	
	//3.
	lfo_compGrd.ctrlUrl = "/cform/basMgt/operMgt/itemMgt"
	
	//4.
	lfo_compGrd.crud  = {
		read:{url:"", auth:"", prmt:{}} 
	};
	
	//5.
	lfo_compGrd.model = {
		id: "compId",
		fields: {
			compId: { type: "string" },
			compNm: { type: "string" },
			compNumber: { type: "string" },
			description: { type: "string" },
			compOrder: { type: "string" }
		}
	};
	
	//6.
	lfo_compGrd.columns = [
		{field: "compOrder", title: "순서", width: "80px"},
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "180px"},				//업체명
		{field: "compNumber", title: "전화번호", width: "180px"},				//업체명
		{field: "description", title:gfn_getMsg("col_desc"), width: "250px"},			//비고
		{field: "compId", title:gfn_getMsg("col_compCd"), width: "140px"},				//업체코드
	];
	
/* 	//7.
	lfo_compGrd.selectBox = [
		{ text: gfn_getMsg("col_compNm"), value: "comp.comp_nm" },					//업체명
		{ text: gfn_getMsg("col_compCd"), value: "comp.comp_id" },					//업체코드
		{ text: gfn_getMsg("col_desc"), value: "comp.description" }					//비고
	]; */
	
	//order에 포함된 LOT 정보 담아주기(order-child)
	lfo_compGrd.childItems = childItems;
	
	//Object형 그리드 세팅 호출(order-child)
	lfo_compGrd.grid = gfn_objectDatagrid_set(lfo_compGrd);
}

//일괄수령 버튼 클릭
this.lfn_BatchPickUp_open = function(){

	lfo_batchPickUp = {
		popId : "jteBatchPickUpPop",
		ctrlUrl : "/cform/mtrl/mtrlOdMgt/mtrlOdplanMgt",
		crud : {
			create:{url : "/setMtrlOrderBatchSave", callback : lfn_BatchPickUp_save},
			update:{url : "/setMtrlOrderBatchSave", callback : lfn_BatchPickUp_save}
		}
	};
	
	
	if($("#" + lfo_popGrd.layoutId + " .k-checkbox:checked").length > 0){
		var options = {
				modal:true, 
				width: "350px",
				height: "250px",
				id : lfo_batchPickUp.popId, 
				title : "일괄수령",
				resizable:true,
				animation:{open :{effects:"expand:vertical fadeIn"},
				close :{effects:"expand:vertical fadeIn", reverse: true}},
				actions:[/*"Minimize", "Maximize", */"Close"]
			};
			

			//팝업이 생성된 뒤 동작해야할 함수 입력
			options.callback = function(){
				
				gfn_popform_set(lfo_batchPickUp, "NEW");
			
				//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
				$("#" + lfo_batchPickUp.popId + " [name=mtrlOrderDate]").data("kendoDatePicker").value(new Date());
				$("#" + lfo_batchPickUp.popId + " [name=mtrlOrderUserNm]").val($("#_loginUserName").val())
				$("#" + lfo_batchPickUp.popId + " [name=mtrlOrderUser]").val($("#_loginUserId").val())
				
			};
			this.gfn_winOpen(options);
	}else{
		gfn_warnBox({msg : "선택된 목록이 없습니다."});
	}
}

//발주계획 저장
this.lfn_BatchPickUp_save = function(mode){
	//입력폼 serialize 
	var savePrmt = $("#"+lfo_batchPickUp.popId+"_form").serializeObject();
	
	var batchArray = [];
	//체크항목 반복문
	$("#" + lfo_popGrd.layoutId + " .k-checkbox").each(function(index, item){
		if($(this).attr("aria-checked") == "true"){
			
			var bulkPrmt = lfo_popGrd.grid.dataItem($(this).closest('tr'));
			
			bulkPrmt.mtrlOrderUser = savePrmt.mtrlOrderUser;
			bulkPrmt.mtrlOrderDate = savePrmt.mtrlOrderDate;
			
			//이미 발주 완료된 항목은 update 예외처리
			if(bulkPrmt.mtrlOrderState == "mtrl_order_end"){
				bulkPrmt.action = "ENDUP";
			}else if(bulkPrmt.mtrlOrderState == "mtrl_order_prs"){
				bulkPrmt.action = "END";
			}
			//예정일 date 타입인경우 에러 예외처리
			if(typeof(batchArray.mtrlOrderExpectex) == 'object'){
				batchArray.mtrlOrderExpectex = gfn_getDate(batchArray.mtrlOrderExpectex,"yyyy-MM-dd")	
			}
			batchArray.push(bulkPrmt);
		}
	});
	
	//일괄저장 
	$.ajax({
		async:false,
		url : lfo_batchPickUp.ctrlUrl + lfo_batchPickUp.crud[mode].url,
		type: "POST",
		data: JSON.stringify(batchArray),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				
				lfn_jtePop_set("EDT",data);
				
				gfn_closePop(lfo_batchPickUp.popId);
				
				lfo_popGrd.grid.dataSource.read();
				
				lfo_common.grid.dataSource.read();
				
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

//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

//pop - 수령확인 완료정보 유저 팝업 콜백
this.lfn_userInfoPop_callback = function(rtnObj){
	$("#" + lfo_popGrd.popId + " [name=mtrlOrderUser]").val(rtnObj["userId"]);
	$("#" + lfo_popGrd.popId + " [name=mtrlOrderUserNm]").val(rtnObj["userNm"]);
}
//pop - 일괄수령 팝업 유저정보 콜백
this.lfn_batchPickUpPop_callback = function(rtnObj){
	$("#" + lfo_batchPickUp.popId + " [name=mtrlOrderUser]").val(rtnObj["userId"]);
	$("#" + lfo_batchPickUp.popId + " [name=mtrlOrderUserNm]").val(rtnObj["userNm"]);
}

this.lfn_userChargePop_callback = function(rtnObj){
	$("#" + lfo_popGrd.popId + " [name=mtrlChargeUser]").val(rtnObj["userId"]);
	$("#" + lfo_popGrd.popId + " [name=mtrlChargeUserNm]").val(rtnObj["userNm"]);
}
//pop - 접수처 팝업 유저정보 콜백
this.lfn_receiptPop_callback = function(rtnObj){
	$("#" + lfo_receipt.popId + " [name=receiptUser]").val(rtnObj["userId"]);
	$("#" + lfo_receipt.popId + " [name=receiptUserNm]").val(rtnObj["userNm"]);
}
</script>