<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="baseSetMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="baseSetMgtForm"></div>
</div>
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="baseSetMgtForm">
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:30%;">
				<col style="width:20%;">
				<col style="width:30%;">
				<col style="width:20%;">
			</colgroup>
				<tr><td colspan="4"></td></tr>			
				<tr>
				<!-- 코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_cdId"></spring:message> : </td>
					<td colspan="3"><input type="text" id="cdId" name="cdId" readonly/></td>			<!-- 자동생성 -->
				</tr>
				<tr>
				<!-- 코드명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_cdNm"></spring:message> :  </td>
					<td colspan="3">
						<input type="text" id="cdNm" name="cdNm" format="text"/>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_cdVal"></spring:message> : </td>
					<td colspan="3"><input type="text" id="cdVal" name="cdVal" format="text"/></td>
				</tr>
				
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="description" name="description" format="text"/></td>
				</tr>
				<tr>
				<!-- 순서 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_sortNum"></spring:message> : </td>
					<td colspan="3"><input type="text" id="sortNum" name="sortNum" format="currency"/></td>
				</tr>
				<tr>
				<!-- 사용유무 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_cdUseYn"></spring:message> : </td>
					<td colspan="3"><input id="useYn" name="useYn" format="selBox" keyGbn="cdVal" msg="comn_isUse"/></td>
				</td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" id="updatorId" name="updatorId"/>
						<input type="hidden" name="creatorId" id="creatorId" />
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area baseSetMgtForm-final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<input type="hidden" id="jteSingleGrid_hidSelected" class="jteMasterTree_hidSelected" value="">
<input type="hidden" id="hidSelBiz" value="none">
<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/codMgt/baseSetMgt/baseSetMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 
var lfo_popGrd = {};//팝업 그리드에서 사용
var dropDownData = new Array();

this.lfn_init = function(){

	lfn_jteSgGrd_setGrd();
	
}
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};
	
	//1
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/codMgt/baseSetMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getBaseSet", auth:"", prmt:{upCdId: "sys"}},
		create:{url:"/addBaseSet", auth:"", openFunc : lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setBaseSet", auth:"", openFunc: "", callback:lfn_popSave}, 
		destroy:{url:"/delBaseSet", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "cdId",
		fields: {
			cdId: { type: "string" },
			upCdId: { type: "string" },
			cdNm: { type: "string" },
			cdVal: { type: "string" },
			description: { type: "string" },
			updatorId: { type: "string", editable: false },
			updatedAt: { type: "string", editable: false },
			useYn: { 
				type: "string", 
			 	validation: {
					required: true,
					useYnvalidation: function (input) {
						if (input.is("[name='useYn']")) {
						input.attr("data-useYnvalidation-msg", "Y, N만 입력 가능합니다.");
						return /^[YN]$/.test(input.val());
						}
					return true;
					}
				}
			}
		}
	};


	//6.
	lfo_common.columns = [
		{selectable : true, width:40},
		{field: "compAddrId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\', this)" style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update"), width: 90},
		{ field: "cdId", title: gfn_getMsg("col_cdId"), width: "15%" },												//코드
		{ field: "cdNm", title: gfn_getMsg("col_cdNm"), width: "15%" },												//코드명
		{ field: "cdVal", title: gfn_getMsg("col_cdVal"), width: "15%" },											//코드값
		{ field: "description", title: gfn_getMsg("col_desc"), width: "30%" },										//설명
		{ field: "useYn", title: gfn_getMsg("col_cdUseYn"), width: "10%" },											//사용유무
		{ field: "updatorId", title: gfn_getMsg("col_updateId"), width: "15%" }									//수정자

	];
	lfo_common.selectBox = [gfn_getMsg("col_cdId")];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}
//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	
	var options = {
		modal:true, 
		width: "500px", 
		height: "420px", /* 04.29 JJW 565->600px_201112 YUMI 320->322px_201203 YUMI 500->423px */
		id:lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_basicCodeRegist");			//기초코드 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_basicCodeUpdate");				//기초코드 조회
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}
//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){

	if(mode=='NEW'){
		lfo_common.gridSelected = "";
		gfn_popform_set(lfo_common, mode);
		$("#placeParent").val($("#jteMasterTree_hidSelected").val());
		$("#jtePopForm #cdId").attr("readonly", false);
		$("#" + lfo_common.popId + "_form [name=updatorId]").val($("#_loginUserId").val()); 
		$("#" + lfo_common.popId + "_form [name=creatorId]").val($("#_loginUserId").val()); 
	}else if(mode == 'EDT'){
		var dataItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			//data: {upCdid : "sys"},
			success: function(data){
				gfn_popform_set(lfo_common, mode,dataItem);
				$("#" + lfo_common.popId + "_form [name=updatorId]").val($("#_loginUserId").val()); 
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		}); 
	}
}
//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		savePrmt.upCdId = "sys";
		
		//패스워드패턴체크 예외처리
		if(savePrmt.cdId =="pw_set"){
			var pwdPtn = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}/;
			if(!pwdPtn.test(savePrmt.cdVal)){
				gfn_warnBox({msg:gfn_getMsg("pop_pwLetterChar")});
				return false;
			}
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
				lfo_common.grid.dataSource.read();
				gfn_closePop("jtePopForm");
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
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

</script>