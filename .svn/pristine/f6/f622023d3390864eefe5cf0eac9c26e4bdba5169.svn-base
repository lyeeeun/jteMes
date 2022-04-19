<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="facilToolMgtForm" style="width: 100%;">
	<div id="jteMasterTree" class="facilToolMgtForm left-contents jteMasterTree"></div><input type="hidden" id = "jteMasterTree_hidSelected" value="">
	<div class="facilToolMgtForm middle-contents"><span><i class="fas fa-caret-square-right fa-3x"></i></span></div>
	<div id="jteSubGrid" class="facilToolMgtForm right-contents jteSubGrid"></div>
</div>

<!-- <div id="grid-content"  style="width:100%;">
	<div class="left-content-box" style="display:inline-block; width:20%; height:100%; box-shadow: 0px 0px 4px 2px rgba(0, 0, 0, 0.13);  background:#f8f8f8;"> 
		<div id="jteMasterTree" style="height:100%;"></div>
		<input type="hidden" id = "jteMasterTree_hidSelected" value="">
	</div>
<div class="center-content-box">
	<span><i class="fas fa-caret-square-right fa-3x"></i></span>
</div>
	<div id="jteSubGrid" style="display:inline-block; width:60%; height:100%;"></div> 
</div> --> <!-- grid-content 원본 -->

<div style="display:none;">
	<div id="jtePopForm" class="jtePopForm facilToolMgtForm_jtePopForm">  <!-- style="height:100%; -->
		<div id="jtePopForm_grid" class="jtePopForm_grid facilToolMgtForm_jtePopForm_grid"></div>   <!-- style="height:430px;" -->
	</div>
</div>

<div style="display:none;">
	<div id="jteToolPosForm" class="jteToolPosForm facilToolMgtForm_jteToolPosForm">  <!-- style="height:100%;" -->
		<div id="jteToolPosForm_grid" class="jteToolPosForm_grid facilToolMgtForm_jteToolPosForm_grid"></div> 
		<div class="final-btn-area">
			<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"></spring:message></button>											<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteToolPosForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/facilMgt/facilToolMgt/facilToolMgtForm_lym.css' rel="stylesheet" type="text/css"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/facilMgt/facilToolMgt/facilToolMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200507 LYM  -->

<script>
var lfo_tree = {};

var lfo_common = {};//공통 Object

var lfo_popGrd = {};//팝업 그리드에서 사용

var lfo_toolPos = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: "/cform/basMgt/operMgt/rlehoMgt/getPlaceTree",
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

	lfo_tree.mtTree = $("#jteMasterTree").data("kendoTreeView");
	lfo_tree.mtTreeExpand =[];
	
	//로딩시간으로 인한 0.5초뒤 로딩
	setTimeout(function() {
		lfo_tree.mtTree.expand(".k-item");
	}, 500);
	
	
	//더블클릭 이벤트
	$("#jteMasterTree").on("dblclick",".k-in", function(e){
		//선택한 값 매핑
		lfo_tree.treeSelected = lfo_tree.mtTree.dataItem($(e.target).closest("li"));
		
		//lfo_common.grid.dataSource.read();
		$("#jteSubGrid").html("");
		lfn_jteSubGrd_setGrd();
		
	});
};
//트리 오픈 순서 기억
this.lfn_jteMtTree_expandPush = function(e){
	var item = lfo_tree.mtTree.dataItem(e.node);
	lfo_tree.mtTreeExpand.push(item.menuId);
}

//트리 클로즈시 해당부분 제거
this.lfn_jteMtTree_expandPop = function(e){
	var item = lfo_tree.mtTree.dataItem(e.node);
	lfo_tree.mtTreeExpand.pop(item.menuId);
}

//main - grid 생성 -- 위치에 따른 설비리스트
this.lfn_jteSubGrd_setGrd = function(){
	
	lfo_common = {};//Form 내부에서 사용될 Object 
	/* 
		1. gridObject.layoutId = gridId
		2. gridObject.popId = popId
		3. gridObject.ctrlUrl = 조회 url
		4. gridObject.crud  = {
			read:{url:"",auth:"", prmt:{}}, 
			create:{url:"",auth:"",openFunc:function, callback:function}, 
			update:{url:"",auth:"",openFunc:function, callback:function}, 
			delete:{url:"",auth:"", callback:function}}
		5. gridObject.model = fieldType
		6. gridObject.columns = foeldColumns
		7. gridObject.selectBox = SelectBox 매핑 값 
	*/
	
	//1.
	lfo_common.layoutId = "jteSubGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";

	//3.
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/facilMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/getEqmtMgtList", auth:"", prmt:{placeId : lfo_tree.treeSelected.placeId}}, 
// 		create:{url:"/setToolMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
 		update:{url:"/getEqmtMgtList", auth:"", openFunc : lfn_jtePop_open, callback:lfn_jtePop_open}, 
// 		destroy:{url:"/setToolMgtDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
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
	lfo_common.columns = [
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtNm"), width: "140px"},												//설비명
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: "160px"},											//설비개별코드
		{field: "eqmtMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(eqmtMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(eqmtMgtGbn).cdId , gfn_getCode(eqmtMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_eqmtDiv"), width: "130px;"},																//설비구분
		{field: "eqmtMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "110px"},			//입고일
		{field: "eqmtMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: "110px"},			//검증기간
		{field: "eqmtMgtMtnc", format: "{0:n0}", title:gfn_getMsg("col_mtnc"), width: "100px"},								//정비주기
		{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: "140px"},												//위치명
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "140px"},													//업체명
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc"), width: "280px"}												//설명
	];
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_eqmtNm"), value: "eqmtMgt.eqmt_mgt_nm" },
		{ text: gfn_getMsg("col_eqmtIndivCd"), value: "eqmtMgt.eqmt_mgt_id" },
		{ text: gfn_getMsg("col_compNm"), value: "comp.comp_nm" }
	];

	//공통 그리드 세팅 호출 compId
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}

//더블클릭 콜백(팝업) -- 선택한 설비에 장착된 공구 팝업
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px", 
		height: "300px", // 200519 JJW 설비공구관리 오른쪽 그리드 더블클릭 430px -> 300px
		id : lfo_common.popId, 
		title:gfn_getMsg("pop_eqmtToolMount"),			//설비 장착 공구
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.eqmtMgtId = selectedItem;
		}else if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
		}
		
		//그리드 조회
		lfn_jtePopGrd_setGrd();
	};
	this.gfn_winOpen(options);
}

//팝업내부 그리드 - 선택한 설비에 장착된 공구 조회
this.lfn_jtePopGrd_setGrd = function(){
	
	lfo_popGrd = {};
	/* 
	1. gridObject.layoutId = gridId
	2. gridObject.popId = popId
	3. gridObject.ctrlUrl = 조회 url
	4. gridObject.crud  = {
		read:{url:"",auth:"", prmt:{}}, 
		create:{url:"",auth:"",openFunc:function, callback:function}, 
		update:{url:"",auth:"",openFunc:function, callback:function}, 
		delete:{url:"",auth:"", callback:function}}
	5. gridObject.model = fieldType
	6. gridObject.columns = foeldColumns
	7. gridObject.selectBox = SelectBox 매핑 값 
*/
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	lfo_popGrd.popId = "jteToolPosForm";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/facilMgt/facilToolMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getEqmtToolList", auth:"", prmt:{eqmtMgtId: lfo_common.gridSelected.eqmtMgtId}}, 
		create:{url:"/setEqmtToolSave", auth:"", openFunc : lfn_jteToolPos_popOpen, callback : lfn_jtePopGrd_save},
		//update:{url:"/setEqmtToolSave", auth:"", openFunc : lfn_toolPos_save, callback : lfn_toolPos_save},
		destroy:{url:"/setEqmtToolDelete", auth:"", callback : lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "eqipId",
		fields: {
			eqmtMgtId: { type: "string" },
			eqipId: { type: "string" },
			eqipNm: { type: "string" },
			eqipPosition: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" },
			updatorId: { type: "string" },
			updatedAt: { type: "date" },
			toolMgtId: { type: "string" },
			toolMgtPurchase: { type: "string" },
			toolMgtState: { type: "string" },
			toolMgtLimit: { type: "int" },
			toolMgtUse: { type: "int" },
			toolMgtVerif: { type: "date" },
			toolMgtGbn: { type: "string" },
			toolMgtDesc: { type: "string" },
			compId: { type: "string" },
			compNm: { type: "string" },
			toolId: { type: "string" },
			toolNm: { type: "string" },
			toolRpm: { type: "int" },
			toolLocation: { type: "string" },
			toolCount: { type: "int" },
			itemId: { type: "string" },
			itemNm: { type: "string" },
			routingId: { type: "string" },
			routingType: { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "eqipPosition", title : gfn_getMsg("col_mountPosition"), width: 150},										//장착위치
		{field: "toolNm", title : gfn_getMsg("col_toolNm"), width: 200},													//공구명
		{field: "toolMgtId", title : gfn_getMsg("col_toolIndivCd"), width: 200},											//공구개별코드
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #",
				title : gfn_getMsg("col_toolDiv"), width: 150},																//공구구분(공구사용처)
		//{field: "eqipNm", title : "장착명", width: 120},
		//{field: "eqipId", title : "장착코드", width: 150},
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #",
				title : gfn_getMsg("col_toolStatus"), width: 150},															//공구상태
		{field: "toolMgtLimit", format:"{0:n0}", title : gfn_getMsg("col_useLimit"), width: 110},							//사용한도
		{field: "toolMgtUse", format:"{0:n0}", title : gfn_getMsg("col_toolUseQuan"), width: 110},							//공구사용량
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: 120},			//입고일
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_verifyPeriod"), width: 120},				//검증기간
		{field: "compNm", title : gfn_getMsg("col_compNm"), width: 120},													//업체명
		{field: "toolMgtDesc", title : gfn_getMsg("col_desc"), width: 300}													//설명
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_toolNm"), value: "toolInfo.tool_nm" },
		{ text: gfn_getMsg("col_toolIndivCd"), value: "rtl.tool_mgt_id" },
		{ text: gfn_getMsg("col_compNm"), value: "comp.comp_nm" },
		{ text: gfn_getMsg("col_desc"), value: "toolMgt.tool_mgt_desc" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

//삭제 콜백
this.lfn_jtePopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_popGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_popGrd.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//더블클릭 콜백(팝업) -- 장착 가능한 공구 조회 팝업
this.lfn_jteToolPos_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "650px", 
		height: "345px", //200507 그리드 더블 클릭→설비 장착 공구 팝업의 추가 버튼 클릭 시의'장착 가능 공구 조회' 팝업 크기 변경 460->515px_LYM 200519 JJW 330px 200811 youmi 330->345px
		id : lfo_popGrd.popId, 
		title:gfn_getMsg("pop_possToolSrh"),			//장착 가능 공구 조회
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfo_popGrd.gridSelected = {
			eqmtMgtId : lfo_common.gridSelected.eqmtMgtId
		};
		
		//여기부터 공통팝업 띄우기
		$("#jteToolPosForm_grid").html();
		lfn_jteToolPos_setGrd();
		
	};
	this.gfn_winOpen(options);
	
}


//그리드 - 장착 가능한 공구 조회 그리드 
this.lfn_jteToolPos_setGrd = function(){
	
	lfo_toolPos = {};
	/* 
	1. gridObject.layoutId = gridId
	2. gridObject.popId = popId
	3. gridObject.ctrlUrl = 조회 url
	4. gridObject.crud  = {
		read:{url:"",auth:"", prmt:{}}, 
		create:{url:"",auth:"",openFunc:function, callback:function}, 
		update:{url:"",auth:"",openFunc:function, callback:function}, 
		delete:{url:"",auth:"", callback:function}}
	5. gridObject.model = fieldType
	6. gridObject.columns = foeldColumns
	7. gridObject.selectBox = SelectBox 매핑 값 
*/
	
	//1.
	lfo_toolPos.layoutId = "jteToolPosForm_grid";
	
	//2.
	//lfo_toolPos.popId = "jteToolPosForm";
	
	//3.
	lfo_toolPos.ctrlUrl = "/cform/facilMgt/facilToolMgt"
	       
	//4.
	lfo_toolPos.crud  = {
		read:{url:"/getEqmtToolPosList", auth:"", prmt:{eqmtMgtId : lfo_common.gridSelected.eqmtMgtId},
			dynamicPrmt:{itemId : lfo_toolPos.layoutId+'_hidItemBox', routingId : lfo_toolPos.layoutId+'_hidRoutingBox'}, 
			search : false}, 
		//create:{url:"/setEqmtToolSave", auth:"", openFunc : lfn_jtePopGrd_popOpe2n, callback : lfn_jtePopGrd_save},
		//update:{url:"/setEqmtToolSave", auth:"", openFunc : lfn_toolPos_save, callback : ""}
		//destroy:{url:"/setEqmtToolDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_toolPos.model = {
		id: "toolMgtId",
		fields: {
			toolRpm: { type: "int" },
			toolLocation: { type: "string" },
			toolCount: { type: "int" },
			routingId: { type: "string" },
			routingType: { type: "string" },
			toolMgtId: { type: "string" },
			toolMgtPurchase: { type: "string" },
			toolMgtState: { type: "string" },
			toolMgtLimit: { type: "int" },
			toolMgtUse: { type: "int" },
			toolMgtVerif: { type: "date" },
			toolMgtGbn: { type: "string" },
			toolMgtDesc: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" },
			updatorId: { type: "string" },
			updatedAt: { type: "date" },
			compId: { type: "string" },
			compNm: { type: "string" },
			toolId: { type: "string" },
			toolNm: { type: "string" }
		}
	};
	
	//6.
	lfo_toolPos.columns = [
		{selectable : true, width:"50px"},
		{field: "toolLocation", title : gfn_getMsg("col_mountPosition"), width: 130},										//공구위치
		{field: "toolNm", title : gfn_getMsg("col_toolNm"), width: 200},													//공구명
		{field: "toolMgtId", title : gfn_getMsg("col_toolIndivCd"), width: 200},											//공구개별코드
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #",
			title : gfn_getMsg("col_toolDiv"), width: 150},																	//공구구분
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #",
				title : gfn_getMsg("col_toolStatus"), width: 150},															//공구상태
		{field: "toolMgtLimit", format:"{0:n0}", title : gfn_getMsg("col_useLimit"), width: 110},							//사용한도
		{field: "toolMgtUse", format:"{0:n0}", title : gfn_getMsg("col_toolUseQuan"), width: 110},							//공구사용량
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_purchaseDate"), width: 120},			//입고일
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title : gfn_getMsg("col_verifyPeriod"), width: 120},				//검증기간
		{field: "toolRpm", format:"{0:n0}", title : gfn_getMsg("col_toolRpm"), width: 100},									//RPM
		{field: "toolCount", format:"{0:n0}", title : gfn_getMsg("col_toolCount"), width: 100},								//카운트
		{field: "compNm", title : gfn_getMsg("col_compNm"), width: 120},													//업체명
		{field: "toolMgtDesc", title : gfn_getMsg("col_desc"), width: 300}													//설명
	];
	
	//7.
	lfo_toolPos.selectBox = [
		{ text: gfn_getMsg("col_toolNm"), value: "toolInfo.tool_nm" },				//공구명
		{ text: gfn_getMsg("col_toolIndivCd"), value: "rtl.tool_mgt_id" },			//공구개별코드
		{ text: gfn_getMsg("col_compNm"), value: "comp.comp_nm" },					//업체명
		{ text: gfn_getMsg("col_desc"), value: "toolMgt.tool_mgt_desc" }			//설명
	];
	
	//커스텀 타이틀- 부품별조회
	lfo_toolPos.customTitle = {
			html : '<span class="jte-search-aria"><label>'+"부품"+' : </label>'
			+ '<input id=\"'+lfo_toolPos.layoutId+'_itemBox\" style="width:200px;"/>'			//검색(UI)
			+ '<input id=\"'+lfo_toolPos.layoutId+'_hidItemBox\" type=\"hidden\">'
			+ '<label>'+"공정"+' : </label>'
			+ '<input id=\"'+lfo_toolPos.layoutId+'_routingBox\" style="width:200px;"/>'
			+ '<input id=\"'+lfo_toolPos.layoutId+'_hidRoutingBox\" type=\"hidden\"></span>',
			callback : lfn_customTltle_set
		}
		
	//공통 그리드 세팅 호출 
	lfo_toolPos.grid = gfn_grid_set(lfo_toolPos);
	
	$("#"+lfo_popGrd.popId+" .jte-update").on("click",function(){
		lfn_toolPos_save();
	});
}

//커스텀타이틀 세팅 - 부품별 조회 
this.lfn_customTltle_set = function(){
	//부품별 조회 기본세팅
	var itemList = [];
	//해당 설비에서 제조가능한 아이템조회 후 변수에 추가
	$.ajax({
		async:false,
		url : lfo_toolPos.ctrlUrl + "/getEqmtToolItemList",
		type: "POST",
		data: JSON.stringify({eqmtMgtId : lfo_popGrd.gridSelected.eqmtMgtId}),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				if(data.rows.length > 0){
					for(i in data.rows){
						//드롭다운 세팅
						itemList.push({text:data.rows[i].itemNm, value:data.rows[i].itemId})
					}
				}else{
					//데이터가 없는 경우
					itemList = [{text:"지정 부품 없음", value:' '}];
				}
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	
	//selectBox 세팅
	$("#"+lfo_toolPos.layoutId+'_itemBox').kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: itemList,
		index: 0,
		change: function(e){
			$("#"+lfo_toolPos.layoutId+'_hidItemBox').val(this.value());
			lfn_customTltle_sub();
			
		}
	});
	$("#"+lfo_toolPos.layoutId+'_hidItemBox').val($("#"+lfo_toolPos.layoutId+'_itemBox').val());
	lfn_customTltle_sub();
}

//커스텀타이틀 세팅 - 라우팅별 조회 
this.lfn_customTltle_sub = function(){
	//부품별 조회 기본세팅
	var itemList = [];
	
	//초기화
	$("#"+lfo_toolPos.layoutId+'_hidRoutingBox').val("")
			
	//해당 설비에서 제조가능한 아이템조회 후 변수에 추가
	$.ajax({
		async:false,
		url : lfo_toolPos.ctrlUrl + "/getEqmtToolRoutingList",
		type: "POST",
		data: JSON.stringify({eqmtMgtId : lfo_popGrd.gridSelected.eqmtMgtId, itemId : $("#"+lfo_toolPos.layoutId+'_hidItemBox').val()}),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				if(data.rows.length > 0){
					for(i in data.rows){
						//라우팅 - 공정 기초코드에서 가져옴 
						var routingType = gfn_isNull(gfn_getCode(data.rows[i].routingType))== true ? '기초코드 없음' : 
							gfn_getMsg('bc_'+ gfn_getCode(data.rows[i].routingType).cdId , gfn_getCode(data.rows[i].routingType).cdNm);
						
						//드롭다운 세팅
						itemList.push({text : routingType, value:data.rows[i].routingId});
					}
				}else{
					//데이터가 없는 경우 
					itemList = [{text:"지정 라우팅 없음", value:' '}];
				}
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	//selectBox 세팅
	$("#"+lfo_toolPos.layoutId+'_routingBox').kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: itemList,
		index: 0,
		change: function(e){
			//Search 호출
			lfn_customTltle_search();
		}
	});
	lfn_customTltle_search();
}

//커스텀 타이틀 SELECT
this.lfn_customTltle_search = function(){
	
	$("#"+lfo_toolPos.layoutId+'_hidRoutingBox').val($("#"+lfo_toolPos.layoutId+'_routingBox').val());
	
	//그리드가 로드된 경우에만 리로드
	if(!gfn_isEmpty(lfo_toolPos.grid)){
		lfo_toolPos.grid.dataSource.read();
	}
}

//설비에 장착가능한 공구 저장
this.lfn_toolPos_save = function(mode,selectedItem){
	var savePrmt = [];
	
	$("#"+ lfo_toolPos.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var item = lfo_toolPos.grid.dataItem($(this).closest('tr'));
			item.eqipNm = item.itemNm;
			item.eqipPosition = item.toolLocation;
			item.eqmtMgtId = lfo_popGrd.gridSelected.eqmtMgtId;
			savePrmt.push(item);
		}
	});
	$.ajax({
		async:false,
		url : lfo_toolPos.ctrlUrl + "/setEqmtToolSave",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//마스터 그리드 리로드
				lfo_common.grid.dataSource.read();
				//이전 팝업화면 리로드
				lfo_popGrd.grid.dataSource.read();
				//현재팝업 종료
				gfn_closePop(lfo_popGrd.popId);
				
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
</script>