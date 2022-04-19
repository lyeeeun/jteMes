<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="rlesMgtForm" style="width:100%;"> <!-- style="width:100%;" -->
	<div class="select-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<input class="k-radio" type="radio" name="target" value="ship_sta01" checked/><span class="radio-span">
		<!-- 미 완료 -->
		<spring:message code = "pop_notComplete"></spring:message></span>
		<input class="k-radio" type="radio" name="target" value="ship_sta02" /><span class="radio-span">
		<!-- 완료 -->
		<spring:message code = "pop_complete"></spring:message></span>
	</div>

	<div id="grid-content" style="width:100%;">
		<div id="jteSingleGrid"></div>
	</div>
</div>
<div style="display:none;">
	<div id="packageRegistry">
		<div id="packageInfo_grid"></div>
	</div>
</div>
<div style="display:none;">
	<div id="pkgWorkInfo">
		<form id="pkgWorkInfo_form" class="rlesMgtForm">
		<!-- 포장 작업 정보 -->
			<div class="pop_title"><spring:message code = "col_releaseOperInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
				<colgroup>
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-title">
					<col class="col-right-content">
				</colgroup>
				<tr>
				<!-- 품목명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td>
						<input type="text" id="itemNm" class="left-input" name="itemNm"/>
						<input type="hidden" id="itemId" class="left-input" name="itemId"/>
						<input type="hidden" id="pkgWorkId" name="pkgWorkId"/>
					</td>
				<!-- LoT코드 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_lotCd"></spring:message> : </td>
					<td>
						<input type="text" id="lotId" class="right-input" name="lotId"/>
						<input type="hidden" id="itemMgtId" name="itemMgtId" />
					</td>
				</tr>
				<tr>
				<!-- 시작시간 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_startTime"></spring:message>: </td>
					<td><input id="pkgWorkStart" class="left-input" name="pkgWorkStart" format="datetimepicker"/></td>
				<!-- 종료시간 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_endTime"></spring:message> : </td>
					<td><input id="pkgWorkEnd" class="right-input" name="pkgWorkEnd" format="datetimepicker"/></td>
				</tr>
				<tr>
				<!-- 불량량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_badProdQuan"></spring:message>: </td>
					<td colspan="2"><input id="defectQty" class="left-input btn-input" name="defectQty"  format="numeric" readonly/></td>
					<td>
						<button class="k-button k-primary rlesMgtForm-btn" type="button" onclick = "lfn_defectPop_open()">
				<!-- 불량 정보 등록 -->
						<spring:message code = "pop_badInfoRegist"></spring:message></button>
					</td>
				</tr>
				<tr>
				<!-- 포장 계획 수량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_releasePlanQty"></spring:message> : </td>
					<td><input class="left-input" id="pkgPlanQty" name="pkgPlanQty" format="numeric" readonly/></td>
				<!-- 재고량 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_stockQty"></spring:message> : </td>
					<td><input class="right-input" id="itemStock" name="itemStock" format="numeric" readonly/></td>
				</tr>
				<tr>
				<!-- 포장수량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_releaseQty"></spring:message> : </td>
					<td colspan="3">
						<input class="center-input" id="prsPackageQty" name="prsPackageQty" format="numeric"/>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="description" class="center-input" name="description"/></td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('pkgWorkInfo');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="pop_defectInfo" class="rlesMgtForm">
		<form id="pop_defectInfo_Form" class="pop_defectInfo_Form rlesMgtForm">
			<div id="defectInfoOption" class="plus-minus-btn-area">
				<button class="k-button k-primary plus-minus-btn" type="button" id="defectAdd">+</button>
				<button class="k-button k-primary plus-minus-btn" type="button" id="defectRemove">-</button>
			</div>
			<div>
				<table id="toolInfo-title" class="toolInfo toolInfo-title rlesMgtForm rlesMgtForm-toolInfo-title">
					<colgroup>
						<col class="col-toolInfo-check">  <!-- style="width: 4%;" -->
						<col class="col-toolInfo1">  <!-- style="width: 24%;" -->
						<col class="col-toolInfo2">  <!-- style="width: 24%;" -->
					</colgroup>
					<tr>
						<td><span style="visibility: hidden;" 체크></span></td>
					<!-- 불량원인 -->
						<td><spring:message code = "col_badCause"></spring:message></td>
					<!-- 불량량 -->
						<td><spring:message code = "col_badProdQuan"></spring:message></td>
					</tr>
				</table>
			</div>
			<div class="toolInfo-div">
				<table id="defectInfo" class="toolInfo toolInfo-content rlesMgtForm rlesMgtForm-toolInfo-content">
				</table>
			</div>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" onclick = "lfn_saveRtlDefectList()"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('pop_defectInfo')"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<div style="display:none;">
	<div id="pop_shipmentInspect">
	</div>
</div>
<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/ship/rlesMgt/rlesMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/ship/rlesMgt/rlesMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200507 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_jteSgGrd_setGrd("ship_sta01");
	
	lfn_radioBtn_event();
};

this.lfn_radioBtn_event = function(){
	$("input:radio[name=target]").click(function(e){
		$('#jteSingleGrid').empty();
		lfn_jteSgGrd_setGrd($(this).val());
	}); 
}


this.lfn_jteSgGrd_setGrd = function(target){
	
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
	lfo_common.popId = "packageRegistry";
	
	//3.
	lfo_common.ctrlUrl = "/cform/ship/rlesMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/getPackagePlanList", auth:"", prmt:{pkgState: target}}
	};
	
	//5.
	lfo_common.model = {
		id: "pkgId",
		fields: {
			pkgId : { type: "string" },
			orderId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotId : { type: "string" },
			itemStock : { type: "int" },
			itemPackageStock : { type: "int" },
			pkgPlanQty : { type: "int" },
			pkgDesc : { type: "string" },
			pkgState : { type: "string" }
		}
	};
	 
	//6.
	lfo_common.columns = [
		{field: "pkgId", title: gfn_getMsg("col_releaseCd"), width: "100px"},					//포장 계획 코드
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "100px"},					//수주코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "140px"},						//부품명
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "100px"},						//부품코드
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "100px"},						//LoT코드
		{field: "itemStock",  title:gfn_getMsg("col_stockQty"), width: "80px"},				//재고량
		{field: "itemPackageStock",  title:gfn_getMsg("col_releaseQty"), width: "80px"},			//포장수량
		{field: "pkgPlanQty",  title:gfn_getMsg("col_releasePlanQty"), width: "120px"},				//포장 계획 수량
		{field: "pkgDesc",  title:gfn_getMsg("col_desc"), width: "220px"},						//설명
		{field: "pkgState", template: "# var item = gfn_isNull(gfn_getCode(pkgState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(pkgState).cdId , gfn_getCode(pkgState).cdNm) # #= item #",
			title:gfn_getMsg("col_releaseState"), width: "130px;"},							//포장 진행 상태
		{field: "packageWork", title: gfn_getMsg("col_releaseOper"), width:"100px",				//포장작업
			template : function(rows) {
				return '<button class="k-button k-primary" type="button" onclick="lfn_packageWork(this)"><spring:message code = "col_releaseOper"></spring:message></button>';
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
	 	{ text: gfn_getMsg("col_itemNm"), value: "itemInfo.item_nm" },			//부품명
		{ text: gfn_getMsg("col_lotCd"), value: "pkgPlan.lot_id" }, 			//LoT코드
	];
	
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_packageWork = function(rows) {
	var dataItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr"));
	lfn_jtePopGrd_popOpen("EDT", dataItem);
}

this.lfn_jtePopGrd_popOpen = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "1250px", 
		height: "470px", //200520 JJW 470->
		id:lfo_common.popId, 
		title: gfn_getMsg("col_releaseOper"),			//포장작업
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePopGrd_setGrd(selectedItem);
		$('#packageInfo_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_setGrd = function(selectedItem){
	lfo_popGrd = {};
	
	lfo_popGrd.selected = {};
	lfo_popGrd.selected = selectedItem;
	lfo_popGrd.selected.checkYn = "미완료";
	
	//체크리스트 저장 변수
	lfo_popGrd.checked = new Array();
	
	//1.
	lfo_popGrd.layoutId = "packageInfo_grid";
	
	//2.
	lfo_popGrd.popId = "pkgWorkInfo";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/ship/rlesMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getPackageWorkList", auth:"", prmt:{pkgId: selectedItem.pkgId}}, 
		create:{url:"/setPackageWorkList", auth:"", openFunc:lfn_pkgWorkPop_open, callback: lfn_pkgWorkPop_save},
		//update:{url:"/setClaimInfoSave", auth:"", callback:lfn_jtePopGrd_save}
		destroy:{url:"/delPackageWorkList", auth:"", callback:lfn_pkgWorkPop_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "pkgWorkId",
		fields: {
			pkgWorkId : { type: "string" },
			pkgWorkUser : { type: "string" },
			pkgWorkStart : { type: "string" },
			pkgWorkEnd : { type: "string" },
			prsPackageQty : { type: "int" },
			lotId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			description : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "shipmentInspection", editable: function(){return false;}, title:gfn_getMsg("col_checkList"), width:"95px",			//수령
			template : function(rows) {
				return '<button class="k-button k-primary" type="button" onclick = "gfn_inspectPop(\'NEW\', \'shipmentInspect\', \'pop_shipmentInspect\', \'' + rows.pkgWorkId + '\') " style="width:60px;">'+ "<spring:message code = "col_checkList" />" +'</button>';					//내역보기
			}
		},
		{field: "pkgWorkId", title: gfn_getMsg("col_releaseOperCd"), width: "170px;"},				//포장작업코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "180px;"},						//품목명
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "160px;"},						//LoT코드
		{field: "pkgWorkUserNm", title:gfn_getMsg("col_worker"), width: "120px;"},				//작업자
		{field: "prsPackageQty", title: gfn_getMsg("col_releaseQty"), width: "120px;"},			//포장수량
		{field: "pkgWorkStart", title:gfn_getMsg("col_wrkStartTime"), width: "180px;"},			//작업시작시간
		{field: "pkgWorkEnd", title:gfn_getMsg("col_wrkEndTime"), width: "180px;"},				//작업종료시간
		{field: "description", title:gfn_getMsg("col_desc"), width: "250px;"}					//비고
	];
	
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "iteminfo.item_nm" },			//품목명
		{ text: gfn_getMsg("col_worker"), value: "urInfo.user_nm" },			//작업자
		{ text: gfn_getMsg("col_lotCd"), value: "packageWork.lot_id" }			//Lot코드
	];
	
	lfo_popGrd.customTitle = {html:'<button class="k-button k-primary" type="button" onclick="lfn_pkg_complete(this)" style="float:right;">'+ "<spring:message code = "pop_workEnd" />" +'</button>'};
	
	lfo_popGrd.validation ={
		pkgWorkStart:{
			messages : "작업 시작일을 등록하세요",
			rules : function(input){
				if(input.is("[name=pkgWorkStart]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		pkgWorkEnd:{
			messages : "작업 종료일을 등록하세요",
			rules : function(input){
				if(input.is("[name=pkgWorkEnd]")){
					return kendo.parseDate(input.val());
					return false;
				}
				return true;
			}
		}
	}
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

this.lfn_pkgWorkPop_open = function(){
	//초기화
	lfo_popGrd.defectList = undefined;
	lfo_popGrd.checked = new Array();
	lfo_popGrd.defectInsertList = new Array();
	lfo_popGrd.defectDeleteList = new Array();
	
 	var options = {
		modal:true, 
		width: "800px",
		height: "418px",  //200507 출고 관리 그리드의 포장 작업 버튼 클릭 → 추가 버튼 클릭 시의 팝업창 height 변경_550->360px LYM 200511 JJW 550-> 410px 200810 youmi 430->468px_201102 YUMI 468->418
		id : "pkgWorkInfo", 
		title: gfn_getMsg("col_releaseRegist"),			//포장 작업 등록
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){gfn_popform_set(lfo_popGrd, 'NEW', lfo_popGrd.selected)};
	this.gfn_winOpen(options);
}


this.lfn_defectPop_open = function(){
 	var options = {
		modal:true, 
		width: "680px", //200518 JJW 너비 900-> 680
		height: "500px", //200507 출고 관리 그리드의 포장 작업 버튼 클릭 → 추가 버튼 클릭  → 불량 정보 등록 버튼 클릭 시의 팝업창 height 변경_550->555px LYM 200518 JJW 550 -> 480 200810 youmi 480->500px 
		id : "pop_defectInfo", 
		title:gfn_getMsg("pop_badInfoRegist"),			//불량 정보 등록
		resizable:false,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_defectPopup();};
	this.gfn_winOpen(options);
	
}

this.lfn_defectPopup = function() {
	lfo_popGrd.defectRowCount = 1;
	
	lfo_popGrd.defectCodeList = gfn_getCode("qual_SHIPCUT");
	
	
	var rtlDefectList = new Array();
	
	lfo_popGrd.beforeDefectList = new Array();
	if(lfo_popGrd.defectList != undefined) {
		rtlDefectList = lfo_popGrd.defectList;
	}
	
	if(rtlDefectList != undefined) {
		$.each(rtlDefectList, function(index, item) {
			lfn_defectAddRow();

			$("#pop_defectInfo_Form [name = badCode"+lfo_popGrd.defectRowCount+"]").data("kendoDropDownList").select(function(dataItem) {
				return dataItem.cdId === item.badCode;
			});
			
			$("#pop_defectInfo_Form [name = badQty"+lfo_popGrd.defectRowCount+"]").data("kendoNumericTextBox").value(item.badQty);
			
			lfo_popGrd.defectRowCount++;
		});
	} else {
		lfn_defectAddRow();
		
		lfo_popGrd.defectRowCount++;
	}
	
	$('#defectAdd').click(function() {
		lfo_popGrd.defectRowCount++;
		
		lfn_defectAddRow();
	});
	
	$('#defectRemove').click(function() {
		lfo_popGrd.defectRowCount--;
		$.each($('#defectInfo').find('tr'), function(index, item) {
			$(item).find("input[type='checkbox']:checked").closest("tr").remove();
		});
	});
	
}

this.lfn_defectAddRow = function() {
	$('#defectInfo').append('<tr>' +
			'<td style="width:6%; text-align:center"><input type="checkbox" name="checkbox' + lfo_common.rowCount + '"/></td>' +
			'<td style="width:65%"><input type="text" class="badCode" format="selBox" name="badCode' + lfo_popGrd.defectRowCount + '" msg="qual_SHIPCUT"/></td>' +
			'<td style="width:29%"><input type="text" class="badQty" format="numeric" name="badQty' + lfo_popGrd.defectRowCount + '" /></td>' +
			'</tr>');  // 200507 LYM 내부 스타일 추가 + 체크박스 추가

	$("#pop_defectInfo_Form [name = badCode"+lfo_popGrd.defectRowCount+"]").kendoDropDownList({
		dataSource: lfo_popGrd.defectCodeList,
		dataValueField: "cdId",
		valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
		template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
		index:0,
		autoWidth: true
	});
	
	$("#pop_defectInfo_Form [name = badQty"+lfo_popGrd.defectRowCount+"]").kendoNumericTextBox({
		format: "0",
		value: 0
	});
}

this.lfn_saveRtlDefectList = function() {
	lfo_popGrd.defectList = new Array();
	
	var duplicateCheck = new Array();
	var flag = true;
	
	var defectTotalCount = 0;
	$.each($('#defectInfo').children('tr'), function(index, item){
		if(duplicateCheck.indexOf($(item).find('input.badCode').val()) !== -1){
			kendo.confirm("동일한 불량 원인을 중복하여 선택할 수 없습니다.");
			flag = false;
			return flag;
		}
		duplicateCheck.push($(item).find('input.badCode').val());
		
		lfo_popGrd.defectList.push({
			badCode: $(item).find('input.badCode').val(),
			badQty: $(item).find('input.badQty').val()
		})
		defectTotalCount += parseInt($(item).find('input.badQty').val());
	});
	
	if(!flag) {
		return flag;
	}
	
	var beforeDefectList = lfo_popGrd.beforeDefectList.slice();
	var selDefectList = lfo_popGrd.defectList.slice();
	
	$.each(beforeDefectList, function(index, item) {
		var idx = selDefectList.findIndex(x => x.badCode == item.badCode)
		if(idx != -1) {
			selDefectList.splice(idx, 1);
		}
	});
	lfo_popGrd.defectInsertList = selDefectList;
	selDefectList = lfo_popGrd.defectList.slice();
	
	lfo_popGrd.defectUpdateList = new Array();
	
	$.each(selDefectList, function(index, item) {
		var idx = beforeDefectList.findIndex(x => x.badCode == item.badCode)
		if(idx != -1) {
			lfo_popGrd.defectUpdateList.push(item);
			beforeDefectList.splice(idx, 1);
		}
	});
	
	lfo_popGrd.defectDeleteList = beforeDefectList;
	
	$("#defectQty").data("kendoNumericTextBox").value(defectTotalCount);
	
	gfn_closePop('pop_defectInfo'); 
}

this.lfn_pkgWorkPop_save = function(mode){
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		if(parseInt(lfo_popGrd.selected.itemStock) < (parseInt($('#defectQty').val()) + parseInt($('#prsPackageQty').val()))) {
			kendo.confirm('불량 수량과 출고 수량의 합이 보유 재고량보다 클 수 없습니다.');
			return false;
		}
		
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		savePrmt.defectInsertList = lfo_popGrd.defectInsertList;
		
		savePrmt.lotId = lfo_popGrd.selected.lotId;
		savePrmt.itemMgtId = lfo_popGrd.selected.lotId;
		savePrmt.pkgId = lfo_popGrd.selected.pkgId;

		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				//마스터 그리드 리로드
				lfo_common.grid.dataSource.read();
				/* lfo_popGrd.grid.dataSource.read(); */
				
				//팝업종료
				gfn_closePop(lfo_popGrd.popId);
				gfn_closePop(lfo_common.popId);
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//삭제 콜백
this.lfn_pkgWorkPop_delete = function(){
	var delPrmt = [];
	var delPackageQty = 0;
	
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delTemp = lfo_popGrd.grid.dataItem($(this).closest('tr'))
			delTemp.itemId = lfo_popGrd.selected.itemId;
			delTemp.itemMgtId = lfo_popGrd.selected.itemMgtId;
			delPrmt.push(delTemp);
			
			delPackageQty += delTemp.prsPackageQty;
		}
	});

	if(lfo_popGrd.selected.itemPackageStock < delPackageQty) {
		kendo.confirm(gfn_getMsg("pop_toManyDelPackageStock"));
		return false;
	}
	
	kendo.confirm("출고 작업 이력을 삭제 할 경우 해당 출고 작업으로 진행 된 출하 계획/진행 이력을 조회 하실 수 없습니다. \n계속 진행하시겠습니까?")
	.done(function(){
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.destroy.url,
			type: "POST",
			data: JSON.stringify(delPrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				lfo_popGrd.grid.dataSource.read();
				
				gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});		//성공적으로 삭제되었습니다.
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}).fail(function(){return false;});
	
}

this.lfn_pkg_complete = function() {
	$.ajax({
		async:false,
		url : '/cform/ship/rlesMgt/updatePkgPlanState',
		type: "POST",
		data: JSON.stringify({pkgId: lfo_popGrd.selected.pkgId}),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//마스터 그리드 리로드
			lfo_common.grid.dataSource.read();
			
			//팝업종료
			gfn_closePop(lfo_common.popId);
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
</script>