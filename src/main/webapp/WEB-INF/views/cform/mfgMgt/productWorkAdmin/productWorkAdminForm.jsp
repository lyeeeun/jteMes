 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="productWorkAdminForm" style="width:100%;">
	<!-- 좌측 오더리스트 -->
	<div id="jteSingleGrid" class="jteGrid productWorkAdminForm" style="width:49%; height:100%; float:left;"></div>
	<!-- 우측 작업지시리스트 -->
	<div id="jteDoubleGrid" class="jteGrid productWorkAdminForm" style="width: 50%; height:100%; float:right;"></div>
</div>

<!-- 생산지시 팝업 -->
<div style="display:none;">
	<div id="jteProdAsgnPop">
		<form id="jteProdAsgnPop_form" class="productWorkAdminForm">
		<!-- 작업지시 -->
			<div class="pop_title"><spring:message code = "pop_workAsm"></spring:message></div>
			<table style="width:100%;" id="jteProdAsgnPop_master" class="BasicTable">
			<colgroup>
				<col style="width:22%;">
				<col style="width:28%;">
				<col style="width:22%;">
				<col style="width:28%;">
			</colgroup>
				<tr>
				<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="itemNm" name="itemNm" readonly />
						<input type="hidden" id="itemId" name="itemId"/>
					</td>
				</tr>
				<tr>
				<!-- 작업지시명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderNm"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="prodAsmNm" name="prodAsmNm"/>
						<input type="hidden" name="prodAsmId"/>
					</td>
				</tr>
				<tr>
				<!-- 지시량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_asmQuan"></spring:message> : </td>
					<td><input id="prodAsmQty" name="prodAsmQty" format="currency"/></td>
					<td><i class="fas fa-caret-right"></i>지시일 : </td>
					<td><input id="prodAsmDate" name="prodAsmDate" format="datepicker"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="prodAsmDesc" name="prodAsmDesc" format="text"/></td>
				</tr>
				<tr style="display:none;">
				<!-- 부서명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_deptNm"></spring:message> : </td>
					<td>
						<input id="deptNm" class="btn-input" name="deptNm" format="text" readonly/>
						<input type="hidden" name="deptId" id="deptId"/>
				<!-- 조회 -->
						<button class="k-button k-primary" type="button"  onclick="lfn_deptInfoPop_Open(lfn_deptInfoPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				<!-- 작업지시자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderUser"></spring:message> : <i class="fas fa-info-circle" title="미설정시 지정된 부서의 팀장에게 발송됩니다." style="background:yellow;"></i></td>
					<td>
						<input id="prodAsmUserNm" class="btn-input" name="prodAsmUserNm" format="text" readonly/>
						<input type="hidden" name="prodAsmUser" id="prodAsmUser"/>
				<!-- 조회 -->
						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
					<!-- 작업상태 -->
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "prodAsmState"/>
						<input type="hidden" name="use"/>
						<input type="hidden" name="action"/>
					</td>
				</tr>
			</table>
		</form>
		
		<div class="productWorkAdminForm final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>				<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>				<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteProdAsgnPop');"><spring:message code = "pop_cancel"></spring:message></button>		<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 라우팅 전체조회 POP(같은 작업지시에 포함된 라우팅만 조회한다.) -->
<div style="display:none;">
	<div id="routingSheetPop" class="routingSheetPop">
		<div class="pop_title">작업정보</div>
		<div id="routingSheetPop_grid" class="routingSheetPop_grid" style="height:430px;"></div>
	</div>
</div>

<!-- 자재파악 팝업 -->
<div style="display:none;">
	<div id="mtrlUsePop">
		<div id="mtrlUsePop_grid" style="height:430px;"></div>
	</div>
</div>

<!-- 자재파악 - 상세조회  팝업 -->
<div style="display:none;">
	<div id="mtrlDetailPop">
		<div id="mtrlDetailPop_grid" style="height:360px;"></div>
	</div>
</div>


<!-- 라우팅 설비변경 팝업 -->
<div style="display:none;">
	<div id="routEqmtPop" class="routEqmtPop">
		<div class="pop_title">설비변경</div>
		<div id="routEqmtPop_grid" class="productWorkAdminForm routEqmtPop_grid" style="height:363px;"></div> <!-- 201120 YUMI_height 추가 -->
	</div>
</div>

<!-- 라우팅 공구변경 팝업 -->
<div style="display:none;">
	<div id="routToolPop" class="routToolPop">
		<div class="pop_title">공구변경</div>
		<div id="routToolPop_grid" class="productWorkAdminForm routToolPop_grid" style="height:363px;"></div> <!-- 201120 YUMI_height 360->363 -->
	</div>
</div>

<!-- 장착가능한 공구 조회 -->
<div style="display:none;">
	<div id="jteToolPosForm" class="wrkinWrkerMgtForm jteToolPosForm">
		<div id="jteToolPosForm_grid" class="productWorkAdminForm jteToolPosForm-single-grid"  style="height:410px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-update final-btn" type="button"><spring:message code = "pop_save"></spring:message></button>												<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteToolPosForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 부품 불량 등록/확인팝업 -->
<div style="display:none;">
	<div id="mtrlBadPop">
		<form id="mtrlBadPop_form" class="productWorkAdminForm itemBadSavePop_form">
		<!-- 불량품 정보 -->
			<table class="BasicTable">
			<colgroup> 
				<col style="width:23%;">
				<col style="width:27%;">
				<col style="width:23%;">
				<col style="width:27%;">
			</colgroup>
				<!-- 불량품정보 -->
				<div class="pop_title"><spring:message code = "pop_badInfo"></spring:message></div> <!-- tr을 div로 변경 -->
				<tr>
				<!-- 불량아이디 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badId"></spring:message> : 
					</td>
					<td colspan="3"><input type="text" id="badId" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : 
					</td>
					<td><input id="badCode" name="badCode"  format = "selBox" msg="qual_ITEMCUT"/></td> <!-- style="width: 95%; max-width:95%; " -->
				<!-- 수량 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_quantity"></spring:message> : 
					</td>
					<td><input id="badQty" name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input id="chkUserNm" name="chkUserNm" format="text"/>
						<input type="hidden" name="chkUser" id="chkUser"/>
<!--  						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)"> -->
<!-- 	 						조회 -->
<%-- 	 						<spring:message code="btn_search" /> --%>
<!--  						</button> -->
					</td>
				<!-- 검사일 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_inspectDate"></spring:message> : 
					</td>
					<td><input id="chkDate" name="chkDate" format="datepicker"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : 
					</td>
					<td colspan="3">
						<input id="badDesc" name="badDesc"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "badTarget"/>
						<input type="hidden" name = "badTargetCode"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "prodWorkStart"/>
						<input type="hidden" name = "prodWorkEnd"/>
						<input type="hidden" name = "prodWorkUser"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name = "prodPlanId"/>
						<input type="hidden" name = "itemId"/>
						<input type="hidden" name = "itemMgtId"/>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "action"/>
						<input type="hidden" name = "use"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="productWorkAdminForm final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('mtrlBadPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/mfgMgt/productWorkAdmin/productWorkAdminForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};// order(LOT)목록 Object 

var lfo_workAsgn = {};// 작업지시 목록 Object

var lfo_popGrd = {};// 선택한 작업지시 라우팅 Object

var lfo_routingAll = {};

var lfo_bomMtrl = {}; //자재파악

var lfo_mtrlDetail = {}; //자재파

var lfo_mtrlBad = {}; //불량저장


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
	lfo_common.popId = "";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mfgMgt/productWork";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getProductWorkLotList", auth:"", prmt:{}, dynamicPrmt:{lotState : "lotState"}}
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html :	'<span style="margin : 0 14px 0 5px;">LoT상태 : <input name="lotState" id="lotState" value="ord_sta01" style="width:110px;"></span>', position:"start"
	}
	
	//5.
	lfo_common.model = {
			id: "lotSeq",
			fields: {
				lotSeq : { type: "int" },
				lotId : { type: "string" },
				lotNm : { type: "string" },
				lotCode : { type: "string" },
				lotType : { type: "string" },
				lotQty : { type: "int" },
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
				orderNm: { type: "string" },
				orderManager: { type: "string" },
				orderStdt: { type: "date" },
				orderEddt: { type: "date" },
				orderCost: { type: "int" },
				compId: { type: "string" },
				compNm: { type: "string" },
				orderState: { type: "string" },
				description: { type: "string" }
			}
		};
	
	//6.
	lfo_common.columns = [
		{field: "lotId",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_jteDbGrid_gridSet(this);" style="min-width:60px;">' + "지시목록" + '</button>',
		title : "상세", width: 110},									//수정
		//{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},				//Lot코드
		
/* 		{field: "slipNum", title:gfn_getMsg("col_slipNum"), width: "130px"},
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "120px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "120px"},			//납기일
		{field: "lotQty", title : "수주량", width: "90px;"},
		{field: "itemId"}
		{field: "itemNm"}
		{field: "item"}
		 */
		
		
		{template:"#:data.orderNm#",field: "orderNm", title:"수주명", width: "150px;"},
		{field: "lotNm", title:"LoT명", width: "150px;"},
		{field: "lotId", title:"LoT코드", width: "150px;"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "150px;"},				//부품명
		{field: "lotQty", title : "수주량", width: "90px;"},				//Lot수량
		{field: "compNm", title : "업체명", width: "120px;"},				//업체명
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
			title:gfn_getMsg("col_lotStatus"), width: "120px;"},					//수주상태
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "120px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "120px"},			//납기일
		{field: "lotPmNm", title:gfn_getMsg("col_manager"), width: "120px;"}			//담당자
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "수주명", value: "lot.lot_nm" },
		{ text: "제품명", value: "item.item_nm"},
		{ text: gfn_getMsg("col_lotCd"), value: "lot.lot_id" },			//수주코드
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },			//담당자
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" }			//업체명
	];
	
	//8.
	lfo_common.validation ={}
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	var selBoxItem = gfn_getCode('ord_sta');
	
	$("#lotState").kendoDropDownList({
		dataSource: selBoxItem,
		dataValueField: "cdId",
		dataTextField: "cdNm",
	//	valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
	//	template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
		index:0,
		change: function(e) {
			lfo_common.grid.dataSource.read();
		}
	});
};

//투입현황 토탈 그리드 세팅
this.lfn_jteDbGrid_gridSet = function(rows){
	
	//작업지시 그리드 초기화
	$("#jteDoubleGrid").html("");
	
	lfo_common.gridSelected = lfo_common.grid.dataItem($(rows).closest("tr"));
	
	//1.
	lfo_workAsgn.layoutId = "jteDoubleGrid";
	
	//2.
	lfo_workAsgn.popId = "jteProdAsgnPop";
	
	//3.
	lfo_workAsgn.ctrlUrl = "/cform/mfgMgt/productWork"

	//4.
	lfo_workAsgn.crud  = {
		read:{url:"/getProdWorkAsgnList", auth:"", prmt:{lotId : lfo_common.gridSelected.lotId}, search : false, paging:false},
		create : {url:"/setProdWorkAsgnSave", auth : "", openFunc : lfn_asgnCreatePop_open, callback : lfn_asgnCreatePop_save},
		update : {url:"/setProdWorkAsgnSave", auth : "", openFunc : lfn_asgnCreatePop_open, callback : lfn_asgnCreatePop_save},
		destroy : {url:"/setProdWorkAsgnDelete", auth : "", callback : lfn_asgnCreatePop_delete}
	};
	
	//커스텀 타이틀
	lfo_workAsgn.customTitle = {
		html:'<span class="pop_title">'+"지시목록"+'</span>'
	}
	
	//5.
	lfo_workAsgn.model = {
		id: "prodAsmId",
		fields: {
			orderId : { type: "string" }, 
			orderNm : { type: "string" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotQty : { type: "int" },
			prodAsmId : { type: "string" },
			prodAsmNm : { type: "string" },
			prodAsmDate : { type: "date" },
			prodAsmQty : { type: "int" },
			prodAsmDesc : { type: "string" },
			prodAsmUser : { type: "string" },
			prodAsmUserNm : { type: "string" },
			prodAsmEmj : { type: "string" },
			prodAsmState : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			deptId : { type: "string" },
			deptNm : { type: "string" }
		}
	};
	
	//6.
	lfo_workAsgn.columns = [
		{selectable : true, width:"50px"},
		{field: "prodAsmId", title: "정보", width: "190px",
			template:'<button class="k-button k-primary" type = "button" onclick = "lfn_routingSheet_open(this)" style="width:70px;">'+"작업정보"+'</button>' 
					+ '<button class="k-button k-primary" type = "button" onclick = "lfn_asgnCreatePop_open(\'EDT\', this); " style="width:40px;">'+"수정"+'</button>'},
		{field: "prodAsmNm", title : "지시명", width: "150px"},
		{field: "prodAsmDate", format: "{0: yyyy-MM-dd}", title : "지시일", width: "120px"},
		{field: "prodAsmQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : "지시량", width: "100px"},
		{field: "prodAsmUserNm", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : "지시자", width: "90px"},
		{field: "prodAsmState", template:"# var item = gfn_isNull(gfn_getCode(prodAsmState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmState).cdId , gfn_getCode(prodAsmState).cdNm) # #= item #", 
			title : "상태", width: "110px"}
	];
	
	//공통 그리드 세팅 호출 
	lfo_workAsgn.grid = gfn_grid_set(lfo_workAsgn);
}


//생산지시 팝업
this.lfn_asgnCreatePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "560px", //200520 JJW 550 -> 560
		height: "348px", //201216 JJW 330 -> 370
		id : lfo_workAsgn.popId, 
		title : gfn_getMsg("pop_workAsm"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_asgnCreatePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_asgnCreatePop_set = function(mode,selectedItem){
	lfo_workAsgn.gridSelected = {};
	
	if(mode=='NEW'){
		//팝업 기본정보 세팅
		lfo_workAsgn.gridSelected={ 
			lotId : lfo_common.gridSelected.lotId
		};
		
		//팝업내용 조회
		$.ajax({
			async:false,
			url : lfo_workAsgn.ctrlUrl + "/getProductWorkLotList",
			type: "POST",
			data: lfo_workAsgn.gridSelected,
			success: function(data){
				//팝업 세팅 로드
				gfn_popform_set(lfo_workAsgn, mode, data.rows[0]);
				$("#" + lfo_workAsgn.popId + " [name = prodAsmDate]").data("kendoDatePicker").value(new Date());
				$("#" + lfo_workAsgn.popId + " [name = prodAsmState]").val("prod_sta00");
				
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});	
		
	}else if(mode == 'EDT'){
		
		lfo_workAsgn.gridSelected = lfo_workAsgn.grid.dataItem($(selectedItem).closest("tr"));
		
		//팝업내용 조회
		$.ajax({
			async:false,
			url : lfo_workAsgn.ctrlUrl + "/getProdWorkAsgnDetail",
			type: "POST",
			data: {lotId : lfo_workAsgn.gridSelected.lotId, prodAsmId : lfo_workAsgn.gridSelected.prodAsmId},
			success: function(data){
				//팝업 세팅 로드
				gfn_popform_set(lfo_workAsgn, mode, data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});	
	}
}

//Form내용 입력/저장
this.lfn_asgnCreatePop_save = function(savePrmt){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_workAsgn.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		var savePrmt = gfn_serializeObject(lfo_workAsgn.popId+"_form");
		
		$.ajax({
			async:false,
			url : lfo_workAsgn.ctrlUrl + lfo_workAsgn.crud.create.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//이전화면 리로드
					lfo_common.grid.dataSource.read();
					lfo_workAsgn.grid.dataSource.read();
					
					gfn_closePop('jteProdAsgnPop');
					
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
}

//삭제 콜백
this.lfn_asgnCreatePop_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_workAsgn.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_workAsgn.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_workAsgn.ctrlUrl + lfo_workAsgn.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data == "bad"){//에러
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}else if(data == "workBad"){//작업진행중(삭제진행X)
				gfn_warnBox({title : "경고", msg:"작업이 이미 시작되었습니다."});
			}else if(data == "success"){//성공
				lfo_workAsgn.grid.dataSource.read();
				gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//전체 공정 보기 버튼 클릭 (팝업 오픈)
this.lfn_routingSheet_open = function(selectedItem){
	var options = {
		modal:true, 
		width: "1300px", 
		height: "530px", 
		id : "routingSheetPop", 
		title:"작업정보 팝업",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//전체 공정 그리드 세팅
		this.lfn_jteRoutingAll_setGrd(selectedItem);
		
		//그리드가 정상적으로 생성되었다면 show();
		if(gfn_isEmpty(lfo_routingAll.grid)){
			$("#routingSheetPop").show();
		}
	};
	
	this.gfn_winOpen(options);
}

//라우팅 전체 조회 팝업 내부 그리드 세팅
this.lfn_jteRoutingAll_setGrd = function(selectedItem){
	lfo_workAsgn.gridSelectedRout = lfo_workAsgn.grid.dataItem($(selectedItem).closest("tr"));
	
	lfo_routingAll = {};//Form 내부에서 사용될 Object 
	//1.
	lfo_routingAll.layoutId = "routingSheetPop_grid";
	
	//2.
	//lfo_routingAll.popId = "jteProdWorkForm";
	
	//3.
	lfo_routingAll.ctrlUrl = "/cform/mfgMgt/productWork"

	//4.
	lfo_routingAll.crud  = {
		read:{url:"/getProdWorkRoutSheetList", auth:"" ,search : false, paging : false,
			prmt:{ lotId : lfo_workAsgn.gridSelectedRout.lotId, prodAsmId : lfo_workAsgn.gridSelectedRout.prodAsmId}}
	};
	
	//5.
	lfo_routingAll.model = {
			id: "prodWorkId",
			fields: {
				orderId: { type: "string" },
				lotId: { type: "string" },
				lotNm: { type: "string" },
				itemId : { type: "string" },
				itemNm : { type: "string" },
				itemStd01: { type: "int" },
				itemStd02: { type: "int" },
				itemStd03: { type: "int" },
				itemStd04: { type: "int" },
				itemStd05: { type: "int" },
				itemStdStr01: { type: "string" },
				itemStdStr02: { type: "string" },
				itemStdStr03: { type: "string" },
				itemStdStr04: { type: "string" },
				itemStdStr05: { type: "string" },
				prodAsmId: { type: "string" },
				prodAsmNm: { type: "string" },
				prodAsmDate: { type: "date" },
				prodAsmQty: { type: "int" },
				prodAsmDesc: { type: "string" },
				prodAsmUser: { type: "string" },
				prodAsmUserNm: { type: "string" },
				prodAsmEmj: { type: "string" },
				prodAsmState: { type: "string" },
				deptId: { type: "string" },
				deptNm: { type: "string" },
				prodWorkId: { type: "string" },
				routingId: { type: "string" },
				routingSeq : { type: "int" },
				routingType :  { type: "string" },
				bomTarget: { type: "string" },
				mtrlUse : { type: "string" },
				eqmtMgtId: { type: "string" },
				eqmtMgtNm: { type: "string" },
				prodWorkUser: { type: "string" },
				prodWorkUserNm: { type: "string" },
				prodWorkQty: { type: "int" },
				prodWorkGood: { type: "int" },
				prodWorkBad: { type: "int" },
				prodWorkStart: { type: "date" },
				prodWorkEnd: { type: "date" }
			}
		};
	
	//6.
	lfo_routingAll.columns = [
		{field: "routingSeq", title:gfn_getMsg("col_routSeq"), width: "80px"},												//차수
		{field: "routingId", title:gfn_getMsg("col_routCd"), width: "120px"},								//라우팅코드
		{field: "routingType",  template:"# var item = gfn_isNull(gfn_getCode(routingType).cdId)== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
			title:gfn_getMsg("col_routType"), width: "140px"},												//공정유형
		//설비 + 공구 미사용
		{field: "eqmtMgtNm", title : "설비", width: "280px",
				template : "#=eqmtMgtNm# <div style=\"float:right\"><button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_routSheetEqmt_chPopOpen(this);\" style=\"min-width:60px;\">설비변경</button><div>"
				// +"<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_routSheetTool_chPopOpen(this);\" style=\"min-width:60px;\">공구세팅</button></div>"
				},	//설비
//		{field: "placeNm", title : "위치", width: "130px"},													//위치
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "110px"},							//작업자
		{field: "prodWorkStart", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"시작시간", width: 120},
		{field: "prodWorkEnd", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"종료시간", width: 120},
		{field: "prodWorkQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_asmQuan"), width: "95px"},			//지시량
		{field: "prodWorkGood", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:"생산량", width: 95},
		{field: "prodWorkBad", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:"불량량", width: 95},
		{field: "bomTarget", title : "자재", width: 100,
			template:"# var badBtn = '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_mtrlUsePop_Open(this);\" style=\"min-width:60px;\">자재파악</button>' # #= badBtn #" }		
	];
	
	//7.
	lfo_routingAll.selectBox = [/* { text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" }//공구유형 */];
	
	//공통 그리드 세팅 호출 
	lfo_routingAll.grid = gfn_grid_set(lfo_routingAll);
}

//자재파악 팝업 오픈
this.lfn_mtrlUsePop_Open = function(selectedItem){
	var options = {
			modal:true, 
			width: "630px", 
			height: "440px", 
			id : "mtrlUsePop", 
			title: "자재 사용량",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			//부품 불량 리스트 조회 그리드 셋
			lfn_mtrlUsePop_gridSet(selectedItem);
		}

		this.gfn_winOpen(options);	
}

//자재파악 그리드 세팅
this.lfn_mtrlUsePop_gridSet = function(selectedItem){
	
	lfo_routingAll.gridSelected = lfo_routingAll.grid.dataItem($(selectedItem).closest("tr"));
	
	//1.
	lfo_bomMtrl.layoutId = "mtrlUsePop_grid";
	
	//2.
	lfo_bomMtrl.popId = "itemBadSavePop";
	
	//3.
	lfo_bomMtrl.ctrlUrl = "/cform/mfgMgt/productWork"

	//4.
	lfo_bomMtrl.crud  = {
		read:{url:"/getBomMtrlList", auth:"",search : false,paging:false,
			prmt:{
				itemId : lfo_routingAll.gridSelected.itemId,
				prodAsmId : lfo_routingAll.gridSelected.prodAsmId,
				bomTarget : 'prcs_bom02'
			}
		}
	};
	
	lfo_bomMtrl.customTitle = {
		html:'<span class="pop_title">' + "자재목록" + '</span>'
	}
	
	//5.
	lfo_bomMtrl.model = {
		id: "badId",
		fields: {
			bomId : { type: "string" },
			bomTarget : { type: "string" },
			bomTargetId : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlMgtId : { type: "string" },
			mtrlMgtCnt : { type: "int" },
			mtrlQtyTotal : { type: "int" },
			routingId : { type: "string" },
			routingSeq : { type: "int" },
			prodWorkId : { type: "string" },
			prodAsmId : { type: "string" },
			itemId : { type: "string" }
		}
	};
	//6.
	lfo_bomMtrl.columns = [
		{field: "routingSeq", title : "공정", width: "80px"},
		{field: "mtrlNm", title : "자재명", width: "160px"},
		{field: "mtrlMgtCnt", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : "재고량", width: "90px"},
		{field: "mtrlQtyTotal", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : "사용량", width: "90px"},
 		{field: "bomId", title: "정보", width: "190px",								//상세정보
			template : '<button class="k-button k-primary" type="button" onclick = "lfn_mtrlDetailPop_Open(this); " style="min-width:60px;">' + "상세정보" + '</button>'
				+ '<button class="k-button k-primary" type="button" onclick = "lfn_mtrlBadPop_open(\'NEW\',this); " style="min-width:60px;">' + "불량등록" + '</button>'
		},
	];
	
	//공통 그리드 세팅 호출 
	lfo_bomMtrl.grid = gfn_grid_set(lfo_bomMtrl);
}


//자재 사용 상세조회 팝업 오픈
this.lfn_mtrlDetailPop_Open = function(selectedItem){
	var options = {
		modal:true, 
		width: "830px", 
		height: "380px", 
		id : "mtrlDetailPop", 
		title: "자재 사용 상세조회",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//부품 불량 리스트 조회 그리드 셋
		lfn_mtrlDetailPop_gridSet(selectedItem);
	}

	this.gfn_winOpen(options);	
}

//자재 사용 상세조회 팝업 그리드 세팅 
this.lfn_mtrlDetailPop_gridSet = function(selectedItem){
	
	//선택한 행 정보 담기
	lfo_bomMtrl.gridSelected = lfo_bomMtrl.grid.dataItem($(selectedItem).closest("tr"));	
	
	//1.
	lfo_mtrlDetail.layoutId = "mtrlDetailPop_grid";
	
	//2.
	lfo_mtrlDetail.popId = "";
	
	//3.
	lfo_mtrlDetail.ctrlUrl = "/cform/mfgMgt/productWork"

	//4.
	lfo_mtrlDetail.crud  = {
		read:{url:"/getBomMtrlDetail", auth:"",search : false,paging:false,
			prmt:{
				mtrlId : lfo_bomMtrl.gridSelected.bomTargetId,
				prodAsmId : lfo_routingAll.gridSelected.prodAsmId
			}
		}
	};
	
	lfo_mtrlDetail.customTitle = {
		html:'<span class="pop_title">' + "사용목록" + '</span>'
	}
	
	//5.
	lfo_mtrlDetail.model = {
		id: "mtrlQtyTargetCode",
		fields: {
			routingSeq : { type: "int" },
			mtrlQtyTarget : { type: "string" },
			mtrlQtyTargetCode : { type: "string" },
			mtrlQtyTotal : { type: "int" },
			mtrlQtyUser : { type: "string" },
			mtrlQtyUserNm : { type: "string" },
			mtrlQtyDate : { type: "date" },
			mtrlQtyDesc : { type: "string" }
		}
	};
	//6.
	lfo_mtrlDetail.columns = [
		{field: "routingSeq", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : "공정", width: "80px"},
		{field: "mtrlQtyTarget", title : "구분", width: "100px",
			template : "# var qtyTarget = mtrlQtyTarget == 'mtrl_tagt03' ? '불량' : '자재사용' # #= qtyTarget#"},
		{field: "mtrlQtyTotal", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : "수량", width: "80px"},
		{field: "mtrlQtyUserNm", title : "등록자", width: "110px"},
		{field: "mtrlQtyDate", format: "{0: yyyy-MM-dd HH:mm}", title : "날짜", width: "145px"},
		{field: "mtrlQtyDesc", title: "비고", width: "150px"},
		{field: "mtrlQtyTarget", title : "-", width: "90px",
			template : function(rows){
				if(rows.mtrlQtyTarget == 'mtrl_tagt03'){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_mtrlBadPop_open(\'EDT\', this); " style="min-width:60px;">' + "수정" + '</button>';
				}else{
					return '';
				}
			}
		}
	];
	//공통 그리드 세팅 호출 
	lfo_mtrlDetail.grid = gfn_grid_set(lfo_mtrlDetail);
}

//불량등록 팝업 오픈
this.lfn_mtrlBadPop_open = function(mode, selectedItem){
	//불량등록을 위한 객체정보 담기
	lfo_mtrlBad = {
		popId : "mtrlBadPop",
		ctrlUrl : "/cform/mfgMgt/productWork",
		crud : {
			read:{url:"/getMtrlBadInfo"}, 
			//다른 컨트롤러에 있는 서비스를 호출하기 위하여 풀경로 매핑
			create : {url:"/setMtrlBadSave", callback : lfn_mtrlBadPop_save},
			update : {url:"/setMtrlBadSave", callback : lfn_mtrlBadPop_save}
		}
	}
	var options = {
		modal:true, 
		width: "650px",
		height: "351px",
		id : lfo_mtrlBad.popId, 
		title : "불량등록 팝업",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_mtrlBadPop_set(mode, selectedItem);
	};
	
	//팝업 오픈
	this.gfn_winOpen(options);
}

//불량등록 팝업 세팅
this.lfn_mtrlBadPop_set = function(mode, selectedItem){
	if(mode=='NEW'){
		//선택한 행 정보 담기
		lfo_bomMtrl.gridSelected = lfo_bomMtrl.grid.dataItem($(selectedItem).closest("tr"));
		
		var selectedItem = lfo_bomMtrl.gridSelected;
		
		//사용자정보, 시간 자동 세팅
		selectedItem.chkUser = $("#_loginUserId").val();
		selectedItem.chkUserNm = $("#_loginUserName").val();
		selectedItem.chkDate = new Date();
		
		//팝업 세팅 로드
		gfn_popform_set(lfo_mtrlBad, mode, selectedItem);
		
	}else if(mode == 'EDT'){
		
		lfo_mtrlDetail.gridSelected = {};
		//선택한 행 정보 담기
		lfo_mtrlDetail.gridSelected = lfo_mtrlDetail.grid.dataItem($(selectedItem).closest("tr"));
		
		//팝업내용 조회
		$.ajax({
			async:false,
			url : lfo_mtrlBad.ctrlUrl + lfo_mtrlBad.crud.read.url,
			type: "POST",
			data: {badId : lfo_mtrlDetail.gridSelected.mtrlQtyTargetCode},
			success: function(data){
				//팝업 세팅 로드
				gfn_popform_set(lfo_mtrlBad, mode, data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});	
	}
}

//불량정보 저장
this.lfn_mtrlBadPop_save = function(mode){
	
	var savePrmt = gfn_serializeObject(lfo_mtrlBad.popId+"_form");
	savePrmt.badTarget = "qual_spec02";
	savePrmt.badTargetCode = $("#" + lfo_mtrlBad.popId + " [name=prodWorkId]").val();
	
	$.ajax({
		async:false,
		url : lfo_mtrlBad.ctrlUrl + lfo_mtrlBad.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//지시목록 업데이트
				lfo_common.grid.dataSource.read();
				
				lfo_routingAll.grid.dataSource.read();
				
				//자재파악 그리드 리로드
				lfo_bomMtrl.grid.dataSource.read();
				
				//자재사용 상세 그리드 리로드
				if(mode == 'update' ){
					lfo_mtrlDetail.grid.dataSource.read();
				}
				
				//팝업종료
				gfn_closePop(lfo_mtrlBad.popId);
				
				//성공메세지
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}










//설비변경 팝업 오픈
this.lfn_routSheetEqmt_chPopOpen = function(rows){
	var options = {
			modal:true, 
			width: "600px", 
			height: "400px", 
			id : "routEqmtPop", 
			title:"설비변경팝업",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			//전체 공정 그리드 세팅
			this.lfn_routSheetEqmt_setGrd(rows);
		};
		
		this.gfn_winOpen(options);
}

//변경가능한 설비목록 불러옴
this.lfn_routSheetEqmt_setGrd = function(rows){
	lfo_routingAll.gridSelectedEqmt = lfo_routingAll.grid.dataItem($(rows).closest("tr"));

	lfo_routEqmtGrd = {};//Form 내부에서 사용될 Object 
	//1.
	lfo_routEqmtGrd.layoutId = "routEqmtPop_grid";
	
	//2.
	//lfo_routingAll.popId = "jteProdWorkForm";
	
	//3.
	lfo_routEqmtGrd.ctrlUrl = "/cform/mfgMgt/productWork"

	//4.
	lfo_routEqmtGrd.crud  = {
		read:{url:"/getProdWorkEqmtChangeList", auth:"" ,search : false, paging : false,
			prmt:{routingId : lfo_routingAll.gridSelectedEqmt.routingId}}
	};
	
	//5.
	lfo_routEqmtGrd.model = {
			id: "eqmtMgtId",
			fields: {
				eqmtMgtId : { type: "string" },
				eqmtMgtNm: { type: "string" },
				eqmtMgtDesc: { type: "string" },
				placeId: { type: "string" },
				placeNm: { type: "string" },
				compId: { type: "string" },
				compNm: { type: "string" }
			}
	};
	
	//6.
	lfo_routEqmtGrd.columns = [
		{field: "eqmtMgtId", title : "변경", width: "90px",
			template : "<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_routSheetEqmt_chPopSave(this);\" style=\"min-width:60px;\">교체</button>"},	//설비
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: 180},											//설비개별코드
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: 160},											//설비명(상세)
		{field: "placeId", title:gfn_getMsg("col_placeCd"), width: 150},												//위치코드
		{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: 150},												//위치명
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc"), width: 300}												//비고
	
	];
	
	//7.
	lfo_routEqmtGrd.selectBox = [/* { text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" }//공구유형 */];

	//공통 그리드 세팅 호출 
	lfo_routEqmtGrd.grid = gfn_grid_set(lfo_routEqmtGrd);
}

//선택한 설비로 변경 후 그리드 리로드
this.lfn_routSheetEqmt_chPopSave = function(rows){
	var savePrmt = lfo_routEqmtGrd.grid.dataItem($(rows).closest("tr"));
	$.ajax({
		async:false,
		url : lfo_routEqmtGrd.ctrlUrl + "/setProdWorkRoutSheetSave",
		type: "POST",
		data: JSON.stringify({prodWorkId :lfo_routingAll.gridSelectedEqmt.prodWorkId , eqmtMgtId : savePrmt.eqmtMgtId, action : "U"}),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//이전화면 리로드
				lfo_routingAll.grid.dataSource.read();
				
				gfn_closePop('routEqmtPop');
				
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


//공구 세팅 팝업
this.lfn_routSheetTool_chPopOpen = function(rows){
	var options = {
			modal:true, 
			width: "1200px", 
			height: "400px", 
			id : "routToolPop", 
			title:"설비 장착 공구",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			//전체 공정 그리드 세팅
			this.lfn_routSheetTool_setGrd(rows);
		};
		
		this.gfn_winOpen(options);
}

//공구세팅 팝업 그리트 세팅
this.lfn_routSheetTool_setGrd = function(rows){
	lfo_routingAll.gridSelectedTool = lfo_routingAll.grid.dataItem($(rows).closest("tr"));
	
	lfo_routToolGrd = {};//Form 내부에서 사용될 Object 
	//1.
	lfo_routToolGrd.layoutId = "routToolPop_grid";
	
	//2.
	lfo_routToolGrd.popId = "jteToolPosForm";
	
	//3.
	lfo_routToolGrd.ctrlUrl = "/cform/mfgMgt/productWork"
	
	//4.
	lfo_routToolGrd.crud  = {
		read:{url:"/getProdWorkEqmtToolList", auth:"", prmt:{eqmtMgtId: lfo_routingAll.gridSelectedTool.eqmtMgtId, routingId: lfo_routingAll.gridSelectedTool.routingId}
			,paging : false, search : false},
		create : {url:"/setProdWorkEqmtTool", auth:"", openFunc : lfn_jteToolPos_popOpen, callback : lfn_toolPos_save},
		destroy : {url:"/setProdWorkEqmtToolDel", auth:"", callback : lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_routToolGrd.model = {
		id: "toolMgtId",
		fields: {
			routingId : {type: "string"}, 
			toolNo : {type: "int"}, 
			toolId : {type: "string"}, 
			holderId : {type: "string"},
			eqmtMgtId : {type: "string"}, 
			holderEqipId : {type: "string"},
			holderMgtId : {type: "string"},
			holderLimit : {type: "int"},
			holderUse : {type: "int"},
			holderGbn : {type: "string"},
			holderDesc : {type: "string"},
			holderInfo : {type: "string"},
			toolEqipId : {type: "string"},
			toolMgtId : {type: "string"},
			toolLimit : {type: "int"},
			toolUse : {type: "int"},
			toolGbn : {type: "string"},
			toolDesc : {type: "string"},
			toolInfo : {type: "string"}
		}
	};
	
	//6.
	lfo_routToolGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "toolLocation", title : gfn_getMsg("col_mountPosition"), width: "110px"},										//장착위치
		{field: "toolNm", title : gfn_getMsg("col_toolNm"), width: "160px"},													//공구명
		{field: "toolMgtId", title : gfn_getMsg("col_toolIndivCd"), width: "170px"},											//공구개별코드
		{field: "eqipState", title : gfn_getMsg("col_lifeMgt"), width: "150px",
			template : function(e){
				//공구장착상태 값이 없으면 ''처리
				if(gfn_isEmpty(e.eqipState)) return '';
				
				//공구장착상태 기초코드 불러옴
				var eqipState = gfn_getCode(e.eqipState);
				
				//공구장착상태기초코드로 변환하여 출력
				return $("<div>").append($("<span>", {style : "color : " + eqipState.cdReserve01, text : gfn_getMsg('bc_'+eqipState.cdId, eqipState.cdNm) })).html();
			} 
		},
		{field: "eqipState",title : gfn_getMsg("col_lifeMgt"), width: "150px",
			template : function(e){
				
				//장착된 공구가 없거나 장착된 공구가 규격에 맞지 않는 경우 ''처리
				if(gfn_isNull(e.toolMgtId) || e.eqipState != 'eqipState01') return "";
				
				//공구 수명계산
				var stock = Math.ceil((e.toolMgtLimit - e.toolMgtUse)/e.toolCount);
				
				//분기처리
				if(stock > lfo_common.gridSelected.prodWorkQty)return stock +'개 생산가능';
					else return stock+'개 생산후 교체요망';
			}
		},
		{field: "toolMgtLimit", format:"{0:n0}", title : gfn_getMsg("col_useLimit"), width: "110px"},							//사용한도
		{field: "toolMgtUse", format:"{0:n0}", title : gfn_getMsg("col_toolUse"), width: "110px"},								//사용량
		{field: "toolCount", format:"{0:n}", title : gfn_getMsg("col_toolCount"), width: "110px"},								//FEEDRATE
		{field: "toolRpm", format:"{0:n0}", title : gfn_getMsg("col_toolRpm"), width: "110px"},									//RPM
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? toolMgtGbn : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #",
				title : gfn_getMsg("col_toolDiv"), width: "160px"},																//공구구분
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? toolMgtState : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #",
				title : gfn_getMsg("col_toolStatus"), width: "140px"},															//공구상태
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: "180px"},			//입고일
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_verifyPeriod"), width: "140px"},				//검증기간
		{field: "compNm", title : gfn_getMsg("col_compNm"), width: "170px"},													//업체명
		{field: "toolMgtDesc", title : gfn_getMsg("col_desc"), width: "300px"}													//설명
	];
	
	//7.
	lfo_routToolGrd.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_routToolGrd.grid = gfn_grid_set(lfo_routToolGrd);
}


//장착 가능한 공구 조회 팝업
this.lfn_jteToolPos_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "650px", 
		height: "490px", /* 200515 JJW 장착 가능 공구 조회 팝업 높이(&공구조회/교체 추가버튼 팝업) 460-> 490px */
		id : lfo_routToolGrd.popId, 
		title : gfn_getMsg("col_possToolSrh","장착가능공구조회"),			//장착 가능 공구 조회
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){		
		//그리드 세팅
		$("#jteToolPosForm_grid").html();
		lfn_jteToolPos_setGrd();
		
	};
	this.gfn_winOpen(options);	
}

//그리드 - 장착 가능한 공구 조회 그리드 
this.lfn_jteToolPos_setGrd = function(){
	
	lfo_toolPos = {};
	
	//1.
	lfo_toolPos.layoutId = "jteToolPosForm_grid";
	
	//2.
	//lfo_toolPos.popId = "jteToolPosForm";
	
	//3.
	lfo_toolPos.ctrlUrl = "/cform/mfgMgt/productWork"

	//4.
	lfo_toolPos.crud  = {
		read:{url:"/getProdWorkToolUseableList", auth:"", prmt:{routingId : lfo_routingAll.gridSelectedTool.routingId},
			search : false, paging : false}
	};
	
	//5.
	lfo_toolPos.model = {
		id: "toolMgtId",
		fields: {
			routingId: { type: "string" },
			toolType: { type: "string" },
			toolChange: { type: "int" },
			toolId: { type: "string" },
			toolNm: { type: "string" },
			toolNo: { type: "string" },
			toolMgtId: { type: "string" },
 			toolMgtLimit: { type: "int" },
			toolMgtUse: { type: "int" },
			eqmtMgtId:{type: "string"},
			eqmtMgtNm:{type: "string"},
			isDel: {type: "bool"}

// 			creatorId: { type: "string" },
// 			createdAt: { type: "date" },
// 			updatorId: { type: "string" },
// 			updatedAt: { type: "date" },
// 			compId: { type: "string" },
// 			compNm: { type: "string" },
		}
	};
	
	//6.
	lfo_toolPos.columns = [
		{selectable:true , width:"50px"},
		{field: "isDel", template:"# var pos = del == true ? '가능' : '불가' # #= pos #",
			title : "가능여부", width: "110px"},
		{field: "eqmtMgtNm", title : "장착된 설비", width: "120px"},
		{field: "toolNo", title : "장착위치", width: "110px"},//공구구분
		{field: "toolNm", title : "공구명", width: "160px"},
		{field: "toolMgtGbn", template:"# var type = toolType == 'HOLDER' ? '홀더' : toolType == 'TOOL' ? '공구' : '' # #= type #",
			title : gfn_getMsg("col_toolDiv"), width: "110px"},																	
		{field: "toolMgtId", title : "공구개별코드", width: "170px"},
		{field: "toolMgtLimit", format:"{0:n0}", title : gfn_getMsg("col_useLimit"), width: "110px"},							//사용한도
 		{field: "toolMgtUse", format:"{0:n0}", title : gfn_getMsg("col_toolUse"), width: "110px"},								//사용량
		{field: "toolChange", format:"{0:n}", title : "공구카운트", width: "110px"},
 		{field: "toolMgtDesc", title : gfn_getMsg("col_desc"), width: "300px"}													//설명
 		
	];
	
	//7.
	lfo_toolPos.selectBox = [];
	
	
	lfo_toolPos.dataBound = function(e) {
		var grid = this;
		var rows = grid.items();

		$(rows).each(function(e) {
			var row = this;
			var dataItem = grid.dataItem(row);
			if(!dataItem.del){
				$(row).find(".k-checkbox").remove()
			}
		});
	},
	lfo_toolPos.selectable = "multiple, row";
	//공통 그리드 세팅 호출 
	lfo_toolPos.grid = gfn_grid_set(lfo_toolPos);
	
	$("#"+lfo_routToolGrd.popId+" .jte-update").on("click",function(){
		lfn_toolPos_save();
	});
}


//설비에 장착가능한 공구 저장
this.lfn_toolPos_save = function(mode,selectedItem){
	var savePrmt = [];
	var item = {};
	$("#"+ lfo_toolPos.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var rows = lfo_toolPos.grid.dataItem($(this).closest('tr'));
			rows.eqipPosition = rows.toolLocation;
			rows.eqmtMgtId = lfo_routingAll.gridSelectedTool.eqmtMgtId;
			rows.del = false;
			savePrmt.push(rows);
		}
	});
	$.ajax({
		async:false,
		url : lfo_toolPos.ctrlUrl + "/setProdWorkEqmtTool",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//이전 그리드 리로드
				lfo_routToolGrd.grid.dataSource.read();
				//현재팝업 종료
				gfn_closePop(lfo_routToolGrd.popId);
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//설비장착공구  장착해제 콜백- 작업을 시작했다면 사용량 입력 받게 함
this.lfn_jtePopGrd_delete = function(resultObj){
	
	var delPrmt = [];
	$("#"+ lfo_routToolGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delItem = lfo_routToolGrd.grid.dataItem($(this).closest('tr'));
			//장착되지 않은 공구 삭제 에러 예외처리
			if(!gfn_isNull(delItem.eqipId)){
				delPrmt.push(delItem);
			}
		}
	});

	$.ajax({
		async:false,
		url : lfo_routToolGrd.ctrlUrl + lfo_routToolGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_routToolGrd.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}
</script>