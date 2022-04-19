<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="authInfoForm" style="width:100%;">
	<div id="jteSingleGrid" class="authInfoForm"></div>
</div>
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="authInfoForm">
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:30%;">
				<col style="width:20%;">
				<col style="width:30%;">
				<col style="width:20%;">
			</colgroup>
				<tr><td colspan="4"></td></tr>			
				<tr>
				<!-- 권한 코드 -->
					<td><i class="fas fa-caret-right"></i>권한 코드 : </td>
					<td colspan="3"><input type="text" id="authId" name="authId" readonly/></td>
				</tr>
				<tr>
				<!-- 권한 경로 -->
					<td><i class="fas fa-caret-right"></i>권한 경로 :  </td>
					<td colspan="3"><input type="text" id="reqSvcUri" name="reqSvcUri" /></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i>설명 :  </td>
					<td colspan="3"><input type="text" id="description" name="description" /></td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area authInfoForm-final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display : none;"><spring:message code = "pop_save"/></button>				<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display : none;"><spring:message code = "pop_save"/></button>				<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>		<!-- 취소 -->
		</div>
	</div>
</div>


<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/authMgt/authInfo/authInfoForm_JJW.css' rel="stylesheet">

<script>
var lfo_common = {};//Form 내부에서 사용될 Object 

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	 
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//grid 생성
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
	lfo_common.ctrlUrl = "/form/basMgt/authMgt/authInfo"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getAuthList", auth:"", prmt:{}}, 
		create:{url:"/setAuthSave", auth:"", openFunc: lfn_jtePop_open, callback: lfn_popSave}, 
		update:{url:"/setAuthUpdate", auth:"", openFunc:"", callback: lfn_popSave},
		destroy:{url:"/setAuthDelete", auth:"", callback: lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
			id: "authId",
			fields: {
				authId : { type: "string" },
				reqSvcUri : { type: "string" },
				description : { type: "string" }
			}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:40},
		{field: "authId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "보기" + '</button>',
			title:"수정", width: "90px"},
		{field: "authId", title:gfn_getMsg("col_authId"), width: "20%"},				//권한코드
		{field: "reqSvcUri", title:gfn_getMsg("col_authPath"), width: "25%"},			//권한경로
		{field: "description", title:gfn_getMsg("col_desc"), width: "55%"}				//설명
		
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "권한 아이디", value: "authId" },
		{ text: "권한경로", value: "reqSvcUri" },
		{ text: "설명", value: "description" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "460px",
		height: "267px", // 200519 JJW 600-> 580_201111 YUMI 310->267
		id : "jtePopForm" , 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = "권한 추가"
	}else if(mode=="EDT"){
		selectedItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		options.title = "권한 수정"
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
		$("#jtePopForm #authId").attr("readonly", false);
	}else if(mode == 'EDT'){
		
		var savePrmt = {};
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.authId =  selectedItem;
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
		}
	});
}

</script>