<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 내부 스타일 외부로 이동_200416 LYM&JJW  -->

<div id="grid-content" class="grid-content">
	<div id="jteSingleGrid"></div>
</div>
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="processInfoForm">
			<table id="jtePopForm_master" class="jtePopForm_master">
			<colgroup>
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr>
					<th><i class="fas fa-caret-right"></i><spring:message code = "col_processCd"></spring:message> : </th>			<!-- 공정코드 -->
					<td colspan="3"><input type="text" id="processId" class="center-input" name="processId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_processNm"></spring:message> : </td>			<!-- 공정명 -->
					<td><input type="text" id="processNm" class="left-input" name="processNm" format="text"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_processType"></spring:message> : </td>		<!-- 공정유형 -->
					<td><input type="text" id="processType" class="right-input" name="processType" format="selBox"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td><td colspan="3"><input type="text" id="description" class="center-input" name="description" class="k-textbox"/></td>			<!-- 설명 -->
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "pop_relEqmtInfo"></spring:message> :</td><td colspan="3"><button type="button" id="btn_equipment_info" class="k-button btn_equipment_info" onclick= "lfn_equipmentInfo('NEW')" ><spring:message code = "pop_eqmtInfoAdd"></spring:message></button></td>			<!-- 관련 설비 정보 --> <!-- 설비 정보 추가 -->
				</tr> 
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" onclick = "lfn_popSave('jtePopForm_form')"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>
<div style="display:none;">
	<div id="equipment_info">
		<div class="processInfoForm equipment_info_div">
			<div class="k-widget k-header">
				<div class="search-area">
					<input id="searchEqmt" autocomplete="off" class="k-textbox searchEqmt" placeholder="전체 설비 목록 내 검색"/><span class="k-icon k-i-search left-icon"></span> <!-- left-icon 클래스 추가, 인풋박스 placeholder 추가 200416 JJW-->
					<input id="searchSelectedEqmt" autocomplete="off" class="k-textbox searchSelectedEqmt" placeholder="포함 설비 목록 내 검색"/><span class="k-icon k-i-search right-icon"></span> <!-- right-icon 클래스 추가, 인풋박스  placeholder 200416 JJW -->
				</div>
			</div>
			<div class="equipment_info_left">전체 설비 목록</div>
			<div class="equipment_info_right">포함 설비 목록</div>
			<select id="equipmentList" class="equipmentList"></select>
			<select id="selectedEquipment" class="selectedEquipment"></select>
		</div>
		<div class="processInfoForm final-btn-area" style="text-align:center;">
				<button type="button" class="k-button final-btn" onclick = "lfn_rtlEquipmentSave('equipment_info')"><spring:message code = "pop_save"></spring:message></button>		<!-- 저장 -->
				<button type="button" class="k-button final-btn" onclick = "gfn_closePop('equipment_info');"><spring:message code = "pop_cancel"></spring:message></button>				<!-- 취소 -->
		</div>
	</div>
</div> 

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/processInfo/processInfoForm_lym.css' rel="stylesheet" type="text/css"> -->

<!-- 전주원 주임 작업 CSS -->
	<link href='/resources/mes/css/contents/basMgt/operMgt/processInfo/processInfoForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object

//검색영역
var jteSgGrd_shAr= '<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteSgGrd_shSelBox\"/>'
	+'<input type=\"text\" id=\"jteSgGrd_shSelTxt\" name=\"jteSgGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteSgGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'
	+'<input id=\"jteSgGrd_hidShSelBox\" type=\"hidden\">'
	+'<input id=\"jteSgGrd_hidShSelTxt\" type=\"hidden\">'
	+'<input id=\"jteSgGrd_hidSelected\" type=\"hidden\">';

var jtePopGrd_shAr='<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jtePopGrd_shSelBox\"/>'
	+'<input type=\"text\" id=\"jtePopGrd_shSelTxt\" name=\"jtePopGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jtePopGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'
	+'<input id=\"jtePopGrd_hidShSelBox\" type=\"hidden\">'
	+'<input id=\"jtePopGrd_hidShSelTxt\" type=\"hidden\">'
	+'<input id=\"jtePopGrd_hidSelected\" type=\"hidden\">';
	
//추가버튼
var jteSgGrd_addBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jtePop_open(\'NEW\') \"><span class=\"k-icon k-i-plus\"></span>'+gfn_getMsg("btn_add")+'</a>';

//수정버튼
var jteSgGrd_modBtn = '<a role=\"button\" class=\"k-button k-button-icontext k-grid-edit\" ><span class=\"k-icon k-i-edit\"></span>'+gfn_getMsg("btn_update")+'</a>';

//새로고침
var jteSgGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteSgGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	lfo_common.ctrlUrl ="/form/basMgt/operMgt/processInfo";
	
	lfn_jteSgGrd_setGrd();
	lfn_jteSgGrd_eventBind();
	
	lfo_common.sgGrid = $("#jteSingleGrid").getKendoGrid();	
	

};

//main - grid 생성
this.lfn_jteSgGrd_setGrd = function(){
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : lfo_common.ctrlUrl + "/getProcessInfo",
				dataType : "json",
				traditional :true
			},
			parameterMap: function(data, type){
				switch(type) {
				case "read" :
					var sort='';
					$.each(data.sort, function(index,item) {
						sort += item.field+' ' +item.dir+',';
					});
					
					if(!gfn_isEmpty(sort)){
						sort = sort.substring(0,sort.length-1);
					}
				return {
					page: data.page,
					take: data.take,
					rows : data.pageSize,
					sort : sort,
					searchGubun: $("#jteSgGrd_shSelBox").val(),
					searchText: $("#jteSgGrd_shSelTxt").val()
				};
				}	
			}
		},		
		batch: true,
		schema: {
			model: {
				id: "processId",
				fields: {
					processId : { type: "string" },
					processNm : { type: "string" },
					processGbn : { type: "string" },
					description : { type: "string" },
					isUse : { type: "bool" },
					creatorId : { type: "string" },
					createdAt : { type: "string" },
					updatorId : { type: "string" },
					updatedAt : { type: "string" },
				}
			},
			data: "rows",
			total: "count"
 		},
		pageSize: 10,
		serverPaging: true,
		serverFiltering: false,
		serverSorting: true
	});

	$("#jteSingleGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{field: "processId", title: gfn_getMsg("col_processCd"), width: 120},
			{field: "processNm", title: gfn_getMsg("col_processNm"), width: 150},	
			{field: "processType", title: gfn_getMsg("col_processType"), width: 100},
			{field: "description", title: gfn_getMsg("col_desc"), width: 100},	
			{field: "isUse", title:gfn_getMsg("col_isuse"), width:"7%",
 				template : function(rows) {
 					if(rows.isUse == true){
 						return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px; cursor:pointer;'/></a>";
 					}else if (rows.isUse == false){
 						return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px; cursor:pointer;'/></a>";
 					}else{
 						return " ";
 					}
 				}
			} 
		],
		allowCopy:true,
		resizable: true,
 		columnMenu: true,
 		sortable: {
			mode: "multiple",
			allowUnsort: true
		},
		 selectable: "multiple, row",
		navigatable: true,
		pageable: {
			pageSizes: true
		},
		editable: {
			mode:"inline"
		},
		toolbar: [
			{template: kendo.template(jteSgGrd_shAr)},
			{template: kendo.template(jteSgGrd_addBtn)},
			{template: kendo.template(jteSgGrd_refreshBtn)}
			
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		}
		
	});
}

//검색이벤트
this.lfn_jteSgGrd_search = function(){
	lfo_common.sgGrid.dataSource.read();
}

this.lfn_jteSgGrd_refresh = function(){
	$("#jteSgGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteSgGrd_shSelTxt").val("");
	
	lfo_common.sgGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	
	lfo_common.sgGrid.dataSource.read();
}

// 입력,수정 ValidationCheck
this.lfn_jteSgGrd_validation = function(e){
	console.log(e);
	if(gfn_isNull(e.authId)){
		gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
		return false;
	}
	return true;
}

this.lfn_jteSgGrd_eventBind = function(){
	//검색 Selectbox 바인딩 
	var shBoxItem = [
			{ text: gfn_getMsg("col_processCd"), value: "processId" },
			{ text: gfn_getMsg("col_processNm"), value: "processNm" }
			/* { text: gfn_getMsg("col_processType"), value: "processType" } */
	];
	
	$("#jteSgGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: shBoxItem,
		index: 0
	});
	
	//검색박스 엔터 이벤트
	$("#jteSgGrd_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_jteSgGrd_search();
		}
	});
	
	//마스터테이블 더블 클릭
	$("#jteSingleGrid tbody").on("dblclick", "tr", function(e){
		lfn_jtePop_open("EDIT",lfo_common.sgGrid.dataItem($(e.target).closest('tr')));
	});
}

this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
			modal:true, 
			width: "700px", 
			height: "290px", /** 200416 수정팝업 height 조정_LYM 290px**/
			id:"jtePopForm", 
			title:gfn_getMsg("pop_processSrh"), 
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
		options.title = gfn_getMsg("pop_processRegist");
		options.workCd = "EDIT";
		options.callback = function(){
			lfn_jtePopGrd_setForm(mode, selectedItem["processId"]);
		};
 	}
	
	this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_setForm = function(mode, selectedItem){
	lfo_common.mode = mode;
	
	$("#processType").kendoDropDownList({
		dataValueField: "cdVal",
		dataSource: gfn_getCode('process_type'),
		valueTemplate : "# var item = gfn_getMsg(cdId, cdNm)  #"
			+ "#= item #",
		template : "# var item = gfn_getMsg(cdId, cdNm)  #"
			+ "#= item #",
		index: 0
	});
	
	if(mode=='NEW'){
		$("#jtePopForm_master").find("input").each(function(index,item){
			var formatType = $(item).attr("format");
			var fillTextId = $(item).attr("id");
			if(formatType == "currency"){
				$("#"+fillTextId).kendoNumericTextBox({
					format: "n0",
					value: 0
				});
			} else if(formatType == "numeric"){
				$("#"+fillTextId).kendoNumericTextBox({
					value: 0
				});
			}
			else if(formatType == "datepicker"){
				$("#"+fillTextId).kendoDatePicker({
					format : "yyyy-MM-dd"
				});
			} else{
				$("#"+fillTextId).addClass("k-textbox");
			}
		});
	} else{
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl+"/getProcessInfo",
			type: "POST",
			data: {searchGubun: "processId", searchText: selectedItem},
			success: function(data){
				lfo_common.popData = data.rows[0];
			},
			error : function(ex){
				alert("실패");
			}
		});
		$("#jtePopForm_master").find("input").each(function(index,item){
			var formatType = $(item).attr("format");
			var fillTextId = $(item).attr("id");
			
			if(formatType == "currency"){
				$("#"+fillTextId).kendoNumericTextBox({
					format: "n0",
					value: lfo_common.popData[fillTextId]
				});
			} else if(formatType == "numeric"){
				$("#"+fillTextId).kendoNumericTextBox({
					value: lfo_common.popData[fillTextId]
				});
			} else if(formatType == "datepicker"){
				$("#"+fillTextId).kendoDatePicker({
					format : "yyyy-MM-dd",
					value: lfo_common.popData[fillTextId]
				});
			} else if(formatType == "selBox"){
				$("#"+fillTextId).data("kendoDropDownList").select(function(dataItem) {
					if(dataItem.cdId === lfo_common.popData[fillTextId]) {
						return dataItem.cdId === lfo_common.popData[fillTextId];
					} else if(dataItem.cdVal === lfo_common.popData[fillTextId]) {
						return dataItem.cdVal === lfo_common.popData[fillTextId];
					} else if(dataItem.cdNm === lfo_common.popData[fillTextId]) {
						return dataItem.cdNm === lfo_common.popData[fillTextId];
					}
				});
			}else{
				$("#"+fillTextId).addClass("k-textbox");
				$("#"+fillTextId).val(lfo_common.popData[fillTextId]);
			}
		});
		
	}
}

this.lfn_equipmentInfo = function(mode) {
	var options = {
			modal:true, 
			width: "600px", 
			height: "500px", /* 200518 팝업창 높이 변경_LYM 475px JJW 500px */
			id:"equipment_info", 
			title:gfn_getMsg("pop_relEqmtMgt"), /** 200416 팝업창 제목 변경_LYM&JJW **/
			workCd:mode, 
			bdSeq:"",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:["Close"],
	};
	
	var equipmentList = new Array();
	var rtlEquipmentList = new Array();

	$.ajax({
		async:false,
		url : "/form/facilMgt/facilCorMgt/getEqmtMgtListAll",
		type: "POST",
		data: "",
		success: function(data){
			$.each(data.result, function(index, item){
				equipmentList[index] = {"eqmtMgtId": item.eqmtMgtId, "eqmtMgtNm": item.eqmtMgtNm};
			});
		},error : function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
		}
	});
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getRtlEqmtList",
		type: "POST",
		data: { processId: $('#processId').val()},
		success: function(data){
			$.each(data.rows, function(index, item){
				rtlEquipmentList[index] = {"eqmtMgtId": item.eqmtMgtId, "eqmtMgtNm": item.eqmtMgtNm};
			});
			
			lfo_common.beforeEqmtList = rtlEquipmentList;
		},error : function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
		}
	});
	
	if(!gfn_isEmpty(lfo_common.eqmtList)) {
		rtlEquipmentList = lfo_common.eqmtList;
	}
	
	$.each(rtlEquipmentList, function(index, item) {
		equipmentList.splice(equipmentList.findIndex(x => x.eqmtMgtId === item.eqmtMgtId), 1);
	});
	
	options.callback = function(){
		var equipmentListBox = $("#equipmentList").kendoListBox({
			dataSource: equipmentList,
			dataTextField: "eqmtMgtNm",
			dataValueField: "eqmtMgtId",
			connectWith: "selectedEquipment",
			toolbar: {
				tools: ["moveUp", "moveDown", "transferTo", "transferFrom", "transferAllTo", "transferAllFrom", "remove"]
			}
		}).data("kendoListBox");
		
		var selectedEquipment = $("#selectedEquipment").kendoListBox({
			dataSource: rtlEquipmentList,
			dataTextField: "eqmtMgtNm",
			dataValueField: "eqmtMgtId"
		}).data("kendoListBox");
		
		$("#searchEqmt").on("input", function(e){
			equipmentListBox.dataSource.filter({field:"eqmtMgtNm", value:$(e.target).val(), operator:"contains"});
		})
		
		$("#searchSelectedEqmt").on("input", function(e){
			selectedEquipment.dataSource.filter({field:"eqmtMgtNm", value:$(e.target).val(), operator:"contains"});
		})
		
	};
	
	this.gfn_winOpen(options);
};

//Form내용 입력/저장
this.lfn_popSave = function(formID){
	
	//입력폼 serialize 
	var savePrmt = $("#"+formID).serializeObject();
	 
	switch(lfo_common.mode) {
	case "NEW":
		savePrmt.rtlEqmtMgtList = lfo_common.eqmtList;
		/* console.log(savePrmt); */
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setProcessInfo",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				console.log(data);
			},error : function(ex){
				alert(ex);
			}
		});
		break;
	default :
		savePrmt.rtlEqmtMgtList = lfo_common.eqmtInsertList;
		savePrmt.delRtlEqmtMgtList = lfo_common.eqmtDeleteList;
		console.log(savePrmt);
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/updateProcessInfo",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				console.log(data);
			},error : function(ex){
				alert(ex);
			}
		});
		break;
	}
	
	gfn_closePop(formID);
	lfo_common.eqmtList = {};
	lfo_common.sgGrid.dataSource.read();
}

this.lfn_rtlEquipmentSave = function(formID){
	var listBox = $("#selectedEquipment").data("kendoListBox").dataItems();
	
	var selectedEquipment = [];
	
	$.each(listBox, function(index, item) {
		selectedEquipment.push({
			eqmtMgtId: item.eqmtMgtId,
			eqmtMgtNm: item.eqmtMgtNm 
		});
	})
	
	var beforeEqmtList = lfo_common.beforeEqmtList.slice();
	var selEqmtList = selectedEquipment.slice();
	
	$.each(beforeEqmtList, function(index, item) {
		var idx = selEqmtList.findIndex(x => x.eqmtMgtId == item.eqmtMgtId)
		if(idx != -1) {
			selEqmtList.splice(idx, 1);
		}
	});
	
	lfo_common.eqmtInsertList = selEqmtList;
	selEqmtList = selectedEquipment;
	$.each(selEqmtList, function(index, item) {
		var idx = beforeEqmtList.findIndex(x => x.eqmtMgtId == item.eqmtMgtId)
		if(idx != -1) {
			beforeEqmtList.splice(idx, 1);
		}
	});
	
	lfo_common.eqmtDeleteList = beforeEqmtList;
	lfo_common.eqmtList = selectedEquipment;
	
	gfn_closePop(formID);
}

this.lfn_jteSgGrd_changeIsUse = function(rows){
	var dataItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr"));
	
	if(dataItem.isUse) {
		dataItem.isUse = false;
	} else {
		dataItem.isUse = true;
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/updateIsUse",
		type: "POST",
		data: JSON.stringify(dataItem),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.sgGrid.dataSource.read();
		}
	});
}
</script>