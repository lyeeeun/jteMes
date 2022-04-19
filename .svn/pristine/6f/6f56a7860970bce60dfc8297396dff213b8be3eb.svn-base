<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<table id="grid-content" style="width:100%;">
	<tr class="rlehoMgtForm">
		<td class="left-content-box">
			<div id="jteMasterTree" class="jteMasterTree"></div>
			<input type="hidden" id="jteMasterTree_hidSelected" class="jteMasterTree_hidSelected" value="">
		</td>
		<td class="center-content-box">
			<span><i class="fas fa-caret-square-right fa-3x"></i></span>
		</td>
		<td class="right-content-box">
			<div id="jteSubGrid"></div>
		</td>
	</tr>
</table>
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="rlehoMgtForm">
			<table id="jtePopForm_master" class="jtePopForm_master">
			<colgroup>
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-center-content">
				<col class="col-right-content">
			</colgroup>
				<tr>
				<!-- 위치코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_placeCd"></spring:message> : </td>
					<td colspan="3"><input type="text" id="placeId" class="normal-input" name="placeId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly /></td>			<!-- 자동생성 -->
				</tr>
				<tr>
				<!-- 위치명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_placeNm"></spring:message> :  </td>
					<td colspan="3">
						<input type="text" id="placeNm" class="normal-input" name="placeNm" format="text"/>
					</td>
<%-- 					<td>	
						<button class="k-button k-primary msgPop-btn" type="button" onclick = "lfn_msgPop('placeId','placeNm')">
				<!-- 다국어 -->
						<spring:message code = "pop_msgLang"></spring:message></button>
					</td> --%>
				</tr>
				<tr>
				<!-- 관리자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager"></spring:message> :  </td>
					<td colspan="2">
						<input type="text" id="placeManagerNm" class="normal-input btn-input" name="placeManagerNm" format="text" readonly/>
						<input type="hidden" id="placeManager" class="normal-input btn-input" name="placeManager"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
				<!-- 조회 -->
						<spring:message code ="btn_search"></spring:message></button>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="description" class="normal-input" name="description" format="text"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="place_action" class="place_action"/>
						<input type="hidden" name="placeParent" id="placeParent" class="placeParent"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area">
			<button class="k-button k-primary final-btn" type="button" onclick = "lfn_popSave('jtePopForm_form')"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/rlehoMgt/rlehoMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/operMgt/rlehoMgt/rlehoMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200428 LYM  -->

<script>
var lfo_common = {};//공통 Object

//검색영역
var jteSubGrd_shAr='<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteSubGrd_shSelBox\"/>'																					//검색(UI)
	+'<input type=\"text\" id=\"jteSubGrd_shSelTxt\" name=\"jteSubGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'									//조회(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteSubGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'			//조회버튼
	+'<input id=\"jteSubGrd_hidShSelBox\" type=\"hidden\">'
	+'<input id=\"jteSubGrd_hidShSelTxt\" type=\"hidden\">';
	+'<input id=\"jteSubGrd_hidSelected\" type=\"hidden\">';
	
//추가버튼
var jteSubGrd_addBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jtePop_open(\'NEW\') \"><span class=\"k-icon k-i-plus\"></span>'+gfn_getMsg("btn_add")+'</a>';

//삭제버튼
var jteSubGrd_delBtn = '<a role=\"button\" class=\"k-button k-button-icontext k-grid-delete\" ><span class=\"k-icon k-i-close\"></span>'+gfn_getMsg("btn_delete")+'</a>';

//새로고침 버튼
var jteSubGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteSubGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/rlehoMgt";
	dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: lfo_common.ctrlUrl + "/getPlaceTree",
				dataType: "json"
			}
		},
		schema: {
			model: {
				id: "placeId",
				hasChildren: "hasChildren",
				field:{
					placeId : { type: "string" },
					placeNm : { type: "string" },
					placeParent : { type: "string" },
					placeManager : { type: "string" },
					createdAt : { type: "string" },
					updatedAt : { type: "string" },
					creatorId : { type: "string" },
					updatorId : { type: "string" },
					description : { type: "string" },
					isUse : { type: "string" }
				}
			}
		}
	});
	dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: lfo_common.ctrlUrl + "/getPlaceTree",
				dataType: "json"
			}
		},
		schema: {
			model: {
				id: "placeId",
				hasChildren: "hasChildren",
				field:{
					placeId : { type: "string" },
					placeNm : { type: "string" },
					placeParent : { type: "string" },
					placeManager : { type: "string" },
					createdAt : { type: "string" },
					updatedAt : { type: "string" },
					creatorId : { type: "string" },
					updatorId : { type: "string" },
					description : { type: "string" },
					isUse : { type: "string" }
				}
			}
		}
	});
	
	$("#jteMasterTree").kendoTreeView({
		dataSource: dataSource,
		dataTextField: "placeNm",
		expand:lfn_jteMtTree_expandPush,
		collapse:lfn_jteMtTree_expandPop
		//전체 확장 
// 		dataBound: function(){
// 			this.expand('.k-item');
// 		}
	});

	lfo_common.mtTree = $("#jteMasterTree").data("kendoTreeView");
	lfo_common.mtTreeExpand =[];
	
	setTimeout(function() {
		lfo_common.mtTree.expand(".k-item");
	}, 300);
	lfn_jteSubGrd_setGrd();
	
	lfn_jteSubGrd_eventBind();
	
	lfo_common.subGrid = $("#jteSubGrid").getKendoGrid();
	
	$("#jteMasterTree").on("dblclick",".k-in", function(e){
		var item = lfo_common.mtTree.dataItem($(e.target).closest("li"));
		$("#jteMasterTree_hidSelected").val(item.placeId);
		lfo_common.subGrid.dataSource.read();
	});
};
//트리 오픈 순서 기억
this.lfn_jteMtTree_expandPush = function(e){
	var item = lfo_common.mtTree.dataItem(e.node);
	lfo_common.mtTreeExpand.push(item.menuId);
}

//트리 클로즈시 해당부분 제거
this.lfn_jteMtTree_expandPop = function(e){
	var item = lfo_common.mtTree.dataItem(e.node);
	lfo_common.mtTreeExpand.pop(item.menuId);
}

//main - grid 생성
this.lfn_jteSubGrd_setGrd = function(){
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : lfo_common.ctrlUrl+"/getPlaceList",
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
					searchGubun:$("#jteSubGrd_hidShSelBox").val(),
					searchText:$("#jteSubGrd_hidShSelTxt").val(),
					placeId : $("#jteMasterTree_hidSelected").val()
					}
				}
			}
		},		
		batch: true,
		schema: {
			 model: {
				id: "placeId",
				fields: {
					placeId : { type: "string" },
					placeNm : { type: "string" },
					placeParent : { type: "string" },
					placeManager : { type: "string" },
					createdAt : { type: "date" },
					updatedAt : { type: "date" },
					creatorId : { type: "string" },
					updatorId : { type: "string" },
					description : { type: "string" },
					isUse : { type: "bool" },
					hasChildren: { type: "bool" },
					placeManagerNm : { type: "string" }
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
	$("#jteSubGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{selectable : true, width:"50px"}, 
			{field: "placeId", title:gfn_getMsg("col_placeCd"), width: "150px"},										//위치코드
			{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: "200px"},										//위치명
			{field: "placeManagerNm", title:gfn_getMsg("col_manager"), width: "200px"},									//관리자
			{field: "description", title:gfn_getMsg("col_desc"), width: "300px"},										//설명
			{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"120px",			//사용유무
 				template : function(rows) {
 					if(rows.use == false){
 						return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
 					}else if (rows.use == true){
 						return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
 					}else{
 						return ""+gfn_getMsg("val_basic")+" : Y";														//기본
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
			{template: kendo.template(jteSubGrd_shAr)},
			{template: kendo.template(jteSubGrd_addBtn)},
			{template: kendo.template(jteSubGrd_delBtn)},
			{template: kendo.template(jteSubGrd_refreshBtn)}
			
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		},
		
	});
}

//검색이벤트
this.lfn_jteSubGrd_search = function(){
	$("#jteSubGrd_hidShSelBox").val($("#jteSubGrd_shSelBox").val());
	$("#jteSubGrd_hidShSelTxt").val($("#jteSubGrd_shSelTxt").val());
	lfo_common.subGrid.dataSource.read();
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

// 입력,수정 ValidationCheck
this.lfn_jteSubGrd_validation = function(e){
	if(gfn_isNull(e.authId)){
		gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
		return false;
	}
	return true;
}

/* 이벤트/초기설정  바인딩 
 1. grid SelectBox 바인딩
 2. 검색박스 엔터 이벤트 바인딩
 3. grid 삭제이벤트 바인딩
 */
this.lfn_jteSubGrd_eventBind = function(){
	//검색 Selectbox 바인딩 
	var shBoxItem = [
			{ text: gfn_getMsg("col_placeNm"), value: "place.place_nm" },			//위치명
			{ text: gfn_getMsg("col_placeCd"), value: "place.place_id" },			//위치코드
			{ text: gfn_getMsg("col_desc"), value: "place.description" }			//설명
		];
	$("#jteSubGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: shBoxItem,
		index: 0
	});
	
	//검색박스 엔터 이벤트
	$("#jteSubGrd_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_jteSubGrd_search();
		}
	});
	
	//삭제이벤트 바인딩
	$("#jteSubGrid").find(".k-grid-toolbar").on("click", ".k-grid-delete", function (e) {
		kendo.confirm(gfn_getMsg("pop_confirmDelete"))			//삭제하시겠습니까?
		.done(function(){
			var delPrmt = [];
			$(".k-checkbox").each(function(index,item){
				if($(this).attr("aria-checked") == "true"){
					var dataItem = $("#jteSubGrid").data("kendoGrid").dataItem($(this).closest("tr"));
					delPrmt.push(dataItem);
				}
			});
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl+"/setPlaceDelete",
				type: "POST",
				data: JSON.stringify(delPrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					lfo_common.subGrid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		})
	});
	
	//마스터테이블 더블 클릭
	$("#jteSubGrid tbody").on("dblclick", "tr", function(e){
		//선택한 항목 바인드
//  		var selectedItem = lfo_common.sgGrid.dataItem($(this));
		lfn_jtePop_open("EDT",lfo_common.subGrid.dataItem($(e.target).closest('tr')));
	});
}

this.lfn_jtePop_open = function(mode,selectedItem){
	//다국어 초기화
	lfo_common.msgTemp = {};
	
	var options = {
			modal:true, 
			width: "550px", 
			height: "320px",  /** 200428 첫번째 팝업 height 변경_LYM 290으로 / JJW 310**/
			id:"jtePopForm", 
			title:"", 
			workCd:mode, 
			bdSeq:"",
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};

	if(mode=='NEW'){
		
		options.title = gfn_getMsg("pop_placeRegist");			//위치 등록
		options.callback = function(){
			$(".jtePopForm_onlyInsert").attr('readonly', true);
			
			$("#jtePopForm_master").find("input").each(function(index,item){
				var formatType = $(item).attr("format");
				var fillTextId = $(item).attr("id");
				if(formatType == "currency"){
					$("#"+fillTextId).kendoNumericTextBox({
						format: "n0"
					});
				}else if(formatType == "datepicker"){
					$("#"+fillTextId).kendoDatePicker({
						format : "yyyy-MM-dd"
					});
				}else if(formatType == "selBox"){
					var selBoxItem = gfn_getCode($(item).attr("msg"));
					$("#"+fillTextId).kendoDropDownList({
						dataSource: selBoxItem,
						dataValueField: "cdVal",
						valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"
							+ "#= item #",
						template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"
							+ "#= item #",
						index : 0
					});
				}else{
					$("#"+fillTextId).addClass("k-textbox");
				}
			});
			$("#placeParent").val($("#jteMasterTree_hidSelected").val());
			$("#place_action").val("C");
		}
	}else{
		$("#jteSubGrd_hidSelected").val(selectedItem["menuId"]);
		options.title = gfn_getMsg("pop_placeDetailSrh");			//위치 상세조회
		options.callback = function(){
			$(".jtePopForm_onlyInsert").attr('readonly', true);
			$("#jtePopForm_master").find("input").each(function(index,item){
				var formatType = $(item).attr("format");
				var fillTextId = $(item).attr("id");
				if(formatType == "currency"){
					$("#"+fillTextId).kendoNumericTextBox({
						format: "n0",
						value:selectedItem[fillTextId]
					});
				}else if(formatType == "datepicker"){
					$("#"+fillTextId).kendoDatePicker({
						format : "yyyy-MM-dd",
						value:selectedItem[fillTextId]
					});
				}else if(formatType == "selBox"){
					var selBoxItem = gfn_getCode($(item).attr("msg"));
					$("#"+fillTextId).kendoDropDownList({
						dataSource: selBoxItem,
						dataValueField: "cdVal",
						valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"
							+ "#= item #",
						template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"
							+ "#= item #"
					});
					$("#"+fillTextId).data("kendoDropDownList").select(function(dataItem) {
							return dataItem.cdVal === selectedItem[fillTextId];
					});
				}else{
					$("#"+fillTextId).addClass("k-textbox");
					$("#"+fillTextId).val(selectedItem[fillTextId]);
				}
			});
			$("#place_action").val("U");
		};
	}
	this.gfn_winOpen(options);		
	lfo_common.popGrid = $("#jtePopForm_grid").getKendoGrid();
}

//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

//pop - 유저정보 팝업 콜백
this.lfn_userInfoPop_callback = function(rtnObj){
	$("#placeManager").val(rtnObj["userId"]);
	$("#placeManagerNm").val(rtnObj["userNm"]);
}


//Form내용 입력/저장
this.lfn_popSave = function(formID){
	
	//입력폼 serialize 
	var savePrmt = $("#"+formID).serializeObject();
	
	//저장된 다국어가 있다면 추가
	if(!gfn_isEmpty(lfo_common.msgTemp)){
		savePrmt.msgList = lfo_common.msgTemp;
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/setPlaceSave",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data > 0){
				gfn_closePop(formID);
				lfo_common.mtTree.dataSource.read();
				lfo_common.subGrid.dataSource.read();
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				setTimeout(function() {
					lfo_common.mtTree.expandPath(lfo_common.mtTreeExpand);
				}, 300);
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//잠금유무
this.lfn_jteSubGrd_changeIsUse = function(rows){
	var dataItem = lfo_common.subGrid.dataItem($(rows).closest("tr"));
	var prmt = {placeId : dataItem.placeId, action : "USE", use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/setPlaceSave",
		type: "POST",
		data: JSON.stringify(prmt),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data > 0){
				lfo_common.mtTree.dataSource.read();
				lfo_common.subGrid.dataSource.read();
				setTimeout(function() {
					lfo_common.mtTree.expandPath(lfo_common.mtTreeExpand);
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

//다국어 팝업
this.lfn_msgPop = function(defId,defNm){
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
	if($("#place_action").val() == 'C'){
		option.mode = "PG_NEW";
		option.defNm = $("#"+defNm).val();
	}else if($("#place_action").val() == 'U'){
		option.mode = "PG_EDT";
		option.defId = "place_" + $("#"+defId).val();
		option.defNm = $("#"+defNm).val();
	}
	gfn_msgSetPop(option);
}
</script>