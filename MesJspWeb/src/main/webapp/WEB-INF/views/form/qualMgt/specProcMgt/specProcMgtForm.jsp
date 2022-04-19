<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 마스터 그리드 영역 -->
<div id="grid-content" style="width:100%;">
	<div id="jteSingleGrid"></div>
</div>
<!-- 팝업(마스터 그리드> 더블클릭)  -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="specProcMgtForm">
			<div class="pop_title">SPC 정보</div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master specProcMgtForm">
			<colgroup>
				<col class="pop-col-left-title">
				<col class="pop-col-left-content-1">
				<col class="pop-col-left-content-2">
				<col class="pop-col-right-title">
				<col class="pop-col-right-content-1">
				<col class="pop-col-right-content-2">
			</colgroup>
				<tr>
					<!-- 코드  -->
					<td><i class="fas fa-caret-right"></i>코드 : </td>
					<td colspan="2"><input type="text" id="spcId" class="left-input" name="spcId" format="text" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly /></td>
					<!-- 프로젝트명  -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i>프로젝트 명 : </td>
					<td colspan="2"><input type="text" id="spcNm" class="right-input" name="spcNm" format="text" /></td>
				</tr>
				<tr>
					<!-- 품목  -->
					<td><i class="fas fa-caret-right"></i>품목 아이디 : </td>
					<td>
						<input type="text" id="spcItem" class="left-input btn-input" name="spcItem" format="text" readonly/> 
						<input type="hidden" id="itemId" class="left-input btn-input" name="itemId"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_itemPop_Open(lfn_itemPop_callback)">
				<!-- 조회 -->
						<spring:message code="btn_search" /></button>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>품목명 : </td>
					<td colspan="2"><input type="text" id="itemNm" class="right-input" name="itemNm" format="text" readonly/></td>
				</tr>
				<tr>
				<!-- 시작일 -->
					<td><i class="fas fa-caret-right"></i>시작일 : </td>
					<td colspan="2"><input id="spcStartDt" class="left-input" name="spcStartDt" format="datepicker"/></td> 
				<!-- 종료일 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i>종료일 : </td>
					<td colspan="2"><input id="spcFinishDt" class="right-input" name="spcFinishDt" format="datepicker"/></td> 
				</tr>
				<tr>
					<!-- 상태  -->
					<td><i class="fas fa-caret-right"></i>상태: </td>
					<td colspan="2"><input id="spcStatus" class="left-input" name="spcStatus" format="selBox" msg="spc_status" /></td>
					<!-- 현상  -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i>현상 : </td>
					<td colspan="2"><input type="text" id="spcPnmn" class="right-input" name="spcPnmn" format="text" /></td>
				</tr>

				<tr>
					<!-- 원인  -->
					<td><i class="fas fa-caret-right"></i>원인 : </td>
					<td colspan="2"><input type="text" id="spcCause" class="left-input" name="spcCause" format="text" /></td>
					<!-- 목표  -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i>목표 : </td>
					<td colspan="2"><input type="text" id="spcGoal" class="right-input" name="spcGoal" format="text" /></td>
				</tr>

				<tr>
					<!-- 대책안  -->
					<td><i class="fas fa-caret-right"></i>대책안 : </td>
					<td colspan="5"><input type="text" id="spcMeasure" class="center-input" name="spcMeasure" format="text" /></td>
				</tr>
				<tr>
					<!-- 실행결과  -->
					<td><i class="fas fa-caret-right"></i>실행결과 : </td>
					<td colspan="5"><input type="text" id="spcResult" class="center-input" name="spcResult" format="text" /></td>
				</tr>
				<tr>
					<!-- 효과파악  -->
					<td><i class="fas fa-caret-right"></i>효과 파악 : </td>
					<td colspan="5"><input type="text" id="spcEffect" class="center-input" name="spcEffect" format="text" /></td>
				</tr>
				<tr>
					<!-- 표준화  -->
					<td><i class="fas fa-caret-right"></i>표준화 : </td>
					<td colspan="5"><input type="text" id="spcStandard" class="center-input" name="spcStandard" format="text" /></td>
				</tr>
				<tr>
					<!-- 담당자  -->
					<td><i class="fas fa-caret-right"></i>담당자 : </td>
					<td colspan="2"><input type="text" id="spcManager" class="left-input" name="spcManager" format="text" /></td>
					<!-- 알람  -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i>알람 : </td>
					<td><input type="text" id="spcAlarm" class="right-input btn-input" name="spcAlarm" format="text" /></td>
					<td><button class="k-button k-primary search-btn" type="button" >전송</button></td>
				</tr>
				<tr>
					<!-- 관련자료  -->
					<td><i class="fas fa-caret-right"></i>관련 자료 : </td>
					<td colspan="3">
						<input name="attachFile" id="attachFiles" type="file" aria-label="files" format="file" code="spcId" />
						<input type="hidden" id="insertAttach" value = "[]"/>
						<input type="hidden" id="deleteAttach" value = "[]"/>
					</td>
				</tr>

				<tr style="display:hidden;">
					<td>
						
						<input type="hidden" name="action" id="spc_action"/>
					</td>
				</tr>
			</table>
			
			<!-- 팀원 목록 -->
			<div id="jtePopForm_gridArea" style="display: none;">
				<div class="pop_title">팀원 목록</div>
				<div id="jtePopForm_grid"></div>
			</div>

			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		
	</div>
</div>

<link href='/resources/mes/css/contents/qualMgt/specProcMgt/specProcMgtForm.css' rel="stylesheet">
<!-- 내부 스타일 외부로 이동_200824 JJW -->

<script>
var lfo_common = {};  //form 내부에서 사용될 Object

var lfo_popGrd = {}; //팝업 그리드에서 사용

//진입 이벤트 
this.lfn_init = function() {
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

this.lfn_jteSgGrd_setGrd = function(){   
	lfo_commom = {};	
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/qualMgt/specProcMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getSpcList", auth:"", prmt:{}}, 
		create:{url:"/setSpcSave", auth:"", openFunc: lfn_jtePop_open, callback: lfn_popSave}, 
		update:{url:"/setSpcSave", auth:"", openFunc: lfn_jtePop_open, callback: lfn_popSave}, 
		destroy:{url:"/setSpcDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	lfo_common.model = {
			id: "spcId",
			fields: {
				spcId 		: { type: "string" },
				spcNm		: { type: "string" },
				spcPnmn		: { type: "string" },
				spcCause	: { type: "string" },
				spcGoal		: { type: "string" },
				spcMeasure	: { type: "string" },
				spcResult	: { type: "string" },
				spcEffect	: { type: "string" },
				spcStandard	: { type: "string" },
				spcManager	: { type: "string" },
				spcFile		: { type: "string" },
				spcUsers	: { type: "string" },
				spcStatus	: { type: "string" },
				updatedAt	: { type: "date" },
				updatorId	: { type: "string" },
				createdAt	: { type: "date" },
				creatorId	: { type: "string" },
				spcStartDt	: { type: "date" },
				spcFinishDt	: { type: "date" },
				itemNm		: { type: "string" }
			}
	};
	
	lfo_common.columns = [
		{selectable : true, width:"40px"},
		{field: "spcId", title:"코드", width: "120px"},
		{field: "spcNm", title:"프로젝트명", width: "120px"},
		{field: "spcStartDt", format:"{0: yyyy-MM-dd}", title:"시작일", width: "120px"},
		{field: "spcFinishDt", format:"{0: yyyy-MM-dd}", title:"종료일", width: "120px"},
		{field: "spcManager", title:"담당자", width: "120px"},
		{field: "spcStatus",template:"# var item = gfn_isNull(gfn_getCode(spcStatus))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(spcStatus).cdId , gfn_getCode(spcStatus).cdNm) # #= item #", title:"상태", width: "120px"}
		
	];
	
	lfo_common.selectBox = [
		{ text: "코드", value: "spcInfo.spc_id" },
		{ text: "프로젝트명", value: "spcInfo.spc_nm" },
		{ text: "담당자", value: "spcInfo.spc_manager" }
	];
	
	lfo_common.validation = {
		spcId:{
			messages : "코드를 입력하세요",
			rules : function(input){
				if(input.is("[name=spcId]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		spcManager:{
			messages : "담당자를 입력하세요",
			rules : function(input){
				if(input.is("[name=spcManager]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		spcStartDt:{
			messages : "시작일을 등록하세요",
			rules : function(input){
				if(input.is("[name=spcStartDt]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		spcFinishDt:{
			messages : "종료일을 등록하세요",
			rules : function(input){
				if(input.is("[name=spcFinishDt]")){
					return kendo.parseDate(input.val());
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
		height: "620px",  /** 200428 첫번째 팝업 높이 변경 565px->600px_LYM **/ /* 200921 JJW 600px -> 620px */
		id:lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_spcRegist");			//spc 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_spcUpdate");			//spc 수정
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
		gfn_resizePop(lfo_common.popId,{width:750,height:580}); //200831JJW팝업높이수정
		$("#"+lfo_common.popId+"_gridArea").show();
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem["spcId"];
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = selectedItem;
		}

		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {spcId:lfo_common.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
				//lfo_common.gridSelected = {spcId : data.rows[0].spcId};
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	//그리드 세팅
	if ( $("#jtePopForm_grid").html("") ) {
		lfn_jtePopGrd_setGrd();	
	}else {
		lfo_popGrd.grid.dataSource.read();
	}
	
	
}
//Form내용 입력/저장
this.lfn_popSave = function(mode){
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		//var savePrmt = gfn_serializeObject(lfo_common.popId+"_form");
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
					gfn_closePop(lfo_common.popId);
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

//팝업 내부 그리드
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.     
	//lfo_popGrd.popId = "";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/qualMgt/specProcMgt";
	
	//4.
	lfo_popGrd.crud = {
			read:{url:"/getSpcUserList", auth:"", prmt:{spcId : lfo_common.gridSelected}}, 
			create:{url:"/setSpcUserSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
			update:{url:"", auth:"", openFunc:"", callback:""},
			destroy:{url:"/setSpcUserDelete", auth:"", callback:lfn_jtePopGrd_delete}	
	};
	
	//5
	lfo_popGrd.model ={
			id: "userId",
			fields:{
				updatedAt	: { type: "date" },
				createdAt	: { type: "date" },
				spcId		: { type: "string" },
				userNm: {type: "string" },
				userId: {type: "string" }				
			}
	};
	
	//6
	lfo_popGrd.columns = [
		{selectable : true, width:"40px"},
		{field: "userId", title:" 팀원 아이디 ", width:"120px"},
		{field: "userNm", title:" 이름" }
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: "아이디", value: "spcUser.user_id" }, //아이디
		{ text: "이름", value: "userInfo.user_nm" }
		];
	//8.
	lfo_popGrd.validation ={
		userId:{
			messages : "팀원 아이디를 입력하세요",
			rules : function(input){
				if(input.is("[name=userId]")){
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
this.lfn_jtePopGrd_popOpen = function(selectedItem){
	//여기부터 공통팝업 띄우기
	gfn_openCustomPop('userInfo',lfn_jtePopGrd_save);
}



//팀원 추가 Form내용 입력/저장
this.lfn_jtePopGrd_save = function(savePrmt){
	savePrmt.spcId = lfo_common.gridSelected;
		
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.create.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					
					
					//팝업 그리드 리로드
					lfo_popGrd.grid.dataSource.read();
				
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

//pop - 품목 팝업 오픈
this.lfn_itemPop_Open = function(call){
	gfn_openCustomPop('item',call);
}

//pop - 품목 팝업 콜백
this.lfn_itemPop_callback = function(rtnObj){
	$("#spcItem").val(rtnObj["itemId"]);
	$("#itemNm").val(rtnObj["itemNm"]);

}





</script>