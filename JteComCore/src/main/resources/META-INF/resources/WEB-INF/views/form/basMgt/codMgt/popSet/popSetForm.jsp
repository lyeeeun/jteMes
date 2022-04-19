<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 마스터 그리드 영역 -->
<div id="grid-content">
	<div id="jteSingleGrid"></div>
</div>

<!-- 화면설정 - 그리드 설정 -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form">
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:31%;">
				<col style="width:20%;">
				<col style="width:31%;">
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="호출키"/> : </td>
					<td><input type="text" name="popId" /></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 타이틀"/> : </td>
					<td><input type="text" name="popNm"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="타입"/> : </td>
					<td>
						<input type="text" name="popType" format="selBox" msg="popSetGridType" defId="popSetGrid"/>
					</td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="호출 url"/> : </td>
					<td><input type="text" name="popUrl"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 가로"/> : </td>
					<td><input type="text" name="popWidth" format="currency" /></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 세로"/> : </td>
					<td><input type="text" name="popHeight" format="currency" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="template"/> : </td>
					<td colspan="3">
						<textarea name="popTemplate" rows="3"></textarea>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td colspan="4">
						<input type="hidden" name="action"/>
						<input type="hidden" name="upPopId"/>
					</td>
				</tr>
			</table>
		</form>
		<div id = "jtePopFieldGrid" style="width:98%; height:300px; margin:auto;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn jte-create" type="button"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn jte-destroy" type="button"><spring:message code = "pop_delete" text="삭제"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
	
	<div id="jtePopFieldForm">
		<form id="jtePopFieldForm_form">
			<table id="jtePopFieldForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:31%;">
				<col style="width:20%;">
				<col style="width:31%;">
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="필드 아이디"/> : </td>
					<td><input type="text" name="popId"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="필드명"/> : </td>
					<td><input type="text" name="popNm"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="순서"/> : </td>
					<td><input type="text" name="popNum" format="currency"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="표시유무"/> : </td>
					<td><input type="text" name="popUse" format="selBox"  msg="comnBool" defId="comnTrue"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="필드타입"/> : </td>
					<td>
						<input type="text" name="popType" format="selBox" msg="popSetPopType" defId="popSetString"/>
					</td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="필드길이"/> : </td>
					<td><input type="text" name="popWidth" format="currency" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="필드속성"/> : </td>
					<td>
						<input type="text" name="popFormat"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="검색유무"/> : </td>
					<td><input type="text" name="popSearchUse" format="selBox" msg="comnBool" defId="comnTrue"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="검색값"/> : </td>
					<td><input type="text" name="popSearchValue"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="파라미터 유무"/> : </td>
					<td><input type="text" name="popDynamicUse" format="selBox" msg="comnBool" defId="comnTrue"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="파라미터 값"/> : </td>
					<td><input type="text" name="popDynamicValue"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="template"/> : </td>
					<td colspan="3">
						<textarea name="popTemplate" rows="3"></textarea>
					</td>
				</tr>
				<tr style="display:hidden;">
					<td colspan="4">
						<input type="hidden" name="action"/>
						<input type="hidden" name="upPopId"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn jte-create" type="button"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn jte-destroy" type="button"><spring:message code = "pop_delete" text="삭제"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopFieldForm');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
</div>
<script>

var lfo_common = {};//Form 내부에서 사용될 Object

var lfo_popField = {};


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//메인 그리드 생성
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/codMgt/popSet"
	
	//4.
	lfo_common.crud  = {
		read : {url:"/getPopSetList", auth:"", prmt:{upPopId : 'def'}, search : false, paging : false},
		create : {url : "/setPopSetSave", auth : "", openFunc : lfn_jtePop_open, callback : lfn_jtePop_save},
		update : {url : "/setPopSetSave", auth : "", callback : lfn_jtePop_save},
		destroy : {type : 'pop', url : "/setPopSetDelete", auth : "", callback : lfn_jtePop_delete},
	};
	
	//5.
	lfo_common.model = {
		id: "gridNo",
		fields: {
			popId: { type: "string" },
			popNm: { type: "string" },
			popType: { type: "string" },
			popWidth: { type: "int" },
			popHeight: { type: "int" },
			popUrl: { type: "string" },
			popTemplate: { type: "string" },
			popFormat: { type: "string" },
			popSearchUse: { type: "string" },
			popNum: { type: "int" },
			popUse: { type: "string" },
			popSearchValue: { type: "string" },
			popDynamicUse: { type: "string" },
			popDynamicValue: { type: "string" },
			upPopId: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" },
			updatorId: { type: "string" },
			updatedAt: { type: "date" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "popId", title : gfn_getMsg("btn_search") , width: "95px"
			,template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); "><spring:message code = "btn_update"/></button>'},
		{field: "popId", title : "팝업 아이디", width: "150px"},
		{field: "popNm", title : "팝업 타이틀", width: "150px"},
		{field: "popType", title : "팝업타입", width: "120px",
			template : "#= gfn_getMsg('bc_'+ gfn_getCode(popType).cdVal , gfn_getCode(popType).cdNm == null ? '기초코드 없음' :  gfn_getCode(popType).cdNm)#"
		},
		{field: "popWidth", title : "팝업 가로", width: "120px"},
		{field: "popHeight", title : "팝업 세로", width: "120px"},
		{field: "popUrl", title : "호출 url", width: "200px"},
		{field: "popTemplate", title : "template", width: "300px"}
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//8.
// 	lfo_common.validation ={
// 		compNm:{
// 			messages : "업체명을 입력하세요",
// 			rules : function(input){
// 				if(input.is("[name=compNm]")){
// 					return input.val().length != 0 && input.val().trim().length != "";
// 				}
// 				return true;
// 			}
// 		}
// 	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//팝업설정 - 팝업 설정 팝업 오픈
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
			modal:true, 
			width: "750px",
			height: "630px",
			id:"jtePopForm", 
			title : "그리드 설정",
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		if(!gfn_isEmpty(selectedItem)){
			selectedItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}
		lfn_jtePop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);		
}

//팝업설정 - 팝업 설정 팝업 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = {};
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
		lfo_common.gridSelected.popId = "";
	}else if(mode == 'EDT'){
		//수정시 특정값 변경불가
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.popId = selectedItem;
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {popId : lfo_common.gridSelected.popId, upPopId : "def"},
			success: function(data){
				if(data.rows.length > 0){
					lfo_common.gridSelected = data.rows[0];
				}else{
					lfo_common.gridSelected = {};
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		
		$("#"+lfo_common.popId+"_form [name=popId]").attr("readonly",true);
		
		gfn_popform_set(lfo_common, mode, lfo_common.gridSelected);
	}
	
	
	var childItems = [];
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
		type: "POST",
		data: {upPopId : lfo_common.gridSelected.popId},
		success: function(data){
			if(data.rows.length > 0 ){
				childItems = data.rows;
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	lfn_jtePopFieldGrd_set(childItems);
}

//Form내용 입력/저장
this.lfn_jtePop_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#" + lfo_common.popId + "_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = gfn_serializeObject(lfo_common.popId + "_form");
		savePrmt.upPopId = 'def'
		savePrmt.popFieldList = lfo_popField.childItems;
		
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
				if(!gfn_isNull(data)){
					lfo_common.grid.dataSource.read();
					
					lfn_jtePop_set("EDT",{popId : data, upPopId : ""})
					
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

//Form 삭제
this.lfn_jtePop_delete = function(mode){
	gfn_conBox({
		title : "삭제 팝업", 
		msg:"삭제하시겠습니까?",
		yes : function(){
			//입력폼 serialize 
			var delPrmt = gfn_serializeObject(lfo_common.popId + "_form");
			
			delPrmt.popFieldList = lfo_popField.childItems;
			
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
				type: "POST",
				data: JSON.stringify(delPrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					if(data == 'success'){
						lfo_common.grid.dataSource.read();
						
						gfn_closePop(lfo_common.popId)
						
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
	});
}

//팝업필드정보 그리드 생성
this.lfn_jtePopFieldGrd_set = function(childItems){
	$("#jtePopFieldGrid").html("");
	
	lfo_popField = {}; 
	
	//1.
	lfo_popField.layoutId = "jtePopFieldGrid";
	
	//2.
	lfo_popField.popId = "jtePopFieldForm";
	
	//3.
	lfo_popField.ctrlUrl = "/form/basMgt/codMgt/popSet"
	
	//4.
	lfo_popField.crud  = {
		read : {url:"/getPopSetList", auth:"", prmt:{}, search : false, paging : false},
		create : {url : "", auth : "", openFunc : lfn_jtePopFieldPop_open, callback : lfn_jtePopFieldPop_save},
		update : {url : "", auth : "", callback : lfn_jtePopFieldPop_save},
		destroy : {type : 'pop', url : "", auth : "", callback : lfn_jtePopFieldPop_delete},
	};
	
	//5.
	lfo_popField.model = {
		id: "popId",
		fields: {
			popId: { type: "string" },
			popNm: { type: "string" },
			popType: { type: "string" },
			popWidth: { type: "int" },
			popHeight: { type: "int" },
			popUrl: { type: "string" },
			popTemplate: { type: "string"},
			popFormat: { type: "string" },
			popNum: { type: "int" },
			popUse: { type: "string" },
			popSearchUse: { type: "string" },
			popSearchValue: { type: "string" },
			popDynamicUse: { type: "string" },
			popDynamicValue: { type: "string" },
			upPopId: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" },
			updatorId: { type: "string" },
			updatedAt: { type: "date" }
		}
	};
	
	//6.
	lfo_popField.columns = [
		{field: "popId", title : gfn_getMsg("btn_search") , width: "95px"
			,template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePopFieldPop_open(\'EDT\',this); "><spring:message code = "btn_update"/></button>'
		},
		{field: "action", template : "#= action == 'C' ? '신규' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '' : '에러' #",
			title:"액션", width: "95px"},
		{field: "popNum", title : "순서", width: "90px"},
		{field: "popId", title : "필드 아이디", width: "150px"},
		{field: "popNm", title : "필드명", width: "150px"},
		{field: "popType", title : "필드속성", width: "120px",
			template : "#= gfn_getMsg('bc_'+ gfn_getCode(popType).cdVal , gfn_getCode(popType).cdNm == null ? '기초코드 없음' :  gfn_getCode(popType).cdNm)#"},
		{field: "popWidth", title : "필드길이", width: "120px"},
		{field: "popUse", title : "표시유무", width: "90px",
			template : "#= gfn_getMsg('bc_'+ gfn_getCode(popUse).cdVal , gfn_getCode(popUse).cdNm == null ? '기초코드 없음' :  gfn_getCode(popUse).cdNm)#"},
		{field: "popFormat", title : "필드포맷", width: "120px"},
		{field: "popSearchUse", title : "검색 사용", width: "90px",
			template : "#= gfn_getMsg('bc_'+ gfn_getCode(popSearchUse).cdVal , gfn_getCode(popSearchUse).cdNm == null ? '기초코드 없음' :  gfn_getCode(popSearchUse).cdNm)#"},
		{field: "popSearchValue", title : "검색 값", width: "120px"},
		{field: "popDynamicUse", title : "파라미터 사용", width: "90px",
			template : "#= gfn_getMsg('bc_'+ gfn_getCode(popDynamicUse).cdVal , gfn_getCode(popDynamicUse).cdNm == null ? '기초코드 없음' :  gfn_getCode(popDynamicUse).cdNm)#"},
		{field: "popDynamicValue", title : "파라미터 값", width: "120px"},
		{field: "popTemplate", title : "template", width: "300px"}
	];
	
	//7.
	lfo_popField.selectBox = [];
	
	//8.
// 	lfo_common.validation ={
// 		compNm:{
// 			messages : "업체명을 입력하세요",
// 			rules : function(input){
// 				if(input.is("[name=compNm]")){
// 					return input.val().length != 0 && input.val().trim().length != "";
// 				}
// 				return true;
// 			}
// 		}
// 	}
	
	childItems.sort(function(a, b) {return a.popNum - b.popNum;});
	
	lfo_popField.childItems = childItems;
	
	//공통 그리드 세팅 호출 
	lfo_popField.grid = gfn_objectDatagrid_set(lfo_popField);
}

//팝업필드정보 팝업 오픈
this.lfn_jtePopFieldPop_open = function(mode, selectedItem){
	var options = {
			modal:true, 
			width: "650px",
			height: "500px",
			id : lfo_popField.popId, 
			title : "팝업 필드 세팅",
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePopFieldPop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);		
}

//팝업필드정보 팝업 세팅
this.lfn_jtePopFieldPop_set = function(mode,selectedItem){
	
	lfo_popField.gridSelected = {};
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_popField, mode);
	}else if(mode == 'EDT'){
		
		lfo_popField.gridSelected = lfo_popField.grid.dataItem($(selectedItem).closest("tr"));
		
		$("#"+lfo_popField.popId+"_form [name=popId]").attr("readonly",true);
		
		gfn_popform_set(lfo_popField, mode, lfo_popField.gridSelected);
		
		//신규등록이 수정인 경우. 등록수정으로 상태 변경
		if(lfo_popField.gridSelected.action == "C"){
			$("#"+lfo_popField.popId+"_form [name=action]").val("CU");
		}
	}
}

//팝업필드 정보 저장
this.lfn_jtePopFieldPop_save = function(){
	
	var savePrmt = gfn_serializeObject(lfo_popField.popId + "_form");
	
	var childItems = gfn_objectDataGrid_save({tgObj : lfo_popField, prmt : savePrmt, pk : "popId", autokey : false});
	if(!childItems){
		return false;
	}
	
	lfo_popField.childItems = childItems;
	
	lfo_popField.grid.dataSource.read();
	
	gfn_closePop(lfo_popField.popId);
}
//팝업필드 정보 삭제
this.lfn_jtePopFieldPop_delete = function(){
	gfn_conBox({
		title : "삭제 팝업", 
		msg:"삭제하시겠습니까?",
		yes : function(){
			var delPrmt = gfn_serializeObject(lfo_popField.popId + "_form");
			gfn_objectDataGrid_delete({tgObj : lfo_popField, prmt : delPrmt, pk : "popId"});
			
			//그리드 리로드
			lfo_popField.grid.dataSource.read();
			//팝업종료
			gfn_closePop(lfo_popField.popId)
		}
	});
}

</script>