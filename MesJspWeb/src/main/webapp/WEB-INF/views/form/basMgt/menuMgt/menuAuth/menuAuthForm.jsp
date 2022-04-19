<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="grid-content" class="menuAuthForm" style="width: 100%;">
	<div id="jteMasterGrid" class="menuAuthForm left-contents jteMasterGrid"></div>
	<div class="menuAuthForm middle-contents"><span><i class="fas fa-caret-square-right fa-3x"></i></span></div>
	<div id="jteSubTree" class="menuAuthForm right-contents jteSubTree"></div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/menuMgt/menuAuth/menuAuthForm_lym.css' rel="stylesheet" type="text/css"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/menuMgt/menuAuth/menuAuthForm_JJW.css' rel="stylesheet">


<script>
var lfo_common = {};//공통 Object

//검색영역
var jteMtGrd_shAr='<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteMtGrd_shSelBox\"/>'																						//검색(UI)
	+'<input type=\"text\" id=\"jteMtGrd_shSelTxt\" name=\"jteMtGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'									//조회(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteMtGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'			//조회버튼
	+'<input id=\"jteMtGrd_hidShSelBox\" type=\"hidden\">'
	+'<input id=\"jteMtGrd_hidShSelTxt\" type=\"hidden\">'
	+'<input id=\"jteMtGrd_hidSelected\" type=\"hidden\">';
	
//새로고침 버튼
var jteMtGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteMtGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfo_common.ctrlUrl = "/form/basMgt/menuMgt/menuAuth";
	
	lfn_jteMtGrd_setGrd();
	
	lfn_jteMtGrd_eventBind();
	
	lfo_common.mtGrid = $("#jteMasterGrid").getKendoGrid();
	
};

//main - grid 생성
this.lfn_jteMtGrd_setGrd = function(){
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : lfo_common.ctrlUrl+"/getAuthList",
				dataType : "json",
				traditional :true
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
				}
			}
		},		
		batch: true,
		schema: {
			 model: {
				id: "roleId",
					fields: {
						roleId: { type: "string" },
						roleNm: { type: "string" },
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
	$("#jteMasterGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{title:"No.", template: "#=++record #", width:"50px"},
			{field: "roleId", editable: lfn_jteMtGrd_isEditable, title:gfn_getMsg("col_authGrpCd"), width: "150px"},			//권한그룹코드
			{field: "roleNm", title:gfn_getMsg("col_authGrpNm"), width: "200px"},												//권한그룹명
			{field: "description", title:gfn_getMsg("col_desc"), width: "250px"}												//설명
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
			{template: kendo.template(jteMtGrd_shAr)},
			{template: kendo.template(jteMtGrd_refreshBtn)}
			
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		},
		
	});
}

//검색이벤트
this.lfn_jteMtGrd_search = function(){
	$("#jteMtGrd_hidShSelBox").val($("#jteMtGrd_shSelBox").val());
	$("#jteMtGrd_hidShSelTxt").val($("#jteMtGrd_shSelTxt").val());
	lfo_common.mtGrid.dataSource.read();
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
	
	lfo_common.mtGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	lfo_common.mtGrid.dataSource.read();
}

// 입력,수정 ValidationCheck
this.lfn_jteMtGrd_validation = function(e){
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
this.lfn_jteMtGrd_eventBind = function(){
	//검색 Selectbox 바인딩 
	var shBoxItem = [
			{ text: gfn_getMsg("col_authGrpCd"), value: "roleId" },			//권한그룹코드
			{ text: gfn_getMsg("col_authGrpNm"), value: "roleNm" },			//권한그룹명
			{ text: gfn_getMsg("col_desc"), value: "description" }			//설명
		];
	$("#jteMtGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: shBoxItem,
		index: 0
	});
	
	//검색박스 엔터 이벤트
	$("#jteMtGrd_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_jteMtGrd_search();
		}
	});
	
	//마스터테이블 더블 클릭
	$("#jteMasterGrid tbody").on("dblclick", "tr", function(e){
		//선택한 항목 바인드
		selectedItem = lfo_common.mtGrid.dataItem($(e.target).closest('tr'));
		
		lfo_common.subTreeExpand = [];
		
		$("#jteMtGrd_hidSelected").val(selectedItem.roleId);
		if($("#jteSubTree").html() == ""){
			lfn_jteSubTree_setTree();
			lfo_common.subTree = $("#jteSubTree").data("kendoTreeView");
		}else{
			lfo_common.subTree.dataSource.read();
		}
		
		setTimeout(function() {
			lfo_common.subTree.expand(".k-item");
		}, 300);
	});

}

this.lfn_jteSubTree_setTree = function(){
	
	dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: lfo_common.ctrlUrl + "/getMenuRoleTree",
				dataType: "json"
			},
			parameterMap: function(data, type){
				switch(type) {
				case "read" :
					return {
						menuId: data.menuId,
						roleId:$("#jteMtGrd_hidSelected").val()
					};
				}
			}
		},
		schema: {
			model: {
				id: "menuId",
				hasChildren: "hasChildren",
				fields: {
					roleId: { type: "string" },
					menuId: { type: "string" },
					menuNm: { type: "string" }
				}
			}
		}
	});
	
	$("#jteSubTree").kendoTreeView({
		dataSource: dataSource,
		template: '<span>#= item.menuNm #</span>'+
		' #if (item.roleId != null)'
		+'{# <a onclick="lfn_jteSubGrd_changeIsUse(this)"><img src="/resources/mes/img/useY.png" style="width:25px;"/></a> #}'
		+'else{# <a onclick="lfn_jteSubGrd_changeIsUse(this)"><img src="/resources/mes/img/useN.png" style="width:25px;"/></a> #}#',
		expand : lfn_jteSubTree_expandPush,
		collapse : lfn_jteSubTree_expandPop
		//전체 확장 dataBound: function(){this.expand('.k-item');}
	});
}

this.lfn_jteSubTree_expandPush = function(e){
	var item = lfo_common.subTree.dataItem(e.node);
	lfo_common.subTreeExpand.push(item.menuId);
}

this.lfn_jteSubTree_expandPop = function(e){
	var item = lfo_common.subTree.dataItem(e.node);
	lfo_common.subTreeExpand.pop(item.menuId);
}

//잠금유무
this.lfn_jteSubGrd_changeIsUse = function(rows){
	var dataItem = lfo_common.subTree.dataItem($(rows).closest("li"));
	var prmt = {menuId : dataItem.menuId, roleId : $("#jteMtGrd_hidSelected").val()};
	if(dataItem.roleId == null){
		prmt.action = "C"
	}else{
		prmt.action = "D"
	}
	 $.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/setMenuRoleSave",
		type: "POST",
		data: prmt,
		success: function(data){
			if(data > 0){
				lfo_common.subTree.dataSource.read();
				setTimeout(function() {
					lfo_common.subTree.expandPath(lfo_common.subTreeExpand);
				}, 300);
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	}); 
}

</script>