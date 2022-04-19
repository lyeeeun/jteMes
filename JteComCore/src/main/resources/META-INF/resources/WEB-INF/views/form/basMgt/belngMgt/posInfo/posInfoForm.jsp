<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="posInfoForm" style="width:100%;">
	<div id="jteSingleGrid" class="posInfoForm"></div>
</div>
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="posInfoForm">
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
					<td><i class="fas fa-caret-right"></i>직급코드 : </td>
					<td colspan="3"><input type="text" id="positionId" name="positionId" readonly/></td>
				</tr>
				<tr>
				<!-- 이름 -->
					<td><i class="fas fa-caret-right"></i>직급명 :  </td>
					<td colspan="3"><input type="text" id="positionNm" name="positionNm" /></td>
				</tr>
				<tr>
				<!-- 이름 -->
					<td><i class="fas fa-caret-right"></i>순서 :  </td>
					<td colspan="3"><input type="text" id="positionSeq" name="positionSeq" format="currency"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="position_action"/>
						<input type="hidden" name="use" id="isUse"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area posInfoForm-final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display : none;"><spring:message code = "pop_save"/></button>				<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display : none;"><spring:message code = "pop_save"/></button>				<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>		<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/belngMgt/posInfo/posInfoForm_JJW.css' rel="stylesheet">

<script>
var lfo_common = {};//Form 내부에서 사용될 Object 

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


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
	lfo_common.ctrlUrl = "/form/basMgt/belngMgt/posInfo"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getPositionList", auth:"", prmt:{}}, 
		create:{url:"/setPositionSave", auth:"", openFunc: lfn_jtePop_open, callback: lfn_popSave}, 
		update:{url:"/setPositionSave", auth:"", openFunc: "", callback: lfn_popSave},
		destroy:{url:"/setPositionDelete", auth:"", callback: lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "positionId",
		fields: {
			positionId : { type: "string" },
			positionNm : { type: "string" },
			positionSeq : { type: "int" },
			posStd01 : { type: "string" },
			posStd02 : { type: "string" },
			posStd03 : { type: "string" },
			posStd04 : { type: "string" },
			posStd05 : { type: "string" },
			posStdStr01 : { type: "string" },
			posStdStr02 : { type: "string" },
			posStdStr03 : { type: "string" },
			posStdStr04 : { type: "string" },
			posStdStr05 : { type: "string" },
			isUse : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"30px"},
		//{title:"No.", width:"50px", template: "#=++record #"},
		{field: "positionId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "보기" + '</button>',
			title:"수정", width: 60},
		{field: "positionId", title:gfn_getMsg("col_positionCd"), width: "160px"},			//직급코드
		{field: "positionNm", title:gfn_getMsg("col_positionNm"), width: "210px"},												//직급명
		{field: "positionSeq" , title:gfn_getMsg("col_sequence"), width: "120px"},												//순서
		//{field: "posStdStr01" , title:"예비1(str)", width: "120px"},															//예비1(str)
		//{field: "posStd01" , title:"예비1", width: "120px"},																	//예비1
		{field: "isUse", title:gfn_getMsg("col_isuse"), width:"120px",						//사용유무
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic")+" : Y";																	//기본
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "직급명", value: "positionNm" },
		{ text: "직급코드", value: "positionId" },
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "460px",
		height: "267px", //201111 YUMI 310->267
		id : lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = "직급 추가"
	}else if(mode=="EDT"){
		options.title = "직급 수정"
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
			positionId : lfo_common.gridSelected.positionId
		}
		gfn_popform_set(lfo_common, mode);
		$("#jtePopForm #positionId").attr("readonly", false);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {positionId : selectedItem};
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

//사용유무
this.lfn_jteSgGrd_changeIsUse = function(rows){
	
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {
			positionId : dataItem.positionId, 
			positionNm : dataItem.positionNm, 
			positionSeq : dataItem.positionSeq, 
			use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/setPositionUseUpdate",
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