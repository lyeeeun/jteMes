<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 내부 스타일 외부로 이동_200408 LYM  -->

<div id="grid-content" class="grid-content">
	<div id="jteSingleGrid"></div>
</div>
<div class="base-div">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="itemMgtForm">
			<table id="jtePopForm_master" class="jtePopForm_master">
				<colgroup>
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-title">
					<col class="col-right-content">
				</colgroup>
				<tr>
				<!-- 부품코드 -->
					<th><i class="fas fa-caret-right"></i><spring:message code = "col_itemCd"></spring:message> :</th>
					<td><input type="text" id="itemId" 
						class="left-input" name="itemId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 부품유형 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemType"></spring:message> :</td>
					<td><input type="text" id="itemType" class="right-input" name="itemType" format="selBox" msg="item_type" /></td>
				</tr>
				<tr>
				<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> :</td>
					<td><input type="text" id="itemNm" class="left-input" name="itemNm" format="text"  /></td>
				<!-- 금액 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_cost"></spring:message> :</td>
					<td><input type="text" id="itemPrice" class="right-input" name="itemPrice" format="currency"/></td>
				</tr>
				<tr>
				<!-- 인건비 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_laborCost"></spring:message> :</td>
					<td><input type="text" id="itemPersonCost" class="left-input" name="itemPersonCost" format="currency"/></td>
				<!-- 제조원가 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manufactCost"></spring:message> :</td>
					<td><input type="text" id="itemMtrlCost" class="right-input" name="itemMtrlCost" format="currency"/></td>
				</tr>
				<tr>
				<!-- 방진구Ø -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_length"></spring:message> :</td>
					<td><input type="text" id="itemStd01" class="left-input" name="itemStd01" format="numeric" /></td>
				<!-- 소재Ø -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_width"></spring:message> :</td>
					<td><input type="text" id="itemStd02" class="right-input" name="itemStd02" format="numeric" /></td>
				</tr>
				<tr>
				<!-- SUBØ -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_thick"></spring:message> :</td>
					<td><input type="text" id="itemStd03" class=left-input name="itemStd03" format="numeric" /></td>
				<!-- 무게 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_weight"></spring:message> :</td>
					<td><input type="text" id="itemStd04" class="right-input" name="itemStd04" format="numeric" /></td>
				</tr>
				<tr>
				<!-- 재질 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_qomtrl"></spring:message> :</td>
					<td><input type="text" id="itemMtrl" class="left-input" name="itemMtrl" format="selBox" msg="comn_qomtrl"/></td>
				<!-- 단위 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_unit"></spring:message> :</td>
					<td><input type="text" id="itemUnit" class="right-input" name="itemUnit" format="selBox" msg="comn_unit" /></td>
				</tr>
 				<tr>
				<!-- 공제량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_deduction"></spring:message> :</td>
					<td><input type="text" id="itemDeduction" class="left-input" name="itemDeduction" format="currency"/></td>	
				<!-- 일일 목표량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_dayTarget"></spring:message> :</td>
					<td><input type="text" id="itemDayTarget" class="right-input" name="itemDayTarget" format="currency"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> :</td>
					<td colspan="3"><input type="text" id="description" class="center-input" name="description" class="k-textbox"/></td>
				</tr>
				<tr>
				<!-- 관련 업체 정보 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "pop_relCompInfo"></spring:message> :</td>
				<!-- 업체 정보 추가 -->
					<td colspan="3"><button type="button" id="btn_company_info" class="k-button btn_company_info"
						onclick="lfn_companyInfo('NEW')"><spring:message code = "pop_compInfoAdd"></spring:message></button></td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" onclick="lfn_popSave('jtePopForm_form')"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick="gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>				<!-- 취소 -->
			</div>
		</form>
	</div>
</div>
<div style="display: none;">
	<div id="company_info">
		<div style="text-align: center;" class="itemMgtForm">
			<div class="company_info_left"><spring:message code = "pop_allCompList"></spring:message></div>				<!-- 전체 회사 목록 -->
			<div class="company_info_right"><spring:message code = "pop_relCompList"></spring:message></div>			<!-- 관련 회사 목록 -->
			<select id="companyList" class="companyList"></select>
			<select id="selectedCompany" class="selectedCompany"></select>
		</div>
		<div class="final-btn-area">
				<button type="button" class="k-button k-primary final-btn" onclick="lfn_rtlCompanySave('company_info')"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
				<button type="button" class="k-button k-primary final-btn" onclick="gfn_closePop('company_info');"><spring:message code = "pop_cancel"></spring:message></button>				<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- 	<link href='/resources/mes/css/contents/basMgt/operMgt/itemMgt/itemMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
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
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/itemMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getItemList", auth:"", prmt:{}}, 
		create:{url:"/setItem", auth:"", openFunc : lfn_jtePop_open, callback : lfn_popSave}, 
		update:{url:"/updateItem", auth:"", openFunc : lfn_jtePop_open, callback : lfn_popSave}, 
		/* destroy:{url:"/setEqmtMgtDelete", auth:"", callback:lfn_jteGrid_delete} */
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
				itemDeduction : { type: "int"},
				itemTotalStock : { type: "int"},
				itemDayTarget : { type: "int"},
				itemUnit: { type: "string" },
				itemMtrl: { type: "string" },
				isUse: { type: "bool" }
			}
		};
	
	//6.
	lfo_common.columns = [
		/* {title:"No.", width:50, template: "#=++record #"}, */
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "150px"},										//부품코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "180px"},										//부품명
		{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
			title:gfn_getMsg("col_itemType"), width: "110px"},													//부품유형
		{field: "itemPrice", title:gfn_getMsg("col_cost"), format: "{0:n0}", width: "100px"},					//금액
		{field: "itemMtrlCost", title:gfn_getMsg("col_manufactCost"), format: "{0:n0}", width: "110px"},		//제조원가
		{field: "itemPersonCost", title:gfn_getMsg("col_laborCost"), format: "{0:n0}", width: "100px"},			//인건비
		{field: "itemStd01", title:gfn_getMsg("col_length"), format: "{0:n}", width: "100px"},					//방진구Ø
		{field: "itemStd02", title:gfn_getMsg("col_width"), format: "{0:n}", width: "100px"},					//소재Ø
		{field: "itemStd03", title:gfn_getMsg("col_thick"), format: "{0:n}", width: "100px"},					//SUBØ
 		{field: "itemStd04", title:gfn_getMsg("col_weight"), format: "{0:n}", width: "100px"},					//무게
		{field: "itemUnit", template:"# var item = gfn_isNull(gfn_getCode(itemUnit))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemUnit).cdVal , gfn_getCode(itemUnit).cdNm) # #= item #",
				title:gfn_getMsg("col_unit"), width: "100px"},
		{field: "itemMtrl", template:"# var item = gfn_isNull(gfn_getCode(itemMtrl))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemMtrl).cdVal , gfn_getCode(itemMtrl).cdNm) # #= item #",
			title:gfn_getMsg("col_qomtrl"), width: "110px"},													//재질
		{field: "itemDeduction", title:gfn_getMsg("col_deduction"), format: "{0:n0}", width: "100px"},			//공제량
		{field: "itemDayTarget", title:gfn_getMsg("col_dayTarget"), format: "{0:n0}", width: "120px"},			//일일목표량
		{field: "description", title:gfn_getMsg("col_desc"), width: "190px"},									//설명
		{field: "isUse", title:gfn_getMsg("col_isuse"), width:"110px",											//사용유무
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
		{ text: gfn_getMsg("col_itemNm"), value: "itemNm" },			//부품명
		{ text: gfn_getMsg("col_itemCd"), value: "itemId" }				//부품코드
	];
	//8.
	lfo_common.validation ={
		itemNm:{
			messages : "부품명을 입력하세요",
			rules : function(input){
				if(input.is("[name=itemNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		itemStd04:{
			messages : "무게를 입력하세요",
			rules : function(input){
				if(input.is("[name=itemStd04]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		itemDeduction:{
			messages : "공제량을 입력하세요",
			rules : function(input){
				if(input.is("[name=itemDeduction]")){
					return input.val().length != 0;
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


this.lfn_jtePop_open = function(mode, selectedItem){
	lfo_common.CompList = new Array();
	lfo_common.CompInsertList = new Array();
	lfo_common.CompDeleteList = new Array();
	
	var options = {
			modal:true, 
			width: "700px", 
			height: "530px", //20.05.20|ymlee|필드 추가로 크기 변경
			id:"jtePopForm", 
			title:gfn_getMsg("pop_itemRegist"),					//부품 등록
			workCd:mode, 
			bdSeq:"",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:["Close"]
	};

	if(mode=='NEW'){
		options.callback = function(){
			lfn_jtePopGrd_setForm(mode);
		}
	} else{
		options.title = gfn_getMsg("pop_itemSrh");				//부품 수정
		options.workCd = "EDIT";
		options.callback = function(){
			lfn_jtePopGrd_setForm(mode, selectedItem["itemId"]);
		};
 	}
	
	this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_setForm = function(mode, selectedItem){
	
	////관련자료 초기화(전역변수에 데이터가 남아 있어 이전데이터를 불러온다.) -- jkkim
	lfo_common.CompList = [];
	
	lfo_common.mode = mode;
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	} else{
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl+"/getItemList",
			type: "POST",
			data: {searchGubun: "itemId", searchText: selectedItem},
			success: function(data){
				lfo_common.popData = data.rows[0];
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

this.lfn_companyInfo = function(mode) {
	var options = {
			modal:true, 
			width: "600px", 
			height: "450px",  /* 200409 관련 회사 관리 팝업창 높이 545px에서 수정_LYM */
			id:"company_info", 
			title:gfn_getMsg("pop_relCompMgt"),			//관련 회사 관리
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
		url : "/cform/basMgt/operMgt/compMgt/getAllCompList",
		type: "POST",
		data: "",
		success: function(data){
			$.each(data.result, function(index, item){
				companyList[index] = {"compId": item.compId, "compNm": item.compNm};
				/* 업체명 다국어처리 안하도록 주석(다국어 반영시간 고려) {"compId": item.compId, "compNm": gfn_getMsg('comp_' + item.compId)}; */
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
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
				/* {"compId": item.compId, "compNm": gfn_getMsg('comp_' + item.compId)}; */
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
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
this.lfn_popSave = function(formID){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){	
		//입력폼 serialize 
		var savePrmt = $("#"+formID).serializeObject();
		switch(lfo_common.mode) {
		case "NEW":
			savePrmt.compList = lfo_common.CompList;
			
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + "/setItem",
				type: "POST",
				data: JSON.stringify(savePrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					gfn_closePop(formID);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
			break;
		default :
			savePrmt.compList = lfo_common.CompInsertList;
			savePrmt.delCompList = lfo_common.CompDeleteList;
		
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + "/updateItem",
				type: "POST",
				data: JSON.stringify(savePrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					gfn_closePop(formID);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
			break;
		}
		
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
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
</script>