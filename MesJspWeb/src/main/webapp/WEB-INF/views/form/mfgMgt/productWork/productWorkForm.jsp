 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>



<div id="grid-content" class="productWorkForm productWorkForm-gird">
	<!-- 좌측 오더리스트 -->
	<div id="jteSingleGrid" class="productWorkForm left-contents"></div>
	<!-- 우측 작업지시리스트 -->
	<div id="jteDoubleGrid" class="productWorkForm right-contents"></div>
</div>

<!-- 생산지시 팝업 -->
<div style="display:none;">
	<div id="jteProdAsgnPop">
		<form id="jteProdAsgnPop_form" class="productWorkForm">
		<!-- 작업지시 -->
			<div class="pop_title"><spring:message code = "pop_workAsm"></spring:message></div>
			<table style="width:100%;" id="jteProdAsgnPop_master">
			<colgroup>
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr>
				<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td>
						<input type="text" id="itemNm" class="left-input" name="itemNm" readonly />
						<input type="hidden" id="itemId" name="itemId"/>
					</td>
					<!-- 긴급여부 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_prodEmj"></spring:message> : </td>
					<td>
						<input name="prodAsmEmj" id="prodAsmEmj" class="right-input" format="selBox" msg="prod_emj"/>
					</td>
				</tr>
				<tr>
				<!-- 작업지시명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderNm"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="prodAsmNm" name="prodAsmNm" class="center-input"/>
						<input type="hidden" name="prodAsmId"/>
					</td>
				</tr>
				<tr>
				<!-- 지시량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_asmQuan"></spring:message> : </td>
					<td>
						<input id="prodAsmQty" class="left-input" name="prodAsmQty" format="currency"/>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>지시일 : </td>
					<td>
						<input id="prodAsmDate" class="right-input" name="prodAsmDate" format="datepicker"/>
						</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="prodAsmDesc" class="center-input" name="prodAsmDesc" format="text"/></td>
				</tr>
				<tr style="display:none;">
				<!-- 부서명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_deptNm"></spring:message> : </td>
					<td>
						<input id="deptNm" class="left-input btn-input" name="deptNm" format="text" readonly/>
						<input type="hidden" name="deptId" id="deptId"/>
					</td>
					<td>
				<!-- 조회 -->
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_deptInfoPop_Open(lfn_deptInfoPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				<!-- 작업지시자 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_workOrderUser"></spring:message> : <i class="fas fa-info-circle" title="미설정시 지정된 부서의 팀장에게 발송됩니다." style="background:yellow;"></i></td>
					<td>
						<input id="prodAsmUserNm" class="right-input btn-input" name="prodAsmUserNm" format="text" readonly/>
						<input type="hidden" name="prodAsmUser" id="prodAsmUser"/>
					</td>
					<td>
				<!-- 조회 -->
						<button class="k-button k-primary search-btn" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
						<spring:message code="btn_search" /></button>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
					<!-- 작업상태 -->
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "prodAsmState"/>
						<input type="hidden" name="use"/>
						<input type="hidden" name="action"/>
					</td>
				</tr>
			</table>
		</form>
		
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>				<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>				<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteProdAsgnPop');"><spring:message code = "pop_cancel"></spring:message></button>		<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 라우팅 전체조회 POP(같은 작업지시에 포함된 라우팅만 조회한다.) -->
<div style="display:none;">
	<div id="routingSheetPop" class="routingSheetPop">
	<!-- 라우팅 조회 -->
		<div class="pop_title"><spring:message code = "pop_routingSearch"></spring:message></div>
		<div id="routingSheetPop_grid" class="routingSheetPop_grid" style="height:430px;"></div>
		<input type="hidden" id="aabbcc"/>
	</div>
</div>

<!-- 작업종료 팝업 -->
<div style="display:none;">
	<div id="jteWorkEndPop">
		<div class="pop_title">작업종료 정보 입력</div>
		<form id="jteWorkEndPop_form" class="wrkinWrkerMgtForm jteWorkEndPop_form">	
			<table class="jteWorkEndPop_table jteWorkEndPop_table_left"> <!-- 200513 LYM 안정적인 배치를 위해 좌측 우측 하단 세 테이블로 나눔 -->
				<colgroup> <!-- 50 50 -->
					<col class="col-left">
					<col class="col-right">
				</colgroup>
				<tr>
					<!-- 양품량 -->
					<td colspan="2" class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "col_goodProdQuan"></spring:message></td>
					<td>
						<input class="left-input" name="prodWorkGood" format="currency"/>
					</td>
				</tr>
				<tr>
					<!-- 작업종료 -->
					<td colspan="2" class="pop_title not_pop_title"><i class="fas fa-caret-right"></i><spring:message code = "pop_workEnd"></spring:message></td>
					<td>
					<!-- 미입력시 현재시간이 입력됩니다 -->
						<input class="center-input" name="prodWorkEnd" format="datetimepicker" placeholder="<spring:message code = "pop_noEnterCurrentTime"></spring:message>"/>
						<input type= "hidden" name="prodWorkStart" />
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name = "lotId"/>
						<input type="hidden" name = "itemId"/>
						<input type="hidden" name = "prodWorkId"/>
						<input type="hidden" name = "bomTarget"/>
						<input type="hidden" name = "eqmtMgtId"/>
						<input type="hidden" name = "routingId"/>
						<input type="hidden" name = "action"/>
					</td>
				</tr>
			</table>	
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>									<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>									<!-- 저장 -->
				<button class="k-button k-primary jte-tempSave final-btn" type="button" onclick="lfn_workEndPop_TempSave()"><spring:message code = "pop_interStorage"></spring:message></button>			<!-- 중간저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteWorkEndPop');"><spring:message code = "pop_cancel"></spring:message></button>						<!-- 취소 -->
		</div>
	</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mfgMgt/productWork/productWorkForm_JJW.css' rel="stylesheet"/>

<!-- 내부 스타일 외부로 이동_200812 JJW  -->
<script>

var lfo_common = {};// order(LOT)목록 Object 

var lfo_workAsgn = {};// 작업지시 목록 Object

var lfo_popGrd = {};// 선택한 작업지시 라우팅 Object

var lfo_prodWorkEnd = {}; //작업종료 팝업

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
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
	lfo_common.popId = "";
	
	//3.
	lfo_common.ctrlUrl = "/form/mfgMgt/productWork";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getProductWorkLotList", auth:"", prmt:{}}
	};
	
	//5.
	lfo_common.model = {
			id: "lotSeq",
			fields: {
				lotSeq : { type: "int" },
				lotId : { type: "string" },
				lotNm : { type: "string" },
				lotCode : { type: "string" },
				lotType : { type: "string" },
				lotQty : { type: "int" },
				lotPm : { type: "string" },
				lotPmNm : { type: "string" },
				lotState : { type: "string" },
				lotDesc : { type: "string" },
				createdAt : { type: "date" },
				creatorId : { type: "string" },
				updatedAt : { type: "date" },
				updatorId : { type: "string" },
				itemId : { type: "string" },
				cliamId : { type: "string" },
				orderId : { type: "string" },
				itemNm: { type: "string" },
				itemDeduction: { type: "int" },
				orderNm: { type: "int" },
				orderManager: { type: "int" },
				orderStdt: { type: "date" },
				orderEddt: { type: "date" },
				orderCost: { type: "int" },
				compId: { type: "int" },
				compNm: { type: "int" },
				orderState: { type: "int" },
				description: { type: "int" }
			}
		};
	
	//6.
	lfo_common.columns = [
		{field: "lotId",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_jteDbGrid_gridSet(this);" style="min-width:60px;">' + "지시목록" + '</button>',
		title : "상세", width: 100},									//수정
		//{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},				//Lot코드
		{template:"#:data.orderNm#",field: "orderNm", title:"수주명", width: "150px;"},
		{field: "lotNm", title:"LoT명", width: "150px;"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "150px;"},				//부품명
		{field: "lotQty", title : "수주량", width: "90px;"},				//Lot수량
		{field: "compNm", title : "업체명", width: "120px;"},				//업체명
		{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "120px"},				//수주일
		{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "120px"},			//납기일
		{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
			title:gfn_getMsg("col_orderStatus"), width: "120px;"},					//수주상태
		{field: "lotPmNm", title:gfn_getMsg("col_manager"), width: "120px;"}			//담당자
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "수주명", value: "lot.lot_nm" },
		{ text: "부품명", value: "item.item_nm"},
		{ text: gfn_getMsg("col_orderCd"), value: "orInfo.order_id" },			//수주코드
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },			//담당자
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" }			//업체명
	];
	
	//8.
	lfo_common.validation ={}
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
};

//투입현황 토탈 그리드 세팅
this.lfn_jteDbGrid_gridSet = function(rows){
	
	//작업지시 그리드 초기화
	$("#jteDoubleGrid").html("");
	
	lfo_common.gridSelected = lfo_common.grid.dataItem($(rows).closest("tr"));
	
	//1.
	lfo_workAsgn.layoutId = "jteDoubleGrid";
	
	//2.
	lfo_workAsgn.popId = "jteProdAsgnPop";
	
	//3.
	lfo_workAsgn.ctrlUrl = "/form/mfgMgt/productWork";

	//4.
	lfo_workAsgn.crud  = {
		read:{url:"/getProdWorkAsgnList", auth:"", prmt:{lotId : lfo_common.gridSelected.lotId}, search : false, paging:false},
		//create : {url:"/setProdWorkAsgnSave", auth : "", openFunc : lfn_asgnCreatePop_open, callback : lfn_asgnCreatePop_save},
		//update : {url:"/setProdWorkAsgnSave", auth : "", openFunc : lfn_asgnCreatePop_open, callback : lfn_asgnCreatePop_save}
		//,destroy : {url:"/setProdWorkAsgnDelete", auth : "", callback : lfn_asgnCreatePop_delete}
	};
	
	//커스텀 타이틀
	lfo_workAsgn.customTitle = {
		html:'<span class="pop_title">'+"지시목록"+'</span>'
	}
	
	//5.
	lfo_workAsgn.model = {
		id: "prodAsmId",
		fields: {
			orderId : { type: "string" }, 
			orderNm : { type: "string" },
			lotId : { type: "string" },
			lotNm : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotQty : { type: "int" },
			prodAsmId : { type: "string" },
			prodAsmNm : { type: "string" },
			prodAsmDate : { type: "date" },
			prodAsmQty : { type: "int" },
			prodAsmDesc : { type: "string" },
			prodAsmUser : { type: "string" },
			prodAsmUserNm : { type: "string" },
			prodAsmEmj : { type: "string" },
			prodAsmState : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			deptId : { type: "string" },
			deptNm : { type: "string" }
		}
	};
	
	//6.
	lfo_workAsgn.columns = [
		{field: "prodAsmId", title: "라우팅 시트", width: "100px",
			template:'<button class="k-button k-primary" type = "button" onclick = "lfn_routingSheet_open(this)" style="width:60px;">'+"시트조회"+'</button>' },
		{field: "prodAsmNm", title : "지시명", width: "150px"},
		{field: "prodAsmDate", format: "{0: yyyy-MM-dd}", title : "지시일", width: "120px"},
		{field: "prodAsmQty", format:"{0:n0}", title : "지시량", width: "100px"},
		{field: "prodAsmUserNm", format:"{0:n0}", title : "지시자", width: "90px"},
		{field: "prodAsmEmj", template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #", 
			title : "긴급여부", width: "110px"},
		{field: "prodAsmState", template:"# var item = gfn_isNull(gfn_getCode(prodAsmState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmState).cdId , gfn_getCode(prodAsmState).cdNm) # #= item #", 
			title : "상태", width: "110px"}
	];
	
	//공통 그리드 세팅 호출 
	lfo_workAsgn.grid = gfn_grid_set(lfo_workAsgn);
}


//생산지시 팝업
this.lfn_asgnCreatePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "560px", //200520 JJW 550 -> 560
		height: "330px", //200520 JJW 265 -> 330
		id : lfo_workAsgn.popId, 
		title : gfn_getMsg("pop_workAsm"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_asgnCreatePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_asgnCreatePop_set = function(mode,selectedItem){
	lfo_workAsgn.gridSelected = {};
	
	if(mode=='NEW'){
		//팝업 기본정보 세팅
		lfo_workAsgn.gridSelected={ 
			lotId : lfo_common.gridSelected.lotId
		};
		
		//팝업내용 조회
		$.ajax({
			async:false,
			url : lfo_workAsgn.ctrlUrl + "/getProductWorkLotList",
			type: "POST",
			data: lfo_workAsgn.gridSelected,
			success: function(data){
				//팝업 세팅 로드
				gfn_popform_set(lfo_workAsgn, mode, data.rows[0]);
				$("#" + lfo_workAsgn.popId + " [name = prodAsmDate]").data("kendoDatePicker").value(new Date());
				$("#" + lfo_workAsgn.popId + " [name = prodAsmState]").val("prod_sta01");
				
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});	
		
	}else if(mode == 'EDT'){
		
		lfo_workAsgn.gridSelected = lfo_workAsgn.grid.dataItem($(selectedItem).closest("tr"));
		
		//팝업내용 조회
		$.ajax({
			async:false,
			url : lfo_workAsgn.ctrlUrl + "/getProdWorkAsgnDetail",
			type: "POST",
			data: {lotId : lfo_workAsgn.gridSelected.lotId, prodAsmId : lfo_workAsgn.gridSelected.prodAsmId},
			success: function(data){
				console.log(data);
				//팝업 세팅 로드
				gfn_popform_set(lfo_workAsgn, mode, data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});	
	}
}

//Form내용 입력/저장
this.lfn_asgnCreatePop_save = function(savePrmt){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_workAsgn.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		var savePrmt = gfn_serializeObject(lfo_workAsgn.popId+"_form");
		
		$.ajax({
			async:false,
			url : lfo_workAsgn.ctrlUrl + lfo_workAsgn.crud.create.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//이전화면 리로드
					lfo_common.grid.dataSource.read();
					lfo_workAsgn.grid.dataSource.read();
					
					gfn_closePop('jteProdAsgnPop');
					
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
}

//삭제 콜백
this.lfn_asgnCreatePop_delete = function(){
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

//라우팅시트 팝업 오픈 (팝업 오픈)
this.lfn_routingSheet_open = function(selectedItem){
	var options = {
		modal:true, 
		width: "1300px", 
		height: "530px", 
		id : "routingSheetPop", 
		title:"라우팅 시트 팝업",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//라우팅 시트 그리드 세팅
		this.lfn_jteRoutingAll_setGrd(selectedItem);
		
		//그리드가 정상적으로 생성되었다면 show();
		if(gfn_isEmpty(lfo_routingAll.grid)){
			$("#routingSheetPop").show();
		}
	};
	
	this.gfn_winOpen(options);
}

//라우팅 전체 조회 팝업 내부 그리드 세팅
this.lfn_jteRoutingAll_setGrd = function(selectedItem){
	lfo_workAsgn.gridSelectedRout = lfo_workAsgn.grid.dataItem($(selectedItem).closest("tr"));
	
	lfo_routingAll = {};//Form 내부에서 사용될 Object 
	//1.
	lfo_routingAll.layoutId = "routingSheetPop_grid";
	
	//2.
	//lfo_routingAll.popId = "jteProdWorkForm";
	
	//3.
	lfo_routingAll.ctrlUrl = "/form/mfgMgt/productWork"

	//4.
	lfo_routingAll.crud  = {
		read:{url:"/getProdWorkRoutSheetList", auth:"" ,search : false, paging : false,
			prmt:{ lotId : lfo_workAsgn.gridSelectedRout.lotId, prodAsmId : lfo_workAsgn.gridSelectedRout.prodAsmId}}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		//update:{url:"", auth:"", openFunc : lfn_jteSgGrid_dblclick, callback:""}
	};
	
	//5.
	lfo_routingAll.model = {
			id: "prodWorkId",
			fields: {
				orderId: { type: "string" },
				lotId: { type: "string" },
				lotNm: { type: "string" },
				itemId : { type: "string" },
				itemNm : { type: "string" },
				itemDeduction: { type: "int" },
				itemDayTarget: { type: "int" },
				itemTotalStock: { type: "int" },
				itemStd01: { type: "int" },
				itemStd02: { type: "int" },
				itemStd03: { type: "int" },
				itemStd04: { type: "int" },
				itemStd05: { type: "int" },
				itemStdStr01: { type: "string" },
				itemStdStr02: { type: "string" },
				itemStdStr03: { type: "string" },
				itemStdStr04: { type: "string" },
				itemStdStr05: { type: "string" },
				itemUnit: { type: "string" },
				itemMtrl: { type: "string" },
				prodAsmId: { type: "string" },
				prodAsmNm: { type: "string" },
				prodAsmDate: { type: "date" },
				prodAsmQty: { type: "int" },
				prodAsmDesc: { type: "string" },
				prodAsmUser: { type: "string" },
				prodAsmUserNm: { type: "string" },
				prodAsmEmj: { type: "string" },
				prodAsmState: { type: "string" },
				deptId: { type: "string" },
				deptNm: { type: "string" },
				prodWorkId: { type: "string" },
				routingId: { type: "string" },
				routingSeq : { type: "int" },
				routingType :  { type: "string" },
				bomTarget: { type: "string" },
				mtrlUse : { type: "string" }, 
				eqmtMgtId: { type: "string" },
				eqmtMgtNm: { type: "string" },
				prodWorkUser: { type: "string" },
				prodWorkUserNm: { type: "string" },
				prodWorkQty: { type: "int" },
				prodWorkGood: { type: "int" },
				prodWorkBad: { type: "int" },
				prodWorkStart: { type: "date" },
				prodWorkEnd: { type: "date" },
			}
		};
	
	//6.
	lfo_routingAll.columns = [
		{field: "routingSeq", title:gfn_getMsg("col_routSeq"), width: "80px"},												//차수
		{field: "routingId", title:gfn_getMsg("col_routCd"), width: "120px"},								//라우팅코드
		{field: "routingType",  template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #",
			title:gfn_getMsg("col_routType"), width: "130px"},												//공정유형
		{field: "eqmtMgtNm", title : "설비", width: "130px"},	//설비
		{field: "placeNm", title : "위치", width: "130px"},													//위치
		{field: "prodWorkUserNm", title:gfn_getMsg("col_worker"), width: "100px"},							//작업자
		{field: "prodWorkStart", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"시작시간", width: 120},
		{field: "prodWorkEnd", format:"{0: yyyy-MM-dd hh:mm:ss}", title:"종료시간", width: 120},
		{field: "prodWorkQty", format:"{0:n0}", title:gfn_getMsg("col_asmQuan"), width: "95px"},			//지시량
		{field: "prodWorkGood", format:"{0:n0}", title:"생산량", width: 90},
		{field: "prodWorkBad", format:"{0:n0}", title:"불량량", width: 90},
		{field: "prodWorkStart", title : "작업", width: 90,
			template:"# var workBtn = gfn_isNull(prodWorkStart) == true ? '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_routSheetWork_start(this);\" style=\"min-width:60px;\">시작</button>' :" +
			" gfn_isNull(prodWorkEnd) == true ? '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_workEndPop_Open(this);\" style=\"min-width:60px;\">종료</button>' : " + 
			" '작업완료' # #= workBtn #"},
/* 		{field: "bomTarget", title : "자재", width: 100,
			template:"# var mtrlBtn = bomTarget == 'SUCCESS' ? " +
			"'<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_mtrlUseTotalPop_Open(this);\" style=\"min-width:60px;\">자재투입</button>' : '' # #= mtrlBtn #" },
		{field: "bomTarget", title : "불량", width: 100,
			template:"# var badBtn = '<button class=\"k-button k-primary\" type=\"button\" onclick = \"lfn_itemBadListPop_Open(this);\" style=\"min-width:60px;\">불량등록</button>' # #= badBtn #" } */
			

		//설비지정, 공구지정, 자재지정
		//{field: "prodAsmState", title:"상태", width: 100},
		//{field: "deptNm", title:"부서명", width: 120},
 		//{field: "prodAsmId", title:"생산지시코드", width: 150},
 		//{field: "prodAsmNm", title:"생산지시명", width: 150},
 		//{field: "itemNm", title:"생산품", width: 150},
 		//{field: "prodAsmEmj",template:"# var item = gfn_isNull(gfn_getCode(prodAsmEmj))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(prodAsmEmj).cdId , gfn_getCode(prodAsmEmj).cdNm) # #= item #",title:"긴급여부", width: 100},
 		//{field: "prodWorkId", title:"작업정보코드", width: 120},
		//{field: "prodAsmDesc", title:"생산지시 비고", width: 300}
		//{field: "prodWorkGood", format:"{0:n0}", title:"생산량", width: 120},
		//{field: "prodWorkBad", format:"{0:n0}", title:"불량량", width: 120},
		
	];
	
	//7.
	lfo_routingAll.selectBox = [/* { text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" }//공구유형 */];
	
	//공통 그리드 세팅 호출 
	lfo_routingAll.grid = gfn_grid_set(lfo_routingAll);
}

//작업시작
this.lfn_routSheetWork_start = function(rows){
	
	var savePrmt = lfo_routingAll.grid.dataItem($(rows).closest("tr"));
	if($("#aabbcc").val() == ""){
		savePrmt.prodWorkStart = gfn_getDate(new Date(),'yyyy-MM-dd hh:mm:ss');
	}else{
		savePrmt.prodWorkStart = $("#aabbcc").val();
	}
	
	$.ajax({
		async:false,
		url : lfo_routingAll.ctrlUrl + "/setProdWorkRoutSheetStart",
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//이전화면 리로드
				lfo_routingAll.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//작업종료 팝업 오픈
this.lfn_workEndPop_Open = function(rows){
	var options = {
		modal:true, 
		width: "500px", 
		height: "270px", // 200512 JJW 작업종료 팝업 높이 270 -> 600px;
		id : "jteWorkEndPop", 
		title:gfn_getMsg("pop_wrkEndConfirmList"),			//작업종료 전 확인사항
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_workEndPop_set(rows);
	};
	this.gfn_winOpen(options);	
}

//작업종료 팝업 - 세팅
this.lfn_workEndPop_set = function(rows){
	
	lfo_routingAll.gridSelectedEnd = lfo_routingAll.grid.dataItem($(rows).closest("tr"));
	//pop가 두개라 커스텀 오브젝트
	lfo_prodWorkEnd = {
		popId : "jteWorkEndPop",
		ctrlUrl : "/form/mfgMgt/productWork",
		crud : {
			read:{url:"/getProdWorkRoutSheetList", auth:"" ,search : false, paging : false,
				prmt:{ lotId : lfo_routingAll.gridSelectedEnd.lotId, prodAsmId : lfo_routingAll.gridSelectedEnd.prodAsmId, prodWorkId: lfo_routingAll.gridSelectedEnd.prodWorkId}},
			update:{url:"/setProdWorkRoutSheetEnd", auth:"", callback : lfn_routSheetWork_end}
		}
	};
	//ajax호출하여 최신 정보 세팅 
	$.ajax({
		async:false,
		url : lfo_prodWorkEnd.ctrlUrl + lfo_prodWorkEnd.crud.read.url,
		type: "POST",
		data: lfo_prodWorkEnd.crud.read.prmt,
		success: function(data){
			var rtnData = data.rows[0];
			//작업정보화면 세팅(메인우측)
			gfn_popform_set(lfo_prodWorkEnd, "EDT", rtnData);
			if(gfn_isNull(rtnData.prodWorkEnd)){
				$("#"+lfo_prodWorkEnd.popId+"_form [name=qtyAcion]").val("C");
				$("#"+lfo_prodWorkEnd.popId + "_form [name=prodWorkEnd]").data("kendoDateTimePicker").value(gfn_getDate(new Date,'yyyy-MM-dd hh:mm:ss'));
			}else{
				$("#"+lfo_prodWorkEnd.popId+"_form [name=qtyAcion]").val("U");
			}
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

//공구교체


//중간 저장
this.lfn_routSheetWork_tempSave = function(mode){
	
	var savePrmt = gfn_serializeObject(lfo_prodWorkEnd.popId+"_form");
	savePrmt.qtyAction = "TEMP";
	
	$.ajax({
		async:false,
		url : lfo_prodWorkEnd.ctrlUrl + lfo_prodWorkEnd.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				gfn_closePop(lfo_prodWorkEnd.popId);
				
				//이전화면 리로드
				lfo_routingAll.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//작업종료
this.lfn_routSheetWork_end = function(mode){
	
	var savePrmt = gfn_serializeObject(lfo_prodWorkEnd.popId+"_form");
	savePrmt.qtyAction = "C";
	
	$.ajax({
		async:false,
		url : lfo_prodWorkEnd.ctrlUrl + lfo_prodWorkEnd.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				gfn_closePop(lfo_prodWorkEnd.popId);
				
				//이전화면 리로드
				lfo_routingAll.grid.dataSource.read();
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