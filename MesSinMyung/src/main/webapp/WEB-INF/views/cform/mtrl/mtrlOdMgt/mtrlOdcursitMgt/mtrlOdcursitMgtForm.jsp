<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" style="width:100%;">
	<div id="jteSingleGrid"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrlOdcursitMgtForm">
		<!-- 발주주문서 -->
			<div class="pop_title"><spring:message code = "col_mtrlOrderDoc"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master">
			<colgroup> <!-- 13 27 13 27 -->
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr>
				<!-- 발주주문코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderDocCd"></spring:message> : </td>
					<td><input type="text" id="mtrlOfId" class="left-input" name="mtrlOfId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!--발주상태 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlOrderStatus"></spring:message> : </td>
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
				<!-- 배송비 + 자재비용 -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_DeliveryMtrlCost"></spring:message>"></i> : </td>
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
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		<!-- 발주리스트 -->
		<div class="pop_title"><spring:message code = "pop_orderingList"></spring:message></div>
		<div id="jtePopForm_grid"></div>
	</div>
</div>

<!-- 수령확인 팝업 -->
<div style="display:none;">
	<div id="jteMtrlOrdChkPop">
		<form id="jteMtrlOrdChkPop_form" class="mtrlOdcursitMgtForm">
		<!-- 수령정보 -->
			<div class="pop_title"><spring:message code = "pop_receiptInfo"></spring:message></div>
			<table style="width:100%;" id="jteMtrlOrdChkPop_master">
			<colgroup> <!-- 15 25 15 25 완료정보 조회 버튼 때문에 1행 추가-->
				<col class="popsc-col-left-title">
				<col class="popsc-col-left-content-1">
				<col class="popsc-col-left-content-2">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr>
				<!-- 발주계획코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlItemCd"></spring:message> : </td>
					<td colspan="2"><input type="text" id="mtrlOrderId" class="left-input" name="mtrlOrderId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 발주상황구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_orderSitDiv"></spring:message> : </td>
					<td><input id="mtrlOrderState" class="right-input" name="mtrlOrderState"  format = "selBox" msg="mtrl_order" readonly/></td>
				</tr>
				<tr>
				<!-- 자재명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm"></spring:message> : </td>
					<td colspan="2">
						<input type="text" id="mtrlNm" class="left-input" name="mtrlNm" readonly/>
						<!-- <input type="hidden" id="mtrlId" name="mtrlId" /> -->
						<input type="hidden" id="mtrlCost" name="mtrlCost" />
					</td>
				<!-- 자재구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlDiv"></spring:message> : </td>
					<td colspan="2">
						<input type="text "id="mtrlDiv" class="right-input" name="mtrlDiv" format="text" readonly/>
						<input type="hidden" id="mtrlId" name="mtrlId" readonly/>
					</td>
				</tr>
				<tr>
				<!-- 수량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_quantity"></spring:message> : </td>
					<td colspan="2"><input id="mtrlOrderQty" class="left-input" name="mtrlOrderQty" format="currency" onkeyup="lfn_mtrlTotlCostCalc()"/></td>
				<!-- 업체명 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_compNm"></spring:message> : </td>
					<td>
						<input type="text" id="compNm" class="right-input" name="compNm" readonly/>
						<input type="hidden" id="compId" name="compId" />
					</td>
				</tr>
				<tr>
				<!-- 자재비용 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlCost"></spring:message>
				<!-- 자재와 수량을 입력하면 기본적으로 자동계산됩니다. -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_mtrlQtyAuto"></spring:message>"></i> :
					</td>
					<td colspan="2"><input id="mtrlOrderCost" class="center-input" name="mtrlOrderCost" format="currency"/></td>
				<!-- 배송비용 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_deliveryCost"></spring:message> : </td>
					<td colspan="2"><input id="mtrlOrderDelivery" class="right-input" name="mtrlOrderDelivery" format="currency"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="4"><input type="text" id="mtrlOrderDesc" class="center-input" name="mtrlOrderDesc" format="text"/></td>
				</tr>
			</table>
			<!-- 완료정보 -->
			<div class="pop_title"><spring:message code = "pop_finishInfo"></spring:message></div>
			<table style="width:100%;" id="jteMtrlOrdChkPop_master-2">
			<colgroup> <!-- 15 25 15 25 완료정보 조회 버튼 때문에 1행 추가-->
				<col class="popsc-col-left-title">
				<col class="popsc-col-left-content-1">
				<col class="popsc-col-left-content-2">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr>
				<!-- 수령자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_recipient"></spring:message> : </td>
					<td>
						<input id="mtrlOrderUserNm" class="left-input btn-input" name="mtrlOrderUserNm" format="text"/>
						<input type="hidden" name="mtrlOrderUser" id="mtrlOrderUser"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
				<!-- 조회 -->
						<spring:message code="btn_search" /></button>
					</td>
				<!-- 수령일 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate"></spring:message> : </td>
					<td>
						<input id="mtrlOrderDate" class="right-input" name="mtrlOrderDate" format="datepicker"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="mtrlMgtId" id="chkMtrlMgtId"/>
						<input type="hidden" name="use" id="chkUse"/>
						<input type="hidden" name="action" id="chkAction"/>
					</td>
				</tr>
			</table>
		</form>
		<!-- 불량정보 -->
		<div class="pop_title"><spring:message code = "col_badInfo"></spring:message></div>
		<div id="jteMtrlOrdChkPop_grid"></div>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteMtrlOrdChkPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 불량품 관리 팝업 -->
<div style="display:none;">
	<div id="jteMtrlBadChkPop">
		<form id="jteMtrlBadChkPop_form" class="mtrlOdcursitMgtForm">
		<!-- 불량품 정보 -->
			<div class="pop_title"><spring:message code = "pop_badItemInfo"></spring:message></div>
			<table style="width:100%;" id="jteMtrlBadChkPop_master">
			<colgroup> <!-- 15 25 15 25 조회 버튼으로 1행 추가 -->
				<col class="poptr-col-left-title">
				<col class="poptr-col-left-content-1">
				<col class="poptr-col-left-content-2">
				<col class="poptr-col-right-title">
				<col class="poptr-col-right-content">
			</colgroup>
				<tr>
				<!-- 불량아이디 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_badId"></spring:message> : </td>
					<td colspan="4"><input type="text" id="badId" class="center-input" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : </td>
					<td colspan="2"><input id="badCode" class="left-input" name="badCode"  format = "selBox" msg="qual_MTRLCUT"/></td> <!-- style="width: 95%; max-width:95%;" -->
				<!-- 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_quantity"></spring:message> : </td>
					<td><input id="badQty" class="right-input" name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input id="chkUserNm"class="left-input btn-input"  name="chkUserNm" format="text" readonly/>
						<input type="hidden" name="chkUser" id="chkUser"/>
					</td>
					<td><!-- 조회 -->
 						<button class="k-button k-primary search-btn" type="button" onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)">
 						<spring:message code="btn_search" /></button>
					</td>
				<!-- 검사일 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_inspectDate"></spring:message> : </td>
					<td><input id="chkDate" class="right-input" name="chkDate" format="datepicker"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="4"><input id="badDesc" class="center-input" name="badDesc"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="badTarget" id="badTarget"/>
						<input type="hidden" name="badTargetCode" id="badTargetCode"/>
						<input type="hidden" name="mtrlId" id="bad_mtrlId"/>
						<input type="hidden" name="mtrlMgtId" id="bad_mtrlMgtId"/>
						<input type="hidden" name="use" id="bad_use"/>
						<input type="hidden" name="action" id="bad_action"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteMtrlBadChkPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
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

var lfo_mtrlBadGrd = {};//발주주문서 팝업 그리드에서 사용

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
		update:{url:"/setMtrlOrderFormSave", auth:"", openFunc:lfn_jtePop_open, callback : lfn_popSave}, 
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
			updatorId : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlOfId", title:gfn_getMsg("col_mtrlOrderDocCd"), width: "170px"},										//발주주문코드
		{field: "mtrlOfState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOfState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOfState).cdId , gfn_getCode(mtrlOfState).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlOrderStatus"), width: "110px;"},														//발주상태
		{field: "mtrlOfNm", title:gfn_getMsg("col_mtrlOrderDocNm"), width: "180px"},										//발주명
		{field: "mtrlOfCost", format: "{0:n0}", title:gfn_getMsg("col_cost"), width: "100px"},								//비용
		{field: "creatorNm", title:gfn_getMsg("col_registUser"), width: "130px"},											//등록자
		{field: "mtrlOfDate", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtrlOrderDate"), width: "120px"},			//발주일
		{field: "mtrlOfDesc", title:gfn_getMsg("col_desc"), width: "250px"}													//설명
		
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
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px", // 200512 JJW 그리드 더블클릭 팝업 (발주주문서) 너비 700px
		height: "590px", // 200512 JJW 그리드 더블클릭 팝업 (발주주문서) 높이 500px -> 590px;
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
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected.mtrlOfId = selectedItem["mtrlOfId"];
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.mtrlOfId = selectedItem;
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
		read:{url:"/getMtrlOrderList", auth:"", prmt:{mtrlOfId:lfo_common.gridSelected.mtrlOfId}}, 
		create:{url:"/setMtrlOrderSave", auth:"", openFunc:"", callback : lfn_mtrlOrderCheckPop_save}, 
		update:{url:"/setMtrlOrderSave", auth:"", openFunc:"", callback : lfn_mtrlOrderCheckPop_save}, 
		excel:{url:"" ,auth:"", fileName: "발주이력_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
		//destroy:{url:"/setMtrlOrderDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
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
			mtrlOfId : { type: "string" }
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
		{field: "mtrlOrderId", title:gfn_getMsg("col_mtrlItemCd"), width: "180px"},											//발주계획코드
		{field: "mtrlOrderState", template:"# var item = gfn_isNull(gfn_getCode(mtrlOrderState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlOrderState).cdId , gfn_getCode(mtrlOrderState).cdNm) # #= item #", 
			title:gfn_getMsg("col_orderSitDiv"), width: "140px;"},															//발주상황 구분
		//{field: "mtrlId", title:"자재코드", width: 100},
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},												//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},													//자재명
		{field: "mtrlOrderQty", format: "{0:n0}", title:gfn_getMsg("col_quantity"), width: "90px"},							//수량
		{field: "mtrlOrderCost", format: "{0:n0}", title:gfn_getMsg("col_cost"), width: "90px"},							//금액
		{field: "mtrlOrderDelivery", format: "{0:n0}", title:gfn_getMsg("col_deliveryCost"), width: "120px"},				//배송비용
		//{field: "compId",  title:"업체코드", width: 100},
		{field: "compNm",  title:gfn_getMsg("col_compNm"), width: "160px"},													//업체명
		//{field: "mtrlOrderUser", title:"수령자 아이디", width: 100},
		{field: "mtrlOrderUserNm", title:gfn_getMsg("col_recipient"), width: "130px"},										//수령자
		{field: "mtrlOrderDate", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "110px"},			//수령일
		//{field: "creatorId", title:"등록자 코드", width: 100},
		{field: "creatorNm", title:gfn_getMsg("col_registUser"), width: "130px"},											//등록자
		{field: "createdAt", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate"), width: "110px"},				//등록일
		{field: "mtrlOrderDesc", title:gfn_getMsg("col_desc"), width: "150px"}												//설명
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },					//자재구분
		{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },						//자재명
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },						//업체명
		{ text: gfn_getMsg("col_mtrlItemCd"), value: "mtrlOrder.mtrl_order_id" }			//발주계획코드
	];
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

//Form내용 입력/저장
//수령확인 버튼 클릭(팝업 오픈)
this.lfn_mtrlOrderCheckPop_open = function(target, mode){
	var options = {
		modal:true, 
		width: "650px", // 200512 JJW 수령확인 팝업 너비 600px -> 650px
		height: "600px", // 200512 JJW 수령확인 팝업 높이 400px -> 700px,(POP용이면 다시 600으로 고쳐야함) 600px
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
	if(mode=='NEW'){
		gfn_popform_set(lfo_popGrd, mode,dataItem);
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
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		//저장시 action을 수령변경 으로 변경
		$("#" + lfo_popGrd.popId + " [name=action]").val("ENDUP");
			
	}
	//그리드 세팅
	if($("#jteMtrlOrdChkPop_grid").html() ==""){
		lfn_mtrlBadGrd_setGrd();
	}else{
		lfo_popGrd.grid.dataSource.read();
	}
	
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

this.lfn_mtrlOrderCheckPop_save = function(mode){
	//입력폼 serialize 
	var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
	
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


//입고 자재불량 그리드 
this.lfn_mtrlBadGrd_setGrd = function(){
	lfo_mtrlBadGrd = {};
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
	lfo_mtrlBadGrd.layoutId = "jteMtrlOrdChkPop_grid";
	//여기까지
	
	//2.
	lfo_mtrlBadGrd.popId = "jteMtrlBadChkPop";
	
	//3.
	lfo_mtrlBadGrd.ctrlUrl = "/cform/qualMgt/infergodsMgt"
	
	//4.
	lfo_mtrlBadGrd.crud  = {
		read:{url:"/getMtrlBadList", auth:"", prmt:{badTargetCode : lfo_popGrd.gridSelected.mtrlOrderId}}, 
		create:{url:"/setMtrlBadSave", auth:"", openFunc : lfn_mtrlBadGrd_open, callback : lfn_mtrlBadGrd_save}, 
		update:{url:"/setMtrlBadSave", auth:"", openFunc : lfn_mtrlBadGrd_open, callback : lfn_mtrlBadGrd_save}, 
		destroy:{url:"/setMtrlBadDelete", auth:"", callback : lfn_mtrlBadGrd_delete}
	};
	
	//5.
	lfo_mtrlBadGrd.model = {
		id: "badId",
		fields: {
			badId : { type: "string" },	
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkUserNm : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badTargetNm : { type: "string" },
			badDesc : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlMgtId : { type: "string" },
			badPgUser : { type: "string" },
			badPgUserNm : { type: "string" },
			badPgDate : { type: "date" },
			badPgCd : { type: "string" },
			badPgNm : { type: "string" },
			mtrlDiv : { type: "string" }
		}
	};
	
	//6.
	lfo_mtrlBadGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "130px;"},														//불량원인
		{field: "badId", title : gfn_getMsg("col_badId"), width: "180px"},												//불량아이디
		{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},											//자재구분
		{field: "mtrlNm", title : gfn_getMsg("col_mtrlNm"), width: "140px"},											//자재명
		{field: "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd"), width: "180px"},									//자재개별코드
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badInfo"), width: "200px;"},														//불량정보
		{field: "badTargetCode", title : gfn_getMsg("col_badCd"), width: "180px"},										//불량코드
		{field: "badPgUserNm", title : gfn_getMsg("col_worker"), width: "130px"},										//작업자
		{field: "badPgDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_workDate"), width: "130px"},			//작업일
		{field: "badQty",format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "90px"},						//불량량
		{field: "chkUserNm", format: "{0:n0}", title : gfn_getMsg("col_inspector"), width: "130px"},					//검사자
		{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate"), width: "130px"},			//검사일
		{field: "badPgNm", title : gfn_getMsg("col_progNm"), width: "180px"},											//프로그램명
		{field: "badPgCd", title : gfn_getMsg("col_progCd"), width: "180px"}											//프로그램코드
	];
	
	//7.
	lfo_mtrlBadGrd.selectBox = [
		{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlDiv" },				//자재구분
		{ text: gfn_getMsg("col_worker"), value: "badPgUserNm" },			//작업자
		{ text: gfn_getMsg("col_badId"), value: "badId" },					//불량아이디
	];
	//8.
	lfo_mtrlBadGrd.validation ={
			badQty:{
			messages : "불량량을 입력하세요",
			rules : function(input){
				if(input.is("[name=badQty]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		chkDate:{
			messages : "검사일을 등록하세요",
			rules : function(input){
				if(input.is("[name=chkDate]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		chkUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=chkUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 검사자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_mtrlBadGrd.grid = gfn_grid_set(lfo_mtrlBadGrd);
}


//더블클릭 콜백(팝업)
this.lfn_mtrlBadGrd_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "600px", // 200512 JJW 불량품 관리 팝업 너비 500px -> 600px
		height: "330px", // 200512 JJW 불량품 관리 팝업 높이 250px -> 330px
		id : lfo_mtrlBadGrd.popId, 
		title: gfn_getMsg("pop_badItemMgt"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_mtrlBadGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_mtrlBadGrd_popSet = function(mode,selectedItem){
	lfo_mtrlBadGrd.gridSelected = {};
	if(mode=='NEW'){
		//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
		selectedItem = {
				mtrlId : $("#" + lfo_popGrd.popId + " [name=mtrlId]").val(),
				mtrlMgtId : $("#" + lfo_popGrd.popId + " [name=mtrlMgtId]").val(),
				badTarget : "qual_spec01",
				badTargetCode : $("#" + lfo_popGrd.popId + " [name=mtrlOrderId]").val(), 
				chkDate : new Date(),
				chkUserNm : $("#_loginUserName").val(),
				chkUser : $("#_loginUserId").val()
		}
		gfn_popform_set(lfo_mtrlBadGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_mtrlBadGrd.gridSelected.badId = selectedItem["badId"];
		}else if(typeof(selectedItem) == "string"){
			lfo_mtrlBadGrd.gridSelected.badId = selectedItem;
		}
		$.ajax({
			async:false,
			url : lfo_mtrlBadGrd.ctrlUrl + lfo_mtrlBadGrd.crud.read.url,
			type: "POST",
			data: {badId :lfo_mtrlBadGrd.gridSelected.badId},
			success: function(data){
				gfn_popform_set(lfo_mtrlBadGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_mtrlBadGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_mtrlBadGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_mtrlBadGrd.popId+"_form").serializeObject();
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_mtrlBadGrd.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_mtrlBadGrd.ctrlUrl + lfo_mtrlBadGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_mtrlBadGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					//내역보기 팝업 리로드
					lfo_mtrlBadGrd.grid.dataSource.read();
					//발주주문조회 리로드
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

//삭제 콜백
this.lfn_mtrlBadGrd_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_mtrlBadGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_mtrlBadGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	
	$.ajax({
		async:false,
		url : lfo_mtrlBadGrd.ctrlUrl + lfo_mtrlBadGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//내역보기 팝업 리로드
			lfo_mtrlBadGrd.grid.dataSource.read();
			//발주주문조회 리로드
			lfo_popGrd.grid.dataSource.read();
			//마스터그리 리로드
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
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

//LOT-pop - 유저정보 팝업 콜백
this.lfn_badUserInfoPop_callback = function(rtnObj){
	$("#" + lfo_mtrlBadGrd.popId + " [name=chkUser]").val(rtnObj["userId"]);
	$("#" + lfo_mtrlBadGrd.popId + " [name=chkUserNm]").val(rtnObj["userNm"]);
}

</script>