<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="itemMgtForm">
	<div id="jteSingleGrid" class="itemMgtForm"></div>
</div>
<div class="base-div">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="itemMgtForm">
			<table id="jtePopForm_master" class="BasicTable">
				<colgroup>
					<col style="width:22%;">
					<col style="width:27%;">
					<col style="width:24%;">
					<col style="width:27%;">
				</colgroup>
				<tr><td colspan="4"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemCd" text = "부품코드" /> : </td>
					<td><input type="text" id="itemId" name="itemId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemType" text = "부품유형" /> :</td>
					<td><input type="text" id="itemType" name="itemType" format="selBox" msg="item_type" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm" text = "부품명" /> :</td>
					<td><input type="text" id="itemNm" name="itemNm" format="text"  /></td>
					<td><i class="fas fa-caret-right"></i>모델명 :</td>
					<td><input type="text" id="itemStdStr01" name="itemStdStr01" format="text" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>내부코드 :</td>
					<td colspan="3"><input type="text" id="itemStdStr06" name="itemStdStr06" format="text" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemDiv" text = "부품구분" /> :</td>
					<td><input type="text" id="itemStdStr02" name="itemStdStr02" format="selBox" msg="item_div" /></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemPermission" text = "부품허가번호" /> :</td>
					<td><input type="text" id="itemStdStr05" name="itemStdStr05" format="text" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>전원전압 :</td>
					<td><input type="text" id="itemStdStr03" name="itemStdStr03" format="text" /></td>
					<td><i class="fas fa-caret-right"></i>소비전력 :</td>
					<td><input type="text" id="itemStdStr04" name="itemStdStr04" format="text" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>보호형식 :</td>
					<td><input type="text" id="itemMtrl" name="itemMtrl" format="text"/></td>
					<td><i class="fas fa-caret-right"></i>포장단위 :</td>
					<td><input type="text" id="itemUnit" name="itemUnit" format="text" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_cost" text = "금액" /> :</td>
					<td><input type="text" id="itemPrice" name="itemPrice" format="currency"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manufactCost" text = "제조원가" /> :</td>
					<td><input type="text" id="itemMtrlCost" name="itemMtrlCost" format="currency" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>사용 목적 :</td>
					<td colspan="3"><input type="text" id="description" name="description" class="k-textbox"/></td>
				</tr>
			</table>
			<div>
				<div class="pop_title"><spring:message code = "pop_compMgt" text = "업체관리" /></div>
				<div id="jtePopForm_grid" class="itemMgtForm" style="height: 182px; width: 98%; margin: auto; display: flex;"></div>
			</div>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use" class="use"/>
						<input type="hidden" name="action" id="item_action" class="item_action"/>
					</td>
				</tr>
			<div class="final-btn-area">
				<button type="button" class="k-button k-primary final-btn jte-create" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button type="button" class="k-button k-primary final-btn jte-update" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary final-btn" type="button" onclick="gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소" /></button>
			</div>
		</form>
	</div>
</div>
<div style="display: none;">
	<div id="company_info" class="itemMgtForm">
		<div style="text-align: center;" class="itemMgtForm">
			<div class="company_info_left"><spring:message code = "pop_allCompList" text = "전체 회사 목록" /></div>
			<div class="company_info_right"><spring:message code = "pop_relCompList" text = "관련 회사 목록" /></div>
			<select id="companyList" class="companyList"></select>
			<select id="selectedCompany" class="selectedCompany"></select>
		</div>
		<div class="final-btn-area">
				<button type="button" class="k-button k-primary final-btn" onclick="lfn_rtlCompanySave('company_info')"><spring:message code = "pop_save" text = "저장" /></button>
				<button type="button" class="k-button k-primary final-btn" onclick="gfn_closePop('company_info');"><spring:message code = "pop_cancel" text = "취소" /></button>
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/basMgt/operMgt/itemMgt/itemMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//main - grid 생성
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/operMgt/itemMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getItemList", auth:"", prmt:{}}, 
		create:{url:"/setItem", auth:"", openFunc : lfn_jtePop_open, callback : lfn_popSave}, 
		update:{url:"/setItem", auth:"", openFunc : "", callback : lfn_popSave}
	};
	
	//5.
	lfo_common.model = {
			id: "itemId",
			fields: {
				itemId: { type: "string" },
				itemNm: { type: "string" },
				itemPrice: { type: "int" },
				itemMtrlCost: { type: "int" },
				itemPersonCost: { type: "int" },
				itemType: { type: "string" },
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
				itemStdStr06: { type: "string" },
				itemDeduction : { type: "int"},
				itemTotalStock : { type: "int"},
				itemDayTarget : { type: "int"},
				itemUnit: { type: "string" },
				itemMtrl: { type: "string" },
				description: { type: "string" },
				isUse: { type: "bool" }
			}
		};
	
	//6.
	lfo_common.columns = [
		{field: "itemId",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;"><spring:message code = "btn_update"></spring:message></button>',
			title : gfn_getMsg("btn_search", "조회") , width: "90px"},	
		{field: "itemId", title:gfn_getMsg("col_itemCd", "부품코드"), width: "120px"},
		{field: "itemStdStr06", title:"내부코드", width: "120px"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm", "부품명"), width: "180px"},
		{field: "itemStdStr01", title : "모델명", width: "240px"},
		{field: "itemStdStr05", title : gfn_getMsg("col_itemPermission", "부품허가번호"), width: "100px"},
		{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
			title:gfn_getMsg("col_itemType", "부품유형"), width: "110px"},
		{field: "itemStdStr02",template:"# var item = gfn_isNull(gfn_getCode(itemStdStr02))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemStdStr02).cdId , gfn_getCode(itemStdStr02).cdNm) # #= item #",
 			title : gfn_getMsg("col_itemDiv", "부품구분"), width: "100px"},
		{field: "itemPrice", title:gfn_getMsg("col_cost", "금액"), format: "{0:n0}", attributes : { style : "text-align : right;"}, width: "100px"},
		{field: "itemMtrlCost", title:gfn_getMsg("col_manufactCost", "제조원가"), format: "{0:n0}", attributes : { style : "text-align : right;"}, width: "110px"},
 		{field: "itemStdStr03", title : "전원전압", width: "100px"},
 		{field: "itemStdStr04", title : "소비전력", width: "100px"},
 		{field: "itemMtrl", title : "보호형식", width: "100px"},
		{field: "itemUnit", title : "포장단위", width: "100px"},
		{field: "description", title:"사용 목적", width: "240px"},
		{field: "isUse", title:gfn_getMsg("col_isuse", "사용유무"), width:"110px",
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px; cursor:pointer;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px; cursor:pointer;'/></a>";
				}else{
					return " ";
				}
			}
		} 
	];
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm", "부품명"), value: "itemNm" },
		{ text: gfn_getMsg("col_itemCd", "부품코드"), value: "itemId" }
	];
	//8.
	lfo_common.validation ={
		itemNm:{
			messages : "제품명을 입력하세요",
			rules : function(input){
				if(input.is("[name=itemNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
this.lfn_jtePopGrd_setGrd = function(childItems){
	$("#jtePopForm_grid").html("");
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	//lfo_popGrd.popId = "";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/basMgt/operMgt/itemMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"", auth:"", prmt:{}}, 
		create:{url:"/setMtrlRtlCompSave", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"", auth:"", openFunc:"", callback:lfn_jtePopGrd_save},
		destroy:{url:"", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "compId",
		fields: {
			compId: { type: "string" },
			toolId: { type: "string" },
			compNm: { type: "string" },
			compManagr: { type: "string" },
			compNumber: { type: "string" },
			compType: { type: "string" },
			compAddr: { type: "string" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			description: { type: "string" },
			isUse: { type: "bool" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '' : '에러' #",
			title:"액션", width: "95px"},
		{field: "compId", title:gfn_getMsg("col_compCd", "업체코드"), width: "140px"},				//업체코드
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "180px"},				//업체명
		{field: "description", title:gfn_getMsg("col_desc", "비고"), width: "250px"}			//비고
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "comp.comp_nm" },
		{ text: gfn_getMsg("col_compCd", "업체코드"), value: "comp.comp_id" },
		{ text: gfn_getMsg("col_desc", "비고"), value: "comp.description" }
	];
	
	//order에 포함된 LOT 정보 담아주기(order-child)
	lfo_popGrd.childItems = childItems;
	
	//Object형 그리드 세팅 호출(order-child)
	lfo_popGrd.grid = gfn_objectDatagrid_set(lfo_popGrd);
}


this.lfn_jtePop_open = function(mode, selectedItem){

	var options = {
			modal:true, 
			width: "700px",
			height: "721px",
			id : lfo_common.popId,
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		if(mode =="NEW"){
			options.title = gfn_getMsg("pop_itemRegist", "부품등록");
		}else if(mode=="EDT"){
			if(!gfn_isEmpty(selectedItem)){
				selectedItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
			}
			options.title = gfn_getMsg("pop_itemSrh", "부품 상세조회");
		}
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function(){lfn_jtePopGrd_setForm(mode, selectedItem);};
		this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_setForm = function(mode, selectedItem){
	lfo_common.gridSelected = {};
	var childItems = [];
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		var savePrmt = {};
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
			savePrmt = {
				itemId : lfo_common.gridSelected.itemId,
				del : lfo_common.gridSelected.del
			}
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = selectedItem;
			savePrmt = {
				itemId : lfo_common.gridSelected.itemId
			}
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + '/getItemPop', //getItemList
			type: "POST",
			data: savePrmt,
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows);
				childItems = data.rows.childCompMgtList;
				
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
	lfn_jtePopGrd_setGrd(childItems);
}

this.lfn_companyInfo = function(mode) {
	var options = {
		modal:true, 
		width: "600px", 
		height: "466px",
		id:"company_info", 
		title:gfn_getMsg("pop_relCompMgt", "관련 업체 관리"),
		workCd:mode, 
		bdSeq:"",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:["Close"],
	};
	
	var companyList = new Array();
	var rtlCompanyList = new Array();

	$.ajax({
		async:false,
		url : "/form/basMgt/operMgt/compMgt/getAllCompList",
		type: "POST",
		data: "",
		success: function(data){
			$.each(data.result, function(index, item){
				companyList[index] = {"compId": item.compId, "compNm": item.compNm};
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getRtlCompList",
		type: "POST",
		data: {itemId: $('#itemId').val()},
		success: function(data){
			$.each(data.result, function(index, item){
				rtlCompanyList[index] = {"compId": item.compId, "compNm": item.compNm};
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});

	lfo_common.beforeCompList = rtlCompanyList;
	
	if(!gfn_isEmpty(lfo_common.CompList)) {
		rtlCompanyList = lfo_common.CompList;
	}
	
	$.each(rtlCompanyList, function(index, item) {
		companyList.splice(companyList.findIndex(x => x.compId === item.compId), 1);
	});
	
	options.callback = function(){
		$("#companyList").kendoListBox({
			dataSource: companyList,
			dataTextField: "compNm",
			dataValueField: "compId",
			connectWith: "selectedCompany",
			toolbar: {
				tools: ["moveUp", "moveDown", "transferTo", "transferFrom", "transferAllTo", "transferAllFrom", "remove"]
			}
		});
		
		$("#selectedCompany").kendoListBox({
			dataSource: rtlCompanyList,
			dataTextField: "compNm",
			dataValueField: "compId"
		});
	};
	
	this.gfn_winOpen(options);
};

//Form내용 입력/저장
this.lfn_popSave = function(mode){

	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){	
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		savePrmt.childCompMgtList = lfo_popGrd.childItems;
		
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				gfn_closePop(lfo_common.popId);
				lfo_common.grid.dataSource.read();
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
		lfo_common.CompList = {};
	}
}

this.lfn_rtlCompanySave = function(formID){
	var listBox = $("#selectedCompany").data("kendoListBox").dataItems();
	
	var selectedCompany = [];
	
	$.each(listBox, function(index, item) {
		var temp = {};
		temp.compId = item.compId;
		temp.compNm = item.compNm;
		
		selectedCompany.push(temp);
	})
	
	var beforeCompList = lfo_common.beforeCompList.slice();
	var selCompList = selectedCompany.slice();
	
	$.each(beforeCompList, function(index, item) {
		var idx = selCompList.findIndex(x => x.compId == item.compId);
		if(idx != -1) {
			selCompList.splice(idx, 1);
		}
	});
	
	lfo_common.CompInsertList = selCompList;
	
	selCompList = selectedCompany;
	
	$.each(selCompList, function(index, item) {
		var idx = beforeCompList.findIndex(x => x.compId == item.compId);
		if(idx != -1) {
			beforeCompList.splice(idx, 1);
		}
	});
	
	lfo_common.CompDeleteList = beforeCompList;
	lfo_common.CompList = selectedCompany;
	
	gfn_closePop(formID);
}

this.lfn_jteSgGrd_changeIsUse = function(rows){
	var dataItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr"));
	if(dataItem.use) {
		dataItem.use = false;
	} else {
		dataItem.use = true;
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/updateIsUse",
		type: "POST",
		data: JSON.stringify(dataItem),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

this.lfn_jtePopGrd_popOpen = function(selectedItem){
	//여기부터 공통팝업 띄우기
	gfn_openCustomPop('company',lfn_jtePopGrd_save);
}

this.lfn_jtePopGrd_save = function(savePrmt){

	var childItems = gfn_objectDataGrid_save({tgObj : lfo_popGrd, prmt : savePrmt, pk : "compId", autokey : false});
	if(!childItems){
		return false;
	}
	lfo_popGrd.childItems = childItems;
	lfo_popGrd.grid.dataSource.read();
}
//삭제 콜백
this.lfn_jtePopGrd_delete = function(){
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delPrmt = lfo_popGrd.grid.dataItem($(this).closest('tr'));
			//데이터 object에 저장 - 부모요소 저장시 저장(삭제)된다.
			gfn_objectDataGrid_delete({tgObj : lfo_popGrd, prmt : delPrmt, pk : "compId"});
		}
	});
	//그리드 리로드
	lfo_popGrd.grid.dataSource.read();
}

</script>