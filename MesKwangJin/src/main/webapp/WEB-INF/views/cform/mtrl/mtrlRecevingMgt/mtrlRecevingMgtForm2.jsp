<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="mtrlMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrlMgtForm"></div>
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrlMgtForm popfr-mtrlMgtForm">			
			<div class="pop_title"><spring:message code = "pop_mtrlInfo" text = "자재정보"/></div>	
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width: 17%;">
				<col style="width: 33%;">
				<col style="width: 17%;">
				<col style="width: 33%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlCd" text = "자재코드"/>
					<i class="fas fa-info-circle" title="<spring:message code = "자재코드를 조회하셔야 자재개별코드가 부여됩니다."></spring:message>"></i> : </td>
					<td>
						<input type="text" id="mtrlId" class="btn-input" name="mtrlId"  placeholder="<spring:message code = "pop_searchAuto" text = "조회시 자동등록"/>" readonly />
						<button class="k-button k-primary" type="button" id="mtrl_search_btn" onclick= "lfn_mtrlInfoPop_Open();" style="display:none;">
						<spring:message code = "btn_search" text = "조회"/></button>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_mtrlType" text = "자재유형"/> : </td>
					<td><input id="mtrlType" name="mtrlType" format="selBox" msg="mtrl_div" readonly /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm" text = "자재명"/> : </td>
					<td colspan="3"><input type="text" id="mtrlNm" name="mtrlNm" format="text" readonly /></td>
				</tr>
				<tr class="pop_detail_info">
					<td><i class="fas fa-caret-right"></i>자재규격 : </td>
					<td colspan="3"><input type="text" id="mtrlStdStr01" name="mtrlStdStr01" readonly /></td>
				</tr>
				<tr class="pop_detail_info">
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_weight" text = "무게"/> : </td>
					<td><input type="text" id="mtrlStd03" name="mtrlStd03" format="numeric" readonly /></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_unit" text = "단위"/> : </td>
					<td><input id="mtrlUnit" class="right-input" name="mtrlUnit" format="selBox" msg="comn_unit" readonly/></td>
				</tr>
				<tr class="pop_detail_info">
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input id="mtrlDesc" name="mtrlDesc" format="text" readonly/></td>
				</tr>
				<tr>
					<td colspan="4" class="pop_detail_btn_area" style="padding-top:15px; text-align:center;" >
						<span class="pop_detail_btn pop_detail_hide" onclick="lfn_popDetail_toggle()">
						<spring:message code = "pop_expHide" text = "펼치기/숨기기"/></span>
					</td>
				</tr>
			</table>
			<div class="pop_title"><spring:message code = "pop_mtrlSpec" text = "자재특성"/></div>
			<table style="width:100%;" id="jtePopForm_master-2" class="BasicTable">
			<colgroup>
				<col style="width: 17%;">
				<col style="width: 33%;">
				<col style="width: 17%;">
				<col style="width: 33%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlIndivCd" text = "자재입고코드"/> : </td>	
					<td><input type="text" id="mtrlMgtId" name="mtrlMgtId" placeholder="<spring:message code = "pop_autoInput" text = "자동등록"/>" readonly /></td>
					<td class="td-right-title">
						<i class="fas fa-caret-right"></i><spring:message code = "col_mtrlQty" text = "자재수량"/> :  
					</td>
					<td><input id="mtrlMgtCnt" name="mtrlMgtCnt" format = "currency" readonly /></td>
				</tr> 
				<tr style="display:none;">
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="mtrlMgtDesc" name="mtrlMgtDesc" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="mtrlMgtUse"/>
						<input type="hidden" name="action" id="mtrlMgtAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
			</div>
		</form>
		<div id="mtrlQtyArea" style="display:none;">
			<div class="pop_title"><spring:message code = "pop_qtyMgt" text = "수량관리"/></div>
			<div id="jtePopForm_grid"></div>
		</div>
	</div>
</div>

<!-- 팝업(마스터그리드 > 팝업창 내부 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopAddForm">
		<form id = "jtePopAddForm_form" class="mtrlMgtForm">
			<table style="width:100%;" id="jtePopAddForm_master" class="BasicTable">
			<colgroup>
				<col style="width: 17%;">
				<col style="width: 30%;">
				<col style="width: 20%;">
				<col style="width: 33%;">
			</colgroup>
				<tr><td colspan="4"></td></tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_targetDiv" text = "업무구분"/> : </td>
					<td>
						<input id="mtrlQtyTarget" name="mtrlQtyTarget" format="selBox" msg="mtrl_tagt" readonly/>
						<input type="hidden" id="mtrlQtyTargetCode" name="mtrlQtyTargetCode" /> 
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_quantity" text = "수량"/> : </td>
					<td><input id="mtrlQtyTotal" name="mtrlQtyTotal" format = "currency" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_registDate" text = "등록일"/> : </td>
					<td><input id="mtrlQtyDate" name="mtrlQtyDate" format="datetimepicker" /></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_registUser" text = "등록자"/> : </td>
					<td>
						<input type="text" id="mtrlQtyUserNm" class="btn-input" name="mtrlQtyUserNm" class="k-textbox" readonly />
						<input type="hidden" id="mtrlQtyUser" name="mtrlQtyUser" />
						<button class="k-button k-primary" type="button"  onclick= "lfn_addFormUserPop_open()">
						<spring:message code = "btn_search" text = "조회"/></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="mtrlQtyDesc" name="mtrlQtyDesc" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" id="hidMtrlMgtId" name="mtrlMgtId">
						<input type="hidden" name="use" id="mtrlQtyUse"/>
						<input type="hidden" name="action" id="mtrlQtyAction"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="mtrlMgtForm final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
		</div>
	</div>
</div>

<link href='/resources/mes/css/contents/mtrl/mtrlMgt/mtrlMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {}; 

var lfo_popGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	$("[name='delChk']").change(function(e){
		$("#delStat").val($("[name='delChk']:checked").val());
		lfo_common.grid.dataSource.read();
	});
};

// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/mtrl/mtrlRecevingMgt";

	lfo_common.crud  = {
		read:{url:"/getMtrlRecevingMgtList", auth:"", prmt:{}, dynamicPrmt : {del : "delStat"}}, 
		create:{url:"/setMtrlRecevingMgtSave", auth:"", openFunc : lfn_jtePop_open, callback : lfn_popSave}, 
		update:{url:"/setMtrlRecevingMgtSave", auth:"", openFunc : "", callback : lfn_popSave}
	};

	lfo_common.model = {
		id: "mtrlMgtId",
		fields: {
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtPrescription: { type: "date" },
			mtrlMgtCnt: { type: "int" },
			mtrlMgtScrap: { type: "int" },
			mtrlMgtDesc: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" },
			updatorId: { type: "string" },
			updatedAt: { type: "date" },
			lotId: { type: "string" },
			mtrlId: { type: "string" },
			mtrlNm: { type: "string" },
			mtrlType: { type: "string" },
			mtrlHCD: { type: "string" },
			mtrlStd01 : { type: "int" }, 
			mtrlStd02 : { type: "int" }, 
			mtrlStd03 : { type: "int" }, 
			mtrlStd04 : { type: "string" },
			mtrlStd05 : { type: "int" },
			mtrlStdStr01 : { type: "string" }, 
			mtrlStdStr02 : { type: "string" }, 
			mtrlStdStr03 : { type: "string" }, 
			mtrlStdStr04 : { type: "string" },
			mtrlStdStr05 : { type: "string" },
			mtrlUseday : { type: "int" },
			mtrlCost : { type: "int" },
			mtrlDiv: { type: "string" },
			mtrlDesc: { type: "string" },
			mtrlQual: { type: "string" }, 
			mtrlUnit: { type: "string" },
			isUse: { type: "bool" },
			isDel: { type: "bool" },
			mtrlDesc: { type: "string" }
		}
	};

	lfo_common.columns = [
		{field: "mtrlMgtId",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("btn_search", "조회") , width: "90px"},																	//조회
		{field : "mtrlNm", title : gfn_getMsg("col_mtrlNm", "자재명"), width: "160px"},
		{field : "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd", "자재입고코드"), width: "150px"}, 
		{field : "mtrlMgtCnt", format: "{0:n0}", attributes : { style : "color: blue; font-weight:bold;  text-align : right;"}, title:gfn_getMsg("col_mtrlQty", "자재수량"), width: "110px"},
		{field : "mtrlStd04", title: "최소재고",   attributes: { style: "color: red; font-weight:bold;  text-align:right;" }, width: "105px"},
		{field : "mtrlMgtDesc", title:gfn_getMsg("col_desc", "설명"), width: "220px"},
	];

	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlInfo.mtrl_nm" },
		{ text: gfn_getMsg("col_mtrlIndivCd", "자재입고코드"), value: "mtrlMgt.mtrl_mgt_id" }
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px", 
		height: "515px", 
		id : lfo_common.popId, 
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlRegistDetail", "자재 상세 등록");
	}else if(mode=="EDT"){
		if(!gfn_isEmpty(selectedItem)){
			selectedItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}
		options.title = gfn_getMsg("pop_mtrlDetailSrh", "자재 상세 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = {};
	if(mode=='NEW'){
		$("#mtrl_search_btn").show();
		if(!gfn_isEmpty(selectedItem) && selectedItem.mtrlType == "mtrl_div01"){
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
				type: "POST",
				data: {mtrlId:selectedItem.mtrlId},
				success: function(data){
					if(!gfn_isEmpty(data.rows)){
						selectedItem = data.rows[0];
						lfo_common.gridSelected = data.rows[0].mtrlMgtId;
						mode = 'EDT';
					}
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
				}
			});
		}
		
		gfn_popform_set(lfo_common, mode, selectedItem);
		
	}else if(mode == 'EDT'){
		
		$("#mtrl_search_btn").hide();
		var savePrmt = {};
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
			savePrmt = {
				mtrlMgtId : lfo_common.gridSelected.mtrlMgtId,
				del : lfo_common.gridSelected.del
			}
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.mtrlMgtId = selectedItem;
			savePrmt = {
				mtrlMgtId : lfo_common.gridSelected.mtrlMgtId
			}
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: savePrmt,
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
				
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
		//그리드 세팅
		gfn_resizePop(lfo_common.popId, {width:750,height:650});
		$("#mtrlQtyArea").show();
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	}
}

//자재정보 팝업 -콜백시 자재정보를 매핑해준다.
this.lfn_mtrlInfoPop_Open = function(){
	var callback = function(selectedItem){
		lfn_jtePop_set('NEW',selectedItem);
	}
	gfn_openCustomPop('material',callback);
}

//자재정보 -보이기/숨기기
this.lfn_popDetail_toggle = function(){
	if($(".pop_detail_btn").hasClass("pop_detail_hide")){
		//영역숨기기
		$("#jtePopForm_master").find(".pop_detail_info").each(function(){
			$(this).show();
		});
		//클래스 변경
		$(".pop_detail_btn").removeClass("pop_detail_hide");
		$(".pop_detail_btn").addClass("pop_detail_show");
	}else if($(".pop_detail_btn").hasClass("pop_detail_show")){
		//영역펼치기
		$("#jtePopForm_master").find(".pop_detail_info").each(function(){
			$(this).hide();
		});
		//클래스 변경
		$(".pop_detail_btn").removeClass("pop_detail_show");
		$(".pop_detail_btn").addClass("pop_detail_hide");
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
		var msgBox = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId")
		if(!gfn_isNull($("#msg_"+msgBox).val())){
			savePrmt.msgList = JSON.parse($("#msg_"+msgBox).val());
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
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
					
					lfo_common.grid.dataSource.read();
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

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";

	lfo_popGrd.popId = "jtePopAddForm";

	lfo_popGrd.ctrlUrl = "/cform/mtrl/mtrlRecevingMgt";

	lfo_popGrd.crud  = {
		read:{url:"/getMtrlRecevingHisList", auth:"", prmt : {mtrlMgtId : lfo_common.gridSelected.mtrlMgtId}}, 
		create:{url:"/setMtrlManualSave", auth:"", openFunc : lfn_jtePopGrd_popOpen, callback : lfn_jtePopGrd_save},
		update:{url:"/setMtrlManualSave", auth:"", openFunc : "", callback : lfn_jtePopGrd_save},
		destroy:{url:"/setMtrlManualDelete", auth:"", callback : lfn_jtePopGrd_delete}
	};

	lfo_popGrd.model = {
		id: "qmParent",
		fields: {
			mtrlMgtId : { type: "string" },
			mtrlQtyTarget : { type: "string" },
			mtrlQtyTargetCode : { type: "string" },
			mtrlQtyTotal : { type: "string" },
			mtrlQtyDesc : { type: "string" },
			mtrlQtyPgCd : { type: "string" },
			mtrlQtyPgNm : { type: "string" },
			mtrlQtyDate : { type: "string" },
			mtrlQtyUser : { type: "string" }
		}
	};

	lfo_popGrd.columns = [
		{selectable : true, width:"45px"},
		{field: "mtrlQtyTargetCode",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("col_update", "수정"), width: "95px"},
		{field: "mtrlQtyTarget",  template:"# var item = gfn_isNull(gfn_getCode(mtrlQtyTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlQtyTarget).cdId , gfn_getCode(mtrlQtyTarget).cdNm) # #= item #",
			title:gfn_getMsg("col_targetDiv", "업무구분"), width: "120px"},
		{field: "mtrlQtyTargetCode", title:gfn_getMsg("col_divCd", "업무코드"), width: "180px"},
		{field: "mtrlQtyTotal", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity", "수량"), width: "90px"},	
		{field: "mtrlQtyDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate", "등록일"), width: "175px"},
		{field: "mtrlQtyUserNm", title:gfn_getMsg("col_registUser", "등록자"), width: "130px"},
		{field: "mtrlQtyDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];

	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_registUser", "등록자"), value: "u_table.mtrlQtyUserNm" },
		{ text: gfn_getMsg("col_divCd", "업무코드"), value: "u_table.mtrlQtyTargetCode" }
	];

	lfo_popGrd.validation ={
			mtrlQtyTotal:{
				messages : "수량을 입력하세요",
				rules : function(input){
					if(input.is("[name=mtrlQtyTotal]")){
						return input.val().length != 0;
					}
					return true;
			}
		},
		mtrlQtyDate:{
			messages : "등록일을 등록하세요",
			rules : function(input){
				if(input.is("[name=mtrlQtyDate]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		mtrlQtyUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=mtrlQtyUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 등록자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "780px",
		height: "290px",
		id:lfo_popGrd.popId, 
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlQtyRegist", "자재입고수량 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlQtySrh", "자재입고수량 수정");
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}


//팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	lfo_popGrd.gridSelected = {};
	if(mode=='NEW'){
		selectedItem={ 
				mtrlMgtId : lfo_common.gridSelected.mtrlMgtId,
				mtrlQtyTarget: "mtrl_tagt01",
				mtrlQtyDate : new Date(),
				mtrlQtyUserNm : $("#_loginUserName").val(),
				mtrlQtyUser : $("#_loginUserId").val()
		};
		gfn_popform_set(lfo_popGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_popGrd.gridSelected = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_popGrd.gridSelected = {mtrlQtyTargetCode : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.read.url,
			type: "POST",
			data: {
				mtrlMgtId : lfo_common.gridSelected.mtrlMgtId, 
				mtrlQtyTarget: lfo_popGrd.gridSelected["mtrlQtyTarget"], 
				mtrlQtyTargetCode:lfo_popGrd.gridSelected["mtrlQtyTargetCode"]
			},
			success: function(data){
				gfn_popform_set(lfo_popGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//유저정보 팝업 -콜백시 유저정보를 매핑해준다.
this.lfn_addFormUserPop_open = function(){
	var callback = function(selectedItem){
		$("#" + lfo_popGrd.popId + "_form").find("[name=mtrlQtyUser]").val(selectedItem["userId"]);
		$("#" + lfo_popGrd.popId + "_form").find("[name=mtrlQtyUserNm]").val(selectedItem["userNm"]);
	}
	gfn_openCustomPop('userInfo',callback);
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_popGrd.popId);
					
					//마스터 그리드 리로드
					lfo_common.grid.dataSource.read();
					//이전 팝업화면 리로드
					lfn_jtePop_set('EDT',lfo_common.gridSelected);
					
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
this.lfn_jtePopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delTemp = lfo_popGrd.grid.dataItem($(this).closest('tr'))
			delPrmt.push(delTemp);
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
			lfo_common.grid.dataSource.read();
			lfn_jtePop_set('EDT',lfo_common.gridSelected);
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});	
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

</script>