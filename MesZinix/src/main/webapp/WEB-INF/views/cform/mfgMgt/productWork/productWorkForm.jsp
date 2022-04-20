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
				<!-- 작업지시 비고 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderDesc"></spring:message> : </td>
					<td colspan="3">
						<label for="prodWorkDesc"></label>
						<input name="prodWorkDesc" style="display:none;"/>
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
						<input type="hidden" name = "prodAsmId"/>
						<input type="hidden" name = "routingId"/>
						<input type="hidden" name = "bomId"/>
						<input type="hidden" name = "bomTarget"/>
						<input type="hidden" name = "bomTargetCode"/>
						<input type="hidden" name="prodPlanId"/>
						<input type="hidden" name="prodPlanYear"/>
						<input type="hidden" name="prodPlanMonth"/>
						<input type="hidden" name="prodPlanDay"/>
						<input type="hidden" name="prodAsmDate"/>
						<input type="hidden" name="prodAsmQty"/>
						<input type="hidden" name="use"/>
					</td>
				</tr>
			</table>
			<div id="scrollWapper" style="margin:auto; width:100%; display : none;">
				<div id="scrollView" style="height: 200px; width:100%;"></div>
			</div>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" id = "workStartBtn" onclick="lfn_prodWork_save('prodWorkDetail','start')" style="display:none;"><spring:message code = "pop_workStart" text="작업시작"></spring:message></button>
				<button class="k-button k-primary final-btn" type="button" id = "workMinusBtn" onclick="lfn_prodWork_save('prodWorkDetail','minus')" style="display:none;"><spring:message code = "" text="카운트-"></spring:message></button>
				<button class="k-button k-primary final-btn" type="button" id = "workCountBtn" onclick="lfn_prodWork_save('prodWorkDetail','count')" style="display:none;"><spring:message code = "" text="카운트+"></spring:message></button>
				<button class="k-button k-primary final-btn" type="button" id = "workDirectBtn" style="display:none;"><spring:message code = "" text="수동등록"></spring:message></button>
				<button class="k-button k-primary final-btn" type="button" id = "workMtrlBtn" onclick="lfn_mtrlUsePop_Open('prodWorkDetail')" style="display:none;"><spring:message code = "" text="자재파악"></spring:message></button>
				<button class="k-button k-primary final-btn" type="button" id = "workEndBtn" onclick="lfn_prodWork_end('prodWorkDetail')" style="display:none;"><spring:message code = "pop_workEnd" text="작업종료"></spring:message></button>
			</div>
		</form>
	</div>
</div>


<!-- 작업종료 팝업 -->
<div style="display:none;">
	<div id="jteWorkEndPop">
		<div class="pop_title">작업종료 정보 입력</div>
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
						<input name="prodWorkGood" format="currency"/>
					</td>
				</tr>
				<tr>
					<!-- 작업종료 -->
					<td class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "pop_workEnd"></spring:message></td>
					<td>
					<!-- 미입력시 현재시간이 입력됩니다 -->
						<input name="prodWorkEnd" format="datetimepicker" placeholder="<spring:message code = "pop_noEnterCurrentTime"></spring:message>"/>
						<input type= "hidden" name="prodWorkStart" />
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

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/productWork/productWorkForm_JJW.css' rel="stylesheet"/>

<script>

var lfo_common = {};// order(LOT)목록 Object  

var lfo_chkDate = {};

var lfo_workDetail = {}; //작업정보

var lfo_bomDetail = {}; //현재작업

var lfo_bomMtrl = {}; //자재파악

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
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "prodWorkDetail";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mfgMgt/productWork";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getProdWorkRoutSheetList", auth:"" ,search : false, paging : false, 
			prmt : {}, dynamicPrmt : {prodAsmId : "shAsmId", prodAsmDate : "shAsmDate"}
		}
		//destroy:{url:"/setProdWorkRoutSheetDelete", auth:"", callback:lfn_prodWork_delete}
	};
	
	//5.
	lfo_common.model = {
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
			prodWorkStatus: { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "prodWorkStatus", title : "상세", width: 110,
			template:"<button class=\"k-button k-primary\" onclick = \"lfn_prodWork_set('EDT', this);\">상세정보</button>"},
		{field: "itemNm", title : gfn_getMsg("col_itemNm"), width: "150px"},
		{field: "routingSeq", title : "공정", width: "80px"},
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "100px"},							//작업자
		{field: "prodWorkQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_asmQuan"), width: "90px"},			//지시량
		{field: "prodWorkGood", title:"생산/불량", width: 120,
			template: "#= prodWorkGood +' / '+ prodWorkBad#"},
		{field: "prodWorkStatus", template:"# var item = gfn_isNull(prodWorkStatus)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(prodWorkStatus).cdId , gfn_getCode(prodWorkStatus).cdNm) # #= item #",
				title : "작업상태", width: "120px;"}
	];
	
	//7.
	lfo_common.selectBox = [
	];
	
	//8.
	lfo_common.validation ={}
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	//상단 검색영역 추가에 따른 사이즈 조정
	$("#jteSingleGrid").height($("#jteSingleGrid").parent().height() - $("#jteSingleGrid").prev().outerHeight(true));	
};



//작업정보 세팅(우측)
this.lfn_prodWork_set = function(mode, selectedItem){
	lfo_common.gridSelected = {};
	
	$("#prodWorkDetail_form").show();
	
	if(mode=='NEW'){
		lfo_common.gridSelected = selectedItem;
	}else{
		if(typeof(selectedItem) =="string"){
			lfo_common.gridSelected.prodWorkId = selectedItem;
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
				$("#workStartBtn").show();
				$("#workMinusBtn").hide();
				$("#workCountBtn").hide();
				$("#workMtrlBtn").hide();
				$("#workEndBtn").hide();
			}else if(retrunData.prodWorkStatus == "work_prs"){//작업진행
				$("#workStartBtn").hide();
				$("#workMinusBtn").show();
				$("#workCountBtn").show();
				$("#workMtrlBtn").show();
				$("#workEndBtn").show();
			}else if(retrunData.prodWorkStatus == "work_end"){//작업완료
				$("#workStartBtn").hide();
				$("#workMinusBtn").hide();
				$("#workCountBtn").hide();
				$("#workMtrlBtn").show();
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

	//1.
	lfo_bomDetail.layoutId = "bomDetailPop_grid";
	
	//2.
	lfo_bomDetail.popId = "";
	
	//3.
	lfo_bomDetail.ctrlUrl = "/cform/mfgMgt/productWork"

	//4.
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
	
	//5.
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
	
	//6.
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
		url = "/setProdWorkStart";
	}else if(mode == "count"){
		lfo_workDetail.formData.workAction = "P";
		url = "/setProdWorkCount";
	}else if(mode == "minus"){
		lfo_workDetail.formData.workAction = "M";
		url = "/setProdWorkCount";
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



//작업종료
this.lfn_prodWork_end = function(formId){
	
	lfo_workDetail.formData = gfn_serializeObject(formId + "_form");
	
	//confirm Box
	gfn_conBox({msg:"작업을 종료하시겠습니까?", yes : function(){
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setProdWorkEnd",
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
	}});
}



//자재파악 팝업 오픈
this.lfn_mtrlUsePop_Open = function(formId){
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
			lfn_mtrlUsePop_gridSet(formId);
		}

		this.gfn_winOpen(options);	
}



//자재파악 그리드 세팅
this.lfn_mtrlUsePop_gridSet = function(formId){
	
	lfo_workDetail.formData = gfn_serializeObject(formId + "_form");

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
				itemId : lfo_workDetail.formData.itemId,
				prodAsmId : lfo_workDetail.formData.prodAsmId,
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
				prodAsmId : lfo_workDetail.formData.prodAsmId
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
				
				//작업정보 리로드
				lfn_prodWork_set('EDT',lfo_common.gridSelected.prodWorkId);
				
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
</script>