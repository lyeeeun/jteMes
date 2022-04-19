<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div id="grid-content" class="performEquipmentForm-gird"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="packagePlanRegistry">
		<div id="packageInfo_grid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="pkgPlanInfo">
		<form id="pkgPlanInfo_form" class="rlesPlanMgtForm">
		<!-- 포장 작업 정보 -->
			<div class="pop_title"><spring:message code = "pop_pkgPlanInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
				<colgroup>
					<col class="col-left-title">
					<col class="col-left-content">
					<col class="col-right-title">
					<col class="col-right-content">
				</colgroup>
				<tr>
				<!-- 품목명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td>
						<input type="text" id="itemNm" class="left-input" name="itemNm" readonly/>
						<input type="hidden" id="itemId" name="itemId"/>
						<input type="hidden" id="pkgId" name="pkgId" />
					</td>
				<!-- LoT코드 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_lotCd"></spring:message> : </td>
					<td><input type="text" id="itemMgtId" class="right-input" name="itemMgtId" readonly/></td>
				</tr>
				<tr>
				<!-- 부품무게 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemWeight"></spring:message> : </td>
					<td colspan="3"><input type="text" id="itemWeight" class="center-input" name="itemWeight" format="numeric" readonly/></td>
				</tr>
				<tr>
				<!-- 자재입고량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlReceiveQty"></spring:message>: </td>
					<td><input type="text" id="mtrlReceiveQty" class="left-input" name="mtrlReceiveQty" format="numeric"/></td>
				<!-- 자재잔량 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_mtrlScrap"></spring:message> : </td>
					<td><input type="text" id="mtrlMgtScrap" class="right-input" name="mtrlMgtScrap" format="numeric" readonly/></td>
				</tr>
				<tr>
				<!-- 재고량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_stockQty"></spring:message>: </td>
					<td><input type="text" id="itemStock" class="left-input" name="itemStock" format="numeric" readonly/></td>
				<!-- 예상 포장 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_predPackQty"></spring:message> : </td>
					<td><input type="text" id="pkgEstimated" class="right-input" name="pkgEstimated" format="numeric" readonly/></td>
				</tr>
				<tr>
				<!-- 포장 계획 수량 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_packPlanQuan"></spring:message> : </td>
					<td colspan="3"><input type="text" id="pkgPlanQty" class="center-input" name="pkgPlanQty" format="numeric"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="description" class="center-input" name="description"/></td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('pkgPlanInfo');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/ship/rlesMgt/rlesMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/ship/rlesPlanMgt/rlesPlanMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200507 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_jteSgGrd_setGrd();
};

this.lfn_jteSgGrd_setGrd = function(){
	
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
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "packagePlanRegistry";
	
	//3.
	lfo_common.ctrlUrl = "/form/ship/rlesMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/getPackageList", auth:"", prmt:{}}
	};
	
	//5.
	lfo_common.model = {
		id: "lotSeq",
		fields: {
			itemId : { type: "string" },
			itemMgtId : { type: "string" },
			itemMgtType : { type: "string" },
			lotQty : { type: "int" },
			itemStock : { type: "int" },
			itemPackageStock : { type: "int" },
			itemNm : { type: "string" },
			orderId : { type: "string" },
			orderNm : { type: "string" }
		}
	};
	 
	//6.
	lfo_common.columns = [
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "100px"},					//수주명
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "150px"},						//품목명
		{field: "itemMgtId", title:gfn_getMsg("col_lotCd"), width: "120px"},					//LoT코드
		{field: "itemMgtType", title:gfn_getMsg("col_lotDiv"), width: "100px"},					//LoT구분
		{field: "lotQty",  title:gfn_getMsg("col_lotQty"), width: "100px"},						//주문수량
		{field: "itemStock",  title:gfn_getMsg("col_stockQty"), width: "100px"},				//재고량
		{field: "itemPackageStock",  title:gfn_getMsg("col_packQuan"), width: "100px"},			//포장수량
		{field: "packageWork", title: gfn_getMsg("col_packPlan"), width:"100px",				//포장계획
			template : function(rows) {
				return '<button class="k-button k-primary" type="button" onclick="lfn_packagePlan(this)">포장 계획 수립</button>';
			}
		},
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "itemInfo.item_nm" },			//품목명
		{ text: gfn_getMsg("col_lotCd"), value: "itemMgtId" },					//LoT코드
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_packagePlan = function(rows) {
	var dataItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr"));
	lfn_jtePopGrd_popOpen("EDT", dataItem);
}

this.lfn_jtePopGrd_popOpen = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "1250px", 
		height: "470px", 
		id:lfo_common.popId, 
		title:gfn_getMsg("pop_pkgPlanInfo"),			//포장작업
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePopGrd_setGrd(selectedItem);
		$('#packageInfo_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}

this.lfn_jtePopGrd_setGrd = function(selectedItem){
	lfo_popGrd = {};
	
	lfo_popGrd.selected = {};
	lfo_popGrd.selected = selectedItem;
	
	//체크리스트 저장 변수
	lfo_popGrd.checked = new Array();
	
	//1.
	lfo_popGrd.layoutId = "packageInfo_grid";
	
	//2.
	lfo_popGrd.popId = "pkgPlanInfo";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/ship/rlesPlanMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getPackagePlanList", auth:"", prmt:{itemId : selectedItem.itemId, itemMgtId: selectedItem.itemMgtId}, search:false},
		create:{url:"/setPackagePlanList", auth:"", openFunc:lfn_pkgPlanPop_open, callback:lfn_pkgPlanPop_save},
		update:{url:"/updatePackagePlan", auth:"", callback:lfn_planAddPop_save},
		destroy:{url:"/deletePackagePlan", auth:"", callback:lfn_pkgPlanPop_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "pkgId",
		fields: {
			pkgId : { type: "string" },
			lotId : { type: "string" },
			itemNm : { type: "string" },
			itemWeight : { type: "float" },
			mtrlMgtScrap : { type: "float" },
			mtrlReceiveQty : { type: "float" },
			pkgPlanQty : { type: "int" },
			pkgState : { type: "string" },
			pkgDesc : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "pkgOption", template:'<button class="k-button k-primary" type="button" onclick = "lfn_pkgPlanPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title:gfn_getMsg("btn_update"), width: "120px;"}, 										//수정
		{field: "pkgId", title:gfn_getMsg("col_packPlanCd"), width: "170px;"},						//포장계획코드
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},							//Lot ID
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "120px;"},							//품목명
		{field: "itemWeight", title:gfn_getMsg("col_weight"), width: "120px;"},						//품목 무게
		{field: "mtrlMgtScrap", title:gfn_getMsg("col_mtrlScrap"), width: "120px;"},				//자재 잔량
		{field: "mtrlReceiveQty", title:gfn_getMsg("col_mtrlReceiveQty"), width: "120px;"},			//자재 입고량
		{field: "pkgPlanQty", title:gfn_getMsg("col_packPlanQuan"), width: "120px;"},				//포장 계획 수량
		{field: "pkgState", template: "# var item = gfn_isNull(gfn_getCode(pkgState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(pkgState).cdId , gfn_getCode(pkgState).cdNm) # #= item #",
			title:gfn_getMsg("col_packingStatus"), width: "120px;"},								//포장 진행 상태
		{field: "pkgDesc", title:gfn_getMsg("col_desc"), width: "250px;"}							//비고
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

this.lfn_pkgPlanPop_open = function(mode, selectedItem){
 	var options = {
		modal:true, 
		width: "750px",
		height: "410px",  //200507 출고 관리 그리드의 포장 작업 버튼 클릭 → 추가 버튼 클릭 시의 팝업창 height 변경_550->360px LYM 200511 JJW 550-> 410px
		id : "pkgPlanInfo", 
		title:gfn_getMsg("pop_packWrkRegist"),			//포장 작업 등록
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
 	$.ajax({
		async:false,
		url : "/form/ship/rlesPlanMgt/getPackageAgg",
		type: "POST",
		data: JSON.stringify({lotId: lfo_popGrd.selected.itemMgtId}),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_popGrd.selected.mtrlMgtScrap = data.rows.mtrlMgtScrap;
			lfo_popGrd.selected.itemWeight = data.rows.itemWeight;
			lfo_popGrd.selected.itemStock = data.rows.itemStock;
			
			if(mode == 'NEW') {
				lfo_popGrd.selected.mtrlReceiveQty = 0;
				lfo_popGrd.selected.pkgPlanQty = 0;
				lfo_popGrd.selected.description = "";
				lfo_popGrd.selected.pkgId = "";
			} else {
				lfo_popGrd.selected.mtrlReceiveQty = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr")).mtrlReceiveQty;
				lfo_popGrd.selected.pkgPlanQty = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr")).pkgPlanQty;
				lfo_popGrd.selected.description = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr")).description;
				lfo_popGrd.selected.pkgId = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr")).pkgId;
			}
		},error: function(ex){
			gfn_loading(false);
		}
	});
 	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		gfn_popform_set(lfo_popGrd, mode, lfo_popGrd.selected);
		
		$("#mtrlReceiveQty").data("kendoNumericTextBox").bind("change", function() {
			$("#pkgEstimated").data("kendoNumericTextBox").value((this.value() - $('#mtrlMgtScrap').val())/$('#itemWeight').val());
		});
		$("#mtrlReceiveQty").data("kendoNumericTextBox").trigger('change');
	};
	this.gfn_winOpen(options);
}

this.lfn_pkgPlanPop_save = function(mode){
	
	var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
	
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//마스터 그리드 리로드
			/* lfo_common.grid.dataSource.read(); */
			lfo_popGrd.grid.dataSource.read();
			
			//팝업종료
			gfn_closePop(lfo_popGrd.popId);
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

this.lfn_planAddPop_save = function(mode){
	
	var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
	savePrmt.lotId = lfo_popGrd.selected.lotId;
	savePrmt.lotSeq = lfo_popGrd.selected.lotSeq;
	
	savePrmt.bundleInsertList = lfo_popGrd.bundleInsertList;
	savePrmt.bundleUpdateList = lfo_popGrd.bundleUpdateList;
	savePrmt.bundleDeleteList = lfo_popGrd.bundleDeleteList;
	
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//마스터 그리드 리로드
			lfo_common.grid.dataSource.read();
			lfo_popGrd.grid.dataSource.read();
			
			//팝업종료
			gfn_closePop(lfo_popGrd.popId);
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}


//삭제 콜백
this.lfn_pkgPlanPop_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delTemp = lfo_popGrd.grid.dataItem($(this).closest('tr'))
			delPrmt.push(delTemp);
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
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});		//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}


</script>