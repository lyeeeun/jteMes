<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="mtrlInfoForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrlInfoForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrlInfoForm">
			<div class="pop_title"><spring:message code = "pop_mtrlInfo"></spring:message></div>		<!-- 자재정보 -->
			<table id="jtePopForm_master" class="jtePopForm_master">
			<colgroup>
				<col class="col-left-title"> <!-- 13 27 13 27 -->
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr>
				<!-- 자재코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlCd"></spring:message> : </td>
					<td><input type="text" id="mtrlId" class="left-input" name="mtrlId"  placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 자재유형 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlType"></spring:message> : </td>
					<td><input id="mtrlType" class="right-input" name="mtrlType" format="selBox" msg="mtrl_div"/></td>
				</tr>
				<tr>
				<!-- 자재명 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_mtrlNm"></spring:message> : </td>
					<td colspan="3"><input type="text" id="mtrlNm" class="k-textbox center-input" name="mtrlNm" format="text"/></td>
				</tr>
				<tr>
				<!-- 자재규격 -->
					<td><i class="fas fa-caret-right"></i>자재규격 :</td>
					<td colspan="3"><input type="text" id="mtrlStdStr01" class="k-textbox center-input" name="mtrlStdStr01"/></td>
				</tr>
				<tr>
				<!-- 단가 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_unitPrice"></spring:message> : </td>
					<td><input id="mtrlCost" class="left-input" name="mtrlCost"  format = "currency"/></td>
				<!-- 시효기간 -->
	 				<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_prescripPeriod"></spring:message> : </td>
					<td><input type="text" id="mtrlUseday" class="right-input" name="mtrlUseday" format="currency"/></td>
				<tr>
<%-- 				<!-- 자재구분 -->
 					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlDiv"></spring:message> : </td>
					<td>
						<input type="text" id="mtrlDiv" class="right-input" name="mtrlDiv" format="text"/>
						<input type="hidden" id="description" name="description">
					</td>
 					<td>
						<button class="k-button k-primary jte-msgBox" type="button" prefix = "mtrl" defId="mtrlId" defNm="mtrlNm" >
 				<!-- 다국어 -->
						<spring:message code = "pop_msgLang"></spring:message></button>
						<input type="hidden" id="msg_mtrlId" />
					</td>
				</tr>
				<tr>
				<!-- 단가 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_unitPrice"></spring:message> : </td>
					<td><input id="mtrlCost" class="left-input" name="mtrlCost"  format = "currency"/></td>
					
				<!-- HCD구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlHCD"></spring:message> : </td>
					<td><input id="mtrlHCD" class="right-input" name="mtrlHCD" format="selBox" msg="mtrl_HCD"/></td>
				</tr>
				<tr>
				<!-- 소재Φ -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_width"></spring:message> : </td>
					<td><input type="text" id="mtrlStd01" class="left-input" name="mtrlStd01" format="numeric" /></td> --%>
				<tr style="display:none;">
					<!-- 필요한 부분에 꺼내쓰시오 - jkkim -->
					<td><i class="fas fa-caret-right"></i>예비2(String) :</td>
					<td><input type="text" id="mtrlStdStr02" class=left-input name="mtrlStdStr02"/></td>
					<td><i class="fas fa-caret-right"></i>예비3(String) :</td>
					<td><input type="text" id="mtrlStdStr03" class=left-input name="mtrlStdStr03"/></td>
					<td><i class="fas fa-caret-right"></i>예비4(String) :</td>
					<td><input type="text" id="mtrlStdStr04" class=left-input name="mtrlStdStr04"/></td>
					<td><i class="fas fa-caret-right"></i>예비5(String) :</td>
					<td><input type="text" id="mtrlStdStr05" class=left-input name="mtrlStdStr05"/></td>
				</tr>
				<tr>
				<!-- 무게 -->
					<td><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_weight"></spring:message> : </td>
					<td><input type="text" id="mtrlStd03" class="left-input" name="mtrlStd03" format="numeric" /></td>
				<!-- 단위 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_unit"></spring:message> : </td>
					<td><input type="text" id="mtrlStd04" class="right-input" name="mtrlStd04" format="selBox" msg="comn_unit"/></td>
				</tr>
					<!-- 04.29|ymlee|예비 규격, 소재 주석 -->
<%-- 				<tr>
					<td><i class="fas fa-caret-right"></i>자재규격,소재 예비1 : </td>
					<td><input type="text" id="mtrlStd04" class="left-input" name="mtrlStd04" format="currency"/></td>
					<td><i class="fas fa-caret-right"></i>자재규격,소재 예비2 : </td>
					<td><input type="text" id="mtrlStd04" class="right-input" name="mtrlStd05" format="currency"/></td>
				</tr> --%>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="mtrlDesc" class="k-textbox center-input" name="mtrlDesc"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="mtrl_action"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		<!-- 업체관리 -->
		<div class="pop_title"><spring:message code = "pop_compMgt"></spring:message></div>
		<div id="jtePopForm_grid" class="mtrlInfoForm"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/mtrlInfo/mtrlInfoForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/operMgt/mtrlInfo/mtrlInfoForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

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
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/mtrlInfo"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getMtrlInfoList", auth:"", prmt:{}}, 
		create:{url:"/setMtrlInfoSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setMtrlInfoSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		destroy:{url:"/setMtrlInfoDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "mtrlId",
		fields: {
			mtrlId : { type: "string" },
			mtrlNm: { type: "string" },
			mtrlDesc: { type: "string" },
			mtrlType: { type: "string" },
			mtrlHCD: { type: "string" },
			mtrlStd01: { type: "int" },
			mtrlStd02: { type: "int" },
			mtrlStd03: { type: "int" },
			mtrlStd04: { type: "string" },
			mtrlStd05: { type: "int" },
			mtrlStdStr01 : { type: "string" },
			mtrlStdStr02 : { type: "string" },
			mtrlStdStr03 : { type: "string" },
			mtrlStdStr04 : { type: "string" },
			mtrlStdStr05 : { type: "string" },
			mtrlUseday: { type: "int" },
			mtrlCost: { type: "int" },
			createdAt: { type: "string" },
			updatedAt: { type: "string" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			mtrlDiv: { type: "string" },
			isUse: { type: "bool" },
			mtrlQual: { type: "string" },
			mtrlUnit: { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlId", title:gfn_getMsg("col_mtrlCd"), width: "110px"},											//자재코드
		//{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "130px"},									//자재구분
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "170px"},											//자재명
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlType"), width: "90px;"},														//자재유형
		{field: "mtrlCost", format: "{0:n0}", title:gfn_getMsg("col_unitPrice"), width: "100px"},					//단가
		{field: "mtrlUseday", format: "{0:n0}", title:"시효기간", width: "100px"},
/* 		{field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlHCD"), width: "110px;"},														//HCD구분
		{field: "mtrlStd01",format: "{0:n}", title:gfn_getMsg("col_width"), width: "100px"},						//소재Φ
		{field: "mtrlStd02", format: "{0:n}", title:gfn_getMsg("col_mainHall"), width: "100px"},					//본당기장 */
		{field: "mtrlStd03", format: "{0:n}", title:gfn_getMsg("col_weight"), width: "100px"},						//무게 
		{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
				title:gfn_getMsg("col_unit"), width: "100px"},														//단위
 		{field: "mtrlStdStr01", title : "자재규격", width: "260px"},											//예비1(Str)
 		/*{field: "mtrlStdStr02", title : "예비2(Str)", width: "100px"},											//예비2(Str)
 		{field: "mtrlStdStr03", title : "예비3(Str)", width: "100px"},											//예비3(Str)
 		{field: "mtrlStdStr04", title : "예비4(Str)", width: "100px"},											//예비4(Str)
 		{field: "mtrlStdStr05", title : "예비5(Str)", width: "100px"},											//예비5(Str) */
		{field: "mtrlDesc", title:gfn_getMsg("col_desc"), width: "330px"},											//설명
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"90px",			//사용유무
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic")+" : Y";														//기본
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [ 
		//{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },			//자재구분
		{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },				//자재명
		{ text: gfn_getMsg("col_mtrlCd"), value: "mtrlInfo.mtrl_id" }				//자재코드
	];
	//8.
	lfo_common.validation ={
		mtrlNm:{
			messages : "자재명을 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		mtrlStdStr01:{
			messages : "자재규격을 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlStdStr01]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		}
/* 		mtrlDiv:{
			messages : "자재구분을 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlDiv]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		mtrlStd01:{
			messages : "소재Ø를 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlStd01]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		mtrlStd02:{
			messages : "본당기장을 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlStd02]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		mtrlStd03:{
			messages : "무게를 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlStd03]")){
					return input.val().length != 0;
				}
				return true;
			}
		} */
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "705px", 
		height: "695px", /* 04.29 JJW 565 --> 600px로 수정 */
		id:lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlRegist");			//자재 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlSrh");				//자재 조회
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
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem["mtrlId"];
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {mtrlId:lfo_common.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	//그리드 세팅
	if($("#jtePopForm_grid").html() ==""){
		lfn_jtePopGrd_setGrd();
	} else{
		//Grid 재 바인딩 안하면 공통 Popup parameter 값 변경 안됨. -> 재 바인딩 시 기존 바인딩 된 Grid와 충돌 -> Empty 후 재 바인딩.
		$("#jtePopForm_grid").empty();
		lfn_jtePopGrd_setGrd();
	}
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
	
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
					lfn_jtePop_set('EDT',data);
					lfo_common.grid.dataSource.read();
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
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//사용유무
this.lfn_jteSgGrd_changeIsUse = function(rows){
	
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {mtrlId : dataItem.mtrlId, action : "USE", use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.update.url,
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



//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	
	lfo_popGrd = {};
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
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	//lfo_popGrd.popId = "";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/basMgt/operMgt/mtrlInfo"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlRtlCompList", auth:"", prmt:{mtrlId: lfo_common.gridSelected}}, 
		create:{url:"/setMtrlRtlCompSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"", auth:"", openFunc:"", callback:""},
		destroy:{url:"/setMtrlRtlCompDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "compId",
		fields: {
			compId: { type: "string" },
			mtrlId: { type: "string" },
			compNm: { type: "string" },
			compManagr: { type: "string" },
			compNumber: { type: "string" },
			compType: { type: "string" },
			compAddr: { type: "string" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			description: { type: "string" },
			isUse: { type: "bool" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "compId", title:gfn_getMsg("col_compCd"), width: "140px"},				//업체코드
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "180px"},				//업체명
		{field: "description", title:gfn_getMsg("col_desc"), width: "250px"}			//비고
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_compNm"), value: "comp.comp_nm" },			//업체명
		{ text: gfn_getMsg("col_compCd"), value: "comp.comp_id" },			//업체코드
		{ text: gfn_getMsg("col_desc"), value: "comp.description" }			//비고
	];
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(selectedItem){

	//여기부터 공통팝업 띄우기
	gfn_openCustomPop('company',lfn_jtePopGrd_save);
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(savePrmt){
	savePrmt.mtrlId = lfo_common.gridSelected;
	
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.create.url,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				//마스터 그리드 리로드
				lfo_common.grid.dataSource.read();
				//이전 팝업화면 리로드
				lfn_jtePop_set('EDT',lfo_common.gridSelected);
				
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

//삭제 콜백
this.lfn_jtePopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_popGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_popGrd.grid.dataSource.read();
			
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
</script>