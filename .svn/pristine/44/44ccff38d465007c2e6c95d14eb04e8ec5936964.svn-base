<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 내부 스타일 외부로 이동_200423 LYM&JJW  -->

<div id="grid-content" class="grid-content">
	<div id="jteMasterGrid" style="float:left; width:37%;"></div>
	<div id="jteSubGrid" style="float:right; width:62%;"></div>
</div>

<div style="display: none;">
	<div id="useToolInfo">
		<div style="text-align: center;" class="itemToolMgtForm">
			<div class="useToolInfo_left"><spring:message code = "pop_allToolList"></spring:message></div>			<!-- 전체공구목록 -->
			<div class="useToolInfo_right"><spring:message code = "pop_relToolList"></spring:message></div>			<!-- 관련공구목록 -->
			<select id="toolList" class="toolList"></select>
			<select id="selectedTool" class="selectedTool"></select>
		</div>
		<div class="final-btn-area">
				<button type="button" class="k-button k-primary final-btn" onclick="lfn_rtlToolSave('useToolInfo')"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
				<button type="button" class="k-button k-primary final-btn" onclick="gfn_closePop('useToolInfo');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/item/itemToolMgt/itemToolMgtForm_JJW.css' rel="stylesheet">
<!--  이윤민 주임 작업 CSS
<link href='/resources/mes/css/contents/item/itemToolMgt/itemToolMgtForm_lym.css' rel="stylesheet"> -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object

var jteMasterGrd_shAr= '<label>'+gfn_getMsg("ui_search")+': </label><input id=\"jteMasterGrd_shSelBox\"/>'																					//검색(UI)
	+'<input type=\"text\" id=\"jteMasterGrd_shSelTxt\" name=\"jteMasterGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'								//검색(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteMasterGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>';			//조회

var jteSubGrd_shAr='<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteSubGrd_shSelBox\"/>'																						//검색(UI)
	+'<input type=\"text\" id=\"jteSubGrd_shSelTxt\" name=\"jteSubGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'										//검색(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteSubGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>';			//조회

//새로고침 버튼
var jteMasterGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteMasterGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';
var jteSubGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteSubGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	lfo_common.ctrlUrl ="/cform/item/itemToolMgt";
	lfo_common.selectedItemId = "";
	lfo_common.selectedEqmtMgtId = "";

	//그리드 생성
	lfn_jteMasterGrd_setGrd();
	lfn_jteSubGrd_setGrd();
	
	lfo_common.masterGrid = $("#jteMasterGrid").getKendoGrid();
	lfo_common.subGrid = $("#jteSubGrid").getKendoGrid();
	
	lfn_jteGrd_evenetBind();
};

this.lfn_jteMasterGrd_setGrd = function(){
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : "/form/basMgt/operMgt/itemMgt/getItemList",
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
						searchGubun: $("#jteMasterGrd_shSelBox").val(),
						searchText: $("#jteMasterGrd_shSelTxt").val()
					};
				}	
			}
		},		
		batch: true,
		schema: {
			model: {
				id: "itemId",
				fields: {
					itemId: { type: "string" },
					itemNm: { type: "string" },
					itemType: { type: "int" },
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

	$("#jteMasterGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "8%"},				//품목코드
			{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "12%"},			//품목명
			{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
				title:gfn_getMsg("col_itemType"), width: "8%"}							//품목유형
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
			{template: kendo.template(jteMasterGrd_shAr)},
			{template: kendo.template(jteMasterGrd_refreshBtn)}
			
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		}
		
	});
}

//검색이벤트
this.lfn_jteMasterGrd_search = function(){
	lfo_common.masterGrid.dataSource.read();
}

/* 새로고침이벤트
	1. 검색구분, 검색 새로고침
	2. 페이징 정보 새로고침
*/
this.lfn_jteMasterGrd_refresh = function(){
	$("#jteMasterGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteMasterGrd_shSelTxt").val("");
	
	lfo_common.masterGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
}

// 입력,수정 ValidationCheck
this.lfn_jteMasterGrd_validation = function(e){
	if(gfn_isNull(e.authId)){
		gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
		return false;
	}
	return true;
}

this.lfn_jteSubGrd_setGrd = function(item){
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : lfo_common.ctrlUrl + "/getRtlEqmtList",
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
						rows: data.pageSize,
						sort: sort,
						itemId: lfo_common.selectedItemId,
						searchGubun: $("#jteSubGrd_shSelBox").val(),
						searchText: $("#jteSubGrd_shSelTxt").val()
					};
				}	
			}
		},
		batch: true,
		schema: {
			model: {
				fields: {
					itemId: { type: "string" },
					processId: { type: "string" },
					processNm: { type: "string" },
					eqmtMgtId: { type: "string" },
					eqmtMgtNm: { type: "string" },
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
	
	$("#jteSubGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{field: "processNm", title: gfn_getMsg("col_processNm"), width: "12%"},				//공정명
			{field: "eqmtMgtId", title: gfn_getMsg("col_eqmtIndivCd"), width: "12%"},			//설비개별코드
			{field: "eqmtMgtNm", title: gfn_getMsg("col_eqmtDetailNm"), width: "12%"},			//설비명(상세)
			{field: "useToolInfo", title: gfn_getMsg("col_useToolInfo"), width:"7%",			//사용공구정보
 				template : function(rows) {
 					return '<button class="k-button k-primary" type="button" onclick="lfn_useToolInfo(\'NEW\', this)"><spring:message code = "col_toolSet"></spring:message></button>';			//공구설정
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
			{template: kendo.template(jteSubGrd_shAr)},
			{template: kendo.template(jteSubGrd_refreshBtn)}
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		}
		
	});
}

//검색이벤트
this.lfn_jteSubGrd_search = function(){
	lfo_common.subGrid.dataSource.read();
}

/* 새로고침이벤트
	1. 검색구분, 검색 새로고침
	2. 페이징 정보 새로고침
*/
this.lfn_jteSubGrd_refresh = function(){
	$("#jteSubGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteSubGrd_shSelTxt").val("");
	
	lfo_common.subGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
}

// 입력,수정 ValidationCheck
this.lfn_jteSubGrd_validation = function(e){
	if(gfn_isNull(e.authId)){
		gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
		return false;
	}
	return true;
}

/* 이벤트/초기설정  바인딩 
 1. grid SelectBox 바인딩
 2. 검색박스 엔터 이벤트 바인딩
 3. grid 삭제이벤트 바인딩
 */
this.lfn_jteGrd_evenetBind = function(){
	//검색 Selectbox 바인딩 
	var masterGridSelBox = [
			{ text: gfn_getMsg("col_itemCd"), value: "itemId" },				//품목코드
			{ text: gfn_getMsg("col_itemNm"), value: "itemNm" }					//품목명
	];
	
	var subGridSelBox = [
		{ text: gfn_getMsg("col_eqmtIndivCd"), value: "eqmtMgtId" },			//설비개별코드
		{ text: gfn_getMsg("col_eqmtDetailNm"), value: "eqmtMgtNm" }			//설비명(상세)
	];
	
	$("#jteMasterGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: masterGridSelBox,
		index: 0
	});
	
	$("#jteSubGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: subGridSelBox,
		index: 0
	});
	
	//검색박스 엔터 이벤트
	$("#jteMasterGrd_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_jteMasterGrd_search();
		}
	});
	
	$("#jteSubGrd_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_jteSubGrd_search();
		}
	});
	
	//마스터테이블 더블 클릭
	$("#jteMasterGrid tbody").on("dblclick", "tr", function(e){
		lfo_common.selectedItemId = lfo_common.masterGrid.dataItem($(e.target).closest('tr')).itemId; 
		lfo_common.subGrid.dataSource.query({
			page: 1,
			pageSize: 10 
		});
	});
}

this.lfn_useToolInfo = function(mode, rows) {
	var dataItem = $("#jteSubGrid").data("kendoGrid").dataItem($(rows).closest("tr"));
	
	lfo_common.selectedEqmtMgtId = dataItem.eqmtMgtId;
	
	var options = {
			modal:true, 
			width: "600px", 
			height: "450px",  /* 200409 관련 회사 관리 팝업창 높이 545px에서 수정_LYM */
			id: "useToolInfo", 
			title: gfn_getMsg("pop_useToolMgt"),			//사용공구관리
			workCd: mode, 
			bdSeq: "",
			resizable : true,
			animation: {open :{effects:"expand:vertical fadeIn"},
			close : {effects:"expand:vertical fadeIn", reverse: true}},
			actions: ["Close"]
	};
	
	var toolList = new Array();
	var rtltoolList = new Array();

	$.ajax({
		async:false,
		url : "/form/basMgt/operMgt/toolMgt/getAllToolInfoList",
		type: "POST",
		data: "",
		success: function(data){
			$.each(data.result, function(index, item){
				toolList[index] = {"toolId": item.toolId, "toolNm": item.toolNm};
			});
		}, error : function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
		}
	});
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getRtlToolList",
		type: "POST",
		data: {itemId: dataItem.itemId, eqmtMgtId: dataItem.eqmtMgtId},
		success: function(data){
			$.each(data.result, function(index, item){
				rtltoolList[index] = {"toolId": item.toolId, "toolNm": item.toolNm};
			});
		},error : function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
		}
	});
	
	lfo_common.beforeToolList = rtltoolList;
	
	$.each(rtltoolList, function(index, item) {
		toolList.splice(toolList.findIndex(x => x.toolId === item.toolId), 1);
	});
	 
	options.callback = function(){
		$("#toolList").kendoListBox({
			dataSource: toolList,
			dataTextField: "toolNm",
			dataValueField: "toolId",
			connectWith: "selectedTool",
			toolbar: {
				tools: ["moveUp", "moveDown", "transferTo", "transferFrom", "transferAllTo", "transferAllFrom", "remove"]
			}
		});
		
		$("#selectedTool").kendoListBox({
			dataSource: rtltoolList,
			dataTextField: "toolNm",
			dataValueField: "toolId"
		});
	
	}; 
	this.gfn_winOpen(options);
};

this.lfn_rtlToolSave = function(formID){
	var savePrmt = {};
	
	savePrmt.itemId = lfo_common.selectedItemId;
	savePrmt.eqmtMgtId = lfo_common.selectedEqmtMgtId;
	
	var beforeToolList = lfo_common.beforeToolList.slice();
	var selectedToolList = $("#selectedTool").data("kendoListBox").dataItems().slice();
	
	$.each(beforeToolList, function(index, item) {
		var idx = selectedToolList.findIndex(x => x.toolId == item.toolId);
		if(idx != -1) {
			selectedToolList.splice(idx, 1);
		}
	});
	
	savePrmt.toolList = selectedToolList;
	
	selectedToolList = $("#selectedTool").data("kendoListBox").dataItems().slice();
	
	$.each(selectedToolList, function(index, item) {
		var idx = beforeToolList.findIndex(x => x.toolId == item.toolId);
		if(idx != -1) {
			beforeToolList.splice(idx, 1);
		}
	});
	
	savePrmt.delToolList = beforeToolList;
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/updateRtlTool",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
		},error : function(ex){
			alert(ex);
		}
	});
	
	gfn_closePop(formID);
	lfo_common.masterGrid.dataSource.read();
}
</script>