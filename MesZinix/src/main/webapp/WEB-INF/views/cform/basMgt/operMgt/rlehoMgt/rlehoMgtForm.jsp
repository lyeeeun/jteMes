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
				<!-- 위치코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_placeCd"></spring:message> : </td>
					<td colspan="3"><input type="text" id="placeId" name="placeId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly /></td>			<!-- 자동생성 -->
				</tr>
				<tr>
				<!-- 위치명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_placeNm"></spring:message> :  </td>
					<td colspan="3">
						<input type="text" id="placeNm" name="placeNm" format="text"/>
					</td>
<%-- 					<td>	
						<button class="k-button k-primary msgPop-btn" type="button" onclick = "lfn_msgPop('placeId','placeNm')">
				<!-- 다국어 -->
						<spring:message code = "pop_msgLang"></spring:message></button>
					</td> --%>
				</tr>
			<%--
				<tr>				
				<!-- 예비1 -->
					<td><i class="fas fa-caret-right"></i>예비1 :</td>
					<td><input type="text" id="placeStd01" class="left-input" name="placeStd01" format="numeric"/></td>
				<!-- 예비1(str) -->
					<td><i class="fas fa-caret-right"></i>예비1(str) :</td>
					<td><input type="text" id="placeStdStr01" class="right-input" name="placeStdStr01"  /></td>
				</tr>
			 --%>
				
				<tr>
				<!-- 관리자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager"></spring:message> :  </td>
					<td colspan="3">
						<input type="text" id="placeManagerNm" class="btn-input" name="placeManagerNm" format="text" readonly/>
						<input type="hidden" id="placeManager" name="placeManager"/>
						<button class="k-button k-primary" type="button"  onclick="lfn_userInfoPop_Open(lfn_userInfoPop_callback)">
				<!-- 조회 -->
						<spring:message code ="btn_search"></spring:message></button>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
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
			<button class="k-button k-primary final-btn" type="button" onclick = "lfn_popSave('jtePopForm_form')"><spring:message code = "pop_save"></spring:message></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/rlehoMgt/rlehoMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
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
	
	// lfo_common = {};
	
	lfo_common.layoutId = "jteSubGrid";
	
	lfo_common.popId = "jtePopForm";
	
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/rlehoMgt";
	
	
	lfo_common.crud  = {
			read:{url:"/getPlaceList", auth:"", prmt:{}, dynamicPrmt:{placeParent:"jteMasterTree_hidSelected"}}, 
			create:{url:"/setPlaceSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
			//update:{url:"/", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
			destroy:{url:"/setPlaceDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	lfo_common.model = {
			id: "placeId",
			field:{
				placeId : { type: "string" },
				placeNm : { type: "string" },
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
			title:gfn_getMsg("btn_update"), width: 90},																//201113 YUMI_깨지는 현상 수정 85->90
		{field: "placeId", title:gfn_getMsg("col_placeCd"), width: "150px"},										//위치코드  
		{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: "200px"},										//위치명
		{field: "placeManagerNm", title:gfn_getMsg("col_manager"), width: "200px"},									//관리자
		{field: "placeSeq", title:gfn_getMsg("col_sequence"), width: "80px"},										//순서
		{field: "placeStd01", title:"예비1(숫자)", width: "120px"},
		{field: "placeStd02", title:"예비2(숫자)", width: "120px"},
		{field: "placeStrStd01", title:"예비1(문자)", width: "120px"},
		{field: "placeStrStd02", title:"예비2(문자)", width: "120px"},
		{field: "description", title:gfn_getMsg("col_desc"), width: "300px"},										//설명
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"120px",			//사용유무
				template : function(rows) {
					if(rows.use == false){
						return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
					}else if (rows.use == true){
						return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
					}else{
						return ""+gfn_getMsg("val_basic")+" : Y";														//기본
					}
				}
		}
	];
	lfo_common.selectBox = [ 
		{ text: gfn_getMsg("col_placeNm"), value: "place.place_nm" },			//위치명
		{ text: gfn_getMsg("col_placeCd"), value: "place.place_id" },			//위치코드
		{ text: gfn_getMsg("col_desc"), value: "place.description" }			//설명
	];
	
	lfo_common.grid = gfn_grid_set(lfo_common);

}

this.lfn_jteSubGrd_eventBind = function(){
	//검색 Selectbox 바인딩 
/* 	var shBoxItem = [
			{ text: gfn_getMsg("col_placeNm"), value: "place.place_nm" },			//위치명
			{ text: gfn_getMsg("col_placeCd"), value: "place.place_id" },			//위치코드
			{ text: gfn_getMsg("col_desc"), value: "place.description" }			//설명
		];
	$("#jteSubGrd_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: shBoxItem,
		index: 0
	}); */
	
	//검색박스 엔터 이벤트
/* 	$("#jteSubGrd_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_jteSubGrd_search();
		}
	}); */
	
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
/*	
	//마스터테이블 더블 클릭
	$("#jteSubGrid tbody").on("dblclick", "tr", function(e){
		//선택한 항목 바인드
//  		var selectedItem = lfo_common.sgGrid.dataItem($(this));
		lfn_jtePop_open("EDT",lfo_common.grid.dataItem($(e.target).closest('tr')));
	});
*/
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	
	var options = {
		modal:true, 
		width: "550px", 
		height: "316px", /* 04.29 JJW 565 --> 600px로 수정_201112 YUMI 320->322px */
		id:lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_placeRegist");			//자재 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_placeDetailSrh");				//자재 조회
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
			//data: {placeId : selectedItem.placeId},
			success: function(data){
				gfn_popform_set(lfo_common, mode,dataItem);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		}); 
	}
	/*
	//그리드 세팅
	if($("#jteSubGrid").html() ==""){
		lfn_jteSubGrd_setGrd();
	} else{
		//Grid 재 바인딩 안하면 공통 Popup parameter 값 변경 안됨. -> 재 바인딩 시 기존 바인딩 된 Grid와 충돌 -> Empty 후 재 바인딩.
		$("#jteSubGrid").empty();
		lfn_jteSubGrd_setGrd();
	}
	*/
}

//Form내용 입력/저장
this.lfn_popSave = function(){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		console.log(savePrmt);
		//savePrmt.placeParent = $("#jteMasterTree_hidSelected").val();
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.create.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data > 0){
					gfn_closePop("jtePopForm");
				
					lfo_common.mtTree.dataSource.read();
					lfo_common.grid.dataSource.read();

					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					//setTimeout(function() {
						//lfo_common.mtTree.expandPath(lfo_common.mtTreeExpand);
					//}, 500);
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
			lfo_common.mtTree.dataSource.read();
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
//잠금유무
this.lfn_jteSubGrd_changeIsUse = function(rows){
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {placeId : dataItem.placeId, action : "USE", use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/setPlaceSave",
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
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

</script>