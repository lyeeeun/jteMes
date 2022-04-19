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
			<table style="width:100%;" id="jteProdAsgnPop_master">
			<colgroup>
				<col class="pop-col-left-title">
				<col class="pop-col-left-content">
				<col class="pop-col-right-title">
				<col class="pop-col-right-content">
			</colgroup>
				<tr>
				<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td>
						<input type="text" id="itemNm" class="left-input" name="itemNm" readonly />
						<input type="hidden" id="itemId" name="itemId"/>
					</td>
					<!-- 긴급여부 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_prodEmj"></spring:message> : </td>
					<td>
						<input name="prodAsmEmj" id="prodAsmEmj" class="right-input" format="selBox" msg="prod_emj"/>
					</td>
				</tr>
				<tr>
				<!-- 작업지시명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderNm"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="prodAsmNm" name="prodAsmNm" class="center-input"/>
						<input type="hidden" name="prodAsmId"/>
					</td>
				</tr>
				<tr>
				<!-- 지시량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_asmQuan"></spring:message> : </td>
					<td><input id="prodAsmQty" class="left-input" name="prodAsmQty" format="currency"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_orderDate"></spring:message> : </td>
					<td><input id="prodAsmDate" class="right-input" name="prodAsmDate" format="datepicker"/></td>
				</tr>
				<!-- 설비라인 -->
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_facilityLine"></spring:message> : </td>
					<td colspan="3">
						<input id="placeId" class="center-input" name="placeId" format = "selBox" custom="true" keyGbn="placeId" keyText="placeNm" func="lfn_placeParent_get()" />
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="prodAsmDesc" class="center-input" name="prodAsmDesc" format="text"/></td>
				</tr>
				<!--미사용주석처리 -->
				<tr style="display:none;">
				<!-- 부서명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_deptNm"></spring:message> : </td>
					<td>
						<input id="deptNm" class="left-input btn-input" name="deptNm" format="text" readonly/>
						<input type="hidden" name="deptId" id="deptId"/>
					</td>
					<td>
				<!-- 조회 -->
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_deptInfoPop_Open(lfn_deptInfoPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				<!-- 작업지시자 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderUser"></spring:message> : <i class="fas fa-info-circle" title="미설정시 지정된 부서의 팀장에게 발송됩니다." style="background:yellow;"></i></td>
					<td>
						<input id="prodAsmUserNm" class="right-input btn-input" name="prodAsmUserNm" format="text" readonly/>
						<input type="hidden" name="prodAsmUser" id="prodAsmUser"/>
					</td>
					<td>
				<!-- 조회 -->
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
					<!-- 작업상태 -->
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "prodAsmState"/>
						<input type="hidden" name = "prodWorkState"/>
						<input type="hidden" name = "itemStdStr01"/>
						<input type="hidden" name = "itemStdStr02"/>
						<input type="hidden" name="use"/>
						<input type="hidden" name="action"/>
					</td>
				</tr>
			</table>
		</form>
		
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>				<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>				<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteProdAsgnPop');"><spring:message code = "pop_cancel"></spring:message></button>		<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 라우팅 전체조회 POP(같은 작업지시에 포함된 라우팅만 조회한다.) -->
<div style="display:none;">
	<div id="routingSheetPop" class="routingSheetPop">
		<div class="pop_title"><spring:message code = "pop_routingSearch"></spring:message></div>
		<div id="routingSheetPop_grid" class="routingSheetPop_grid" style="height:430px;"></div>
	</div>
</div>

<!-- 자재투입 마스터 -->
<div style="display:none;">
	<div id="mtrlUseTotalPop" class="mtrlUseTotalPop">
		<div class="pop_title"><spring:message code = "pop_mtrlInput"></spring:message></div>
		<div id="mtrlUseTotal_grid" class="mtrlUseTotal-single-grid" style="width: 100%; height: 180px;"></div>
	</div>
</div>

<!-- 자재투입 상세 팝업-->
<div style="display:none;">
	<div id="mtrlUseDetailPop" class="wrkinWrkerMgtForm mtrlUseDetailPop">
		<div id="mtrlUseDetail_grid" class="mtrlUseDetailPop-top-grid" style="width:100%; height:300px; min-height:300px;"></div>
	</div>
</div>

<!-- 자재투입 등록/조회 팝업 -->
<div style="display:none;">
	<div id="mtrlUseSavePop">
		<form id="mtrlUseSavePop_form" class="productWorkAdminForm mtrlUseSavePop_form">
			<table class="mtrlUseSavePop_table">
				<colgroup> <!-- 20 80 -->
					<col class="popsc-col-left-title">
					<col class="popsc-col-left-content">
					<col class="popsc-col-right-content">
				</colgroup>
				<!-- 자재투입정보 -->
				<div class="pop_title"><spring:message code = "pop_mtrlInputInfo"></spring:message></div>
				<tr>
					<!-- 자재명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm"></spring:message> : </td>
					<td>
					<!-- 조회버튼을 눌러 등록해주세요 -->
						<input type="text" class="left-input btn-input" name="mtrlNm" placeholder = "<spring:message code = "pop_clickButtonInput"></spring:message>" readonly/>
						<input type="hidden"  name="mtrlMgtId" />
						<input type="hidden"  name="mtrlId" />
					</td>
					<td>
						<!-- 조회 -->
						<button class="k-button k-primary search-btn" type="button" id="mtrlUseDetailSaveBtn" style="display:none;">
						<spring:message code = "btn_search"></spring:message></button>
					</td>
				</tr>
<%-- 				<tr>
					<!-- 자재구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlDiv"></spring:message> : </td>
					<td colspan="2">
						<input id="mtrlDiv" name="mtrlDiv" class="center-input" format="text" readonly/>
					</td>
				</tr> --%>
				<tr style="display:none;">
					<!-- 투입량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inputQuan"></spring:message> : </td>
					<td colspan="2">
						<input  name="mtrlUseInput" class="center-input" format="currency"/>
					</td>
				</tr>
				<tr>
					<!-- 사용량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_useQuan"></spring:message>: </td>
					<td colspan="2">
						<input  name="mtrlUseCnt" class="center-input" format="currency"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "mtrlUseId"/>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "prodWorkStart"/>
						<input type="hidden" name = "prodWorkEnd"/>
						<input type="hidden" name = "prodWorkUser"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name = "prodPlanId"/>
						<input type="hidden" name = "action"/>
						<input type="hidden" name = "use"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button"><spring:message code = "pop_mtrlInput"></spring:message></button>											<!-- 자재투입 -->
			<button class="k-button k-primary jte-update final-btn" type="button"><spring:message code = "pop_inputQuanChange"></spring:message></button>									<!-- 투입량변경 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('mtrlUseSavePop');"><spring:message code = "pop_close"></spring:message></button>			<!-- 닫기 -->
		</div>
	</div>
</div>


<!-- 부품 불량 리스트  팝업-->
<div style="display:none;">
	<div id="itemBadListPop" class="productWorkAdminForm itemBadListPop">
		<div id="itemBadListPop_grid" class="itemBadListPop-single-grid" style="width:100%; height:280px; min-height:280px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('itemBadListPop');"><spring:message code = "pop_close"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 부품 불량 등록/확인팝업 -->
<div style="display:none;">
	<div id="itemBadSavePop">
		<form id="itemBadSavePop_form" class="productWorkAdminForm itemBadSavePop_form">
		<!-- 불량품 정보 -->
			<table class="itemBadSavePop_table">
			<colgroup> <!-- 17 33 17 33 -->
				<col class="poptr-col-left-title">
				<col class="poptr-col-left-content">
				<col class="poptr-col-right-title">
				<col class="poptr-col-right-content">
			</colgroup>
				<!-- 불량품정보 -->
				<div class="pop_title"><spring:message code = "pop_badInfo"></spring:message></div> <!-- tr을 div로 변경 -->
				<tr>
				<!-- 불량아이디 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badId"></spring:message> : 
					</td>
					<td colspan="3"><input type="text" id="badId" class="center-input" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : 
					</td>
					<td><input id="badCode" class="left-input" name="badCode"  format = "selBox" msg="qual_ITEMCUT"/></td> <!-- style="width: 95%; max-width:95%; " -->
				<!-- 수량 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_quantity"></spring:message> : 
					</td>
					<td><input id="badQty" class="right-input" name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input id="chkUserNm" class="left-input" name="chkUserNm" format="text"/>
						<input type="hidden" name="chkUser" id="chkUser"/>
<!--  						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)"> -->
<!-- 	 						조회 -->
<%-- 	 						<spring:message code="btn_search" /> --%>
<!--  						</button> -->
					</td>
				<!-- 검사일 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right left-caret"></i><spring:message code = "col_inspectDate"></spring:message> : 
					</td>
					<td><input id="chkDate" class="right-input" name="chkDate" format="datepicker"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : 
					</td>
					<td colspan="3">
						<input id="badDesc" class="center-input" name="badDesc"/>
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
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('itemBadSavePop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/mfgMgt/productWorkAdmin/productWorkAdminForm_JJW.css' rel="stylesheet">
<!-- 내부 스타일 외부로 이동_200819.200827 JJW -->


<script>

var lfo_common = {};// order(LOT)목록 Object 

var lfo_workAsgn = {};// 작업지시 목록 Object

var lfo_popGrd = {};// 선택한 작업지시 라우팅 Object

var lfo_routEqmtGrd = {};//라우팅시트 설비 Object

var lfo_routToolGrd = {};//라우팅시트 공구 Object

var lfo_routBadGrd = {};//라우팅시트 불량체크 Object


var lfo_mtrlUseTotal = {}; //자재투입현황 - 종합

var lfo_mtrlUseDetail = {}; //자재투입현황 - 상세

var lfo_itemBad = {}; //부품 - 불량

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
		read:{url:"/getProductWorkLotList", auth:"", prmt:{}}
	};
	
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
				itemStdStr01 : { type: "string" },
				itemStdStr02 : { type: "string" },
				cliamId : { type: "string" },
				orderId : { type: "string" },
				itemNm: { type: "string" },
				itemDeduction: { type: "int" },
				itemStdStr01: { type: "string" },
				itemStdStr02: { type: "string" },
				placeNm: { type: "string" },
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
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_jteDbGrid_gridSet(this);" style="min-width:60px;"><spring:message code = "col_orderlist"></spring:message></button>',
		title : gfn_getMsg("col_detail"), width: 100},									//수정
		//{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},				//Lot코드
		{template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "150px;"},		//수주명
		{field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "150px;"},				//Lot명
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "150px;"},				//부품명
		{field: "itemStdStr01", title:gfn_getMsg("col_partSpecification"), width: "150px;"},				//부품규격
		{field: "placeNm", title:gfn_getMsg("col_productionLine"), width: "100px;"},				//생산라인
		{field: "lotQty", title : gfn_getMsg("col_oredQuan"), width: "90px;"},				//Lot수량
		{field: "compNm", title : gfn_getMsg("col_compNm"), width: "120px;"},				//업체명
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "120px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "120px"},			//납기일
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
			title:gfn_getMsg("col_orderStatus"), width: "120px;"},					//수주상태
		{field: "lotPmNm", title:gfn_getMsg("col_manager"), width: "120px;"}			//담당자
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_orderNm"), value: "lot.lot_nm" },
		{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm"},
		{ text: gfn_getMsg("col_orderCd"), value: "orInfo.order_id" },			//수주코드
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },			//담당자
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" }			//업체명
	];
	
	//8.
	lfo_common.validation ={}
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
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
		update : {url:"/setProdWorkAsgnSave", auth : "", callback : lfn_asgnCreatePop_save}
		//,destroy : {url:"/setProdWorkAsgnDelete", auth : "", callback : lfn_asgnCreatePop_delete}
	};
	
	//커스텀 타이틀
	lfo_workAsgn.customTitle = {
		html:'<span class="pop_title">'+gfn_getMsg("col_orderlist")+'</span>'
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
			prodAsmGood : { type: "float" },
			prodAsmBad : { type: "float" },
			prodAsmUserNm : { type: "string" },
			prodAsmWorkerNm : { type: "string" },
			prodAsmEmj : { type: "string" },
			prodAsmState : { type: "string" },
			callAsmModDt : { type: "string" },
			callAsmGood : { type: "int" },
			callAsmBad : { type: "int" },
			callAsmFinDt : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			deptId : { type: "string" },
			deptNm : { type: "string" },
			placeId : { type: "string" },
			placeNm : { type: "string" }
		}
	};
	
	//6.
	lfo_workAsgn.columns = [
		{field: "prodAsmId", title: gfn_getMsg("col_routingsheet"), width: "270px",
			template:'<button class="k-button k-primary" type = "button" onclick = "lfn_routingSheet_open(this)" style="width:60px;">'+gfn_getMsg("col_searchSheet")+'</button>' 
					+ '<button class="k-button k-primary" type = "button" onclick = "lfn_asgnCreatePop_open(\'EDT\', this); " style="width:40px;">'+gfn_getMsg("col_update")+'</button>'
					+ '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_itemBadListPop_Open(this);\" style=\"min-width:60px;\">'+gfn_getMsg("col_badRegist")+'</button>'},
		{field: "prodAsmNm", title : gfn_getMsg("col_orderName"), width: "150px"},		//지시명
		{field: "prodAsmDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_orderDate"), width: "120px"},		//지시일
		{field: "prodAsmQty", format:"{0:n0}", title : gfn_getMsg("col_asmQuan"), width: "100px"},		//지시량
		{field: "callAsmGood", format:"{0:n0}", title : gfn_getMsg("col_goodProdQuan"), width: "100px"},		//양품량
		{field: "prodAsmBad", format:"{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "100px"},		//불량량
		{field: "prodAsmWorkerNm", title : gfn_getMsg("col_worker"), width: "100px"},		//작업자	
		{field: "placeNm", title : gfn_getMsg("col_productionLine"), width: "100px"},				//생산라인
		{field: "prodAsmEmj", template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #", 
			title : gfn_getMsg("col_prodEmj"), width: "110px"},		//긴급여부
		{field: "prodAsmState", template:"# var item = gfn_isNull(gfn_getCode(prodAsmState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmState).cdId , gfn_getCode(prodAsmState).cdNm) # #= item #", 
			title : gfn_getMsg("col_state"), width: "110px"}		//상태
	];
	
	//공통 그리드 세팅 호출 
	lfo_workAsgn.grid = gfn_grid_set(lfo_workAsgn);
}


//생산지시 팝업
this.lfn_asgnCreatePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "560px", /* 200520 JJW 550 -> 560 */
		height: "370px", /* 201020 JJW 265 -> 370 */
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
			lotId : lfo_common.gridSelected.lotId,
			itemStdStr02 : lfo_common.gridSelected.itemStdStr02
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
				$("#" + lfo_workAsgn.popId + " [name = prodAsmState]").val("prod_wait");
				$("#" + lfo_workAsgn.popId + " [name = prodWorkState]").val("prod_wait");
				$("#" + lfo_workAsgn.popId + " [name = placeNm]").val("");
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

//전체 공정 보기 버튼 클릭 (팝업 오픈)
this.lfn_routingSheet_open = function(selectedItem){
	var options = {
		modal:true, 
		width: "1300px", 
		height: "470px", 
		id : "routingSheetPop", 
		title:gfn_getMsg("pop_routingSheet"),
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
				itemDeduction: { type: "int" },
				itemDayTarget: { type: "int" },
				itemTotalStock: { type: "int" },
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
				itemUnit: { type: "string" },
				itemMtrl: { type: "string" },
				prodAsmId: { type: "string" },
				prodAsmNm: { type: "string" },
				prodAsmDate: { type: "date" },
				prodAsmQty: { type: "int" },
				prodAsmDesc: { type: "string" },
				prodAsmUser: { type: "string" },
				prodAsmUserNm: { type: "string" },
				prodAsmWorkerNm : { type: "string" },
				prodAsmEmj : { type: "string" },
				prodAsmState : { type: "string" },
				callAsmModDt : { type: "string" },
				callAsmGood : { type: "int" },
				callAsmBad : { type: "int" },
				callAsmFinDt : { type: "string" },
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
		{field: "routingType",  template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
			title:gfn_getMsg("col_routType"), width: "140px"},												//공정유형
		{field: "eqmtMgtNm", title : gfn_getMsg("eqmt_mgt_nm"), width: "140px"},							//설비
		{field: "placeNm", title : gfn_getMsg("col_place"), width: "130px"},								//위치
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "110px"},							//작업자
		{field: "prodWorkStart", format:"{0: yyyy-MM-dd hh:mm:ss}", title:gfn_getMsg("col_startTime"), width: 120},
		{field: "prodWorkEnd", format:"{0: yyyy-MM-dd hh:mm:ss}", title:gfn_getMsg("col_endTime"), width: 120},
		{field: "prodWorkQty", format:"{0:n0}", title:gfn_getMsg("col_asmQuan"), width: "95px"},			//지시량
		{field: "prodWorkGood", format:"{0:n0}", title:gfn_getMsg("col_productionQuan"), width: 95},		//생산량
		{field: "prodWorkBad", format:"{0:n0}", title:gfn_getMsg("col_badProdQuan"), width: 95},			//불량량
		{field: "mtrlUse", title : gfn_getMsg("pop_material"), width: 100,
			template:"# var mtrlBtn = mtrlUse == 'SUCCESS' ? " +
			"'<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_mtrlUseTotalPop_Open(this);\" style=\"min-width:60px;\"><spring:message code = "pop_mtrlInput"></spring:message></button>' : '' # #= mtrlBtn #" }	//자재투입
	];
	
	//7.
	lfo_routingAll.selectBox = [/* { text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" }//공구유형 */];
	
	//공통 그리드 세팅 호출 
	lfo_routingAll.grid = gfn_grid_set(lfo_routingAll);
}

//자재투입 팝업
this.lfn_mtrlUseTotalPop_Open = function(rows){
	var options = {
			modal:true, 
			width: "700px", 
			height: "290px", //200518 JJW 자재재고파악 팝업 높이 390 -> 430
			id : "mtrlUseTotalPop", 
			title:gfn_getMsg("pop_mtrlStockConfirm"),			//자재 재고확인
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			lfo_workAsgn.gridSelectedMtrl = lfo_routingAll.grid.dataItem($(rows).closest("tr"));
			
			//그리드 그리기
			lfn_mtrlUseTotal_gridSet();		
		};
		this.gfn_winOpen(options);	
}


//투입현황 토탈 그리드 세팅
this.lfn_mtrlUseTotal_gridSet = function(){
	
	//1.
	lfo_mtrlUseTotal.layoutId = "mtrlUseTotal_grid";
	
	//2.
	lfo_mtrlUseTotal.popId = "mtrlUseDetailPop";
	
	//3.
	lfo_mtrlUseTotal.ctrlUrl = "/cform/mfgMgt/wrkinWrkerMgt"

	//4.
	lfo_mtrlUseTotal.crud  = {
		read:{url:"/getMtrlUseList", auth:"", prmt:{prodWorkId : lfo_workAsgn.gridSelectedMtrl.prodWorkId, action : "TOTAL"}
		, search : false, paging:false}, 
	};
	
	//커스텀 타이틀
	lfo_mtrlUseTotal.customTitle = {
		html:'<span class="pop_title">' + gfn_getMsg("pop_mtrlInputStatus") + '</span>'			//자재 퉁비 현황
	}
	
	//5.
	lfo_mtrlUseTotal.model = {
		id: "mtrlUseId",
		fields: {
			prodWorkId : { type: "string" },
			bomId : { type: "string" },
			mtrlId : { type: "string" },
			description : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlType : { type: "string" },
			mtrlHCD : { type: "string" },
			mtrlStd01 : { type: "int" },
			mtrlStd02 : { type: "int" },
			mtrlStd03 : { type: "int" },
			mtrlStd04 : { type: "string" },
			mtrlStd05  : { type: "int" },
			mtrlUseday  : { type: "int" },
			mtrlCost  : { type: "int" },
			isUse   : { type: "bool" },
			mtrlDesc : { type: "string" },
			mtrlQual  : { type: "string" },
			mtrlUnit : { type: "string" },
			mtrlUseId : { type: "string" },
			mtrlUseInput : { type: "int" },
			mtrlUseCnt : { type: "int" },
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtCnt : { type: "int" },
			mtrlMgtDesc : { type: "string" },
			badId : { type: "string" },
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badDesc : { type: "string" }
		}
	};
	
	//6.
	lfo_mtrlUseTotal.columns = [
		{field: "mtrlUseId", title: gfn_getMsg("col_detailInfo"), width: "120px",									//상세정보
		template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseDetailPop_open(this)" style="width:60px;">'+"투입/조회"+'</button>'},
		//{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},										//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},											//자재명
		//{field: "mtrlUseInput", format: "{0:n0}", title : gfn_getMsg("col_totalInputQty"), width: "140px"},			//총투입량
		{field: "mtrlUseCnt", format:"{0:n0}", title : gfn_getMsg("col_totalUseQty"), width: "140px"},				//총사용량
		//{field: "badQty", format:"{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},					//불량량
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlType"), width: "140px"},													//자재유형
		/* {field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlHCD"), width: "110px"},														//HCD구분
		{field: "mtrlStd01", format: "{0:n}", title : gfn_getMsg("col_width"), width: "110px"},						//소재Φ
		{field: "mtrlStd02", format: "{0:n}", title : gfn_getMsg("col_mainHall"), width: "110px"},					//본당기장
		{field: "mtrlStd03", format: "{0:n}", title : gfn_getMsg("col_weight"), width: "110px"},					//무게
		{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
			title:gfn_getMsg("col_unit"), width: "110px"},															//단위 */
		{field: "description", title : gfn_getMsg("col_desc"), width: "250px"}										//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_mtrlUseTotal.grid = gfn_grid_set(lfo_mtrlUseTotal);
}

//투입현황 상세 조회/등록 팝업 오픈
this.lfn_mtrlUseDetailPop_open = function(target){
	var options = {
		modal:true, 
		width: "900px", 
		height: "340px", /* 200515 JJW 330 -> 340 */
		id : lfo_mtrlUseTotal.popId, 
		title:gfn_getMsg("pop_mtrlInputDetailStatus"),			//자재투입 상세현황
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		$("#"+lfo_mtrlUseTotal.popId).show();
		//선택값 저장
		lfo_mtrlUseTotal.gridSelected = lfo_mtrlUseTotal.grid.dataItem($(target).closest("tr"));
		
		//자재 투입 현황 그리드 세팅(DETAIL)
		lfn_mtrlUseDetail_gridSet();
	};
	this.gfn_winOpen(options);	
}

//자재 투입 현황 그리드 세팅(DETAIL)
this.lfn_mtrlUseDetail_gridSet = function(){
	//초기화
	lfo_mtrlUseDetail = {};
	
	//1.
	lfo_mtrlUseDetail.layoutId = "mtrlUseDetail_grid";
	
	//2.
	lfo_mtrlUseDetail.popId = "mtrlUseSavePop";
	
	//3.
	lfo_mtrlUseDetail.ctrlUrl = "/cform/mfgMgt/productWork"

	//4.
	lfo_mtrlUseDetail.crud  = {
		read:{url:"/getProdWorkMtrl", auth:"", prmt:{prodWorkId : lfo_workAsgn.gridSelectedMtrl.prodWorkId, mtrlId :lfo_mtrlUseTotal.gridSelected.mtrlId , action : "DETAIL"}
		, search : false, paging:false},
		create : {url:"/setProdWorkMtrlSave", openFunc : lfn_mtrlUseSavePop_open, callback : lfn_mtrlUseSavePop_save},
		update : {url:"/setProdWorkMtrlSave", callback : lfn_mtrlUseSavePop_save}
	};
	
	//커스텀 타이틀
	lfo_mtrlUseDetail.customTitle = {
		html:'<span class="pop_title">'+gfn_getMsg("pop_mtrlInputStatus")+'</span>'			//자재투입현황
	}
	
	//5.
	lfo_mtrlUseDetail.model = {
		id: "mtrlUseId",
		fields: {
			prodWorkId : { type: "string" },
			bomId : { type: "string" },
			mtrlId : { type: "string" },
			description : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlDiv : { type: "string" },
			mtrlType : { type: "string" },
			mtrlHCD : { type: "string" },
			mtrlStd01 : { type: "int" },
			mtrlStd02 : { type: "int" },
			mtrlStd03 : { type: "int" },
			mtrlStd04 : { type: "string" },
			mtrlStd05  : { type: "int" },
			mtrlUseday  : { type: "int" },
			mtrlCost  : { type: "int" },
			isUse   : { type: "bool" },
			mtrlDesc : { type: "string" },
			mtrlQual  : { type: "string" },
			mtrlUnit : { type: "string" },
			mtrlUseId : { type: "string" },
			mtrlUseInput : { type: "int" },
			mtrlUseCnt : { type: "int" },
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtCnt : { type: "int" },
			mtrlMgtDesc : { type: "string" },
			badId : { type: "string" },
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badDesc : { type: "string" }
		}
	};
	
	//6.
	lfo_mtrlUseDetail.columns = [
		{field: "mtrlUseId", title: gfn_getMsg("col_detailInfo"), width: "90px",												//상세정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_mtrlUseSavePop_open(\'EDT\',this); " style="min-width:60px;"><spring:message code = "btn_update"></spring:message></button>'},
		//{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},													//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "120px"},														//자재명
		{field: "mtrlMgtId", title:gfn_getMsg("col_mtrlIndivCd"), width: "170px"},												//자재개별코드
		//{field: "mtrlUseInput", format: "{0:n0}", title : gfn_getMsg("col_inputQuan"), width: "110px"},							//투입량
		{field: "mtrlUseCnt", format:"{0:n0}", title : gfn_getMsg("col_useQuan"), width: "110px"},								//사용량
		//{field: "badQty", format:"{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},								//불량량
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlType"), width: "140px"},																//자재유형
		/* {field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #", 
			title : gfn_getMsg("col_mtrlHCD"), width: "110px"},																	//HCD구분
		{field: "mtrlStd01", format: "{0:n}", title : gfn_getMsg("col_width"), width: "110px"},									//소재Φ
		{field: "mtrlStd02", format: "{0:n}", title : gfn_getMsg("col_mainHall"), width: "110px"},								//본당기장
		{field: "mtrlStd03", format: "{0:n}", title : gfn_getMsg("col_weight"), width: "110px"},								//무게
		{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
			title:gfn_getMsg("col_unit"), width: "110px"},																		//단위 */
		{field: "mtrlMgtPurchase", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: "120px"},			//입고일
		{field: "mtrlMgtCnt", format: "{0:n0}", title : gfn_getMsg("col_stockQty"), width: "110px"},							//재고량
		{field: "mtrlMgtDesc", title : gfn_getMsg("col_desc"), width: "250px"}													//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_mtrlUseDetail.grid = gfn_grid_set(lfo_mtrlUseDetail);
}

//자재투입 등록 팝업
this.lfn_mtrlUseSavePop_open = function(mode,target){
	var options = {
		modal:true, 
		width: "500px", //200515 JJW 350->500
		height: "310px", // 201020 JJW 250-> 310
		id : lfo_mtrlUseDetail.popId, 
		title:gfn_getMsg("pop_mtrlInput"),			//자재투입
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode=='NEW'){
			selectedItem = {
				prodWorkId : lfo_mtrlUseTotal.gridSelected.prodWorkId,
				mtrlId : lfo_mtrlUseTotal.gridSelected.mtrlId ,
				mtrlUseId : lfo_mtrlUseTotal.gridSelected.mtrlUseId
			}
			
			//팝업 세팅
			gfn_popform_set(lfo_mtrlUseDetail, mode,selectedItem);
			//조회버튼 이벤트 생성
			$("#mtrlUseDetailSaveBtn").on("click",function(){
				lfn_openMtrlMgtUse();
			});
			$("#mtrlUseDetailSaveBtn").show();
			
		}else if(mode == 'EDT'){
			//선택 값 가져오기
			var dataItem = lfo_mtrlUseDetail.grid.dataItem($(target).closest("tr"));
			
			//저장된 정보 불러오기
			$.ajax({
				async:false,
				url : lfo_mtrlUseDetail.ctrlUrl + lfo_mtrlUseDetail.crud.read.url,
				type: "POST",
				data: {
					prodWorkId : dataItem.prodWorkId,
					mtrlId : dataItem.mtrlId ,
					mtrlMgtId : dataItem.mtrlMgtId,
					mtrlUseId : dataItem.mtrlUseId,
					action :"DETAIL"
				},success: function(data){
					gfn_popform_set(lfo_mtrlUseDetail, mode,data.rows[0]);
				},error : function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
				}
			});
			$("#mtrlUseDetailSaveBtn").hide();
		}
	};
	this.gfn_winOpen(options);	
}

//자재투입 등록 팝업 - 자재관리 조회
this.lfn_openMtrlMgtUse = function(){
	//검색조건
	var searchPrmt ={
		mtrlId : $("#"+lfo_mtrlUseDetail.popId+"_form [name=mtrlId]").val(),
		isDel:false
	}
	
	//공통 자재관리 조회 팝업 호출
	gfn_openCustomPop('materialMgt',lfn_mtrlMgtPop_callback,searchPrmt);
	
	
}

//자재투입 등록 팝업 - 자재관리 콜백
this.lfn_mtrlMgtPop_callback = function(dataItem){
	$("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlNm]").val(dataItem.mtrlNm);
	$("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlMgtId]").val(dataItem.mtrlMgtId);
	$("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlId]").val(dataItem.mtrlId);
	// $("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlDiv]").val(dataItem.mtrlDiv);
	$("#"+lfo_mtrlUseDetail.popId+"_form [name = mtrlUseInput]").data("kendoNumericTextBox").value(dataItem.mtrlMgtCnt);
}

//자재투입 등록 팝업 - 등록/수정
this.lfn_mtrlUseSavePop_save = function(mode){
	
	var savePrmt = gfn_serializeObject(lfo_mtrlUseDetail.popId+"_form");
	
	$.ajax({
		async:false,
		url : lfo_mtrlUseDetail.ctrlUrl + lfo_mtrlUseDetail.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
			
				//작업종료 팝업 - 자재투입현황(TOTAL) 리로드
				lfo_mtrlUseTotal.grid.dataSource.read();
				
				//자재투입 상세현황 - 자재투입현황(DETAIL) 리로드
				lfo_mtrlUseDetail.grid.dataSource.read();
				
				//현재팝업 종료
				gfn_closePop(lfo_mtrlUseDetail.popId);
				
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

//폼묵 불량 조회 팝업 조회
this.lfn_itemBadListPop_Open = function(rows){
	var options = {
			modal:true, 
			width: "650px", 
			height: "350px", 
			id : "itemBadListPop", 
			title:gfn_getMsg("pop_itemBadSrh"),			//부품불량조회
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			//부품 불량 리스트 조회 그리드 셋
			lfn_itemBadListPop_gridSet(rows);
		}

		this.gfn_winOpen(options);	
}

//부품 불량  --  그리드 세팅
this.lfn_itemBadListPop_gridSet = function(rows){
	lfo_workAsgn.gridSelectedItemBad = lfo_workAsgn.grid.dataItem($(rows).closest("tr"));
	//1.
	lfo_itemBad.layoutId = "itemBadListPop_grid";
	
	//2.
	lfo_itemBad.popId = "itemBadSavePop";
	
	//3.
	lfo_itemBad.ctrlUrl = "/cform/mfgMgt/productWork"

	//4.
	lfo_itemBad.crud  = {
		read:{url:"/getProdWorkItemBadList",
			auth:"",
			prmt:{
				badTarget : 'qual_spec03',
				badTargetCode : lfo_workAsgn.gridSelectedItemBad.prodAsmId,
			},
			search : false,
			paging:false
		},
		//다른 컨트롤러에 있는 서비스를 호출하기 위하여 풀경로 매핑
		create : {url:"/setProdWorkItemBadSave", openFunc : lfn_itemBadSavePop_Open, callback : lfn_itemBadSavePop_Save},
		update : {url:"/setProdWorkItemBadSave", callback : lfn_itemBadSavePop_Save}
	};
	
	
	//커스텀 타이틀
	lfo_itemBad.customTitle = {
		html : '<span class="pop_title">'+''+gfn_getMsg("pop_badStatus")+' : ' + lfo_common.gridSelected.itemNm + '</span>'			//불량현황
	}
	
	//5.
	lfo_itemBad.model = {
		id: "badId",
		fields: {
			badId : { type: "string" },
			lotId : { type: "string" },	
			badCode : { type: "string" },
			badQty : { type: "string" },
			chkUser : { type: "string" },
			chkUserNm : { type: "string" },
			chkDate : { type: "string" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badTargetNm : { type: "string" },
			badDesc : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			badPgUser : { type: "string" },
			badPgUserNm : { type: "string" },
			badPgDate : { type: "string" }
		}
	};
	//6.
	lfo_itemBad.columns = [
		{field: "lotId", title: gfn_getMsg("col_detailInfo"), width: "120px",								//상세정보
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_itemBadSavePop_Open(\'EDT\',this); " style="min-width:60px;"><spring:message code = "btn_update"></spring:message></button>'},
		{field: "badId", title:gfn_getMsg("col_badId"), width: "170px"},									//불량아이디
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "220px"},											//불량원인
		{field: "badQty", format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "110px"},			//불량량
		{field: "badDesc", title : gfn_getMsg("col_desc"), width: "250px"}									//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_itemBad.grid = gfn_grid_set(lfo_itemBad);

}
//부품 불량팝업
this.lfn_itemBadSavePop_Open = function(mode,target){
	//선택 값 가져오기
	var options = {
		modal:true, 
		width: "590px", // 200515 JJW 585->590
		height: "340px", /* 200515 JJW 285->340 */
		id : lfo_itemBad.popId, 
		title:gfn_getMsg("pop_itemBadRegist"),			//부품불량 등록
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode=='NEW'){
			var selectedItem = {
				prodAsmId : lfo_workAsgn.gridSelectedItemBad.prodAsmId,
				itemId : lfo_workAsgn.gridSelectedItemBad.itemId,
				chkUser : $("#_loginUserId").val(),
				chkUserNm : $("#_loginUserName").val(),
				chkDate : new Date()
			} 
			
			//팝업 세팅
			gfn_popform_set(lfo_itemBad, mode,selectedItem);
			
		}else if(mode == 'EDT'){
			var dataItem = lfo_itemBad.grid.dataItem($(target).closest("tr"));
			
			//저장된 정보 불러오기
			$.ajax({
				async:false,
				url : lfo_itemBad.ctrlUrl + lfo_itemBad.crud.read.url,
				type: "POST",
				data: {
					prodAsgnId : dataItem.prodAsmId,
					badId : dataItem.badId
				},success: function(data){
					//조회결과에 prodWorkId없어서 직접매핑
					data.rows[0].prodAsmId = lfo_workAsgn.gridSelectedItemBad.prodAsmId;
					
					gfn_popform_set(lfo_itemBad, mode,data.rows[0]);
				},error : function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
				}
			});
		}
	};
	this.gfn_winOpen(options);	
}

//부품 불량 - 저장/수정
this.lfn_itemBadSavePop_Save = function(mode){
	var savePrmt = gfn_serializeObject(lfo_itemBad.popId+"_form");
	console.log(savePrmt);
	savePrmt.badTarget = "qual_spec03";
	savePrmt.badTargetCode = savePrmt.prodAsmId;
	savePrmt.lotId = lfo_common.gridSelected.lotId;
	$.ajax({
		async:false,
		url : lfo_itemBad.ctrlUrl + lfo_itemBad.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				
				lfo_workAsgn.grid.dataSource.read();
				
				//부품불량 현항(BAD) 리로드
				lfo_itemBad.grid.dataSource.read();
				
				//현재팝업 종료
				gfn_closePop(lfo_itemBad.popId);
				
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

this.lfn_placeParent_get = function(){
	return gfn_ajaxCallByList("place",{placeStrStd01 : "workLine", placeParent : lfo_workAsgn.gridSelected.itemStdStr02});
}

</script>