 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="smplPectMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="smplPectMgtForm"></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
</div>

<div style="display:none;">
	<div id="jtePopForm">
	<form id="jtePopForm_form" class="inputQualMgtForm" style="display:none;">
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="orderId" id="orderId"/>
						<input type="hidden" name="lotId" id="lotId"/>
						<input type="hidden" name="prodAsmId" id="prodAsmId"/>
						<input type="hidden" name="use" id="prodAsmUse"/>
						<input type="hidden" name="action" id="prodAsmAction"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>

<div style="display:none;">
	<div id="routWorkBadPop">
	<form id="routWorkBadPop_form" class="inputQualMgtForm" style="display:none;">
			<table style="width:100%;" id="routWorkBadPop_master" class="BasicTable">
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="prodUse"/>
						<input type="hidden" name="action" id="prodAction"/>
						<input type="hidden" name="prodWorkId" id="prodWorkId"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="pop_title"><spring:message code = "col_badInfo" text="불량정보"></spring:message></div>
		<div id="itemBad_grid" style="height:390px"></div>
	</div>
</div>

<!-- 불량품 관리 팝업 -->
<div style="display: none;">
	<div id="jteItemBadChkPop">
		<form id="jteItemBadChkPop_form" class="inputQualMgtForm">
			<table id="jteItemBadChkPop_master"
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
					<td><input id="badCode" name="badCode" format="selBox"	msg="qual_ITEMCUT" /></td>
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
					<td><input id="chkDate" name="chkDate" format="datetimepicker" /></td>
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
						<input type="hidden" name="prodAsmId" id="prodAsmId" />
						<input type="hidden" name="prodWorkId" id="prodWorkId" />
						<input type="hidden" name="orderId" id="orderId" />
						<input type="hidden" name="itemId" id="itemId" /> 
						<input type="hidden" name="lotId" id="lotId" /> 
						<input type="hidden" name="use" id="bad_use" /> 
						<input type="hidden" name="action" id="bad_action" />
					</td>
				</tr>
			</table>
		</form>
		<div class="inputQualMgtForm final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display: none;"><spring:message code="pop_save" text = "저장" /></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display: none;"><spring:message code="pop_save" text = "저장" /></button>
			<button class="k-button k-primary final-btn" type="button" onclick="gfn_closePop('jteItemBadChkPop');"><spring:message code="pop_cancel" text = "취소" /></button>
		</div>
	</div>
</div>

<div id="lotInfoPop">
	<div id="lotInfo_grid"></div>
</div>

<div style="display:none;">
	<div id="routWorkPop" style="height:100%">
		<div class="pop_title"><spring:message code = "pop_asdf" text = "라우팅정보" /></div>
		<div id="routWork_grid" style="height:350px;"></div>
	</div>
</div>

<link href='/resources/mes/css/contents/qualMgt/qualPec/smplPectMgt/smplPectMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//메인 그리드 Object 

var lfo_popGrd = {};

var lfo_routWorkGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/qualMgt/smplPectMgt"

	lfo_common.crud  = {
		read:{url:"/getProdAsgnList", auth:"", prmt:{}, dynamicPrmt:{lotId : "lotId"}, search : false}

	};

	lfo_common.model = {
			id: "prodAsmId",
			fields: {
				orderId : { type : "string" },
				orderNm : { type : "string" },
				lotId : { type : "string" },
				lotNm : { type : "string" },
				itemId : { type : "string" },
				itemNm : { type : "string" },
				prodAsmId : { type : "string" },
				prodAsmNm : { type : "string" },
				prodAsmDate : { type : "date" },
				prodAsmQty : { type : "int" },
				prodAsmDesc : { type : "string" },
				prodAsmUser : { type : "string" },
				prodAsmState : { type : "string" },
				routingId : { type : "string" },
				routingSeq : { type : "string" },
				routingType : { type : "string" },
				eqmtMgtId : { type : "string" },
				bomId : { type : "string" },
				bomNm : { type : "string" },
				bomTarget : { type : "string" },
				bomTargetCnt : { type : "string" },
				eqmtMgtNm : { type : "string" },
				prodWorkId : { type : "string" },
				prodWorkUser : { type : "string" },
				userNm : { type : "string" },
				prodWorkQty : { type : "int" },
				prodWorkGood : { type : "int" },
				prodWorkBad : { type : "int" },
				prodWorkStart : { type : "date" },
				prodWorkEnd : { type : "date" },
				prodWorkStatus : { type : "string" }
			}
	};
	
	lfo_common.columns = [
		{field: "prodAsmId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_routWork_popOpen(this)" style="width:60px;">보기</button>',
			title: gfn_getMsg("pop_view", "보기"), width: "90px"},
		{field: "prodAsmNm", title:gfn_getMsg("col_prodAsmNm", "작업지시명"), width: "160px"},
		{field: "prodAsmDate", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_prodAsmDate", "작업지시일"), width: "150px"},
		{field: "prodAsmQty", title:gfn_getMsg("col_prodAsmQty", "작업지시량"), width: "140px"},
		{field: "prodWorkQty", title:gfn_getMsg("col_prodWorkQty", "목표량"), width: "140px"},
		{field: "prodWorkGood", title:gfn_getMsg("col_prodWorkGood", "양품량"), width: "140px"}
	];
	
	lfo_common.customTitle = {
			html : '<span class="jte-search-aria"><label>'+"LoT"+' : </label>'
			+ '<input class="k-textbox" id="lotId" style="width:200px;" readonly/>'
			+ '<button class="k-button k-primary" type="button" onclick="lfn_lotInfoGrd_popOpen()">LoT 조회</button>',
			callback : lfn_customTltle_set
		};

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//자재조회 팝업 오픈
this.lfn_lotInfoGrd_popOpen = function(){
	var options = {
		modal:true, 
		width: "1250px", 
		height: "470px",
		id:"lotInfoPop", 
		title:"LoT 정보",	
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:["Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		$("#lotInfo_grid").empty();
		
		lfn_jtePopGrd_setGrd();
		$('#lotInfo_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}

//자재 조회 팝업 그리드 세팅
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
	
	lfo_popGrd.layoutId = "lotInfo_grid";
	
	lfo_popGrd.popId = "lotInfoPop";
	
	lfo_popGrd.ctrlUrl = "/cform/qualMgt/smplPectMgt"

	lfo_popGrd.crud  = {
		read:{url:"/getLotList", auth:"", prmt:{}, dynamicPrmt : {orderId : "orderId"}, search:false}, 
	};

	lfo_popGrd.model = {
		id: "lotId",
		fields: {
			itemId : { type: "string" },
			itemNm : { type: "string" },
			itemType : {type: "string"},
			itemMgtId : { type: "string" },
			itemStock: { type: "int" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			lotType : { type: "string" },
			lotQty : { type: "string" },
			lotOriginalQty : { type: "string" },
			lotPm : { type: "string" },
			lotPmNm : { type: "string" },
			lotState : { type: "string" },
			createdAt : { type: "string" },
			creatorId : { type: "string" },
			updatedAt : { type: "string" },
			updatorId : { type: "string" },
			orderId : { type: "string" }
		}
	};

	lfo_popGrd.columns = [
		{field: "lotId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_lotInfo_callback(this,\'EDT\');" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title: gfn_getMsg("btn_update", "수정"), width: "90px"},	
		{field: "lotNm", title: gfn_getMsg("col_lotWrkNm", "LoT명"), width: "170px"},
		{field: "lotId", title: gfn_getMsg("col_lotCd", "LoT 코드"), width: "160px"},
		{field: "itemNm", title: gfn_getMsg("col_itemNm", "제품명"), width: "160px"},
		{field: "lotQty", title: gfn_getMsg("col_lotQty", "LoT수량"), width: "140px"},
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
			title: gfn_getMsg("col_lotStatus", "LoT상태"), width: "140px"},
		{field: "lotPmNm", title: gfn_getMsg("col_manager", "관리자"), width: "140px"}
	];
	
	lfo_popGrd.customTitle = {
			html: '<button class="k-button k-primary" type="button" onclick = "lfn_orderInfo_open(\'order\');" style="min-width:60px;">수주 검색</button>' +
			'<input class="k-textbox" id="orderNm" readonly/><input type="hidden" id="orderId" /> '
	};
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}


this.lfn_orderInfo_open = function(mode){
	
	if(mode == 'order') {
		var callback = function(selectedItem){
			$('#orderNm').val(selectedItem.orderNm);
			$('#orderId').val(selectedItem.orderId);
			
			lfo_popGrd.grid.dataSource.read();
		};
		
		gfn_openCustomPop("orderInfo", callback);
	}
}

//자재정보 콜백
this.lfn_lotInfo_callback = function(selectedItems){
	
	var selectedItem = lfo_popGrd.grid.dataItem($(selectedItems).closest('tr'));
	
	$("#lotId").val(selectedItem.lotId);
	$("#lotNm").val(selectedItem.lotNm);
	
	gfn_closePop("lotInfoPop");
	
	lfo_common.grid.dataSource.read();
}

//정비이력 버튼 클릭(팝업 오픈)
this.lfn_routWork_popOpen = function(target){
	var options = {
		modal:true, 
		width: "1100px", 
		height: "400px",
		id : "routWorkPop", 
		title:"라우팅 정보",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	
	//선택한 항목의 ID 가져옴
	lfo_common.gridSelected = { 
			lotId : dataItem.lotId, 
			prodAsmId : dataItem.prodAsmId
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_routWorkGrd_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}

//자재 조회 팝업 그리드 세팅
this.lfn_routWorkGrd_setGrd = function(dataItem){
	lfo_routWorkGrd = {};
	
	lfo_routWorkGrd.layoutId = "routWork_grid";
	
	lfo_routWorkGrd.popId = "routWorkBadPop";
	
	lfo_routWorkGrd.ctrlUrl = "/cform/qualMgt/smplPectMgt"

	lfo_routWorkGrd.crud  = {
		read:{url:"/getRoutWorkList", auth:"", prmt:{lotId : dataItem.lotId, prodAsmId : dataItem.prodAsmId}, search:false}
	};

	lfo_routWorkGrd.model = {
			id: "prodAsmId",
			fields: {
				orderId : { type : "string" },
				orderNm : { type : "string" },
				lotId : { type : "string" },
				lotNm : { type : "string" },
				itemId : { type : "string" },
				itemNm : { type : "string" },
				prodAsmId : { type : "string" },
				prodAsmNm : { type : "string" },
				prodAsmDate : { type : "date" },
				prodAsmQty : { type : "int" },
				prodAsmDesc : { type : "string" },
				prodAsmUser : { type : "string" },
				prodAsmState : { type : "string" },
				routingId : { type : "string" },
				routingSeq : { type : "string" },
				routingType : { type : "string" },
				eqmtMgtId : { type : "string" },
				bomId : { type : "string" },
				bomNm : { type : "string" },
				bomTarget : { type : "string" },
				bomTargetCnt : { type : "string" },
				eqmtMgtNm : { type : "string" },
				prodWorkId : { type : "string" },
				prodWorkUser : { type : "string" },
				userNm : { type : "string" },
				prodWorkQty : { type : "int" },
				prodWorkGood : { type : "int" },
				prodWorkBad : { type : "int" },
				prodWorkStart : { type : "date" },
				prodWorkEnd : { type : "date" },
				prodWorkStatus : { type : "string" }
			}
	};
	
	lfo_routWorkGrd.columns = [
		{field: "prodWorkStatus", editable: function(){return false;}, title: gfn_getMsg("btn_search", "조회") , width:"100px",
			template : function(rows) {
				if (rows.prodWorkStatus == "work_end"){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_itemBadPop_open(this) " style="width:80px;">불량등록</button>';
				}else{
					return "";
				}
			}
		},
		{field: "routingSeq", title:gfn_getMsg("col_routingSeq", "차수"), width: "80px"},
		{field: "routingId", title:gfn_getMsg("col_routingId", "라우팅코드"), width: "180px"},
		{field: "routingType",  template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
			title:gfn_getMsg("col_routingType", "공정유형"), width: "120px"},
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtMgtNm", "설비명"), width: "160px"},
		{field: "prodWorkUserNm", title:gfn_getMsg("col_prodWorkUserNm", "작업자"), width: "120px"},
		{field: "prodWorkQty", title:gfn_getMsg("col_prodWorkQty", "목표량"), width: "100px"},
		{field: "prodWorkStart", format: "{0: yyyy-MM-dd hh:mm:ss}", title:gfn_getMsg("col_prodWorkStart", "시작시간"), width: "180px"},
		{field: "prodWorkEnd", format: "{0: yyyy-MM-dd hh:mm:ss}", title:gfn_getMsg("col_prodWorkEnd", "종료시간"), width: "180px"}
	];
	
	
	//공통 그리드 세팅 호출 
	lfo_routWorkGrd.grid = gfn_grid_set(lfo_routWorkGrd);
}

this.lfn_itemBadPop_open = function(target){
	
	var options = {
			modal:true, 
			width: "800px", 
			height: "470px",
			id: "routWorkBadPop", 
			title: "불량 정보",
			resizable: true,
			animation: {open :{effects:"expand:vertical fadeIn"},
			close : {effects:"expand:vertical fadeIn", reverse: true}},
			actions: [/*"Minimize", "Maximize", */"Close"]
		};
	
	var dataItem = lfo_routWorkGrd.grid.dataItem($(target).closest("tr"));
	
	//선택한 항목의 ID 가져옴
	lfo_routWorkGrd.gridSelected = {
			itemId : dataItem.itemId,
			lotId : dataItem.lotId,
			prodWorkId : dataItem.prodWorkId
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_itemMgtBadGrid(dataItem);
	};
	
	this.gfn_winOpen(options);
}


//그리드 세팅
this.lfn_itemMgtBadGrid = function(dataItem){
	lfo_itemBadGrd = {};//Form 내부에서 사용될 Object

	//1.
	lfo_itemBadGrd.layoutId = "itemBad_grid";
	
	//2.
	lfo_itemBadGrd.popId = "jteItemBadChkPop";
	
	//3.
	lfo_itemBadGrd.ctrlUrl = "/cform/qualMgt/smplPectMgt";

	//4.
	lfo_itemBadGrd.crud  = {
		read:{url:"/getItemBadList", auth:"", prmt:{itemId : dataItem.itemId, lotId : dataItem.lotId, badTargetCode : dataItem.prodWorkId}, search:false}, 
		create:{url:"/setItemBadSave", auth:"", openFunc : lfn_itemBadGrd_open, callback : lfn_itemBadGrd_save}, 
		update:{url:"/setItemBadSave", auth:"", openFunc : "", callback : lfn_itemBadGrd_save}, 
		destroy:{url:"/setItemBadDelete", auth:"", callback : lfn_itemBadGrd_delete}
	};
	
	//5.
	lfo_itemBadGrd.model = {
			id: "itemMgtId",
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
				itemId : { type: "string" },
				itemNm : { type: "string" },
				itemMgtId : { type: "string" },
				lotId : { type: "string" },
				badPgUser : { type: "string" },
				badPgUserNm : { type: "string" },
				badPgDate : { type: "date" },
				badPgCd : { type: "string" },
				badPgNm : { type: "string" }
		},
	};
	
	//6.
	lfo_itemBadGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "badId", title:gfn_getMsg("btn_update"), width: "90px",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_itemBadGrd_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view" text = "보기"/>" + '</button>',
			},		
		{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause", "불량원인"), width: "130px;"},
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badInfo", "불량정보"), width: "200px;"},
		{field: "itemNm", title : gfn_getMsg("col_itemNm", "자재명"), width: "140px"},
		{field: "badQty",format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan", "불량량"), width: "90px"},	
		{field: "badDesc", title: "처리결과", width: "350px"},
		{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate", "검사일"), width: "130px"},
		{field: "chkUserNm", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_inspector", "검사자"), width: "130px"},
		{field: "badPgDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_workDate", "작업일"), width: "130px"},
		{field: "orderId", title : gfn_getMsg("col_orderCd", "수주코드"), width: "180px"},
		{field: "lotId", title : gfn_getMsg("col_lotCd", "LoT코드"), width: "180px"},
		{field: "badId", title : gfn_getMsg("col_badId", "불량아이디"), width: "180px"},	
	];

	//공통 그리드 세팅 호출 
	lfo_itemBadGrd.grid = gfn_grid_set(lfo_itemBadGrd);

}

//불량정보 팝업 오픈
this.lfn_itemBadGrd_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "690px",
		height: "400px",
		id : "jteItemBadChkPop",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[ "Minimize", "Maximize", "Close"]
	};
	
	if(mode =="NEW"){
		options.title = "불량정보 등록"
	}else if(mode=="EDT"){
		options.title = "불량정보 수정"
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_itemBadGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//불량정보 팝업내용 세팅
this.lfn_itemBadGrd_popSet = function(mode,selectedItem){
	lfo_itemBadGrd.gridSelected = {};
	if(mode=='NEW'){
		//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
		selectedItem = {
				itemId : lfo_routWorkGrd.gridSelected.itemId,
//				itemId : $("#" + lfo_itemBadGrd.popId + " [name=itemId]").val(), 
				lotId : $("#lotId").val(),
				orderId : $("#orderId").val(),
				badTarget : "qual_spec03",
				badTargetCode : lfo_routWorkGrd.gridSelected.prodWorkId,
//				badTargetCode : $("#" + lfo_itemBadGrd.popId + " [name=prodWorkId]").val(), 
				chkDate : new Date(),
				chkUserNm : $("#_loginUserName").val(),
				chkUser : $("#_loginUserId").val()
		}
		gfn_popform_set(lfo_itemBadGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_itemBadGrd.gridSelected = lfo_itemBadGrd.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_itemBadGrd.gridSelected = {badId : selectedItem};
			
		}
		$.ajax({
			async:false,
			url : lfo_itemBadGrd.ctrlUrl + lfo_itemBadGrd.crud.read.url,
			type: "POST",
			data: {badId :lfo_itemBadGrd.gridSelected.badId},
			success: function(data){
				gfn_popform_set(lfo_itemBadGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//불량정보 Form내용 입력/저장
this.lfn_itemBadGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_itemBadGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		
		var formId = lfo_itemBadGrd.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);
		savePrmt.itemId = $("#itemId").val();
		savePrmt.lotId = $("#lotId").val();
		savePrmt.orderId = $("#orderId").val();
	
		//var savePrmt = $("#"+lfo_itemBadGrd.popId+"_form").serializeObject();
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_itemBadGrd.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_itemBadGrd.ctrlUrl + lfo_itemBadGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_itemBadGrd.popId);
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
					
					//내역보기 팝업 리로드
					lfo_itemBadGrd.grid.dataSource.read();
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
this.lfn_itemBadGrd_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_itemBadGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_itemBadGrd.grid.dataItem($(this).closest('tr')));
		}
	}); 
	
	$.ajax({
		async:false,
		url : lfo_itemBadGrd.ctrlUrl + lfo_itemBadGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//내역보기 팝업 리로드
			lfo_itemBadGrd.grid.dataSource.read();
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
</script>

