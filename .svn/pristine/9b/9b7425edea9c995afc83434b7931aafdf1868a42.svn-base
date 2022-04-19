 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="customBar"></div>
<div id="grid-content" class="productWorkForm productWorkForm-gird" style="width:100%;">
	<!-- 우측 작업지시리스트 -->
	<div id="jteSingleGrid" class="productWorkForm"></div>
</div>

<!-- 라우팅 전체조회 POP(같은 작업지시에 포함된 라우팅만 조회한다.) -->
<div style="display:none;">
	<div id="routingSheetPop" class="routingSheetPop">
	<!-- 라우팅 조회 -->
		<div class="pop_title"><spring:message code = "pop_routingSearch"></spring:message></div>
		<div id="routingSheetPop_grid" class="routingSheetPop_grid" style="height:380px;"></div>
	</div>
</div>

<!-- 작업종료 팝업 -->
<div style="display:none;">
	<div id="jteWorkEndPop">
		<form id="jteWorkEndPop_form" class="productWorkForm jteWorkEndPop_form">	
			<table class="productWorkForm jteWorkEndPop_table">
				<colgroup> <!-- 50 50 -->
					<col class="col-left">
					<col class="col-right">
				</colgroup>
<!-- 				<tr> -->
<!-- 					양품량 -->
<%-- 					<td class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "col_goodProdQuan"></spring:message></td> --%>
<!-- 					<td> -->
<!-- 						<input class="left-input" name="prodAsmGood" format="currency"/> -->
<!-- 						<input type= "hidden" name="prodAsmBad" /> -->
<!-- 						<input type= "hidden" name="prodAsmWorker" /> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				<tr id="endTimeZone">
					<!-- 작업종료 -->
					<td class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "pop_workEnd"></spring:message></td>
					<td>
					<!-- 미입력시 현재시간이 입력됩니다 -->
						<input class="center-input" name="prodWorkEnd" format="datetimepicker" placeholder="<spring:message code = "pop_noEnterCurrentTime"></spring:message>"/>
						<input type= "hidden" name="prodWorkStart" />
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "itemId"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "bomTarget"/>
						<input type="hidden" name = "eqmtMgtId"/>
						<input type="hidden" name = "routingId"/>
						<input type="hidden" name = "action"/>
					</td>
				</tr>
			</table>	
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>									<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>									<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteWorkEndPop');"><spring:message code = "pop_cancel"></spring:message></button>						<!-- 취소 -->
		</div>
	</div>
	</div>
</div>
<!-- 부품 불량 리스트  팝업-->
<div style="display:none;">
	<div id="itemBadListPop" class="productWorkForm itemBadListPop">
		<div id="itemBadListPop_grid" class="itemBadListPop-single-grid" style="width:100%; height:280px; min-height:280px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('itemBadListPop');"><spring:message code = "pop_close"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 부품 불량 등록/확인팝업 -->
<div style="display:none;">
	<div id="itemBadSavePop">
		<form id="itemBadSavePop_form" class="productWorkForm itemBadSavePop_form">
		<!-- 불량품 정보 -->
			<table class="productWorkForm itemBadSavePop_table">
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

<div style="display:none;">
	<div id="pop_selfInspectDct">
	</div>
</div>

<div style="display:none;">
	<div id="pop_selfInspectAnn">
	</div>
</div>
<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/productWork/productWorkForm_JJW.css' rel="stylesheet"/>

<!-- 내부 스타일 외부로 이동_200812 JJW  -->
<script>

var lfo_common = {};// order(LOT)목록 Object 

var lfo_popGrd = {};// 선택한 작업지시 라우팅 Object

var lfo_prodWorkEnd = {}; //작업종료 팝업

var lfo_itemBad = {}; //부품불량 팝업


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//커스텀 검색조건 세팅
	lfn_customSearchBar_set();
	
	//최상위 검색영역 이벤트 바인딩
	$("[name='placeType']").change(function(e){
		lfn_clearLoadGrid();
	});
	
	//최상위 검색영역 이벤트 바인딩
	$("[name='asgnStateList']").change(function(e){
		lfn_clearLoadGrid();
	});
	
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//커스텀 검색조건 세팅
this.lfn_customSearchBar_set = function(){
	
	//사용자정보가져옴(세션에는 추가한 필드가 없다..)
	var userInfo = gfn_ajaxCallByList("user",{userId : $("#_loginUserId").val()});
	
	//초기화
	$("#customBar").html("");
	var customBarHTML = "";
	
	//위치정보 불러오기
	var parentPlaceList = gfn_ajaxCallByList("place",{placeStrStd01 : "ParentWorkLine"});
	customBarHTML += '<span style=" font-weight:600;"><spring:message code = "col_productionLine"></spring:message> : </span>';
	
	//위치정보 선택 박스 만들기
	for(var i in parentPlaceList){
		//작업자  생산라인 기본세팅 설정
		var checkFlag = ''
		
		if(gfn_isNull(userInfo.rows[0].userStrStd01) && i == 0){
			checkFlag = 'checked=\"checked\"';
		}else if(userInfo.rows[0].userStrStd01 == parentPlaceList[i].placeId){
			checkFlag = 'checked=\"checked\"';
		}else if(userInfo.rows[0].userStrStd01 == "ALL"){
			checkFlag = 'checked=\"checked\"';
		}
		
		customBarHTML += '<input type="checkBox" name="placeType" id="'+parentPlaceList[i].placeId+'" ' + checkFlag + ' class="k-checkBox" value="'+parentPlaceList[i].placeId+'" style="margin : 0 5px 0 5px;">';
		customBarHTML += '<label for="'+parentPlaceList[i].placeId+'" style="vertical-align:middle;">' + parentPlaceList[i].placeNm + '</label>';
	}
	
	//작업상태 - 현재 LOT 기준
	customBarHTML += '<span style="margin-left:20px; font-weight:600;"><spring:message code = "col_workStatus"></spring:message> : </span>';
	
	//작업상태 select 만들기
	var asgnStateList = gfn_getCode("prod_sta");
	for(i in asgnStateList){
		var stateCheckFlag = ''
		if(asgnStateList[i].cdReserve01 == 'def'){
			stateCheckFlag = 'checked=\"checked\"';
		}
		customBarHTML += '<input type="checkBox" name="asgnStateList" id="'+asgnStateList[i].cdId+'" ' + stateCheckFlag + ' class="k-checkBox" value="'+asgnStateList[i].cdId+'" style="margin : 0 5px 0 5px;">';
		customBarHTML += '<label for="'+asgnStateList[i].cdId+'" style="vertical-align:middle;">' +  gfn_getMsg("bc_"+asgnStateList[i].cdId) + '</label>';
	}
	
	$("#customBar").html(customBarHTML);
}

//custombar 변경 이벤트
this.lfn_clearLoadGrid = function(){
	lfo_common.grid.dataSource.read();
}

//메인 그리드 생성
this.lfn_jteSgGrd_setGrd = function(rows){
	
	//작업지시 그리드 초기화
	$("#jteDoubleGrid").html("");
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "routingSheetPop";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mfgMgt/productWork";

	//4.
	lfo_common.crud  = {
		read:{url:"/getProdWorkAsgnList", auth:"", prmt:{},dynamicMultiPrmt : {placeType :"placeType", asgnStateList : "asgnStateList"}
		, search : false, paging:false},
		//create : {url:"/setProdWorkAsgnSave", auth : "", openFunc : lfn_asgnCreatePop_open, callback : lfn_asgnCreatePop_save},
		//update : {url:"/setProdWorkAsgnSave", auth : "", openFunc : lfn_asgnCreatePop_open, callback : lfn_asgnCreatePop_save}
		//,destroy : {url:"/setProdWorkAsgnDelete", auth : "", callback : lfn_asgnCreatePop_delete}
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html:'<span class="pop_title"> <spring:message code = "col_orderlist"></spring:message> </span>'
	}
	
	//5.
	lfo_common.model = {
		id: "prodAsmId",
		fields: {
			orderId : { type: "string" }, 
			orderNm : { type: "string" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			itemStdStr01 : { type: "string" },
			itemStdStr02 : { type: "string" },
			lotQty : { type: "int" },
			prodAsmId : { type: "string" },
			prodAsmNm : { type: "string" },
			prodAsmDate : { type: "date" },
			prodAsmQty : { type: "int" },
			prodAsmDesc : { type: "string" },
			prodAsmUser : { type: "string" },
			prodAsmUserNm : { type: "string" },
			prodAsmGood : { type: "float" },
			prodAsmBad : { type: "float" },
			prodAsmWorker : { type: "string" },
			prodAsmWorkerNm : { type: "string" },
			prodAsmEmj : { type: "string" },
			prodAsmState : { type: "string" },
			callAsmModDt : { type: "string" },
			callAsmGood : { type: "int" },
			callAsmBad : { type: "int" },
			callAsmFinDt : { type: "string" },
			placeId : { type: "string" },
			placeNm : { type: "string" },
			placeParent : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			deptId : { type: "string" },
			deptNm : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "prodAsmId", title: gfn_getMsg("pop_workInfo"), width: 325,
			template:'<button class="k-button k-primary" type = "button" onclick = "lfn_routingSheet_open(this)" style="min-width:60px;"><spring:message code = "col_workHistory"></spring:message></button>'+
				'<button class="k-button k-primary" type = "button" onclick = "lfn_cycleCheck_open(this)" style="min-width:60px;"><spring:message code = "col_selfInspection"></spring:message></button>'
				+ '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_itemBadListPop_Open(this);\" style=\"min-width:60px;\"><spring:message code = "col_badRegist"></spring:message></button>'},
		{field: "prodWorkState", title : gfn_getMsg("col_work"), width:160,
			template: function(dateItem){
				var saveAreaHtml = ''; 
				if(dateItem.prodAsmState == 'prod_wait'){//작업대기
					saveAreaHtml = '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_workPop_Open(this,\'START\');\" style=\"min-width:60px;\"><spring:message code = "col_start"></spring:message></button>';//작업시작 버튼
				}else if(dateItem.prodAsmState == 'prod_process'){//작업진행중
					//중지 
					saveAreaHtml = '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_workPop_Open(this,\'STOP\');\" style=\"min-width:60px;\"><spring:message code = "col_stop"></spring:message></button>';
					//작업왑료
					saveAreaHtml +='<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_workPop_Open(this,\'END\');\" style=\"min-width:60px;\"><spring:message code = "col_end"></spring:message></button>';
				}else if(dateItem.prodAsmState == 'prod_stop'){//작업중지
					saveAreaHtml = '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_workPop_Open(this,\'RE\');\" style=\"min-width:60px;\"><spring:message code = "col_restart"></spring:message></button>';//작업 재시작 버튼
				}else if(dateItem.prodAsmState == 'prod_end'){//작업완료
					saveAreaHtml = gfn_getMsg("col_workComplete"); //작업완료 text
				}
				return saveAreaHtml;
			}},
		{field: "prodAsmState", template:"# var item = gfn_isNull(gfn_getCode(prodAsmState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmState).cdId , gfn_getCode(prodAsmState).cdNm) # #= item #", 
			title : gfn_getMsg("col_state"), width: "125px"},			//상태
		{field: "placeNm", title : gfn_getMsg("col_productionLine"), width: "140px"},							//생산라인
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "200px;"},									//부품명
		{field: "itemStdStr01", title:gfn_getMsg("col_partSpecification"), width: "175px;"},				//부품규격
		{field: "prodAsmQty", format:"{0:n0}", title : gfn_getMsg("col_asmQuan"), width: "120px"},		//지시량
// 		{field: "prodAsmGood", format:"{0:n0}", title : gfn_getMsg("col_goodProdQuan"), width: "100px"},		//양품량
		{field: "callAsmGood", format:"{0:n0}", title : gfn_getMsg("col_goodProdQuan"), width: "120px"},
		{field: "prodAsmBad", format:"{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "120px"},		//불량량
		{field: "prodAsmEmj", template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #", 
			title : gfn_getMsg("col_prodEmj"), width: "150px"},		//긴급여부
		{field: "prodAsmNm", title : gfn_getMsg("col_orderName"), width: "200px"},		//지시명
		{field: "prodAsmDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_orderDate"), width: "140px"},		//지시일
		{field: "prodAsmUserNm", title : gfn_getMsg("col_orderUser"), width: "132px"},		//지시자
		{field: "prodAsmWorkerNm", title : gfn_getMsg("col_worker"), width: "132px"}					//작업자

	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	//custombar 로인한 화면 재조정
	$("#grid-content " + "#"+lfo_common.layoutId).resize();
	
	//생산량 갱신을 위해 1분마다 그리드 load
	setInterval(function(){lfo_common.grid.dataSource.read();}, 60 * 1000);
}

//라우팅시트 팝업 오픈 (팝업 오픈)
this.lfn_routingSheet_open = function(selectedItem){
	var options = {
		modal:true, 
		width: "950px", 
		height: "420px", 
		id : lfo_common.popId, 
		title:gfn_getMsg("pop_routingSheet"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//라우팅 시트 그리드 세팅
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
	lfo_common.gridSelectedRout = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
	
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
			prmt:{ lotId : lfo_common.gridSelectedRout.lotId, prodAsmId : lfo_common.gridSelectedRout.prodAsmId}}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		//update:{url:"", auth:"", openFunc : lfn_jteSgGrid_dblclick, callback:""}
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
				prodWorkEnd: { type: "date" },
				prodWorkState: { type: "string" }
			}
		};
	
	//6.
	lfo_routingAll.columns = [
		{field: "routingSeq", title:gfn_getMsg("col_routSeq"), width: "80px"},												//차수
//		{field: "routingId", title:gfn_getMsg("col_routCd"), width: "120px"},								//라우팅코드
		{field: "routingType",  template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
			title:gfn_getMsg("col_routType"), width: "130px"},												//공정유형
		{field: "eqmtMgtNm", title : gfn_getMsg("eqmt_mgt_nm"), width: "130px"},	//설비
		{field: "placeNm", title : gfn_getMsg("col_place"), width: "130px"},													//위치
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "100px"},							//작업자
		{field: "prodWorkStart", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_startTime"), width: 180},
		{field: "prodWorkEnd", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_endTime"), width: 180}
// 		{field: "prodWorkQty", format:"{0:n0}", title:gfn_getMsg("col_asmQuan"), width: "95px"},			//지시량
// 		{field: "prodWorkGood", format:"{0:n0}", title:gfn_getMsg("col_productionQuan"), width: 90},
// 		{field: "prodWorkBad", format:"{0:n0}", title:gfn_getMsg("col_badProdQuan"), width: 90},
/* 		{field: "bomTarget", title : "자재", width: 100,
			template:"# var mtrlBtn = bomTarget == 'SUCCESS' ? " +
			"'<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_mtrlUseTotalPop_Open(this);\" style=\"min-width:60px;\">자재투입</button>' : '' # #= mtrlBtn #" },
		{field: "bomTarget", title : "불량", width: 100,
			template:"# var badBtn = '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_itemBadListPop_Open(this);\" style=\"min-width:60px;\">불량등록</button>' # #= badBtn #" } */
			

		//설비지정, 공구지정, 자재지정
		//{field: "prodAsmState", title:"상태", width: 100},
		//{field: "deptNm", title:"부서명", width: 120},
 		//{field: "prodAsmId", title:"생산지시코드", width: 150},
 		//{field: "prodAsmNm", title:"생산지시명", width: 150},
 		//{field: "itemNm", title:"생산품", width: 150},
 		//{field: "prodAsmEmj",template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #",title:"긴급여부", width: 100},
 		//{field: "prodWorkId", title:"작업정보코드", width: 120},
		//{field: "prodAsmDesc", title:"생산지시 비고", width: 300}
		//{field: "prodWorkGood", format:"{0:n0}", title:"생산량", width: 120},
		//{field: "prodWorkBad", format:"{0:n0}", title:"불량량", width: 120},
		
	];
	
	//7.
	lfo_routingAll.selectBox = [/* { text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" }//공구유형 */];
	
	//공통 그리드 세팅 호출 
	lfo_routingAll.grid = gfn_grid_set(lfo_routingAll);
}

this.lfn_workPop_Open = function(rows, stat){
	var savePrmt = lfo_common.grid.dataItem($(rows).closest("tr"));
	savePrmt.prodAsmDate = gfn_getDate(savePrmt.prodAsmDate,'yyyy-MM-dd');
	savePrmt.prodAsmWorker = $("#_loginUserId").val();

	var msg = '';
	var svaeUrl = '';
	
	if(stat == 'START'){
		msg = '작업을 시작하시겠습니까?';
		svaeUrl = '/setProdWorkRoutSheetStart';
		savePrmt.prodWorkStart = gfn_getDate(new Date,'yyyy-MM-dd HH:mm:ss');
		savePrmt.prodAsmState = 'prod_process';
		
	}else if(stat == 'RE'){
		msg = '작업을 재시작하시겠습니까?';
		svaeUrl = '/setProdWorkRoutSheetStart';
		savePrmt.prodAsmState = "prod_process";
		
	}else if(stat == 'STOP'){
		msg = '작업을 중지하시겠습니까?';
		svaeUrl = '/setProdWorkRoutSheetEnd';
		savePrmt.prodAsmState = 'prod_stop';
		
	}else if(stat == 'END'){
		msg = '작업을 종료하시겠습니까?';
		svaeUrl = '/setProdWorkRoutSheetEnd';
		savePrmt.prodWorkEnd = gfn_getDate(new Date,'yyyy-MM-dd HH:mm:ss');
		savePrmt.prodAsmState = 'prod_end';
	}
	
	gfn_conBox({"msg" : msg, yes : function(){
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + svaeUrl,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//이전화면 리로드
					lfo_common.grid.dataSource.read();
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		
	}});
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
	lfo_common.gridSelectedItemBad = lfo_common.grid.dataItem($(rows).closest("tr"));
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
				badTargetCode : lfo_common.gridSelectedItemBad.prodAsmId,
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
		html : '<span class="pop_title">'+''+gfn_getMsg("pop_badStatus")+' : ' + lfo_common.gridSelectedItemBad.itemNm + '</span>'			//불량현황
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
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_itemBadSavePop_Open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'},
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
		width: "620px", // 200515 JJW 585->590 -> 620
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
				prodAsmId : lfo_common.gridSelectedItemBad.prodAsmId,
				itemId : lfo_common.gridSelectedItemBad.itemId,
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
					data.rows[0].prodAsmId = lfo_common.gridSelectedItemBad.prodAsmId;
					
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
	savePrmt.lotId = lfo_common.gridSelectedItemBad.lotId;
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
				
				lfo_common.grid.dataSource.read();
				
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

//자주검사 팝업 오픈
this.lfn_cycleCheck_open = function(rows){
	var selectedItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var inspectMode = "";
	if(selectedItem.placeNm.indexOf("DCT") != -1) {
		inspectMode = "selfInspectDct";
	} else if(selectedItem.placeNm.indexOf("ANN") != -1) {
		inspectMode = "selfInspectAnn";
	}
	gfn_inspectPop("NEW", inspectMode, "pop_" + inspectMode, selectedItem.lotId);
}

</script>