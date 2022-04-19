<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="mtrltoolMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrltoolMgtForm mtrltoolMgtForm-jteSingleGrid"></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
	<div id="jteSubGrid" class="mtrltoolMgtForm mtrltoolMgtForm-jteSubGrid"></div>   <!-- style="display:inline-block; width:59%; height:100%;" -->
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrltoolMgtForm">
			<div class="pop_title"><spring:message code = "pop_toolInfo"></spring:message></div>
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width: 20%;">
				<col style="width: 30%;">
				<col style="width: 20%;">
				<col style="width: 30%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolIndivCd" text = "공구개별코드" /> : </td>
					<td><input type="text" id="toolMgtId" class="" name="toolMgtId" placeholder="<spring:message code = "pop_autoInput" text = "자동입력" />" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_toolNm" text = "공구명" /> : </td>
					<td><input type="text"  id="toolNm" class="" name="toolNm" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolStatus" text = "공구상태" /> : </td>
					<td><input id="toolMgtGbn" class="" name="toolMgtGbn" format="selBox" msg="tool_use"/></td> 
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_toolDiv" text = "공구구분" /> : </td>
					<td><input id="toolMgtState" class="" name="toolMgtState" format="selBox" msg="tool_sta"/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate" text = "등록일" /> : </td>
					<td><input type="text" id="toolMgtPurchase" class="" name="toolMgtPurchase" format="datepicker"/></td> 
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_verifyPeriod" text = "검증기간" /> : </td>
					<td><input id="toolMgtVerif" class="" name="toolMgtVerif" format="datepicker"/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolUse" text = "사용량" /> : </td>
					<td><input id="toolMgtUse" class="" name="toolMgtUse" format="currency"/></td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_useLimit" text = "사용한도" /> : </td>
					<td><input id="toolMgtLimit" class="" name="toolMgtLimit" format="currency"/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm" text = "업체명" /> : </td>
					<td colspan="3">
						<input type="text" id="compNm" class="btn-input" name="compNm" readonly/> 
						<input type="hidden" id="compId" name="compId" />
						<button class="k-button k-primary" type="button" onclick="lfn_supplierPop_open();" >
						<spring:message code = "btn_search" text = "조회" /></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명" /> : </td>
					<td colspan="3"><input type="text" id="toolMgtDesc" class="center-input" name="toolMgtDesc" class="k-textbox"/></td> 
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="toolLimit" id="toolLimit"/>
						<input type="hidden" name="toolId" id="toolId"/>
						<input type="hidden" name="use" id="toolMgtUse"/>
						<input type="hidden" name="action" id="toolMgtAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장" /></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소" /></button>
			</div>
		</form>
	</div>
</div>

<link href='/resources/mes/css/contents/mtrl/mtrltoolMgt/mtrltoolMgtForm_JJW.css' rel="stylesheet"> 

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_subGrd = {};//서브그리드에서 사용될 Object

var lfo_toolMtncGrd = {};//정비이력 Object

var lfo_toolUseGrd = {};//사용정보 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();

};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	//lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/operMgt/toolMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getToolInfoList", auth:"", prmt:{use:false}}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		update:{url:"", auth:"", openFunc : "", callback:""}
		//destroy:{url:"", auth:"", callback:""}
	};
	
	//5.
	lfo_common.model = {
		id: "toolId",
		fields: {
			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolType : { type: "string" },
			toolPrice : { type: "int" },
			toolLimit : { type: "int" },
			toolDesc : { type: "string" },
			isUse : { type: "bool" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" },
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "toolId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jteSgGrid_dblclick(\'EDT\',this); " style="min-width:60px;">' + "상세" + '</button>',
			title : gfn_getMsg("btn_search", "조회") , width: "110px"},
		{field: "toolId", title:gfn_getMsg("col_toolCd", "공구코드"), width: "160px"},
		{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolType", "공구유형"), width: "140px;"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm", "공구명"), width: "180px"},
		{field: "toolPrice",format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_cost", "비용"), width: "90px"},
		{field: "toolLimit", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit", "사용한도"), width: "120px"},
		{field: "toolDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_toolNm", "공구명"), value: "toolInfo.tool_nm" },
		{ text: gfn_getMsg("col_toolCd", "공구코드"), value: "toolInfo.tool_id" },
		{ text: gfn_getMsg("col_desc", "설명"), value: "toolInfo.tool_desc" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//상세버튼클릭 콜백(팝업)
this.lfn_jteSgGrid_dblclick = function(mode, selectedItem){
	lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
	//그리드 세팅
	if($("#jteSubGrid").html() !=""){
		$("#jteSubGrid").html("");
	}
	lfn_jteSubGrd_setGrd();
	

	$("[name='delToolChk']").change(function(e){
		$("#delStat").val($("[name='delToolChk']:checked").val());
		lfo_subGrd.grid.dataSource.read();
	});
}


//서브 그리드 세팅
this.lfn_jteSubGrd_setGrd = function(){
	lfo_subGrd = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_subGrd.layoutId = "jteSubGrid";
	
	//2.
	lfo_subGrd.popId = "jtePopForm";
	
	//3.
	lfo_subGrd.ctrlUrl = "/form/tool/mtrltoolMgt";
	
	//4.
	lfo_subGrd.crud  = {
		read:{url:"/getToolMgtList", auth:"", prmt:{toolId : lfo_common.gridSelected.toolId}, dynamicPrmt : {del : "delStat"}}, 
		create:{url:"/setToolMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setToolMgtSave", auth:"", openFunc :"" , callback:lfn_popSave}, 
		destroy:{url:"/setToolMgtDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//커스텀 타이틀
 	lfo_subGrd.customTitle = {
		html :	"<div style='padding : 5px 0; font-weight: bold; font-size: 20px;'>선택된 공구 : " + lfo_common.gridSelected.toolNm + "</div>"+
				'<div style="margin : 5px 0 10px 0;">사용가능 여부 : '+
				'<input type="radio" name="delToolChk" id="delFalse" class="k-radio" checked="checked" value=false style="margin : 0 5px 0 5px;">' +
			 	'<label class="mtrltoolMgtForm-label" for="delFalse">가능</label>'+
				'<input type="radio" name="delToolChk" id="delTrue" class="k-radio"  value=true style="margin : 0 5px 0 5px;">'+
				'<label class="mtrltoolMgtForm-label" for="delTrue">불가</label>'+
				'<input type="hidden" id="delStat" value="false"></div>'
	} 
	
	//5.
	lfo_subGrd.model = {
		id: "toolMgtId",
		fields: {
			toolMgtId : { type: "string" },
			toolMgtPurchase : { type: "date" },
			toolMgtState : { type: "string" },
			toolMgtLimit : { type: "int" },
			toolMgtUse : { type: "int" },
			toolMgtVerif : { type: "date" },
			toolMgtGbn : { type: "string" },
			toolMgtDesc : { type: "string" },
			creatorId : { type: "string" },
			createdAt : { type: "date" },
			updatorId : { type: "string" },
			updatedAt : { type: "date" },
			compId : { type: "string" },
			compNm : { type: "string" },
			isDel : {type:"bool"},

			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolType : { type: "string" },
			toolPrice : { type: "int" },
			toolLimit : { type: "int" },
			toolDesc : { type: "string" },
			isUse : { type: "bool" }
		}
	};
	
	//6.
	lfo_subGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMgtId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("btn_search", "조회") , width: "110px"},
		{field: "toolMgtId", title:gfn_getMsg("col_toolIndivCd", "공구개별코드"), width: "160px"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm", "공구명"), width: "140px"},
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolStatus", "공구상태"), width: "160px"},
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolDiv", "공구구분"), width: "140px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "160px"},
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate", "등록일"), width: "120px"},
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod", "검증기간"), width: "120px"},
		{field: "toolMgtUse", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_toolUse", "사용량"), width: "120px"},
		{field: "toolMgtLimit", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit", "사용제한"), width: "120px"},
		{field: "toolMgtDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"},
		{field : "toolMgtId",title : gfn_getMsg("col_mtrlReturn", "반납"), width: "120px",
			template : function(rows){
				if(rows.del){
					return '폐기완료';
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_tool_return(this); " style="min-width:90px;">' + "공구폐기" + '</button>';
				}
			}
		} 
	];
	//7.
	lfo_subGrd.selectBox = [
		{ text: gfn_getMsg("col_toolNm", "공구명"), value: "toolInfo.tool_nm" },
		{ text: gfn_getMsg("col_toolIndivCd", "공구개별코드"), value: "toolMgt.tool_mgt_id" },
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_desc", "설명"), value: "toolMgt.tool_mgt_desc" }
	];
	//8.
	lfo_subGrd.validation ={
		toolMgtUse:{
			messages : "사용량을 입력하세요",
			rules : function(input){
				if(input.is("[name=toolMgtUse]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		toolMgtLimit:{
			messages : "사용한도를 입력하세요",
			rules : function(input){
				if(input.is("[name=toolMgtLimit]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		toolMgtPurchase:{
			messages : "수령일을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMgtPurchase]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		toolMgtVerif:{
			messages : "검증기간을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMgtVerif]")){
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
						alert("조회버튼을 눌러 업체를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 compId
	lfo_subGrd.grid = gfn_grid_set(lfo_subGrd);
}

//수정버튼클릭 콜백(공구 상세 팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px", 
		height: "470px",
		id:lfo_subGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_toolRegistDetail", "공구상세 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_toolDetailSrh", "공구상세 수정");
		if(!gfn_isEmpty(selectedItem)){
			selectedItem = lfo_subGrd.grid.dataItem($(selectedItem).closest("tr"));
		}
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//공구 상세 팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_subGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			toolId : lfo_common.gridSelected.toolId,
			toolLimit: lfo_common.gridSelected.toolLimit,
			toolMgtLimit: lfo_common.gridSelected.toolLimit,
			toolNm: lfo_common.gridSelected.toolNm
		}
		gfn_popform_set(lfo_subGrd, mode,selectedItem);
	}else if(mode == 'EDT'){
		var searchPrmt = {};
		if(typeof(selectedItem) == "object"){
			lfo_subGrd.gridSelected = searchPrmt;
			
			searchPrmt = {
				toolId : lfo_common.gridSelected.toolId, 
				toolMgtId : selectedItem.toolMgtId,
				del : selectedItem.del
			}
		}else if(typeof(selectedItem) == "string"){
			searchPrmt = {
				toolId : lfo_common.gridSelected.toolId, 
				toolMgtId : selectedItem
			}
		}
		
		$.ajax({
			async:false,
			url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud.read.url,
			type: "POST",
			data: searchPrmt,
			success: function(data){
				gfn_popform_set(lfo_subGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//공구 업체 등록
this.lfn_supplierPop_open= function(){
	var toolId = $("#"+ lfo_subGrd.popId + "_form [name='toolId']").val();
	if(!gfn_isNull(toolId)){
		gfn_openCustomPop('company',lfn_supplierPop_callback,{toolId: toolId});
	}else{
		gfn_msgBox({msg:"선택된 공구가정보가 없습니다."});
	}
}

//업체코드 정보 팝업 콜백
this.lfn_supplierPop_callback = function(callbackObj){
	$("[name='compId']").val(callbackObj.compId);
	$("[name='compNm']").val(callbackObj.compNm);
}

//공구 상세 Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_subGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_subGrd.popId+"_form").serializeObject();
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_subGrd.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		$.ajax({
			async:false,
			url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//lfn_jtePop_set('EDT',data);
					gfn_closePop(lfo_subGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
					
					lfo_subGrd.grid.dataSource.read();
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//삭제 콜백
this.lfn_jteGrid_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_subGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_subGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_subGrd.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}
//공구 반납처리
 this.lfn_tool_return = function(target){
	gfn_conBox({msg:"정말로 폐기 처리하시겠습니까?", yes : function(){
		var returnTemp = lfo_subGrd.grid.dataItem($(target).closest('tr'))
		returnTemp.del = true;
		returnTemp.action = "D";
		$.ajax({
			async:false,
			url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud.update.url,
			type: "POST",
			data: JSON.stringify(returnTemp),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_subGrd.grid.dataSource.read();
				gfn_msgBox({msg :  gfn_getMsg("pop_toolReturnSuccess", "폐기처리가 완료되었습니다.")});	
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}});
} 

</script>