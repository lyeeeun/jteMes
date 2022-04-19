<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="inputQualMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="inputQualMgtForm inputQualMgtForm-jteSingleGrid"></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
	&nbsp;
	<div id="jteSubGrid" class="inputQualMgtForm inputQualMgtForm-jteSubGrid"></div>   <!-- style="display:inline-block; width:59%; height:100%;" -->
</div>
<!-- </div> -->
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<%-- <div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="inputQualMgtForm">
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
					<td>
						<input type="text" id="mtrlChargeUserNm" class="left-input" name="mtrlChargeUserNm" readonly/>
						<input type="hidden" id="mtrlChargeUser" name="mtrlChargeUser">
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>검사시작일 :</td>
					<td><input type="text" id="mtrlQualStart" class="right-input" name="mtrlQualStart" format="datepicker" readonly/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>발주코드 : </td>
					<td><input type="text" id="mtrlOrderId" class="left-input" name="mtrlOrderId" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>물품명 :</td>
					<td><input type="text" id="mtrlNm" class="right-input" name="mtrlNm" readonly/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>검사수량 :</td>
					<td><input type="text" id="mtrlOrderQty" class="left-input" name="mtrlOrderQty" format="currency" /></td> 
 					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>합격수량 : </td>
					<td><input type="text" id="mtrlPassQty" class="right-input" name="mtrlPassQty" format="currency" /></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>불합격수량 :</td>
					<td><input id="mtrlBadQty" class="left-input" name="mtrlBadQty" format="currency" /></td> 
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="mtrlOrderId" id="qcaMtrlOrderId"/>
						<input type="hidden" name="itemCd" id="itemCd"/>
						<input type="hidden" name="use" id="inputQualUse"/>
						<input type="hidden" name="action" id="inputQualAction"/>
						<input type="hidden" name="mtrlQualSta" id="mtrlQualSta" value="inspecWaiting"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>
 --%>
<!-- 입고검사 관련문서 POP -->
<div style="display:none;">
	<div id="jtePopRelDoc">   <!-- style="height:100%" -->
		<div class="pop_title">컨트롤번호 조회</div>
		<div id="jtePopInputQualAdd_grid" class="inputQualMgtForm" style="height:350px;"></div>
	</div>
</div>

<!-- 입고검사 관련문서 등록/수정 팝업(서브 그리드 > 관련문서조회 버튼 클릭) -->
<div style="display:none;">
	<div id="jtePopQcDocAdd">
		<form id="jtePopQcDocAdd_form" class="inputQualMgtForm">
		<div class="pop_title">컨트롤번호 정보</div>
			<table style="width:100%;" id="jtePopQcDocAdd_master" class="jtePopQcDocAdd_master">
			<colgroup>
				<col class="popsc-col-left-title"> <!-- 15 25 15 25 --> <!-- 200511 JJW 조회버튼을 위해 col 하나 더 추가 -->
				<col class="popsc-col-left-content">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i>Control No : </td>
					<td><input type="text" id="controlNo" class="left-input" name="controlNo" placeholder="자동생성" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>Heat No :</td>
					<td><input type="text" id="heatNo" class="right-input" name="heatNo" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>제조일자 : </td>
					<td><input type="text" id="mfgDate" class="left-input" name="mfgDate" format="datepicker"/></td> 
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>시효일자 :</td>
					<td><input type="text" id="expDate" class="right-input" name="expDate" format="datepicker" /></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>발주수량 :</td>
					<td><input type="text" id="qcMtrlOrderQty" class="left-input" name="mtrlOrderQty" format="currency" readonly/></td>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i>검사수량 :</td>
					<td><input type="text" id="ctMtrlQualQty" class="right-input" name="ctMtrlQualQty" format="currency" readonly/></td>
				</tr>
				<tr>
<!-- 					<td><i class="fas fa-caret-right"></i>합격수량 :</td>
					<td colspan="2"><input type="text" id="ctMtrlPassQty" class="left-input" name="ctMtrlPassQty" format="currency" readonly/></td> -->
					<td><i class="fas fa-caret-right"></i>불량수량 :</td>
					<td colspan="2"><input type="text" id="ctMtrlBadQty" class="left-input btn-input" name="ctMtrlBadQty" format="currency" readonly/></td>
					<td><button class="k-button k-primary search-btn" type="button" onclick="lfn_mtrlBadListPop_Open()">불량등록</button></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>원제조사 : </td>
					<td colspan="2">
						<input type="text" id="compNm" class="left-input btn-input" name="compNm" readonly/> 
						<input type="hidden" id="compId" name="compId" />
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="gfn_openCustomPop('makerorg',lfn_companyPop_callback);" >
				<!-- 조회 -->
						<spring:message code = "btn_search"></spring:message></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>결함내용 : </td>
					<td colspan="3"><input type="text" id="badDesc" class="center-input" name="badDesc" class="k-textbox"/></td> 
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>비고 : </td>
					<td colspan="3"><input type="text" id="ctrlDesc" class="center-input" name="ctrlDesc" class="k-textbox"/></td> 
				</tr>				
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="mtrlOrderId" id="qcMtrlOrderId"/>
						<!-- <input type="hidden" name="mtrlOrderQty" id="qcMtrlOrderQty"> -->
						<input type="hidden" name="mtrlId" id="mtrlId"/>
						<input type="hidden" name="mtrlMgtId" id="mtrlMgtId"/>
						<input type="hidden" name="use" id="inputQualAddUse"/>
						<input type="hidden" name="action" id="inputQualAddAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopQcDocAdd');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 입고검사 관련문서 POP -->
<div style="display:none;">
	<div id="jteMtrlBadPop">   <!-- style="height:100%" -->
		<div class="pop_title">불량자재 조회</div>
		<div id="jteQualBadChkPop_grid" class="inputQualMgtForm" style="height:350px;"></div>
	</div>
</div>

<!-- 불량품 관리 팝업 -->
<div style="display:none;">
	<div id="jteQualBadChkPop">
		<form id="jteQualBadChkPop_form" class="inputQualMgtForm">
		<!-- 불량품 정보 -->
			<div class="pop_title">불량자재 정보</div>
			<table style="width:100%;" id="jteQualBadChkPop_master" class="jteQualBadChkPop_master">
			<colgroup> <!-- 15 25 15 25 조회 버튼으로 1행 추가 -->
				<col class="poptr-col-left-title">
				<col class="poptr-col-left-content-1">
				<col class="poptr-col-left-content-2">
				<col class="poptr-col-right-title">
				<col class="poptr-col-right-content">
			</colgroup>
				<tr>
				<!-- 불량아이디 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_badId"></spring:message> : </td>
					<td colspan="4"><input type="text" id="badId" class="center-input" name="badId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				</tr>
				<tr>
				<!-- 불량정보 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_badInfo"></spring:message> : </td>
					<td colspan="2"><input id="badCode" class="left-input" name="badCode"  format = "selBox" msg="qual_MTRLCUT"/></td> <!-- style="width: 95%; max-width:95%;" -->
				<!-- 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_quantity"></spring:message> : </td>
					<td><input id="badQty" class="right-input" name="badQty" format="currency"/></td>
				</tr>
				<tr>
				<!-- 검사자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_inspector"></spring:message> : </td>
					<td>
						<input id="chkUserNm"class="left-input btn-input"  name="chkUserNm" format="text" readonly/>
						<input type="hidden" name="chkUser" id="chkUser"/>
					</td>
					<td><!-- 조회 -->
 						<button class="k-button k-primary search-btn" type="button" onclick="lfn_userInfoPop_Open(lfn_badUserInfoPop_callback)">
 						<spring:message code="btn_search" /></button>
					</td>
				<!-- 검사일 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_inspectDate"></spring:message> : </td>
					<td><input id="chkDate" class="right-input" name="chkDate" format="datetimepicker"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="4"><input id="badDesc" class="center-input" name="badDesc"/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="mtrlOrderId" id="qctMtrlOrderId"/>
						<input type="hidden" name="badId" id="qcBadId"/>
						<input type="hidden" name="controlNo" id="controlNo"/>
						<input type="hidden" name="badTarget" id="badTarget"/>
						<input type="hidden" name="badTargetCode" id="badTargetCode"/>
						<input type="hidden" name="mtrlId" id="badMtrlId"/>
						<input type="hidden" name="mtrlMgtId" id="badMtrlMgtId"/>
						<input type="hidden" name="use" id="bad_use"/>
						<input type="hidden" name="action" id="bad_action"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>							<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteQualBadChkPop');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/mtrl/mtrltoolMgt/inputQualMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
 <link href='/resources/mes/css/contents/qualMgt/qualPec/inputQualMgt/inputQualMgtForm_JJW.css' rel="stylesheet"> 

<!-- 내부 스타일 외부로 이동_200511 JJW  -->

<script>

var lfo_dateBox = {};

var lfo_common = {};//Form 내부에서 사용될 Object 

// var lfo_subGrd = {};//서브그리드에서 사용될 Object

var lfo_inputQualAddGrd = {};

var lfo_qualBadGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	$("[name='delChk']").change(function(e){
		$("#delStat").val($("[name='delChk']:checked").val());
		lfo_common.grid.dataSource.read();
	});
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
	lfo_common.ctrlUrl = "/form/qualMgt/qualPec/inputQualMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getInputQualList", auth:"", prmt:{}, dynamicPrmt:{mtrlQualSta :"mtrlQualSta"}, period:{stdt:-30, eddt:0}}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		update:{url:"/setInputQualSave", auth:"", openFunc : "", callback:""}
		//destroy:{url:"", auth:"", callback:""}
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html :	'<div style="margin : 0 14px 0 5px; float:right;">검사현황 : '+   /** 원래는 style="margin : 5px 0 5px 0; float:right;"_200819 youmi **/
				'<input name="mtrlQualSta" id="mtrlQualSta"></div>'
				
/* 			 	'<label class="k-radio-label" for="delFalse">'+gfn_getMsg("col_stock")+'</label>'+
				'<input type="radio" name="delChk" id="delTrue" class="k-radio"  value=true>'+
				'<label class="k-radio-label" for="delTrue">'+gfn_getMsg("col_mtrlReturn")+'</label>'+
				'<input type="hidden" id="delStat" value="false">' */
	}

	//5.
	lfo_common.model = {
		id: "mtrlOrderId",
		fields: {
			mtrlOfId : { type: "string" },
			mtrlOfNm : { type: "string" },
			mtrlOfDate : { type: "date" },
			mtrlQualStart : { type: "date"},
			mtrlQualEnd : { type: "date" },
			mtrlId : { type: "string" },
			mtrlMgtId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlOrderQty : { type: "string" },
			mtrlQualQty : { type: "string" },
			mtrlPassQty : { type: "string" },
			mtrlBadQty : { type: "string" },
			mtrlChargeUser : { type: "string" },
			mtrlChargeUserNm : { type: "string" },
			mtrlRequestUser : { type: "string" },
			mtrlRequestUserNm : { type: "string" },
			mtrlQualSta : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			createdAt : { type: "string" },
			updatedAt : { type: "string" },
			creatorId : { type: "string" },
			updatorId : { type: "string" }
		}
	};

	//6.
	lfo_common.columns = [
		{field: "mtrlOfId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_ctrlAddPop(this) " style="width:70px;">번호추가</button>',
			title : "조회" , width: "90px"},
		{field: "mtrlOfId", title: "발주코드", width: "140px"},
		{field: "mtrlOfNm", title: "발주명", width: "150px"},
		{field: "mtrlQualStart", format:"{0: yyyy-MM-dd}", title: "검사시작일", width: "110px"},
		{field: "mtrlQualEnd", format:"{0: yyyy-MM-dd}", title: "검사완료일", width: "110px"},
		{field: "mtrlRequestUserNm", title: "검사의뢰자", width: "110px"},
		{field: "mtrlChargeUserNm", title: "검사담당자", width: "110px"},
		//{field: "mtrlId", title:"물품번호", width: "140px"},
		{field: "mtrlNm", title:"물품명", width: "200px"},
		{field: "mtrlOrderQty", format: "{0:n}", title:"발주수량", width: "100px"},
		{field: "mtrlQualQty", format: "{0:n}", title:"검사수량", width: "100px"},
		{field: "mtrlPassQty", format: "{0:n}", title:"합격수량", width: "100px"},
		{field: "mtrlBadQty", format: "{0:n}", title:"불합격수량", width: "110px"},
		{field: "mtrlQualSta", title: "검사보류", width: "110px",
			template : function(rows){
				if(rows.mtrlQualSta == 'inspecHolding'){
					return '검사 보류중';
				}else if(rows.mtrlQualSta == 'inspecComplete'){
					return '-';
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_qual_hold(this); " style="min-width:70px;">' + "보류" + '</button>';
				}
			}
		},
		{field: "mtrlQualSta", title: "검사현황", width: "110px",
			template : function(rows){
				
				if(rows.mtrlQualSta == 'inspecComplete'){
					return '검사완료';
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_qual_return(this); " style="min-width:70px;">' + "완료" + '</button>';
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "발주명", value: "ordForm.mtrl_of_nm" },
		{ text: "검사담당자", value: "urInfo.user_nm" },
		{ text: "물품명", value: "mtrlInfo.mtrl_nm" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
	var selBoxItem = gfn_getCode('inspec_sta');
	
	$("#mtrlQualSta").kendoDropDownList({
		dataSource: selBoxItem,
		dataValueField: "cdId",
		dataTextField: "cdNm",
	//	valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
	//	template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
		index:0,
		change: function(e) {
			$('#mtrlQualSta').val(this.value());
			lfo_common.grid.dataSource.read();
		}
	});
	
}

this.lfn_qual_return = function(target){
	gfn_conBox({msg:"검사완료 처리하시겠습니까?", yes : function(){
		var returnTemp = lfo_common.grid.dataItem($(target).closest('tr'))
		//returnTemp.del = true;
		returnTemp.action = "U";
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.update.url,
			type: "POST",
			data: JSON.stringify(returnTemp),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				gfn_msgBox({msg : "검사처리가 완료되었습니다."});	
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}});
}

this.lfn_qual_hold = function(target){
	gfn_conBox({msg:"검사보류 처리하시겠습니까?", yes : function(){
		var returnTemp = lfo_common.grid.dataItem($(target).closest('tr'))
		//returnTemp.del = true;
		returnTemp.action = "C";
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.update.url,
			type: "POST",
			data: JSON.stringify(returnTemp),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				gfn_msgBox({msg : "검사보류 처리가 완료되었습니다."});	
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}});
}
//업체코드 정보 팝업 콜백
this.lfn_companyPop_callback = function(callbackObj){
	$("[name='compId']").val(callbackObj.compId);
	$("[name='compNm']").val(callbackObj.compNm);
}

//입고검사 관련문서 버튼 클릭(팝업 오픈)
this.lfn_ctrlAddPop = function(target){
	var options = {
		modal:true, 
		width: "800px", 
		height: "395px", //200519 JJW 400-> 395
		id : "jtePopRelDoc", 
		title:"관련문서 조회",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));
	
	//선택한 항목의 ID 가져옴
	lfo_common.gridSelected = { 
			mtrlOrderId : dataItem.mtrlOrderId,
			mtrlId : dataItem.mtrlId,
			mtrlMgtId : dataItem.mtrlMgtId,
			mtrlOrderQty : dataItem.mtrlOrderQty,
			mtrlQualQty : dataItem.mtrlQualQty,
			mtrlPassQty : dataItem.mtrlPassQty,
			mtrlBadQty : dataItem.mtrlBadQty
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteInputQualAdd_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}


//입고검사 관련문서 그리드 세팅
this.lfn_jteInputQualAdd_setGrd = function(dataItem){
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
	lfo_inputQualAddGrd.popId = "jtePopQcDocAdd";
	
	//3.
	lfo_inputQualAddGrd.ctrlUrl = "/form/qualMgt/qualPec/inputQualMgt";
	
	//4.
	lfo_inputQualAddGrd.crud  = {
		read:{url:"/getInputQualAddList", auth:"", prmt:{mtrlOrderId: dataItem.mtrlOrderId, mtrlQualQty: dataItem.mtrlOrderQty, ctMtrlPassQty: dataItem.mtrlPassQty, ctMtrlBadQty: dataItem.mtrlBadQty}
				,dynamicPrmt:{mtrlId :"mtrlId", mtrlMgtId : "mtrlMgtId"}}, 
		create:{url:"/setInputQualAddSave", auth:"", openFunc : lfn_inputQualPop_open, callback : lfn_inputQualPop_save}, 
		update:{url:"/setInputQualAddSave", auth:"", openFunc : lfn_inputQualPop_open, callback : lfn_inputQualPop_save}, 
		//destroy:{url:"/setInputQualAddDelete", auth:"", callback : lfn_inputQualPop_delete}
	};

	//5.
	lfo_inputQualAddGrd.model = {
		id: "controlNo",
		fields: {
			coCd : { type: "string" },
			controlNo : { type: "string" },
			mtrlOrderQty : { type: "int" },
			mtrlQualQty : { type: "int" },
			mtrlPassQty : { type: "int" },
			mtrlBadQty : { type: "int" },
			ctMtrlQualQty : { type: "int"},
			ctMtrlPassQty : { type: "int"},
			ctMtrlBadQty : { type: "int" },
			heatNo : { type: "string" },
			mfgDate : { type: "date" },
			expDate : { type: "date" },
			makerOrg : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			badDesc : { type: "string" },
			mtrlId : { type: "string" },
			mtrlMgtId : { type: "string" },
			mtrlOrderId : { type: "string" },
			mtrlOfId : { type: "string" },
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
		{field: "controlNo", title:"Control No", width: "160px"},
		{field: "ctMtrlQualQty", title:"검사수량", width: "110px"},
		{field: "ctMtrlPassQty", title:"합격수량", width: "110px"},
		{field: "ctMtrlBadQty", title:"불합격수량", width: "130px"},
		{field: "heatNo", title:"Heat No", width: "140px"},
		{field: "compNm", title:"원제조사", width: "240px"},
		{field: "badDesc", title:"결함내용", width: "280px"},
		{field: "ctrlDesc", title:"비고", width: "280px"},
		{field: "mfgDate", format:"{0: yyyy-MM-dd}", title:"제조일자", width: "110px"},
		{field: "expDate", format:"{0: yyyy-MM-dd}", title:"시효일자", width: "110px"}
	];
	//7.
	lfo_inputQualAddGrd.selectBox = [
	//	{ text: "Control No", value: "mtrlCtrl.control_no" },
		{ text: "원제조사", value: "compInfo.comp_nm" },
		{ text: "Heat No", value: "mtrlCtrl.heat_no" }
	];
	//8.
	lfo_inputQualAddGrd.validation ={
		compId:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=compId]")){
					if(input.val().length == 0){
						gfn_msgBox({msg: "조회버튼을 눌러 원제조사를 등록해주세요."});
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_inputQualAddGrd.grid = gfn_grid_set(lfo_inputQualAddGrd);
}
//입고검사 관련문서 등록/수정 팝업 호출
this.lfn_inputQualPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px",
		height: "470px",
		//title : gfn_getMsg("pop_mtncRegist"),
		id:lfo_inputQualAddGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[ /*"Minimize", "Maximize", */ "Close"]
	};
	if(mode =="NEW"){
		options.title = "컨트롤번호 정보등록"
		
		selectedItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		if($("#jtePopInputQualAdd_grid").data("kendoGrid").dataSource.total() == 1){
			gfn_warnBox({msg:"Control No는 한개만 생성 가능합니다."});			//수동입력된 데이터만 변경하실 수 있습니다.
			return false;
		}
	}else if(mode=="EDT"){
		options.title = "컨트롤번호 정보수정"
 		if($("#mtrlQualSta").val() == "inspecComplete"){
 			gfn_msgBox({msg : "검사가 완료되어 내용수정이 불가능합니다."});
			return false;
		}
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_inputQualAddPop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//입고검사 관련문서 등록/수정 팝업 내용 세팅
this.lfn_inputQualAddPop_set = function(mode,selectedItem){
	lfo_inputQualAddGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = lfo_common.gridSelected;
		gfn_popform_set(lfo_inputQualAddGrd, mode,selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_inputQualAddGrd.gridSelected = selectedItem["controlNo"];
		}else if(typeof(selectedItem) == "string"){
			lfo_inputQualAddGrd.gridSelected = selectedItem;
		}
		$.ajax({
			async:false,
			url : lfo_inputQualAddGrd.ctrlUrl + lfo_inputQualAddGrd.crud.read.url,
			type: "POST",
			data: {controlNo : lfo_inputQualAddGrd.gridSelected},
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
		savePrmt.mtrlOrderId = $('#qcMtrlOrderId').val();
		savePrmt.mtrlQualQty = $('#qcMtrlOrderQty').val();
		savePrmt.mtrlPassQty = $('#ctMtrlPassQty').val();
		savePrmt.mtrlBadQty = $('#ctMtrlBadQty').val();
		
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
					//입고검사 관련문서 그리드 리로드
					lfo_inputQualAddGrd.grid.dataSource.read();
					//입고검사 상세 그리드 리로드
					lfo_common.grid.dataSource.read();
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
/* 
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
			//Control No 삭제 후 리로드
			lfo_inputQualAddGrd.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
} */

//입고검사 관련문서 버튼 클릭(팝업 오픈)
this.lfn_mtrlBadListPop_Open = function(target){
	var options = {
		modal:true, 
		width: "800px", 
		height: "395px", //200519 JJW 400-> 395
		id : "jteMtrlBadPop", 
		title:"불량 조회",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_inputQualAddGrd.grid.dataItem($(target).closest("tr"));
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_QualBadGrd_setGrd(dataItem);
	};
	
	this.gfn_winOpen(options);
}


//입고 자재불량 그리드 
this.lfn_QualBadGrd_setGrd = function(dataItem){
	lfo_qualBadGrd = {};
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
	lfo_qualBadGrd.layoutId = "jteQualBadChkPop_grid";
	//여기까지
	
	//2.
	lfo_qualBadGrd.popId = "jteQualBadChkPop";
	
	//3.
	lfo_qualBadGrd.ctrlUrl = "/form/qualMgt/infergodsMgt"

	//4.
	lfo_qualBadGrd.crud  = {
		read:{url:"/getMtrlBadList", auth:"", prmt:{badTargetCode : lfo_inputQualAddGrd.gridSelected, badTarget : "qual_spec01"}}, 
		create:{url:"/setMtrlBadSave", auth:"", openFunc : lfn_QualBadGrd_open, callback : lfn_QualBadGrd_save}, 
		update:{url:"/setMtrlBadSave", auth:"", openFunc : lfn_QualBadGrd_open, callback : lfn_QualBadGrd_save}, 
		destroy:{url:"/setMtrlBadDelete", auth:"", callback : lfn_QualBadGrd_delete}
	};
	
	//5.
	lfo_qualBadGrd.model = {
		id: "badId",
		fields: {
			mtrlOrderId : { type : "string" },
			controlNo : { type : "string" },
			badId : { type: "string" },	
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkUserNm : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badTargetNm : { type: "string" },
			badDesc : { type: "string" },
			mtrlId : { type: "string" },
			mtrlNm : { type: "string" },
			mtrlMgtId : { type: "string" },
			badPgUser : { type: "string" },
			badPgUserNm : { type: "string" },
			badPgDate : { type: "date" },
			badPgCd : { type: "string" },
			badPgNm : { type: "string" },
			mtrlDiv : { type: "string" }
		}
	};
	
	//6.
	lfo_qualBadGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "130px;"},														//불량원인
		{field: "badId", title : gfn_getMsg("col_badId"), width: "180px"},												//불량아
		{field: "badQty",format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: "90px"},						//불량량이디
		//{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "120px"},											//자재구분
		{field: "mtrlNm", title : gfn_getMsg("col_mtrlNm"), width: "140px"},											//자재명
		{field: "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd"), width: "180px"},									//자재개별코드
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badInfo"), width: "200px;"},														//불량정보
		{field: "badTargetCode", title : gfn_getMsg("col_badCd"), width: "180px"},										//불량코드
		{field: "badPgUserNm", title : gfn_getMsg("col_worker"), width: "130px"},										//작업자
		{field: "badPgDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_workDate"), width: "130px"},			//작업일
		{field: "chkUserNm", format: "{0:n0}", title : gfn_getMsg("col_inspector"), width: "130px"},					//검사자
		{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate"), width: "130px"},			//검사일
		{field: "badPgNm", title : gfn_getMsg("col_progNm"), width: "180px"},											//프로그램명
		{field: "badPgCd", title : gfn_getMsg("col_progCd"), width: "180px"}											//프로그램코드
	];
	
	//7.
	lfo_qualBadGrd.selectBox = [
		//{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlNm" },				//자재구분
		{ text: gfn_getMsg("col_worker"), value: "badPgUserNm" },			//작업자
		{ text: gfn_getMsg("col_badId"), value: "badId" },					//불량아이디
	];
	//8.
	lfo_qualBadGrd.validation ={
			badQty:{
			messages : "불량량을 입력하세요",
			rules : function(input){
				if(input.is("[name=badQty]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		chkDate:{
			messages : "검사일을 등록하세요",
			rules : function(input){
				if(input.is("[name=chkDate]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		chkUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=chkUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 검사자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_qualBadGrd.grid = gfn_grid_set(lfo_qualBadGrd);
}


//더블클릭 콜백(팝업)
this.lfn_QualBadGrd_open = function(mode, dataItem){
	var options = {
		modal:true, 
		width: "610px", // 200821 JJW 불량품 관리 팝업 너비 500px -> 610px
		height: "330px", // 200512 JJW 불량품 관리 팝업 높이 250px -> 330px
		id : lfo_qualBadGrd.popId, 
//		title: "불량자재 등록",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	if(mode =="NEW"){
		options.title = "불량자재 정보등록"
	}else if(mode=="EDT"){
		options.title = "불량자재 정보수정"
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_QualBadGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_QualBadGrd_popSet = function(mode,selectedItem){
	lfo_qualBadGrd.gridSelected = {};
	if(mode=='NEW'){
		//초기 현재날짜와 접속자의 정보를 수령정보에 초기입력해준다.
		selectedItem = {
				mtrlId : $("#" + lfo_inputQualAddGrd.popId + " [name=mtrlId]").val(),
				mtrlMgtId : $("#" + lfo_inputQualAddGrd.popId + " [name=mtrlMgtId]").val(),
				badTarget : "qual_spec01",
				badTargetCode : $("#" + lfo_inputQualAddGrd.popId + " [name=controlNo]").val(), 
				chkDate : new Date(),
				chkUserNm : $("#_loginUserName").val(),
				chkUser : $("#_loginUserId").val(),
				controlNo : $("#controlNo").val(),
				badId : $("#qcBadId").val()
		}
		gfn_popform_set(lfo_qualBadGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_qualBadGrd.gridSelected = selectedItem;
		}else if(typeof(selectedItem) == "string"){
			lfo_qualBadGrd.gridSelected = selectedItem;
		}
		$.ajax({
			async:false,
			url : lfo_qualBadGrd.ctrlUrl + lfo_qualBadGrd.crud.read.url,
			type: "POST",
			data: {badId :lfo_qualBadGrd.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_qualBadGrd, mode ,data.rows[0]);
				
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_QualBadGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_qualBadGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_qualBadGrd.popId+"_form").serializeObject();
		savePrmt.badTarget = $("#badTarget").val();
		savePrmt.badId = $("#badId").val();
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_qualBadGrd.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_qualBadGrd.ctrlUrl + lfo_qualBadGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//내역보기 팝업 리로드
					lfo_qualBadGrd.grid.dataSource.read();
					//발주주문조회 리로드
					lfo_inputQualAddGrd.grid.dataSource.read();
					//마스터그리 리로드
					lfo_common.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_qualBadGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		
		$.ajax({
			async:false,
			url : lfo_inputQualAddGrd.ctrlUrl + lfo_inputQualAddGrd.crud.read.url,
			type: "POST",
			data: {controlNo : lfo_inputQualAddGrd.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_inputQualAddGrd, "EDT", data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	
}

//삭제 콜백
this.lfn_QualBadGrd_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_qualBadGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_qualBadGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	
	$.ajax({
		async:false,
		url : lfo_qualBadGrd.ctrlUrl + lfo_qualBadGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			//내역보기 팝업 리로드
			lfo_qualBadGrd.grid.dataSource.read();
			//발주주문조회 리로드
			lfo_inputQualAddGrd.grid.dataSource.read();
			//마스터그리 리로드
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	$.ajax({
		async:false,
		url : lfo_inputQualAddGrd.ctrlUrl + lfo_inputQualAddGrd.crud.read.url,
		type: "POST",
		data: {controlNo : lfo_inputQualAddGrd.gridSelected},
		success: function(data){
			gfn_popform_set(lfo_inputQualAddGrd, "EDT", data.rows[0]);
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
//pop - 유저정보 팝업 오픈
this.lfn_userInfoPop_Open = function(call){
	gfn_openCustomPop('userInfo',call);
}

this.lfn_badUserInfoPop_callback = function(rtnObj){
	$("#" + lfo_qualBadGrd.popId + " [name=chkUser]").val(rtnObj["userId"]);
	$("#" + lfo_qualBadGrd.popId + " [name=chkUserNm]").val(rtnObj["userNm"]);
}
</script>