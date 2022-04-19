<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="facilMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="facilMgtForm"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="facilMgtForm" enctype="multipart/form-data">
			<div class="pop_title"><spring:message code = "pop_eqmtInfo"></spring:message></div> <!-- 설비정보 -->
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:30%;">
				<col style="width:22%;">
				<col style="width:30%;">
			</colgroup>
				<tr>
				<!-- 설비코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtCd"></spring:message> : </td>
					<td><input type="text" id="eqmtMgtId" name="eqmtMgtId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동 입력 -->
				<!-- 설비구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtDiv"></spring:message> : </td>
					<td><input id="eqmtGbn" name="eqmtMgtGbn"  format = "selBox" msg="eqmt_div"/></td>
				</tr>
				<tr>
				<!-- 설비명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtDetailNm"></spring:message> : </td>
					<td><input type="text" id="eqmtMgtNm" name="eqmtMgtNm" format="text"/>
<%-- 					
						<button class="k-button k-primary jte-msgBox" type="button" prefix = "eqmgt" defId="eqmtMgtId" defNm="eqmtMgtNm" >
				<!-- 다국어 -->
						<spring:message code = "pop_msgLang"></spring:message></button>
						<input type="hidden" id="msg_eqmtMgtId" />--%>
					</td> 
				<!-- 정비주기 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtnc"></spring:message> : </td>
					<td><input id="eqmtMgtMtnc" name="eqmtMgtMtnc" format="currency" /></td>
				</tr>
				
				<%--
				<tr>
				
				<!-- 예비1 -->
					<td><i class="fas fa-caret-right"></i>예비1 :</td>
					<td><input type="text" id="eqmtMgtStd01" class="left-input" name="eqmtMgtStd01" format="numeric"/></td>
				<!-- 예비1(str) -->
					<td><i class="fas fa-caret-right"></i>예비1(str) :</td>
					<td><input type="text" id="eqmtMgtStdStr01" class="right-input" name="eqmtMgtStdStr01"  /></td>
				</tr>
				 --%>
				
				<tr>
				<!-- 수령일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate"></spring:message> : </td>
					<td><input id="eqmtMgtPurchase" name="eqmtMgtPurchase" format="datepicker"  /></td>
				<!-- 검증기간 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_verifyPeriod"></spring:message>
				<!-- 값을 입력하지 않으면 등록된 정비주기로 계산됩니다. -->
					<i class="fas fa-info-circle jte-tooltip" title="<spring:message code = "pop_noValEnter"></spring:message>"></i> :
					</td>
					<td><input id="eqmtMgtVerif" name="eqmtMgtVerif" format="datepicker"/></td>
				</tr>
				<tr>
				<!-- 상태 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_eqmtState"></spring:message> : </td>
					<td><input id="eqmtMgtStdStr01" name="eqmtMgtStdStr01"  format = "selBox" msg="eqmt_state"/></td>
				</tr>
				<tr>
				<!-- 첨부파일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_attachment"></spring:message> : </td>
					<td colspan="3">
						<input name="attachFile" type="file" format="file" code="eqmtMgtId" />
						<input type="hidden" id="insertAttach" value = "[]"/>
						<input type="hidden" id="deleteAttach" value = "[]"/>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="eqmtMgtDesc" name="eqmtMgtDesc" class="k-textbox"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="action"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area facilMgtForm-final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn jte-update" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/facilMgt/facilMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/operMgt/facilMgt/facilMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200428 LYM  -->

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
	lfo_common.ctrlUrl = "/form/basMgt/operMgt/facilMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getEqmtMgtList", auth:"", prmt:{}}, 
		create:{url:"/setEqmtMgtSave", auth:"", openFunc : lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setEqmtMgtSave", auth:"", openFunc:"", callback:lfn_popSave}, 
		destroy:{url:"/setEqmtMgtDelete", auth:"", callback:lfn_jteGrid_delete}
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
			compNm : { type: "string" },
			eqmtMgtStd01: { type: "int" },
			eqmtMgtStd02: { type: "int" },
			eqmtMgtStd03: { type: "int" },
			eqmtMgtStd04: { type: "int" },
			eqmtMgtStd05: { type: "int" },
			eqmtMgtStdStr01: { type: "string" },
			eqmtMgtStdStr02: { type: "string" },
			eqmtMgtStdStr03: { type: "string" },
			eqmtMgtStdStr04: { type: "string" },
			eqmtMgtStdStr05: { type: "string" }
			
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "compAddr",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\', this); " style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update"), width: 90},	
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: "150px"},											//설비개별코드
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtNm"), width: "170px"},												//설비명
		{field: "eqmtMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(eqmtMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(eqmtMgtGbn).cdId , gfn_getCode(eqmtMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_eqmtDiv"), width: "130px;"},											//설비구분
		{field: "eqmtMgtStdStr01", template:"# var item = gfn_isNull(gfn_getCode(eqmtMgtStdStr01))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(eqmtMgtStdStr01).cdId , gfn_getCode(eqmtMgtStdStr01).cdNm) # #= item #", 
				title:gfn_getMsg("col_eqmtState"), format: "{0:n}", width: "100px"},							//상태	
		{field: "eqmtMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "120px"},			//입고일
		{field: "eqmtMgtVerif" , format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: "120px"},			//검증기간
		{field: "eqmtMgtMtnc", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_mtnc"), width: "100px"},								//정비주기(일)
		{field: "eqmtMgtFile", title:gfn_getMsg("col_attachment"), width: "110px"},											//첨부파일
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc"), width: "300px"},												//설명
/* 		{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: "120px"},
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "130px"},
		
		{field: "eqmtMgtStd02", title:"예비2", format: "{0:n}", width: "100px"},
		{field: "eqmtMgtStd03", title:"예비3", format: "{0:n}", width: "100px"},
		{field: "eqmtMgtStd04", title:"예비4", format: "{0:n}", width: "100px"},
		{field: "eqmtMgtStd05", title:"예비5", format: "{0:n}", width: "100px"},
		{field: "eqmtMgtStdStr01", title : "예비1(Str)", width: "100px"},
		{field: "eqmtMgtStdStr02", title : "예비2(Str)", width: "100px"},
		{field: "eqmtMgtStdStr03", title : "예비3(Str)", width: "100px"},
		{field: "eqmtMgtStdStr04", title : "예비4(Str)", width: "100px"},
		{field: "eqmtMgtStdStr05", title : "예비5(Str)", width: "100px"}, */
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"100px",					//사용유무
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic")+" : Y";																//기본
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_eqmtNm"), value: "eqmtMgt.eqmt_mgt_nm" },				//설비명
		{ text: gfn_getMsg("col_eqmtIndivCd"), value: "eqmtMgt.eqmt_mgt_id" },			//설비개별코드
		{ text: gfn_getMsg("col_placeNm"), value: "place.place_nm" },					//위치명
		{ text: gfn_getMsg("col_compNm"), value: "comp.comp_nm" },						//업체명
		{ text: gfn_getMsg("col_desc"), value: "eqmtMgt.eqmt_mgt_desc" }				//설명
	];
	
	//8.
	lfo_common.validation ={
		eqmtMgtNm:{
			messages : "설비명을 입력하세요",
			rules : function(input){
				if(input.is("[name=eqmtMgtNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		eqmtMgtPurchase:{
			messages : "수령일을 입력하세요",
			rules : function(input){
				if(input.is("[name=eqmtMgtPurchase]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		compId:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=compId]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 업체명을 등록해주세요");
						return false;
					}
				}
				return true;
			}
		},
		placeId:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=placeId]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 위치명을 등록해주세요");
						return false;
					}
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
		width: "760px", //200506 JJW 팝업 너비 변경 600-> 660
		height: "485px", /** 200911 youmi 427->467 JJW 467 -> 515_201112 YUMI 515->478 **/
		id : lfo_common.popId, 
		//title: gfn_getMsg("pop_addPop")
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]  
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_eqmtRegist");			//설비 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_eqmtUpdate");			//설비 수정
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
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {eqmtMgtId : selectedItem};
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {eqmtMgtId :lfo_common.gridSelected.eqmtMgtId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	//그리드 세팅
// 	if($("#jtePopForm_grid").html() ==""){
// 		lfn_jtePopGrd_setGrd();
// 	}else{
// 		lfo_popGrd.grid.dataSource.read();
// 	}
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		var formId = lfo_common.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);
		
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
					gfn_closePop(lfo_common.popId);
					//lfn_jtePop_set('EDT',data);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}
//사용유무
this.lfn_jteSubGrd_changeIsUse = function(rows){
	
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {eqmtMgtId : dataItem.eqmtMgtId, action : "USE", use : dataItem.use};
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
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
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
		},
		error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

this.lfn_compPop_callback = function(callbackObj){
	$("[name='compId']").val(callbackObj.compId);
	$("[name='compNm']").val(callbackObj.compNm);
}

//위치정보 팝업 콜백
this.lfn_placePop_callback = function(callbackObj){
	$("[name='placeId']").val(callbackObj.placeId);
	$("[name='placeNm']").val(callbackObj.placeNm);
}
</script>
