<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="divInfoForm" style="width:100%;">
	<div id="jteSingleGrid" class="divInfoForm"></div>
</div>

<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="divInfoForm">
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:30%;">
				<col style="width:20%;">
				<col style="width:30%;">
				<col style="width:20%;">
			</colgroup>
			<tr><td colspan="4"></td></tr>			
				<tr>
				<!-- 아이디 -->
					<td><i class="fas fa-caret-right"></i>부서코드 : </td>
					<td colspan="3"><input type="text" id="deptId" name="deptId" readonly/></td>
				</tr>
				<tr>
				<!-- 이름 -->
					<td><i class="fas fa-caret-right"></i>부서명 :  </td>
					<td colspan="3"><input type="text" id="deptNm" name="deptNm" /></td>
				</tr>
				<tr>
				<!-- 이름 -->
					<td><i class="fas fa-caret-right"></i>순서 :  </td>
					<td colspan="3"><input type="text" id="deptSeq" name="deptSeq" format="currency"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="dept_action"/>
						<input type="hidden" name="use" id="isUse"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area divInfoForm-final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display : none;"><spring:message code = "pop_save"/></button>				<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display : none;"><spring:message code = "pop_save"/></button>				<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>		<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/belngMgt/divInfo/divInfoForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	//그리드 생성
	lfn_jteSgGrd_setGrd();
}

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
	lfo_common.ctrlUrl = "/form/basMgt/belngMgt/divInfo"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getDeptList", auth:"", prmt:{}}, 
		create:{url:"/setDeptSave", auth:"", openFunc: lfn_jtePop_open, callback: lfn_popSave}, 
		update:{url:"/setDeptSave", auth:"", openFunc: "", callback: lfn_popSave},
		destroy:{url:"/setDeptDelete", auth:"", callback: lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "deptId",
		fields: {
			deptId : { type: "string" },
			deptNm : { type: "string" },
			deptSeq : { type: "int" },
			deptStd01 : { type: "string" },
			deptStd02 : { type: "string" },
			deptStd03 : { type: "string" },
			deptStd04 : { type: "string" },
			deptStd05 : { type: "string" },
			deptStdStr01 : { type: "string" },
			deptStdStr02 : { type: "string" },
			deptStdStr03 : { type: "string" },
			deptStdStr04 : { type: "string" },
			deptStdStr05 : { type: "string" },
			isUse : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"30px"},
		//{title:"No.", width:"50px", template: "#=++record #"},
		{field: "deptId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "보기" + '</button>',
			title:"수정", width: 60},
		{field: "deptId", title:"부서코드", width: "160px"},			//직급코드
		{field: "deptNm", title:gfn_getMsg("col_deptNm"), width: "210px"},												//직급명
		{field: "deptSeq" , title:gfn_getMsg("col_sequence"), width: "120px"},												//순서
		//{field: "deptStdStr01" , title:"예비1(str)", width: "120px"},															//예비1(str)
		//{field: "deptStd01" , title:"예비1", width: "120px"},																	//예비1
		{field: "isUse", title:gfn_getMsg("col_isuse"), width:"120px",					//사용유무
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic")+" : Y";																//기본
				}
			}
		},
	];
	
 	lfo_common.customTitle = {
			html :	'<button class="k-button k-primary" type="button" onclick = "gfn_excelUplodePop(\'mtrl\'); " style="min-width:60px; float: right;">Excel Upload</button>'
		}

	
	//7.
	lfo_common.selectBox = [
		{ text: "부서명", value: "deptNm" },
		{ text: "부서코드", value: "deptId" },
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
		id : lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = "부서 추가"
	}else if(mode=="EDT"){
		options.title = "부서 수정"
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			deptId : lfo_common.gridSelected.deptId,
		}
		gfn_popform_set(lfo_common, mode);
		$("#jtePopForm #deptId").attr("readonly", false);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {deptId : selectedItem};
		}
		gfn_popform_set(lfo_common, mode,lfo_common.gridSelected);
	}
}
//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		savePrmt.use = $("#isUse").val();
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
					//팝업종료
					gfn_closePop(lfo_common.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					//마스터그리 리로드
					lfo_common.grid.dataSource.read();
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
//inputbox 비활성화(insert 활성화, update 비활성) 
this.lfn_jteSgGrd_isEditable = function(e){
	return gfn_isNull(e.deptId);
}

//inputbox 비활성화(insert 활성화, update 비활성) 
this.lfn_jteSgGrd_isEditable2 = function(e){
	return false;
}
//사용유무
this.lfn_jteSgGrd_changeIsUse = function(rows){
	
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {deptId : dataItem.deptId, deptNm : dataItem.deptNm, deptSeq: dataItem.deptSeq, use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/setDeptUseUpdate",
		type: "POST",
		data: JSON.stringify(prmt),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				lfo_common.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
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
		url : lfo_common.ctrlUrl + "/setDeptDelete",
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