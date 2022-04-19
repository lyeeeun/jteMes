<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="finalQualMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="finalQualMgtForm finalQualMgtForm-jteSingleGrid"></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
</div>

<!-- 입고검사 관련문서 POP -->
<div style="display:none;">
	<div id="jteBadItemPop">   <!-- style="height:100%" -->
		<div class="pop_title">불량부품 조회</div>
		<div id="jteBadItemChkPop_grid" class="finalQualMgtForm" style="height:350px;"></div>
	</div>
</div>

<!-- 불량품 관리 팝업 -->
<div style="display:none;">
	<div id="jteBadItemChkPop" class="finalQualMgtForm">
		<form id="jteBadItemChkPop_form" class="finalQualMgtForm">
		<!-- 불량품 정보 -->
			<div class="pop_title">불량부품 정보</div>
			<table style="width:100%;" id="jteBadItemChkPop_master" class="finalQualMgtForm">
			<colgroup> <!-- 15 25 15 25 조회 버튼으로 1행 추가 -->
				<col class="col-left-title">
				<col class="col-left-content-1">
				<col class="col-left-content-2">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr>
				<!-- 불량아이디 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_badId"></spring:message> : </td>
					<td colspan="4"><input type="text" id="badId" class="center-input" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : </td>
					<td colspan="2"><input id="badCode" class="left-input" name="badCode"  format = "selBox" msg="qual_ITEMCUT"/></td> <!-- style="width: 95%; max-width:95%;" -->
				<!-- 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_quantity"></spring:message> : </td>
					<td><input id="badQty" class="right-input" name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input id="chkUserNm"class="left-input btn-input"  name="chkUserNm" format="text" readonly/>
						<input type="hidden" name="chkUser" id="chkUser"/>
					</td>
					<td><!-- 조회 -->
 						<button class="k-button k-primary search-btn" type="button" onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)">
 						<spring:message code="btn_search" /></button>
					</td>
				<!-- 검사일 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_inspectDate"></spring:message> : </td>
					<td><input id="chkDate" class="right-input" name="chkDate" format="datetimepicker"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="4"><input id="badDesc" class="center-input" name="badDesc"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="lotId" id="lotId"/>
						<!-- <input type="hidden" name="badId" id="qcBadId"/> -->
						<input type="hidden" name="badTarget" id="badTarget"/>
						<input type="hidden" name="badTargetCode" id="badTargetCode"/>
						<input type="hidden" name="itemId" id="badItemId"/>
						<input type="hidden" name="itemMgtId" id="badItemMgtId"/>
						<input type="hidden" name="use" id="bad_use"/>
						<input type="hidden" name="action" id="bad_action"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteBadItemChkPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/mtrl/mtrltoolMgt/finalQualMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
 <link href='/resources/mes/css/contents/qualMgt/qualPec/finalQualMgt/finalQualMgtForm_JJW.css' rel="stylesheet"> 

<!-- 내부 스타일 외부로 이동_200511 JJW  -->

<script>

var lfo_dateBox = {};

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_badItemGrd = {};


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	$("[name='delChk']").change(function(e){
		$("#delStat").val($("[name='delChk']:checked").val());
		lfo_common.grid.dataSource.read();
	});
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
	//lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/qualMgt/qualPec/finalQualMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getFinalQualList", auth:"", prmt:{}}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		//update:{url:"/setFinalQualSave", auth:"", openFunc : "", callback:""}
		//destroy:{url:"", auth:"", callback:""}
	};
	

	//5.
	lfo_common.model = {
		id: "itemMgtId",
		fields: {
			itemId : { type: "string" },
			itemNm : { type: "string" },
			itemType : {type: "string"},
			itemMtrl : {type: "string"},
			itemMgtId : { type: "string" },
			itemMfgDate : { type: "date" },
			itemMgtType: { type: "string" },
			itemStock: { type: "int" },
			description: { type: "string" },
			isDel: { type: "bool" }
		}
	};

	//6.
	lfo_common.columns = [
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "130px"},															//부품코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px"},															//부품명
		{field: "itemMgtId", title:gfn_getMsg("col_itemIndivCd"), width: "160px"},													//부품개별코드
		{field: "itemMgtType",  title: gfn_getMsg("col_itemIndivDiv"), width: "130px"},												//부품개별구분
		{field: "itemMfgDate", format:"{0: yyyy-MM-dd hh:mm:ss}", title:gfn_getMsg("col_manufactDate"), width: "150px"},			//제조일자
		{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
			title:gfn_getMsg("col_itemType"), width: "100px"},																		//부품유형
/* 		{field: "itemMtrl", template:"# var item = gfn_isNull(gfn_getCode(itemMtrl))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemMtrl).cdVal , gfn_getCode(itemMtrl).cdNm) # #= item #",
			title:gfn_getMsg("col_qomtrl"), width: "110px"}, */																		//재질
		{field: "itemStock", format: "{0:n0}", title:gfn_getMsg("col_indivStockQty"), width: "110px"},								//개별부품재고량
		{field: "description", title:gfn_getMsg("col_desc"), width: "250px"},
		{field: "itemMgtId", title: "불량정보", width: "120px",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_qualBadItemPop_Open(this) " style="width:60px;">불량등록</button>'
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "부품명", value: "itemInfo.item_nm" },
		{ text: "부품개별코드", value: "itemMgt.item_mgt_id" }
		//{ text: "프로젝트명", value: "spjt.PJT_NM" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}

//입고검사 관련문서 버튼 클릭(팝업 오픈)
this.lfn_qualBadItemPop_Open = function(target){
	var options = {
		modal:true, 
		width: "800px", 
		height: "395px", //200519 JJW 400-> 395
		id : "jteBadItemPop", 
		title:"불량 조회",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	
	//선택한 항목의 ID 가져옴
	lfo_common.gridSelected = { 
			itemId : dataItem.itemId,
			itemMgtId : dataItem.itemMgtId,
			itemStock : dataItem.itemStock,
			lotId : dataItem.itemMgtId
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_badItemGrd_setGrd(dataItem);
	};
	
	this.gfn_winOpen(options);
}


//입고 자재불량 그리드 
this.lfn_badItemGrd_setGrd = function(dataItem){
	lfo_badItemGrd = {};
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
	lfo_badItemGrd.layoutId = "jteBadItemChkPop_grid";
	//여기까지
	
	//2.
	lfo_badItemGrd.popId = "jteBadItemChkPop";
	
	//3.
	lfo_badItemGrd.ctrlUrl = "/cform/qualMgt/infergodsMgt"


	//4.
	lfo_badItemGrd.crud  = {
		read:{url:"/getItemBadList", auth:"", prmt:{badTargetCode : "FINAL", badTarget : "qual_spec07", itemId : dataItem.itemId, itemMgtId : dataItem.itemMgtId, lotId : dataItem.itemMgtId}},
		create:{url:"/setItemBadQualSave", auth:"", openFunc : lfn_badItemGrd_open, callback : lfn_BadItemGrd_save}, 
		update:{url:"/setItemBadQualSave", auth:"", openFunc : lfn_badItemGrd_open, callback : lfn_BadItemGrd_save}, 
		destroy:{url:"/setItemBadDelete", auth:"", callback : lfn_QualBadGrd_delete}
	};
	
	//5.
	lfo_badItemGrd.model = {
		id: "badId",
		fields: {
			badId : { type: "string" },	
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkUserNm : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badTargetNm : { type: "string" },
			badDesc : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			itemMgtId : { type: "string" },
			itemStock : { type: "int" },
			badPgUser : { type: "string" },
			badPgUserNm : { type: "string" },
			badPgDate : { type: "date" },
			badPgCd : { type: "string" },
			badPgNm : { type: "string" }
		}
	};
	
	//6.
	lfo_badItemGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "130px;"},														//불량원인
		{field: "badId", title : gfn_getMsg("col_badId"), width: "180px"},												//불량아이디
		{field: "badQty",format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "90px"},						//불량량
		{field: "itemNm", title : "부품명", width: "140px"},
		{field: "lotId", title : "부품개별코드", width: "180px"},
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badInfo"), width: "200px;"},														//불량정보
		{field: "badTargetCode", title : gfn_getMsg("col_badCd"), width: "180px"},										//불량코드
		//{field: "badPgUserNm", title : gfn_getMsg("col_worker"), width: "130px"},										//작업자
		//{field: "badPgDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_workDate"), width: "130px"},			//작업일
		{field: "chkUserNm", format: "{0:n0}", title : gfn_getMsg("col_inspector"), width: "130px"},					//검사자
		{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate"), width: "130px"},			//검사일
		//{field: "badPgNm", title : gfn_getMsg("col_progNm"), width: "180px"},											//프로그램명
		//{field: "badPgCd", title : gfn_getMsg("col_progCd"), width: "180px"}											//프로그램코드
	];
	
	//7.
	lfo_badItemGrd.selectBox = [
	
		{ text: "검사자", value: "chkUserNm" },
		{ text: gfn_getMsg("col_badId"), value: "badId" }					//불량아이디
	];
	
	//8.
	lfo_badItemGrd.validation ={
			badQty:{
			messages : "불량량을 입력하세요",
			rules : function(input){
				if(input.is("[name=badQty]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		chkDate:{
			messages : "검사일을 등록하세요",
			rules : function(input){
				if(input.is("[name=chkDate]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		chkUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=chkUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 검사자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_badItemGrd.grid = gfn_grid_set(lfo_badItemGrd);
}


//더블클릭 콜백(팝업)
this.lfn_badItemGrd_open = function(mode, dataItem){
	var options = {
		modal:true, 
		width: "600px", // 200512 JJW 불량품 관리 팝업 너비 500px -> 600px
		height: "330px", // 200512 JJW 불량품 관리 팝업 높이 250px -> 330px
		id : lfo_badItemGrd.popId, 
		//title: "",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	if(mode =="NEW"){
		options.title = "불량부품 정보등록"
	}else if(mode=="EDT"){
		options.title = "불량부품 정보수정"
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_QualBadGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_QualBadGrd_popSet = function(mode,selectedItem){
	lfo_badItemGrd.gridSelected = {};
	if(mode=='NEW'){
		//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
		selectedItem = {
				itemId : lfo_common.gridSelected.itemId,
				itemMgtId : lfo_common.gridSelected.itemMgtId,
				badTarget : "qual_spec07",
				chkDate : new Date(),
				chkUserNm : $("#_loginUserName").val(),
				chkUser : $("#_loginUserId").val(),
				//badId : $("#qcBadId").val(),
				lotId : lfo_common.gridSelected.lotId
		}
		gfn_popform_set(lfo_badItemGrd, mode, selectedItem);
		
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_badItemGrd.gridSelected = selectedItem;
		}else if(typeof(selectedItem) == "string"){
			lfo_badItemGrd.gridSelected = selectedItem;
		}
		$.ajax({
			async:false,
			url : lfo_badItemGrd.ctrlUrl + lfo_badItemGrd.crud.read.url,
			type: "POST",
			data: {badId :lfo_badItemGrd.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_badItemGrd, mode ,data.rows[0]);
				
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_BadItemGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_badItemGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_badItemGrd.popId+"_form").serializeObject();
 		savePrmt.badTarget = $("#badTarget").val();
		savePrmt.badId = $("#badId").val(); 
		savePrmt.itemId = $("#badItemId").val();
		savePrmt.itemMgtId = $("#badItemMgtId").val();
		//저장된 다국어가 있다면 추가
		
		var msgId = $("#"+lfo_badItemGrd.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_badItemGrd.ctrlUrl + lfo_badItemGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					
					lfo_badItemGrd.grid.dataSource.read();
					
					lfo_common.grid.dataSource.read();
					
					gfn_closePop(lfo_badItemGrd.popId);
					
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
this.lfn_QualBadGrd_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_badItemGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_badItemGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	
	$.ajax({
		async:false,
		url : lfo_badItemGrd.ctrlUrl + lfo_badItemGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//내역보기 팝업 리로드
			lfo_badItemGrd.grid.dataSource.read();
			
			//마스터그리 리로드
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

this.lfn_badUserInfoPop_callback = function(rtnObj){
	$("#" + lfo_badItemGrd.popId + " [name=chkUser]").val(rtnObj["userId"]);
	$("#" + lfo_badItemGrd.popId + " [name=chkUserNm]").val(rtnObj["userNm"]);
}

</script>