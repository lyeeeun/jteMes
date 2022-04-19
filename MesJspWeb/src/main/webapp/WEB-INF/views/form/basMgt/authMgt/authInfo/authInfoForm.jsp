<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="grid-content" class="authInfoForm" style="width:100%;">
	<div id="jteSingleGrid" class="authInfoForm"></div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/authMgt/authInfo/authInfoForm_JJW.css' rel="stylesheet">

<script>
var lfo_common = {};//Form 내부에서 사용될 Object 
//var lva_authGrpGrid = $("#jteSimpleGrid").data("kendoGrid");

//검색영역
var jteSgGrd_shAr='<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteSgGrd_shSelBox\"/>'																						//검색(UI)
	+'<input type=\"text\" id=\"jteSgGrd_shSelTxt\" name=\"jteSgGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'									//조회(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteSgGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'			//조회버튼
	+'<input id=\"jteSgGrd_hidShSelBox\" type=\"hidden\">'
	+'<input id=\"jteSgGrd_hidShSelTxt\" type=\"hidden\">';
//추가버튼
var jteSgGrd_addBtn = '<a role=\"button\" class=\"k-button k-button-icontext k-grid-add\" href=\"\\\#"\><span class=\"k-icon k-i-plus\"></span>'+gfn_getMsg("btn_add")+'</a>';
//삭제버튼
var jteSgGrd_delBtn = '<a role=\"button\" class=\"k-button k-button-icontext k-grid-delete\" ><span class=\"k-icon k-i-close\"></span>'+gfn_getMsg("btn_delete")+'</a>';
//수정버튼
var jteSgGrd_modBtn = '<a role=\"button\" class=\"k-button k-button-icontext k-grid-edit\" ><span class=\"k-icon k-i-edit\"></span>'+gfn_getMsg("btn_update")+'</a>';
//새로고침
var jteSgGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteSgGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	lfo_common.ctrlUrl ="/form/basMgt/authMgt/authInfo";
	
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	//데이터 생성
	lfn_jteSgGrd_eventBind();
	
};

//grid 생성
this.lfn_jteSgGrd_setGrd = function(){
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : lfo_common.ctrlUrl+"/getAuthList",
				dataType : "json",
				traditional :true
			},create : {
				url : lfo_common.ctrlUrl + "/setAuthSave",
				dataType : "json"
			}, update: {
				url : lfo_common.ctrlUrl + "/setAuthUpdate",
				dataType : "json"
			},
			parameterMap: function(data, type){
				switch(type) {
				case "read" :
					var sort =[], order =[];
					$.each(data.sort, function(index,item) {
						sort.push(item.field);
						order.push(item.dir);
					});
				return {
					page: data.page,
					take: data.take,
					rows : data.pageSize,
					sort : sort,
					order : order,
					searchGubun:$("#jteSgGrd_hidShSelBox").val(),
					searchText:$("#jteSgGrd_hidShSelTxt").val()
				};
				case "create" :
					return data.models[0];
				case "update" :
					return {
						authId : data.models[0].authId, 
						reqSvcUri :data.models[0].reqSvcUri, 
						description:data.models[0].description
					};
				}	
			}
		},		
		batch: true,
		schema: {
			 model: {
				id: "authId",
				fields: {
					authId: { type: "string",
						validation: {
							required: true,
							rules: function (input) {
								if (input.is("[name='authId']")) {
								input.attr("권한 코드를 입력하세요");
								return input.val().length != 0 && input.val().trim().length != "";
								}
							return true;
							}
						}
					},
					reqSvcUri: { type: "string", 
						validation: {
							required: true,
							rules: function (input) {
								if (input.is("[name='reqSvcUri']")) {
								input.attr("권한 경로를 입력하세요");
								return input.val().length != 0 && input.val().trim().length != "";
								}
							return true;
							}
						}
					},
					description: { type: "string" }
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
	
	//grid 정의
	$("#jteSingleGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{selectable : true, width:40},
			{title:"No.", width:50, template: "#=++record #"},
			{field: "authId", editable: lfn_jteSgGrd_isEditable, title:gfn_getMsg("col_authId"), width: "20%"},				//권한코드
			{field: "reqSvcUri", title:gfn_getMsg("col_authPath"), width: "25%"},											//권한경로
			{field: "description", title:gfn_getMsg("col_desc"), width: "55%"},												//설명
			{title:gfn_getMsg("col_update"), command: [{name:"edit",text:gfn_getMsg("btn_update")}], width:205 }			//수정버튼(실효과)
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
			{template: kendo.template(jteSgGrd_delBtn)},
			{template: kendo.template(jteSgGrd_refreshBtn)}
			
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		}
	});
}

//inputbox 비활성화(insert 활성화, update 비활성) 
this.lfn_jteSgGrd_isEditable = function(e){
	return gfn_isNull(e.authId);
}

//검색이벤트
this.lfn_jteSgGrd_search = function(){
	$("#jteSgGrd_hidShSelBox").val($("#jteSgGrd_shSelBox").val());
	$("#jteSgGrd_hidShSelTxt").val($("#jteSgGrd_shSelTxt").val());
	/* $("#jteSingleGrid").data("kendoGrid").dataSource.read(); */
	$("#jteSingleGrid").data("kendoGrid").dataSource.query({
		page: 1,
		pageSize: 10
	});
}

/* 새로고침이벤트
	1. 검색구분, 검색 새로고침
	2. 페이징 정보 새로고침
*/
this.lfn_jteSgGrd_refresh = function(){
	$("#jteSgGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteSgGrd_shSelTxt").val("");
	$("#jteSgGrd_hidShSelBox").val("");
	$("#jteSgGrd_hidShSelTxt").val("");
	var grid = $("#jteSingleGrid").data("kendoGrid");
	grid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	/* grid.dataSource.read(); */
}

// 입력,수정 ValidationCheck
this.lfn_jteSgGrd_validation = function(e){
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
this.lfn_jteSgGrd_eventBind = function(){
	//검색 Selectbox 바인딩 
	var shBoxItem = [
			{ text: gfn_getMsg("col_authId"), value: "authId" },				//권한아이디
			{ text: gfn_getMsg("col_authPath"), value: "reqSvcUri" },			//권한경로
			{ text: gfn_getMsg("col_desc"), value: "description" }				//설명
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
	
	//삭제이벤트 바인딩
	$("#jteSingleGrid").find(".k-grid-toolbar").on("click", ".k-grid-delete", function (e) {
		kendo.confirm(gfn_getMsg("pop_confirmDelete"))			//삭제하시겠습니까?
		.done(function(){
			$(".k-checkbox").each(function(){
				if($(this).attr("aria-checked") == "true"){
					var dataItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(this).closest("tr"));
					var delPrmt = {authId : dataItem.authId};
					$.ajax({
						async:false,
						url : lfo_common.ctrlUrl + "/setAuthDelete",
						type: "POST",
						data: delPrmt,
						success: function(data){
							$("#jteSingleGrid").data("kendoGrid").dataSource.read();
							gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
						},error: function(ex){
							gfn_loading(false);
							gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
						}
					});
				}
			});
		})
	});
}
</script>