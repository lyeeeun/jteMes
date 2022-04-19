<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="grpAuthForm" style="width: 100%;">
	<div id="jteMasterGrid" class="grpAuthForm left-contents"></div>
	<div class="grpAuthForm middle-contents"><span><i class="fas fa-caret-square-right fa-3x"></span></i></div>
	<div id="jteSubGrid" class="grpAuthForm right-contents"></div>
</div>

<div style="display:none;">
	<div id="jtePopForm" class="grpAuthForm-div">
		<form id="jtePopForm_form" class="grpAuthForm">
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:35%;">
				<col style="width:15%;">
				<col style="width:30%;">
				<col style="width:20%;">
			</colgroup>
			<tr><td colspan="4"></td></tr>			
				<tr>
				<!-- 권한 그룹 코드 -->
					<td><i class="fas fa-caret-right"></i>권한 그룹 코드 : </td>
					<td colspan="3"><input type="text" id="roleId" name="roleId" readonly/></td>
				</tr>
				<tr>
				<!-- 권한 그룹명 -->
					<td><i class="fas fa-caret-right"></i>권한 그룹명 :  </td>
					<td colspan="3"><input type="text" id="roleNm" name="roleNm" /></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i>설명 :  </td>
					<td colspan="3"><input type="text" id="description" name="description" /></td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display : none;"><spring:message code = "pop_save"/></button>				<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display : none;"><spring:message code = "pop_save"/></button>				<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>		<!-- 취소 -->
		</div>
	</div>
</div>




<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/menuMgt/menuAuth/menuAuthForm_lym.css' rel="stylesheet" type="text/css"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/authMgt/grpAuth/grpAuthForm_JJW.css' rel="stylesheet">

<script>
var lfo_common = {};//권한그룹코드 Object

var lfo_subGrd = {}; //서브그리드 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteMtGrd_setGrd();
	
	//데이터 생성
	//lfn_jteMtGrd_eventBind();
	
	
	//lfo_common.masterGrid = $("#jteMasterGrid").getKendoGrid();
	//lfo_common.subGrid = $("#jteSubGrid").getKendoGrid();
};

//MasterGrid 생성
this.lfn_jteMtGrd_setGrd = function(){
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
	lfo_common.layoutId = "jteMasterGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/authMgt/grpAuth";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getRoleGrp", auth:"", prmt:{}}, 
		create:{url:"/setRoleGrpInsert", auth:"", openFunc: lfn_jtePop_open, callback: lfn_popSave}, 
		update:{url:"/setRoleGrpUpdate", auth:"", openFunc:"", callback: lfn_popSave},
		destroy:{url:"/setRoleGrpDelete", auth:"", callback: lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
			id: "roleId",
			fields: {
				roleId : { type: "string" },
				roleNm : { type: "string" },
				description : { type: "string" }
			}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:40},
		{field: "roleId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>'+
			'<button class="k-button k-primary" type="button" onclick = "lfn_jteSubGrd_setGrd(this)" style="min-width:60px;">' + "권한보기" + '</button>',
			title:"버튼", width: "180px"},
		{field: "roleId", editable: lfn_jteMtGrd_isEditable, title:gfn_getMsg("col_authGrpCd"), width: "150px"}, 		//권한그룹코드
		{field: "roleNm", title:gfn_getMsg("col_authGrpNm"), width: "200px"}, 											//권한그룹명
		{field: "description", title:gfn_getMsg("col_desc"), width: "330px"}											//설명	
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "권한그룹코드", value: "roleId" },
		{ text: "권한그룹명", value: "roleNm" },
		{ text: "설명", value: "description" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//SubGrid 생성
this.lfn_jteSubGrd_setGrd = function(rows){
	$("jteSubGrid").html("");
	
	lfo_common.gridSelected = lfo_common.grid.dataItem($(rows).closest("tr"));

	
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
	
	//lfo_common.gridSelected = lfo_common.grid.dataItem($(rows).closest("tr"));
	
	//1.
	lfo_subGrd.layoutId = "jteSubGrid";
	
	//2.
	lfo_subGrd.popId = "jtePopForm";
	
	//3.
	lfo_subGrd.ctrlUrl = "/form/basMgt/authMgt/authInfo";
	
	//4.
	lfo_subGrd.crud  = {
		read:{url:"/getGrpAuthList", auth:"", prmt:{dynamicField : "roleInfo.roleId", dynamicValue : lfo_common.gridSelected.roleId}}, 
		//create:{url:"/setRoleGrpInsert", auth:"", openFunc: lfn_jtePop_open, callback: lfn_popSave}, 
		//update:{url:"/setRoleGrpUpdate", auth:"", openFunc:"", callback: lfn_popSave},
		//destroy:{url:"/setRoleGrpDelete", auth:"", callback: lfn_jteGrid_delete}
	};
	
	//5.
	lfo_subGrd.model = {
			id: "authId",
			fields: {
				roleId : { type: "string" },
				authId : { type: "string" },
				reqSvcUri : { type: "string" },
				description : { type: "string" },
				isUse : { type: "bool" }
			}
	};
	
	//6.
	lfo_subGrd.columns = [
		{title:"No.", width:50, template: "#=++record #"},
		{field: "authId", title:gfn_getMsg("col_authId"), width: "20%"},			//권한코드
		{field: "reqSvcUri", title:gfn_getMsg("col_authPath"), width: "20%"}, 		//권한경로
		{field: "description", title:gfn_getMsg("col_desc"), width: "45%"}, 		//설명
		{field: "isUse", title:gfn_getMsg("col_isuse"), width:"15%",				//사용유무
				template : function(rows) {
					if(rows.use == true){
						return "<a onclick='lfn_jteSubGrd_changeInclude(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
					}else if (rows.use == false){
						return "<a onclick='lfn_jteSubGrd_changeInclude(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
					}
				}
		}
		
	];
	
	//7.
	lfo_subGrd.selectBox = [
		{ text: gfn_getMsg("col_authId"), value: "authId" },
		{ text: gfn_getMsg("col_authPath"), value: "reqSvcUri" },
		{ text: gfn_getMsg("col_desc"), value: "description" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_subGrd.grid = gfn_grid_set(lfo_subGrd);
}
//inputbox 비활성화(insert 활성화, update 비활성) 
this.lfn_jteMtGrd_isEditable = function(e){
	return gfn_isNull(e.roleId);
}

//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "460px",
		height: "273px", // 200519 JJW 600-> 580_201111 YUMI 310->267_201201 YUMI 267->273
		id : "jtePopForm" , 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = "권한 그룹 추가"
	}else if(mode=="EDT"){
		selectedItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		options.title = "권한 그룹 수정"
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "NONE";
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
		$("#jtePopForm #roleId").attr("readonly", false);
	}else if(mode == 'EDT'){
		
		var savePrmt = {};
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.roleId =  selectedItem;
		}
		gfn_popform_set(lfo_common, mode,selectedItem);
	}
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url ,
			type: "POST",
			data: savePrmt,
			success: function(data){
				if(data != ""){
					//마스터그리 리로드
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_common.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				console.log(ex);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

this.lfn_jteGrid_delete = function(){

		var delPrmt = [];
		$(".k-checkbox").each(function(){
			if($(this).attr("aria-checked") == "true"){
				var dataItem = $("#jteMasterGrid").data("kendoGrid").dataItem($(this).closest("tr"));
				delPrmt.push(dataItem.roleId);
			}
		});
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setRoleGrpDelete",
			type: "POST",
			data: {roleIds : delPrmt},
			success: function(data){
				$("#jteMasterGrid").data("kendoGrid").dataSource.read();
				gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});

}

this.lfn_jteSubGrd_changeInclude = function(rows){
	 	
		var dataItem = lfo_subGrd.grid.dataItem($(rows).closest("tr"));

		var AppendPrmt = {authId : dataItem.authId, isInclude : dataItem.use, roleId: lfo_common.gridSelected.roleId };
			$.ajax({
				async:false,
				url : lfo_subGrd.ctrlUrl + "/setGrpAuthInclude",
				type: "POST",
	 			contentType: "application/json",
	 			data: JSON.stringify(AppendPrmt),
				dataType : 'json',
				success: function(data){
					lfo_subGrd.grid.dataSource.read();
					gfn_msgBox({msg:gfn_getMsg("pop_updateSuccess")});			//성공적으로 수정되었습니다.
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
}

</script>