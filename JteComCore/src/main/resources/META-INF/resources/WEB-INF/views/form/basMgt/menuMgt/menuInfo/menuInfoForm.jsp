<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- <div id="grid-content" class="menuInfoForm">
	<div id="jteMasterTree" class="jteMasterTree left-content-box"></div>	style="display:inline-block; width:39%; height:100%; float:left; box-shadow: 0px 0px 4px 2px rgba(0, 0, 0, 0.13);  background:#f8f8f8;"
	<input type="hidden" id = "jteMasterTree_hidSelected" class="jteMasterTree_hidSelected" value="root">
	<div id="jteSubGrid" class="jteSubGrid right-content-box"></div>	style="display:inline-block; width:60%; height:100%; float:right;"
</div> -->

<!-- 20.08.10 JJW 반응형 웹 -->
<div id="grid-content" class="menuInfoForm" style="width: 100%;">
	<div id="jteMasterTree" class="menuInfoForm left-contents jteMasterTree"></div>
	<!--메뉴트리 선택값 저장 -->
	<input type="hidden" id = "jteMasterTree_hidSelected" class="jteMasterTree_hidSelected" value="root">
	<div class="menuInfoForm middle-contents"><span><i class="fas fa-caret-square-right fa-3x"></span></i></div>
	<div id="jteSubGrid" class="menuInfoForm right-contents"></div>
</div>

<!-- 메뉴 입력 폼 -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="menuInfoForm" >
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:31%;">
				<col style="width:20%;">
				<col style="width:31%;">
			</colgroup>
				<tr><td colspan="4"></td></tr>					
				<tr>
				<!-- 메뉴코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_menuCd"/> : </td>
					<td><input type="text" id="menuId" name="menuId" class="jtePopForm_onlyInsert"/></td>
				<!-- 메뉴구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_menuDiv"/> : </td>
					<td><input id="menuCd" name="menuCd" format = "selBox" msg="comn_isDupl" keyGbn="cdVal" class="jtePopForm_onlyInsert"/></td>
				</tr>
				<tr>
				<!-- 메뉴명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_menuNm"/> :  </td>
					<td colspan="3">
						<input type="text" id="menuNm" class="btn-input" name="menuNm" format="text"/>
						<!-- 다국어 -->
						<button class="k-button k-primary jte-msgBox " type="button" prefix = "mn" defId="menuId" defNm="menuNm" >
							<spring:message code = "pop_msgLang"></spring:message>
						</button>
						<input type="hidden" id="msg_menuId" />
					</td>
				</tr>
				<tr>
				<!-- 메뉴경로 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_menuPath"/> : </td>
					<td colspan="3">
						<input type="text" id="svcUrl" name="svcUrl" format="text"/>
					</td>
				</tr>
				<tr>
				<!-- 중복여부 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_duplyn"/> : </td>
					<td><input id="duplYn" name="duplYn" format = "selBox" keyGbn="cdVal" msg="comn_isUse"/></td>
				<!-- 순서 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_sequence"/> : </td>
					<td><input type="text" id="menuSeq" name="menuSeq" format="currency"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code="col_desc"/> : </td>
					<td colspan="3"><input type="text" id="description" name="description" format="text"/></td>
				</tr>
				
				<!-- <tr>
					<td><i class="fas fa-caret-right"></i>예비1 : </td>
					<td colspan="3"><input type="text" id="menuStd01" class="center-input" name="menuStd01" format="text"/></td>
					<td><i class="fas fa-caret-right"></i>예비1 : </td>
					<td colspan="3"><input type="text" id="menuStd01" class="center-input" name="menuStd01" format="text"/></td>
				</tr> -->
				
				<tr>
					<td><i class="fas fa-caret-right"></i>예비1(str) : </td>
					<td><input type="text" id="menuStdStr01" class="center-input" name="menuStdStr01" format="text"/></td>
					<td><i class="fas fa-caret-right"></i>예비2(str) : </td>
					<td><input type="text" id="menuStdStr01" class="center-input" name="menuStdStr02" format="text"/></td>
				</tr>
				
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="menu_action" class="menu_action"/>
						<input type="hidden" name="upMenuId" id="upMenuId" class="upMenuId"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area menuInfoForm-final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn" type="button" onclick = "lfn_popSave('jtePopForm_form')"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
</div>
<div style="display:none;">
	<div id="excelSetPop" class="menuInfoForm">
		<div class="menuInfoForm excel-btn-area">
			<input type="text" class="k-textbox" id="tableId" name="tableId"/>
			<button id="columnInfoBtn" class="k-button k-primary" type="button" onclick="lfn_getColumnInfo('C')">Column 정보 조회</button>
			
			<input type="checkbox" id="rtlSystemYn" name="rtlSystemYn" class="k-checkbox" onclick="lfn_rtlSystemYnCheck()" style="margin-left:10px;" />
			<label for="rtlSystemYn">타 시스템 연동</label>
			
			<input type="text" class="k-textbox" id="rtlSystemSvc" name="rtlSystemSvc" style="display:none; width:300px;" placeholder="Service path ex)form.basMgt.... "/>
			<input type="text" class="k-textbox" id="rtlSystemMethod" name="rtlSystemMethod" style="display:none;" placeholder="Method name"/>
			
			<button id="delExcelSetBtn" class="k-button k-primary ExcelSet-btn" type="button" onclick="lfn_delExcelSetting()" style="float: right; display:none;">설정 삭제</button>
			<button class="k-button k-primary ExcelSet-btn" type="button" onclick="lfn_saveExcelSetting()" style="float: right; margin-right: 20px;">설정 저장</button>
			
			<input type="hidden" id="excelMenuId" name="excelMenuId" >
			<input type="hidden" id="action" name="action" >
		</div>
		<div>
			<table id="columnInfoTable" class="menuInfoForm columnInfoTable">
				
			</table>
		</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/menuMgt/menuInfo/menuInfoForm_JJW.css' rel="stylesheet">

<script>


this.lfn_rtlSystemYnCheck = function() {
	if($("#rtlSystemYn").prop("checked")) {
		$("#rtlSystemSvc").show();
		$("#rtlSystemMethod").show();
	} else {
		$("#rtlSystemSvc").hide();
		$("#rtlSystemMethod").hide();
	}
}
this.lfn_excelSetPop_open = function(selectedItem){
	
	var options = {
			modal:true, 
			width: "1350px", /** 200430 JJW 첫번째 팝업 너비 변경 550 -> 600px**/
			height: "371px", /** 200429 첫번째 팝업 height 변경 250px->335px_LYM 200430 JJW 250 -> 350_201015 youmi 350 -> 360_201111 YUMI 360->371**/
			id:"excelSetPop", 
			title:"Excel 설정", 
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};

	if(!gfn_isEmpty(selectedItem)){
		selectedItem = lfo_popGrd.subGrid.dataItem($(selectedItem).closest("tr"));
	}	

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		$('#excelMenuId').val(selectedItem.menuId);

		$.ajax({
			async:false,
			url : "/excelUtil/selectIsSet",
			type: "POST",
			data: JSON.stringify({menuId: selectedItem.menuId}),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data > 0) {
					$("#columnInfoBtn").hide();
					$("#tableId").hide();
					$("#delExcelSetBtn").show();

					lfn_getColumnInfo('U');
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	};
	this.gfn_winOpen(options);		
}

this.lfn_getColumnInfo = function(mode) {
	$('#columnInfoTable').empty();
	
	$("#action").val(mode);
	
	if(mode == "C") {
		var columnList = gfn_ajaxCallByList("tableInfo", {
			tableId: $("#tableId").val(),
			action: mode
		});	
	} else if(mode == "U") {
		var columnList = gfn_ajaxCallByList("tableInfo", {
			menuId: $("#excelMenuId").val(),
			action: mode
		});
	}
	
	
	console.log(columnList);
	if(columnList.rows.length == 0) {
		kendo.confirm("해당 Table은 조회되지 않습니다. 다시 입력하여 주십시오.");
		return false;
	}
	
	$('#columnInfoTable').append('<colgroup>' +
			'<col style="width: 5%">' +
			'<col style="width: 10%">' +
			'<col style="width: 10%">' +
			'<col style="width: 5%">' +
			'<col style="width: 10%">' +
			'<col style="width: 5%">' +
			'<col style="width: 10%">' +
			'<col style="width: 5%">' +
			'<col style="width: 10%">' +
			'<col style="width: 10%">' +
			'<col style="width: 10%">' +
			'<col style="width: 10%">' +
			'</colgroup>'		
	);

	$('#columnInfoTable').append('<tr style="font-weight:bold; text-align:center;">' +
			'<td>사용여부</td>' +
			'<td>Column ID</td>' +
			'<td>표시 명</td>' +
			'<td>PK 자동생성</td>' +
			'<td>자동생성 Key</td>' +
			'<td>기초코드 연동</td>' +
			'<td>기초코드 ID</td>' +
			'<td>참조 테이블 연동</td>' +
			'<td>참조 테이블 명</td>' +
			'<td>참조 테이블 PK</td>' +
			'<td>참조 테이블 표시 명</td>' +
			'<td>표시 순서</td>' +
			'</tr>'
	);
	
	$.each(columnList.rows, function(index, item) {
		$('#columnInfoTable').append('<tr id="' + item.columnId + '"><td><input type="checkbox" id="' + item.columnId + '" name="columnCheck" class="k-checkbox" value="' + item.columnId + '" /></td>' +
									 '<td><label for="' + item.columnId + '">' + item.columnId + '</label></td>' +
									 '<td><input type="text" class="k-textbox" name="columnNm" /></td>' +
									 '<td><input type="checkbox" class="k-checkbox" name="autoKeyYn" /></td>' +
									 '<td><input type="text" class="k-textbox" name="autoKey" /></td>' +
									 '<td><input type="checkbox" class="k-checkbox" name="listYn" /></td>' +
									 '<td><input type="text" class="k-textbox" name="cdId" /></td>' +
									 '<td><input type="checkbox" class="k-checkbox" name="rtlTableYn" /></td>' +
									 '<td><input type="text" class="k-textbox" name="rtlTableId" /></td>' +
									 '<td><input type="text" class="k-textbox" name="rtlTablePk" /></td>' +
									 '<td><input type="text" class="k-textbox" name="rtlTablePkNm" /></td>' +
									 '<td><input type="text" name="order"/></td>' +
									 '</tr>');
		
		$("#"+item.columnId+" [name=order]").kendoNumericTextBox({
			format: "n0",
			value: 0
		});
	});
	
	if(mode == "U") {
		$.each(columnList.rows, function(index, item) {
			if(index == 0) {
				if(item.rtlSystemYn) {
					$("#rtlSystemYn").prop("checked", item.rtlSystemYn);
					$("#rtlSystemSvc").val(item.rtlSystemSvc);
					$("#rtlSystemMethod").val(item.rtlSystemMethod);
					
					$("#rtlSystemSvc").show();
					$("#rtlSystemMethod").show();
				}
			}
			$("#" + item.columnId+ " [name=columnCheck]").prop("checked", item.checkYn);
			$("#" + item.columnId+ " [name=columnNm]").val(item.columnNm);
			$("#" + item.columnId+ " [name=autoKeyYn]").prop("checked", item.autoKeyYn);
			$("#" + item.columnId+ " [name=autoKey]").val(item.autoKey);
			$("#" + item.columnId+ " [name=listYn]").prop("checked", item.listYn);
			$("#" + item.columnId+ " [name=cdId]").val(item.cdId);
			$("#" + item.columnId+ " [name=rtlTableYn]").prop("checked", item.rtlTableYn);
			$("#" + item.columnId+ " [name=rtlTableId]").val(item.rtlTableId);
			$("#" + item.columnId+ " [name=rtlTablePk]").val(item.rtlTablePk);
			$("#" + item.columnId+ " [name=rtlTablePkNm]").val(item.rtlTablePkNm);
			$("#" + item.columnId+ " [name=order]").data("kendoNumericTextBox").value(item.order);
		});
	}
}

this.lfn_saveExcelSetting = function() {
	var savePrmt = {};
	savePrmt.columnList = new Array();
	
	var saveUrl = "";
	
	if($("#action").val() == "C") {
		saveUrl = "/excelUtil/insertExcelSetting";
	} else if($("#action").val() == "U") {
		saveUrl = "/excelUtil/updateExcelSetting";
	}
	
	$('#columnInfoTable').find('tr').each(function (index, item) {
		if(index == 0) {
			return true;
		}
		
		savePrmt.columnList.push({
			menuId: $('#excelMenuId').val(),
			tableId: $('#tableId').val(),
			columnId: $(item).attr('id'),
			columnNm: $(item).find("input[name='columnNm']").val(),
			autoKeyYn: $(item).find("input[name='autoKeyYn']").is(":checked"),
			autoKey: $(item).find("input[name='autoKey']").val(),
			listYn: $(item).find("input[name='listYn']").is(":checked"),
			cdId: $(item).find("input[name='cdId']").val(),
			rtlTableYn: $(item).find("input[name='rtlTableYn']").is(":checked"),
			rtlTableId: $(item).find("input[name='rtlTableId']").val(),
			rtlTablePk: $(item).find("input[name='rtlTablePk']").val(),
			rtlTablePkNm: $(item).find("input[name='rtlTablePkNm']").val(),
			rtlSystemYn: $("#rtlSystemYn").is(":checked"),
			rtlSystemSvc: $("#rtlSystemSvc").val(),
			rtlSystemMethod: $("#rtlSystemMethod").val(),
			order: $(item).find("input[name='order']").val(),
			checkYn: $(item).find("input[name='columnCheck']").is(":checked")
		});
		
	});
	
	$.ajax({
		async:false,
		url : saveUrl,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			gfn_closePop('excelSetPop');
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
}

this.lfn_delExcelSetting = function() {
	var delPrmt = {};
	
	delPrmt.menuId = $('#excelMenuId').val(); 
	
	$.ajax({
		async:false,
		url : "/excelUtil/deleteExcelSetting",
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			gfn_closePop('excelSetPop');
			
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});		
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
}

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfo_common.ctrlUrl = "/form/basMgt/menuMgt/menuInfo";
	
	dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: lfo_common.ctrlUrl + "/getMenuTree",
				dataType: "json"
			}
		},
		schema: {
			model: {
				id: "menuId",
				hasChildren: "hasChildren"
			}
		}
	});
	
	$("#jteMasterTree").kendoTreeView({
		dataSource: dataSource,
		dataTextField: "menuNm",
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
	}, 500);
	lfn_jteSubGrd_setGrd();
	

	
	$("#jteMasterTree").on("dblclick",".k-in", function(e){
		var item = lfo_common.mtTree.dataItem($(e.target).closest("li"));
		if(item.menuCd == "F"){
			$("#jteMasterTree_hidSelected").val(item.menuId);
			lfo_popGrd.subGrid.dataSource.read();
		}
	});
};
//메뉴 오픈 순서 기억
this.lfn_jteMtTree_expandPush = function(e){
	var item = lfo_common.mtTree.dataItem(e.node);
	lfo_common.mtTreeExpand.push(item.menuId);
}

//메뉴 클로즈시 해당부분 제거
this.lfn_jteMtTree_expandPop = function(e){
	var item = lfo_common.mtTree.dataItem(e.node);
	lfo_common.mtTreeExpand.pop(item.menuId);
}

//main - grid 생성
this.lfn_jteSubGrd_setGrd = function(){
	lfo_popGrd = {};//Form 내부에서 사용될 Object 
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
	lfo_popGrd.layoutId = "jteSubGrid";
	
	//2.
	lfo_popGrd.popId = "jtePopForm";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/basMgt/menuMgt/menuInfo";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMenuList", auth:"", prmt:{}, dynamicPrmt : {menuId : "jteMasterTree_hidSelected"}}, 
		create:{url:"/setMenuSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setMenuSave", auth:"", openFunc : "", callback:lfn_popSave}
		//destroy:{url:"/setMtrlMgtDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	
	//5.
	lfo_popGrd.model = {
			id: "menuId",
			fields: {
				menuId : { type: "string" },
				duplYn : { type: "string" },
				isDel: { type: "bool" },
				isLock : { type: "bool" },
				menuCd: { type: "string" },
				menuNm : { type: "string" },
				menuSeq : { type: "string" },
				msgId: { type: "string" },
				svcUrl: { type: "string" },
				ReportsTo: { type: "string" },
				upMenuId: { type: "string" },
				viewUrl: { type: "string" },
				createdAt: { type: "date" },
				updatedAt: { type: "date" },
				creatorId: { type: "string" },
				updatorId: { type: "string" },
				description: { type: "string" },
				hasChildren: { type: "bool" },
				menuStd01: { type: "int" },
				menuStd02: { type: "int" },
				menuStd03: { type: "int" },
				menuStd04: { type: "int" },
				menuStd05: { type: "int" },
				menuStdStr01: { type: "string" },
				menuStdStr02: { type: "string" },
				menuStdStr03: { type: "string" },
				menuStdStr04: { type: "string" },
				menuStdStr05: { type: "string" }
			}			
	};
	
	//6.
	lfo_popGrd.columns = [
		{field: "menuId",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;"><spring:message code = "btn_update"></spring:message></button>',
			title : gfn_getMsg("btn_search") , width: "90px"},	
		{field: "excelSetting",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_excelSetPop_open(this); " style="min-width:60px;">설정</button>',
				title : "Excel 설정" , width: "90px"},	
		{field: "menuSeq", title:gfn_getMsg("col_sequence"), width: "80px"},											//메뉴순서
		{field: "menuId", title:gfn_getMsg("col_menuCd"), width: "150px"},												//메뉴코드
		{field: "menuNm", title:gfn_getMsg("col_menuNm"), width: "200px"},												//메뉴명
		{field: "menuCd", template:"# var item = gfn_isNull(gfn_getCode(\"isDupl_\"+menuCd))== true ? '코드없음' : gfn_getMsg('bc_'+ gfn_getCode(\"isDupl_\"+menuCd).cdId , gfn_getCode(\"isDupl_\"+menuCd).cdNm) # #= item #",
				title:gfn_getMsg("col_menuDiv"), width: "110px"},														//메뉴구분
		{field: "svcUrl", title:gfn_getMsg("col_menuPath"), width: "200px"},											//메뉴경로
		{field: "description", title:gfn_getMsg("col_desc"), width: "300px"},											//설명
		//{field: "menuStd01", title:"예비1", width: "300px"},											//예비1
		//{field: "menuStdStr01", title:"예비1(str)", width: "300px"},											//예비1(str)
		{field: "isLock", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isLock"), width:"120px",			//잠금처리
				template : function(rows) {
					if(rows.lock == false){
						return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
					}else if (rows.lock == true){
						return "<a onclick='lfn_jteSubGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
					}else{
						return ""+gfn_getMsg("val_basic")+" : Y";															//기본
					}
				}
		}
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_menuCd"), value: "menu.menu_id" },				//메뉴코드
		{ text: gfn_getMsg("col_menuNm"), value: "menu.menu_Nm" },				//메뉴명
		{ text: gfn_getMsg("col_menuPath"), value: "menu.svc_url" },			//메뉴경로
		{ text: gfn_getMsg("col_desc"), value: "menu.description" }				//설명
	];
	
	//8.
	lfo_popGrd.validation ={
		menuCd:{
			messages : "메뉴코드을 입력하세요",
			rules : function(input){
				if(input.is("[name=menuCd]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		menuNm:{
			messages : "메뉴명을 입력하세요",
			rules : function(input){
				if(input.is("[name=menuNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		svcUrl:{
			messages : "메뉴경로를 입력하세요",
			rules : function(input){
				if(input.is("[name=svcUrl]")){
					return input.val().length != 0;
				}
				return true;
			}
		}
// 		,description:{
// 			messages : "설명을 입력하세요",
// 			rules : function(input){
// 				if(input.is("[name=description]")){
// 					return input.val().length != 0 && input.val().trim().length != "";
// 				}
// 				return true;
// 			}
// 		}
	}
	lfo_popGrd.subGrid = gfn_grid_set(lfo_popGrd);
}

//메뉴추가팝업 오픈
this.lfn_jtePop_open = function(mode,selectedItem){
	//다국어 초기화
	lfo_popGrd.msgTemp = {};
	
	var options = {
			modal:true, 
			width: "600px", /** 200430 JJW 첫번째 팝업 너비 변경 550 -> 600px**/
			height: "371px", /** 200429 첫번째 팝업 height 변경 250px->335px_LYM 200430 JJW 250 -> 350_201015 youmi 350 -> 360_201111 YUMI 360->371**/
			id:"jtePopForm", 
			title:"", 
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};

	if(mode=='NEW'){
		options.title = gfn_getMsg("pop_menuRegist");			//메뉴등록
	}else{
		if(!gfn_isEmpty(selectedItem)){
			selectedItem = lfo_popGrd.subGrid.dataItem($(selectedItem).closest("tr"));
		}
		$("#jteSubGrd_hidSelected").val(selectedItem["menuId"]);
		options.title = gfn_getMsg("pop_menuDetailSrh");			//메뉴상세조회
		
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);		
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	 lfo_popGrd.gridSelected = "NONE";
	if(mode=='NEW'){
		//입력시 특정값 변경 가능
		$(".jtePopForm_onlyInsert").attr('readonly', false);
		gfn_popform_set(lfo_popGrd, mode);
		$("#upMenuId").val($("#jteMasterTree_hidSelected").val());
	}else if(mode == 'EDT'){
		//수정시 특정값 변경불가
		$(".jtePopForm_onlyInsert").attr('readonly', true);
		if(typeof(selectedItem) == "object"){
			lfo_popGrd.gridSelected = selectedItem;
		}else if(typeof(selectedItem) == "string"){
			lfo_popGrd.gridSelected.menuId = selectedItem;
		}
		gfn_popform_set(lfo_popGrd, mode, selectedItem);
	}
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_popGrd.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + "/setMenuSave",
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					lfo_common.mtTree.dataSource.read();
					setTimeout(function() {
						lfo_common.mtTree.expandPath(lfo_common.mtTreeExpand);
					}, 300);
					lfo_popGrd.subGrid.dataSource.read();
					gfn_closePop('jtePopForm');
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

//잠금유무
this.lfn_jteSubGrd_changeIsUse = function(rows){
	var dataItem = lfo_popGrd.subGrid.dataItem($(rows).closest("tr"));
	var prmt = {menuId : dataItem.menuId, action : "LOCK", lock : dataItem.lock};
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + "/setMenuSave",
		type: "POST",
		data: JSON.stringify(prmt),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data > 0){
				lfo_common.mtTree.dataSource.read();
				lfo_popGrd.subGrid.dataSource.read();
				setTimeout(function() {
					lfo_common.mtTree.expandPath(lfo_common.mtTreeExpand);
				}, 300);
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

</script>