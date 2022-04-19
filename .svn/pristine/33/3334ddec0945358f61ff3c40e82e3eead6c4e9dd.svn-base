<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="mqsToolMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<input type="text" class="k-textbox" id="itemNm" readonly/>
		<input type="hidden" id="itemId">
		<button class="k-button k-primary page-search-btn" type="button" onclick= "lfn_itemInfo();"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="mqsToolMgtForm-grid" style="width:100%;"> <!-- style="width: 100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="shipPlanPop">
		<div id="shipPlanInfo_grid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="toolListPop">
		<div id="toolListPop_grid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="toolRegForm" class="toolRegForm">
		<form id="toolRegForm_form" class="mqsToolMgtForm" >
			<table id="toolRegForm_master" class="BasicTable">  <!-- style="width:100%;" -->
				<colgroup>
					<col style="width:20%;">
					<col style="width:29%;">
					<col style="width:22%;">
					<col style="width:29%;">
				</colgroup>
				<tr><td colspan="4"></td></tr>					
				<tr>
				<!-- 기술문서 그룹 구분 -->
					<td><i class="fas fa-caret-right"></i>TOOL NO : </td>
					<td>
						<input id="toolNo" name="toolNo"/>
						<input type="hidden" name="action" id="mqsToolInfoAction" type="text"/>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>TOOL 물품번호 : </td>
					<td><input id="toolId" name="toolId" class="btn-input" readonly/>
					<button class="k-button k-primary popsc-btn" type="button" onclick = "lfn_toolInfo('tool')">조회</button></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>TOOL 명칭 : </td>
					<td><input id="toolNm" name="toolNm" type="text" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i>TOOL 사양 : </td>
					<td><input id="toolDc" name="toolDc" type="text" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>특기사항 : </td>
					<td><input id="specialDc" name="specialDc" type="text"/></td>
					<!-- 기술문서 그룹 구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i>HOLDER 물품번호 : </td>
					<td><input id="holderId" name="holderId" class="btn-input" readonly/>
					<button class="k-button k-primary popsc-btn" type="button" onclick = "lfn_toolInfo('holder')">조회</button></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>HOLDER 명칭 : </td>
					<td><input id="holderNm" name="holderNm" type="text" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i>HOLDER 사양 : </td>
					<td><input id="holderDc" name="holderDc" type="text" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>INSERT DC : </td>
					<td><input id="insertDc" name="insertDc" type="text"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>날수 : </td>
					<td><input id="insertQty" name="insertQty" format="currency"/></td>
				</tr>
				<tr><td colspan="4"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right left-caret"></i>총 공구 길이 <b>(최대)</b> : </td>
					<td><input id="toolTLengthU" name="toolTLengthU" format="numeric"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>총 공구 길이 <b>(최소)</b> : </td>					
					<td><input id="toolTLengthL" name="toolTLengthL" format="numeric"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>날장 길이 <b>(최대)</b> : </td>
					<td><input id="toolWlengthU" name="toolWlengthU" format="numeric"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>날장 길이 <b>(최소)</b> : </td>					
					<td><input id="toolWlengthL" name="toolWlengthL" format="numeric"/></td>
				</tr>
				<tr><td colspan="4"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>교환주기 <b>(가공수량)</b> : </td>
					<td><input id="toolChange" name="toolChange" format="currency"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>공구 직경 <b>(최소)</b> : </td>
					<td><input id="toolDia" name="toolDia" format="numeric"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>OFFSET NO <b>(H)</b> : </td>
					<td><input id="offsetH" name="offsetH" type="text"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>OFFSET NO <b>(D)</b> : </td>					
					<td><input id="offsetD" name="offsetD" type="text"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>Special Note : </td>
					<td colspan="3"><input id="specialPic" name="specialPic" type="text"/></td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('toolRegForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<div style="display:none;">
	<div id="toolInfoForm" class="toolInfoForm"> <!-- MAVST > 차수 1에서 확인 가능_200806 youmi -->
		<form id="toolInfoForm_form" class="mqsToolMgtForm" >
			<table id="toolInfoForm_master" class="BasicTable">  <!-- style="width:100%;" -->
				<colgroup>
					<col style="width:22%;">
					<col style="width:27%;">
					<col style="width:24%;">
					<col style="width:27%;">
				</colgroup>
				<tr><td colspan="4"></td></tr>					
				<tr>
					<td><i class="fas fa-caret-right"></i>INSERT DC : </td>
					<td><input id="insertDc" name="insertDc" type="text" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i>날수 : </td>
					<td><input id="insertQty" name="insertQty" type="text" readonly/></td>
				</tr>
				<tr><td colspan="4"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right left-caret"></i>총 공구 길이 <b>(최대)</b> : </td>
					<td><input id="toolTLengthU" name="toolTLengthU" type="text" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>총 공구 길이 <b>(최소)</b> : </td>					
					<td><input id="toolTLengthL" name="toolTLengthL" type="text" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>날장 길이 <b>(최대)</b> : </td>
					<td><input id="toolWlengthU" name="toolWlengthU" type="text" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i>날장 길이 <b>(최소)</b> : </td>					
					<td><input id="toolWlengthL" name="toolWlengthL" type="text" readonly/></td>
				</tr>
				<tr><td colspan="4"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>교환주기 <b>(가공수량)</b> : </td>
					<td><input id="toolChange" name="toolChange" type="text" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i>공구 직경 <b>(최소)</b> : </td>
					<td><input id="toolDia" name="toolDia" type="text" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>OFFSET NO <b>(H)</b> : </td>
					<td><input id="offsetH" name="offsetH" type="text" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i>OFFSET NO <b>(D)</b> : </td>					
					<td><input id="offsetD" name="offsetD" type="text" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>Special Note : </td>
					<td colspan="3"><input id="specialPic" name="specialPic" type="text" readonly/></td>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- CSS -->
<link href='/resources/mes/css/contents/techMgt/mqsToolMgt/mqsToolMgtForm.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	lfn_eventBind();
	
};

this.lfn_itemInfo = function() {
	var callback = function(selectedItem){
		$('#jteSingleGrid').empty();
		$('#itemId').val(selectedItem.itemId);
		$('#itemNm').val(selectedItem.itemNm);
		
		lfn_jteSgGrd_setGrd();
	};
	gfn_openCustomPop('item', callback);
}

this.lfn_toolInfo = function(target) {
	var callback = function(selectedItem){
		$('#' + target + 'Id').val(selectedItem.toolId);
		$('#' + target + 'Nm').val(selectedItem.toolNm);
		$('#' + target + 'Dc').val(selectedItem.toolDc);
	};
	
	gfn_openCustomPop('tool', callback);
}

this.lfn_eventBind = function(){/* 
	$("#techDocGroupC").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_gridSearch();
		}
	}); */
}

this.lfn_gridSearch = function(){
	lfo_common.grid.dataSource.query({
		page: 1,
		pageSize: 10
	});
}

// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_common = {};//Form 내부에서 사용될 Object
	lfo_common.count = 0;
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
		6. gridObject.columns = fieldColumns
		7. gridObject.selectBox = SelectBox 매핑 값 
	*/
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "toolListPop";
	
	//3.
	lfo_common.ctrlUrl = "/form/techMgt/mqsToolMgt";

	//4.
	lfo_common.crud  = {
		//create:{url:"/setMtrlMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave},
		read:{url:"/selectMqsRoutingInfo", auth:"", prmt:{}, dynamicPrmt:{itemId: "itemId"}, search : false}
	};
	
	//5.
	lfo_common.model = {
		fields: {
			itemId : { type: "string" },
			itemNm : { type: "string" },
			routingId : { type: "string" },
			routingType : { type: "string" },
			routingSeq : { type: "int" },
			ncpgmNo : { type: "string" },
			manHour : { type: "int" },
			description : { type: "string" },
			cycleTime: { type: "int" },
			setupTime: { type: "int" },
			inspectTime: { type: "int" }
		},
	};
	
	//6.
	lfo_common.columns = [
		{field: "itemId", title: "제품 번호", width: "140px"},
		{field: "itemNm", title: "제품 명칭", width: "140px"},
		{field: "routingSeq", title: "차수", width: "160px"},
		{field: "routingType", title: "공정", 
			template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #", width: "130px"},
		{field: "ncpgmNo", title: "NC PGMNO", width: "130px"},
		{field: "cycleTime", title: "Cycle Time", width: "130px"},		
		{field: "setupTime",  title: "Setup Time", width: "130px"},			
		{field: "inspectTime", title: "Inspect Time", width: "130px"},				
		{field: "toolDetailInfo", title: "공구 상세 정보", width:"150px",		 
			template : function(rows) {
				return "<button class='k-button k-primary' type='button' onclick='lfn_toolList_popOpen(this)'>관련 공구 설정</button>";			//관련 공구 정보 입력
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}

this.lfn_toolList_popOpen = function(rows){
	var options = {
		modal:true, 
		width: "1350px", /* JJW 20.11.13 1500 -> 1350 */
		height: "470px", //200520 JJW 470->
		id: lfo_common.popId, 
		title:"MQS공구정보 관리",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_toolListPop_setGrid($("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest('tr')));
		$('#toolListPop_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}

this.lfn_toolListPop_setGrid = function(selectedItem){
	
	lfo_toolListGrd = {};
	
	lfo_toolListGrd.routingId = selectedItem.routingId;
	//1.
	lfo_toolListGrd.layoutId = "toolListPop_grid";
	
	//2.
	lfo_toolListGrd.popId = "toolRegForm";
	
	//3.
	lfo_toolListGrd.ctrlUrl = "/form/techMgt/mqsToolMgt";
	
	//4.
	lfo_toolListGrd.crud  = {
		read:{url: "/selectMqsToolInfo", auth:"", prmt:{ routingId: lfo_toolListGrd.routingId }, search: false},
		create:{url:"/saveMqsToolInfo", auth:"", openFunc: lfn_toolRegPop_open, callback: lfn_toolRegPop_save},
		update:{url:"/saveMqsToolInfo", auth:"", callback: lfn_toolRegPop_save}
	};
	
	//5.
	lfo_toolListGrd.model = {
		fields: {
			routingId : { type: "string" },
			toolNo : { type: "string" },
			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolDc : { type: "string" },
			holderId : { type: "string" },
			holderNm : { type: "string" },
			holderDc : { type: "string" },
			insertQty : { type: "string" },
			insertDc : { type: "string" },
			cornerQty : { type: "int" },
			toolTLengthU : { type: "float" },
			toolTLengthL : { type: "float" },
			toolWlengthU : { type: "float" },
			toolWlengthL : { type: "float" },
			toolDia : { type: "float" },
			toolChange : { type: "int" },
			offsetH : { type: "string" },
			offsetD : { type: "string" },
			specialDc : { type: "string" },
			specialPic : { type: "string" }
		}
	};
	
	//6.
	lfo_toolListGrd.columns = [
		{field: "toolNo", title:"TOOL NO", width: "120px;"},			//포장 수량
		{field: "toolId", title:"TOOL 물품번호", width: "120px;"},			//포장 수량
		{field: "toolNm", title:"TOOL 명칭", width: "120px;"},			//포장 수량
		{field: "toolDc", title:"TOOL 사양", width: "120px;"},			//포장 수량
		{field: "holderId", title:"HOLDER 물품번호", width: "120px;"},			//포장 수량
		{field: "holderNm", title:"HOLDER 명칭", width: "120px;"},			//포장 수량
		{field: "holderDc", title:"HOLDER 사양", width: "120px;"},			//포장 수량
		{field: "detailInfo", title:"상세 정보", width: "120px;",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolRegPop_open(\'INFO\',this); " style="min-width:60px;">' + "상세 정보" + '</button>'
		},
		{field: "editOption", title:"수정", width: "120px;",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolRegPop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'
		}
	];
	
	//공통 그리드 세팅 호출
	lfo_toolListGrd.grid = gfn_grid_set(lfo_toolListGrd);
}


this.lfn_toolRegPop_open = function(mode, rows){
	
	var popHeight = "580px"; //200806 그리드의 관련공구 설정 버튼 클릭 → 추가 버튼 클릭 시의 팝업창 height 변경_700->590px->580px 200821 youmi
	if(mode == "INFO") {
		lfo_toolListGrd.popId = "toolInfoForm";
		popHeight = "360px"; //200806 그리드의 관련공구 설정 버튼 클릭 → 상세 정보 버튼 클릭 시의 팝업창 height 변경_300->360px youmi
	} else {
		lfo_toolListGrd.popId = "toolRegForm"; 
	}
	
	//초기화
 	var options = {
		modal: true, 
		width: "1000px",
		height: popHeight,  
		id : lfo_toolListGrd.popId, 
		title: "공구 정보",
		resizable: true,
		animation: {open :{effects:"expand:vertical fadeIn"},
		close : {effects:"expand:vertical fadeIn", reverse: true}},
		actions: [/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(mode == "INFO") {
			gfn_popform_set(lfo_toolListGrd, mode, $("#toolListPop_grid").data("kendoGrid").dataItem($(rows).closest('tr')));
		} else {
			gfn_popform_set(lfo_toolListGrd, mode, $("#toolListPop_grid").data("kendoGrid").dataItem($(rows).closest('tr')));
			
			if(mode == "EDT") {
				$('#toolNo').attr('readonly', true);
			}
		}
	};
	this.gfn_winOpen(options);
}

this.lfn_toolRegPop_save = function(mode){
	var formId = lfo_toolListGrd.popId+"_form";
	var savePrmt = gfn_serializeObject(formId);
	
	savePrmt.routingId = lfo_toolListGrd.routingId;
	
	if(mode == "create"){
		var validationYn = lfn_validationCheck(savePrmt);
		
		if(validationYn) return false;
	}
	
	$.ajax({
		async:false,
		url : lfo_toolListGrd.ctrlUrl + lfo_toolListGrd.crud[mode].url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_toolListGrd.grid.dataSource.read();
			
			gfn_closePop(lfo_toolListGrd.popId);
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

this.lfn_validationCheck = function(pSavePrmt) {
	var key = {routingId: pSavePrmt.routingId, toolNo: pSavePrmt.toolNo};
	
	var flag;
	$.ajax({
		async:false,
		url : lfo_toolListGrd.ctrlUrl + '/selectDupleKeyCheck',
		type: "POST",
		data: JSON.stringify(key),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			flag = data;
		},error: function(ex){
			gfn_loading(false);
		}
	});
	
	if(flag) {
		kendo.confirm("Tool No 값이 이미 존재합니다.");
		return flag;
	}
	
	if(gfn_isEmpty(pSavePrmt.toolId) || gfn_isEmpty(pSavePrmt.holderId)) {
		kendo.confirm("TOOL 또는 HOLDER를 선택하여 주십시오.");
		return true;
	}
	
	return flag;
}


</script>