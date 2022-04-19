 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="productWorkForm productWorkForm-gird" style="display:flex;">
	
	<!-- 좌측 오더리스트 -->
	<div class="productWorkForm left-contents" style="flex:1; height:100%">
		<!-- 외부스타일 시트인 경우 outerHeight 함수가 적용되지 않아 내부 스타일로 변경 -->
		<div style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
			<span style="margin-left : 15px;">
				<span>지시일 : </span> <input id="shAsmDate" name="shAsmDate"/>
				<span>작업지시 : </span> <input id="shAsmId" name="shAsmId"/>
			</span>
		</div>
		
		<div id="jteSingleGrid"></div>
	</div>
	
	<!-- 작업정보 상세화면(우측) -->
	<div id="prodWorkDetail" class="productWorkForm" style="flex:1; height:100%; padding:0 10px;">
		<form id="prodWorkDetail_form" class="BasicTable" style="height:100%; background:#f3f3f3; padding:10px 15px;">
			<table style="width:100%;"> 
				<colgroup>
					<col style="width:20%;"/>
					<col style="width:30%;"/>
					<col style="width:20%;"/>
					<col style="width:30%;"/>
				</colgroup>
				<tr>
					<td colspan="4" class="pop_title top_pop_title"><spring:message code = "pop_workInfo" text="작업정보"></spring:message></td>
				</tr>
				<tr>
					<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td>
						<label for="itemNm"></label>
						<input type="hidden" name="itemId"/>
						<input type="hidden" name="itemNm"/>
					</td>
					<td><i class="fas fa-caret-right"></i> 생산명 : </td>
					<td>
						<label for = "bomNm"></label>
						<input name = bomNm style="display:none;"/>
						<button class="k-button k-primary" type="button" onclick = "lfn_bomDetail_open('prodWorkDetail');" style="min-width:60px; margin-left: 5px">사용자재</button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_prodAsmId" text="작업지시 코드"/> : </td>
					<td colspan="3">
						<label for="prodAsmId"></label>
						<input name="prodAsmId" style="display:none;"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>설비 : </td>
					<td colspan="3">
						<label for="eqmtMgtId"></label>
						<input name="eqmtMgtId" style="display:none;"/>
						<button class="k-button k-primary" type="button" onclick = "lfn_routSheetEqmt_chPopOpen();" style="min-width:60px; margin-left: 5px">설비변경</button>
					</td>
				</tr>
				<tr>
					<!-- 작업지시량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_wrkAsmQty"></spring:message> : </td>
					<td>
						<label for="prodWorkQty"></label>
						<input name=prodWorkQty format="currency" style="display:none;"/>
					</td>
					<!-- 작업자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_worker"></spring:message> : </td>
					<td>
						<label for="prodWorkUserNm"></label>
						<input type="hidden" name="prodWorkUserNm"/>
						<input type="hidden" name="prodWorkUser"/>
					</td>
				</tr>
				<tr>
					<!-- 양품량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_prodQuan"></spring:message> : </td>
					<td>
						<label for="prodWorkGood" class="custom-label-success"></label>
						<input type="hidden" name="prodWorkGood" format="currency" />
					</td>
					<!-- 불량량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_badProdQuan"></spring:message> : </td>
					<td>
						<label for="prodWorkBad" class="custom-label-fail"></label>
						<input  type="hidden" name="prodWorkBad" format="currency" />
					</td>
				</tr>
				<tr>
					<!-- 작업시작시간 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_wrkStartTime"></spring:message> : </td>
					<td>
						<label for="prodWorkStart"></label>
						<input  type="hidden" name="prodWorkStart" format="datetimepicker" />
					</td>
					<!-- 작업종료시간 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_wrkEndTime"></spring:message> : </td>
					<td>
						<label for="prodWorkEnd"></label>
						<input  type="hidden" name="prodWorkEnd" format="datetimepicker" />
					</td>
				</tr>
				<tr style="display:hidden;">
					<td colspan="4">
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "routingId"/>
						<input type="hidden" name = "bomId"/>
						<input type="hidden" name = "bomTarget"/>
						<input type="hidden" name = "bomTargetCode"/>
						<input type="hidden" name = "prodPlanId"/>
						<input type="hidden" name = "prodPlanYear"/>
						<input type="hidden" name = "prodPlanMonth"/>
						<input type="hidden" name = "prodPlanDay"/>
						<input type="hidden" name = "prodAsmDate"/>
						<input type="hidden" name = "use"/>
					</td>
				</tr>
			</table>
			<div id="scrollWapper" style="margin:auto; width:100%; display : none;">
				<div id="scrollView" style="height: 200px; width:100%;"></div>
			</div>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" id = "workStartBtn" onclick="lfn_prodWork_save('prodWorkDetail','start')" style="display:none;"><spring:message code = "pop_workStart" text="작업시작"></spring:message></button>
				<button class="k-button k-primary final-btn" type="button" id = "workReStartBtn" onclick="lfn_prodWork_save('prodWorkDetail','start')" style="display:none;"><spring:message code = "pop_workReStart" text="작업 재시작"></spring:message></button>
				<button class="k-button k-primary final-btn" type="button" id = "workStopBtn" onclick="lfn_prodWork_save('prodWorkDetail','stop')" style="display:none;"><spring:message code = "pop_workStop" text="작업중지"></spring:message></button>
				<button class="k-button k-primary final-btn" type="button" id = "workEndBtn" onclick="lfn_workEndPop_Open()" style="display:none;"><spring:message code = "pop_workEnd" text="작업종료"></spring:message></button>
			</div>
		</form>
	</div>
</div>

<!-- 작업종료 팝업 -->
<div style="display:none;">
	<div id="jteWorkEndPop">
		<div class="pop_title">		</div>
		<form id="jteWorkEndPop_form" class="productWorkForm jteWorkEndPop_form">	
			<table class="BasicTable jteWorkEndPop_table jteWorkEndPop_table_left"> 
				<colgroup> <!-- 50 50 -->
					<col style="width: 30%">
					<col style="width: 70%">
				</colgroup>
				<tr>
					<!-- 양품량 -->
					<td class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "col_goodProdQuan"></spring:message></td>
					<td>
						<input name="prodWorkGood" id="prodWorkGood" format="currency"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "itemId"/>
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

<!-- 라우팅 설비변경 팝업 -->
<div style="display:none;">
	<div id="routEqmtPop" class="routEqmtPop">
		<div class="pop_title">설비변경</div>
		<div id="routEqmtPop_grid" class="productWorkAdminForm routEqmtPop_grid" style="height:550px;"></div>
	</div>
</div>

<!-- 현재작업 관련 bom -->
<div style="display:none;">
	<div id="bomDetailPop">
		<div id="bomDetailPop_grid" style="height:430px;"></div>
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

<!-- 불량등록 팝업 -->
<div style="display:none;">
	<div id="mtrlBadPop">
		<form id="mtrlBadPop_form" class="productWorkForm">
			<table class="BasicTable">
			<colgroup> 
				<col style="width:23%;">
				<col style="width:27%;">
				<col style="width:23%;">
				<col style="width:27%;">
			</colgroup>
				<!-- 불량품 정보 -->
				<div class="pop_title"><spring:message code = "pop_badInfo"></spring:message></div>
				<tr>
				<!-- 불량아이디 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badId"></spring:message> : 
					</td>
					<td colspan="3"><input type="text" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : 
					</td>
					<td><input name="badCode"  format = "selBox" msg="qual_MTRLCUT"/></td> <!-- style="width: 95%; max-width:95%; " -->
				<!-- 불량량 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_badProdQuan"></spring:message> : 
					</td>
					<td><input name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input name="chkUserNm" format="text"/>
						<input type="hidden" name="chkUser" />
<!--  						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)"> -->
<%-- 	 						<spring:message code="btn_search" /> --%>
<!--  						</button> -->
					</td>
					
				<!-- 검사일 -->
					<td>
						<i class="fas fa-caret-right"></i><spring:message code = "col_inspectDate"></spring:message> : 
					</td>
					<td><input name="chkDate" format="datepicker"/></td>
				</tr>
				<tr>
					<td>
						<!-- 설명 -->
						<i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : 
					</td>
					<td colspan="3">
						<input name="badDesc"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "mtrlUseId"/>
						<input type="hidden" name = "badTarget"/>
						<input type="hidden" name = "badTargetCode"/>
						<input type="hidden" name = "mtrlId"/>
						<input type="hidden" name = "mtrlMgtId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "prodWorkStart"/>
						<input type="hidden" name = "prodWorkEnd"/>
						<input type="hidden" name = "prodWorkUser"/>
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name = "prodPlanId"/>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "action"/>
						<input type="hidden" name = "use"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="productWorkForm final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('mtrlBadPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>


<div style="display:none;">
	<div id="itemBadPop">
		<div id="itemBadPop_grid" style="height:360px;"></div>
	</div>
</div>


<!-- 불량품 관리 팝업 -->
<div style="display: none;">
	<div id="jteItemBadPop">
		<form id="jteItemBadPop_form" class="inputQualMgtForm">
			<table id="jteItemBadPop_master"
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
					<td><i class="fas fa-caret-right"></i>처리결과 :</td>
					<td colspan="3"><input id="badDesc" name="badDesc" type="text" /></td>
				</tr>
				<tr style="display: hidden;">
					<td>
						<input type="hidden" name="badTarget" id="badTarget" /> 
						<input type="hidden" name="badTargetCode" id="badTargetCode" /> 
						<input type="hidden" name="itemId" id="itemId" /> 
						<input type="hidden" name="itemMgtId" id="itemMgtId" /> 
						<input type="hidden" name="use" id="bad_use" /> 
						<input type="hidden" name="action" id="bad_action" />
					</td>
				</tr>
			</table>
		</form>
		<div class="inputQualMgtForm final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display: none;"><spring:message code="pop_save" text = "저장" /></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display: none;"><spring:message code="pop_save" text = "저장" /></button>
			<button class="k-button k-primary final-btn" type="button" onclick="gfn_closePop('jteItemBadPop');"><spring:message code="pop_cancel" text = "취소" /></button>
		</div>
	</div>
</div>


<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/productWork/productWorkForm_JJW.css' rel="stylesheet"/>

<script>

var lfo_common = {};// order(LOT)목록 Object  

var lfo_chkDate = {};

var lfo_workDetail = {}; //작업정보

var lfo_bomDetail = {}; //현재작업

var lfo_bomMtrl = {}; //자재파악

var lfo_itemBadGrd = {};

var lfo_mtrlDetail = {}; //자재파

var lfo_mtrlBad = {}; //불량저장

var lfo_prodWorkEnd = {}; //작업종료 팝업

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	//날짜검색 박스 세팅(초기 오늘 날짜 세팅)
	if($("#shAsmDate").attr("data-role") != "datepicker"){
		$("#shAsmDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_getDate(new Date(),"yyyy-MM-dd"),
			change : function(){
				//작업지시 목록 세팅
				lfn_asgnBox_set();
			}
		});
	}
	//해당날짜 작업지시 조회
	lfn_asgnBox_set();
}

//해당날짜 작업지시 조회
this.lfn_asgnBox_set = function(){
	var asgnList = [];
	
	//작업지시내용 조회
	$.ajax({
		async:false,
		url : "/cform/mfgMgt/productWork/getProdWorkAsgnList",
		type: "POST",
		data: {prodAsmDate : $("#shAsmDate").val()},
		success: function(data){
			if(data.rows.length > 0){
				asgnList = data.rows;
			}else{
				//데이터가 없는 경우 '-' 값 표시
				asgnList = [{"prodAsmId":"X", "prodAsmNm":"-"}];
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	//select box 세팅 - 이벤트 중복 등록을 방지하기 위해 selectbox 중복예외처리 추가
	if($("#shAsmId").attr("data-role") != "dropdownlist"){
		//최초 세팅
		$("#shAsmId").kendoDropDownList({
			dataTextField: "prodAsmNm",
			dataValueField: "prodAsmId",
			dataSource: asgnList,
			index: 0,
			change : function(){
				//지시목록 리로드 
				lfo_common.grid.dataSource.read();
				//작업정보 숨기기
				$("#prodWorkDetail_form").hide();
			}
		});
	}else{
		//중복 세팅
		var dataSource = new kendo.data.DataSource({
			data: asgnList
		});
		//작업지시 selectbox 데이터 바인딩 후 첫번째 값 선택
		var dropdownlist = $("#shAsmId").data("kendoDropDownList");
		dropdownlist.setDataSource(dataSource);
		dropdownlist.select(0)
		
		//작업정보 숨기기
		$("#prodWorkDetail_form").hide();
	}
	
	//작업정보 숨기기
	$("#prodWorkDetail_form").hide();
	//메인화면, 전체화면 분기처리하여 모니터화면 조회
	this.lfn_jteSgGrd_setGrd();
}


//작업지시(routing 기준) 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "prodWorkDetail";

	lfo_common.ctrlUrl = "/cform/mfgMgt/productWork";

	lfo_common.crud  = {
		read:{url:"/getProdWorkRoutSheetList", auth:"" ,search : false, paging : false, 
			prmt : {}, dynamicPrmt : {prodAsmId : "shAsmId", prodAsmDate : "shAsmDate"}
		}
	};

	lfo_common.model = {
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
			prodWorkEnd: { type: "date" },
			prodWorkStatus: { type: "string" }
		}
	};

	lfo_common.columns = [
		{field: "prodWorkStatus", title : "상세", width: 110,
			template:"<button class=\"k-button k-primary\" onclick = \"lfn_prodWork_set('EDT', this);\">상세정보</button>"},
		{field: "itemNm", title : gfn_getMsg("col_itemNm", "제품명"), width: "150px"},
		{field: "routingSeq", title : "공정", width: "80px"},
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker", "작업자"), width: "100px"},
		{field: "prodWorkQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_asmQuan", "지시량"), width: "90px"},
		{field: "prodWorkGood", title:"생산/불량", width: 120,
			template: "#= prodWorkGood +' / '+ prodWorkBad#"},
		{field: "prodWorkStatus", template:"# var item = gfn_isNull(prodWorkStatus)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(prodWorkStatus).cdId , gfn_getCode(prodWorkStatus).cdNm) # #= item #",
				title : "작업상태", width: "130px;"}
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	//상단 검색영역 추가에 따른 사이즈 조정
	$("#jteSingleGrid").height($("#jteSingleGrid").parent().height() - $("#jteSingleGrid").prev().outerHeight(true));	
};

//설비변경 팝업 오픈
this.lfn_routSheetEqmt_chPopOpen = function(rows){
	var options = {
			modal:true, 
			width: "730px", 
			height: "590px", 
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

	lfo_routEqmtGrd = {}; 
	
	lfo_routEqmtGrd.layoutId = "routEqmtPop_grid";

	lfo_routEqmtGrd.ctrlUrl = "/cform/mfgMgt/productWork"

	lfo_routEqmtGrd.crud  = {
		read:{url:"/getProdWorkEqmtChangeList", auth:"" ,search : false, paging : false, prmt:{}}
	};
	
	
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
	
	lfo_routEqmtGrd.columns = [
		{field: "eqmtMgtId", title : "변경", width: "90px",
			template : "<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_routSheetEqmt_chPopSave(this);\" style=\"min-width:60px;\">교체</button>"},	//설비
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd", "설비개별코드"), width: 180},
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm", "설비명"), width: 160},
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc", "비고"), width: 270}
	
	];
	
	//공통 그리드 세팅 호출 
	lfo_routEqmtGrd.grid = gfn_grid_set(lfo_routEqmtGrd);
}

//선택한 설비로 변경 후 그리드 리로드
this.lfn_routSheetEqmt_chPopSave = function(rows){
	var savePrmt = lfo_routEqmtGrd.grid.dataItem($(rows).closest("tr"));
	
	gfn_warnBox({msg:"선택한 설비로 교체하면 작업종료 전까지 \n 해당 설비를 다른작업정보에서 불러올 수 없습니다.", yes : function(){
		$.ajax({
			async:false,
			url : lfo_routEqmtGrd.ctrlUrl + "/setProdWorkRoutSheetSave",
			type: "POST",
			data: JSON.stringify({prodWorkId :lfo_common.gridSelected.prodWorkId , eqmtMgtId : savePrmt.eqmtMgtId, action : "U"}),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					lfn_prodWork_set('EDT',lfo_common.gridSelected.prodWorkId);
					
					//이전화면 리로드
					lfo_common.grid.dataSource.read();
					
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
	}})
}


//작업정보 세팅(우측)
this.lfn_prodWork_set = function(mode, selectedItem){
	lfo_common.gridSelected = "";
	
	$("#prodWorkDetail_form").show();
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else{
		if(typeof(selectedItem) =="string"){
			lfo_common.gridSelected = {prodWorkId : selectedItem};
		}else if(typeof(selectedItem) =="object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));	
		}
	}
	//팝업내용 조회
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
		type: "POST",
		data: {prodWorkId : lfo_common.gridSelected.prodWorkId},
		success: function(data){
			//팝업 세팅 로드
			gfn_popform_set(lfo_common, mode, data.rows[0]);

			var retrunData = data.rows[0];
			
			//선택한 버튼 선택 표시(버튼 색변경)
			$("#"+ lfo_common.layoutId +" .pop-on").removeClass("pop-on");
			lfo_common.grid.dataSource.data().forEach(function(item,index){
				if(item["prodWorkId"] == retrunData.prodWorkId){
					$("#" + lfo_common.layoutId + " .k-grid-content").find("tr").eq(index).find(".k-button").addClass("pop-on");
				}
			});
			
			//이미지뷰사용시 주석 해제
// 			var imageObject = {
// 				viewId : "scrollView",
// 				paginng : false, 
// 				prmt : {attachCode: retrunData.routingId, attachTarget : "routingMgt"}
// 			}
// 			$("#scrollView").html("");
// 			gfn_scrollView_set(imageObject);
			
			//버튼 활성, 비활성
			if(retrunData.prodWorkStatus == "work_wait"){//작업대기
				$("#workReStartBtn").hide();
				$("#workStartBtn").show();
				$("#workMinusBtn").hide();
				$("#workStopBtn").hide();
				$("#workEndBtn").hide();
			}else if(retrunData.prodWorkStatus == "work_prs"){//작업진행
				$("#workReStartBtn").hide();
				$("#workStartBtn").hide();
				$("#workMinusBtn").show();
				$("#workStopBtn").show();
				$("#workEndBtn").show();
			}else if(retrunData.prodWorkStatus == "work_end"){//작업완료
				$("#workReStartBtn").hide();
				$("#workStartBtn").hide();
				$("#workMinusBtn").hide();
				$("#workStopBtn").hide();
				$("#workEndBtn").hide();
			}else if(retrunData.prodWorkStatus == "workStop"){//작업중지
				$("#workReStartBtn").show();
				$("#workStartBtn").hide();
				$("#workMinusBtn").hide();
				$("#workStopBtn").hide();
				$("#workEndBtn").hide();
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});	
}

//삭제 콜백
this.lfn_prodWork_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_common.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}


//사용될 자재 조회 오픈
this.lfn_bomDetail_open = function(formId){
	var options = {
			modal:true, 
			width: "630px", 
			height: "440px", 
			id : "bomDetailPop", 
			title: "사용 자재",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			//부품 불량 리스트 조회 그리드 셋
			lfn_bomDetail_set(formId);
		}

		this.gfn_winOpen(options);	
}

//사용될 자재 조회 그리드 세팅
this.lfn_bomDetail_set = function(formId){

	lfo_workDetail.formData = gfn_serializeObject(formId + "_form");

	lfo_bomDetail.layoutId = "bomDetailPop_grid";

	lfo_bomDetail.popId = "";

	lfo_bomDetail.ctrlUrl = "/cform/mfgMgt/productWork"

	lfo_bomDetail.crud  = {
		read:{url:"/getBomDetailInfo", auth:"",search : false,paging:false,
			prmt:{
				bomId : lfo_workDetail.formData.bomId
			}
		}
	};
	
	lfo_bomDetail.customTitle = {
		html:'<span class="pop_title">' + "자재목록" + '</span>'
	}

	lfo_bomDetail.model = {
		id: "badId",
		fields: {
			bomId : { type: "string" },
			bomNm : { type: "string" },
			bomTarget : { type: "string" },
			bomTargetId : { type: "string" },
			bomTargetCnt : { type: "int" },
			mtrlNm : { type: "string" },
			mtrlMgtId : { type: "string" }
		}
	};

	lfo_bomDetail.columns = [
		{field: "bomTarget", title : "구분", width: "100px",
			template:"# var item = gfn_isNull(bomTarget)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(bomTarget).cdId , gfn_getCode(bomTarget).cdNm) # #= item #"},
		{field: "bomNm", title : "BOM명", width: "160px"},
		{field: "mtrlNm", title : "자재명", width: "160px"},
		{field: "bomTargetCnt", format: "{0:n0}", attributes : { style : "text-align : right;"}, title : "사용량", width: "90px"}
	];
	
	//공통 그리드 세팅 호출 
	lfo_bomDetail.grid = gfn_grid_set(lfo_bomDetail);
}

//작업시작/카운트
this.lfn_prodWork_save = function(formId, mode){
	var url = ""
	
	lfo_workDetail.formData = gfn_serializeObject(formId + "_form");
	
	if(mode == "start"){
		if($("#" + lfo_common.popId + " [name=eqmtMgtId]").val() == "" || $("#" + lfo_common.popId + " [name=eqmtMgtId]").val() == null){
			gfn_conBox({msg : "설비가 선택되지 않았습니다."});
			return false;
		}else{
			url = "/setProdWorkStart";
		}
	}else if(mode == "stop"){
		url = "/setProdWorkStop";
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + url,
		type: "POST",
		data: JSON.stringify(lfo_workDetail.formData),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				lfn_prodWork_set('EDT',data);
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
}

//작업종료  팝업 - 오픈
this.lfn_workEndPop_Open = function(formId){
	var options = {
		modal:true, 
		width: "400px", 
		height: "190px",
		id : "jteWorkEndPop", 
		title : "양품량 등록",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_workEndPop_set(formId);
	};
	this.gfn_winOpen(options);	
}

//작업종료 팝업 - 세팅
this.lfn_workEndPop_set = function(formId){
	
	lfo_workDetail.formData = gfn_serializeObject(formId + "_form");
	
	//pop가 두개라 커스텀 오브젝트
	lfo_prodWorkEnd = {
		popId : "jteWorkEndPop",
		ctrlUrl : "/cform/mfgMgt/productWork",
		crud : {
			read:{url:"/getProdWorkRoutSheetList"},  
			update:{url:"/setProdWorkEnd", auth:"", callback : lfn_workEndPop_Save}
		}
	};
	
	//ajax호출하여 최신 정보 세팅 
	$.ajax({
		async:false,
		url : lfo_prodWorkEnd.ctrlUrl + lfo_prodWorkEnd.crud.read.url,
		type: "POST",
		data: {prodWorkId : lfo_common.gridSelected.prodWorkId},
		success: function(data){
			
			//작업정보화면 세팅(메인우측)
			gfn_popform_set(lfo_prodWorkEnd, "EDT",  data.rows[0]);
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//작업 종료 팝업 - 저장
this.lfn_workEndPop_Save = function(){
	
	var savePrmt = gfn_serializeObject(lfo_prodWorkEnd.popId+"_form");
	savePrmt.prodAsmId = $("#" + lfo_common.popId + " [name=prodAsmId]").val()
	
	$.ajax({
		async:false,
		url : lfo_prodWorkEnd.ctrlUrl + lfo_prodWorkEnd.crud.update.url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				lfn_prodWork_set('EDT',lfo_common.gridSelected.prodWorkId);
				//현재팝업 종료
				gfn_closePop(lfo_prodWorkEnd.popId);

				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				
				//마스터테이블 리로드
				lfo_common.grid.dataSource.read();
				
				//작업정보 리로드
				//lfn_jteSgGrid_dblclick("EDT",lfo_common.gridSelected)
				
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}
</script>