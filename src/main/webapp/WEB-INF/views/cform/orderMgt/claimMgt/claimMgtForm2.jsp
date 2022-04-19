<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="claimMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="claimMgtForm"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm" class="jtePopForm">
		<div id="jtePopForm_gridArea" style="display:none;">
			<div class="pop_title"><spring:message code = "pop_lotInfo" text = "LoT정보"/></div>
			<div id="jtePopForm_grid" class="claimMgtForm" style="height : 400px;"></div>
		</div>
	</div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm_Claim" class="jtePopForm">
		<div id="jtePopForm_Claim_gridArea" style="display:none;">
			<div class="pop_title"><spring:message code = "col_claimInfo" text = "클레임정보"/></div>			
			<div id="jtePopForm_Claim_grid" class="claimMgtForm" style="height : 330px;"></div>
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="jtePopAddForm">
		<form id="jtePopAddForm_form" class="claimMgtForm">
			<div class="pop_title"><spring:message code = "pop_lotInfo" text = "LoT정보"/></div>
			<table style="width:100%;" id="jtePopAddForm_master" class="BasicTable">
			<colgroup>
				<col style="width:16%;">
				<col style="width:34%;">
				<col style="width:16%;">
				<col style="width:34%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotCd" text = "LoT코드"/> : </td>
					<td>
						<input type="text" id="lotId" name="lotId" readonly/>
						<input type="hidden" id="lotSeq" name="lotSeq"/>
					</td>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_itemNm" text = "제품명"/> :  </td>
					<td>
						<input type="text" id="itemNm" name="itemNm" format="text" readonly/>
						<input type="hidden" id="itemId" name="itemId">
					</td>
				</tr>
 				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_lotWrkNm" text = "LoT명"/> : </td>
					<td colspan="3"><input type="text" id="lotNm" class="center-input" name="lotNm" format="text" readonly/></td>
				</tr>
			</table>
			<div class="pop_title"><spring:message code = "pop_claimInfo" text = "클레임정보"/></div>
			<table style="width:100%;" id="jtePopAddForm_master" class="BasicTable">
			<colgroup>
				<col style="width:16%;">
				<col style="width:34%;">
				<col style="width:16%;">
				<col style="width:34%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimCd" text = "클레임코드"/> : </td>
					<td colspan="3"><input type="text" id="claimId" name="claimId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력"/>" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimNm" text = "클레임명"/> : </td>
					<td colspan="3"><input type="text" id="claimNm" name="claimNm"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimQty" text = "클레임수량"/> : </td>		
					<td colspan="3">
						<input id="claimQty" name="claimQty" format="currency"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimCause" text = "발생원인"/> : </td>
					<td colspan="3"><input type="text" id="claimCause" name="claimCause"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_claimResult" text = "처리결과"/> : </td>
					<td colspan="3"><input type="text" id="claimResult" name="claimResult"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="col_reason" text = "이유"/> : </td>
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
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/orderMgt/claimMgt/claimMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//서브그리드에서 사용될 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_common = {};

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/orderMgt/claimMgt";

	lfo_common.crud  = {
		read:{url:"/getOrderList", auth:"", prmt:{}, dynamicPrmt:{orderState : "orderState"}},
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html :	'<div style="margin : 0 14px 0 5px; float:right;">수주상태 : '+
				'<input name="orderState" id="orderState" value="ord_prcd01"></div>'

	}	

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

	lfo_common.columns = [
		{field: "orderId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},
		{field: "orderId", title:gfn_getMsg("col_orderCd", "수주코드"), width: "110px"},
		{template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm", "수주명"), width: "160px"},
		{field: "orderManagerNm", title:gfn_getMsg("col_manager", "관리자"), width: "80px;"},
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate", "수주일"), width: "90px"},
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate", "납기일"), width: "90px"},
		{field: "description", title:gfn_getMsg("col_desc", "설명"), width: "250px"},	
		{field: "orderState",template:"# var item = gfn_isNull(orderState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(orderState).cdId , gfn_getCode(orderState).cdNm) # #= item #",
			title : gfn_getMsg("col_orderStatus", "수주상태"), width: "100px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "120px"}, 
		{field: "claimCnt", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_claimCount", "클레임 건수"), width: "80px"},
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_orderNm", "수주명"), value: "orInfo.order_nm" },
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_orderCd", "수정코드"), value: "orInfo.order_id" }


	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	var selBoxItem = gfn_getCode('ord_prcd');
	
	$("#orderState").kendoDropDownList({
		dataSource: selBoxItem,
		dataValueField: "cdId",
		dataTextField: "cdNm",
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
		options.title = gfn_getMsg("pop_orderRegist", "수주등록");
		options.id = "jtePopAddForm";
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_lotInfo", "LoT정보");	
		options.id = "jtePopForm";
	}else if(mode =="LOT"){
		options.width = "800px;";
		options.height = "390px;";
		options.title = gfn_getMsg("pop_claimInfo", "클레임정보");
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

	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	lfo_popGrd.popId = "jtePopForm";

	lfo_popGrd.ctrlUrl = "/cform/orderMgt/claimMgt";

	lfo_popGrd.crud  = {
		read:{url:"/getLotList", auth:"", prmt:{orderId : lfo_common.gridSelected.orderId}}, 
	};

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
				mtrlNm: { type: "string" },
				mtrlQty: { type: "string" },
				mtrlDiv: { type: "string" },
				mtrlDesc: { type: "string" },
				claimCnt: { type: "int"}
			}
		};

	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "lotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'LOT\',this)" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px;"},
		{field: "lotId", title:gfn_getMsg("col_lotCd", "LoT코드"), width: "170px;"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm", "제품명"), width: "220px;"},
		{field: "lotQty", title:gfn_getMsg("col_lotQty", "LoT수량"), width: "120px;"},
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
				title : gfn_getMsg("col_lotStatus", "작업상태"), width: "120px;"},	
		{field: "claimCnt", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_claimCount", "클레임 건수"), width: "100px"},
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_itemNm", "제품명"), value: "item.item_nm" },
		{ text: gfn_getMsg("col_manager", "관리자"), value: "urInfo.user_nm" },
		{ text: gfn_getMsg("col_lotCd", "LoT코드"), value: "lot.lot_id" }
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);

}

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd_claim = function(prmt){
	lfo_claimPopGrd = {};

	lfo_claimPopGrd.prmt = prmt;

	lfo_claimPopGrd.layoutId = "jtePopForm_Claim_grid";

	lfo_claimPopGrd.popId = "jtePopAddForm";

	lfo_claimPopGrd.ctrlUrl = "/cform/orderMgt/claimMgt" ;

	lfo_claimPopGrd.crud  = {
		read:{url:"/getLotClaimList", auth:"", prmt:{lotId : lfo_popGrd.gridSelected.lotId}},
		create:{url:"/setClaimInfoSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"/setClaimInfoSave", auth:"", openFun: "" ,callback:lfn_jtePopGrd_save},
		destroy : {url:"/setClaimInfoDelete", auth: "" , callback:lfn_claimPopGrd_delete}
	};

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

	lfo_claimPopGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "claimId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this)" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px;"},
		{field: "claimId", title:gfn_getMsg("col_cdId", "코드"), width: "150px;"},				
		{field: "claimNm", title:gfn_getMsg("col_userNm", "유저명"), width: "150px;"},				
		{field: "claimQty", title:gfn_getMsg("col_quantity", "수량"), width: "120px;"},
		{field: "claimCause", title:gfn_getMsg("col_claimCause", "발생 원인"), width: "120px;"},
		{field: "claimResult", title:gfn_getMsg("col_claimResult", "처리 결과"), width: "120px;"},
		{field: "claimDesc", title:gfn_getMsg("col_reason", "이유"), width: "150px;"}
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
		width: "710px", 
		height: "500px",
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