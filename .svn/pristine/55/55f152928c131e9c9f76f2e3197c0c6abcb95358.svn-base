<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="asHisMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="asHisMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="asHisMgtForm">
			<div class="pop_title">바코드 상세 정보</div>
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:19%;">
				<col style="width:29%;">
				<col style="width:23%;">
				<col style="width:29%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i>바코드 : </td>
					<td><input type="text" id="barcodeId" name="barcodeId" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>수주명 : </td>
					<td><input type="text" id="orderNm" name="orderNm" readonly/></td>
					<td><i class="fas fa-caret-right"></i>LoT명 : </td>
					<td><input type="text" id="lotNm" name="lotNm" readonly/></td>
				</tr>				
				<tr>
					<td><i class="fas fa-caret-right"></i>제품명 : </td>
					<td>
						<input type="text" id="itemNm" name="itemNm" readonly/>
						<input type="hidden" id="itemId" name="itemId"/>
					</td>
					<td><i class="fas fa-caret-right"></i>제품규격 : </td>
					<td><input type="text" id="itemStdStr01" name="itemStdStr01" readonly/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="mtrl_action"/>
						<input type="hidden" name="itemId" id="itemId"/>
					</td>
				</tr>
			</table>
			
			<div class="pop_title">A/S</div>
			<div id="jtePopForm_grid" style="height:300px" class="asHisMgtForm"></div>
 			<div class="final-btn-area asHisMgtForm-final-btn-area">
<%-- 				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->--%>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 --> 
			</div>
		</form>
	</div>
</div>

<!-- 팝업(마스터그리드 > 팝업창 내부 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopAddForm">
		<form id = "jtePopAddForm_form" class="mtrlMgtForm popsc-mtrlMgtForm">
			<table style="width:100%;" id="jtePopAddForm_master" class="BasicTable">
			<colgroup>  <!-- 200511 원래는 23 27 23 27_LYM -->
				<col style="width:24%;">
				<col style="width:26%;">
				<col style="width:22%;">
				<col style="width:28%;">
			</colgroup>
				<tr><td colspan="4"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>A/S 아이디 : </td>
					<td><input type="text" id="ashisId" name="ashisId" placeholder="자동생성" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>A/S 등록자 : </td>
					<td>
						<input type="text" id="ashisUserNm" class="btn-input" name="ashisUserNm" class="k-textbox" readonly />
						<input type="hidden" id="ashisUser" name="ashisUser" />
						<button class="k-button k-primary" type="button" onclick= "lfn_ashisUserPop_open()">
				<!-- 조회 -->
						<spring:message code = "btn_search"/></button>
					</td>
				</tr>
<!-- 				<tr>
					<td><i class="fas fa-caret-right"></i>자재명 : </td>
					<td><input type="text" id="mtrlNm" class="left-input" name="mtrlNm" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>자재개별코드 : </td>
					<td><input type="text" id="mtrlMgtId" class="right-input" name="mtrlMgtId" format="selBox" /></td>
				</tr> -->
				<tr>
					<td><i class="fas fa-caret-right"></i>자재명 : </td>
					<td>
						<input id="mtrlMgtId" name="mtrlMgtId" format = "selBox" custom="true" keyGbn="mtrlMgtId" keyText="bomTargetNm" func="lfn_bomMtrl_get()" />
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>수량 : </td>
					<td><input type="text" id="ashisCnt" name="ashisCnt" format="currency"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>A/S 등록시간 : </td>
					<td><input type="text" id="ashisAt" name="ashisAt" format="datepicker"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>A/S 이유 : </td>
					<td colspan="4"><input type="text" id="ashisDesc" name="ashisDesc" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>처리 결과 :</td>
					<td colspan="3"><textarea id="ashisResult" name="ashisResult" rows="3"></textarea></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="mtrlQtyUse"/>
						<input type="hidden" name="action" id="mtrlQtyAction"/>
						<input type="hidden" name="barcodeId" id="barcodeId"/>
						<input type="hidden" name="lotId" id="lotId"/>
						<input type="hidden" name="mtrlId" id="mtrlId"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="shipInfoForm">
		<form id="shipInfoForm_form" class="shipInfoForm">
		<!-- 포장 작업 정보 -->
			<div class="pop_title">출하 정보</div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
				<colgroup>
					<col style="width: 22%;">
					<col style="width: 28%;">
					<col style="width: 25%;">
					<col style="width: 25%;">
				</colgroup>
				<tr>
				<!-- 출하코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipCd"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="shipId" name="shipId" readonly/>
					</td>
				</tr>
				<tr>
				<!-- LoT코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_lotCd"></spring:message> : </td>
					<td colspan="3">
						<input type="text" id="popItemMgtId" name="itemMgtId" readonly/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>출하 구분 : </td>
					<td><input id="shipType" name="shipType" format="selBox" msg="ship_type" class="jtePopForm_onlyInsert"/></td>
					<td><i class="fas fa-caret-right"></i>출하 수량 : </td>
					<td>
						<input id="shipQty" name="shipQty"  format="numeric" readonly/>
						<input type="hidden" id="prevShipQty" name="prevShipQty" />
					</td>
				</tr>
				<tr>
					<!-- 출하 예정일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_shipExceptDate"></spring:message> : </td>
					<td><input type="text" id="shipStartDate" name="shipStartDate" format="datetimepicker" class="jtePopForm_onlyInsert"/></td>
					<!-- 출하 완료일 -->
					<td class="completeDate" ><i class="fas fa-caret-right"></i>출하 완료일 : </td>
					<td class="completeDate" ><input type="text" id="shipCompleteDate" name="shipCompleteDate" format="datetimepicker" class="jtePopForm_onlyInsert"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>고객사 : </td>
					<td colspan="3">
						<input type="text" id="compNm" name="compNm" readonly/>
						<input type="hidden" id="compId" name="compId" />
						<input type="hidden" id="compAddrId" name="compAddrId" />
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>고객사 주소 : </td>
					<td colspan="3"><input type="text" id="compAddrDetail" name="compAddrDetail" readonly/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="shipDesc" name="shipDesc" readonly/></td>
				</tr>
			</table>
			<input type="hidden" name="action" id="shipAction"/>
		</form>
		
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('shipInfoForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="finalInfoForm">
		<form id="finalInfoForm_form" class="finalInfoForm">
		<!-- 최종 검사 정보 -->
			<div class="pop_title">최종 검사 정보</div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
				<colgroup>
					<col style="width: 22%;">
					<col style="width: 28%;">
					<col style="width: 25%;">
					<col style="width: 25%;">
				</colgroup>
				<tr>
				<!-- 최종검사 코드 -->
					<td><i class="fas fa-caret-right"></i>최종검사 코드 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtId" name="plcEqmtId" readonly/>
					</td>
					<td><i class="fas fa-caret-right"></i>최종검사 시간 : </td>
					<td><input type="text" id="plcEqmtDate" name="plcEqmtDate" format="datetimepicker" class="jtePopForm_onlyInsert"/></td>
				</tr>
				<tr>
				<!-- 합격여부 -->
					<td><i class="fas fa-caret-right"></i>합격 여부 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtPass" name="plcEqmtPass" readonly/>
					</td>
				</tr>
			</table>
			<div class="pop_title">최종 검사 데이터</div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
				<tr>
				<!-- 검사 데이터 -->
					<td><i class="fas fa-caret-right"></i>DBW0 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtBolt01" name="plcEqmtBolt01" readonly/>
					</td>
					<td><i class="fas fa-caret-right"></i>DBW2 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtBolt02" name="plcEqmtBolt02" readonly/>
					</td>
				</tr>
				<tr>
				<!-- 검사 데이터 -->
					<td><i class="fas fa-caret-right"></i>DBW4 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtBolt03" name="plcEqmtBolt03" readonly/>
					</td>
					<td><i class="fas fa-caret-right"></i>DBW6 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtBolt04" name="plcEqmtBolt04" readonly/>
					</td>
				</tr>
				<tr>
				<!-- 검사 데이터 -->
					<td><i class="fas fa-caret-right"></i>DBW8 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtChk01" name="plcEqmtChk01" readonly/>
					</td>
					<td><i class="fas fa-caret-right"></i>DBW10 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtChk02" name="plcEqmtChk02" readonly/>
					</td>
				</tr>
				<tr>
				<!-- 검사 데이터 -->
					<td><i class="fas fa-caret-right"></i>DBW12 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtChk03" name="plcEqmtChk03" readonly/>
					</td>
					<td><i class="fas fa-caret-right"></i>DBW14 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtChk04" name="plcEqmtChk04" readonly/>
					</td>
				</tr>
				<tr>
				<!-- 검사 데이터 -->
					<td><i class="fas fa-caret-right"></i>DBW0 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtBolt01" name="plcEqmtBolt01" readonly/>
					</td>
					<td><i class="fas fa-caret-right"></i>DBW0 : </td>
					<td colspan="3">
						<input type="text" id="plcEqmtBolt02" name="plcEqmtBolt02" readonly/>
					</td>
				</tr>

			</table>
		</form>
		
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('finalInfoForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
};

// 그리드 세팅
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
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mtrl/asHisMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getSerialList", auth:"", prmt:{}, dynamicPrmt : {}}, 
		//create:{url:"", auth:"", openFunc : "", callback : "" }, 
		update:{url:"", auth:"", openFunc :"" , callback : ""}, 
		//destroy:{url:"/setAsHisMgtDelete", auth:"", callback : lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "barcodeId",
		fields: {
			itemMgtId : { type : "string" },
			barcodeId : { type : "stirng" },
			orderId : { type : "string" },
			orderNm : { type : "string" },
			orderState : { type : "string" },
			lotId : { type : "string" },
			lotNm : { type : "string" },
			lotState : { type : "string" },
			lotQty : { type : "string" },
			itemId : { type : "string" },
			itemNm : { type : "string" },
			itemStdStr01 : { type : "string", },
			shipId : { type: "string" },
			plcEqmtId : { type: "string" },
			packageId : { type: "string" },
			shipCompleteDate : { type : "date" },
			createdAt : { type : "string" },
			creatorId : { type : "string" },
			updatedAt : { type : "string" },
			updatorId : { type : "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field : "barcodeId", title : gfn_getMsg("btn_update"), width : 200, attributes:{style:'text-align:center;'}, 
			template : '<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this)"><spring:message code = "btn_search" /></button>'+'<button class="k-button k-primary" type="button" onclick = "lfn_finalInfoForm_open(\'EDT\',this);">최종검사</button>'+ 
			'<button class="k-button k-primary" type="button" onclick = "lfn_shipInfoForm_open(\'EDT\',this);">출하정보</button>'},
		{field : "barcodeId", title : "바코드", width: "180px"},
		{field : "orderNm", title : "수주명", width : "200px"},
		{field : "lotNm", title : "LoT명", width : "200px"},
		{field : "itemNm", title : "제품명", width : "150px"},
		{field : "createdAt", title : "바코드 생성 날짜", width : "180px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "바코드", value: "barcode.barcode_id" },
		{ text: "수주명", value: "odr.order_nm" },
		{ text: "LoT명", value: "lot.lot_nm" },
		{ text: "제품명", value: "itemInfo.item_nm" }
	]

	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px", 
		height: "640px", 
		id : lfo_common.popId, 
		title:"A/S 관리",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			barcodeId : lfo_common.gridSelected.barcodeId,
			itemId : lfo_common.gridSelected.itemId,
			lotId : lfo_common.gridSelected.lotId
		}
		gfn_popform_set(lfo_common, mode,selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {barcodeId : selectedItem};
			
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {barcodeId : lfo_common.gridSelected.barcodeId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	}
	
}

//팝업내부 그리드 
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
	lfo_popGrd.popId = "jtePopAddForm";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/mtrl/asHisMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getAsHisMgtList", auth:"", prmt:{barcodeId : lfo_common.gridSelected.barcodeId, itemId : lfo_common.gridSelected.itemId}}, 
		create:{url:"/setAsHisMgtSave", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback : lfn_jtePopGrd_save},
		update:{url:"/setAsHisMgtSave", auth:"", openFunc : "" , callback : lfn_jtePopGrd_save},
		destroy:{url:"/setAsHisMgtDelete", auth:"", callback : lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "ashisId",
		fields: {
			ashisId : { type: "string" },
			ashisState : { type: "string" },
			ashisCnt : { type: "int" },
			ashisUser : { type: "string" },
			ashisAt : { type: "date" },
			ashisDesc : { type: "string" },
			ashisResult : { type: "string" },
			ashisStdStr01 : { type: "string" },
			creatorId : { type: "string" },
			createdAt : { type: "date" },
			updatorId : { type: "string" },
			updatedAt : { type: "date" },
			mtrlMgtId : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			barcodeId : { type: "string" },
			itemId : { type : "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "ashisId",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("col_update"), width: "90px"},
		{field: "ashisId", title : "A/S 아이디", width: "160px"},
		{field: "mtrlNm", title : "자재명", width: "150px"},
		{field: "mtrlMgtId", title : "자재개별코드", width: "160px"},
		{field: "ashisAt", format: "{0: yyyy-MM-dd}", title : "A/S 등록시간", width: "140px"},
		{field: "ashisUserNm", title : "A/S 등록자", width: "130px"},
		{field: "ashisCnt", title : "수량", width: "80px"},
		{field: "ashisDesc", title : "A/S 이유", width: "300px"}
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text : "자재명", value : "mtrlInfo.mtrl_nm" },
		{ text : "A/S 이유", value : "asInfo.ashis_desc" },
		{ text : "A/S 등록자", value : "userInfo.user_nm" }
	];

	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

//입고검사 관련문서 등록/수정 팝업 호출
this.lfn_jtePopGrd_popOpen = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "710px",
		height: "400px", /* 20.12.23 JJW 315 -> 340 */
		id : lfo_popGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[ /*"Minimize", "Maximize", */ "Close"]
	};
	if(mode =="NEW"){
		options.title = "A/S"

	}else if(mode=="EDT"){
		options.title = "A/S 수정"
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteAsPop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//입고검사 관련문서 등록/수정 팝업 내용 세팅
this.lfn_jteAsPop_set = function(mode,selectedItem){
	lfo_popGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			barcodeId : lfo_common.gridSelected.barcodeId,
			lotId : lfo_common.gridSelected.lotId,
			ashisId : lfo_popGrd.gridSelected.ashisId,
			mtrlMgtId : lfo_popGrd.gridSelected.mtrlMgtId,
			ashisAt : new Date(),
			ashisUser : $("#_loginUserId").val(),
			ashisUserNm : $("#_loginUserName").val()
		}
		gfn_popform_set(lfo_popGrd, mode,selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_popGrd.gridSelected = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_popGrd.gridSelected = {ashisId : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.read.url,
			type: "POST",
			data: {
				ashisId : lfo_popGrd.gridSelected.ashisId,
				itemId : lfo_common.gridSelected.itemId,
				},
			success: function(data){
				gfn_popform_set(lfo_popGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		savePrmt.barcodeId = $("#barcodeId").val();
		savePrmt.lotId = $("#lotId").val();

		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					
					lfo_popGrd.grid.dataSource.read();
					
					lfo_common.grid.dataSource.read();
					//팝업종료
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
			
			lfo_common.grid.dataSource.read();
			
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//유저정보 팝업 -콜백시 유저정보를 매핑해준다.
this.lfn_ashisUserPop_open = function(){
	var callback = function(selectedItem){
		$("#" + lfo_popGrd.popId + "_form").find("[name=ashisUser]").val(selectedItem["userId"]);
		$("#" + lfo_popGrd.popId + "_form").find("[name=ashisUserNm]").val(selectedItem["userNm"]);
	}
	gfn_openCustomPop('userInfo',callback);
}

//bom 자재 선택
this.lfn_bomMtrl_get = function(){
	return gfn_ajaxCallByList("bomMtrl",{bomTarget : "prcs_bom02", itemId : lfo_common.gridSelected.itemId}).result;
}

//출하 정보 팝업 오픈
this.lfn_shipInfoForm_open = function(mode, selectedItem){
	lfo_shipInfo = {};
	
	lfo_shipInfo.popId = "shipInfoForm";
	
	lfo_shipInfo.ctrlUrl = "/cform/ship/shipMgt";
	
	lfo_shipInfo.crud = {
		read:{url:"/selectShipInfo", auth:"", prmt:{}}	
	};
	
 	var options = {
		modal:true, 
		width: "900px",
		height: "470px", 
		id : lfo_shipInfo.popId, 
		title: "출하 정보",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_shipInfoForm_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);
}

//출하 정보 팝업내용  세팅
this.lfn_shipInfoForm_set = function(mode, selectedItem){
	
	lfo_common.gridSelected = {};
	if(mode == "EDT"){
		$(".jtePopForm_onlyInsert").attr('readonly', true);
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {shipId : selectedItem};
		} 
		
		$.ajax({
			async:false,
			url : lfo_shipInfo.ctrlUrl + lfo_shipInfo.crud.read.url,
			type: "POST",
			data: {shipId :lfo_common.gridSelected.shipId, currentMenuId : $("#_currentMenuId").val()},
			success: function(data){
				gfn_popform_set(lfo_shipInfo, mode, data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//최종검사 정보 팝업 오픈
this.lfn_finalInfoForm_open = function(mode, selectedItem){

	lfo_finalInfo = {};
	
	lfo_finalInfo.popId = "finalInfoForm";
	
	lfo_finalInfo.ctrlUrl = "/cform/qualMgt/qualPec/finalQualMgt";
	
	lfo_finalInfo.crud = {
		read:{url:"/getPlcEqmtLogList", auth:"", prmt:{}}	
	};
	
 	var options = {
		modal:true, 
		width: "780px",
		height: "520px", 
		id : lfo_finalInfo.popId, 
		title: "최종 검사 정보",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_finalInfoForm_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);
}

//최종 검사 정보 팝업내용  세팅
this.lfn_finalInfoForm_set = function(mode, selectedItem){
	
	lfo_common.gridSelected = {};
	if(mode == "EDT"){
		$(".jtePopForm_onlyInsert").attr('readonly', true);
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {barcodeId : selectedItem};
		} 
		
		$.ajax({
			async:false,
			url : lfo_finalInfo.ctrlUrl + lfo_finalInfo.crud.read.url,
			type: "POST",
			data: {barcodeId :lfo_common.gridSelected.barcodeId, currentMenuId : $("#_currentMenuId").val()},
			success: function(data){
				gfn_popform_set(lfo_finalInfo, mode, data.rows[0]);
				if(data.rows[0].plcEqmtPass == true){
					$("#plcEqmtPass").val( "합" );
				} else {
					$("#plcEqmtPass").val( "불" );
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}



</script>