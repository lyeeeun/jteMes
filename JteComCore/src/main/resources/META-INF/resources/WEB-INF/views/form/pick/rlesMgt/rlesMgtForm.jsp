<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

	<div id="grid-content" class="rlesMgtForm">
		<div id="jteSingleGrid"></div>
	</div>


<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="rlesMgtForm">
		<!-- 출고 진행 정보 -->
			<table id="jtePopForm_master" class="jtePopForm_master">
				<colgroup>
					<col style="width: 12%;">
					<col style="width: 15%;">
					<col style="width: 12%;">
					<col style="width: 15%;">
				</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_rlesMgtCd" text = "출고작업코드" /> : </td>
					<td><input type="text" id="rlesMgtId" name="rlesMgtId"  readonly/></td>
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_lotCd" text = "LoT 코드"/> : </td>
					<td><input type="text" id="lotId"  name="lotId" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_itemNm" text = "부품명"/> : </td>
					<td><input id="itemNm" name="itemNm" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemStockQty" text = "생산재고량" />: </td>
					<td><input id="itemStock" name="itemStock" format="numeric" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_releasePlanQty" text = "출고계획수량" />: </td>
					<td><input id="rlesPlanQty" name="rlesPlanQty"  format="numeric"  readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_rlesWorkQty" text = "출고 작업 수량" />: </td>
					<td><input id="rlesMgtQty" name="rlesMgtQty"  format="numeric"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_rlesStartDate" text = "출고 작업 시작"/> : </td>
					<td ><input id="rlesWorkStart" name="rlesWorkStart" format="datetimepicker" style="width:90%"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_rlesEndDate" text = "출고 작업 종료"/> : </td>
					<td><input id="rlesWorkEnd" name="rlesWorkEnd" format="datetimepicker" style="width:90%"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="rlesMgtDesc"  class="center-input" name="rlesMgtDesc" style="width:88%"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="action"/>
						<input type="hidden" name="rlesPlanState" id="rlesPlanState"/>
						<input type="hidden" name="rlesPlanId" id="rlesPlanId"/>
						<input type="hidden" name="itemId" id="itemId"/>
						<input type="hidden" name="itemMgtId" id="itemMgtId"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소" /></button>
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/ship/rlesMgt/rlesMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/pick/rlesMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/getRlesPlansList", auth:"", prmt:{}},
		update:{url:"/setRlesWorkSave", auth:"", openFunc : "", callback:lfn_popSave},
	};
	
	//5.
	lfo_common.model = {
		id: "rlesPlanId",
		fields: {
			rlesPlanId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotId : { type: "string" },
			itemStock : { type: "int" },
			rlesPlanQty : { type: "int" },
			rlesPlanDate : { type: "date" },
			rlesPlanDesc : { type: "string" },
			rlesPlanState : { type: "string" },
			rlesWorkStart : { type: "string" },
			rlesWorkEnd : { type: "string" },
			rlesMgtQty : { type: "int" },
			rlesMgtDesc : { type: "string" }
		}
	};
	 
	//6.
	lfo_common.columns = [
		{field: "rlesPlanId", title: gfn_getMsg("col_rlesMgt", "출고"), width:"140px",
			template : function(rows) {
				if(rows.rlesPlanState == "rlesSta01"){
					return '<button class="k-button k-primary" type="button" onclick="lfn_rlesWorkStart(this)">출고 시작</button>';
				}else if(rows.rlesPlanState == "rlesSta02" || rows.rlesPlanState == "rlesSta04"){
					return '<button class="k-button k-primary" type="button" onclick="lfn_jtePop_open(\'EDT\',this)" style = "margin-left:50%">출고 완료</button>';
				}
			}
		},
		{field: "rlesPlanId", title: gfn_getMsg("col_releasePlanCd", "출고 계획 코드"), width: "110px"},
		{field: "itemNm", title: gfn_getMsg("col_itemNm", "부품명"), width: "80px"},
		{field: "rlesPlanState",  template:"# var item = gfn_isNull(gfn_getCode(rlesPlanState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(rlesPlanState).cdId , gfn_getCode(rlesPlanState).cdNm) # #= item #",
				title: gfn_getMsg("col_rlesState", "출고 진행 상태"), width: "100px"},
		{field: "itemStock", attributes : { style : "text-align : right;"}, title: gfn_getMsg("col_itemStockQty", "생산재고량"), width: "90px"},
		{field: "rlesPlanQty",  attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_releasePlanQty", "출고 계획 수량"), width: "95px"},
		{field: "rlesMgtQty",  attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_rlesWorkQty", "출고 작업 수량"), width: "95px"},
		{field: "rlesPlanDate",  format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_releasePlanDate", "출고 예정일"), width: "100px"},
		{field: "rlesPlanDesc",  title:gfn_getMsg("col_desc"), width: "120px"}
	];
	
	//7.
	lfo_common.selectBox = [
	 	{ text: gfn_getMsg("col_itemNm", "부품명"), value: "itemInfo.item_nm" },
		{ text: gfn_getMsg("col_lotCd", "LoT코드"), value: "rlesPlan.lot_id" }
	];
	
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//출고 작업 시작
this.lfn_rlesWorkStart = function(rows) {
	var url = "/setRlesWorkStart";
	var msg = "출고 작업을 시작하시겠습니까?";
	var savePrmt = lfo_common.grid.dataItem($(rows).closest("tr"));
	
	gfn_conBox({"msg" : msg, yes : function(){
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data == "error"){
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다.")});
				}else{
					//이전화면 리로드
					lfo_common.grid.dataSource.read();
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
		
	}});
	
}

//출고 작업 팝업 오픈(출고 작업 시작 후 출고 작업 종료 버튼 클릭)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "900px", 
		height: "370px",
		id:lfo_common.popId, 
		title:gfn_getMsg("nm_rlesMgt", "출고 진행"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode,selectedItem);
	};
	this.gfn_winOpen(options);
}

//출고 작업 팝업 셋팅
this.lfn_jtePop_set = function(mode, selectedItem){
	lfo_common.gridSelected = {};
	if(mode == "EDT"){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {rlesPlanId : selectedItem};
		}
	}
	
	var date = new Date()
	var year = date.getFullYear()
	var month = date.getMonth() + 1
	month = month >= 10 ? month : '0' + month
	var day = date.getDate()
	day = day >= 10 ? day : '0' + day
	var hour = date.getHours()
	hour = hour >= 10 ? hour : '0' + hour
	var min = date.getMinutes()
	var sec = date.getSeconds()
	sec = sec >= 10 ? sec : '0' + sec
	var dateTime = year + '-' + month + '-' + day + ' ' + hour + ':' + min + ':' + sec
	
	
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {rlesPlanId :lfo_common.gridSelected.rlesPlanId},
			success: function(data){

				if(lfo_common.gridSelected.rlesMgtQty == 0){
					gfn_popform_set(lfo_common, mode,data.rows[0]);
					$("#rlesMgtQty").data("kendoNumericTextBox").value($("#rlesPlanQty").val());
					$("#rlesWorkEnd").val(dateTime);
				} else {
					gfn_popform_set(lfo_common, mode,data.rows[0]);
					$("#rlesWorkEnd").val(dateTime);
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		var formId = lfo_common.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data == ""){//에러
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다.")});
				}else if(data == "ing"){//계획 수량보다 적은 수량 출고
					gfn_closePop(lfo_common.popId);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg : "입력하신 수량만큼 부분출고가 완료되었습니다."});
				}else if(data == "end"){//계획 수량 이상의 수량으로 출고 완료. 출고 상태가 출고 완료로 변경됨
					gfn_closePop(lfo_common.popId);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg : "해당 출고 계획의 출고가 완료되었습니다."});
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
	
	
}


</script>