<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="rlehoMgtForm" style="width: 100%;">
	<div id="jteMasterTree" class="rlehoMgtForm left-contents"></div>
	<div class="rlehoMgtForm middle-contents"><span><i class="fas fa-caret-square-right fa-3x"></i></span></div><input type="hidden" id="jteMasterTree_hidSelected" class="jteMasterTree_hidSelected" value="">
	<div id="jteSubGrid" class="rlehoMgtForm right-contents"></div>
</div>

<div style="display:none;">
	<div id="jtePopForm" class="rlehoMgtForm">
		<form id="jtePopForm_form" class="rlehoMgtForm">
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width: 30%;">
				<col style="width: 20%;">
				<col style="width: 30%;">
				<col style="width: 20%;">
			</colgroup>	
				<tr><td colspan="4"></td></tr>				
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_placeCd" text = "위치코드"/> : </td>
					<td colspan="3"><input type="text" id="placeId" name="placeId" placeholder="<spring:message code = "pop_autoInput" text = "자동생성"/>" readonly /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_placeNm" text = "위치명"></spring:message> :  </td>
					<td colspan="3">
						<input type="text" id="placeNm" name="placeNm" format="text"/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager" text = "관리자"/> :  </td>
					<td colspan="3">
						<input type="text" id="placeManagerNm" class="btn-input" name="placeManagerNm" format="text" readonly/>
						<input type="hidden" id="placeManager" name="placeManager"/>
						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
						<spring:message code ="btn_search" text = "조회"/></button>
					</td>
				</tr>
 				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_attachment" text = "첨부파일"/> : </td>
					<td colspan="3">
						<input name="attachFile" type="file" format="file" code="placeId" />
						<input type="hidden" id="insertAttach" value = "[]"/>
						<input type="hidden" id="deleteAttach" value = "[]"/>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "비고"/> : </td>
					<td colspan="3"><input type="text" id="description" name="description" format="text"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="place_action" class="place_action"/>
						<input type="hidden" name="placeParent" id="placeParent" class="$()"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area rlehoMgtForm-final-btn-area">
 			<button class="k-button k-primary final-btn" type="button" onclick = "lfn_popSave('jtePopForm_form')"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소"/></button> 
		</div>
<%-- 		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div> --%>
	</div>
</div>

<link href='/resources/mes/css/contents/basMgt/operMgt/rlehoMgt/rlehoMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200428 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 
var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/rlehoMgt";
	dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: lfo_common.ctrlUrl + "/getPlaceTree",
				dataType: "json"
			}
		},
		schema: {
			model: {
				id: "placeId",
				hasChildren: "hasChildren",
				field:{
					placeId : { type: "string" },
					placeNm : { type: "string" },
					placeFile : { type: "string" },
					placeParent : { type: "string" },
					placeManager : { type: "string" },
					createdAt : { type: "string" },
					updatedAt : { type: "string" },
					creatorId : { type: "string" },
					updatorId : { type: "string" },
					description : { type: "string" },
					isUse : { type: "string" }
				}
			}
		}
	});
	dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: lfo_common.ctrlUrl + "/getPlaceTree",
				dataType: "json"
			}
		},
		schema: {
			model: {
				id: "placeId",
				hasChildren: "hasChildren",
				field:{
					placeId : { type: "string" },
					placeNm : { type: "string" },
					placeFile : { type: "string" },
					placeParent : { type: "string" },
					placeManager : { type: "string" },
					createdAt : { type: "string" },
					updatedAt : { type: "string" },
					creatorId : { type: "string" },
					updatorId : { type: "string" },
					description : { type: "string" },
					isUse : { type: "string" }
				}
			}
		}
	});
	
	$("#jteMasterTree").kendoTreeView({
		dataSource: dataSource,
		dataTextField: "placeNm",
		expand:lfn_jteMtTree_expandPush,
		collapse:lfn_jteMtTree_expandPop
		//전체 확장 
// 		dataBound: function(){
// 			this.expand('.k-item');
// 		}
	});

	lfo_common.mtTree = $("#jteMasterTree").data("kendoTreeView");
	lfo_common.mtTreeExpand =[];
	
	setTimeout(function() {
		lfo_common.mtTree.expand(".k-item");
	}, 300);
	
	lfn_jteSubGrd_setGrd();
	
	lfn_jteSubGrd_eventBind();
	
	lfo_common.grid = $("#jteSubGrid").getKendoGrid();
	
	// 좌측 Tree 더블클릭 이벤트
	$("#jteMasterTree").on("dblclick",".k-in", function(e){
		var item = lfo_common.mtTree.dataItem($(e.target).closest("li"));
		$("#jteMasterTree_hidSelected").val(item.placeId);
		lfo_common.grid.dataSource.read();
	});
	
};
//트리 오픈 순서 기억
this.lfn_jteMtTree_expandPush = function(e){
	var item = lfo_common.mtTree.dataItem(e.node);
	lfo_common.mtTreeExpand.push(item.menuId);
}

//트리 클로즈시 해당부분 제거
this.lfn_jteMtTree_expandPop = function(e){
	var item = lfo_common.mtTree.dataItem(e.node);
	lfo_common.mtTreeExpand.pop(item.menuId);
}

this.lfn_jteSubGrd_setGrd = function(){
	
	//lfo_common = {};
	
	lfo_common.layoutId = "jteSubGrid";
	
	lfo_common.popId = "jtePopForm";
	
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/rlehoMgt";
	
	
	lfo_common.crud  = {
			read:{url:"/getPlaceList", auth:"", prmt:{}, dynamicPrmt:{placeParent:"jteMasterTree_hidSelected"}}, 
			create:{url:"/setPlaceSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
			update:{url:"/setPlaceSave", auth:"", openFunc:lfn_jtePop_open, callback: ""}, 
			destroy:{url:"/setPlaceDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	lfo_common.model = {
			id: "placeId",
			field:{
				placeId : { type: "string" },
				placeNm : { type: "string" },
				placeFile : { type: "string" },
				placeParent : { type: "string" },
				placeManager : { type: "string" },
				placeSeq : { type: "int" },
				plcaeStd01 : { type: "float" },
				plcaeStd02 : { type: "float" },
				plcaeStrStd01 : { type: "string" },
				plcaeStrStd02 : { type: "string" },
				createdAt : { type: "string" },
				updatedAt : { type: "string" },
				creatorId : { type: "string" },
				updatorId : { type: "string" },
				description : { type: "string" },
				isUse : { type: "string" }
			}
		};
	
	lfo_common.columns = [
		{selectable : true, width:"50px"}, 
		{field: "compAddrId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\', this)" style="min-width:60px;">' + "<spring:message code = "pop_view" />" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},
		{field: "placeId", title:gfn_getMsg("col_placeCd", "위치코드"), width: "150px"},  
		{field: "placeNm", title:gfn_getMsg("col_placeNm", "위치명"), width: "200px"},
		{field: "placeManagerNm", title:gfn_getMsg("col_manager", "관리자"), width: "200px"},
		{field: "description", title:gfn_getMsg("col_desc", "비고"), width: "300px"},
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse", "사용유무"), width:"120px",
				template : function(rows) {
					if(rows.use == false){
						return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
					}else if (rows.use == true){
						return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
					}else{
						return ""+gfn_getMsg("val_basic", "기본")+" : Y";	
					}
				}
		}
	];
	lfo_common.selectBox = [ 
		{ text: gfn_getMsg("col_placeNm", "위치명"), value: "place.place_nm" },
		{ text: gfn_getMsg("col_placeCd", "위치코드"), value: "place.place_id" }
	];
	
	lfo_common.grid = gfn_grid_set(lfo_common);

}

this.lfn_jteSubGrd_eventBind = function(){

	//삭제이벤트 바인딩
	$("#jteSubGrid").find(".k-grid-toolbar").on("click", ".k-grid-delete", function (e) {
		kendo.confirm(gfn_getMsg("pop_confirmDelete"))			//삭제하시겠습니까?
		.done(function(){
			var delPrmt = [];
			$(".k-checkbox").each(function(index,item){
				if($(this).attr("aria-checked") == "true"){
					var dataItem = $("#jteSubGrid").data("kendoGrid").dataItem($(this).closest("tr"));
					delPrmt.push(dataItem);
				}
			});
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl+"/setPlaceDelete",
				type: "POST",
				data: JSON.stringify(delPrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					lfo_common.mtTree.dataSource.read();
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
					
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		})
	});
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	
	var options = {
		modal:true, 
		width: "550px", 
		height: "316px",
		id:lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_placeRegist", "위치 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_placeDetailSrh", "위치 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}
//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

//pop - 유저정보 팝업 콜백
this.lfn_userInfoPop_callback = function(rtnObj){
	$("#placeManager").val(rtnObj["userId"]);
	$("#placeManagerNm").val(rtnObj["userNm"]);
}


//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	
	if(mode=='NEW'){
		lfo_common.gridSelected = "";
		gfn_popform_set(lfo_common, mode);
		$("#placeParent").val($("#jteMasterTree_hidSelected").val());
	}else if(mode == 'EDT'){
		var dataItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			//data: {placeId : lfo_common.gridSelected.placeId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,dataItem);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
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
			url : lfo_common.ctrlUrl + "/setPlaceSave",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					gfn_closePop(lfo_common.popId);
				
					lfo_common.mtTree.dataSource.read();
					lfo_common.grid.dataSource.read();

					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
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
			lfo_common.mtTree.dataSource.read();
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}
//잠금유무
this.lfn_jteSubGrd_changeIsUse = function(rows){
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {placeId : dataItem.placeId, action : "USE", use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.update.url,
		type: "POST",
		data: JSON.stringify(prmt),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data > 0){
				lfo_common.mtTree.dataSource.read();
				lfo_common.grid.dataSource.read();
				setTimeout(function() {
					lfo_common.mtTree.expandPath(lfo_common.mtTreeExpand);
				}, 300);
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});	
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

</script>