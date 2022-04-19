<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="grid-content" class="posInfoForm" style="width:100%;">
	<div id="jteSingleGrid" class="posInfoForm"></div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/belngMgt/posInfo/posInfoForm_JJW.css' rel="stylesheet">

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
//03.26 ymlee UI 수정 Error
var jteSgGrd_modBtn = '<a role=\"button\" class=\"k-button k-button-icontext k-grid-edit\" ><span class=\"k-icon k-i-edit\"></span>'+gfn_getMsg("btn_update")+'</a>';
//새로고침
var jteSgGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteSgGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	lfo_common.ctrlUrl ="/form/basMgt/belngMgt/posInfo";
	
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	//데이터 생성
	lfn_jteSgGrd_eventBind();
	
	lfo_common.sgGrid = $("#jteSingleGrid").getKendoGrid();	
};

//grid 생성
this.lfn_jteSgGrd_setGrd = function(){
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : lfo_common.ctrlUrl+"/getPositionList",
				dataType : "json",
				traditional :true
			},create : {
				url : lfo_common.ctrlUrl + "/setPositionSave",
				dataType : "json",
				complete: function(e) {
					lfo_common.sgGrid.dataSource.read();
				}
			}, update: {
				url : lfo_common.ctrlUrl + "/setPositionSave",
				dataType : "json",
				complete: function(e) {
					lfo_common.sgGrid.dataSource.read();
				}
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
					data.models[0].use = true;
					return data.models[0];
				case "update" :
					return data.models[0];
				}	
			}
		},		
		batch: true,
		schema: {
			 model: {
				id: "positionId",
				fields: {
					positionId: { type: "string", 
						validation: {
							required: true,
							rules: function (input) {
								if (input.is("[name='positionId']")) {
								input.attr("직급코드를 입력하세요");
								return input.val().length != 0 && input.val().trim().length != "";
								}
							return true;
							}
						}
					},
					positionNm: { type: "string", 
						validation: {
							required: true,
							rules: function (input) {
								if (input.is("[name='positionNm']")) {
								input.attr("직급명을 입력하세요");
								return input.val().length != 0 && input.val().trim().length != "";
								}
							return true;
							}
						}
					},
					positionSeq: { type: "int", 
						validation: {
							required: true,
							rules: function (input) {
								if (input.is("[name='positionSeq']")) {
								input.attr("순서를 입력하세요");
								return input.val().length != 0 && input.val().trim().length != "";
								}
							return true;
							}
						}
					},
					isUse: { type: "bool" }
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
			{selectable : true, width:"50px"},
			{title:"No.", width:"50px", template: "#=++record #"},
			{field: "positionId", editable: lfn_jteSgGrd_isEditable, title:gfn_getMsg("col_positionCd"), width: "150px"},			//직급코드
			{field: "positionNm", title:gfn_getMsg("col_positionNm"), width: "200px"},												//직급명
			{field: "positionSeq" , title:gfn_getMsg("col_sequence"), width: "120px"},												//순서
			{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"120px",						//사용유무
 				template : function(rows) {
 					if(rows.use == true){
 						return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
 					}else if (rows.use == false){
 						return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
 					}else{
 						return ""+gfn_getMsg("val_basic")+" : Y";																	//기본
 					}
 				}
			},
			{title:gfn_getMsg("col_update"), command: [{name:"edit",text:gfn_getMsg("btn_update")}], width:"300px" }				//수정버튼(실제)
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
	return gfn_isNull(e.positionId);
}
//inputbox 비활성화(insert 활성화, update 비활성) 
this.lfn_jteSgGrd_isEditable2 = function(e){
	return false;
}
//검색이벤트
this.lfn_jteSgGrd_search = function(){
	$("#jteSgGrd_hidShSelBox").val($("#jteSgGrd_shSelBox").val());
	$("#jteSgGrd_hidShSelTxt").val($("#jteSgGrd_shSelTxt").val());
	/* lfo_common.sgGrid.dataSource.read(); */
	lfo_common.sgGrid.dataSource.query({
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
	/* lfo_common.sgGrid.dataSource.read(); */
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
			{ text: gfn_getMsg("col_positionCd"), value: "positionId" },			//직급코드
			{ text: gfn_getMsg("col_positionNm"), value: "positionNm" }				//직급명
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
	
	
	this.lfn_jteSgGrd_changeIsUse = function(rows){
		var dataItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr"));
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setPositionUseUpdate",
			type: "POST",
 			data: JSON.stringify(dataItem),
 			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
// 				gfn_msgBox({msg:"성공적으로 등록되었습니다."});
				lfo_common.sgGrid.dataSource.read();
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	//삭제이벤트 바인딩
	$("#jteSingleGrid").find(".k-grid-toolbar").on("click", ".k-grid-delete", function (e) {
		kendo.confirm(gfn_getMsg("pop_confirmDelete"))
		.done(function(){
			var delPrmt = [];
			$(".k-checkbox").each(function(index,item){
				if($(this).attr("aria-checked") == "true"){
					var dataItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(this).closest("tr"));
					delPrmt.push(dataItem);
				}
			});
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + "/setPositionDelete",
				type: "POST",
				data: JSON.stringify(delPrmt),
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					lfo_common.sgGrid.dataSource.read();
					gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		})
	});
}
</script>