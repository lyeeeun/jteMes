<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="grid-content" class="grpAuthForm" style="width: 100%;">
	<div id="jteMasterGrid" class="grpAuthForm left-contents"></div>
	<div class="grpAuthForm middle-contents"><span><i class="fas fa-caret-square-right fa-3x"></span></i></div>
	<div id="jteSubGrid" class="grpAuthForm right-contents"></div>
</div>


<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/menuMgt/menuAuth/menuAuthForm_lym.css' rel="stylesheet" type="text/css"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/authMgt/grpAuth/grpAuthForm_JJW.css' rel="stylesheet">

<script>
var lfo_common = {};//권한그룹코드 Object

//검색영역
var jteMtGrd_shAr='<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteMtGrd_shSelBox\"/>' 																					//검색(UI)
	+'<input type=\"text\" id=\"jteMtGrd_shSelTxt\" name=\"jteMtGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'								//조회(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteMtGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'		//조회버튼
	+'<input id=\"jteMtGrd_hidShSelBox\" type=\"hidden\">'
	+'<input id=\"jteMtGrd_hidShSelTxt\" type=\"hidden\">'
	+'<input id=\"jteMtGrd_hidMtSelected\" type=\"hidden\">';
	
var jteSubGrd_shAr='<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteSubGrd_shSelBox\"/>'																				//검색(UI)
	+'<input type=\"text\" id=\"jteSubGrd_shSelTxt\" name=\"jteSubGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'								//조회(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteSubGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'		//조회버튼
	+'<input id=\"jteSubGrd_hidShSelBox\" type=\"hidden\">'
	+'<input id=\"jteSubGrd_hidShSelTxt\" type=\"hidden\">';
	
	

//추가버튼
var jteMtGrd_addBtn = '<a role=\"button\" class=\"k-button k-button-icontext k-grid-add\" href=\"\\\#"\><span class=\"k-icon k-i-plus\"></span>'+gfn_getMsg("btn_add")+'</a>';

//삭제버튼
var jteMtGrd_delBtn = '<a role=\"button\" class=\"k-button k-button-icontext k-grid-delete\" onclick=\"lfn_jteMtGrd_delete()\"><span class=\"k-icon k-i-close\"></span>'+gfn_getMsg("btn_delete")+'</a>';

var jteSubGrd_delBtn = '<a role=\"button\" class=\"k-button k-button-icontext k-grid-delete\"><span class=\"k-icon k-i-close\"></span>'+gfn_getMsg("btn_delete")+'</a>';

//새로고침 버튼
var jteMtGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteMtGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';

var jteSubGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteSubGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	lfo_common.mtCtrlUrl = "/form/basMgt/authMgt/grpAuth";
	lfo_common.subCtrlUrl = "/form/basMgt/authMgt/authInfo";
	
	//그리드 생성
	lfn_jteMtGrd_setGrd();
	
	//데이터 생성
	lfn_jteMtGrd_eventBind();
	
	lfo_common.masterGrid = $("#jteMasterGrid").getKendoGrid();
	lfo_common.subGrid = $("#jteSubGrid").getKendoGrid();
};

//MasterGrid 생성
this.lfn_jteMtGrd_setGrd = function(){
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : lfo_common.mtCtrlUrl + "/getRoleGrp",
				dataType : "json",
				traditional :true
			},create : {
				url : lfo_common.mtCtrlUrl + "/setRoleGrpInsert",
				dataType : "json"
			}, update: {
				url : lfo_common.mtCtrlUrl + "/setRoleGrpUpdate",
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
							searchGubun:$("#jteMtGrd_hidShSelBox").val(),
							searchText:$("#jteMtGrd_hidShSelTxt").val()
						};
					case "create":
						return data.models[0];
					case "update" : 
						return {
							roleId: data.models[0].roleId,
							roleNm: data.models[0].roleNm,
							description: data.models[0].description
						};
				}
			}
		},
		batch: true,
		schema: {
			 model: {
				id: "roleId",
				fields: {
					roleId: { type: "string", 
						validation: {
							required: true,
							rules: function (input) {
								if (input.is("[name='roleId']")) {
								input.attr("권한 그룹 코드를 입력하세요");
								return input.val().length != 0 && input.val().trim().length != "";
								}
							return true;
							}
						}
					},
					roleNm: { type: "string", 
						validation: {
							required: true,
							rules: function (input) {
								if (input.is("[name='roleNm']")) {
								input.attr("권한 그룹명을 입력하세요");
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
	
	//MasterGrid 정의
	$("#jteMasterGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{selectable : true, width:"50px"},
			{title:"No.", template: "#=++record #", width:"50px"},
			{field: "roleId", editable: lfn_jteMtGrd_isEditable, title:gfn_getMsg("col_authGrpCd"), width: "150px"}, 		//권한그룹코드
			{field: "roleNm", title:gfn_getMsg("col_authGrpNm"), width: "200px"}, 											//권한그룹명
			{field: "description", title:gfn_getMsg("col_desc"), width: "330px"}, 											//설명
			{title:gfn_getMsg("col_update"), command: [{name:"edit",text:gfn_getMsg("btn_update")}], width:"300px" }		//수정버튼(실제)
		],
// 		 save: function(e) {	//입력, 수정 이벤트
// 			 lfn_jteMtGrd_save(e);
// 		},
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
			{template: kendo.template(jteMtGrd_shAr)},
			{template: kendo.template(jteMtGrd_addBtn)},
			{template: kendo.template(jteMtGrd_delBtn)},
			{template: kendo.template(jteMtGrd_refreshBtn)}
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		}
	});
}


//SubGrid 생성
this.lfn_jteSubGrd_setGrd = function(){
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : lfo_common.subCtrlUrl + "/getGrpAuthList",
				dataType : "json",
				traditional :true
			},
			parameterMap: function(data, type){
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
					searchGubun:$("#jteSubGrd_hidShSelBox").val(),
					searchText:$("#jteSubGrd_hidShSelTxt").val(),
					dynamicField:"roleInfo.roleId",
					dynamicValue:$("#jteMtGrd_hidMtSelected").val()
				};
			}
		},
		schema: {
			data: "rows",
			total: "count"
 		},
		pageSize: 10,
		serverPaging: true,
		serverFiltering: false,
		serverSorting: true
	});
	
	//Subgrid 정의
	$("#jteSubGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{title:"No.", width:50, template: "#=++record #"},
			{field: "authId", title:gfn_getMsg("col_authId"), width: "20%"},			//권한코드
			{field: "reqSvcUri", title:gfn_getMsg("col_authPath"), width: "20%"}, 		//권한경로
			{field: "description", title:gfn_getMsg("col_desc"), width: "45%"}, 		//설명
			{field: "isUse", title:gfn_getMsg("col_isuse"), width:"15%",				//사용유무
 				template : function(rows) {
 					if(rows.use){
 						return "<a onclick='lfn_jteSubGrd_changeInclude(\""+rows.authId+"\", \""+rows.use+"\")'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
 					}else{
 						return "<a onclick='lfn_jteSubGrd_changeInclude(\""+rows.authId+"\", \""+rows.use+"\")'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
 					}
 				}
			}
			/* {field: "isUse", title:"사용유무", width: "15%"} */
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
//inputbox 비활성화(insert 활성화, update 비활성) 
this.lfn_jteMtGrd_isEditable = function(e){
	return gfn_isNull(e.roleId);
}

//검색이벤트
this.lfn_jteMtGrd_search = function(){
	$("#jteMtGrd_hidShSelBox").val($("#jteMtGrd_shSelBox").val());
	$("#jteMtGrd_hidShSelTxt").val($("#jteMtGrd_shSelTxt").val());
	
	$("#jteMasterGrid").data("kendoGrid").dataSource.read();
}

//검색이벤트
this.lfn_jteSubGrd_search = function(){
	$("#jteSubGrd_hidShSelBox").val($("#jteSubGrd_shSelBox").val());
	$("#jteSubGrd_hidShSelTxt").val($("#jteSubGrd_shSelTxt").val());
	
	$("#jteSubGrid").data("kendoGrid").dataSource.read();
}

this.lfn_jteMtGrd_delete = function(){
	kendo.confirm(gfn_getMsg("pop_confirmDelete"))			//삭제하시겠습니까?
	.done(function(){
		var delPrmt = [];
		$(".k-checkbox").each(function(){
			if($(this).attr("aria-checked") == "true"){
				var dataItem = $("#jteMasterGrid").data("kendoGrid").dataItem($(this).closest("tr"));
				delPrmt.push(dataItem.roleId);
			}
		});
		$.ajax({
			async:false,
			url : lfo_common.mtCtrlUrl + "/setRoleGrpDelete",
			type: "POST",
			data: {roleIds : delPrmt},
			success: function(data){
				$("#jteMasterGrid").data("kendoGrid").dataSource.read();
				gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	});
}

/* 새로고침이벤트
1. 검색구분, 검색 새로고침
2. 페이징 정보 새로고침
*/
this.lfn_jteMtGrd_refresh = function(){
	$("#jteMtGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteMtGrd_shSelTxt").val("");
	$("#jteMtGrd_hidShSelBox").val("");
	$("#jteMtGrd_hidShSelTxt").val("");
	lfo_common.masterGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	lfo_common.masterGrid.dataSource.read();
}


/* 새로고침이벤트
1. 검색구분, 검색 새로고침
2. 페이징 정보 새로고침
*/
this.lfn_jteSubGrd_refresh = function(){
	$("#jteSubGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteSubGrd_shSelTxt").val("");
	$("#jteSubGrd_hidShSelBox").val("");
	$("#jteSubGrd_hidShSelTxt").val("");
	
	lfo_common.subGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	lfo_common.subGrid.dataSource.read();
}


this.lfn_jteMtGrd_validation = function(e){
	if(gfn_isNull(e.roleId)){
		gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
		return false;
	}
	return true;
}

//이벤트 바인딩
this.lfn_jteMtGrd_eventBind = function(){
	
	//검색 Selectbox 바인딩 
	var data = [
			{ text: gfn_getMsg("col_authGrpCd"), value: "roleId" },			//권한그룹코드
			{ text: gfn_getMsg("col_authGrpNm"), value: "roleNm" },			//권한그룹명
			{ text: gfn_getMsg("col_desc"), value: "description" }			//설명
		];
	$("#jteMtGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: data,
		index: 0
	});
	
	$("#jteMtGrd_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_jteMtGrd_search();
		}
	});
	
	//마스터테이블 더블 클릭
	$("#jteMasterGrid tbody").on("dblclick", "tr", function(e){
		//선택한 항목 바인드
		var selectedItem = lfo_common.masterGrid.dataItem($(this));
		$("#jteMtGrd_hidMtSelected").val(selectedItem.roleId);
		
		//그리드가 최초생성인지 판단
		if(gfn_isNull($("#jteSubGrid").data("kendoGrid"))){
			//그리드 최초생성
			lfn_jteSubGrd_setGrd();
			
			//그리드 기초 바인딩
			lfn_jteSubGrd_eventBind();
			lfo_common.subGrid = $("#jteSubGrid").getKendoGrid();
			
		}else{
			//그리드 리로드
			$("#jteSubGrid").data("kendoGrid").dataSource.read();
		}
	});
}

//이벤트 바인딩
this.lfn_jteSubGrd_eventBind = function(){
	
	//검색 Selectbox 바인딩 
	var data = [
			{ text: gfn_getMsg("col_authId"), value: "authId" },				//권한코드
			{ text: gfn_getMsg("col_authPath"), value: "reqSvcUri" },			//권한경로		<03.27> .. ymlee value값 roleNm에서 reqSvcUri로 변경
			{ text: gfn_getMsg("col_desc"), value: "description" }				//설명
		];
	
	$("#jteSubGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: data,
		index: 0
	});
	
	$("#jteSubGrd_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_jteSubGrd_search();
		}
	});
}


this.lfn_jteSubGrd_changeInclude = function(authId,isInclude){
	var AppendPrmt={"roleId":$("#jteMtGrd_hidMtSelected").val(),"authId":authId,"isInclude":isInclude};
	kendo.confirm(gfn_getMsg("pop_confirmUpdate"))			//수정하시겠습니까?
	.done(function(){
		$.ajax({
			async:false,
			url : lfo_common.subCtrlUrl + "/setGrpAuthInclude",
			type: "POST",
 			contentType: "application/json",
 			data: JSON.stringify(AppendPrmt),
			dataType : 'json',
			success: function(data){
				$("#jteSubGrid").data("kendoGrid").dataSource.read();
				gfn_msgBox({msg:gfn_getMsg("pop_updateSuccess")});			//성공적으로 수정되었습니다.
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	});
}

</script>