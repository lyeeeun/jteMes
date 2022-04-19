<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="msgMgtForm" style="width:100%;">
	<div id="jteMasterGrid" class="msgMgtForm"></div> 
</div>
<input type="hidden" id="regMsgList">	

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/codMgt/msgMgt/msgMgtForm_JJW.css' rel="stylesheet">

<script type="text/javascript">
/**
 * /msgMgt/msgMgtForm
*/
var lfo_common = {};//공통 Object

this.lfn_init = function(){
	
	lfn_masterGridBind();
	lfn_setSelBox();
	lfn_eventBind();
}


//Master Grid Binding
this.lfn_masterGridBind = function(){

	//검색(custom)
	var jteMtGrd_shAr = kendo.template('<input id=\"jteMtGrd_shSelBox\"/>'
		+'<input type=\"text\" id=\"jteMtGrd_shSelTxt\" name=\"jteMtGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'									//조회(Input)
		+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteMtGrd_search() \"><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>');			//조회버튼
	
	//추가버튼
	var jteMtGrd_addBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_msgPop(\'NEW\') \"><span class=\"k-icon k-i-plus\"></span>'+gfn_getMsg("btn_add")+'</a>';
	
	//삭제(custom)  
	var jteMtGrd_delBtn = kendo.template("<a role='button' class='k-button k-button-icontext' onclick=\"lfn_deleteRow();\">"
	+ "<span class='k-icon k-i-close'></span>"+gfn_getMsg("btn_delete")+"</a>" )
	
	//새로고침(custom)
	var jteMtGrd_refreshBtn = kendo.template('<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteMtGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>');
	
	var dataSource = {
		transport: {
			read: {
				url : "<c:url value="/form/basMgt/codMgt/msgMgt/getMsgMergeList"/>",
				dataType : "json",
				traditional :true
			},
			destroy: {
				url : "<c:url value="/form/basMgt/codMgt/msgMgt/deleteMsg"/>",
				dataType : "json"
			},
			parameterMap: function(data, type){
				if(type == "read") {
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
						msgPrmt : lfo_common.msgLangType,
						searchGubun:$("#jteMtGrd_shSelBox").val(),
						searchText:$("#jteMtGrd_shSelTxt").val()
					};	
				} else if(type == "update") {
					return {
						"msgViewPk.msgId" : data.models[0].msgViewPk.msgId,
						"msgViewPk.langCd" : data.models[0].msgViewPk.langCd,
						"msgView" : data.models[0].msgView
					}
				} else if(type == "destroy") {
					var delData = {};
					
					$.each(data.models, function(index, item) {
						delData['msgList[' + index + '].msgViewPk.msgId'] = data.models[index].msgViewPk.msgId;
						delData['msgList[' + index + '].msgViewPk.langCd'] = data.models[index].msgViewPk.langCd;
					});
					
					return delData;
				} 
			}
		},
		schema: {
			 model: {
				 id: "msgId",
				 fields: {
					 "msgId": { type: "string", editable: false }
					}
				},
			data: "rows", 
			total: "count"
		},
		batch: true,
		pageSize: 10,
		serverPaging: true,
		serverFiltering: false,
		serverSorting: true
	};
	//언어타입
	lfo_common.msgLangType = [];
	//그리드 columns
	lfo_common.msgLangColumns = [{selectable : true, width:"50px"},{ field: "msgId", title: gfn_getMsg("col_msgId"), width: "100px" }];																								//메시지아이디
	//grid Search Field
	lfo_common.searchField = [];
	//기초코드에 등록된 언어만큼 생성한다.
	gfn_getCode("msgLangCode").forEach(function(item,index){
		langType = item.cdVal;
		lfo_common.msgLangType.push(langType);
		//grid Field
		dataSource.schema.model.fields[langType+"LangCd"] = { type: "string", editable: false };
		dataSource.schema.model.fields[langType+"MsgView"] = { type: "string"};
		dataSource.schema.model.fields[langType+"CdId"] = { type: "string"};
		dataSource.schema.model.fields[langType+"CdNm"] = { type: "string"};
		
		//grid columns
		lfo_common.msgLangColumns.push({ field: langType+"CdNm", template:"# var item =  gfn_isNull("+langType+"CdNm) == true ? '미등록' : "+langType+"CdNm # #= item #", title: gfn_getMsg("col_lang"), width: "40px" });			//코드명(언어)
		lfo_common.msgLangColumns.push({ field: langType+"MsgView", title: gfn_getMsg("col_msgView"), width: "190px" });																											//메세지(View)
		
		//grid Search Field
		lfo_common.searchField.push(langType+"MsgView");
	});
	$("#jteMasterGrid").kendoGrid({
		dataSource: dataSource,
		columns: lfo_common.msgLangColumns,
		dataBinding: function(e) {},
		cancel: function(e) {
			e.preventDefault();
			$("#jteMasterGrid").data("kendoGrid").dataSource.read();
		},
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
			mode:"popup"
		},
		edit:function(e){
			lfn_popupTemplate(e);
		},
		toolbar: [{ template: jteMtGrd_shAr },{template: jteMtGrd_addBtn},{ template: jteMtGrd_delBtn },{ template: jteMtGrd_refreshBtn }],
	});
} 

//Master Grid Select Box Binding
this.lfn_setSelBox = function(){
	var data = [
			{ text: gfn_getMsg("col_msgId"), value: "msgId" },													//메시지아이디
			{ text: gfn_getMsg("col_msgView"), value: "concat("+lfo_common.searchField.join(', ')+")" }			//메시지(View)
	];
	
	$("#jteMtGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: data,
		index: 0
	});	
}

//Master Grid Search Field Event Binding
this.lfn_eventBind = function(){
	$("#jteMtGrd_shSelTxt").keyup(function(e) {
		if(e.keyCode == 13) lfn_jteMtGrd_search();
	});
	
	$("#jteMasterGrid tbody").on("dblclick", "tr", function(e){
		//선택한 항목 바인드
//			var selectedItem = lfo_common.sgGrid.dataItem($(this));
		lfn_msgPop("EDT",$("#jteMasterGrid").data("kendoGrid").dataItem($(e.target).closest('tr')));
	});
}

this.lfn_msgPop = function(mode,selectedItem){
	var option ={
			mode : mode,
			saveCallback : function(){
				$("#jteMasterGrid").data("kendoGrid").dataSource.read();
			}
	};
	
	if(mode == 'EDT'){
		option.selectedItem = selectedItem;
	}
	gfn_msgSetPop(option);
}


//Master Grid Search
this.lfn_jteMtGrd_search = function(){
	$("#jteMasterGrid").data("kendoGrid").dataSource.read();	
}

//Master Grid Refresh
this.lfn_jteMtGrd_refresh = function(){
	$("#jteMtGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteMtGrd_shSelTxt").val("");
	
	var grid = $("#jteMasterGrid").data("kendoGrid");
	grid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	grid.dataSource.read();
}

//Master Grid Row Delete(복수 삭제 가능)
this.lfn_deleteRow = function(){
	var delPrmt = [];
	var grid = $("#jteMasterGrid").data("kendoGrid");
	kendo.confirm(gfn_getMsg("pop_setDeleteConfirm"))			//코드를 완전히 삭제하시겠습니까? 삭제하시면 복구가 불가능합니다.
	.done(function(){
		$("#jteMasterGrid .k-checkbox").each(function(index,item){
			if($(this).attr("aria-checked") == "true"){
				var dataRow = grid.dataItem($(this).closest('tr'));
				delPrmt.push(dataRow);
			}
		});
		
		$.ajax({
			async:false,
			url : "/form/basMgt/codMgt/msgMgt/deleteMsg",
			type: "POST",
			data: JSON.stringify(delPrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				grid.dataSource.read();
				gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	});
}
</script>
