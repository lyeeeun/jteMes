<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 내부 스타일 외부로 이동_200410 LYM  --> <!-- 테이블형식을 반응형 웹을 위해 div로 변경_200911 JJW  -->

<div id="grid-content" class="bomMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="bomMgtForm bomMgtForm-jteSingleGrid" style="width:44.5%;"></div>
	<div class="bomMgtForm bomMgtForm-jteSubGrid" style="width: 54.5%; overflow: auto;">
	<button id="bomAddBtn" class="k-button k-primary bomAddBtn" type='button' id='editBtn' onclick="lfn_jtePop_open('NEW', '')"><!-- 신규생성 -->
	<spring:message code = "btn_newCreat"></spring:message></button>
	<div id="bomTree"></div></div>
</div>

<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="bomMgtForm">
				<table id="jtePopForm_master" class="jtePopForm_master">
					<colgroup>
						<col class="col-left-title">
						<col class="col-left-content">
						<col class="col-center-content">
						<col class="col-right-content">
					</colgroup>
					<tr>
					<!-- BOM 코드 -->
						<th><i class="fas fa-caret-right"></i><spring:message code = "col_bomCd"></spring:message> : </th>
						<td colspan="3"><input type="text" id="bomId" class="normal-input" name="bomId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>													<!-- 자동입력 -->
					</tr>
					<tr style = "display:none;">
					<!-- 부품/자재 구분 -->
						<th><i class="fas fa-caret-right"></i><spring:message code = "col_divItemMtrl"></spring:message> : </th>
						<td colspan="3"><input type="text" id="bomTarget" class="normal-input" name="bomTarget" format='selBox'/></td>
					</tr>
					<tr>
					<!-- 사용 자재 -->
						<th><i class="fas fa-caret-right"></i><spring:message code = "col_useItemMtrl"></spring:message> : </th>
						<td colspan="2">
							<input type="text" id="bomTargetId" name="bomTargetId" class="normal-input btn-input" readonly/> <!-- 200410 what??? LYM&JJW-->
							<input type="hidden" id="bomTargetNm" name="bomTargetNm" class="normal-input btn-input"> <!-- 200410 what??? LYM&JJW -->
						</td>
						<td><button class="k-button k-primary bomTargetInfo" type="button" id="bomTargetInfo" name="bomTargetInfo" onclick="lfn_bomTargetInfo()">
					<!-- 조회 -->
						<spring:message code = "btn_search"></spring:message></button></td>
					</tr>
					<tr>
					<!-- 수량 -->
						<th><i class="fas fa-caret-right"></i><spring:message code = "col_quantity"></spring:message> : </th>
						<td colspan="3"><input type="text" id="bomTargetCnt" class="normal-input" name="bomTargetCnt" format='numeric'/></td>
					</tr>	
					<tr>
					<!-- 설명 -->
						<th><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </th>
						<td colspan="3"><input type="text" id="description" class="normal-input" name="description"/></td>
					</tr>	
					<tr style = "display:none;"> 
					<!-- 상위 부품/자재 -->
						<th><i class="fas fa-caret-right"></i><spring:message code = "col_upItemMtrl"></spring:message> : </th>
						<td colspan="3"><input type="text" id="bomParentId" class="normal-input" name="bomParentId" format='selBox'/></td>
					</tr>
				</table>
				<div class="final-btn-area">
				<button class="k-button k-primary final-btn" type="button" onclick = "lfn_popSave('jtePopForm_form')"><spring:message code = "pop_save"></spring:message></button>														<!-- 저장 -->
					<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>													<!-- 취소 -->
					<button id="bomDelBtn" class="k-button k-primary final-btn" type="button" onclick = "lfn_popDelete('jtePopForm_form');" style="display:none"><spring:message code = "btn_delete"></spring:message></button>			<!-- 삭제 -->
				</div>
			</form>
		</div>
</div>
<div style="display:none;">
	<div id="popItemInfo">
		<div id="popItemGrid"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/bom/bomMgt/bomMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/bom/bomMgt/bomMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object

//검색영역
var jteSgGrd_shAr= '<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteSgGrd_shSelBox\"/>'																						//검색(UI)
	+'<input type=\"text\" id=\"jteSgGrd_shSelTxt\" name=\"jteSgGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'									//검색(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteSgGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>';			//조회

//새로고침
var jteSgGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteSgGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfo_common.ctrlUrl ="/cform/basMgt/bom/bomMgt";
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	//데이터 생성
	lfn_jteSgGrd_eventBind();

	lfo_common.sgGrid = $("#jteSingleGrid").getKendoGrid();	

};

//main - grid 생성
this.lfn_jteSgGrd_setGrd = function(){
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : "/cform/basMgt/operMgt/itemMgt/getItemList",
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
					searchGubun: $("#jteSgGrd_shSelBox").val(),
					searchText: $("#jteSgGrd_shSelTxt").val()
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
					itemPrice: { type: "int" },
					itemPersonCost: { type: "int" },
					itemType: { type: "int" },
					itemLen: { type: "int" },
					itemWidth: { type: "int" },
					itemThick: { type: "int" },
					itemWeight: { type: "int" },
					itemUnit: { type: "string" },
					itemMtrl: { type: "string" },
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
	
	$("#jteSingleGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "130px"},				//부품코드
			{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "170px"},				//부품명
/* 			{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
				title:gfn_getMsg("col_itemType"), width: "110px"},							//부품유형 */
			{field: "description", title:gfn_getMsg("col_desc"), width: "150px"}			//설명
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
			{template: kendo.template(jteSgGrd_refreshBtn)}
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		}
		
	});
}

//검색이벤트
this.lfn_jteSgGrd_search = function(){
	lfo_common.sgGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	/* lfo_common.sgGrid.dataSource.read(); */
}

/* 새로고침이벤트
	1. 검색구분, 검색 새로고침
	2. 페이징 정보 새로고침
*/
this.lfn_jteSgGrd_refresh = function(){
	$("#jteSgGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteSgGrd_shSelTxt").val("");
	
	lfo_common.sgGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	
/* 	lfo_common.sgGrid.dataSource.read(); */
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
			{ text: gfn_getMsg("col_itemNm"), value: "itemNm" },			//부품명
			{ text: gfn_getMsg("col_itemCd"), value: "itemId" }				//부품코드
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
	
	//마스터테이블 더블 클릭
	$("#jteSingleGrid tbody").on("dblclick", "tr", function(e){
		lfn_setBomTree(lfo_common.sgGrid.dataItem($(e.target).closest('tr')));
	});
}

this.lfn_jtePopGrd_eventBind = function(){
	var shBoxItem = [
			{ text: gfn_getMsg("col_itemCd"), value: "itemId" },			//부품코드
			{ text: gfn_getMsg("col_itemNm"), value: "itemNm" }				//부품명
	];
	
	$("#jtePopGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: shBoxItem,
		index: 0
	});
	
	//LotGrid - 검색박스 엔터 이벤트
	$("#jtePopGrd_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_jtePopGrd_search();
		}
	});
	
	//LotGrid - 더블 클릭
	$("#popItemGrid tbody").on("dblclick", "tr", function(e){
		$('#bomTargetId').val(lfo_common.popGrid.dataItem($(e.target).closest('tr')).itemId);
		$('#bomTargetNm').val(lfo_common.popGrid.dataItem($(e.target).closest('tr')).itemNm);
		gfn_closePop("popItemInfo");
	});
}

//pop - 검색이벤트
this.lfn_jtePopGrd_search = function(){
	lfo_common.popGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
/* 	lfo_common.popGrid.dataSource.read(); */
}

/*pop -  새로고침이벤트
	1. 검색구분, 검색 새로고침
	2. 페이징 정보 새로고침
*/
this.lfn_jtePopGrd_refresh = function(){
	$("#jtePopGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jtePopGrd_shSelTxt").val("");
	
	lfo_common.popGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
/* 	lfo_common.popGrid.dataSource.read(); */
}

this.lfn_setBomTree = function(param) {
	$('#bomAddBtn').show();
	
	var bomTreeData = [];
	var connectionsDatasource = [];
	var flag = true;
	
	lfo_common.itemId = param.itemId;
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getBomList",
		type: "POST",
		data: { itemId: param.itemId},	
		success: function(data){
			var insertNode = {};
			lfo_common.bomData = [];
			
			if(data.result == 0) {
				kendo.confirm("BOM이 구성되지 않았습니다. BOM을 생성하여 주십시오.")
				flag = false;
				return flag;
			}
			$.each(data.result, function(index, item) {
				insertNode = {
						bomId: item.bomId,
						bomTarget: item.bomTarget,
						bomTargetId: item.bomTargetId,
						bomTargetNm: item.bomTargetNm,
						bomTargetCnt: item.bomTargetCnt,
						description: item.description,
						bomParentId: item.bomParentId,
						mtrlDesc: item.mtrlDesc,
						colorScheme: "#FFAACC", /*"#081332"*_LYM*/ /*200413  우측  root 배경 색상 수정_LYM */
						items: "",
						image: "bomItem.png"
				};
				if(index != 0) {
					if(item.bomTarget == "prcs_bom01") {
						insertNode.colorScheme = "#d6e3ff"; /*"#4d5f75"_LYM*/ /* 200413  우측  1단계 배경 색상 수정_LYM */
					} else if(item.bomTarget == "prcs_bom02") {
						insertNode.colorScheme = "#e4bdff"; /*"#96a6ba"_LYM*/ /* 200413  우측  2단계 배경 색상 수정_LYM*/
						insertNode.image = "bomMaterial.png"
					}
					connectionsDatasource.push({itemId: item.itemId ,bomId: item.bomId, from: item.bomParentId, to: item.bomId});
				}
				bomTreeData.push(insertNode);
				
				lfo_common.bomData.push(insertNode);
				
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	$("#bomTree").kendoDiagram({
		dataSource: {
			data: bomTreeData,
			schema: {
				model: {
					id: "bomId",
					fields: {
						bomId: { from: "bomId", type: "string" },
						bomParentId: { type: "string"},
						Color: { type: "string" }
					},
				}
			}
		},
		connectionsDataSource: connectionsDatasource,
		editable: {
			tools: false,
		},
		click: function(e) {
			lfn_jtePop_open("EDT",e.item.dataItem);
		},
		layout: {
			type: "layered"
		},
		shapeDefaults: {
			visual: visualTemplate,
			/* content: {
				template: "#= dataItem.bomTargetNm #", 
				fontSize: 10
			}, */
			editable: {
				tools: false,
			}
		},
		connectionDefaults: {
			type: "cascading",
			stroke: {
				color: "#adbac7", /* 200413 Tree 선 색상 수정_LYM*/
				width: 2.4 /*width: 2*/ /*200413 Tree 선 두께 수정_LYM*/
			},
			editable: {
				tools: false,
			}
		}
	});
	
	var diagram = $("#bomTree").getKendoDiagram();
	
	if(flag) {
		diagram.bringIntoView(diagram.shapes[0], { align: "center top" });
	}
	
}

function visualTemplate(options) {
	
	var dataviz = kendo.dataviz;
	var g = new dataviz.diagram.Group();
	var dataItem = options.dataItem;

	g.append(new dataviz.diagram.Rectangle({
		width: 220,
		height: 80,
		stroke: {
			width: 1
		},
			fill: dataItem.colorScheme,
	}));


	g.append(new dataviz.diagram.TextBlock({
		text: dataItem.bomId,
		x: 80,
		y: 3,
		fontSize: 14, /*14_LYM*/ /* 200413 Tree 제목 폰트 크기 수정_LYM */
		fontStyle: "bold",
		color: "#000000" /* 200413 Tree 제목 색상 수정_LYM #ffffff */
	}));

	g.append(new dataviz.diagram.TextBlock({
		text: dataItem.bomTargetNm,
		x: 80,
		y: 30,
		fontSize: 12,
		fontStyle: "bold",
		color: "#525252" /*"#eaf4f9"_LYM*/ /* 200413 Tree 내용 색상 수정_LYM */
	}));

	g.append(new dataviz.diagram.TextBlock({
		text: dataItem.mtrlDesc,
		x: 80,
		y: 45,
		fontSize: 12,
		fontStyle: "bold",
		color: "#525252" /*"#eaf4f9"_LYM*/ /* 200413 Tree 내용 색상 수정_LYM */
	}));
	
	g.append(new dataviz.diagram.Image({
		source: "/resources/mes/img/" + dataItem.image,
		x: 12,
		y: 15,
		width: 50,
		height: 50
	}));

	return g;
}

this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
			modal:true, 
			width: "700px", 
			height: "300px", /* 200413 첫번째 추가 팝업  height 수정_LYM 380 , 0428 JJW 380 -> 350 -> 300 */ 
			id:"jtePopForm", 
			title:gfn_getMsg("pop_bomCreat"),					//BOM 신규 생성
			workCd:mode, 
			bdSeq:"",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:["Close"]
	};

	if(mode=='NEW'){
		options.callback = function(){
			lfn_jtePopGrd_setForm(mode);
		}
	} else{
		options.title = gfn_getMsg("pop_bomUpdate");			//BOM 수정
		options.workCd = "EDIT";
		options.callback = function(){
			lfn_jtePopGrd_setForm(mode, selectedItem);
		};
 	}
	
	this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_setForm = function(mode, selectedItem){
	lfo_common.mode = mode;
	
	$("#bomTarget").kendoDropDownList({
		dataTextField: "cdNm",
		dataValueField: "cdId",
		dataSource: gfn_getCode('prcs_bom'),
		index: 0
	});
	
	$("#bomParentId").kendoDropDownList({
		dataTextField: "bomTargetNm",
		dataValueField: "bomId", 
		dataSource: lfo_common.bomData,
		index: 0
	});
/* 	
	$("#itemType").kendoDropDownList({
		dataValueField: "cdVal",
		dataSource: gfn_getCode('item_type'),
		valueTemplate : "# var item = gfn_getMsg(cdId, cdNm)  #"
			+ "#= item #",
		template : "# var item = gfn_getMsg(cdId, cdNm)  #"
			+ "#= item #",
		index: 0
	}); */
	
	if(mode=='NEW'){
		$("#jtePopForm_master").find("input").each(function(index,item){
			var formatType = $(item).attr("format");
			var fillTextId = $(item).attr("id");
			if(formatType == "currency"){
				$("#"+fillTextId).kendoNumericTextBox({
					format: "n0",
					value: 0
				});
			} else if(formatType == "numeric"){
				$("#"+fillTextId).kendoNumericTextBox({
					value: 0
				});
			}
			else if(formatType == "datepicker"){
				$("#"+fillTextId).kendoDatePicker({
					format : "yyyy-MM-dd"
				});
			} else{
				$("#"+fillTextId).addClass("k-textbox");
			}
		});
	} else{
		$('#bomDelBtn').show();
		lfo_common.popData = selectedItem;
		
		$.each($("#bomParentId").data('kendoDropDownList').dataSource.data(), function(index, item) {
			if(item.bomId == lfo_common.popData.bomId) {
				$("#bomParentId").data('kendoDropDownList').dataSource.remove(item);
				return false;
			}
		});
		
		$("#jtePopForm_master").find("input").each(function(index,item){
			var formatType = $(item).attr("format");
			var fillTextId = $(item).attr("id");
			
			if(formatType == "currency"){
				$("#"+fillTextId).kendoNumericTextBox({
					format: "n0",
					value: lfo_common.popData[fillTextId]
				});
			} else if(formatType == "numeric"){
				$("#"+fillTextId).kendoNumericTextBox({
					format: "0",
					value: lfo_common.popData[fillTextId]
				});
			} else if(formatType == "datepicker"){
				$("#"+fillTextId).kendoDatePicker({
					format : "yyyy-MM-dd",
					value: lfo_common.popData[fillTextId]
				});
			} else if(formatType == "selBox"){
				if(fillTextId == "bomParentId") {
					$("#"+fillTextId).data("kendoDropDownList").select(function(dataItem) {
						if(dataItem.bomId === lfo_common.popData[fillTextId]) {
							return dataItem.bomId === lfo_common.popData[fillTextId];
						}
					});
				} else {
					$("#"+fillTextId).data("kendoDropDownList").select(function(dataItem) {
						if(dataItem.cdId === lfo_common.popData[fillTextId]) {
							return dataItem.cdId === lfo_common.popData[fillTextId];
						} else if(dataItem.cdVal === lfo_common.popData[fillTextId]) {
							return dataItem.cdVal === lfo_common.popData[fillTextId];
						} else if(dataItem.cdNm === lfo_common.popData[fillTextId]) {
							return dataItem.cdNm === lfo_common.popData[fillTextId];
						}
					});
				}
			} else{
				$("#"+fillTextId).addClass("k-textbox");
				$("#"+fillTextId).val(lfo_common.popData[fillTextId]);
			}
		});
		
	}
}

this.lfn_popSave = function(formID){
	//입력폼 serialize 
	var savePrmt = $("#"+formID).serializeObject();
	savePrmt.itemId = lfo_common.itemId;

	switch(lfo_common.mode) {
	case "NEW":
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setBom",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		break;
	default :
		var flag = true
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/getBomList",
			type: "POST",
			data: { itemId: savePrmt.bomId },
			success: function(data){
				$.each(data.result, function(index, item) {
					if(savePrmt.bomParentId == item.bomId) {
						kendo.alert("해당 Bom 요소의 하위 요소를 상위 요소로 선택 할 수 없습니다.");
						flag = false;
					}
				});
				
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		if(!flag) {
			return flag;
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/updateBom",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		break;
	}
	
	gfn_closePop(formID);
	lfn_setBomTree(lfo_common);
}

this.lfn_popDelete = function(formID){
	var deletePrmt = $("#"+formID).serializeObject();
	
	kendo.confirm("해당 Bom을 삭제하시겠습니까?<br/> 상위 노드를 삭제 할 경우 하위 노드 전부가 삭제 됩니다.")
		.done(function(){
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + "/deleteBom",
				type: "POST",
				data: JSON.stringify(deletePrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					
					gfn_closePop(formID);
					lfn_setBomTree(lfo_common);
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		})
		.fail(function(){
		});
	
	
}

this.lfn_bomTargetInfo = function(){
	lfn_bomTargetInfo_open();
}

this.lfn_bomTargetInfo_open = function(){

	if($("#bomTarget").val() == "prcs_bom01") {
		var options = {
				modal:true, 
				width: "700px", // 200511 JJW 그리드 너비에 딱 맞게 수정 700px -> 1000px;로 바꿨는데 안바뀜
				height: "443px", /* 200413 두번째 추가 팝업 (정보조회) height 수정_LYM */ /* 200423 두번째 추가 팝업 (정보조회) height 여백이 없도록 수정_LYM */
				id:"popItemInfo", 
				title:gfn_getMsg("pop_itemInfo"),			//부품정보
				workCd:"", 
				bdSeq:"",
				resizable : true,
				animation:{open :{effects:"expand:vertical fadeIn"},
				close :{effects:"expand:vertical fadeIn", reverse: true}},
				actions:["Close"]
		};
		
		options.callback = function(){
			lfn_jtePopGrd_setGrd();
			lfo_common.popGrid = $("#popItemGrid").getKendoGrid();
			lfn_jtePopGrd_eventBind();
		};
		
		this.gfn_winOpen(options);
	} else if($("#bomTarget").val() == "prcs_bom02") {
		
		
		var callback = function(e) {
			$('#bomTargetId').val(e.mtrlId);
			$('#bomTargetNm').val(e.mtrlNm);
		};
		
		gfn_openCustomPop("material", callback);
	}
	
}

//Pop - grid 생성
this.lfn_jtePopGrd_setGrd = function(){
	//검색영역
	var jtePopGrd_shAr= '<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jtePopGrd_shSelBox\"/>'																						//검색(UI)
		+'<input type=\"text\" id=\"jtePopGrd_shSelTxt\" name=\"jtePopGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'										//검색(Input)
		+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jtePopGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>';			//조회

	//새로고침
	var jtePopGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jtePopGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : "/cform/basMgt/operMgt/itemMgt/getItemList",
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
						searchGubun: $("#jtePopGrd_shSelBox").val(),
						searchText: $("#jtePopGrd_shSelTxt").val()
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
					itemPrice: { type: "int" },
					itemPersonCost: { type: "int" },
					itemType: { type: "int" },
					itemLen: { type: "int" },
					itemWidth: { type: "int" },
					itemThick: { type: "int" },
					itemWeight: { type: "int" },
					itemUnit: { type: "string" },
					itemMtrl: { type: "string" },
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
	$("#popItemGrid").kendoGrid({
		dataSource: dataSource,
		columns: [
			{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "10%"},			//부품코드
			{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "10%"},			//부품명
			{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
				title:gfn_getMsg("col_itemType"), width: "5%"},							//부품유형
			{field: "description", title:gfn_getMsg("col_desc"), width: "18%"}			//설명
		],
		allowCopy:true,
		resizable: true,
 		columnMenu: true,
 		sortable: {
			mode: "multiple",
			allowUnsort: true
		},
		toolbar: [
			{template: kendo.template(jtePopGrd_shAr)},
			{template: kendo.template(jtePopGrd_refreshBtn)}
		],
		selectable: "multiple, row",
		navigatable: true,
		pageable: {
			pageSizes: true
		},
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		}
		
	});
}
</script>