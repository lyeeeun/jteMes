<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="baseCodeMgtForm" style="width:100%;">
	<div id="jteMasterGrid" class="jteGrid baseCodeMgtForm" style="width:39.5%; height:100%; float:left;">
	</div>
	<div id="jteSubGrid" class="jteGrid baseCodeMgtForm" style="width: 59.5%; height:100%; float:right;">
	</div>
</div>


<input type="hidden" id="hidSelBiz" value="none">
<input type="hidden" id="hidSelMasterCode" value="none">

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/codMgt/baseCodeMgt/baseCodeMgtForm_JJW.css' rel="stylesheet">

<script type="text/javascript">
/**
 * /codeMgt/codeMgtForm
*/
//공통 오브젝트 
var lfo_common = {};
// windows resize & grid resize
this.lfn_init = function(){
	this.lfn_masterGridBind();
	this.lfn_setSelBox();
	this.lfn_subGridBind();
	this.lfn_eventBind();
	lfn_jteMtGrd_SelBoxChange();
	setTimeout(function(){$("#jteMasterGrid tbody tr:first").dblclick();},300);
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
			url : "/form/basMgt/codMgt/baseCodeMgt/delCode",
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
	//마스터테이블 더블 클릭
	$("#jteMasterGrid tbody").on("dblclick", "tr", function(e){
		//선택한 항목(Row)
		var selectedItem = $("#jteMasterGrid").getKendoGrid().dataItem($(this));
		
		$("#hidSelMasterCode").val(selectedItem.cdId);

		//그리드 리로드
		$("#jteSubGrid").data("kendoGrid").dataSource.read();
	});
	
	$("#jteMtGrd_shSelTxt").keyup(function(e) {
		if(e.keyCode == 13) lfn_jteMtGrd_search("jteMasterGrid");
	});
	
	$("#jteSubGrd_shSelTxt").keyup(function(e) {
		if(e.keyCode == 13) lfn_jteMtGrd_search("jteSubGrid");
	});
};

//Master Grid Select Box Binding
this.lfn_setSelBox = function(){
	var dropDownData = new Array();
	//선택 주석
	//dropDownData.push({ text: "--"+gfn_getMsg("slctbox_select")+"--", value: "" });

	$.each( gfn_getCode('biz'), function(index, item) {
		dropDownData.push({ text: gfn_getMsg('bc_' + item.cdId, item.cdNm) , value: item.cdId });
	});
	
	$("#jteMtGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: dropDownData,
		index: 0,
		change:lfn_jteMtGrd_SelBoxChange
	});
}

this.lfn_jteMtGrd_SelBoxChange = function(){
	var selectedItem = $("#jteMtGrd_shSelBox").data("kendoDropDownList");
	$('#hidSelBiz').val(selectedItem.value());
	$("#jteMasterGrid").data("kendoGrid").dataSource.read();
}

this.lfn_jteMtGrd_search = function(gridGubun){
	$("#" + gridGubun).data("kendoGrid").dataSource.read();
}

this.lfn_masterGridBind = function(){
	// 업무 구분 선택 박스(ex: 수주, 제품, 공정 등), 검색 박스
	var bizSelBox = kendo.template("<input id=\"jteMtGrd_shSelBox\"/>"
		+"<input type=\"text\" id=\"jteMtGrd_shSelTxt\" name=\"jteMtGrd_shSelTxt\" class=\"k-textbox\" placeholder=\""+gfn_getMsg("input_search")+"\"/>"													//조회(Input) 
		+"<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteMtGrd_search('jteMasterGrid') \"><span class=\"k-icon k-i-search\"></span>"+gfn_getMsg("btn_search")+"</a>");			//조회버튼
	
	// 삭제 버튼
	var delButton = kendo.template("<a role='button' class='k-button k-button-icontext k-grid-delete' onclick=\"lfn_deleteRow('jteMasterGrid');\"><span class='k-icon k-i-close'></span>"+gfn_getMsg("btn_delete")+"</a>" ) 
	
	$("#jteMasterGrid").kendoGrid({
		dataSource: {
			transport: {
				read: {
					url : "<c:url value="/form/basMgt/codMgt/baseCodeMgt/getCode"/>",
					dataType : "json"
				},
				create: {
					url : "<c:url value="/form/basMgt/codMgt/baseCodeMgt/addCode"/>",
					dataType : "json",
					contentType : 'application/json'
				},
				update: {
					url : "<c:url value="/form/basMgt/codMgt/baseCodeMgt/setCode"/>",
					dataType : "json",
					contentType : 'application/json'
				},
				destroy: {
					url : "<c:url value="/form/basMgt/codMgt/baseCodeMgt/delCode"/>",
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
							upCdId: $('#hidSelBiz').val()
						};
					case "create" :
						return JSON.stringify({
							cdId : data.models[0].cdId,
							cdNm : data.models[0].cdNm,
							cdVal : data.models[0].cdVal,
							sortNum : data.models[0].sortNum,
							description : data.models[0].description,
							cdReserve01 : data.models[0].cdReserve01,
							cdReserve02 : data.models[0].cdReserve02,
							cdReserve03 : data.models[0].cdReserve03,
							cdReserve04 : data.models[0].cdReserve04,
							useYn : data.models[0].useYn,
							creatorId : _loginUserUsername.value,
							updatorId : _loginUserUsername.value,
							upCdId: $('#hidSelBiz').val()
						});
					case "update" :
						
						return JSON.stringify({
							cdId : data.models[0].cdId,
							cdNm : data.models[0].cdNm,
							cdVal : data.models[0].cdVal,
							description : data.models[0].description,
							sortNum : data.models[0].sortNum,
							cdReserve01 : data.models[0].cdReserve01,
							cdReserve02 : data.models[0].cdReserve02,
							cdReserve03 : data.models[0].cdReserve03,
							cdReserve04 : data.models[0].cdReserve04,
							useYn : data.models[0].useYn,
							updatorId : _loginUserUsername.value,
							upCdId: $('#hidSelBiz').val()
						});
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
						cdId: { type: "string",
							validation: {
								required: true,
								rules: function (input) {
									if (input.is("[name='cdId']")) {
									input.attr("코드를 입력하세요");
									return input.val().length != 0 && input.val().trim().length != "";
									}
								return true;
								}
							}
						},
						upCdId: { type: "string" },
						cdNm: { type: "string",
							validation: {
								required: true,
								rules: function (input) {
									if (input.is("[name='cdNm']")) {
									input.attr("코드명을 입력하세요");
									return input.val().length != 0 && input.val().trim().length != "";
									}
								return true;
								}
							}
						},
						cdVal: { type: "string" },
						description: { type: "string" },
						updatorId: { type: "string", editable: false },
						updatedAt: { type: "string", editable: false },
						sortNum : {type:"int"},
						useYn: { 
							type: "string", 
							defaultValue : 'Y',
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
						gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
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
		toolbar:[{ template: bizSelBox },{name:"create", text:gfn_getMsg("btn_add")},{ template: delButton }],
		dataBinding: function(e) {
		},
		columns: [
			{selectable : true, width:"50px"},
			{ field: "cdId", title: gfn_getMsg("col_cdId"), width: "150px" },					//코드
			{ field: "cdNm", title: gfn_getMsg("col_cdNm"), width: "200px" },					//코드명
			{ field: "description", title: gfn_getMsg("col_desc"), width: "250px" },			//설명
			{ field: "sortNum", title: gfn_getMsg("col_sortNum","순서"), width: "80px" },			//순서
			{ field: "useYn", title: gfn_getMsg("col_cdUseYn"), width: "105px" },				//사용유무
			{ field: "cdReserve01", title: "예비필드1", width: "105px" },							//예비필드
			{ field: "updatorId", title: gfn_getMsg("col_updateId"), width: "100px" },			//수정자
			{ command: [{name:"edit",text:gfn_getMsg("btn_update")}], width:"200px" }			//수정버튼(실제)
		]
	});
}



this.lfn_subGridBind = function(){
	
	var searchBox = kendo.template("<input type=\"text\" id=\"jteSubGrd_shSelTxt\" name=\"jteSubGrd_shSelTxt\" class=\"k-textbox\" placeholder=\""+gfn_getMsg("input_search")+"\"/>"					//조회(Input)
		+"<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteMtGrd_search('jteSubGrid') \"><span class=\"k-icon k-i-search\"></span>"+gfn_getMsg("btn_search")+"</a>");			//조회버튼
	
	// 삭제 버튼
	var delButton = kendo.template("<a role='button' class='k-button k-button-icontext k-grid-delete' onclick=\"lfn_deleteRow('jteSubGrid');\"><span class='k-icon k-i-close'></span>"+gfn_getMsg("btn_delete")+"</a>" ) 
	
	$("#jteSubGrid").kendoGrid({
		dataSource: {
			transport: {
				read: {
					url : "<c:url value="/form/basMgt/codMgt/baseCodeMgt/getCode"/>",
					dataType : "json"
				},
				create: {
					url : "<c:url value="/form/basMgt/codMgt/baseCodeMgt/addCode"/>",
					traditional :true,
					dataType : "json",
					contentType : 'application/json'
				},
				update: {
					url : "<c:url value="/form/basMgt/codMgt/baseCodeMgt/setCode"/>",
					traditional :true,
					dataType : "json",
					contentType : 'application/json'
				},
				destroy: {
					url : "<c:url value="/form/basMgt/codMgt/baseCodeMgt/delCode"/>",
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
							cdId : $('#jteSubGrd_shSelTxt').val(),
							upCdId: $('#hidSelMasterCode').val()
						};
					case "create" :
						return JSON.stringify({
							cdId : data.models[0].cdId,
							cdNm : data.models[0].cdNm,
							cdVal : data.models[0].cdVal,
							cdReserve01 : data.models[0].cdReserve01,
							cdReserve02 : data.models[0].cdReserve02,
							cdReserve03 : data.models[0].cdReserve03,
							cdReserve04 : data.models[0].cdReserve04,
							description : data.models[0].description,
							sortNum : data.models[0].sortNum,
							useYn : data.models[0].useYn,
							creatorId : _loginUserUsername.value,
							updatorId : _loginUserUsername.value,
							upCdId: $('#hidSelMasterCode').val(),
							msgList: gfn_isNull(lfo_common.msgTemp) == true ? null : lfo_common.msgTemp
						});
					case "update" :
						return JSON.stringify({
							cdId : data.models[0].cdId,
							cdNm : data.models[0].cdNm,
							cdVal : data.models[0].cdVal,
							cdReserve01 : data.models[0].cdReserve01,
							cdReserve02 : data.models[0].cdReserve02,
							cdReserve03 : data.models[0].cdReserve03,
							cdReserve04 : data.models[0].cdReserve04,
							description : data.models[0].description,
							sortNum : data.models[0].sortNum,
							useYn : data.models[0].useYn,
							updatorId : _loginUserUsername.value,
							upCdId: $('#hidSelMasterCode').val(),
							msgList: gfn_isNull(lfo_common.msgTemp) == true ? null : lfo_common.msgTemp 
						});
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
						cdId: { type: "string",
							validation: {
								required: true,
								rules: function (input) {
									if (input.is("[name='cdId']")) {
									input.attr("코드를 입력하세요");
									return input.val().length != 0 && input.val().trim().length != "";
									}
								return true;
								}
							}	
						},
						upCdId: { type: "string" },
						cdNm: { type: "string",
							validation: {
								required: true,
								rules: function (input) {
									if (input.is("[name='cdNm']")) {
									input.attr("코드명을 입력하세요");
									return input.val().length != 0 && input.val().trim().length != "";
									}
								return true;
								}
							}
						},
						cdVal: { type: "string" },
						cdReserve01: { type: "string" },
						cdReserve02: { type: "string" },
						cdReserve03: { type: "string" },
						cdReserve04: { type: "string" },
						description: { type: "string" },
						sortNum : { type: "int" },
						updatorId: { type: "string", editable: false },
						updatedAt: { type: "string", editable: false },
						useYn: { 
							type: "string",
							defaultValue : 'Y',
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
						gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
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
		toolbar:[{ template: searchBox },{name:"create", text:gfn_getMsg("btn_add")},{ template: delButton }],			//추가버튼
		dataBinding: function(e) {
		},
		columns: [
			{selectable : true, width:"50px"},
			{ field: "cdId", title: gfn_getMsg("col_cdId"), width: "150px" },											//코드
			{ field: "cdNm", title: gfn_getMsg("col_cdNm"), width: "300px", editor:msgEditor},							//코드명
			{ field: "cdVal", title: gfn_getMsg("col_cdVal"), width: "150px" },											//코드값
			{ field: "sortNum", title: gfn_getMsg("col_sortNum","순서"), width: "80px" },									//순서
			{ field: "description", title: gfn_getMsg("col_desc"), width: "250px" },									//설명
		
 			{ field: "cdReserve01", title: "예비1", width: "120px" },
 			{ field: "cdReserve02", title: "예비2", width: "120px" },
			{ field: "cdReserve03", title: "예비3", width: "120px" },
			{ field: "cdReserve04", title: "예비4", width: "120px" }, 
			{ field: "useYn", title: gfn_getMsg("col_cdUseYn"), width: "105px" },										//사용유무
			{ command: [{name:"edit",text:gfn_getMsg("btn_update")}], width:"250px" }									//수정버튼(실제)
		]
	});
}

 function msgEditor(container, options) {
	 lfo_common.msgTemp = {};
	$('<input class="k-textbox" type="text" name="cdNm" data-type="String" data-bind="cdNm" style="width:70%;">'+
		'<button class="k-button k-primary" type="button" onclick = "lfn_msgPop(this)" style="width:60px;">'+gfn_getMsg("pop_msgLang")+'</button>').appendTo(container);			//다국어
 }
 
//다국어 팝업
this.lfn_msgPop = function(target){
	var grid = $("#jteSubGrid").getKendoGrid();
	var dataItem = grid.dataItem($(target).closest('tr'));

 	// 저장 시 콜백 입력된 결과를 임시저장했다가 서비스단에서 저장
 	var option ={
 		saveCallback : function(rtnMsg){
 			lfo_common.msgTemp = rtnMsg;
 		}
 	};
 	
 	//임시저장된 데이터가 있으면 임시데이터 로드를 위함
 	if(!gfn_isEmpty(lfo_common.msgTemp)){
 		option.saveMsg = lfo_common.msgTemp;
 	}
 	
 	//기본설정
 	if(gfn_isNull(dataItem.cdId)){
 		option.mode = "PG_NEW";
 		option.defNm = dataItem.cdNm;
 	}else{
 		option.mode = "PG_EDT";
 		option.defId = "bc_" + dataItem.cdId;
 		option.defNm = dataItem.cdNm;
 	}

 	gfn_msgSetPop(option);
 }
</script>
