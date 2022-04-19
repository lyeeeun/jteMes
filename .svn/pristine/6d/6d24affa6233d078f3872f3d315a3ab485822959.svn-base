<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- <div id="grid-content" class="menuInfoForm">
	<div id="jteMasterTree" class="jteMasterTree left-content-box"></div>	style="display:inline-block; width:39%; height:100%; float:left; box-shadow: 0px 0px 4px 2px rgba(0, 0, 0, 0.13);  background:#f8f8f8;"
	<input type="hidden" id = "jteMasterTree_hidSelected" class="jteMasterTree_hidSelected" value="root">
	<div id="jteSubGrid" class="jteSubGrid right-content-box"></div>	style="display:inline-block; width:60%; height:100%; float:right;"
</div> -->
<div id="grid-content" class="techDocMgtForm" style="width: 100%;">
	<div id="jteMasterTree" class="techDocMgtForm left-contents jteMasterTree"></div><input type="hidden" id = "jteMasterTree_hidSelected" class="jteMasterTree_hidSelected" value="root">
	<div class="techDocMgtForm middle-contents"><span><i class="fas fa-caret-square-right fa-3x"></i></span></div>
	<div id="jteSubGrid" class="techDocMgtForm right-contents jteSubGrid"></div>
</div>

<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="techDocMgtForm" >
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
			<colgroup>
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr><td colspan="4"></td></tr>
				<tr>
					<!-- 기술문서 그룹 구분 -->
					<td><i class="fas fa-caret-right"></i>구분 : </td>
					<td colspan="3"><input id="docGroupTarget" name="docGroupTarget" format = "selBox" msg="docGroupTarget" class="jtePopForm_onlyInsert center-input"/></td>
				</tr>
				<tr>
				<!-- 기술문서 그룹 ID -->
					<td><i class="fas fa-caret-right"></i>그룹 ID : </td>
					<td colspan="2">
						<input type="text" id="docGroupId" name="docGroupId" class="jtePopForm_onlyInsert center-input btn-input" />
						<input type="hidden" id="upDocGroupId" name="upDocGroupId" class="center-input btn-input"/>
						<input type="hidden" name="action" id="docGroupAction" class="center-input btn-input"/>
					</td>
					<td>
						<button class="k-button k-primary page-search-btn search-btn" type="button" id="itemSelBtn" onclick= "lfn_itemInfo()" style="display:none;"><spring:message code = "btn_search"/></button>
					</td>
				</tr>
				<tr>
				<!-- 기술문서 그룹 명 -->
				<td><i class="fas fa-caret-right"></i>그룹 명 :  </td>
					<td colspan="3">
						<input type="text" id="docGroupNm" class="center-input" name="docGroupNm" format="text"/>
						
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i>비고 : </td>
					<td colspan="3">
						<input type="text" id="description" class="center-input" name="description" format="text"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "lfn_popSave('jtePopForm_form')"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="techDocRegPop">
		<div id="techDocRegPop_grid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="techDocRegForm" class="techDocMgtForm">
		<form id="techDocRegForm_form" class="techDocRegForm techDocMgtForm" >
			<table style="width:100%;" id="techDocRegForm_master" class="techDocRegForm_master">
				<colgroup>
					<col class="popsc-col-left-title">
					<col class="popsc-col-left-content">
					<col class="popsc-col-right-title">
					<col class="popsc-col-right-content">
				</colgroup>
				<tr><td colspan="4"></td></tr>
				<tr>
					<!-- 기술문서 그룹 구분 -->
					<td><i class="fas fa-caret-right"></i>문서 종류 : </td>
					<td colspan="3"><input id="documentCd" name="documentCd" format = "selBox" msg="techDocCd" class="center-input"/></td>
				</tr>
				<tr>
				<!-- 기술문서 그룹 ID -->
					<td><i class="fas fa-caret-right"></i>문서 번호 : </td>
					<td>
						<input type="text" id="documentNo" name="documentNo" class="left-input" />
						<input type="hidden" id="docId" name="docId" />
						<input type="hidden" name="action" id="docInfoAction"/>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>Rev No. : </td>
					<td><input type="text" id="documentRev" name="documentRev" class="right-input" /></td>
				</tr>
				<tr>
				<!-- 기술문서 그룹 명 -->
					<td><i class="fas  fa-caret-right"></i>문서 제목 :  </td>
					<td colspan="3"><input type="text" id="documentSubject" class="center-input" name="documentSubject" format="text"/></td>
				</tr>
				<!-- 설명 -->
				<tr>
					<td><i class="fas fa-caret-right"></i>비고 : </td>
					<td colspan="3"><input type="text" id="documentDesc" name="documentDesc" class="center-input" format="text"/></td>  <!-- style="width:95%" -->
				</tr>
				<!-- 파일 경로 -->
				<%-- <tr>
					<td><i class="fas fa-caret-right"></i>파일 경로 : </td>
					<td colspan="2"><input type="text" id="nameFile" name="nameFile" class="left-input" format="text" style="width:95%"/></td>
					<td><button class="k-button k-primary page-search-btn" type="button" id="uploadFile" onclick= "lfn_itemInfo()"><spring:message code = "btn_search"/></button></td>
				</tr> --%>
				<tr>
					<!-- 첨부파일 -->
					<td class="addFile"><i class="fas fa-caret-right"></i><spring:message code = "col_attachment"></spring:message> : </td>
					<td colspan="3">
						<input name="attachFiles" id="attachFiles" type="file" aria-label="files" format="file" code="docId" />
						<input type="hidden" id="insertAttach" value = "[]"/>
						<input type="hidden" id="deleteAttach" value = "[]"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('techDocRegForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>


<!-- CSS -->
<link href='/resources/mes/css/contents/techMgt/techDocMgt/techDocMgtForm.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200806 youmi -->


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

//새로고침 버튼
var jteSubGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteSubGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfo_common.ctrlUrl = "/cform/techMgt/techDocMgt";
	
	dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: lfo_common.ctrlUrl + "/selectTechDocGroup",
				dataType: "json"
			}
		},
		schema: {
			model: {
				id: "docGroupId",
				hasChildren: "hasChildren"
			}
		}
	});
	
	$("#jteMasterTree").kendoTreeView({
		dataSource: dataSource,
		dataTextField: "docGroupNm",
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
	}, 500);
	
	lfn_jteSubGrd_setGrd();
	lfn_jteSubGrd_eventBind();
	
	lfo_common.subGrid = $("#jteSubGrid").getKendoGrid();
	
	$("#jteMasterTree").on("dblclick",".k-in", function(e){
		var item = lfo_common.mtTree.dataItem($(e.target).closest("li"));
		
		if(item.docGroupTarget == "G"){
			$("#jteMasterTree_hidSelected").val(item.docGroupId);
			lfo_common.subGrid.dataSource.read();
		}
	});
	
};

this.lfn_itemInfo = function() {
	var callback = function(selectedItem){
		$('#docGroupId').val(selectedItem.itemId);
		$('#docGroupNm').val(selectedItem.itemNm);
	};
	gfn_openCustomPop('item',callback);
}


//메뉴 오픈 순서 기억
this.lfn_jteMtTree_expandPush = function(e){
	var item = lfo_common.mtTree.dataItem(e.node);
	lfo_common.mtTreeExpand.push(item.docGroupId);
}

//메뉴 클로즈시 해당부분 제거
this.lfn_jteMtTree_expandPop = function(e){
	var item = lfo_common.mtTree.dataItem(e.node);
	lfo_common.mtTreeExpand.pop(item.docGroupId);
}

//main - grid 생성
this.lfn_jteSubGrd_setGrd = function(){
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : lfo_common.ctrlUrl+"/selectTechDocRtlItem",
				dataType : "json",
				traditional :true
			},
			parameterMap: function(data, type){
				switch(type) {
				case "read" :
					var sort=''
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
					docGroupId : $("#jteMasterTree_hidSelected").val()
					}
				}
			}
		},		
		batch: true,
		schema: {
			 model: {
				id: "docGroupId",
				fields: {
					docGroupId : { type: "string" },
					docGroupNm : { type: "string" },
					docGroupTarget: { type: "bool" },
					upDocGroupId : { type: "bool" },
					description: { type: "string" },
					createdAt : { type: "string" },
					creatorId : { type: "string" },
					updatedAt: { type: "string" },
					updatorId: { type: "string" },
					updatorNm: { type: "string" },
					hasChildren: { type: "bool" }
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
			{field: "docGroupId", title: "기술문서 그룹 ID", width: "80px"},
			{field: "docGroupNm", title: "기술문서 그룹 명", width: "150px"},
			{field: "docGroupTarget", title: "구분", width: "200px"},
			{field: "upDocGroupId", title:"상위 그룹 명", width: "200px"},
			{field: "description", title:"설명", width: "200px"},
			{field: "updatedAt", title:"최근 수정일자", width: "200px"},
			{field: "updatorNm", title:"수정자", width: "200px"},
			{field: "techDocReg", title:"기술문서 정보", width: "160px",
				template : function(rows) {
					if(rows.docGroupTarget != "I") {
						return '<button class="k-button k-primary" type="button" onclick="lfn_techDocGrd_popOpen(this)">기술문서 등록</button>';	
					} else {
						return '<span></span>';
					}
				}
			},
			{field: "editOption", title:"수정", width: "160px",			
				template : function(rows) {
					if(rows.docGroupTarget != "I") {
						return '<button class="k-button k-primary" type="button" onclick="lfn_jtePop_open(\'EDT\',this)">수정</button>';	
					} else {
						return '<span></span>';
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
			{template: kendo.template(jteSubGrd_refreshBtn)}
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		}
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
this.lfn_jteSubGrd_eventBind = function(){
	//검색 Selectbox 바인딩 
	var shBoxItem = [
			{ text: "기술문서명", value: "docGroup.docGroupNm" },
			{ text: "수정자", value: "user.updatorNm" },
			{ text: "기술문서코드", value: "docGroup.docGroupId" }
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
}

this.lfn_jtePop_open = function(mode,selectedItem){
	//다국어 초기화
	lfo_common.msgTemp = {};
	
	var options = {
			modal:true, 
			width: "600px", 
			height: "305px", /** 200806 메인 그리드에서 추가/수정 버튼 클릭 시 팝업 height 변경 350px->305px_youmi **/
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
		
		options.title = "기술문서 그룹 등록"
		options.callback = function(){
			$(".jtePopForm_onlyInsert").removeAttr('readonly');
			
			$("#jtePopForm_master").find("input").each(function(index,item){
				var formatType = $(item).attr("format");
				var fillTextId = $(item).attr("id");
				
				if(formatType == "selBox"){
					var selBoxItem = gfn_getCode($(item).attr("msg"));
					$("#"+fillTextId).kendoDropDownList({
						dataSource: selBoxItem,
						dataValueField: "cdVal",
						valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"
							+ "#= item #",
						template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"
							+ "#= item #",
						index : 0,
						change: function(e) {
							console.log(this.value());
							if(this.value() == "I") {
								$('#itemSelBtn').show();
								$('#docGroupId').attr('readonly',true);
							} else {
								$('#itemSelBtn').hide();
								$('#docGroupId').attr('readonly',false);
							}
							
						}
					});
				}else{
					$("#"+fillTextId).addClass("k-textbox");
				}
			});
			$("#upDocGroupId").val($("#jteMasterTree_hidSelected").val());
			$("#docGroupAction").val("C");
		}
	}else{
		var selectedItem = $("#jteSubGrid").data("kendoGrid").dataItem($(selectedItem).closest('tr'));
		
		$("#jteSubGrd_hidSelected").val(selectedItem["docGroupId"]);
		options.title = "기술문서 그룹 수정"
		options.callback = function(){
			$(".jtePopForm_onlyInsert").attr('readonly', true);
			$("#jtePopForm_master").find("input").each(function(index,item){
				var formatType = $(item).attr("format");
				var fillTextId = $(item).attr("id");
				
				if(formatType == "selBox"){
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
			$("#docGroupAction").val("U");
		};
	}
	this.gfn_winOpen(options);		
	lfo_common.popGrid = $("#jtePopForm_grid").getKendoGrid();
}

//Form내용 입력/저장
this.lfn_popSave = function(formID){
	$("input[name=role]").each(function(){
		$(this).val($(this).attr("id"));
	});
	
	//입력폼 serialize 
	var savePrmt = $("#"+formID).serializeObject();
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/saveTechDocRtlItem",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			gfn_closePop(formID);
			
			lfo_common.mtTree.dataSource.read();
			lfo_common.subGrid.dataSource.read();
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			
			setTimeout(function() {
				lfo_common.mtTree.expandPath(lfo_common.mtTreeExpand);
			}, 300);
			
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

this.lfn_techDocGrd_popOpen = function(rows){
	var options = {
		modal:true, 
		width: "1000px", 
		height: "470px", //200520 JJW 470->
		id:"techDocRegPop", 
		title:"기술 문서 정보 관리",			//포장 묶음 정보 등록
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_techDocGrd_setGrd($("#jteSubGrid").data("kendoGrid").dataItem($(rows).closest('tr')));
		$('#techDocRegPop_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}

this.lfn_techDocGrd_setGrd = function(selectedItem){
	
	lfo_techDocGrd = {};
	
	lfo_techDocGrd.docGroupId = selectedItem.docGroupId;
	//1.
	lfo_techDocGrd.layoutId = "techDocRegPop_grid";
	
	//2.
	lfo_techDocGrd.popId = "techDocRegForm";
	
	//3.
	lfo_techDocGrd.ctrlUrl = "/cform/techMgt/techDocMgt";
	
	//4.
	lfo_techDocGrd.crud  = {
		read:{url: "/selectTechDocInfo", auth:"", prmt:{docGroupId: lfo_techDocGrd.docGroupId}, search: false},
		create:{url:"/saveTechDocInfo", auth:"", openFunc: lfn_techDocRegPop_open, callback: lfn_techDocRegPop_save},
		update:{url:"/saveTechDocInfo", auth:"", callback: lfn_techDocRegPop_save}
	};
	
	//5.
	lfo_techDocGrd.model = {
		fields: {
			docId : { type: "string" },
			documentNo : { type: "string" },
			documentRev : { type: "string" },
			documentCd : { type: "string" },
			documentSubject : { type: "string" },
			documentDesc : { type: "string" },
			nameFile : { type: "string" },
			updatorId : { type: "string" },
			userNm : { type: "string" },
			updatedAt : { type: "string" }
		}
	};
	
	//6.
	lfo_techDocGrd.columns = [
		{field: "documentNo", title:"문서 번호", width: "120px;"},
		{field: "documentRev", title:"Rev.", width: "120px;"},
		{field: "documentCd", title:"문서 종류", width: "120px;"},
		{field: "documentSubject", title:"문서 제목", width: "120px;"},
		{field: "documentDesc", title:"문서 설명", width: "120px;"},
		{field: "nameFile", title:"파일 경로", width: "120px;"},	
		{field: "userNm", title:"등록자", width: "120px;"},
		{field: "updatedAt", title:"등록일", width: "120px;"},
		{field: "editOption", title:"파일 저장", width: "120px;",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_techDocRegPop_open(\'download\',this); " style="min-width:60px;">' + "파일 저장" + '</button>'
		},
		{field: "editOption", title:"수정", width: "120px;",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_techDocRegPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'
		}
		
	];
	
	//공통 그리드 세팅 호출
	lfo_techDocGrd.grid = gfn_grid_set(lfo_techDocGrd);
}

this.lfn_techDocRegPop_open = function(mode, rows){
	//초기화
 	var options = {
		modal: true, 
		width: "800px",
		height: "390px",  //200806 메인 그리드의 기술문서 등록 버튼 클릭 → 추가/수정 버튼 클릭 시의 팝업창 height 변경_430->410px youmi 430->390 JWW
		id : lfo_techDocGrd.popId, 
		title: "기술 문서 등록",
		resizable: true,
		animation: {open :{effects:"expand:vertical fadeIn"},
		close : {effects:"expand:vertical fadeIn", reverse: true}},
		actions: [/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		gfn_popform_set(lfo_techDocGrd, mode, $("#techDocRegPop_grid").data("kendoGrid").dataItem($(rows).closest('tr')))
		
		if(mode == "download") {
			$("#"+lfo_techDocGrd.popId+"_form").find("input").each(function(index,item){
				$(item).attr('readonly', true);
			});
			
			$("#"+lfo_techDocGrd.popId+"_form").find("button").each(function(index,item){
				$(item).hide();
			});
			
			$("#" + lfo_techDocGrd.popId +" .k-dropzone").hide();
			$("#" + lfo_techDocGrd.popId).find(".k-upload-action").each(function(item){
				if($(this).attr("aria-label") == "Remove"){
					$(this).hide();
				}
			})
		}
	};
	this.gfn_winOpen(options);
}

this.lfn_techDocRegPop_save = function(mode){
	var formId = lfo_techDocGrd.popId+"_form";
	var savePrmt = gfn_serializeObject(formId);
	
	savePrmt.docGroupId = lfo_techDocGrd.docGroupId;
	
	$.ajax({
		async:false,
		url : lfo_techDocGrd.ctrlUrl + lfo_techDocGrd.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_techDocGrd.grid.dataSource.read();
			
			gfn_closePop(lfo_techDocGrd.popId);
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

</script>