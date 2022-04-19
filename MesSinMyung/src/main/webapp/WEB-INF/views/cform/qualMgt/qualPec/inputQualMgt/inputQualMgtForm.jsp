<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div style="width:100%">
	<div style="width:100%; background:#E2ECFF; padding:15px 0 15px 0; margin:10px 0 10px 0;">
	<input type="radio" name="qcpass" id="completeChk" class="k-radio" checked="checked" value="inspecComplete">
		<label class="k-radio-label" for="completeChk" style="vertical-align:middle; margin-left:15px;">검사완료</label>
		<input type="radio" name="qcpass" id="waitChk" class="k-radio" value="inspecWaiting">
		<label class="k-radio-label" for="waitChk" style="vertical-align:middle;">검사대기</label>
	</div>
	<div id="grid-content"  style="width:100%;">
		<div id="jteSingleGrid" class="mtrltoolMgtForm-jteSingleGrid"></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
		&nbsp;
		<div id="jteSubGrid" class="mtrltoolMgtForm-jteSubGrid"></div>   <!-- style="display:inline-block; width:59%; height:100%;" -->
	</div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrltoolMgtForm">
			<div class="pop_title">검사정보</div>
			<table style="width:100%;" id="jtePopForm_master">
			<colgroup>
				<col class="col-left-title"> <!-- 20 30 20 30 -->
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i>검사원 : </td>
					<td><input type="text" id="empCd" class="left-input" name="empCd" readonly/></td> 
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>검사일 :</td>
					<td><input type="text" id="qcDate" class="right-input" name="qcDate" readonly/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>발주번호 : </td>
					<td><input type="text" id="poNum" class="left-input" name="poNum" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>물품명 :</td>
					<td><input type="text" id="itemNm" class="right-input" name="itemNm" readonly/></td> 
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="qcNum" id="qcNum"/>
						<input type="hidden" name="itemCd" id="itemCd"/>
						<input type="hidden" name="use" id="inputQualUse"/>
						<input type="hidden" name="action" id="inputQualAction"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="pop_title">추가 등록 정보</div>
		<div id="jtePopInputQualAdd_grid" style="height:350px;"></div>
	</div>
</div>

<!-- 정비이력 등록/수정 팝업(서브 그리드 > 정비이력 버튼 클릭) -->
<div style="display:none;">
	<div id="jtePopToolAdd">
		<form id="jtePopToolAdd_form" class="mtrltoolMgtForm">
			<div class="pop_title">Control No</div>
			<table style="width:100%;" id="jtePopToolAdd_master" class="jtePopToolAdd_master">
			<colgroup>
				<col class="popsc-col-left-title"> <!-- 15 25 15 25 --> <!-- 200511 JJW 조회버튼을 위해 col 하나 더 추가 -->
				<col class="popsc-col-left-content-1">
				<col class="popsc-col-left-content-2">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i>Control_No : </td>
					<td colspan="2"><input type="text" id="controlNo" class="left-input" name="controlNo" placeholder="자동생성" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>검사수량 :</td>
					<td><input id="qty" class="right-input" name="qcQty" format="currency" /></td> 
				</tr>
				<tr>
 					<td><i class="fas fa-caret-right"></i>합격수량 : </td>
					<td colspan="2"><input id="stkQty" class="left-input" name="qcstkQty" format="currency" /></td> 
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>불합격수량 :</td>
					<td><input id="badQty" class="right-input" name="qcbadQty" format="currency" /></td> 
				</tr>
			</table>
			<div class="pop_title">Control 등록후에 Update</div>
			<table style="width:100%;" id="jtePopToolAdd_master-2">
			<colgroup>
				<col class="popsc-col-left-title"> <!-- 15 25 15 25 --> <!-- 200511 JJW 조회버튼을 위해 col 하나 더 추가 -->
				<col class="popsc-col-left-content-1">
				<col class="popsc-col-left-content-2">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i>제조일자 : </td>
					<td colspan="2"><input type="text" id="mfgDate" class="left-input" name="mfgDate" /></td> 
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>시효일자 :</td>
					<td><input type="text" id="expDate" class="right-input" name="expDate" /></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>로트번호 :</td>
					<td colspan="2"><input type="text" id="heatNo" class="left-input" name="heatNo" /></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>원제조사 : </td>
					<td colspan="4"><input type="text" id="makerOrg" class="center-input" name="makerOrg"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>결함내용 : </td>
					<td colspan="4"><input type="text" id="badDesc" class="center-input" name="badDesc" class="k-textbox"/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>비고 : </td>
					<td colspan="4"><input type="text" id="ctrlDesc" class="center-input" name="ctrlDesc" class="k-textbox"/></td> 
				</tr>				
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="qcNum" id="qcNum"/>
						<input type="hidden" name="use" id="inputQualAddUse"/>
						<input type="hidden" name="action" id="inputQualAddAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopToolAdd');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/mtrl/mtrltoolMgt/mtrltoolMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
 <link href='/resources/mes/css/contents/qualMgt/qualPec/inputQualMgt/inputQualMgtForm_JJW.css' rel="stylesheet"> 

<!-- 내부 스타일 외부로 이동_200511 JJW  -->

<script>

var lfo_dateBox = {};

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_subGrd = {};//서브그리드에서 사용될 Object

var lfo_inputQualAddGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	$("[name='qcpass']").change(function(e){
		lfn_clearLoadGrid();
	});
	
	//grid 최초 로드
	lfn_clearLoadGrid();
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
	//lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/qualMgt/qualPec/inputQualMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getInputQualList", auth:"", prmt:{use:false}, period:{stdt:-15, eddt:0}, qcpass : lfo_dateBox.qcpass}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		update:{url:"", auth:"", openFunc : "", callback:""}
		//destroy:{url:"", auth:"", callback:""}
	};

	//5.
	lfo_common.model = {
		id: "qcNum",
		fields: {
			coCd : { type: "string" },
			qcDate : { type: "string" },
			qcNum : { type: "string" },
			trNm : { type: "string" },
			empCd : { type: "string" },
			korNm : { type: "string" },
			pjtNm : { type: "string" },
			remarkDesc : { type: "string" },
			qcpassFg : { type: "string" },
			insertId : { type: "string" },
			insertDt : { type: "string" },
			modifyId : { type: "string" },
			modifyDt : { type: "string" }
		}
	};
	
	
	//6.
	lfo_common.columns = [
		{field: "qcNum",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jteSgGrid_dblclick(\'EDT\',this); " style="min-width:60px;">' + "조회" + '</button>',
			title : "조회" , width: "110px"},
		{field: "qcNum", title: "검사번호", width: "160px"},
		{field: "qcDate", title: "검사일자", width: "140px"},
		{field: "trNm", title: "거래처명", width: "140px;"},
		{field: "empCd", title: "검사담당자", width: "180px"},
		{field: "korNm", title: "검사의뢰자", width: "90px"},
		{field: "pjtNm", title: "프로젝트명", width: "120px"},
		{field: "remarkDesc", title: "비고", width: "250px"},
		{field: "qcpassFg", title: "검사현황", width: "250px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "검사번호", value: "qcstk.QC_NB" },
		{ text: "거래처명", value: "strade.TR_NM" },
		{ text: "프로젝트명", value: "spjt.PJT_NM" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_clearLoadGrid = function(){
	lfo_dateBox.qcpass = $("[name='qcpass']:checked").val();
}

//더블클릭 콜백(팝업)
this.lfn_jteSgGrid_dblclick = function(mode, selectedItem){
	lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
	//그리드 세팅
	if($("#jteSubGrid").html() !=""){
		$("#jteSubGrid").html("");
	}
	lfn_jteSubGrd_setGrd();
	
	$("[name='delChk']").change(function(e){
		$("#delStat").val($("[name='delChk']:checked").val());
		lfo_subGrd.grid.dataSource.read();
	});
}

//서브 그리드 세팅
this.lfn_jteSubGrd_setGrd = function(){
	lfo_subGrd = {};//Form 내부에서 사용될 Object 
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
	lfo_subGrd.layoutId = "jteSubGrid";
	
	//2.
	lfo_subGrd.popId = "jtePopForm";
	
	//3.
	lfo_subGrd.ctrlUrl = "/cform/qualMgt/qualPec/inputQualMgt";
	
	//4.
	lfo_subGrd.crud  = {
 		read:{url:"/getInputQualDetailList", auth:"", prmt:{qcNum : lfo_common.gridSelected.qcNum}, dynamicPrmt : {del : "delStat"}, search: false, refresh: false},
//		create:{url:"/setToolMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave},  
//		update:{url:"/setInputQualSave", auth:"", openFunc :"" , callback:lfn_popSave} 
// 		destroy:{url:"/setToolMgtDelete", auth:"", callback:lfn_jteGrid_delete} 
	};
	
	
	//5.
	lfo_subGrd.model = {
		id: "itemCd",
		fields: {
			coCd : { type: "string" },
			qcNum : { type: "string" },
			qcDate : { type: "string" },
			qcSeq : { type: "int" },
			qctyNm : { type: "string" },
			empCd : { type: "string" },
			korNm : { type: "string" },
			itemCd : { type: "string" },
			itemNm : { type: "string" },
			itemDc : { type: "string" },
			qcQty : { type: "int" },
			qcstkQty : { type: "int" },
			qcbadQty : { type: "int" },
			trCd : { type: "string" },
			whCd : { type: "string" },
			poNum : { type: "string" },
			poSeq : { type: "string" },
			reqNum : { type: "string" },
			reqSeq : { type: "string" },
			iblNum : { type: "string" },
			iblSeq : { type: "string" },
			inspNm : { type: "string" },
			inspDate : { type: "string" },
			insertId : { type: "string" },
			insertDt : { type: "string" },
			modifyId : { type: "string" },
			modifyDt : { type: "string" }
		}
	};
	
	//6.
	lfo_subGrd.columns = [
		{field: "itemCd", title: "조회", width: "130px",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "상세조회" + '</button>',
		},
		{field: "qcSeq", title:"순번", width: "100px"},
		{field: "qctyNm", title:"검사유형", width: "150px"},
		{field: "itemCd", title:"물품번호", width: "150px"},
		{field: "itemNm", title:"물품명", width: "200px"},
		{field: "itemDc", title:"물품스펙", width: "340px"},
		{field: "qcQty", title:"검사수량", width: "80px"},
		{field: "qcstkQty", title:"합격수량", width: "80px"},
		{field: "qcbadQty", title:"불합격수량", width: "80px"}
	];
	
	//공통 그리드 세팅 호출 
	lfo_subGrd.grid = gfn_grid_set(lfo_subGrd);
}

//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "830px", 
		height: "530px", // 200511 JJW 오른쪽 그리드 - 추가버튼 팝업 높이 기본값 330px -> 420px _ LYM 330 -> 415
		id:lfo_subGrd.popId, 
		title:"테스트 팝업",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var selectedItem = lfo_subGrd.grid.dataItem($(selectedItem).closest("tr"));
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	console.log("mode: " + mode + " selectedRow: " + JSON.stringify(selectedItem));
	lfo_subGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			qcNum : lfo_common.gridSelected.qcNum,
			trNm : lfo_common.gridSelected.trNm,
			empCd : lfo_common.gridSelected.empCd,
			pjtNm : lfo_common.gridSelected.pjtNm,
			qcpassFg : lfo_common.gridSelected.qcpassFg,
			remarkDesc : lfo_common.gridSelected.remarkDesc
		}
		gfn_popform_set(lfo_subGrd, mode,selectedItem);
	}else if(mode == 'EDT'){
		var searchPrmt = {};
		if(typeof(selectedItem) == "object"){
			lfo_subGrd.gridSelected = searchPrmt;
			searchPrmt = {
				qcNum : lfo_common.gridSelected.qcNum, 
				trNm : selectedItem.trNm,
				itemCd : selectedItem.itemCd,
				qcSeq : selectedItem.qcSeq
			}
		}else if(typeof(selectedItem) == "string"){
			searchPrmt = {
				qcNum : lfo_common.gridSelected.qcNum, 
				trNm : selectedItem,
				itemCd : selectedItem.itemCd,
				qcSeq : selectedItem.qcSeq
			}
		}
		
		$.ajax({
			async:false,
			url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud.read.url,
			type: "POST",
			data: searchPrmt,
			success: function(data){
				gfn_popform_set(lfo_subGrd, mode, data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	//그리드 세팅
	
	if($("#jtePopInputQualAdd_grid").html() ==""){
		lfn_jteInputQualAdd_setGrd(selectedItem);
	}else{
		lfo_inputQualAddGrd.grid.dataSource.read();
	}
}

//Form내용 입력/저장
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
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					lfo_subGrd.grid.dataSource.read();
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
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//정비이력 그리드 세팅
this.lfn_jteInputQualAdd_setGrd = function(selectedItem){
	lfo_inputQualAddGrd = {};//Form 내부에서 사용될 Object
	
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
	lfo_inputQualAddGrd.layoutId = "jtePopInputQualAdd_grid";
	
	//2.
	lfo_inputQualAddGrd.popId = "jtePopToolAdd";
	
	//3.
	lfo_inputQualAddGrd.ctrlUrl = "/cform/qualMgt/qualPec/inputQualMgt";
	
	//4.
	lfo_inputQualAddGrd.crud  = {
		read:{url:"/getInputQualAddList", auth:"", prmt:{qcNum : selectedItem.qcNum}}, 
		create:{url:"/setInputQualAddSave", auth:"", openFunc : lfn_inputQualPop_open, callback : lfn_inputQualPop_save}, 
		update:{url:"/setInputQualAddSave", auth:"", openFunc : lfn_inputQualPop_open, callback : lfn_inputQualPop_save}, 
		destroy:{url:"/setInputQualAddDelete", auth:"", callback : lfn_inputQualPop_delete}
	};

	//5.
	lfo_inputQualAddGrd.model = {
		id: "controlNo",
		fields: {
			coCd : { type: "string" },
			qcNum : { type: "string" },
			qcSeq : { type: "string" },
			empCd : { type: "string" },
			korNm : { type: "string" },
			itemCd : { tpye: "string" },
			itemNm : { type: "string" },
			itemDc : { type: "string" },
			controlNo : { type: "string" },
			qcQty : { type: "int" },
			qcstkQty : { type: "int" },
			qcbadQty : { type: "int" },
			qty : { type: "int" },
			stkQty : { type: "int" },
			badQty : { type: "int" },
			heatNo : { type: "string" },
			mfgDate : { type: "string" },
			expDate : { type: "string" },
			makerOrg : { type: "string" },
			badDesc : { type: "string" },
			ctrlDesc : { type: "string" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" }
		}
	};
	
	//6.
	lfo_inputQualAddGrd.columns = [
		{selectable : true, width:"80px"},
		{field: "controlNo", title:"자재 관리번호", width: "160px"},
		{field: "qcQty", title:"검사수량", width: "120px"},
		{field: "qcstkQty", title:"합격수량", width: "120px"},
		{field: "qcbadQty", title:"불합격수량", width: "120px"},
		{field: "heatNo", title:"로트번호", width: "140px"},
		{field: "mfgDate", title:"제조일자", width: "120px"},
		{field: "expDate", title:"시효일자", width: "110px"},
		{field: "makerOrg", title:"원제조사", width: "240px"},
		{field: "badDesc", title:"결함내용", width: "280px"},
		{field: "ctrlDesc", title:"비고", width: "280px"}
	];
	//7.
	lfo_inputQualAddGrd.selectBox = [
		{ text: "자재 관리번호", value: "qctrl.Control_No" },
		{ text: "로트번호", value: "qctrl.Heat_No" }
	];
	//공통 그리드 세팅 호출 
	lfo_inputQualAddGrd.grid = gfn_grid_set(lfo_inputQualAddGrd);
}
//정비이력 등록/수정 팝업 호출
this.lfn_inputQualPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px", // 200511 JJW 오른쪽 그리드 정비이력 버튼 클릭 - 그리드 추가버튼 클릭 시 나타나는 팝업 너비 600px -> 650px
		height: "460px", // 200511 JJW 오른쪽 그리드 정비이력 버튼 클릭 - 그리드 추가버튼 클릭 시 나타나는 팝업 높이 230px -> 320px _LYM 230px -> 328px 
		//title : gfn_getMsg("pop_mtncRegist"),
		id:lfo_inputQualAddGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = "관리번호 추가"
	}else if(mode=="EDT"){
		options.title = "관리번호 수정"
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_inputQualAddPop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//정비이력 등록/수정 팝업 내용 세팅
this.lfn_inputQualAddPop_set = function(mode,selectedItem){
	lfo_inputQualAddGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			qcNum : lfo_subGrd.gridSelected.qcNum,
			controlNo : lfo_inputQualAddGrd.gridSelected.controlNo,
			qcSeq : lfo_subGrd.gridSelected.qcSeq
		}
		gfn_popform_set(lfo_inputQualAddGrd, mode,selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_inputQualAddGrd.gridSelected = selectedItem["qcNum"];
		}else if(typeof(selectedItem) == "string"){
			lfo_inputQualAddGrd.gridSelected = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_inputQualAddGrd.ctrlUrl + lfo_inputQualAddGrd.crud.read.url,
			type: "POST",
			data: {qcNum : lfo_inputQualAddGrd.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_inputQualAddGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_inputQualPop_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_inputQualAddGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_inputQualAddGrd.popId+"_form").serializeObject();
		savePrmt.qcNum = $('#qcNum').val(); 
		
		console.log(savePrmt);
		$.ajax({
			async:false,
			url : lfo_inputQualAddGrd.ctrlUrl + lfo_inputQualAddGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//lfn_jtePop_set('EDT',data);
					//설비 정비이력 그리드 리로드
					lfo_inputQualAddGrd.grid.dataSource.read();
					//설비상세 그리드 리로드
					lfo_subGrd.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_inputQualAddGrd.popId);
					
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
this.lfn_inputQualPop_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_inputQualAddGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_inputQualAddGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_inputQualAddGrd.ctrlUrl + lfo_inputQualAddGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			//공구정비코드 삭제 후 리로드
			lfo_inputQualAddGrd.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

</script>