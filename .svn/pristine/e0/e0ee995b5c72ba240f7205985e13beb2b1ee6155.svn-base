<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="compMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="compMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="compMgtForm">
		<!-- 업체정보 -->
			<div class="pop_title"><spring:message code = "pop_compInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
			<colgroup>
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr><td colspan="4"></td></tr>					
				<tr>
				<!-- 업체코드 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_compCd"></spring:message> : </td>
					<td><input type="text" id="compId" class="left-input" name="compId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동 입력 -->
				<!-- 업체유형 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compType"></spring:message> : </td>
					<td><input id="compType" class="right-input" name="compType" format="selBox" msg="corp_div"/></td>
				</tr>
				<tr>
				<!-- 업체명 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_compNm"></spring:message> : </td>
					<td>
						<input type="text" id="compNm" class="left-input" name="compNm" format="text"/>
					</td>
				<!-- 업체약어 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compInitials"></spring:message> : </td>
					<td>
						<input type="text" id="compInitials" class="right-input" name="compInitials" format="text"/>
					</td>
<%-- 					<td>
						<button class="k-button k-primary jte-msgBox " type="button" prefix = "comp" defId="compId" defNm="compNm" >
				<!-- 다국어 -->
						<spring:message code = "pop_msgLang"></spring:message></button>
						<input type="hidden" id="msg_compId" />
					</td> --%>
				</tr>
				<tr>
				<!-- 관리자 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_manager"></spring:message> : </td>
					<td><input type="text" id="compManagr" class="left-input" name="compManagr" format="text" /></td>
				<!-- 업체번호 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNum"></spring:message> : </td>
					<td><input type="text" id="compNumber" class="right-input" name="compNumber" format="text" /></td>
				</tr>
				<tr>
				<!-- 업체주소 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compAddr"></spring:message> : </td>
					<td colspan="4"><input type="text" id="compAddr" class="center-input" name="compAddr" format="text" /></td>
				</tr>
				<tr>
				<!-- 비고 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="4"><input type="text" id="description" name="description" class="k-textbox center-input"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="comp_action"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		<!-- 업체주소 -->
		<div class="pop_title"><spring:message code = "pop_compAddr"></spring:message></div>
		<div id="jtePopForm_grid" class="compMgtForm"></div>
	</div>
</div>

<!-- 팝업(마스터그리드 > 팝업창 내부 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopAddForm">
		<form id = "jtePopAddForm_form" class="compMgtForm">
			<table id="jtePopAddForm_master" class="jtePopAddForm_master">
			<colgroup>
				<col class="popsc-col-left-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr><td colspan="4"></td></tr>							
				<tr>
				<!-- 업체주소코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compAddrCd"></spring:message> : </td>
					<td>
						<input type="text" id="compAddrId" class="normal-input" name="compAddrId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/>			<!-- 자동 입력 -->
						<input type="hidden" id="compId" name="compId">
					</td>
					
				</tr>
				<tr>
				<!-- 업체상세주소 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compDetailAddr"></spring:message> : </td>
					<td>
						<input type="text" id="compAddrDetail" class="normal-input" name="compAddrDetail"/>
					</td>
				</tr>
				<tr>
				<!-- 담당자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager"></spring:message> : </td>
					<td>
						<input type="text" id="compAddrUser" class="normal-input" name="compAddrUser" format="text"/>
					</td>
				</tr>
				<tr>
				<!-- 업체번호 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNum"></spring:message> : </td>
					<td>
						<input type="text" id="compAddrNumber" class="normal-input" name="compAddrNumber" format="text"/>
					</td>
				</tr>
				<tr>
				<!-- 비고 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td>
						<input type="text" id="compDesc" class="normal-input" name="compDesc" format="text"/>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="compAddr_action"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/compMgt/compMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/operMgt/compMgt/compMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200410 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

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
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/compMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getCompList", auth:"", prmt:{}}, 
		create:{url:"/setCompSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setCompSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		destroy:{url:"/setCompDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "compId",
		fields: {
			compId: { type: "string" },
			compNm: { type: "string" },
			compInitials: { type: "string" },
			compManagr: { type: "string" },
			compNumber: { type: "string" },
			compType: { type: "string" },
			compAddr: { type: "string" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			description: { type: "string" },
			isUse: { type: "bool" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"40px"},
		{field: "compId", title:gfn_getMsg("col_compCd"), width: "120px"},											//업체코드
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "220px"},											//업체명
		{field: "compInitials", title:gfn_getMsg("col_compInitials"), width: "150px"},								//업체약어
		{field: "compType", template:"# var item = gfn_isNull(gfn_getCode(compType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(compType).cdId , gfn_getCode(compType).cdNm) # #= item #", 
			title:gfn_getMsg("col_compType"), width: "90px;"},														//업체유형
		{field: "compManagr", title:gfn_getMsg("col_manager"), width: "130px"},										//관리자
		{field: "compNumber", title:gfn_getMsg("col_compNum"), width: "130px"},										//업체번호
		{field: "compAddr", title:gfn_getMsg("col_compAddr"), width: "300px"},										//업체주소
		{field: "description", title:gfn_getMsg("col_desc"), width: "350px"},										//비고
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"110px",			//사용유무
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic")+" : Y";														//기본
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },				//업체명
		{ text: gfn_getMsg("col_compCd"), value: "compInfo.comp_id" },				//업체코드
		{ text: gfn_getMsg("col_manager"), value: "compInfo.comp_managr" },			//관리자
		{ text: gfn_getMsg("col_compNum"), value: "compInfo.comp_number" },			//업체번호
		{ text: gfn_getMsg("col_compAddr"), value: "compInfo.comp_addr" },			//업체주소
		{ text: gfn_getMsg("col_desc"), value: "compInfo.description" }				//비고
	];
	
	//8.
	lfo_common.validation ={
		compNm:{
			messages : "업체명을 입력하세요",
			rules : function(input){
				if(input.is("[name=compNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		compManagr:{
			messages : "담당자명을 입력하세요",
			rules : function(input){
				if(input.is("[name=compManagr]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		compInitials:{
			messages : "업체 약어를 입력하세요.",
			rules : function(input){
				if(input.is("[name=compInitials]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "705px", 
		height: "580px",  /** 200428 첫번째 팝업 높이 변경 565px->600px_LYM **/ /* 200518 JJW 565px -> 600px */ /* 201012 JJW 650 -> 580px*/
		id:lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_compRegist");			//업체 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_compSrh");				//업체 조회
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem["compId"];
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {compId:lfo_common.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
				lfo_common.gridSelected = {compId : data.rows[0].compId};
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	//그리드 세팅
	if($("#jtePopForm_grid").html() ==""){
		lfn_jtePopGrd_setGrd();
	}else{
		lfo_popGrd.grid.dataSource.read();
	}
	
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		//저장된 다국어가 있다면 추가
		
		var msgId = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					lfn_jtePop_set('EDT',data);
					lfo_common.grid.dataSource.read();
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
this.lfn_jteGrid_delete = function(){
	var delPrmt = [];

	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_common.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//사용유무
this.lfn_jteSgGrd_changeIsUse = function(rows){
	
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {compId : dataItem.compId, action : "USE", use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.update.url,
		type: "POST",
		data: JSON.stringify(prmt),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				lfo_common.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
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
	lfo_popGrd.ctrlUrl = "/cform/basMgt/operMgt/compMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getCompAddrList", auth:"", prmt:lfo_common.gridSelected}, 
		create:{url:"/setCompAddrSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save}, 
		update:{url:"/setCompAddrSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save}, 
		destroy:{url:"/setCompAddrDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "compAddrId",
		fields: {
			compId : { type: "string" },
			compAddrId : { type: "string" },
			compAddrDetail : { type: "string" },
			compAddrUser : { type: "string" },
			compAddrNumber : { type: "string" },
			compDesc : { type: "string" },
			createdAt : { type: "string" },
			updatedAt : { type: "string" },
			creatorId : { type: "string" },
			updatorId : { type: "string" },
			isUse : { type: "bool" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "compAddrId", title:gfn_getMsg("col_compAddrCd"), width: "170px;"},									//업체주소코드
		{field: "compAddrDetail", title:gfn_getMsg("col_compDetailAddr"), width: "300px;"},							//업체상세주소
		{field: "compAddrUser", title:gfn_getMsg("col_manager"), width: "130px;"},									//관리자
		{field: "compAddrNumber", title:gfn_getMsg("col_compNum"), width: "150px;"},								//업체번호
		{field: "compDesc", title:gfn_getMsg("col_desc"), width: "220px;"},											//비고
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"110px",			//사용유무
				template : function(rows) {
					if(rows.use == true){
						return "<a onclick='lfn_jtePopGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
					}else if (rows.use == false){
						return "<a onclick='lfn_jtePopGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
					}else{
						return ""+gfn_getMsg("val_basic")+" : Y";													//기본
					}
				}
		}
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_compAddrCd"), value: "compAddr.comp_addr_id" },					//업체주소코드
		{ text: gfn_getMsg("col_compDetailAddr"), value: "compAddr.comp_addr_detail" },			//업체상세주소
		{ text: gfn_getMsg("col_manager"), value: "compAddr.comp_addr_user" },					//관리자
		{ text: gfn_getMsg("col_compNum"), value: "compAddr.comp_addr_number" },				//업체번호
		{ text: gfn_getMsg("col_desc"), value: "compAddr.comp_desc" }							//비고
	];
	
	//8.
	lfo_popGrd.validation ={
		compAddrUser:{
			messages : "담당자명을 입력하세요",
			rules : function(input){
				if(input.is("[name=compAddrUser]")){
					return input.val().length != 0 ;
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "480px", // 200512 JJW 430px -> 480px
		height: "367px", /** 200428 두번째 팝업 높이 변경 230px->335px_LYM 200512 JJW 230px -> 350px 200810 youmi 350->367px**/
		id:lfo_popGrd.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_compAddrRegist");			//업체주소 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_compAddrSrh");				//업체주소 조회
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	lfo_popGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {compId : lfo_common.gridSelected.compId}
		gfn_popform_set(lfo_popGrd, mode,selectedItem);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_popGrd.gridSelected = {compId :selectedItem["compId"], compAddrId :selectedItem["compAddrId"]};
		}else if(typeof(selectedItem) == "string"){
			lfo_popGrd.gridSelected = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.read.url,
			type: "POST",
			data: {compId:lfo_popGrd.gridSelected.compId, compAddrId:lfo_popGrd.gridSelected.compAddrId},
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
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		
		//저장된 다국어가 있다면 추가
		var msgBox = $("#"+lfo_popGrd.popId+"_form").find(".jte-msgBox").val();
		if(!gfn_isNull(msgBox)){
			savePrmt.msgList = JSON.parse(msgBox);
		}
		
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
					
					//팝업종료
					gfn_closePop(lfo_popGrd.popId);
					
					//마스터 그리드 리로드
					lfo_common.grid.dataSource.read();
					//이전 팝업화면 리로드
					lfn_jtePop_set('EDT',lfo_common.gridSelected);
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
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//사용유무
this.lfn_jtePopGrd_changeIsUse = function(rows){
	var dataItem = lfo_popGrd.grid.dataItem($(rows).closest("tr"));
	var prmt = {compId : dataItem.compId, compAddrId : dataItem.compAddrId, action : "USE", use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.update.url,
		type: "POST",
		data: JSON.stringify(prmt),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != 0){
				lfo_popGrd.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
</script>