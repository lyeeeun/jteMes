<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content"  style="width:100%;">
	<div id="jteSingleGrid" style="width:height:100%;"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="facilCorMgtForm popfr-facilCorMgtForm">
		<!-- 설비관리정보 -->
			<div class="pop_title"><spring:message code = "pop_eqmtMgtInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
			<colgroup> <!-- 200511 원래는 col 4개에 각각 width 13 27 13 27_LYM -->
				<col class="col-left-title">
				<col class="col-left-content-1">
				<col class="col-left-content-2">
				<col class="col-right-title">
				<col class="col-right-content-1">
				<col class="col-right-content-2">
			</colgroup>
				<tr>
				<!-- 설비개별코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtIndivCd"></spring:message> : </td>
					<td colspan="2"><input type="text" id="eqmtMgtId" class="left-input" name="eqmtMgtId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 설비명(상세) -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_eqmtDetailNm"></spring:message> : </td>
					<td>
						<input type="text" id="eqmtMgtNm" class="right-input btn-input" name="eqmtMgtNm"/>
					</td>
					<td>
						<button class="k-button k-primary jte-msgBox" type="button" prefix = "eqmgt" defId="eqmtMgtId" defNm="eqmtMgtNm" >
				<!-- 다국어 -->
						<spring:message code = "pop_msgLang"></spring:message></button>
						<input type="hidden" id="msg_eqmtMgtId" />
					</td>
				</tr>
				<tr>
				<!-- 등록일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate"></spring:message> : </td>
					<td><input id="eqmtMgtPurchase" class="left-input" name="eqmtMgtPurchase" format="datepicker" required /></td>
				<!-- 검증기간 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_verifyPeriod"></spring:message>
				<!-- 값을 입력하지 않으면 등록된 정비주기로 계산됩니다. -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_noValEnter"></spring:message></button>" ></i>   <!-- style="background:yellow;" -->
					</td>
					<td colspan="2"><input id="eqmtMgtVerif" class="right-input" name="eqmtMgtVerif" format="datepicker"/></td>
				</tr>
				<tr>
				<!-- 위치코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_placeCd"></spring:message> : </td>
					<td colspan="4">
						<input type="text" id="placeId" class="center-input btn-input" name="placeId" readonly/>
						<input type="hidden" id="placeNm" class="center-input btn-input" name="placeNm" />
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="gfn_openCustomPopTree('place',lfn_placePop_callback);" >
				<!-- 조회 -->
						<spring:message code = "btn_search"></spring:message></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
				<!-- 설명 -->
					<td colspan="5"><input type="text" id="eqmtMgtDesc" name="eqmtMgtDesc" class="k-textbox center-input" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="eqmtMaintenance" id="eqmtMaintenance"/>
						<input type="hidden" name="eqmtId" id="eqmtId"/>
						<input type="hidden" name="use" id="eqmtMgtUse"/>
						<input type="hidden" name="action" id="eqmtMgtAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 정비이력 POP -->
<div style="display:none;">
	<div id="jtePopEqmtMtnc" style="height:100%">
	<!-- 정비이력 -->
		<div class="pop_title"><spring:message code = "pop_mtncHis"></spring:message></div>
		<div id="jtePopEqmtMtnc_grid" style="height:350px;"></div>
	</div>
</div>
<!-- 정비이력 등록/수정 팝업(서브 그리드 > 정비이력 버튼 클릭) -->
<div style="display:none;">
	<div id="jtePopEqmtAdd">
		<form id="jtePopEqmtAdd_form" class="facilCorMgtForm popsc-facilCorMgtForm">
		<!-- 정비내역 -->
			<div class="pop_title"><spring:message code = "pop_mtncList"></spring:message></div>
			<table style="width:100%;" id="jtePopEqmtAdd_master" class="jtePopEqmtAdd_master">
			<colgroup> <!-- 200511 원래는 col 4개에 각각 width 15 25 15 25_LYM -->
				<col class="popsc-col-left-title">
				<col class="popsc-col-left-content-1">
				<col class="popsc-col-left-content-2">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content-1">
				<col class="popsc-col-right-content-2">
			</colgroup>
				<tr>
				<!-- 설비정비코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtMtnc"></spring:message> : </td>
					<td colspan=5><input type="text" id="eqmtMtncId" class="center-input" name="eqmtMtncId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly /></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 정비시작일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtncStartDate"></spring:message> : </td>
					<td colspan="2"><input id="eqmtMtncStart" class="left-input" name="eqmtMtncStart" format="datepicker" /></td>
				<!-- 정비종료일 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_mtncEndDate"></spring:message> 
				<!-- 최초 등록시 검증기간이 자동 변경됩니다. (종료일 + 정비주기) -->
						<i class="fas fa-info-circle" title="<spring:message code = "pop_periodAutoChange"></spring:message>" ></i>  : </td>   <!-- style="background:yellow;" -->
					<td colspan="2"><input id="eqmtMtncEnd" class="right-input" name="eqmtMtncEnd" format="datepicker" /></td>
				</tr>
				<tr>
				<!-- 관리자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager"></spring:message> : </td>
					<td>
						<input type="text" id="eqmtMtncUserNm" class="left-input btn-input" name="eqmtMtncUserNm" readonly />
						<input type="hidden" id="eqmtMtncUser" class="left-input btn-input" name="eqmtMtncUser" />
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="gfn_openCustomPop('userInfo',lfn_userPop_callback);" >
				<!-- 조회 -->
						<spring:message code = "btn_search"></spring:message></button>
					</td>
				<!-- 금액 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_cost"></spring:message> : </td>
					<td colspan="2">
						<input id="eqmtMtncCost" class="right-input" name="eqmtMtncCost" format="currency" />
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="5">
						<input type="text" id="eqmtMtncDesc" name="eqmtMtncDesc" class="k-textbox center-input" />
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="eqmtId" id="parentEqmtId"/>
						<input type="hidden" name="eqmtMgtId" id="parentEqmtMgtId"/>
						<input type="hidden" name="eqmtMaintenance" id="parentEqmtMaintenance"/>
						<input type="hidden" name="use" id="eqmtMtncUse"/>
						<input type="hidden" name="action" id="eqmtMtncAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopEqmtAdd');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 가동시간 POP -->
<div style="display:none;">
	<div id="jtePopEqmtWork" style="height:100%;">
	<!-- 설비 종합 -->
		<div class="pop_title"><spring:message code = "pop_totalEqmt"></spring:message></div>
		<table class="eqmtOverall">
			<colgroup>
				<col style="width:50%;"/>
				<col style="width:50%;"/>
			</colgroup>
			<tr>
				<td>
				<!-- 설비 총 가동시간 -->
					<i class="fas fa-caret-right"></i><spring:message code = "col_totalEqmtUp"></spring:message> : <label name="runTime"></label>
				</td>
				<td>
				<!-- 설비종합효윺 -->
					<i class="fas fa-caret-right left-caret"></i><spring:message code ="col_totalEqmtEffect"></spring:message> : <label name="eqmtPercent"></label>
				</td>
			</tr>
		</table>
	<!-- 가동시간 -->
		<div class="pop_title"><spring:message code = "pop_operTime"></spring:message></div>
		<div id="jtePopEqmtWork_grid" style="height:235px"></div>
	</div>
</div>


<!-- 이윤민 주임 작업 CSS -->
<!--  <link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_lym.css' rel="stylesheet">  -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200428 LYM  -->


<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_eqmtMtncGrd = {};//정비이력 Object

var lfo_eqmtWorkGrd = {};//가동시간 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//서브 그리드 세팅
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
	lfo_common.ctrlUrl = "/form/basMgt/operMgt/facilMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getEqmtMgtList", auth:"", prmt:{}}, 
// 		create:{url:"/setEqmtMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
//		update:{url:"/setEqmtMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
// 		destroy:{url:"/setEqmtMgtDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "eqmtMgtId",
		fields: {
			eqmtMgtId : { type: "string" },
			eqmtMgtGbn : { type: "string" },
			eqmtMgtMtnc : { type: "int" },
			eqmtMgtNm : { type: "string" },
			eqmtMgtPurchase : { type: "date" },
			eqmtMgtVerif : { type: "date" },
			eqmtMgtDesc : { type: "string" },
			eqmtMgtFile : { type: "string" },
			isUse : { type: "bool" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" },
			placeId : { type: "string" },
			placeNm : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: "130px"},											//설비명
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: "160px"},											//설비개별코드
		{field: "eqmtMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(eqmtMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(eqmtMgtGbn).cdId , gfn_getCode(eqmtMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_eqmtDiv"), width: "130px;"},																//설비구분
		{field: "eqmtMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "110px"},			//입고일
		{field: "eqmtMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: "110px"},			//검증기간
		{field: "eqmtMgtMtnc", format: "{0:n0}", title:gfn_getMsg("col_mtnc"), width: "110px"},								//정비주기
		/* {field: "eqmtMgtFile", title:gfn_getMsg("col_attachment"), width: "90px"},											//첨부파일 */
		{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: "130px"},												//위치명
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "150px"},													//업체명
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc"), width: "280px"},												//설명
		//이력 Column 320px .. 정비이력, 가동시간 Column 140px
		{ field: "eqmtMgtId", title: gfn_getMsg("col_history"), width: "200px",																									//이력
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_eqmtMtncPop(this) " style="width:60px;">'+gfn_getMsg("pop_mtncHis")+'</button>'			//정비이력
				+'<button class="k-button k-primary" type="button" onclick = "lfn_eqmtWorkPop(this) " style="width:60px;">'+gfn_getMsg("pop_operTime")+'</button>'				//가동시간
			},
	];
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_eqmtDetailNm"), value: "eqmtMgt.eqmt_mgt_nm" },			//설비명
		{ text: gfn_getMsg("col_eqmtIndivCd"), value: "eqmtMgt.eqmt_mgt_id" },			//설비개별코드
		{ text: gfn_getMsg("col_placeNm"), value: "place.place_nm" },					//위치명
		{ text: gfn_getMsg("col_desc"), value: "eqmtMgt.eqmt_mgt_desc" }				//설명
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//정비이력 버튼 클릭(팝업 오픈)
this.lfn_eqmtMtncPop = function(target){
	var options = {
		modal:true, 
		width: "800px", 
		height: "390px", //200519 JJW 400-> 390
		id : "jtePopEqmtMtnc", 
		title:gfn_getMsg("pop_eqmtMtncHis"),			//설비 정비이력
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	
	//선택한 항목의 ID 가져옴
	lfo_common.gridSelected = { 
			eqmtId : dataItem.eqmtId, 
			eqmtMgtId:dataItem.eqmtMgtId, 
			eqmtMaintenance : dataItem.eqmtMaintenance,
			use : dataItem.use
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteEqmtMtnc_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}

//정비이력 그리드 세팅
this.lfn_jteEqmtMtnc_setGrd = function(dataItem){
	lfo_eqmtMtncGrd = {};//Form 내부에서 사용될 Object
	
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
	lfo_eqmtMtncGrd.layoutId = "jtePopEqmtMtnc_grid";
	
	//2.
	lfo_eqmtMtncGrd.popId = "jtePopEqmtAdd";
	
	//3.
	lfo_eqmtMtncGrd.ctrlUrl = "/form/facilMgt/facilCorMgt";
	
	//4.
	lfo_eqmtMtncGrd.crud  = {
		read:{url:"/getEqmtMtncList", auth:"", prmt:{eqmtMgtId : dataItem.eqmtMgtId}}, 
		create:{url:"/setEqmtMtncSave", auth:"", openFunc : lfn_eqmtMtncPop_open, callback : lfn_eqmtMtncPopSave}, 
		update:{url:"/setEqmtMtncSave", auth:"", openFunc : lfn_eqmtMtncPop_open, callback : lfn_eqmtMtncPopSave}, 
		destroy:{url:"/setEqmtMtncDelete", auth:"", callback : lfn_eqmtMtncPopDelete}
	};
	
	//5.
	lfo_eqmtMtncGrd.model = {
		id: "eqmtMtncId",
		fields: {
			eqmtMtncId : { type: "string" },
			eqmtMtncStart : { type: "date" },
			eqmtMtncEnd : { type: "date" },
			eqmtMtncUser : { type: "string" },
			eqmtMtncCost : { type: "int" },
			eqmtMtncDesc : { type: "string" },
			creatorId	 : { type: "string" },
			createdAt : { type: "date" },
			updatorId : { type: "string" },
			updatedAt : { type: "date" },
			eqmtMgtId : { type: "string" },
			eqmtMtncUserNm : {type: "string"}
		}
	};
	
	//6.
	lfo_eqmtMtncGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "eqmtMtncId", title:gfn_getMsg("col_eqmtMtnc"), width: "160px"},											//설비정비코드
		{field: "eqmtMtncStart", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncStartDate"), width: "120px"},			//정비시작일
		{field: "eqmtMtncEnd", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncEndDate"), width: "120px"},				//정비종료일
		{field: "eqmtMtncCost", format:"{0:n0}", title:gfn_getMsg("col_cost"), width: "100px"},								//금액
		{field: "eqmtMtncUserNm", title:gfn_getMsg("col_manager"), width: "130px"},											//관리자
		{field: "eqmtMtncDesc", title:gfn_getMsg("col_desc"), width: "250px"}												//설명
	];
	//7.
	lfo_eqmtMtncGrd.selectBox = [
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },			//관리자 
		{ text: gfn_getMsg("col_eqmtMtnc"), value: "eqmtMtnc.eqmt_mtnc_id" },			//설비정비코드
		{ text: gfn_getMsg("col_desc"), value: "eqmtMtnc.eqmt_mtnc_desc" }				//설명
	];
	
	//8.
	lfo_eqmtMtncGrd.validation ={
		eqmtMtncStart:{
			messages : "정비시작일을 등록하세요",
			rules : function(input){
				if(input.is("[name=eqmtMtncStart]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		eqmtMtncEnd:{
			messages : "정비종료일을 등록하세요",
			rules : function(input){
				if(input.is("[name=eqmtMtncEnd]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		eqmtMtncUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=eqmtMtncUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 담당자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	
	//공통 그리드 세팅 호출 
	lfo_eqmtMtncGrd.grid = gfn_grid_set(lfo_eqmtMtncGrd);
}
//정비이력 등록/수정 팝업 호출
this.lfn_eqmtMtncPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px",  //설비현황 그리드 우측 정비이력 버튼 클릭 > 추가 클릭 시의 팝업 width 변경_LYM 600->700px
		//height 260px
		height: "347px", //설비현황 그리드 우측 정비이력 버튼 클릭 > 추가 클릭 시의 팝업 height 변경_LYM 230->327px 200811 youmi 327->347px
		id:lfo_eqmtMtncGrd.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtncRegist");			//정비내역 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtncListSrh");			//정비내역 조회
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_eqmtMtncPop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//정비이력 등록/수정 팝업 내용 세팅
this.lfn_eqmtMtncPop_set = function(mode,selectedItem){
	lfo_eqmtMtncGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = lfo_common.gridSelected;
		gfn_popform_set(lfo_eqmtMtncGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_eqmtMtncGrd.gridSelected = selectedItem["eqmtMgtId"];
		}else if(typeof(selectedItem) == "string"){
			lfo_eqmtMtncGrd.gridSelected = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_eqmtMtncGrd.ctrlUrl + lfo_eqmtMtncGrd.crud.read.url,
			type: "POST",
			data: {eqmtMgtId:lfo_eqmtMtncGrd.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_eqmtMtncGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//유저정보 팝업 콜백
this.lfn_userPop_callback = function(callbackObj){
	$("[name='eqmtMtncUser']").val(callbackObj.userId);
	$("[name='eqmtMtncUserNm']").val(callbackObj.userNm);
}

//Form내용 입력/저장
this.lfn_eqmtMtncPopSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_eqmtMtncGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_eqmtMtncGrd.popId+"_form").serializeObject();
		
		$.ajax({
			async:false,
			url : lfo_eqmtMtncGrd.ctrlUrl + lfo_eqmtMtncGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					
					//lfn_jtePop_set('EDT',data);
					//설비 정비이력 그리드 리로드
					lfo_eqmtMtncGrd.grid.dataSource.read();
					//설비상세 그리드 리로드
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_eqmtMtncGrd.popId);
					
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
this.lfn_eqmtMtncPopDelete = function(){
	var delPrmt = [];
	$("#"+ lfo_eqmtMtncGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_eqmtMtncGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_eqmtMtncGrd.ctrlUrl + lfo_eqmtMtncGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			//설비정비코드 삭제 후 리로드
			lfo_eqmtMtncGrd.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}


//가동시간 버튼 클릭(팝업오픈)
this.lfn_eqmtWorkPop = function(target){
	var options = {
		modal:true, 
		width: "630px", 
		height: "420px",
		id : "jtePopEqmtWork", 
		title:gfn_getMsg("pop_eqmtOperTime"),			//설비 가동시간
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//가동시간 팝업 세팅
		lfn_jteEqmtWork_setGrd(dataItem);
		
		//검색할게 업어서 하이드 처리
		//$("#jtePopEqmtWork").find(".jte-search-aria").hide();
	};
	
	this.gfn_winOpen(options);
}

//가동시간 그리드 세팅
this.lfn_jteEqmtWork_setGrd = function(dataItem){
	lfo_eqmtWorkGrd = {eqmtMgtId : dataItem.eqmtMgtId};//Form 내부에서 사용될 Object 
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
	lfo_eqmtWorkGrd.layoutId = "jtePopEqmtWork_grid";
	
	//2.
	//lfo_eqmtWorkGrd.popId = "jtePopForm";
	
	//3.
	lfo_eqmtWorkGrd.ctrlUrl = "/form/facilMgt/facilCorMgt";
	
	//4.
	lfo_eqmtWorkGrd.crud  = {
		read:{url:"/getEqmtWorkList", auth:"", search:false, paging:false, prmt:{eqmtMgtId : dataItem.eqmtMgtId}, dynamicPrmt:{eqmtWorkStart:"hidEqmtWorkStart"}},
		excel:{url:"" ,auth:"", fileName: "설비사용 이력_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
	};
	
	lfo_eqmtWorkGrd.customTitle = {html:"<input id='eqmtWorkStart' name='eqmtWorkStart' />"+
										"<input type='hidden' id='hidEqmtWorkStart' name='hidEqmtWorkStart'>"
			, callback : lfn_jteWorkDate_set};
	
	//5.
	lfo_eqmtWorkGrd.model = {
		id: "eqmtMgtId",
		fields: {
			eqmtMgtId : { type: "string" },
			eqmtWorkStart: { type: "date" },
			eqmtWorkEnd: { type: "date" }
		}
	};
	
	//6.
	lfo_eqmtWorkGrd.columns = [
		{field: "eqmtWorkStart", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_eqmtWrkStart"), width: 120},			//설비가동시작
		{field: "eqmtWorkEnd", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_eqmtWrkEnd"), width: 120}				//설비가동종료
	];
	//7.

	
	//공통 그리드 세팅 호출 
	lfo_eqmtWorkGrd.grid = gfn_grid_set(lfo_eqmtWorkGrd);
}

//해당날짜의 작업정보를 조회하기 위한 date 세팅
this.lfn_jteWorkDate_set = function(){
	//초기 오늘 데이터를 매핑
	if($("#eqmtWorkStart").attr("data-role") != "datepicker"){
		$("#eqmtWorkStart").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : new Date(),
			change : function(){
				$("#hidEqmtWorkStart").val($("#eqmtWorkStart").val());
				lfo_eqmtWorkGrd.grid.dataSource.read();
				lfn_eqmtWorkPop_set();
			}
		});
	}
	$("#hidEqmtWorkStart").val($("#eqmtWorkStart").val());
	lfn_eqmtWorkPop_set();
}

//가동시간 팝업 세팅
this.lfn_eqmtWorkPop_set = function(){
	
	$.ajax({
		async:false,
		url : "/form/facilMgt/facilCorMgt/getEqmtOverall",
		type: "POST",
		data: {eqmtMgtId : lfo_eqmtWorkGrd.eqmtMgtId, eqmtWorkStart : $("[name=hidEqmtWorkStart]").val()},
		success: function(data){
			$("[name=runTime]").text(gfn_isNull(data.rows.runTime) == true ? 0 : data.rows.runTime);
			$("[name=eqmtPercent]").text(data.rows.eqmtPercent*100+"%");
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
</script>