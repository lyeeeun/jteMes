<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 테이블형식을 반응형 웹을 위해 div로 변경_200911 JJW  -->

<div id="grid-content" class="routingMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="routingMgtForm routingMgtForm-jteSingleGrid" style="width:44.5%;"></div>
	<div class="routingMgtForm routingMgtForm-jteSubGrid" style="width: 54.5%; overflow: auto;"><button id="routingAddBtn" class="k-button k-primary routingAddBtn" type='button' onclick="lfn_jtePop_open('NEW', '')" style="display:none;"><spring:message code = "btn_newCreat"></spring:message></button>
	<div id="routingTree"></div></div>
</div>

<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="routingMgtForm">
				<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
					<colgroup>
						<col class="col-left-title">
						<col class="col-left-content">
						<col class="col-center-content">
						<col class="col-right-content">
					</colgroup>
					<tr>
					<!-- Routing 코드 -->
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_routCd"></spring:message> : </td>
						<td><input type="text" id="routingId" class="center-input" name="routingId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
					<!-- 공정유형 -->
						<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_routType"></spring:message> : </td>
						<td><input id="routingType" class="center-input" name="routingType" msg="process_type" format="selBox"/></td>
					</tr>
					<tr class="rtlInfo">
					<!-- 관련 설비 정보 -->
						<td><i class="fas fa-caret-right"></i><spring:message code = "pop_relEqmtInfo"></spring:message> : </td>
						<td colspan="3"><button type="button" id="btn_equipment_info" class="k-button btn_equipment_info" onclick= "lfn_equipmentInfo('NEW')" >
					<!-- 설비 정보 추가 -->
						<spring:message code = "pop_eqmtInfoAdd"></spring:message></button></td>
					</tr>
					<%-- <tr class="rtlInfo">
					<!-- 관련 공구 정보 -->
						<td><i class="fas fa-caret-right"></i><spring:message code = "pop_relToolInfo"></spring:message> : </td> 
						<td colspan="3"><button type="button" id="btn_tool_info" class="k-button btn_tool_info" onclick= "lfn_toolInfo('NEW')" >
					<!-- 공구 정보 추가 -->
						<spring:message code = "pop_toolInfoAdd"></spring:message></button></td>
					</tr> --%>
					<tr class="rtlInfo">
					<!-- BOM 연결 -->
						<td><i class="fas fa-caret-right"></i><spring:message code = "pop_bomConnect"></spring:message> : </td>
						<td colspan="2"><select id="connectBomList" class="center-input btn-input"></select></td>
						<td>
							<button class="k-button k-primary connectBom" type="button" id="connectBom" name="connectBom" onclick="lfn_connectBom()">
							<spring:message code = "pop_bomConnect"></spring:message></button>
						</td>
					</tr>
					<tr>
					<!-- 순서 -->
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_sequence"></spring:message> : </td>
						<td><input type="text" id="routingSeq" class="left-input" name="routingSeq" format='numeric'/></td>
					<!-- 작업시간 -->
						<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_wrkTime"></spring:message> : </td>
						<td><input type="text" id="manHour" class="right-input" name="manHour" format='numeric'/></td>
					</tr>
					<tr>
					<!-- Cycle Time -->
						<td class="td-left-title"><i class="fas fa-caret-right left-caret"></i>Cycle Time : </td>
						<td><input type="text" id="cycleTime" class="right-input" name="cycleTime" format='numeric'/></td>
					</tr>
					<tr>
					<!-- Setup Time -->
						<td><i class="fas fa-caret-right"></i>Setup Time : </td>
						<td><input type="text" id="setupTime" class="left-input" name="setupTime" format='numeric'/></td>
					<!-- Inspect Time -->
						<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i>Inspect Time : </td>
						<td><input type="text" id="inspectTime" class="right-input" name="inspectTime" format='numeric'/></td>
					</tr>	
					<tr>
					<!-- 첨부파일 -->
						<td class="addFile"><i class="fas fa-caret-right"></i><spring:message code = "col_attachment"></spring:message> : </td>
						<td colspan="3">
							<input name="attachFiles" id="attachFiles" type="file" aria-label="files" format="file" code="routingId" />
							<input type="hidden" id="insertAttach" value = "[]"/>
							<input type="hidden" id="deleteAttach" value = "[]"/>
						</td>
					</tr>
					<tr>
					<!-- 설명 -->
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
						<td colspan="3"><input type="text" id="description" class="center-input" name="description"/></td>
					</tr>	
				</table>
				<div class="final-btn-area">
					<button class="k-button k-primary final-btn" type="button" onclick = "lfn_popSave('jtePopForm_form')"><spring:message code = "pop_save"></spring:message></button>														<!-- 저장 -->
					<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>														<!-- 취소 -->
					<button id="routingDelBtn" class="k-button k-primary final-btn" type="button" onclick = "lfn_popDelete('jtePopForm_form');" style="display:none"><spring:message code = "btn_delete"></spring:message></button>			<!-- 삭제 -->
				</div>
			</form>
		</div>
</div>
<div style="display:none;">
	<div id="bomInfo">
		<div id="bomTree"></div>
		<div class="final-btn-area">
			<button class="k-button k-primary final-btn" type="button" onclick = "lfn_bomSave('bomInfo')"><spring:message code = "pop_save"></spring:message></button>				<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('bomInfo');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="equipment_info">
		<div class="processInfoForm equipment_info_div">
			<div class="k-widget k-header">
				<div class="routingMgtForm search-area">
					<input id="searchEqmt" autocomplete="off" class="k-textbox searchEqmt" placeholder="<spring:message code = "pop_allEqmtSrh"></spring:message>"/><span class="k-icon k-i-search left-icon"></span><!--전체 설비 목록 내 검색--><!-- left-icon 클래스 추가, 인풋박스 placeholder 추가 200416 JJW-->
					<input id="searchSelectedEqmt" autocomplete="off" class="k-textbox searchSelectedEqmt" placeholder="<spring:message code = "pop_relEqmtSrh"></spring:message>"/><span class="k-icon k-i-search right-icon"></span><!--관련 설비 목록 내 검색--><!-- right-icon 클래스 추가, 인풋박스  placeholder 200416 JJW -->
				</div>
			</div>
			<div class="equipment_info_left"><spring:message code = "pop_allEqmtList"></spring:message></div>			<!-- 전체 설비 목록 -->
			<div class="equipment_info_right">
				<spring:message code = "pop_relEqmtList"></spring:message>
				<i class="fas fa-info-circle" title="default 값을 설정하시기 위해서는 해당 설비에 체크하여 주십시오." ></i>   <!-- style="background:yellow;" -->
			</div>			<!-- 관련 설비 목록 -->
			<select id="equipmentList" class="equipmentList"></select>
			<select id="selectedEquipment" class="selectedEquipment"></select>
		</div>
		<div class="routingMgtForm-pop final-btn-area" style="text-align:center;">
			<button type="button" class="k-button final-btn" onclick = "lfn_rtlEquipmentSave('equipment_info')"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
			<button type="button" class="k-button final-btn" onclick = "gfn_closePop('equipment_info');"><spring:message code = "pop_cancel"></spring:message></button>					<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="jtePopAddForm" class="routingMgtForm">
		<form id="toolInfoPopup_form" class="toolInfoPopup_form routingMgtForm">
			<div id="defectInfoOption" class="plus-minus-btn-area">
				<button class="k-button k-primary plus-minus-btn" type="button" id="defectAdd">+</button>
				<button class="k-button k-primary plus-minus-btn" type="button" id="defectRemove">-</button>
				<button class="k-button k-primary" type="button" id="defaultSettingCall" onclick = "lfn_defaultSettingCall()" style="float:right;">기본 설정 값 적용</button>
				<button class="k-button k-primary" type="button" id="defaultSettingSave" onclick = "lfn_defaultSettingSave()" style="float:right; margin-right:5px;">기본 설정 값 저장</button>
			</div>
<!-- 		<div>관련 공구, 공구 RPM, 공구 위치, 공구 사용 횟수</div>
			<ul id="toolInfo" class="toolInfo">
			</ul> -->
			<div>
			<table id="toolInfo-title" class="toolInfo toolInfo-title">
				<colgroup>
					<col class="col-toolInfo-check">
					<col class="col-toolInfo1">
					<col class="col-toolInfo2">
					<col class="col-toolInfo3">
					<col class="col-toolInfo4">
				</colgroup>
				<tr>
					<td><span style="visibility: hidden;"></span></td>
					<td class="toolInfo-table-name"><spring:message code = "col_relTool"></spring:message></td>				<!--관련 공구--><!-- 20.04.30 JJW 클래스 추가 -->
					<td class="toolInfo-table-name"><spring:message code = "col_toolNum"></spring:message></td>				<!-- 공구 번호 -->
					<td class="toolInfo-table-name"><spring:message code = "col_toolRpm"></spring:message></td>				<!-- 공구 RPM -->
					<td class="toolInfo-table-name"><spring:message code = "col_toolUseQuan"></spring:message></td>			<!-- 공구사용량 -->
				</tr>
			</table>
			</div>
			<div class="toolInfo-div">
			<table id="toolInfo" class="toolInfo toolInfo-content">
			</table>
			</div>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary final-btn" type="button" onclick = "lfn_saveRtlToolList()"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/routing/routingMgt/routingMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
 <link href='/resources/mes/css/contents/basMgt/routing/routingMgt/routingMgtForm_JJW.css' rel="stylesheet">
<!-- 내부 스타일 외부로 이동_200416 LYM&JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object

//검색영역
var jteSgGrd_shAr= '<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteSgGrd_shSelBox\"/>'																						//입력(UI)
	+'<input type=\"text\" id=\"jteSgGrd_shSelTxt\" name=\"jteSgGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'									//입력(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" lfn_jteSgGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>';			//조회

//새로고침
var jteSgGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" lfn_jteSgGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfo_common.ctrlUrl ="/form/basMgt/routing/routingMgt";
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
				url : "/form/basMgt/operMgt/itemMgt/getItemList",
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
			{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "150px"},				//부품코드
			{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "170px"},				//부품명
			{field: "description", title:gfn_getMsg("col_desc"), width: "300px"}			//설명
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
		lfn_setRoutingTree(lfo_common.sgGrid.dataItem($(e.target).closest('tr')));
		$('#routingAddBtn').show();
	});
}

this.lfn_setRoutingTree = function(param) {
	
	var connectionsDatasource = [];
	
	lfo_common.itemId = param.itemId 
		
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getRoutingInfo",
		type: "POST",
		data: { itemId: param.itemId},	
		success: function(data){
			
			var insertNode = {};
			lfo_common.routingData = [];
			
			$.each(data.rows, function(index, item) {
				insertNode = {
						no: index,
						routingId: item.routingId,
						routingSeq: item.routingSeq,
						routingType: item.routingType,
						routingTypeNm: gfn_getMsg('bc_' + item.routingType),
						manHour: item.manHour,
						description: item.description,
						itemId: item.itemId,
						cycleTime: item.cycleTime,
						setupTime: item.setupTime,
						inspectTime: item.inspectTime,
						colorScheme: "#7ca6ff", /*200416  우측  배경 색상 수정_LYM "#96a6ba" */
				};
				
				if(index != 0) {
					connectionsDatasource.push({itemId: item.itemId, routingId: item.routingId, from: index - 1, to: index});
				}
				
				lfo_common.routingData.push(insertNode);
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	if(lfo_common.routingData.length == 0) {
		$("#routingTree").empty();
		return false;
	}
	
	$("#routingTree").kendoDiagram({
		dataSource: {
			data: lfo_common.routingData,
			schema: {
				model: {
					id: "no",
					fields: {
						no: {from: "no", type: "int"},
						routingId: { type: "string" },
						routingSeq: { from: "routingSeq", type: "int" },
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
		/* zoomStart: function(e){
			var zoomDirection = "x";
			var diagram = e.sender,
			panPoint = diagram.pan();
			panPoint[zoomDirection] = panPoint[zoomDirection] + e.meta.delta;
			diagram.pan(panPoint);
			e.preventDefault();
		}, */
		layout: {
			type: "layered",
			subtype: "right"
		},
		shapeDefaults: {
			visual: visualTemplate,
			editable: {
				tools: false,
			}
		},
		connectionDefaults: {
			type: "cascading",
			stroke: {
				color: "#525252", /* 200416 Tree 선 색상 수정_LYM #adbac7 */
				width: 2.4 /* 200417 Tree 선 두께 수정_JJW 2.0에서 2.4로 */
			},
			editable: {
				tools: false,
			}
		},
		editable: false,
		pannable: false,
		/* zoomRate: 0, */
		zoom:false,
		dataBound: function () {
	          var bbox = this.boundingBox();
	          this.wrapper.width(bbox.width + bbox.x + 50);
	          this.wrapper.height(bbox.height + bbox.y + 50);
	          this.resize();
	        }
	});
	
	var diagram = $("#routingTree").getKendoDiagram();
	diagram.bringIntoView(diagram.shapes[0], { align: "left middle" });
	
}

function visualTemplate(options) {
	var dataviz = kendo.dataviz;
	var g = new dataviz.diagram.Group();
	var dataItem = options.dataItem;
	
	g.append(new dataviz.diagram.Rectangle({
		width: 200,
		height: 80,
		stroke: {
			width: 1
		},
		fill: dataItem.colorScheme,
	}));

	g.append(new dataviz.diagram.Rectangle({
		width: 200,
		height: 25,
		stroke: {
			width: 0
		},
		fill: "#3367D6",
	}));
	
	g.append(new dataviz.diagram.TextBlock({
		text: dataItem.routingSeq + "차",
		x: 10,
		y: 2,
		fontSize: 16,
		fontStyle: "bold",
		color: "white" /* 200416 n차 텍스트 색상 수정_LYM #ffffff */
		
	}));
	
	g.append(new dataviz.diagram.TextBlock({
		text: dataItem.routingId,
		x: 10,
		y: 30,
		fontSize: 13,
		fontStyle: "bold",
		color: "white" /* 200416 RUT 텍스트 색상 수정_LYM #ffffff */
	}));
	
	g.append(new dataviz.diagram.TextBlock({
		text: dataItem.routingTypeNm,
		x: 10,
		y: 50,
		fontSize: 13,
		fontStyle: "bold",
		color: "white" /* 200416 RUT 텍스트 색상 수정_LYM #ffffff */
	}));

	return g;
}

this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
			modal:true, 
			width: "750px", 
			height: "630px",  /** 200416 추가 생성에 따른 팝업 height 조정_LYM 535_JJW 535 -> 550**/
			id:"jtePopForm", 
			title:gfn_getMsg("pop_routRegist"),				//라우팅 등록
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
		options.height = "387px"; /** JJW 235 -> 250_LYM 250 -> 387**/
	} else{
		options.title = gfn_getMsg("pop_routSrh");			//라우팅 수정
		options.workCd = "EDIT";
		options.callback = function(){
			lfn_jtePopGrd_setForm(mode, selectedItem);
		};
 	}
	
	this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_setForm = function(mode, selectedItem){
	
	//관련자료 초기화(전역변수에 데이터가 남아 있어 이전데이터를 불러온다.) -- jkkim
	lfo_common.rtlToolList = [];
	lfo_common.eqmtList = [];
	lfo_common.eqmtInsertList = [];
	lfo_common.eqmtDeleteList = [];
	
	lfo_common.toolInsertList = [];
	lfo_common.toolUpdateList = [];
	lfo_common.toolDeleteList = [];
	
	lfo_common.defaultEqmtMgtId = "";
	
	lfo_common.mode = mode;
	
	$("#connectBomList").kendoListBox({
		dataTextField: "bomTargetNm",
		dataValueField: "bomId"
	});
	
	$("#routingType").kendoDropDownList({
		dataSource: gfn_getCode('process_type'),
		dataValueField: "cdId",
		dataTextField: "cdNm",
		index:0
	});
	
	if(mode=='NEW'){
		$('.rtlInfo').hide();
		
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
					format: "0",
					min: 1
				});
			} else if(formatType == "datepicker"){
				$("#"+fillTextId).kendoDatePicker({
					format : "yyyy-MM-dd"
				});
			}else if(formatType == "file"){
				if($("#"+fillTextId).attr("data-role") != "upload"){
					$("#"+fillTextId).kendoUpload({
						template: '<li class="k-file k-file-success" data-uid="#=files[0].uid #">'+
							'<span class="k-progress"></span>'+
							'<span class="k-file-extension-wrapper">'+
								'<span class="k-file-extension">#=files[0].extension#</span>'+
								'<span class="k-file-state"></span>'+
							'</span>'+
							'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
								'<span class="k-file-name" title="#=name#">#=name#</span>'+
								'<span class="k-file-size">#=size# bytes</span>'+
								'<input class="k-file-path" type="hidden" value="#=files[0].path#"/>'+
								'<input class="k-file-attachId" type="hidden" value="#=files[0].attachId#"/>'+
							'</span>'+
							'<strong class="k-upload-status">'+
								'<button type="button" class="k-button k-upload-action" aria-label="Remove">'+
									'<span class="k-icon k-i-close k-i-x" title="Remove"></span>'+
								'</button>'+
							'</strong>'+
						'</li>',
						
						async: {
						saveUrl: "/attach/attachFilesTempSave",
						removeUrl: "/attach/attachFilesTempDelete",
						autoUpload:true
						}
						,success: gfn_attachProc
						,remove : function (e) {
							var attachFiles = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
							attachFiles.forEach(function(item,index){
								if(item.attachOrigin == e.files[0].name){
									e.data = item;
								}
							});
						}
					});
				}
			} else{
				$("#"+fillTextId).addClass("k-textbox");
			}
		});
	} else{
		$('.rtlInfo').show();
		
		$('#routingDelBtn').show();
		lfo_common.connectBomList = new Array();
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/getRtlBomList",
			type: "POST",
			data: JSON.stringify({routingId: selectedItem.routingId}),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				$.each(data.result.bomList, function(index, item) {
					lfo_common.connectBomList.push({ bomId: item.bomId, bomTargetNm: item.bomTargetNm });
				});
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		
		lfo_common.beforeBomList = lfo_common.connectBomList;
			
		var listbox = $("#connectBomList").data("kendoListBox");
		
		listbox.setDataSource(lfo_common.connectBomList);
		
		lfo_common.popData = selectedItem;
		
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
					min: 1,
					value: lfo_common.popData[fillTextId]
				});
			} else if(formatType == "datepicker"){
				$("#"+fillTextId).kendoDatePicker({
					format : "yyyy-MM-dd",
					value: lfo_common.popData[fillTextId]
				});
			} else if(formatType == "selBox"){
				$("#"+fillTextId).data("kendoDropDownList").select(function(dataItem) {
					return dataItem.cdId === lfo_common.popData[fillTextId];
				});
			}else if(formatType == "file"){
				var attachCode = selectedItem[$(item).attr("code")];
				var fileList = [];
				$.ajax({
					async:false,
					url : "/attach/getAttachFiles",
					type: "POST",
					data: {attachCode : attachCode},
					success: function(data){
						$(data.result).each(function(fileIndex,fileUnit){
							fileList.push({
								name : fileUnit.attachOrigin, 
								size : fileUnit.attachSize, 
								extension : fileUnit.attachExt, 
								path : fileUnit.attachPath,
								attachId : fileUnit.attachId
								});
							var insertFiles = JSON.parse($("#insertAttach").val());
							fileUnit.attachStatus = "OLD";
							insertFiles.push(fileUnit);
							console.log(insertFiles);
							$("#insertAttach").val(JSON.stringify(insertFiles));
						});
					},error : function(ex){
						gfn_loading(false);
						gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
					}
				});
					$("#"+fillTextId).kendoUpload({
						template: '<li class="k-file k-file-success" data-uid="#=files[0].uid #">'+
							'<span class="k-progress"></span>'+
							'<span class="k-file-extension-wrapper">'+
								'<span class="k-file-extension">#=files[0].extension#</span>'+
								'<span class="k-file-state"></span>'+
							'</span>'+
							'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
								'<span class="k-file-name" title="#=name#">#=name#</span>'+
								'<span class="k-file-size">#=size# bytes</span>'+
								'<input class="k-file-path" type="hidden" value="#=files[0].path#"/>'+
								'<input class="k-file-attachId" type="hidden" value="#=files[0].attachId#"/>'+
							'</span>'+
							'<strong class="k-upload-status">'+
								'<button type="button" class="k-button k-upload-action" aria-label="Remove">'+
									'<span class="k-icon k-i-close k-i-x" title="Remove"></span>'+
								'</button>'+
							'</strong>'+
						'</li>',
						
						async: {
						saveUrl: "/attach/attachFilesTempSave",
						removeUrl: "/attach/attachFilesTempDelete",
						autoUpload:true
						}
						,success: gfn_attachProc
						,remove : function (e) {
							var attachFiles = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
							
							attachFiles.forEach(function(item,index){
								if(item.attachOrigin == e.files[0].name){
									e.data = item;
								}
							});
						},
						files:fileList
					});
				}else{
				$("#"+fillTextId).addClass("k-textbox");
				if(fillTextId != "insertAttach" && fillTextId != "deleteAttach"){
					$("#"+fillTextId).val(lfo_common.popData[fillTextId]);
				}
			}
		});
		
	}
}

this.lfn_popSave = function(formID){
	//입력폼 serialize 
	
	var savePrmt = gfn_serializeObject(formID);
	savePrmt.itemId = lfo_common.itemId;
	
	var flag = true;
	$.each(lfo_common.routingData, function(index, item) {
		if(item.routingSeq == savePrmt.routingSeq) {
			flag = false;
		}
	});

	switch(lfo_common.mode) {
	case "NEW":
		//개발품목 예외처리 추가 -jkkim 2020-06-02
		if(gfn_isEmpty(gfn_getCode("devItem")) || lfo_common.itemId != gfn_getCode("devItem").cdVal){
			if(!flag) {
				kendo.alert(gfn_getMsg("pop_alreadyProcess")) //이미 해당 차수에 공정이 설정되어 있습니다.
				return flag;
			}
		}
		
		//savePrmt.eqmtMgtList = lfo_common.eqmtList;
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setRoutingInfo",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				alert(gfn_getMsg("pop_successConfirm"))
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		break;
	default :
		if(gfn_isEmpty(gfn_getCode("devItem")) || lfo_common.itemId != gfn_getCode("devItem").cdVal){
			if(lfo_common.popData.routingSeq != savePrmt.routingSeq) {
				if(!flag) {
					kendo.alert(gfn_getMsg("pop_alreadyProcess"))			//이미 해당 차수에 공정이 설정되어 있습니다.
					return flag;
				}
			}
		}
		var listBox = $("#connectBomList").data("kendoListBox").dataItems();
		
		var beforeBomList = lfo_common.beforeBomList.slice();
		var selBomList = listBox.slice();
		
		$.each(beforeBomList, function(index, item) {
			var idx = selBomList.findIndex(x => x.bomId == item.bomId);
			if(idx != -1) {
				selBomList.splice(idx, 1);
			}
		});
		
		savePrmt.bomList = selBomList
		
		selBomList = listBox.slice();
		
		$.each(selBomList, function(index, item) {
			var idx = beforeBomList.findIndex(x => x.bomId == item.bomId);
			if(idx != -1) {
				beforeBomList.splice(idx, 1);
			}
		});
		
		savePrmt.delBomList = beforeBomList;
		
		savePrmt.eqmtMgtList = lfo_common.eqmtInsertList;
		savePrmt.delEqmtMgtList = lfo_common.eqmtDeleteList;
		
		/* savePrmt.toolList = lfo_common.toolInsertList
		savePrmt.updateToolList = lfo_common.toolUpdateList
		savePrmt.delToolList = lfo_common.toolDeleteList */
		
		savePrmt.defaultEqmtMgtId = lfo_common.defaultEqmtMgtId
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/updateRoutingInfo",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				alert(gfn_getMsg("pop_successConfirm"))
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		}); 
		break;
	}
	
	lfo_common.eqmtList = {};
	gfn_closePop(formID);
	lfn_setRoutingTree(lfo_common);
}

this.lfn_popDelete = function(formID){
	var deletePrmt = gfn_serializeObject(formID);
	
	deletePrmt.delEqmtMgtList = lfo_common.eqmtDeleteList;
	
	kendo.confirm(gfn_getMsg("pop_routDelConfirm"))	
		.done(function(){
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + "/deleteRoutingInfo",
				type: "POST",
				data: JSON.stringify(deletePrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					alert(gfn_getMsg("pop_successConfirm"))
					gfn_closePop(formID);
					lfn_setRoutingTree(lfo_common);
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		})
		.fail(function(){
		});
	
	
}

this.lfn_connectBom = function(){
	var mode="NEW";
	var options = {
			modal:true, 
			width: "900px", /* 200518 JJW 봄 관리 팝업 1200 > 900 */
			height: "700px", /* 200518 JJW 봄 관리 팝업 700 > 600 */
			id:"bomInfo", 
			title:gfn_getMsg("pop_mtrlRequiredList"),			//자재 필요 목록
			workCd:mode, 
			bdSeq:"",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:["Close"]
	};
	
	options.callback = function(){
		var listbox = $("#connectBomList").data("kendoListBox");
		lfn_setBomTree(listbox.dataSource.options.data);
	};
	 
	this.gfn_winOpen(options);
}



this.lfn_setBomTree = function(param) {
	
	var bomTreeData = [];
	var connectionsDatasource = [];
	
	$.ajax({
		async:false,
		url : "/form/basMgt/bom/bomMgt/getBomList",
		type: "POST",
		data: { itemId: lfo_common.itemId },	
		success: function(data){
			var insertNode = {};
			
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
						connectRouting: "NO"
				};
				
				var idx = param.findIndex(x => x.bomId == item.bomId)
				if(idx != -1) {
					insertNode.connectRouting = "YES";
				}
				
				if(index != 0) {
					if(item.bomTarget == "prcs_bom01") {
						insertNode.colorScheme = "#d6e3ff"; /*"#4d5f75"_LYM*/ /* 200413  우측  1단계 배경 색상 수정_LYM */
					} else if(item.bomTarget == "prcs_bom02") {
						insertNode.colorScheme = "#e4bdff"; /*"#96a6ba"_LYM*/ /* 200413  우측  2단계 배경 색상 수정_LYM*/
					}
					connectionsDatasource.push({itemId: item.itemId ,bomId: item.bomId, from: item.bomParentId, to: item.bomId});
				}
				
				bomTreeData.push(insertNode);
				
				//lfo_common.bomData.push(insertNode);
				
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
		layout: {
			type: "layered"
		},
		shapeDefaults: {
			visual: visualTemplateBom,
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
		},
		click: function(e) {
			if( e.item.dataItem.connectRouting == "NO" ) {
				e.item.dataItem.connectRouting = "YES";
			} else {
				e.item.dataItem.connectRouting = "NO";
			}
			
			e.item.redrawVisual();
		}
	});
	
	var diagram = $("#bomTree").getKendoDiagram();
	diagram.bringIntoView(diagram.shapes[0], { align: "center top" });
	
	
}

function visualTemplateBom(options) {
	var checkbox = '<input type="checkbox" checked/>';
	
	if(options.dataItem.connectRouting == "NO") {
		checkbox = '<input type="checkbox"/>';
	}
	
	var contentTemplate = kendo.template(checkbox);
    var dataviz = kendo.dataviz;
    var g = new dataviz.diagram.Group();
    var dataItem = options.dataItem;
    var draw = kendo.drawing;
    var renderElement = $("<div style='display:inline-block' />").appendTo("body");
    renderElement.html(contentTemplate);
    var output = new kendo.drawing.Group();
    var width = renderElement.width();
    var height = renderElement.height();
    var geom = new kendo.geometry.Rect([0, 0], [width, height]);
    output.append(new kendo.drawing.Rect(geom, { stroke: { width: 0 }}));

    draw.drawDOM(renderElement)
    .then(function(group) {
	    output.clear();
	    output.append(group);
	    renderElement.remove();
  	});

    g.append(new dataviz.diagram.Rectangle({
        width: 200,
        height: 80,
        stroke: {
            width: 1
        },
        fill: dataItem.colorScheme,
    }));
    
    g.append(new dataviz.diagram.TextBlock({
    	text: dataItem.bomId,
    	 x: 10,
         y: 20,
         fontSize: 16,
         fontStyle: "bold",
         color: "#000000" /* 200413 Tree 제목 색상 수정_LYM #ffffff */
    }));
    
    g.append(new dataviz.diagram.TextBlock({
    	 text: dataItem.bomTargetNm,
    	 x: 10,
         y: 40,
         fontSize: 12,
         fontStyle: "bold", /**0430 패딩 바텀 넣자**/
         color: "#525252", /*"#eaf4f9"_LYM*/ /* 200413 Tree 내용 색상 수정_LYM */
    }));
    
	g.append(new dataviz.diagram.TextBlock({
		text: dataItem.mtrlDesc,
		x: 10,
		y: 55,
		fontSize: 12,
		fontStyle: "bold",
		color: "#525252" /*"#eaf4f9"_LYM*/ /* 200413 Tree 내용 색상 수정_LYM */
	}));
    
    g.drawingElement.append(output);
    
    return g;
}

this.lfn_onSelect = function(e) {
	var selectedItem = e.selected[0]; // first element in selection
	if(selectedItem instanceof kendo.dataviz.diagram.Shape){
	}
}

this.lfn_bomSave = function(formID) {
	lfo_common.connectBomList = new Array();
	var diagram = $("#bomTree").getKendoDiagram();
	$.each(diagram.shapes, function(index, item) {
		if(item.dataItem.connectRouting == "YES") {
			lfo_common.connectBomList.push({ bomId: item.dataItem.bomId, bomTargetNm: item.dataItem.bomTargetNm });
		}
	});
	
	var listbox = $("#connectBomList").data("kendoListBox");
	listbox.setDataSource(lfo_common.connectBomList);
	gfn_closePop(formID);
} 

this.lfn_equipmentInfo = function(mode) {
	var options = {
			modal:true, 
			width: "600px", 
			height: "510px", /* 200416 팝업창 높이 변경_LYM 500->480px 200807 youmi 480->510px*/
			id:"equipment_info", 
			title:gfn_getMsg("pop_relEqmtMgt"), /** 200416 팝업창 제목 변경_LYM&JJW **/
			workCd:mode, 
			bdSeq:"",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:["Close"],
	};
	
	var equipmentList = new Array();
	var rtlEquipmentList = new Array();

	$.ajax({
		async:false,
		url : "/form/basMgt/operMgt/facilMgt/getEqmtMgtListAll",
		type: "POST",
		data: "",
		success: function(data){
			$.each(data.result, function(index, item){
				equipmentList[index] = {"eqmtMgtId": item.eqmtMgtId, "eqmtMgtNm": item.eqmtMgtNm};
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getRtlEqmtList",
		type: "POST",
		data: { routingId: $('#routingId').val()},
		success: function(data){
			$.each(data.rows, function(index, item){
				rtlEquipmentList[index] = {"eqmtMgtId": item.eqmtMgtId, "eqmtMgtNm": item.eqmtMgtNm, "defaultYn": item.defaultYn};
			});
			lfo_common.beforeEqmtList = rtlEquipmentList;
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	if(!gfn_isEmpty(lfo_common.eqmtList)) {
		rtlEquipmentList = lfo_common.eqmtList;
	}
	
	var defaultEqmtMgtId = "";
	$.each(rtlEquipmentList, function(index, item) {
		if(item.defaultYn) {
			defaultEqmtMgtId = item.eqmtMgtId;
		}
		equipmentList.splice(equipmentList.findIndex(x => x.eqmtMgtId === item.eqmtMgtId), 1);
	});
	
	var allTemplate = '<h3>#: data.eqmtMgtNm #</h3></span>';
	var selectedTemplate = '<h3>#: data.eqmtMgtNm #</h3><input type="radio" name="defaultCheck" id= #: data.eqmtMgtId # title="Default 값 설정" /></span>';
	
	options.callback = function(){
		var equipmentListBox = $("#equipmentList").kendoListBox({
			dataSource: equipmentList,
			dataTextField: "eqmtMgtNm",
			dataValueField: "eqmtMgtId",
			template: allTemplate,
			connectWith: "selectedEquipment",
			toolbar: {
				tools: ["moveUp", "moveDown", "transferTo", "transferFrom", "transferAllTo", "transferAllFrom", "remove"]
			}
		}).data("kendoListBox");
		
		var selectedEquipment = $("#selectedEquipment").kendoListBox({
			dataSource: rtlEquipmentList,
			dataTextField: "eqmtMgtNm",
			dataValueField: "eqmtMgtId",
			template: selectedTemplate,
		}).data("kendoListBox");
		
		$("#searchEqmt").on("input", function(e){
			equipmentListBox.dataSource.filter({field:"eqmtMgtNm", value:$(e.target).val(), operator:"contains"});
		})
		
		$("#searchSelectedEqmt").on("input", function(e){
			selectedEquipment.dataSource.filter({field:"eqmtMgtNm", value:$(e.target).val(), operator:"contains"});
		})
		
		$('#' + defaultEqmtMgtId).prop('checked', true);
		
		lfo_common.defaultEqmtMgtId = defaultEqmtMgtId;
		
	};
	
	this.gfn_winOpen(options);
};

this.lfn_rtlEquipmentSave = function(formID){
	
	var listBox = $("#selectedEquipment").data("kendoListBox").dataItems();
	
	var selectedEquipment = [];
	
	var defaultEqmtMgtId = $('input[name=defaultCheck]:checked').attr("id");
	
	if(defaultEqmtMgtId == undefined) {
		kendo.confirm("기본(Default) 설비를 체크하여 주십시오.");
		return false;
	}
	
	$.each(listBox, function(index, item) {
		if( defaultEqmtMgtId == item.eqmtMgtId ) {
			selectedEquipment.push({
				eqmtMgtId: item.eqmtMgtId,
				eqmtMgtNm: item.eqmtMgtNm,
				defaultYn: true
			});
		} else {
			selectedEquipment.push({
				eqmtMgtId: item.eqmtMgtId,
				eqmtMgtNm: item.eqmtMgtNm,
				defaultYn: false
			});
		}
	})
	
	var beforeEqmtList = lfo_common.beforeEqmtList.slice();
	var selEqmtList = selectedEquipment.slice();
	
	$.each(beforeEqmtList, function(index, item) {
		var idx = selEqmtList.findIndex(x => x.eqmtMgtId == item.eqmtMgtId)
		if(idx != -1) {
			selEqmtList.splice(idx, 1);
		}
	});
	
	lfo_common.eqmtInsertList = selEqmtList;
	selEqmtList = selectedEquipment;
	
	$.each(selEqmtList, function(index, item) {
		var idx = beforeEqmtList.findIndex(x => x.eqmtMgtId == item.eqmtMgtId)
		if(idx != -1) {
			beforeEqmtList.splice(idx, 1);
		}
	});
	
	lfo_common.eqmtDeleteList = beforeEqmtList;
	lfo_common.eqmtList = selectedEquipment;
	lfo_common.defaultEqmtMgtId = defaultEqmtMgtId;
	
	gfn_closePop(formID);
}

this.lfn_toolInfo = function(mode) {
	
	var options = {
		modal:true, 
		width: "800px", /**관련 공구 관리 팝업 너비 변경 JJW 1000->800_LYM 1000**/
		height: "455px", /**관련 공구 관리 팝업 높이 변경 LYM 550->545_JJW 455**/
		id : "jtePopAddForm", 
		title:"관련 공구 관리",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_defectPopup($('#routingId').val());
		lfn_toolPopupEvent();
		};
	this.gfn_winOpen(options);
		
};

this.lfn_defectPopup = function(paramRoutingId) {
	lfo_common.rowCount = 1;
	
	lfo_common.toolList = new Array();
	
	$.ajax({
		async:false,
		url : "/form/basMgt/operMgt/toolMgt/getAllToolInfoList",
		type: "POST",
		data: "",
		success: function(data){
			$.each(data.result, function(index, item){
				lfo_common.toolList[index] = {"toolId": item.toolId, "toolNm": item.toolNm};
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	var rtlToolList = [];
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getRtlToolList",
		type: "POST",
		data: {routingId: paramRoutingId},
		success: function(data){
			$.each(data.rows, function(index, item){
				rtlToolList.push({
					"toolId": item.toolId, 
					"toolRpm": item.toolRpm,
					"toolLocation": item.toolLocation,
					"toolCount": item.toolCount
				});
			});
			
			lfo_common.beforeToolList = rtlToolList;
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	if(!gfn_isNull(lfo_common.rtlToolList)) {
		rtlToolList = lfo_common.rtlToolList;
	}
	
	if(rtlToolList.length != 0) {
		$.each(rtlToolList, function(index, item) {
			lfn_toolAddRow();

			$("#toolInfoPopup_form [name = toolId"+lfo_common.rowCount+"]").data("kendoDropDownList").select(function(dataItem) {
				return dataItem.toolId === item.toolId;
			});
			
			$("#toolInfoPopup_form [name = toolRpm"+lfo_common.rowCount+"]").data("kendoNumericTextBox").value(item.toolRpm);
			
			$("#toolInfoPopup_form [name = toolLocation"+lfo_common.rowCount+"]").val(item.toolLocation);
			
			$("#toolInfoPopup_form [name = toolCount"+lfo_common.rowCount+"]").data("kendoNumericTextBox").value(item.toolCount);
			
			lfo_common.rowCount++;
		});
	} else {
		lfn_toolAddRow();
		
		lfo_common.rowCount++;
	}
	
}

this.lfn_toolPopupEvent = function() {
	$('#defectAdd').click(function() {
		lfo_common.rowCount++;
		lfn_toolAddRow();
	});
	
	$('#defectRemove').click(function() {
		$.each($('#toolInfo').find('tr'), function(index, item) {
			$(item).find("input[type='checkbox']:checked").closest("tr").remove();
		});
	});
}

this.lfn_toolAddRow = function() {
	
	$('#toolInfo').append('<tr>' +
			'<td style="width:4%; text-align:center"><input type="checkbox" name="checkbox' + lfo_common.rowCount + '"/></td>' +
			'<td style="width:24%"><input type="text" class="toolId" format="selBox" name="toolId' + lfo_common.rowCount + '" /></td>' +
			'<td style="width:24%"><input type="text" class="toolLocation k-textbox" format="text" name="toolLocation' + lfo_common.rowCount + '" /></td>' +
			'<td style="width:24%"><input type="text" class="toolRpm" format="numeric" name="toolRpm' + lfo_common.rowCount + '" /></td>' +
			'<td style="width:24%"><input type="text" class="toolCount" format="numeric" name="toolCount' + lfo_common.rowCount + '" /></td>' +
		'</tr>');
	
	$("#toolInfoPopup_form [name = toolId"+lfo_common.rowCount+"]").kendoDropDownList({
		dataSource: lfo_common.toolList,
		dataValueField: "toolId",
		dataTextField: "toolNm",
		index:0
	});
	
	$("#toolInfoPopup_form [name = toolRpm"+lfo_common.rowCount+"]").kendoNumericTextBox({
		format: "0",
		value: 0
	});
	
	$("#toolInfoPopup_form [name = toolCount"+lfo_common.rowCount+"]").kendoNumericTextBox({
		value: 0
	});
	
}

this.lfn_saveRtlToolList = function() {
	lfo_common.rtlToolList = [];
	
	var duplicateCheck = new Array();
	var flag = true;
	
	$.each($('#toolInfo').children('tr'), function(index, item){
		if(duplicateCheck.indexOf($(item).find('input.toolId').val() + $(item).find('input.toolLocation').val()) !== -1){
			kendo.confirm("동일한 공구를 중복하여 선택할 수 없습니다.");
			flag = false;
			return flag;
		}
		duplicateCheck.push($(item).find('input.toolId').val() + $(item).find('input.toolLocation').val());
		
		lfo_common.rtlToolList.push({
			toolId: $(item).find('input.toolId').val(),
			toolRpm: $(item).find('input.toolRpm').val(),
			toolLocation: $(item).find('input.toolLocation').val(),
			toolCount: $(item).find('input.toolCount').val()
		})
	});
	
	if(!flag) {
		return flag;
	}
	
	var beforeToolList = lfo_common.beforeToolList.slice();
	var selToolList = lfo_common.rtlToolList.slice();
	
	$.each(beforeToolList, function(index, item) {
		var idx = selToolList.findIndex(x => x.toolId == item.toolId  && x.toolLocation == item.toolLocation)
		if(idx != -1) {
			selToolList.splice(idx, 1);
		}
	});
	lfo_common.toolInsertList = selToolList;
	selToolList = lfo_common.rtlToolList.slice();;
	
	lfo_common.toolUpdateList = new Array();
	
	$.each(selToolList, function(index, item) {
		var idx = beforeToolList.findIndex(x => x.toolId == item.toolId && x.toolLocation == item.toolLocation)
		if(idx != -1) {
			lfo_common.toolUpdateList.push(item);
			beforeToolList.splice(idx, 1);
		}
	});
	
	lfo_common.toolDeleteList = beforeToolList;

	gfn_closePop('jtePopAddForm');
}


this.lfn_defaultSettingSave = function() {
	var savePrmt = {};
	
	var defaultToolList = new Array();
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getRtlToolList",
		type: "POST",
		data: {routingId: "default"},
		success: function(data){ 
			$.each(data.rows, function(index, item){
				defaultToolList.push({
					"toolId": item.toolId, 
					"toolRpm": item.toolRpm,
					"toolLocation": item.toolLocation,
					"toolCount": item.toolCount
				});
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	var beforeDefaultToolList = defaultToolList.slice();
	var saveDefaultToolList = new Array();
	
	var duplicateCheck = new Array();
	var flag = true;
	$.each($('#toolInfo').children('tr'), function(index, item){
		if(duplicateCheck.indexOf($(item).find('input.toolId').val() + $(item).find('input.toolLocation').val()) !== -1){
			kendo.confirm("동일한 공구를 중복하여 선택할 수 없습니다.");
			flag = false;
			return flag;
		}
		duplicateCheck.push($(item).find('input.toolId').val() + $(item).find('input.toolLocation').val());
		
		saveDefaultToolList.push({
			toolId: $(item).find('input.toolId').val(),
			toolRpm: $(item).find('input.toolRpm').val(),
			toolLocation: $(item).find('input.toolLocation').val(),
			toolCount: $(item).find('input.toolCount').val()
		})
	});

	if(!flag) {
		return flag;
	}
	
	var beforeTemp = beforeDefaultToolList.slice();
	var saveTemp = saveDefaultToolList.slice();
	
	$.each(beforeTemp, function(index, item) {
		var idx = saveTemp.findIndex(x => x.toolId == item.toolId && x.toolLocation == item.toolLocation)
		if(idx != -1) {
			saveTemp.splice(idx, 1);
		}
	});
	
	savePrmt.toolList = saveTemp;
	
	saveTemp = saveDefaultToolList
	
	savePrmt.updateToolList = new Array();
	
	$.each(saveTemp, function(index, item) {
		var idx = beforeTemp.findIndex(x => x.toolId == item.toolId && x.toolLocation == item.toolLocation)
		if(idx != -1) {
			savePrmt.updateToolList.push(item);
			beforeTemp.splice(idx, 1);
		}
	});
	
	savePrmt.delToolList = beforeTemp;
	
	kendo.confirm(gfn_getMsg("pop_ToolDefaultSetConfirm"))	
	.done(function(){
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/settingDefaultTool",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				alert(gfn_getMsg("pop_successConfirm"))
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		}); 
	})
	.fail(function(){
	});
	
}

this.lfn_defaultSettingCall = function() {
	lfo_common.rtlToolList = [];
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/getRtlToolList",
		type: "POST",
		data: {routingId: 'default'},
		success: function(data){
			$.each(data.rows, function(index, item){
				lfo_common.rtlToolList.push({
					"toolId": item.toolId, 
					"toolRpm": item.toolRpm,
					"toolLocation": item.toolLocation,
					"toolCount": item.toolCount
				});
			});
		}, error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	$('#toolInfo').empty();
	lfn_defectPopup($('#routingId').val());
}
</script>