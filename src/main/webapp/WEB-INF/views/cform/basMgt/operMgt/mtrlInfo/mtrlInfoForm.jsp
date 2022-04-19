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
			<div class="pop_title"><spring:message code = "pop_mtrlInfo" text = "자재정보" /></div>
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:31%;">
				<col style="width:20%;">
				<col style="width:31%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm" text = "자재명"/> : </td>
					<td colspan="3"><input type="text" id="mtrlNm" name="mtrlNm" format="text"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlType" text = "자재유형"/> : </td>
					<td><input id="mtrlType" name="mtrlType" format="selBox" msg="mtrl_div"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlStdStd03" text = "자재유형 구분"/> : </td>
					<td><input id="mtrlStdStr03" name="mtrlStdStr03" format="selBox" msg="mtrlQualSta"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlStdStr01" text = "자재규격"/> :</td>
					<td colspan="3"><input type="text" id="mtrlStdStr01" name="mtrlStdStr01"/></td>
				</tr> 
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="mtrlDesc" class="k-textbox" name="mtrlDesc"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlStdStr02" text = "변경이력"/> :</td>
					<td colspan="3"><textarea id="mtrlStdStr02" name="mtrlStdStr02" rows="3"></textarea></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="mtrl_action"/>
						<input type="hidden" name="mtrlId" id="mtrlId"/>
					</td>
				</tr>
			</table>
			<div class="pop_title"><spring:message code = "pop_compMgt" text = "업체관리"/></div>
			<div id="jtePopForm_grid" class="mtrlInfoForm" style="height: 222px; width: 98%; margin: auto; display: flex;"></div>
			
			<div class="final-btn-area mtrlInfoForm-final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
			</div>
		</form>
	</div>
</div>

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

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/mtrlInfo"

	lfo_common.crud  = {
		read:{url:"/getMtrlInfoList", auth:"", prmt:{}, dynamicPrmt : {itemId : "itemId"}}, 
		create:{url:"/setMtrlInfoSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setMtrlInfoSave", auth:"", callback:lfn_popSave},  
		destroy:{url:"/setMtrlInfoDelete", auth:"", callback:lfn_jteGrid_delete}
	};

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
			mtrlStd04: { type: "float" },
			mtrlStd05: { type: "int" },
			mtrlStdStr01 : { type: "string" },
			mtrlStdStr02 : { type: "string" },
			mtrlStdStr03 : { type: "string" },
			mtrlStdStr04 : { type: "string" },
			mtrlStdStr05 : { type: "string" },
			mtrlCost: { type: "int" },
			createdAt: { type: "string" },
			updatedAt: { type: "string" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			mtrlDiv: { type: "string" },
			isUse: { type: "bool" },
			compNm : { type: "string" }
		}
	};

	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this);" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update", "수정"), width: "90px"},
		{field: "mtrlId", title:gfn_getMsg("col_mtrlCd", "자재코드"), width: "140px"},
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm", "자재명"), width: "170px"},
		{field: "mtrlStdStr03", template:"# var item = gfn_isNull(gfn_getCode(mtrlStdStr03))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStdStr03).cdId , gfn_getCode(mtrlStdStr03).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlStdStr03", "자재유형 구분"), width: "95px;"},
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlType", "자재유형"), width: "95px;"},
 		{field: "mtrlStdStr01", title : gfn_getMsg("col_mtrlStdStr01", "자재규격"), width: "150px"},
		{field: "mtrlDesc", title:gfn_getMsg("col_desc", "설명"), width: "280px"},
		{field: "mtrlStdStr02", title: gfn_getMsg("col_mtrlStdStr02", "변경이력"), width: "140px",
			template : function(e){return e.mtrlStdStr02.split('\n')[0]}},
		{field: "compNm", title: gfn_getMsg("col_mtrlOrderComp", "발주처"), width: "280px"},
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse", "사용유무"), width:"95px",
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic", "기본")+" : Y";
				}
			}
		}
	];
	
/* 	lfo_common.customTitle = {
		html: '<button class="k-button k-primary" type="button" onclick = "lfn_bomMtrl(\'all\');" style="min-width:60px;">전체 검색</button> &nbsp; <button class="k-button k-primary" type="button" onclick = "lfn_bomMtrl(\'item\');" style="min-width:60px;">품목 검색</button>' +
		'<input class="k-textbox" id="itemNm" readonly/><input type="hidden" id="itemId" /> '
	}; */

	lfo_common.selectBox = [ 
		{ text: gfn_getMsg("col_mtrlNm", "자재명"), value: "mtrlInfo.mtrl_nm" },
		{ text: gfn_getMsg("col_mtrlCd", "자재코드"), value: "mtrlInfo.mtrl_id" },
		{ text: gfn_getMsg("col_mtrlOrderComp", "발주처"), value: "compNm" }
	];

	lfo_common.validation ={
		mtrlNm:{
			messages : "자재명을 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "705px", 
		height: "802px",
		id:lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlRegist", "자재 등록");
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlSrh", "자재 수정");
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode, selectedItem){
	lfo_common.gridSelected = {};
	
	var childItems = [];
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode,selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {mtrlId : selectedItem};
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/getMtrlPop",
			type: "POST",
			data: {mtrlId : lfo_common.gridSelected.mtrlId},
			success: function(data){
				gfn_popform_set(lfo_common, mode, data.rows);
				
				//업체 정보를 담는다.
				childItems = data.rows.childCompList;
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	//업체 grid 생성 (mtrl-child)
	lfn_jtePopGrd_setGrd(childItems);
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
		
		//업체 정보를 담아준다.
		savePrmt.childCompList = lfo_popGrd.childItems;
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data == 'CONST'){
					gfn_warnBox({msg : "실패하였습니다. \n 등록된 데이터가 이미 사용중입니다."});
				}else if(data != ""){
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



//팝업내부 그리드  (mtrl-child)
this.lfn_jtePopGrd_setGrd = function(childItems){
	$("#jtePopForm_grid").html("");
	lfo_popGrd = {};

	lfo_popGrd.layoutId = "jtePopForm_grid";

	lfo_popGrd.ctrlUrl = "/cform/basMgt/operMgt/mtrlInfo"

	lfo_popGrd.crud  = {
		read:{url:"/getMtrlRtlCompList", auth:"", prmt:{mtrlId: lfo_common.gridSelected.mtrlId}}, 
		create:{url:"/setMtrlRtlCompSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		//update:{url:"", auth:"", openFunc:"", callback:""},
		destroy:{url:"/setMtrlRtlCompDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};

	lfo_popGrd.model = {
		id: "compId",
		fields: {
			action: { type: "string" },
			compId: { type: "string" },
			mtrlId: { type: "string" },
			mtrlPrice: { type: "int" },
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
			isUse: { type: "bool" },
			compStd01: { type: "int" },
			compStd02: { type: "int" },
			compStd03: { type: "int" },
			compStd04: { type: "int" },
			compStd05: { type: "int" },
			compStdStr01: { type: "string" },
			compStdStr02: { type: "string" },
			compStdStr03: { type: "string" },
			compStdStr04: { type: "string" },
			compStdStr05: { type: "string" }
		}
	};

	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		//{field: "compId", title:gfn_getMsg("col_compCd", "업체코드"), width: "140px"},
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '기존' : '에러' #",
			title: gfn_getMsg("col_action", "액션"), width: "95px"},
		{field: "compStdStr02", title:gfn_getMsg("col_compStdStr02", "거래처코드"), width: "130px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "190px"},
		{field: "compNumber", title:gfn_getMsg("col_busiNum", "사업자번호"), width: "160px"}
	];

	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_compNm", "업체명"), value: "comp.comp_nm" },
		{ text: gfn_getMsg("col_compCd", "업체코드"), value: "comp.comp_id" },
		{ text: gfn_getMsg("col_desc", "설명"), value: "comp.description" }
	];
	
	//mtrl에 포함된 업체 정보 담아주기 (mtrl-child)
	lfo_popGrd.childItems = childItems;
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_objectDatagrid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(selectedItem){

	//여기부터 공통팝업 띄우기
	gfn_openCustomPop('company',lfn_jtePopGrd_save);
}

//Form내용 입력/저장 (mtrl-child)
this.lfn_jtePopGrd_save = function(savePrmt){
		
	var childItems = gfn_objectDataGrid_save({tgObj : lfo_popGrd, prmt : savePrmt, pk : "compId", autokey : false});
	if(!childItems){
		return false;
	}
	lfo_popGrd.childItems = childItems;
	lfo_popGrd.grid.dataSource.read();
}

//삭제 콜백 (mtrl-child)
this.lfn_jtePopGrd_delete = function(){
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delPrmt = lfo_popGrd.grid.dataItem($(this).closest('tr'));
			
			//데이터 object에 저장 - 부모요소 저장시 저장(삭제)된다.
			gfn_objectDataGrid_delete({tgObj : lfo_popGrd, prmt : delPrmt, pk : "compId"});
		}
	});
	
	//그리드 리로드
	lfo_popGrd.grid.dataSource.read();
}

/* this.lfn_bomMtrl = function(mode){
	
	if(mode == 'item') {
		var callback = function(selectedItem){
			$('#itemNm').val(selectedItem.itemNm);
			$('#itemId').val(selectedItem.itemId);
			
			lfo_common.grid.dataSource.read();
		};
		
		gfn_openCustomPop("item", callback);
	} else {
		$('#itemNm').val(null);
		$('#itemId').val(null);
		
		lfo_common.grid.dataSource.read();
	}
	
} */


</script>