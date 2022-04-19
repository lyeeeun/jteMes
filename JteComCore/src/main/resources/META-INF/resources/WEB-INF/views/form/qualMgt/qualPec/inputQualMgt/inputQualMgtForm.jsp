<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="inputQualMgtForm" style="width: 100%;">
	<div id="jteSingleGrid" class="inputQualMgtForm"></div>
</div>

<div style="display: none;">
	<div id="pop_incommingInspect">
		<form id="pop_incommingInspect_form" class="pop_incommingInspect_Form">
			<table id="pop_incommingInspect_form_tb" style="width: 94%;" class="mtrlOdcursitMgtForm-table" style="display:none;">
				<colgroup>
					<col class='col-input-list-1'>
					<col class='col-input-list-2'>
					<col class='col-input-list-3'>
					<col class='col-input-list-4'>
					<col class='col-input-list-5'>
					<col class='col-input-list-6'>
				</colgroup>
				<tr	class="mtrlOdcursitMgtForm input-list pop_selfInspect_Form_title" >
					<td>No</td>
					<td><spring:message code="col_mtrlOdcursitItem" text = "항목" /></td>
					<td><spring:message code="col_mtrlOdcursitStandard" text = "규격" /></td>
					<td><spring:message code="col_inspectionPort" text = "검사구" /></td>
					<td><spring:message code="col_mtrlOdcursitCycle" text = "주기" /></td>
					<td><spring:message code="col_valueInput"  text = "수치입력" /></td>
				</tr>
			</table>
			<div class="mtrlOdcursitMgtForm final-btn-area" style="text-align: center;" id="pop_incommingInspectBtn"></div>
		</form>
	</div>
</div>


<!-- 수령확인 팝업 -->
<div style="display:none;">
	<div id="jteMtrlOrdChkPop">
	<form id="jteMtrlOrdChkPop_form" class="inputQualMgtForm" style = "display:none">
			<div class="pop_title"><spring:message code = "pop_receiptInfo" text = "수령정보" /></div>
			<table id="jteMtrlOrdChkPop_master" class="BasicTable">
			<colgroup>
				<col style="width: 24%;">
				<col style="width: 27%;">
				<col style="width: 22%;">
				<col style="width: 27%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlItemCd" text = "발주계획코드" /> : </td>
					<td><input type="text" id="mtrlOrderId" name="mtrlOrderId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_orderSitDiv" text = "발주상황구분" /> : </td>
					<td><input id="mtrlOrderState" name="mtrlOrderState"  format = "selBox" msg="mtrl_order" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm" text = "자재명" /> : </td>
					<td colspan="3">
						<input type="text" id="mtrlNm" name="mtrlNm" readonly/>
						<input type="hidden" id="mtrlCost" name="mtrlCost" />
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm" text = "업체명" /> : </td>
					<td colspan="3">
						<input type="text" id="compNm" name="compNm" readonly/>
						<input type="hidden" id="compId" name="compId" />
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_quantity" text = "수량" /> : </td>
					<td><input id="mtrlOrderQty" name="mtrlOrderQty" format="currency" onkeyup="lfn_mtrlTotlCostCalc()"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_deliveryCost" text = "배송비용" /> : </td>
					<td><input id="mtrlOrderDelivery" name="mtrlOrderDelivery" format="currency"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlCost" text = "자재비용" />
					<i class="fas fa-info-circle" title="<spring:message code = "pop_mtrlQtyAuto" text = "자재와 수량을 입력하면 기본적으로 자동계산 됩니다." />"></i> :
					</td>
					<td colspan="3"><input id="mtrlOrderCost" name="mtrlOrderCost" format="currency"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명" /> : </td>
					<td colspan="3"><input type="text" id="mtrlOrderDesc" name="mtrlOrderDesc" format="text"></td>
				</tr>
			</table>
			<!-- 완료정보 -->
			<div class="pop_title"><spring:message code = "pop_finishInfo"></spring:message></div>
			<table style="width:100%;" id="jteMtrlOrdChkPop_master-2" class="BasicTable">
			<colgroup>
				<col style="width: 24%;">
				<col style="width: 27%;">
				<col style="width: 22%;">
				<col style="width: 27%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_recipient" text = "수령자" ></spring:message> : </td>
					<td>
						<input id="mtrlOrderUserNm" class="btn-input" name="mtrlOrderUserNm" format="text" readonly/>
						<input type="hidden" name="mtrlOrderUser" id="mtrlOrderUser"/>
						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
							<spring:message code="btn_search" text = "조회" />
						</button>
					</td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate" text = "수령일" /> : </td>
					<td>
						<input id="mtrlOrderDate" name="mtrlOrderDate" format="datepicker"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>검사담당자 : </td>
					<td>
						<input id="mtrlChargeUserNm" class="btn-input" name="mtrlChargeUserNm" format="text" readonly/>
						<input type="hidden" name="mtrlChargeUser" id="mtrlChargeUser"/>
						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_userChargePop_callback)">
							<spring:message code="btn_search" /><!-- 조회 -->
						</button>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="mtrlId" id="qcMtrlId"/>
						<input type="hidden" name="mtrlOfId"/>
						<input type="hidden" name="mtrlMgtId" id="chkMtrlMgtId"/>
						<input type="hidden" name="mtrlQualSta" id="mtrlQualSta"/>
						<input type="hidden" name="use" id="chkUse"/>
						<input type="hidden" name="action" id="chkAction"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="pop_title"><spring:message code = "col_badInfo" text = "불량정보" /></div>
		<div id="jteMtrlOrdChkPop_grid" style="height:390px"></div>
	</div>
</div>

<!-- 불량품 관리 팝업 -->
<div style="display: none;">
	<div id="jteMtrlBadChkPop">
		<form id="jteMtrlBadChkPop_form" class="inputQualMgtForm">
			<table id="jteMtrlBadChkPop_master"
				class="BasicTable">
				<colgroup>
					<col style="width: 19%;">
					<col style="width: 31%;">
					<col style="width: 19%;">
					<col style="width: 31%;">
				</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_badId" text = "불량아이디" /> :</td>
					<td colspan="3"><input type="text" id="badId" name="badId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />"readonly /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_badInfo" text = "불량정보" /> :</td>
					<td><input id="badCode" name="badCode" format="selBox"	msg="qual_MTRLCUT" /></td>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_quantity" text = "수량" /> :</td>
					<td><input id="badQty" name="badQty" format="currency" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_inspector" text = "검사자" /> :</td>
					<td><input id="chkUserNm" class="btn-input" name="chkUserNm" format="text" readonly /> 
						<input type="hidden" name="chkUser" id="chkUser" />
						<button class="k-button k-primary" type="button" onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)">
							<spring:message code="btn_search" text = "조회" />
						</button>
					</td>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_inspectDate" text = "검사일" /> :</td>
					<td><input id="chkDate" name="chkDate" format="datepicker" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i> <spring:message code="col_attachment" text = "첨부파일" /> :</td>
					<td colspan="3">
						<input name="attachFile" id="attachFiles" type="file" aria-label="files" format="file" code="badId" /> 
						<input type="hidden" id="insertAttach" value="[]" /> 
						<input type="hidden" id="deleteAttach" value="[]" />
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>처리결과 :</td>
					<td colspan="3"><input id="badDesc" name="badDesc" type="text" /></td>
				</tr>
				<tr style="display: hidden;">
					<td>
						<input type="hidden" name="badTarget" id="badTarget" /> 
						<input type="hidden" name="badTargetCode" id="badTargetCode" /> 
						<input type="hidden" name="mtrlId" id="bad_mtrlId" /> 
						<input type="hidden" name="mtrlMgtId" id="bad_mtrlMgtId" /> 
						<input type="hidden" name="use" id="bad_use" /> 
						<input type="hidden" name="action" id="bad_action" />
					</td>
				</tr>
			</table>
		</form>
		<div class="inputQualMgtForm final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display: none;"><spring:message code="pop_save" text = "저장" /></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display: none;"><spring:message code="pop_save" text = "저장" /></button>
			<button class="k-button k-primary final-btn" type="button" onclick="gfn_closePop('jteMtrlBadChkPop');"><spring:message code="pop_cancel" text = "취소" /></button>
		</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/inputQualMgt/inputQualMgtForm_JJW.css' rel="stylesheet">



<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_mtrlBadGrd = {};//발주주문서 팝업 그리드에서 사용

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
	lfo_common.popId = "jteMtrlOrdChkPop";
	
	//3.
	lfo_common.ctrlUrl = "/form/qualMgt/qualPec/inputQualMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getMtrlOrderPlanInputList", auth:"", prmt:{mtrlOrderState: "mtrl_order_end"}, dynamicPrmt : {mtrlOfId : "mtrlOfId" }}
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
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlOrderId", title: "검사항목", width: "110px",
			template : function(rows){
				if (rows.mtrlQualSta == 'inspecComplete'){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_inspectPop(\'EDT\', this) " style="width:80px;">'+ "<spring:message code = "col_checkList" />" +'</button>';					//내역보기
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_inspectPop(\'NEW\', this) " style="width:80px;">'+ "<spring:message code = "col_checkList" />" +'</button>';					//내역보기
				}
				
			}
		},
		{field: "mtrlOrderState", editable: function(){return false;}, title:"불량정보" , width:"110px",			//불량정보
			template : function(rows) {
				if (rows.mtrlOrderState == "mtrl_order_end"){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_mtrlOrderCheckPop_open(this,\'EDT\') " style="width:80px;">불량정보</button>';					//내역보기
				}else{
					return "";
				}
			}
		},
		{field: "mtrlQualSta", title: "검사상태", width: "110px",
			template:
				function(rows){
				if (rows.mtrlQualSta == 'inspecComplete'){
					return '<span style="color:blue">'+gfn_getMsg("bc_"+ gfn_getCode(rows.mtrlQualSta).cdId , gfn_getCode(rows.mtrlQualSta).cdNm)+'</span>';
				}else{
					return '<span style="color:red">'+gfn_getMsg("bc_"+ gfn_getCode(rows.mtrlQualSta).cdId , gfn_getCode(rows.mtrlQualSta).cdNm)+'</span>';
				}
				
			}
		},
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm", "자재명"), width: "120px"},
		{field: "mtrlOrderQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity", "수량"), width: "90px"},
		{field: "compNm",  title:gfn_getMsg("col_compNm", "업체명"), width: "160px"},
		{field: "mtrlOrderUserNm", title:gfn_getMsg("col_recipient", "수령자"), width: "130px"},
		{field: "mtrlOrderDate", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate", "수령일"), width: "110px"},
		{field: "mtrlOrderId", title:gfn_getMsg("col_mtrlItemCd", "발주계획코드"), width: "180px"},
		{field: "mtrlId", title:gfn_getMsg("col_mtrlCd", "자재코드"), width: 100},
		{field: "mtrlOrderCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost", "금액"), width: "90px"},
		{field: "mtrlOrderDelivery", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_deliveryCost", "배송비용"), width: "120px"},
		{field: "mtrlOrderDesc", title:gfn_getMsg("col_desc", "설명"), width: "150px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlInfo.mtrl_nm" },
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_mtrlItemCd", "발주계획코드"), value: "mtrlOrder.mtrl_order_id" }
	];
	
	lfo_common.customTitle = {
			html: '<button class="k-button k-primary" type="button" onclick = "lfn_mtrlOrderForm();" style="min-width:80px;">발주 주문서</button>' +
			'<input class="k-textbox" id="mtrlOfNm" readonly/><input type="hidden" id="mtrlOfId" /> '
		};
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//불량정보 버튼 클릭(팝업 오픈)
this.lfn_mtrlOrderCheckPop_open = function(target, mode){
	var options = {
		modal:true, 
		width: "900px", 
		height: "430px", 
		id : "jteMtrlOrdChkPop", 
		title : gfn_getMsg("pop_badInfo", "불량정보"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_mtrlOrderCheckPop_set(mode, dataItem)};
	this.gfn_winOpen(options);
}


//팝업내용 세팅
this.lfn_mtrlOrderCheckPop_set = function(mode, dataItem){
	lfo_common.gridSelected = {};
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode,dataItem);
		//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
		$("#jteMtrlOrdChkPop" + " [name=mtrlOrderDate]").data("kendoDatePicker").value(new Date());
		$("#jteMtrlOrdChkPop" + " [name=mtrlOrderUserNm]").val($("#_loginUserName").val())
		$("#jteMtrlOrdChkPop" + " [name=mtrlOrderUser]").val($("#_loginUserId").val())
		
		//저장시 action을 수령완료로 변경
		$("#jteMtrlOrdChkPop" + " [name=action]").val("END");
		
		//불량코드 조회문제로 빈값 넣어주기(빈값은 if test문에 걸려서 제외 > false로 대체)
		lfo_common.gridSelected= {
				mtrlOrderId : false
		}
	}else if(mode == 'EDT'){
		if(typeof(dataItem) == "object"){
			lfo_common.gridSelected = dataItem;
		}else if(typeof(dataItem) == "string"){
			lfo_common.gridSelected = dataItem;
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {
				mtrlOrderId :lfo_common.gridSelected.mtrlOrderId,
				mtrlOfId :lfo_common.gridSelected.mtrlOfId
				},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
		//저장시 action을 수령변경 으로 변경
		$("#jteMtrlOrdChkPop" + " [name=action]").val("ENDUP");
			
	}
	//그리드 세팅
	if($("#jteMtrlOrdChkPop_grid").html() ==""){
		lfn_mtrlBadGrd_setGrd();
	}else{
		lfo_common.grid.dataSource.read();
	}
	
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

//입고 자재불량 그리드 
this.lfn_mtrlBadGrd_setGrd = function(){
	lfo_mtrlBadGrd = {};

	//1.
	lfo_mtrlBadGrd.layoutId = "jteMtrlOrdChkPop_grid";
	//여기까지
	
	//2.
	lfo_mtrlBadGrd.popId = "jteMtrlBadChkPop";
	
	//3.
	lfo_mtrlBadGrd.ctrlUrl = "/form/qualMgt/infergodsMgt"
	
	//4.
	lfo_mtrlBadGrd.crud  = {
		read:{url:"/getMtrlBadList", auth:"", prmt:{badTargetCode : lfo_common.gridSelected.mtrlOrderId}}, 
		create:{url:"/setMtrlBadSave", auth:"", openFunc : lfn_mtrlBadGrd_open, callback : lfn_mtrlBadGrd_save}, 
		update:{url:"/setMtrlBadSave", auth:"", openFunc : "", callback : lfn_mtrlBadGrd_save}, 
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
			badPgNm : { type: "string" }
		}
	};
	
	//6.
	lfo_mtrlBadGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "badId", title:gfn_getMsg("btn_update"), width: "90px",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlBadGrd_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" text = "보기"/>" + '</button>',
			},		
		{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause", "불량원인"), width: "130px;"},
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badInfo", "불량정보"), width: "200px;"},
		{field: "mtrlNm", title : gfn_getMsg("col_mtrlNm", "자재명"), width: "140px"},
		{field: "badQty",format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan", "불량량"), width: "90px"},	
		{field: "badDesc", title: "처리결과", width: "350px"},
		{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate", "검사일"), width: "130px"},
		{field: "chkUserNm", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_inspector", "검사자"), width: "130px"},
		{field: "badPgDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_workDate", "작업일"), width: "130px"},
		{field: "badPgUserNm", title : gfn_getMsg("col_representative", "담당자"), width: "130px"},
		{field: "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd", "자재개별코드"), width: "180px"},
		{field: "badId", title : gfn_getMsg("col_badId", "불량아이디"), width: "180px"},	
		{field: "badTargetCode", title : "발주계획코드", width: "180px"},	
		{field: "badPgNm", title : gfn_getMsg("col_progNm", "프로그램명"), width: "180px"},
		{field: "badPgCd", title : gfn_getMsg("col_progCd", "프로그램코드"), width: "180px"}
	];
	
	//7.
	lfo_mtrlBadGrd.selectBox = [
		{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlNm" },
		{ text: gfn_getMsg("col_representative", "담당자"), value: "badPgUserNm" }
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


//불량정보 팝업 오픈
this.lfn_mtrlBadGrd_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "690px",
		height: "400px",
		id : lfo_mtrlBadGrd.popId,
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[ "Minimize", "Maximize", "Close"]
	};
	
	if(mode =="NEW"){
		options.title = "불량정보 등록"
		/* if($("#mtrlQualSta").val() == "inspecComplete"){
			gfn_msgBox({msg : "입고검사가 완료되어 불량등록이 불가능합니다."});
			return false;
		} */
	}else if(mode=="EDT"){
		options.title = "불량정보 수정"
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_mtrlBadGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//불량정보 팝업내용 세팅
this.lfn_mtrlBadGrd_popSet = function(mode,selectedItem){
	lfo_mtrlBadGrd.gridSelected = {};
	if(mode=='NEW'){
		//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
		selectedItem = {
				mtrlId : $("#" + lfo_common.popId + " [name=mtrlId]").val(),
				mtrlMgtId : $("#" + lfo_common.popId + " [name=mtrlMgtId]").val(),
				badTarget : "qual_spec01",
				badTargetCode : $("#" + lfo_common.popId + " [name=mtrlOrderId]").val(), 
				chkDate : new Date(),
				chkUserNm : $("#_loginUserName").val(),
				chkUser : $("#_loginUserId").val()
		}
		gfn_popform_set(lfo_mtrlBadGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_mtrlBadGrd.gridSelected = lfo_mtrlBadGrd.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_mtrlBadGrd.gridSelected = {badId : selectedItem};
			
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

//불량정보 Form내용 입력/저장
this.lfn_mtrlBadGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_mtrlBadGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		
		var formId = lfo_mtrlBadGrd.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);
	
		//var savePrmt = $("#"+lfo_mtrlBadGrd.popId+"_form").serializeObject();
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
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
					
					//내역보기 팝업 리로드
					lfo_mtrlBadGrd.grid.dataSource.read();
					//발주주문조회 리로드
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

//불량정보 삭제 콜백
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
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});	
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
} 
//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

//pop - 수령확인 완료정보 유저 팝업 콜백
this.lfn_userInfoPop_callback = function(rtnObj){
	$("#" + lfo_common.popId + " [name=mtrlOrderUser]").val(rtnObj["userId"]);
	$("#" + lfo_common.popId + " [name=mtrlOrderUserNm]").val(rtnObj["userNm"]);
}
this.lfn_userChargePop_callback = function(rtnObj){
	$("#" + lfo_common.popId + " [name=mtrlChargeUser]").val(rtnObj["userId"]);
	$("#" + lfo_common.popId + " [name=mtrlChargeUserNm]").val(rtnObj["userNm"]);
}

//발주주문서 조회
 this.lfn_mtrlOrderForm = function(){

 		var callback = function(selectedItem){
 			$('#mtrlOfNm').val(selectedItem.mtrlOfNm);
 			$('#mtrlOfId').val(selectedItem.mtrlOfId);
 			
 			lfo_common.grid.dataSource.read();
 		};
 		gfn_openCustomPop("mtrlOrderForm", callback);
 }
 
 
//검사 체크리스트 팝업 
 this.lfn_inspectPop = function(mode, selectedItem) {
	
	lfo_inspect = {};
	
	//2.
	lfo_inspect.popId = "pop_incommingInspect";
	
	//3.
	lfo_inspect.ctrlUrl = "/form/qualMgt/qualCheckList"
	
	//4.
	lfo_inspect.crud  = {
		read:{url:"/selectCheckList", auth:"", prmt:{} }, 
		create:{url:"/insertCheckList", auth:"", openFunc: "", callback: lfn_inspectPop_save}, 
		update:{url:"/updateCheckList", auth:"", openFunc: "", callback : lfn_inspectPop_save}
	};
 	var option = {
 			width: "760px", 
 			height: "350px",
 			id: lfo_inspect.popId, 
 			resizable:false,
 			animation:{open :{effects:"expand:vertical fadeIn"},
 			close :{effects:"expand:vertical fadeIn", reverse: true}},
 			actions:[/*"Minimize", "Maximize", */"Close"],
 			baseGroupCode: "inputQualChk",
 			category: "incomming_inspect",
 			title: "입고검사"
 			
 	};
 	
 	$.each(gfn_getCode(option.baseGroupCode), function(index, item) {
 		$("#pop_incommingInspect_form_tb").append("<tr id=" + item.cdId + ">" +
 				"<td class='mtrlOdcursitMgtForm-index'>" + (index+1) + "</td>" +
 				"<td>" + item.cdNm + "</td>" +
 				"<td>" + item.cdVal + "</td>" +
 				"<td>" + item.cdReserve01 + "</td>" +
				"<td>" + item.cdReserve02 + "</td>" +
 				"<td><input class='k-textbox center-input' name='questionValue' type='text' \></td>" +
 				"</tr>");
 	});
 	

 	//팝업이 생성된 뒤 동작해야할 함수 입력
 	option.callback = function(){
 		lfn_inspectPop_set(mode, selectedItem);
 	};
 	this.gfn_winOpen(option);
 }

//체크리스트 팝업 셋팅
 this.lfn_inspectPop_set = function(mode, selectedItem){

	 lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));

	 if(mode == 'NEW'){
		 $("#pop_incommingInspectBtn").append(
					"<button class='k-button k-primary final-btn' type='button' onclick = "+"lfn_inspectPop_save('NEW')>"+"<spring:message code = 'pop_save'/>"+"</button>"+
	 				"<button class='k-button k-primary final-btn' type='button' onclick = "+"gfn_closePop('pop_incommingInspect')>"+"<spring:message code = 'pop_cancel'/>"+"</button>"
		 );
		 $.ajax({
	 			async:false,
	 			url : lfo_inspect.ctrlUrl + lfo_inspect.crud.read.url,
	 			type: "POST",
	 			data: {targetId: lfo_common.gridSelected.mtrlOrderId},
	 			success: function(data){
	 				gfn_popform_set(lfo_common, mode, data.rows[0]);
	 			}, error: function(ex){
	 				gfn_loading(false);
	 				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
	 			}
	 		});
	 }else if (mode == 'EDT'){
		 $("#pop_incommingInspectBtn").append(
	 				"<button class='k-button k-primary final-btn' type='button' onclick = "+"lfn_inspectPop_save('EDT')>"+"<spring:message code = 'pop_save'/>"+"</button>"+
	 				"<button class='k-button k-primary final-btn' type='button' onclick = "+"gfn_closePop('pop_incommingInspect')>"+"<spring:message code = 'pop_cancel'/>"+"</button>"
		 );
		 $.ajax({
	 			async:false,
	 			url : lfo_inspect.ctrlUrl + lfo_inspect.crud.read.url,
	 			type: "POST",
	 			data: {targetId: lfo_common.gridSelected.mtrlOrderId},
	 			traditional :true,
	 			success: function(data){
	 				$.each(data.rows, function(index, item) {
	 					$('#' + item.questionId).find('[name=questionValue]').val(item.questionValue);
	 				})
	 				gfn_popform_set(lfo_common, mode, data.rows[0]);
	 			}, error: function(ex){
	 				gfn_loading(false);
	 				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
	 			}
	 		});		 
	 }

 }

//체크리스트 저장
 this.lfn_inspectPop_save = function(mode){

 	var insertInspectList = new Array();
 	var updateInspectList = new Array();
 	var svcUrl = lfo_inspect.ctrlUrl;
 	var savePrmt = {};
 	
 	if(mode == "NEW") {
 		$("#pop_incommingInspect_form_tb").find('tr').each(function(index, item) {
 			if(index == 0) {
 				return true
 			}
 			insertInspectList.push({ questionId: $(item).attr('id'), questionValue: $(item).find('input').val(), targetId: lfo_common.gridSelected.mtrlOrderId , category: "incomming_inspect"});
 		});
 		svcUrl += "/insertCheckList";
 		savePrmt.insertInspectList = insertInspectList;
 		savePrmt.currentMenuId = gfn_serializeObject().currentMenuId;
 		savePrmt.targetId = lfo_common.gridSelected.mtrlOrderId;
 	} else if(mode == "EDT") {
 		$("#pop_incommingInspect_form_tb").find('tr').each(function(index, item) {
 			if(index == 0) {
 				return true
 			}
 			updateInspectList.push({ questionId: $(item).attr('id'), questionValue: $(item).find('input').val(), targetId: lfo_common.gridSelected.mtrlOrderId});
 		});
 		svcUrl += "/updateCheckList";
 		savePrmt.updateInspectList = updateInspectList;
 	}
 	
 	$.ajax({
 		async:false,
 		url : svcUrl,
 		type: "POST",
 		data: JSON.stringify(savePrmt),
 		traditional :true,
 		contentType : 'application/json',
 		dataType : 'json',
 		success: function(data){
 			gfn_closePop(lfo_inspect.popId);
 			lfo_common.grid.dataSource.read();
 			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
 		},error: function(ex){
 			gfn_loading(false);
 			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
 		}
 	});
 }

 
 
</script>