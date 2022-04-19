<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="baseSetMgtForm" style="width:100%;">
	<div id="jteMasterGrid" class="jteGrid baseSetMgtForm" style="width:100%;">
	</div>
</div>


<input type="hidden" id="hidSelBiz" value="none">
<input type="hidden" id="hidSelMasterCode" value="none">

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/codMgt/baseSetMgt/baseSetMgtForm_JJW.css' rel="stylesheet">

<script type="text/javascript">
/**
 * /codeMgt/codeMgtForm
*/

// windows resize & grid resize
this.lfn_init = function(){
	this.lfn_masterGridBind();
	this.lfn_eventBind();
}


//Grid selected row delete function
this.lfn_deleteRow = function(gridGubun){
	var delPrmt = [];
	var grid = $("#" + gridGubun).data("kendoGrid");
	kendo.confirm(gfn_getMsg("pop_setDeleteConfirm"))			//코드를 완전히 삭제하시겠습니까? 삭제하시면 복구가 불가능합니다.
	.done(function(){
		$("#"+ gridGubun +" .k-checkbox").each(function(index,item){
			if($(this).attr("aria-checked") == "true"){
				var dataRow = grid.dataItem($(this).closest('tr'));
				delPrmt.push(dataRow);
			}
		});
		
		$.ajax({
			async:false,
			url : "/form/basMgt/codMgt/baseSetMgt/delBaseSet",
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

this.lfn_eventBind = function(){
	$("#jteMtGrd_shSelTxt").keyup(function(e) {
		if(e.keyCode == 13) lfn_jteMtGrd_search("jteMasterGrid");
	});
	
};

this.lfn_jteMtGrd_search = function(gridGubun){
	$("#" + gridGubun).data("kendoGrid").dataSource.read();
}

this.lfn_masterGridBind = function(){
	
	var searchBox = kendo.template("<input type=\"text\" id=\"jteMtGrd_shSelTxt\" name=\"jteMtGrd_shSelTxt\" class=\"k-textbox\" placeholder=\""+gfn_getMsg("input_search")+"\"/>"								//조회(Input)
			+"<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteMtGrd_search('jteMasterGrid') \"><span class=\"k-icon k-i-search\"></span>"+gfn_getMsg("btn_search")+"</a>");			//조회버튼
		
	// 삭제 버튼
	var delButton = kendo.template("<a role='button' class='k-button k-button-icontext k-grid-delete' onclick=\"lfn_deleteRow('jteMasterGrid');\"><span class='k-icon k-i-close'></span>"+gfn_getMsg("btn_delete")+"</a>" ) 
	
	$("#jteMasterGrid").kendoGrid({
		dataSource: {
			transport: {
				read: {
					url : "/form/basMgt/codMgt/baseSetMgt/getBaseSet",
					dataType : "json"
				},
				create: {
					url : "/form/basMgt/codMgt/baseSetMgt/addBaseSet",
					dataType : "json"
				},
				update: {
					url : "/form/basMgt/codMgt/baseSetMgt/setBaseSet",
					dataType : "json"
				},
				destroy: {
					url : "/form/basMgt/codMgt/baseSetMgt/delBaseSet",
					dataType : "json"
				},
				parameterMap: function(data, type){
					var order = "";

					switch(type) {
					case "read" :
						if(data.sort && data.sort.length > 0) {
							$.each(data.sort, function(index, item) {
								order += item.field + ' ' + item.dir + ',';	
							})
							order = order.substring(0, order.length -1);
						}
						return {
							page : data.page,
							take : data.take,
							rows : data.pageSize, 
							sort : order,
							cdId : $('#jteMtGrd_shSelTxt').val(),
							upCdId: "sys"
						};
					case "create" :
						return {
							cdId : data.models[0].cdId,
							cdNm : data.models[0].cdNm,
							cdVal : data.models[0].cdVal,
							description : data.models[0].description,
							useYn : data.models[0].useYn,
							creatorId : _loginUserUsername.value,
							updatorId : _loginUserUsername.value,
							upCdId: "sys"
						};
					case "update" :
						return {
							cdId : data.models[0].cdId,
							cdNm : data.models[0].cdNm,
							cdVal : data.models[0].cdVal,
							description : data.models[0].description,
							useYn : data.models[0].useYn,
							updatorId : _loginUserUsername.value,
							upCdId: "sys"
						};
					case "destroy" :
						var delData = {};
						
						$.each(data.models, function(index, item) {
							delData['baseCodeList[' + index + '].cdId'] = item.cdId
							delData['baseCodeList[' + index + '].upCdId'] = item.upCdId;
						});
						
						return delData;
					} 
				}
			},
			schema: {
				 model: {
					 id: "cdId",
					 fields: {
						cdId: { type: "string" },
						upCdId: { type: "string" },
						cdNm: { type: "string" },
						cdVal: { type: "string" },
						description: { type: "string" },
						updatorId: { type: "string", editable: false },
						updatedAt: { type: "string", editable: false },
						useYn: { 
							type: "string", 
						 	validation: {
								required: true,
								useYnvalidation: function (input) {
									if (input.is("[name='useYn']")) {
									input.attr("data-useYnvalidation-msg", "Y, N만 입력 가능합니다.");
									return /^[YN]$/.test(input.val());
									}
								return true;
								}
							}	
						}
						}
					},
				data: "rows", 
				total: "count"
			},
			batch: true,
			pageSize: 10,
			serverPaging: true,
			serverFiltering: false,
			serverSorting: true,
			requestEnd: function(e) {
				if (e.type != "read") {
					if (e.response.result != -1) {
						e.sender.read();
					} else {
						alert(e.response.Errors);
					}
				}
			}
		},
		allowCopy:true,
		resizable: true,
 		columnMenu: true,
 		sortable: {
			mode: "multiple",
			allowUnsort: true
		},
		navigatable: true,
		pageable: {
			pageSizes: true
		},
		editable: {
			mode:"inline"
		},
		edit: function(e) {
			if (!e.model.isNew()) {
				$(e.container).find("input[name='cdId']").prop('disabled', true);
			}  
		},
		toolbar:[{ template: searchBox },{name:"create", text:gfn_getMsg("btn_add")},{ template: delButton }],			//추가
		dataBinding: function(e) {
		},
		columns: [
			{selectable : true, width:40},
			{ field: "cdId", title: gfn_getMsg("col_cdId"), width: "15%" },												//코드
			{ field: "cdNm", title: gfn_getMsg("col_cdNm"), width: "15%" },												//코드명
			{ field: "cdVal", title: gfn_getMsg("col_cdVal"), width: "15%" },											//코드값
			{ field: "description", title: gfn_getMsg("col_desc"), width: "30%" },										//설명
			{ field: "useYn", title: gfn_getMsg("col_cdUseYn"), width: "10%" },											//사용유무
			{ field: "updatorId", title: gfn_getMsg("col_updateId"), width: "15%" },									//수정자
			{ command: [{name:"edit",text:gfn_getMsg("btn_update")}], width:100 }										//수정버튼(실제)
		]
	});
}

</script>
