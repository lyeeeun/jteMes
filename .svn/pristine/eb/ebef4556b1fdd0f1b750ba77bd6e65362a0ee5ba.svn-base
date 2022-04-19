<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 상단 작업검색 영역 -->
<div style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
	<span class="pop_title" style="margin:0px 5px;">작업검색 : </span><input format="text" class="k-textbox" id="prodAsmNm" readonly/>
	<button class="k-button k-primary" type="button" onclick = "lfn_prodAsgn_popOpen();">조회</button>
	<span class="pop_title" style="margin:0px 5px;">제품명 : </span> <input format="text" class="k-textbox" id="itemNm" readonly/>
	<span class="pop_title" style="margin:0px 5px;">지시일 : </span><input format="text" class="k-textbox" id="prodAsmDate" readonly/>
	<span class="pop_title" style="margin:0px 5px;">지시량 : </span><input format="text" class="k-textbox" id="prodAsmQty" readonly/>
</div>

<!-- 그리드 영역 -->
<div id="grid-content">
	<div id="plcIncludeGrid" style=" height:50%; padding : 5px 0;"></div>
	<div id="plcExcludeGrid" style=" height:50%; padding : 5px 0;"></div>
</div>

<!-- 작업검색 팝업 -->
<div style="display:none;">
	<div id="prodAsgnGridPop">
		<div id="prodAsgnGrid" style="height:380px;"></div>
	</div>
</div>

<!-- 최종검사 바코드 입력팝업  -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form">
			<table id="jtePopForm_master" class="BasicTable">
				<colgroup>
					<col style="width:46%;">
					<col style="width:54%;">
				</colgroup>
				<tr>
					<td colspan="2">
						<span class="">최정검사</span>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>바코드 입력 : </td>
					<td><input type="text" name="barcodeId" /></td>
				</tr>
				<tr style="display:hidden;">
					<td colspan="2">
						<input type="hidden" name="plcEqmtId"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button><!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button><!-- 저장 -->
				<button class="k-button k-primary final-btn" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button><!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 자재파악 팝업 -->
<div style="display:none;">
	<div id="mtrlUsePop">
		<div id="mtrlUsePop_grid" style="height:350px;"></div>
		<div id="measure_grid"></div>
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
		<form id="mtrlBadPop_form" class="finalQualMgtForm">
			<table class="BasicTable">
			<colgroup> 
				<col style="width:24%;">
				<col style="width:25%;">
				<col style="width:24%;">
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
		<div class="finalQualMgtForm final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('mtrlBadPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 조치등록을 위한 검사데이터 조회 팝업 -->
<div style="display:none;">
	<div id="measurePop">
		<div id="measure_pop_grid"></div>
	</div>
</div>

<!-- 검사 불량 조치내용 입력팝업  -->
<div style="display:none;">
	<div id="eqmtDescPop">
		<form id="eqmtDescPop_form">
			<table class="BasicTable">
				<tr>
					<td><span >조치내용 입력</span></td>
				</tr>
				<tr>
					<td><textarea name="plcEqmtDesc" rows=4 style="width:100%;"></textarea></td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" onclick = "lfn_measurePop_save();"><spring:message code = "pop_save"></spring:message></button><!-- 저장 -->
				<button class="k-button k-primary final-btn" onclick = "gfn_closePop('eqmtDescPop');"><spring:message code = "pop_cancel"></spring:message></button><!-- 취소 -->
			</div>
		</form>
	</div>
</div>
<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/finalQualMgt/finalQualMgtForm_JJW.css' rel="stylesheet">

<script>
var lfo_asgnPop = {}; // 작업 조회 팝업 

var lfo_include = {}; //검사완료 목록

var lfo_exclude = {}; //검사 대기 목록

var lfo_bomMtrl = {}; //자재파악

var lfo_measure = {}; //조치내역

var lfo_measurePop = {}; //조치내역 등록을 위한 그리드(검사 대기 목록)

var lfo_mtrlDetail = {}; //자재 사용내역

var lfo_mtrlBad = {}; //불량내역

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//더블클릭 콜백(팝업)
this.lfn_prodAsgn_popOpen = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "1015px", 
		height: "390px",  /** 200428 첫번째 팝업 높이 변경 565px->600px_LYM **/ /* 200518 JJW 565px -> 600px */
		id : "prodAsgnGridPop", 
		title : "작업목록",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jteSgGrd_setGrd();};
	this.gfn_winOpen(options);
}

//그리드 생성
this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_asgnPop = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_asgnPop.layoutId = "prodAsgnGrid";
	
	//2.
	lfo_asgnPop.popId = "";
	
	//3.
	lfo_asgnPop.ctrlUrl = "/cform/mfgMgt/productWork"
	
	//4.
	lfo_asgnPop.crud  = {
		read:{url:"/getProdWorkAsgnList", auth:"",search : false, paging:false, prmt:{}, dynamicPrmt:{prodAsmState : "prodAsmState"}}, 
	};
	
	//커스텀 타이틀
	lfo_asgnPop.customTitle = {
		html:	'<span class="pop_title">' + "작업지시 목록" + '</span>'+
				'<div style="margin : 0 14px 0 5px; float:right;">작업상태 : '+
				'<input name="prodAsmState" id="prodAsmState" value="prod_sta02"></div>'
	}
	
	//5.
	lfo_asgnPop.model = {
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
			creatorId : { type: "string" }
		}
	};

	//6.
	lfo_asgnPop.columns = [
		{field: "prodAsmId", title: "정보", width: 95,
			template:'<button class="k-button k-primary" type = "button" onclick = "lfn_asgnMapping_set(\'button\', this)" style="width:60px;">'+"선택"+'</button>'},
		{field: "lotNm", title : "LoT명", width: 120},
		{field: "lotId", title : "LoT코드", width: 150},
		{field: "itemNm", title : "제품명", width: 130},
		{field: "prodAsmNm", title : "지시명", width: 120},
		{field: "prodAsmDate", format: "{0: yyyy-MM-dd}", title : "지시일", width: 120},
		{field: "prodAsmQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : "지시량", width: 90},
		{field: "prodAsmUserNm", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : "지시자", width: 140}
/* 		{field: "prodAsmState", template:"# var item = gfn_isNull(gfn_getCode(prodAsmState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmState).cdId , gfn_getCode(prodAsmState).cdNm) # #= item #", 
			title : "상태", width: 110} */
	];
	
	//7.
	lfo_asgnPop.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_asgnPop.grid = gfn_grid_set(lfo_asgnPop);
	
	var selBoxItem = gfn_getCode('prod_sta');
	
	$("#prodAsmState").kendoDropDownList({
		dataSource: selBoxItem,
		dataValueField: "cdId",
		dataTextField: "cdNm",
	//	valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
	//	template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
		index:0,
		change: function(e) {
			/* $('#orderState').val(this.value()); */
			lfo_asgnPop.grid.dataSource.read();
		}
	});
}

// 그리드 호출(1. plc - asgn 맵핑정보, 2. plc 대기 데이터) 
this.lfn_asgnMapping_set = function(act, selectedItem){
	
	//선택한 rows 정보 변수에 담기
	lfo_asgnPop.gridSelected = lfo_asgnPop.grid.dataItem($(selectedItem).closest("tr"));
	
	//상단 검색영역 세팅
	$("#prodAsmNm").val(lfo_asgnPop.gridSelected.prodAsmNm);
	$("#itemNm").val(lfo_asgnPop.gridSelected.itemNm);
	$("#prodAsmQty").val(lfo_asgnPop.gridSelected.prodAsmQty);
	$("#prodAsmDate").val(gfn_getDate(lfo_asgnPop.gridSelected.prodAsmDate,'yyyy-MM-dd'));
	
	//1. plc - asgn 맵핑정보
	$("#plcIncludeGrid").html("");
	lfn_plcIncludeGrd_setGrd();
	
	//2. plc 대기 데이터
	$("#plcExcludeGrid").html("");
	lfn_plcExcludeGrd_setGrd();
	
	//팝업종료
	gfn_closePop("prodAsgnGridPop");
}

//1. plc - asgn 맵핑정보 그리드 호출
this.lfn_plcIncludeGrd_setGrd = function(){
	lfo_include = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_include.layoutId = "plcIncludeGrid";
	
	//2.
	lfo_include.popId = "";
	
	//3.
	lfo_include.ctrlUrl = "/cform/qualMgt/qualPec/finalQualMgt"
	
	//4.
	lfo_include.crud  = {
		read:{url:"/getPlcEqmtLogList", auth:"",search : false, paging:false, 
			prmt:{prodAsmId : lfo_asgnPop.gridSelected.prodAsmId, plcEqmtState : "plcState02"}}, 
	};
	
	//커스텀 타이틀
	lfo_include.customTitle = {
		html:'<span class="pop_title">' + "검사 완료 목록" + '</span>'
	}
	
	//5.
	lfo_include.model = {
		id: "plcEqmtId",
		fields: {
			plcEqmtId : { type: "string" },
			plcEqmtDate : { type: "date" },
			plcEqmtBolt01 : { type: "string" },
			plcEqmtBolt02 : { type: "string" },
			plcEqmtBolt03 : { type: "string" },
			plcEqmtBolt04 : { type: "string" },
			plcEqmtChk01 : { type: "string" },
			plcEqmtChk02 : { type: "string" },
			plcEqmtChk03 : { type: "string" },
			plcEqmtChk04 : { type: "string" },
			plcEqmtPass : { type: "bool" },
			plcEqmtState : { type: "String" },
			plcEqmtDesc : { type: "String" },
			upplcEqmtId : { type: "String" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			prodAsmId : { type: "string" },
			barcodeId : { type: "string" },
			badChk : { type: "bool" },
			prodAsmNm : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			updatedAt : { type: "date" },
			updatorId : { type: "string" }
		}
	};

	//6.
	lfo_include.columns = [
		{field: "plcEqmtId", title : "불량", width: 95, attributes : {style:"text-align:center;"}, 
			template : function(e){
				if(e.plcEqmtPass){
					if(e.badChk){
						return "<button class=\'k-button k-primary\' type = \'button\' onclick = \'lfn_mtrlUsePop_Open(this)\'>내역</button>";
					}else{
						return "-";
					}
				}else{
					return "<button class=\'k-button k-primary\' type = \'button\' onclick = \'lfn_mtrlUsePop_Open(this)\'>조치</button>";
				}
			}
		},
		{field: "plcEqmtPass", title : "합불", width: 60,
 			template : "#=  plcEqmtPass == true ? '<span style=\"color:green;\">합</span>' : badChk == true ? '<span style=\"color:blue;\">조치<span>': '<span style=\"color:red;\">불<span>' #"},
		{field: "plcEqmtDate", format:"{0:yyyy-MM-dd HH:mm:ss}", title : "검사시간", width: 140},
		{field: "barcodeId", title : "바코드", width: 100},
		{field: "plcEqmtBolt01", title : "DBW0", width: 75},
 		{field: "plcEqmtBolt02", title : "DBW2", width: 75},
 		{field: "plcEqmtBolt03", title : "DBW4", width: 75},
 		{field: "plcEqmtBolt04", title : "DBW6", width: 75},
 		{field: "plcEqmtChk01", title : "DBW8", width: 75},
 		{field: "plcEqmtChk02", title : "DBW10", width: 75},
 		{field: "plcEqmtChk03", title : "DBW12", width: 75},
 		{field: "plcEqmtChk04", title : "DBW14", width: 75}
	];
	
	//7.
	lfo_include.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_include.grid = gfn_grid_set(lfo_include);
}

//2. plc 대기 데이터 그리드 호출
this.lfn_plcExcludeGrd_setGrd = function(){
	lfo_exclude = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_exclude.layoutId = "plcExcludeGrid";
	
	//2.
	lfo_exclude.popId = "jtePopForm";
	
	//3.
	lfo_exclude.ctrlUrl = "/cform/qualMgt/qualPec/finalQualMgt"
	
	//4.
	lfo_exclude.crud  = {
		read:{url:"/getPlcEqmtLogList", auth:"",search : false, prmt:{plcEqmtState : "plcState01"}},
		create:{url:"/getPlcEqmtLogList", auth:"", openFunc:"", callback : lfn_plcExcludeGrd_save},
		update:{url:"/getPlcEqmtLogList", auth:"", openFunc:"", callback : lfn_plcExcludeGrd_save}
	};
	
	//커스텀 타이틀
	lfo_exclude.customTitle = {
		html:'<span class="pop_title">' + "검사 대기 목록" + '</span>'
	}
	
	//5.
	lfo_exclude.model = {
		id: "plcEqmtId",
		fields: {
			plcEqmtId : { type: "string" },
			plcEqmtDate : { type: "date" },
			plcEqmtBolt01 : { type: "string" },
			plcEqmtBolt02 : { type: "string" },
			plcEqmtBolt03 : { type: "string" },
			plcEqmtBolt04 : { type: "string" },
			plcEqmtChk01 : { type: "string" },
			plcEqmtChk02 : { type: "string" },
			plcEqmtChk03 : { type: "string" },
			plcEqmtChk04 : { type: "string" },
			plcEqmtPass : { type: "bool" },
			plcEqmtState : { type: "String" },
			plcEqmtDesc : { type: "String" },
			upplcEqmtId : { type: "String" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			prodAsmId : { type: "string" },
			badChk : { type: "bool" },
			prodAsmNm : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			updatedAt : { type: "date" },
			updatorId : { type: "string" }
		}
	};

	//6.
	lfo_exclude.columns = [
		{field: "plcEqmtId", title : "검사", width: 95, attributes : {style:"text-align:center;"},
			template : "<button class='k-button k-primary' onclick = 'lfn_plcExcludeGrd_open(this)'>확인</button>"},
		{field: "plcEqmtPass", title : "합불", width: 80,
 			template : function(row){
				if(row.plcEqmtPass == true){//합격
					return '<span style=\"color:green;\">합</span>';
				}else{//불량
					return '<span style=\"color:red;\">불<span>'
				}
 			}
		},
		{field: "plcEqmtDate", format:"{0:yyyy-MM-dd HH:mm:ss}", title : "검사시간", width: 160},
		{field: "plcEqmtBolt01", title : "DBW0", width: 95},
 		{field: "plcEqmtBolt02", title : "DBW2", width: 95},
 		{field: "plcEqmtBolt03", title : "DBW4", width: 95},
 		{field: "plcEqmtBolt04", title : "DBW6", width: 95},
 		{field: "plcEqmtChk01", title : "DBW8", width: 95},
 		{field: "plcEqmtChk02", title : "DBW10", width: 95},
 		{field: "plcEqmtChk03", title : "DBW12", width: 95},
 		{field: "plcEqmtChk04", title : "DBW14", width: 95}
	];
	
	//7.
	lfo_exclude.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_exclude.grid = gfn_grid_set(lfo_exclude);
}

//바코드 매핑 팝업
this.lfn_plcExcludeGrd_open = function(selectedItem){
	var options = {
		modal:true, 
		width: "300px", 
		height: "200px",  /** 200428 첫번째 팝업 높이 변경 565px->600px_LYM **/ /* 200518 JJW 565px -> 600px */
		id : lfo_exclude.popId, 
		title : "바코드 입력 팝업",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		
		var dataItem = lfo_exclude.grid.dataItem($(selectedItem).closest("tr"));
		
		//바코드 팝업 입력
		gfn_popform_set(lfo_exclude, 'EDT', dataItem);
		
		//바코드 입력후 엔터 이벤트
		$("#"+lfo_exclude.popId+" [name=barcodeId]").keydown(function(e) {
			if (e.keyCode == 13) {
				this.lfn_plcExcludeGrd_save("");
			}
		});
	};
	this.gfn_winOpen(options);
}

//plc 데이터 - 대기 > 완료 저장
this.lfn_plcExcludeGrd_save = function(mode){
	//var dataItem = lfo_exclude.grid.dataItem($(selectedItem).closest("tr"));

	var dataItem = gfn_serializeObject(lfo_exclude.popId + "_form"); 
		
	dataItem.lotId = lfo_asgnPop.gridSelected.lotId;
	dataItem.prodAsmId = lfo_asgnPop.gridSelected.prodAsmId;
	dataItem.itemId = lfo_asgnPop.gridSelected.itemId;
	
	//불량인 경우 불량조치 활성화
	if(dataItem.plcEqmtPass == true){
		dataItem.badChk = 1;
	}
	
	dataItem.plcEqmtState = "plcState02";
	
	$.ajax({
		async:false,
		url : lfo_exclude.ctrlUrl + '/setEqmtLogUpdate',
		type: "POST",
		data: JSON.stringify(dataItem),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//팝업종료
				gfn_closePop(lfo_exclude.popId);
				
				//그리드 종료
				lfo_include.grid.dataSource.read();
				lfo_exclude.grid.dataSource.read();
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//자재파악 팝업 오픈 - 검사완료 목록 조치 버튼 클릭
this.lfn_mtrlUsePop_Open = function(selectedItem){
	var options = {
			modal:true, 
			width: "630px", 
			height: "455px", 
			id : "mtrlUsePop", 
			title: "최종검사 불량 조치 팝업",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			
			lfo_include.gridSelected = lfo_include.grid.dataItem($(selectedItem).closest("tr"));
			
			//자재파악 그리드 세팅 - 검사완료 목록 조치 버튼 클릭
			lfn_mtrlUsePop_gridSet();
			
			//조치내역 그리드 세팅
			lfn_measure_gridSet();
		}
		this.gfn_winOpen(options);	
}

//자재파악 그리드 세팅 - 검사완료 목록 조치 버튼 클릭
this.lfn_mtrlUsePop_gridSet = function(){
	//1.
	lfo_bomMtrl.layoutId = "mtrlUsePop_grid";
	
	//2.
	lfo_bomMtrl.popId = "itemBadSavePop";
	
	//3.
	lfo_bomMtrl.ctrlUrl = "/cform/mfgMgt/productWork";

	//4.
	lfo_bomMtrl.crud  = {
		read:{url:"/getBomMtrlList", auth:"",search : false, paging:false,
			prmt:{
				itemId : lfo_asgnPop.gridSelected.itemId,
				prodAsmId : lfo_asgnPop.gridSelected.prodAsmId,
				bomTarget : 'prcs_bom02'
			}
		}
	};
	
	lfo_bomMtrl.customTitle = {
		html:'<span class="pop_title">' + "자재 교체 목록" + '</span>'
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

//조치이력
this.lfn_measure_gridSet = function(){
	lfo_measure = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_measure.layoutId = "measure_grid";
	
	//2.
	lfo_measure.popId = "measurePop";
	
	//3.
	lfo_measure.ctrlUrl = "/cform/qualMgt/qualPec/finalQualMgt"
	
	//4.
	lfo_measure.crud  = {
		read:{url:"/getPlcEqmtLogList", auth:"",search : false, paging:false, 
			prmt:{prodAsmId : lfo_asgnPop.gridSelected.prodAsmId, upPlcEqmtId : lfo_include.gridSelected.plcEqmtId, plcEqmtState : "plcState03" }},
		create:{url:"/setEqmtLogUpdate", auth:"", openFunc : lfn_measurePop_open, callback : lfn_measurePop_save}
	};
	
	//커스텀 타이틀
	lfo_measure.customTitle = {
		html:'<span class="pop_title">' + "검사 완료 목록" + '</span>'
	}
	
	//5.
	lfo_measure.model = {
		id: "plcEqmtId",
		fields: {
			plcEqmtId : { type: "string" },
			plcEqmtDate : { type: "date" },
			plcEqmtBolt01 : { type: "string" },
			plcEqmtBolt02 : { type: "string" },
			plcEqmtBolt03 : { type: "string" },
			plcEqmtBolt04 : { type: "string" },
			plcEqmtChk01 : { type: "string" },
			plcEqmtChk02 : { type: "string" },
			plcEqmtChk03 : { type: "string" },
			plcEqmtChk04 : { type: "string" },
			plcEqmtPass : { type: "bool" },
			plcEqmtState : { type: "String" },
			plcEqmtDesc : { type: "String" },
			upplcEqmtId : { type: "String" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			prodAsmId : { type: "string" },
			barcodeId : { type: "string" },
			badChk : { type: "bool" },
			prodAsmNm : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			updatedAt : { type: "date" },
			updatorId : { type: "string" }
		}
	};

	//6.
	lfo_measure.columns = [
// 		{field: "plcEqmtPass", title : "합불", width: 60,
//  			template : "#=  plcEqmtPass == true ? '<span style=\"color:green;\">합</span>' : badChk == true ? '<span style=\"color:blue;\">조치<span>': '<span style=\"color:red;\">불<span>' #"},
		{field: "plcEqmtDate", format:"{0:yyyy-MM-dd HH:mm:ss}", title : "검사시간", width: 140},
		{field: "plcEqmtDesc", title : "조치이력", width: 200},
		{field: "plcEqmtBolt01", title : "DBW0", width: 75},
 		{field: "plcEqmtBolt02", title : "DBW2", width: 75},
 		{field: "plcEqmtBolt03", title : "DBW4", width: 75},
 		{field: "plcEqmtBolt04", title : "DBW6", width: 75},
 		{field: "plcEqmtChk01", title : "DBW8", width: 75},
 		{field: "plcEqmtChk02", title : "DBW10", width: 75},
 		{field: "plcEqmtChk03", title : "DBW12", width: 75},
 		{field: "plcEqmtChk04", title : "DBW14", width: 75}
	];
	
	//7.
	lfo_measure.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_measure.grid = gfn_grid_set(lfo_measure);
}

//자재 사용 상세조회 팝업 오픈 - 자재목록 상세정보 버튼 클릭
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
				prodAsmId : lfo_asgnPop.gridSelected.prodAsmId
			}
		}
	};
	
	//커스텀 타이틀
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
		width: "615px",
		height: "350px",
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

//최종검사 불량 조치 검사 데이터 그리드 오픈
this.lfn_measurePop_open = function(selectedItem){
	var options = {
			modal:true, 
			width: "900px", 
			height: "455px", 
			id : lfo_measure.popId, 
			title: "조치 검사 데이터 조회",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){
			
			lfo_measure.gridSelected = lfo_measure.grid.dataItem($(selectedItem).closest("tr"));
			
			lfn_measurePop_gridSet();
		}
		this.gfn_winOpen(options);	
}

//최종검사 불량 조치 검사 데이터 그리드 세팅
this.lfn_measurePop_gridSet = function(){
	lfo_measurePop = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_measurePop.layoutId = "measure_pop_grid";
	
	//2.
	lfo_measurePop.popId = "eqmtDescPop";
	
	//3.
	lfo_measurePop.ctrlUrl = "/cform/qualMgt/qualPec/finalQualMgt"
	
	//4.
	lfo_measurePop.crud  = {
		read:{url:"/getPlcEqmtLogList", auth:"",search : false, paging:false, prmt:{plcEqmtState : "plcState01" }}, 
	};
	
	//커스텀 타이틀
	lfo_measurePop.customTitle = {
		html:'<span class="pop_title">' + "조치내역" + '</span>'
	}
	
	//5.
	lfo_measurePop.model = {
		id: "plcEqmtId",
		fields: {
			plcEqmtId : { type: "string" },
			plcEqmtDate : { type: "date" },
			plcEqmtBolt01 : { type: "string" },
			plcEqmtBolt02 : { type: "string" },
			plcEqmtBolt03 : { type: "string" },
			plcEqmtBolt04 : { type: "string" },
			plcEqmtChk01 : { type: "string" },
			plcEqmtChk02 : { type: "string" },
			plcEqmtChk03 : { type: "string" },
			plcEqmtChk04 : { type: "string" },
			plcEqmtPass : { type: "bool" },
			plcEqmtState : { type: "String" },
			plcEqmtDesc : { type: "String" },
			upplcEqmtId : { type: "String" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			prodAsmId : { type: "string" },
			barcodeId : { type: "string" },
			badChk : { type: "bool" },
			prodAsmNm : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			updatedAt : { type: "date" },
			updatorId : { type: "string" }
		}
	};

	//6.
	lfo_measurePop.columns = [
		{field: "plcEqmtId", title : "불량", width: 95, attributes : {style:"text-align:center;"}, 
			template : '<button class="k-button k-primary" type = "button" onclick = "lfn_measurePopDesc_open(this)">선택</button>'},
		{field: "plcEqmtPass", title : "합불", width: 60,
 			template : "#=  plcEqmtPass == true ? '<span style=\"color:green;\">합</span>' : badChk == true ? '<span style=\"color:blue;\">조치<span>': '<span style=\"color:red;\">불<span>' #"},
		{field: "plcEqmtDate", format:"{0:yyyy-MM-dd HH:mm:ss}", title : "검사시간", width: 140},
		{field: "barcodeId", title : "바코드", width: 100},
		{field: "plcEqmtBolt01", title : "DBW0", width: 75},
 		{field: "plcEqmtBolt02", title : "DBW2", width: 75},
 		{field: "plcEqmtBolt03", title : "DBW4", width: 75},
 		{field: "plcEqmtBolt04", title : "DBW6", width: 75},
 		{field: "plcEqmtChk01", title : "DBW8", width: 75},
 		{field: "plcEqmtChk02", title : "DBW10", width: 75},
 		{field: "plcEqmtChk03", title : "DBW12", width: 75},
 		{field: "plcEqmtChk04", title : "DBW14", width: 75}
	];
	
	//7.
	lfo_measurePop.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_measurePop.grid = gfn_grid_set(lfo_measurePop);
}

//최종검사 조치내용 입력 팝업 오픈
this.lfn_measurePopDesc_open = function(selectedItem){
	var options = {
		modal:true, 
		width: "400px", 
		height: "200px", 
		id : lfo_measurePop.popId, 
		title: "",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfo_measurePop.gridSelected = lfo_measurePop.grid.dataItem($(selectedItem).closest("tr"));
	}
	
	this.gfn_winOpen(options);	
}

//최종검사 불합격 조치이력 저장
this.lfn_measurePop_save = function(selectedItem){
	
	//선택된 검사항목(조치 데이터)
	var savePrmt = [];
	
	var dataItem = lfo_measurePop.gridSelected;
	
	//기본정보
	dataItem.lotId = lfo_asgnPop.gridSelected.lotId;
	dataItem.prodAsmId = lfo_asgnPop.gridSelected.prodAsmId;
	dataItem.itemId = lfo_asgnPop.gridSelected.itemId;
	dataItem.barcodeId = lfo_include.gridSelected.barcodeId;
	dataItem.badChk = 1;//이력 확인을 위함
	
	savePrmt.push(dataItem);
	
	//현재 검사항목(조치 히스토리)
	lfo_include.gridSelected.plcEqmtDesc = $("#eqmtDescPop_form [name=plcEqmtDesc]").val();
	
	savePrmt.push(lfo_include.gridSelected);
	
	//추가 - upcdid, 바코드 아이디
	$.ajax({
		async:false,
		url : lfo_measurePop.ctrlUrl + "/setMeasureChange",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				lfo_include.gridSelected = data;
				
				
				//조치내용 입력 팝업 종료
				gfn_closePop(lfo_measurePop.popId);
				
				//조치 검사 데이터 조회 팝업 종료
				gfn_closePop(lfo_measure.popId);
				
				//최종검사 불량조치 팝업 종료
				gfn_closePop("mtrlUsePop");
				
				//검사완료목록 초기화
				lfo_include.grid.dataSource.read();
				
				//검사 대기 목록 초기화
				lfo_exclude.grid.dataSource.read();
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