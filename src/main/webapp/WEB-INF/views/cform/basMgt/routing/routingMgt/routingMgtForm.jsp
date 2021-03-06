<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 테이블형식을 반응형 웹을 위해 div로 변경_200911 JJW  -->

<div id="grid-content" class="routingMgtForm" style="width:100%;">
	<!-- 좌측영역 -->
	<div id="jteSingleGrid" class="routingMgtForm-jteSingleGrid" style="width:44.5%;"></div>
	<!-- 우측영역 -->
	<div id = "routingGrid" class="routingMgtForm-jteSubGrid" style="width: 54.5%;"></div>
</div>

<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="routingMgtForm">
				<table style="width:100%;" class="BasicTable">
					<colgroup>
						<col style="width:19%;">
						<col style="width:30%;">
						<col style="width:21%;">
						<col style="width:30%;">
					</colgroup>
					<tr>
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_routCd" text="Routing 코드"/> : </td>
						<td><input type="text" id="routingId" name="routingId" placeholder="<spring:message code = "pop_autoInput" text="자동입력"/>" readonly/></td>
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_routType" text="공정유형"/> : </td>
						<td><input id="routingType" name="routingType" msg="process_type" format="selBox"/></td>
					</tr>
					<tr class="rtlInfo">
					<tr>
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_sequence" text="순서"/> : </td>
						<td><input type="text" id="routingSeq" name="routingSeq" format='currency'/></td>
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_wrkTime" text="작업시간"/> : </td>
						<td><input type="text" id="manHour" name="manHour" format='numeric'/></td>
					</tr>
					<tr style="display:none;">
						<td class="addFile"><i class="fas fa-caret-right"></i><spring:message code = "col_attachment" text="첨부파일"/> : </td>
						<td colspan="3">
							<input name="attachFiles" id="attachFiles" type="file" aria-label="files" format="file" code="routingId", extention=".jpg,.png,.jpeg"/>
							<input type="hidden" id="insertAttach" value = "[]"/>
							<input type="hidden" id="deleteAttach" value = "[]"/>
						</td>
					</tr>
					<tr>
						<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text="설명"/> : </td>
						<td colspan="3"><input type="text" id="description" name="description"/></td>
					</tr>	
				</table>
				<div  style="display : flex;  width:98%; margin:auto;">
					<div style="flex:1; width:48%;">
						<div class="pop_title"><spring:message code = "pop_bomConnect" text="bom 정보"/></div>
						<div id="rtlBomGrid" style="height: 222px; width: 98%; margin: auto; display: flex;"></div>
					</div>
					<div style="flex:1;  width:48%;">
						<div class="pop_title"><spring:message code = "pop_relEqmtInfo" text="사용 설비 정보"/></div>
						<div id="rtlEqmtGrid" style="height: 222px; width: 98%; margin: auto; display: flex;"></div>
					</div>
				</div>
<%-- 				<div>
					<div class="pop_title"><spring:message code = "pop_relToolInfo" text="사용 공구 정보"/></div>
					<div id="rtlToolGrid" style="height: 222px; width: 98%; margin: auto; display: flex;"></div>
				</div> --%>
				<div class="final-btn-area">
					<button class="k-button k-primary final-btn jte-create" type="button"><spring:message code = "pop_save"/></button>
					<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"/></button>
					<button class="k-button k-primary final-btn jte-destroy" type="button"><spring:message code = "btn_delete"/></button>
					<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>
				</div>
			</form>
		</div>
</div>

<div style="display:none;">
	<div id="eqmtToolPop">
		<form id="eqmtToolPop_form">
				<table style="width:100%;" class="BasicTable">
					<colgroup>
						<col style="width:19%;">
						<col style="width:35%;">
						<col style="width:21%;">
						<col style="width:25%;">
					</colgroup>
					<tr>
						<td><i class="fas fa-caret-right"></i>공구명 : </td>
						<td>
							<input type="text" name="toolNm" class="btn-input" readonly/>
							<input type="hidden" name="toolId"/>
							<button id="rtlToolSearchBtn" class="k-button k-primary" type="button" onclick="lfn_toolInfoPop_Open()">조회</button>
						</td>
						<td><i class="fas fa-caret-right"></i>장착위치 : </td>
						<td>
							<input type="text" name="toolLocation"/>
						</td>
					</tr>
					<tr>
						<td><i class="fas fa-caret-right"></i>RPM : </td>
						<td>
							<input type="text" name="toolRpm" format='numeric'/>
						</td>
						<td><i class="fas fa-caret-right"></i>카운트 : </td>
						<td>
							<input type="text" name="toolCount"  format='numeric'/>
						</td>
					</tr>
					<tr style="display:hidden;">
						<td>
							<input type="hidden" name="action"/>
						</td>
					</tr>
				</table>
				<div class="final-btn-area routingMgtForm_eqmtToolPop_final-btn-area">
					<button class="k-button k-primary final-btn jte-create" type="button"><spring:message code = "pop_save"></spring:message></button>	<!-- 저장 -->
					<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"></spring:message></button>	<!-- 저장 -->
					<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button><!-- 취소 -->
				</div>
			</form>
		</div>
</div>

<link href='/resources/mes/css/contents/basMgt/routing/routingMgt/routingMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object

var lfo_routing = {};//Form 내부에서 사용될 Object

var lfo_rtlBom = {}; // bom

var lfo_rtlTool = {}; // 공구

var lfo_rtlEqmt = {}; // 설비

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "";
	
	//3.
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/itemMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getItemList", auth:"", prmt:{}}, 
		create:{url:"", auth:"", openFunc : "", callback : ""}, 
		update:{url:"", auth:"", openFunc : "", callback : ""}, 
		destroy:{url:"", auth:"", callback : ""}
	};
	
	//5.
	lfo_common.model = {
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
			isUse: { type: "bool" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "itemId", template:'<button class="k-button k-primary" type="button" onclick = "lfn_routingGrid_set(\'NEW\',this);" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title : gfn_getMsg("btn_update"), width: 90},
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "150px"},				//부품코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "170px"},				//부품명
		{field: "description", title:gfn_getMsg("col_desc"), width: "300px"}	
	];
	
	//7.
	lfo_common.selectBox = [ 
		{ text: gfn_getMsg("col_itemNm"), value: "itemNm" },			//부품명
		{ text: gfn_getMsg("col_itemCd"), value: "itemId" }				//부품코드
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//라우팅 그리드 로드(우측영역)
this.lfn_routingGrid_set = function(mode, selectedItem) {
	
	lfo_common.gridSelected = {};
	
	lfo_routing = {};//Form 내부에서 사용될 Object
	
	//선택값 저장
	if(mode == 'NEW'){
		lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
	}else{
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.itemId = selectedItem;
		}
	}
	
	//초기화
	$("#routingGrid").html("");
	
	//1.
	lfo_routing.layoutId = "routingGrid";
	
	//2.
	lfo_routing.popId = "jtePopForm";
	
	//3.
	lfo_routing.ctrlUrl = "/cform/basMgt/routing/routingMgt"
	
	//4.
	lfo_routing.crud  = {
		read:{url:"/getRoutingInfo", auth:"", paging : false,prmt : {itemId: lfo_common.gridSelected.itemId}}, 
		create:{url:"/setRoutingInfo", auth:"", openFunc : lfn_jtePop_open, callback : lfn_popSave}, 
		update:{url:"/updateRoutingInfo", auth:"", openFunc : "", callback : lfn_popSave},
		destroy:{type : 'pop', url:"/deleteRoutingInfo", auth:"", callback : lfn_popDelete}
	};
	
	//5.
	lfo_routing.model = {
		id: "routingId",
		fields: {
			routingId: { type: "string" },
			routingSeq: { type: "int" },
			routingType: { type: "string" },
			manHour: { type: "int" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			description: { type: "string" },
			itemId: { type: "string" },
			routing_mgt_std01: { type: "int" },
			routing_mgt_std02: { type: "int" },
			routing_mgt_std03: { type: "int" },
			routing_mgt_std04: { type: "int" },
			routing_mgt_std05: { type: "int" },
			routing_mgt_std_str01: { type: "string" },
			routing_mgt_std_str02: { type: "string" },
			routing_mgt_std_str03: { type: "string" },
			routing_mgt_std_str04: { type: "string" },
			routing_mgt_std_str05: { type: "string" },
			eqmtMgtId: { type: "string" }
		}
	};
	
	//6.
	lfo_routing.columns = [
		{field: "routingId", template:'<button class="k-button k-primary" onclick = "lfn_jtePop_open(\'EDT\',this);">' + "<spring:message code = "pop_view"/>" + '</button>',
			title : gfn_getMsg("btn_update"), width: 90},
		{field: "routingSeq", title:"순서", width: "150px"},				//부품코드
		{field: "routingType", title:gfn_getMsg("col_itemNm"), width: "170px"},				//부품명
		{field: "description", title:gfn_getMsg("col_desc"), width: "300px"}	
	];
	
	//7.
	lfo_routing.selectBox = [ 
		{ text: gfn_getMsg("col_itemNm"), value: "itemNm" },			//부품명
		{ text: gfn_getMsg("col_itemCd"), value: "itemId" }				//부품코드
	];
	
	//공통 그리드 세팅 호출 
	lfo_routing.grid = gfn_grid_set(lfo_routing);
}


//라우팅 등록 팝업 오픈
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
			modal:true, 
			width: "920px", 
			height: "530px",  /** 200416 추가 생성에 따른 팝업 height 조정_LYM 535_JJW 535 -> 550**/
			id:"jtePopForm", 
			title:gfn_getMsg("pop_routRegist"),				//라우팅 등록
			workCd:mode, 
			bdSeq:"",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:["Close"]
	};

	if(mode=='EDT'){
		options.title = gfn_getMsg("pop_routSrh");			//라우팅 수정
 	}
	
	options.callback = function(){
		lfn_jtePopGrd_setForm(mode, selectedItem);
	}
	
	this.gfn_winOpen(options);
}

//라우팅 등록 팝업 세팅
this.lfn_jtePopGrd_setForm = function(mode, selectedItem){
	
	lfo_routing.gridSelected = {};
	
	//bom
	var bomChildItems = [];
	//설비
	var eqmtChildItems = [];
	//공구
	var toolChildItems = [];
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_routing, mode);
		
		//순차 중복을 막기 위해 마지막 요소 값 + 1
		var routingSeq = 1;
		
		//그리드에 표시된 라우팅 목록 조회
		var routingList = lfo_routing.grid.dataSource.data();
		
		//조회된 데이터가 있으면 순서 최대값 +1
		if(routingList.length > 0){
			routingSeq = routingList[routingList.length-1].routingSeq +1; 
		}
		
		//팝업오픈시 순서값 매핑
		$("#"+lfo_routing.popId+"_form [name = routingSeq]").data("kendoNumericTextBox").value(routingSeq);
		
	} else{
		
		lfo_routing.gridSelected = lfo_routing.grid.dataItem($(selectedItem).closest('tr'));
		
		gfn_popform_set(lfo_routing, mode, lfo_routing.gridSelected);
		
		//현재 라우팅에 등록되어 있는 BOM LIST 조회
		$.ajax({
			async:false,
			url : lfo_routing.ctrlUrl + "/getChildRtlList",
			type: "POST",
			data: JSON.stringify({routingId: lfo_routing.gridSelected.routingId}),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				bomChildItems = data.rows.childBomList;
				eqmtChildItems = data.rows.childEqmtList;
				toolChildItems = data.rows.childToolList;
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	//그리드 호출
	lfn_rtlBomGrid_set(bomChildItems);
	
	if(gfn_getCode('produceEqmtCheck').useYn =="Y"){
		$("#rtlEqmtGrid").parent("div").show();
		lfn_rtlEqmtGrid_set(eqmtChildItems);
	}else{
		$("#rtlEqmtGrid").parent("div").hide();
	}
	
/* 	if(gfn_getCode('produceEqmtCheck').useYn =="Y"){
		$("#rtlToolGrid").parent("div").show();
		lfn_rtlToolGrid_set(toolChildItems);
	}else{
		$("#rtlToolGrid").parent("div").hide();
	} */
}

//설비 그리드 세팅
this.lfn_rtlEqmtGrid_set = function(childItems){
	$("#rtlEqmtGrid").html("");
	
	lfo_rtlEqmt = {};
	
	//1.
	lfo_rtlEqmt.layoutId = "rtlEqmtGrid";
	
	//2.
	lfo_rtlEqmt.popId = "";
	
	//4.
	lfo_rtlEqmt.crud  = {
		read:{url : "", auth : "", prmt:{}}, 
		create:{url:"", auth:"", openFunc : lfn_rtlEqmt_open, callback : ""}, 
		update:{url:"", auth:"", openFunc : "", callback : ""}, 
		destroy:{url:"", auth:"", callback : lfn_rtlEqmt_delete}
	};
	
	//5.
	lfo_rtlEqmt.model = {
		id: "eqmtMgtId",
		fields: {
			eqmtMgtId : { type: "string" },
			eqmtMgtGbn : { type: "string" },
			eqmtMgtMtnc : { type: "int" },
			eqmtMgtNm : { type: "string" },
			eqmtMgtPurchase : { type: "date" },
			eqmtMgtVerif : { type: "date" },
			eqmtMgtDesc : { type: "string" },
			eqmtMgtFile : { type: "string" },
			isUse : { type: "bool" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" },
			placeId : { type: "string" },
			placeNm : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" }
		}
	};
	
	//6.
	lfo_rtlEqmt.columns = [
		{selectable : true, width:"50px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '기본' : '에러' #",
			title:"액션", width: "95px"},
		{field: "eqmtMgtNm", title : gfn_getMsg("col_eqmtNm"), width: "150px"}, //설비명
		{field: "defaultYn", title : "기본설비", width:"110px",
			template : function(rows) {
				if(rows.action == 'K' && rows.defaultYn == true){
					return "<a onclick='lfn_rtlEqmt_ynChange(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.action == 'K' && rows.defaultYn == false){
					return "<a onclick='lfn_rtlEqmt_ynChange(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return "";
				}
			}
		}
	];
	
	//order에 포함된 LOT 정보 담아주기(order-child)
	lfo_rtlEqmt.childItems = childItems;
	
	//Object형 그리드 세팅 호출(order-child)
	lfo_rtlEqmt.grid = gfn_objectDatagrid_set(lfo_rtlEqmt);
}

this.lfn_rtlEqmt_open = function(mode){
	gfn_openCustomPop('eqmtMgt',lfn_rtlEqmt_save)
}

//Form내용 입력/저장(eqmt)
this.lfn_rtlEqmt_save = function(savePrmt){	
	//중복키 예외 처리
	var childItems = gfn_objectDataGrid_save({tgObj : lfo_rtlEqmt, prmt : savePrmt, pk : "eqmtMgtId", autokey : false});
	if(!childItems){
		return false;
	}
	//데이터 object에 저장 - 부모요소 저장시 저장된다.
	lfo_rtlEqmt.childItems = childItems;
	
	//그리드 리로드 후 팝업창 닫기
	lfo_rtlEqmt.grid.dataSource.read();
}

//삭제 콜백(eqmt)
this.lfn_rtlEqmt_delete = function(){
	$("#"+ lfo_rtlEqmt.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delPrmt = lfo_rtlEqmt.grid.dataItem($(this).closest('tr'));
			
			//데이터 object에 저장 - 부모요소 저장시 저장(삭제)된다.
			gfn_objectDataGrid_delete({tgObj : lfo_rtlEqmt, prmt : delPrmt, pk : "eqmtMgtId"});
		}
	});
	
	//그리드 리로드
	lfo_rtlEqmt.grid.dataSource.read();
}

//기본설비 변경
this.lfn_rtlEqmt_ynChange = function(selectedItem){
	var modPrmt = lfo_rtlEqmt.grid.dataItem($(selectedItem).closest('tr'));
	modPrmt.routingId = lfo_routing.gridSelected.routingId;
	$.ajax({
		async:false,
		url : lfo_routing.ctrlUrl + "/settingDefaultTool",
		type: "POST",
		data: JSON.stringify(modPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//db는 바뀌지만 화면상에서는 바뀌지 않기 때문에 똑같이 변경해줌.
			if(modPrmt.defaultYn){
				modPrmt.defaultYn = false;
			}else{
				modPrmt.defaultYn = true;
			}
			lfo_rtlEqmt.childItems.forEach(function(item, index){
				if(item.eqmtMgtId == modPrmt.eqmtMgtId){
					lfo_rtlEqmt.childItems[index] = modPrmt;
				}else{
					lfo_rtlEqmt.childItems[index].defaultYn = false;
				}
			});
			
			lfo_rtlEqmt.grid.dataSource.read();
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	}); 
}
//bom 그리드 세팅
this.lfn_rtlBomGrid_set = function(childItems){
	$("#rtlBomGrid").html("");
	
	lfo_rtlBom = {};
	
	//1.
	lfo_rtlBom.layoutId = "rtlBomGrid";
	
	//2.
	lfo_rtlBom.popId = "";
	
	//4.
	lfo_rtlBom.crud  = {
		read:{url : "", auth : "", prmt:{}}, 
		create:{url:"", auth:"", openFunc : lfn_rtlBom_open, callback : ""}, 
		update:{url:"", auth:"", openFunc : "", callback : ""}, 
		destroy:{url:"", auth:"", callback : lfn_rtlBom_delete}
	};
	
	//5.
	lfo_rtlBom.model = {
		id: "bomId",
		fields: {
			bomId : { type: "string" },
			bomTargetNm : { type: "string" },
			bomTargetCnt : { type: "string" },
		}
	};
	
	//6.
	lfo_rtlBom.columns = [
		{selectable : true, width:"50px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '기본' : '에러' #",
			title:"액션", width: "95px"},
		{field: "bomNm", title : "BOM 명", width: "150px"}, 
		{field: "bomTargetCnt", title : "수량", width: "100px"}
	];
	
	
	lfo_rtlBom.childItems = childItems;
	
	//Object형 그리드 세팅 호출
	lfo_rtlBom.grid = gfn_objectDatagrid_set(lfo_rtlBom);
}
//BOM팝업 오픈
this.lfn_rtlBom_open = function(mode){
	
	gfn_openCustomPopTree('bom',lfn_rtlBom_save, {itemId : lfo_common.gridSelected.itemId})
}

//Form내용 입력/저장(bom)
this.lfn_rtlBom_save = function(savePrmt){	
	//중복키 예외 처리
	var childItems = gfn_objectDataGrid_save({tgObj : lfo_rtlBom, prmt : savePrmt, pk : "bomId", autokey : false});
	if(!childItems){
		return false;
	}
	//데이터 object에 저장 - 부모요소 저장시 저장된다.
	lfo_rtlBom.childItems = childItems;
	
	//그리드 리로드 후 팝업창 닫기
	lfo_rtlBom.grid.dataSource.read();
}

//삭제 콜백(bom)
this.lfn_rtlBom_delete = function(){
	$("#"+ lfo_rtlBom.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delPrmt = lfo_rtlBom.grid.dataItem($(this).closest('tr'));
			
			//데이터 object에 저장 - 부모요소 저장시 저장(삭제)된다.
			gfn_objectDataGrid_delete({tgObj : lfo_rtlBom, prmt : delPrmt, pk : "bomId"});
		}
	});
	
	//그리드 리로드
	lfo_rtlBom.grid.dataSource.read();
}

//공구 그리드 세팅
/* 
this.lfn_rtlToolGrid_set = function(childItems){
	$("#rtlToolGrid").html("");
	
	lfo_rtlTool = {};
	
	//1.
	lfo_rtlTool.layoutId = "rtlToolGrid";
	
	//2.
	lfo_rtlTool.popId = "eqmtToolPop";
	
	//4.
	lfo_rtlTool.crud  = {
		read:{url : "", auth : "", prmt:{}}, 
		create:{url:"", auth:"", openFunc : lfn_rtlTool_open, callback : lfn_rtlTool_save}, 
		update:{url:"", auth:"", openFunc : lfn_rtlTool_open, callback : lfn_rtlTool_save}, 
		destroy:{url:"", auth:"", callback : lfn_rtlTool_delete}
	};
	
	//5.
	lfo_rtlTool.model = {
		id: "toolId",
		fields: {
			action : { type: "string" }, 
			routingId : { type: "string" },
			toolRpm : { type: "float" },
			toolLocation : { type: "string" },
			toolCount : { type: "float" },
			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolType : { type: "string" },
			toolPrice : { type: "string" },
			toolLimit : { type: "string" },
			toolDesc : { type: "string" },
			toolStd01 : { type: "string" },
			toolStd02 : { type: "string" },
			toolStd03 : { type: "string" },
			toolStd04 : { type: "string" },
			toolStd05 : { type: "string" },
			toolStdStr01 : { type: "string" },
			toolStdStr02 : { type: "string" },
			toolStdStr03 : { type: "string" },
			toolStdStr04 : { type: "string" },
			toolStdStr05 : { type: "string" }
		}
	};
	
	//6.
	lfo_rtlTool.columns = [
		{selectable : true, width:"50px"},
		{field: "toolId", template:'<button class="k-button k-primary" type="button" onclick = "lfn_rtlTool_open(\'EDT\',this);" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>', 
			title : "수정", width: "80px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '기본' : '에러' #",
			title:"액션", width: "95px"},
		{field: "toolNm", title : "공구명", width: "150px"},
		{field: "toolLocation", title : "장착위치", width: "80px"},
		{field: "toolRpm", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : "RPM", width: "80px"},
		{field: "toolCount", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : "카운트", width: "80px"}
	];
	
	lfo_rtlTool.childItems = childItems;
	
	lfo_rtlTool.grid = gfn_objectDatagrid_set(lfo_rtlTool);
}


//팝업오픈(tool)
this.lfn_rtlTool_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "620px", 
		height: "180px",
		id : lfo_rtlTool.popId, 
		resizable : true,
		title : "라우팅 공구 관리",
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:["Minimize", "Maximize", "Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_rtlTool_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);
}

//팝업내용 세팅(tool)
this.lfn_rtlTool_set = function(mode, selectedItem){
	lfo_rtlTool.gridSelected = {};
	if(mode=='NEW'){
		selectedItem = {};
		gfn_popform_set(lfo_rtlTool, mode, selectedItem, selectedItem.action);
		
		//부품등록 버튼 활성화
		$("#toolInfoBtn").show();
		
	}else if(mode == 'EDT'){
		//수정시 비활성화
		$("#rtlToolSearchBtn").hide();
		$("#" + lfo_rtlTool.popId + "_form [name=toolLocation]").attr("readonly",true);
		
		//선택값 담아두기
		lfo_rtlTool.gridSelected = lfo_rtlTool.grid.dataItem($(selectedItem).closest("tr"));
		
		//그리드 세팅
		gfn_popform_set(lfo_rtlTool, mode, lfo_rtlTool.gridSelected, lfo_rtlTool.gridSelected.action);
	}
}

//Form내용 입력/저장(tool)
this.lfn_rtlTool_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_rtlTool.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		//입력폼 serialize 
		var savePrmt = gfn_serializeObject(lfo_rtlTool.popId+"_form");
		
		//중복키 예외 처리
		var childItems = gfn_objectDataGrid_save({tgObj : lfo_rtlTool, prmt : savePrmt, pk : ["toolId", "toolLocation"], autokey : false});
		
		if(!childItems){
			return false;
		}
			
		//데이터 object에 저장 - 부모요소 저장시 저장된다.
		lfo_rtlTool.childItems = childItems;
		
		//그리드 리로드 후 팝업창 닫기
		lfo_rtlTool.grid.dataSource.read();
		gfn_closePop(lfo_rtlTool.popId);
	}
}

//삭제 콜백(tool)
this.lfn_rtlTool_delete = function(){
	
	$("#"+ lfo_rtlTool.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delPrmt = lfo_rtlTool.grid.dataItem($(this).closest('tr'));
			
			//데이터 object에 저장 - 부모요소 저장시 저장(삭제)된다.
			gfn_objectDataGrid_delete({tgObj : lfo_rtlTool, prmt : delPrmt, pk : ["toolId", "toolLocation"]});
		}
	});
	
	//그리드 리로드
	lfo_rtlTool.grid.dataSource.read();
}

//pop - 공구조회 팝업 오픈
this.lfn_toolInfoPop_Open = function(){
	gfn_openCustomPop('tool',lfn_toolInfoPop_callBack);
} */

//pop - 공구조회 팝업 콜백
this.lfn_toolInfoPop_callBack = function(rtnObj){
	$("#"+lfo_rtlTool.popId+"_form [name=toolId]").val(rtnObj["toolId"]);
	$("#"+lfo_rtlTool.popId+"_form [name=toolNm]").val(rtnObj["toolNm"]);
}

//라우팅 저장팝업
this.lfn_popSave = function(mode){
	
	//입력폼 serialize 
	var savePrmt = gfn_serializeObject(lfo_routing.popId + "_form");
	savePrmt.itemId = lfo_common.gridSelected.itemId;
	
	savePrmt.childEqmtList = lfo_rtlEqmt.childItems;
	savePrmt.childToolList = lfo_rtlTool.childItems;
	savePrmt.childBomList = lfo_rtlBom.childItems;
	
	$.ajax({
		async:false,
		url : lfo_routing.ctrlUrl + lfo_routing.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			gfn_closePop(lfo_routing.popId);
			lfn_routingGrid_set('EDT', lfo_common.gridSelected);
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	}); 
}

//라우팅 삭제팝업
this.lfn_popDelete = function(){
	var deletePrmt = gfn_serializeObject(lfo_routing.popId + "_form");
	
	kendo.confirm(gfn_getMsg("pop_routDelConfirm")).done(function(){
		$.ajax({
			async:false,
			url : lfo_routing.ctrlUrl + lfo_routing.crud.destroy.url,
			type: "POST",
			data: JSON.stringify(deletePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				gfn_closePop(lfo_routing.popId);
				lfn_routingGrid_set('EDT', lfo_common.gridSelected);
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 삭제되었습니다.")});			//성공
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	});
}
</script>