<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="inputQualMgtForm" style="width: 100%;">
	<div id="jteSingleGrid" class="inputQualMgtForm"></div>
</div>

<!-- 체크리스트 -->
<div style="display: none;">
	<div id="pop_inputQualMgt">
		<form id="pop_inputQualMgt_form" class="pop_inputQualMgt_Form">
			<table id="pop_inputQualMgt_form_tb" style="width: 94%;" class="inputQualMgtForm-table" style="display:none;">
				<colgroup>
					<col class='col-input-list-1'>
					<col class='col-input-list-2'>
					<col class='col-input-list-3'>
					<col class='col-input-list-4'>
				</colgroup>
				<tr	class="inputQualMgtForm input-list pop_selfInspect_Form_title" >
					<td>No</td>
					<td><spring:message code="col_mtrlOdcursitItem" text = "항목"/></td>
					<td><spring:message code="col_mtrlOdcursitStandard" text = "규격"/></td>
					<td><spring:message code="col_valueInput" text = "수치 입력"/></td>
				</tr>
			</table>
			<div class="inputQualMgtForm final-btn-area" style="text-align: center;" id="pop_inputQualMgtBtn"></div>
		</form>
	</div>
</div>

<!-- 개별 자재 검색 그리드 -->
<div style="display:none;">
	<div id="searchMtrlMgt">
		<div id="mtrlMgt_grid"></div>
	</div>
</div>


<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/inputQualMgt/inputQualMgtForm_JJW.css' rel="stylesheet">


<script>

var lfo_common = {}; 

var lfo_mtrlBadGrd = {};

var lfo_mtrlMgtGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//자재 관리 조회
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/qualMgt/inputQualMgt"

	lfo_common.crud  = {
		read:{url:"/getMtrlMgtHisList", auth:"", prmt:{}, dynamicPrmt:{mtrlMgtId : "mtrlMgtId"}, search:false}

	};

	lfo_common.model = {
			id: "mtrlMgtId",
			fields: {
				mtrlMgtId : { type: "string" },
				mtrlQtyTarget : { type: "string" },
				mtrlQtyTargetCode : { type: "string" },
				mtrlInspect : { type: "string" },
				mtrlQtyTotal : { type: "string" },
				mtrlQtyDesc : { type: "string" },
				mtrlQtyPgCd : { type: "string" },
				mtrlQtyPgNm : { type: "string" },
				mtrlQtyDate : { type: "string" },
				mtrlInspect : { type: "string" },
				mtrlQtyUser : { type: "string" }
			}
	};
	
	lfo_common.columns = [
		{field: "mtrlQtyTarget", editable: function(){return false;}, title:"보기" , width:"90px",			//수령
			template : function(rows) {
				if (rows.mtrlInspect == "inspecWaiting"){
					return '<button class="k-button k-primary" type="button" onclick = "lfn_inspectPop(\'NEW\', this) " style="width:90px;">'+ "<spring:message code = "col_checkList" />" +'</button>';
				}else if(rows.mtrlInspect == "inspecComplete") {
					return '<button class="k-button k-primary" type="button" onclick = "lfn_inspectPop(\'EDT\', this) " style="width:90px;">'+ "<spring:message code = "col_checkList" />" +'</button>';
				}
			}
		},
		{field: "mtrlInspect", title:gfn_getMsg("col_inspectState"), width: "90px;",
			template:
				function(rows){
				if(rows.mtrlInspect == 'inspecWaiting'){
						return '<span style="color:red">'+gfn_getMsg("bc_"+ gfn_getCode(rows.mtrlInspect).cdId , gfn_getCode(rows.mtrlInspect).cdNm)+'</span>';					//내역보기
				}else if (rows.mtrlInspect == 'inspecComplete'){
					return '<span style="color:blue">'+gfn_getMsg("bc_"+ gfn_getCode(rows.mtrlInspect).cdId , gfn_getCode(rows.mtrlInspect).cdNm)+'</span>';
				}
			}
		},	
		{field: "mtrlQtyTarget",  template:"# var item = gfn_isNull(gfn_getCode(mtrlQtyTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlQtyTarget).cdId , gfn_getCode(mtrlQtyTarget).cdNm) # #= item #",
			title:gfn_getMsg("col_targetDiv", "업무구분"), width: "120px"},
		{field: "mtrlQtyTotal", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_quantity", "수량"), width: "90px"},	
		{field: "mtrlQtyDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate", "등록일"), width: "175px"},
		{field: "mtrlQtyUserNm", title:gfn_getMsg("col_registUser", "등록자"), width: "130px"},
		{field: "mtrlQtyDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];
	
	lfo_common.customTitle = {
			html : '<span class="jte-search-aria"><label>'+"자재"+' : </label>'
			+ '<input class="k-textbox" id="mtrlNm" style="width:200px;" readonly/>'
			+ '<input id="mtrlMgtId" type="hidden">'
			+ '<button class="k-button k-primary" type="button" onclick="lfn_mtrlMgtPop_open(\'mtrlPlate\')">판 자재 조회</button>'
			+ '<button class="k-button k-primary" type="button" onclick="lfn_mtrlMgtPop_open(\'mtrlCasting\')">주물 자재 조회</button>',
			callback : lfn_customTltle_set
		};
	
	lfo_common.selectBox = [
	];
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//자재 입고 조회 (판, 주물 분리)
this.lfn_mtrlMgtPop_open = function(mode){
		var options = {
				modal:true, 
				width: "850px", 
				height: "500px",
				id: "searchMtrlMgt", 
				resizable: true,
				animation: {open :{effects:"expand:vertical fadeIn"},
				close : {effects:"expand:vertical fadeIn", reverse: true}},
				actions: [/*"Minimize", "Maximize", */"Close"]
			};
		if(mode == "mtrlPlate"){
			options.title = gfn_getMsg("pop_plateMtrl", "판자재"); 
		}else if(mode == "mtrlCasting"){
			options.title = gfn_getMsg("pop_castingMtrl", "주물자재");
		}
		
		options.callback = function(){
			$("#mtrlMgt_grid").empty();
			
			lfn_mtrlMgtGrid(mode);
			$('#mtrlMgt_grid').parent().css('height', '100%');
		};
		
		this.gfn_winOpen(options);
}

//자재 입고 조회 그리드 세팅
this.lfn_mtrlMgtGrid = function(mode){

	lfo_mtrlMgtGrd = {};//Form 내부에서 사용될 Object

	//1.
	lfo_mtrlMgtGrd.layoutId = "mtrlMgt_grid";
	
	//2.
	lfo_mtrlMgtGrd.popId = "searchMtrlMgt";
	
	//3.
	lfo_mtrlMgtGrd.ctrlUrl = "/cform/qualMgt/inputQualMgt";

	//4.
	lfo_mtrlMgtGrd.crud  = {
		read:{url:"/getMtrlMgtList", auth:"", prmt:{}, search: false}
	};
	
	if(mode=="mtrlPlate"){
		lfo_mtrlMgtGrd.crud.read.prmt = {mtrlStdStr03 : "mtrlPlate"};
	} else if(mode == "mtrlCasting") {
		lfo_mtrlMgtGrd.crud.read.prmt = {mtrlStdStr03 : "mtrlCasting"};
	}
	
	//5.
	lfo_mtrlMgtGrd.model = {
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
			mtrlCost : { type: "int" },
			mtrlDiv: { type: "string" },
			mtrlDesc: { type: "string" },
			isUse: { type: "bool" },
			isDel: { type: "bool" },
			mtrlDesc: { type: "string" }
		},
	};
	
	//6.
	lfo_mtrlMgtGrd.columns = [
		{field: "mtrlMgtId",template : '<button class="k-button k-primary" type="button" onclick = "lfn_mtrlMgt_callback(this,\'EDT\') " style="width:80px;">보기</button>',
			title:"보기" , width:"100px"},
		{field : "mtrlNm", title : gfn_getMsg("col_mtrlNm", "자재명"), width: "160px"},
		{field : "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd", "자재입고코드"), width: "150px"}, 
		{field : "mtrlMgtCnt", format: "{0:n0}", attributes : { style : "color: blue; font-weight:bold;  text-align : right;"}, title:gfn_getMsg("col_mtrlQty", "자재수량"), width: "110px"},
		{field : "mtrlStd04", title: "최소재고",   attributes: { style: "color: red; font-weight:bold;  text-align:right;" }, width: "105px"},
		{field : "mtrlMgtDesc", title:gfn_getMsg("col_desc", "설명"), width: "220px"}
	];

	//공통 그리드 세팅 호출 
	lfo_mtrlMgtGrd.grid = gfn_grid_set(lfo_mtrlMgtGrd);

}

//입고 자재 선택
this.lfn_mtrlMgt_callback = function(selectedItems){
	
	var selectedItem = lfo_mtrlMgtGrd.grid.dataItem($(selectedItems).closest('tr'));

	$("#mtrlMgtId").val(selectedItem.mtrlMgtId);
	$("#mtrlNm").val(selectedItem.mtrlNm);
	
	gfn_closePop("searchMtrlMgt");
	
	lfo_common.grid.dataSource.read();
}

//입고검사 체크리스트 팝업 
this.lfn_inspectPop = function(mode, selectedItem) {
	
	lfo_inspect = {};
	
	//2.
	lfo_inspect.popId = "pop_inputQualMgt";
	
	//3.
	lfo_inspect.ctrlUrl = "/cform/qualMgt/qualCheckList"
	
	//4.
	lfo_inspect.crud  = {
		read:{url:"/selectCheckList", auth:"", prmt:{} }, 
		create:{url:"/insertCheckList", auth:"", openFunc: "", callback: lfn_inspectPop_save}, 
		update:{url:"/updateCheckList", auth:"", openFunc: "", callback : lfn_inspectPop_save}
	};
	var option = {
			width: "690px", 
			height: "400px",
			id: lfo_inspect.popId, 
			resizable:false,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"],
			baseGroupCode: "inputQualChk",
			category: "incomming_inspect",
			title: "입고검사"
			
	};
	//기초코드에서 체크리스트 항목 불러옴
	$.each(gfn_getCode(option.baseGroupCode), function(index, item) {
		$("#pop_inputQualMgt_form_tb").append("<tr id=" + item.cdId + ">" +
				"<td class='inputQualMgtForm-index'>" + (index+1) + "</td>" +
				"<td>" + item.cdNm + "</td>" +
				"<td>" + item.cdVal + "</td>" +
				"<td><input class='k-textbox center-input' name='inspectValue' type='text' \></td>" +
				"</tr>");
	});
	

	//팝업이 생성된 뒤 동작해야할 함수 입력
	option.callback = function(){
		lfn_inspectPop_set(mode, selectedItem);
	};
	this.gfn_winOpen(option);
}

//체크리스트 팝업 셋팅
this.lfn_inspectPop_set = function(mode, selectedItem){

	 lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
	 //입고 검사 체크리스트 신규 입력
	 if(mode == 'NEW'){
		 $("#pop_inputQualMgtBtn").append(
					"<button class='k-button k-primary final-btn' type='button' onclick = "+"lfn_inspectPop_save('NEW')>"+"<spring:message code = 'pop_save'/>"+"</button>"+
	 				"<button class='k-button k-primary final-btn' type='button' onclick = "+"gfn_closePop('pop_inputQualMgt')>"+"<spring:message code = 'pop_cancel'/>"+"</button>"
		 );
		 $.ajax({
	 			async:false,
	 			url : lfo_inspect.ctrlUrl + lfo_inspect.crud.read.url,
	 			type: "POST",
	 			data: {targetId: lfo_common.gridSelected.mtrlQtyTargetCode},
	 			success: function(data){
	 				gfn_popform_set(lfo_common, mode, data.rows[0]);
	 			}, error: function(ex){
	 				gfn_loading(false);
	 				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
	 			}
	 		});
	 }else if (mode == 'EDT'){ //입고 검사 체크리스트 수정
		 $("#pop_inputQualMgtBtn").append(
	 				"<button class='k-button k-primary final-btn' type='button' onclick = "+"lfn_inspectPop_save('EDT')>"+"<spring:message code = 'pop_save'/>"+"</button>"+
	 				"<button class='k-button k-primary final-btn' type='button' onclick = "+"gfn_closePop('pop_inputQualMgt')>"+"<spring:message code = 'pop_cancel'/>"+"</button>"
		 );
		 $.ajax({
	 			async:false,
	 			url : lfo_inspect.ctrlUrl + lfo_inspect.crud.read.url,
	 			type: "POST",
	 			data: {targetId: lfo_common.gridSelected.mtrlQtyTargetCode},
	 			traditional :true,
	 			success: function(data){
	 				$.each(data.rows, function(index, item) {
					$('#' + item.questionId).find('input').val(item.questionValue);
				})
	 			}, error: function(ex){
	 				gfn_loading(false);
	 				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
	 			}
	 		});		 
	 }
}

//체크리스트 저장
this.lfn_inspectPop_save = function(mode){

	var insertInspectList = new Array();
	var updateInspectList = new Array();
	var svcUrl = lfo_inspect.ctrlUrl;
	var savePrmt = {};
	//if()
	if(mode == "NEW") {
		$("#pop_inputQualMgt_form_tb").find('tr').each(function(index, item) {
			if(index == 0) {
				return true
			}
			insertInspectList.push({ questionId: $(item).attr('id'), questionValue: $(item).find('input').val(), targetId: lfo_common.gridSelected.mtrlQtyTargetCode , category: "incomming_inspect"});
		});
		svcUrl += "/insertCheckList";
		savePrmt.insertInspectList = insertInspectList;
		savePrmt.currentMenuId = gfn_serializeObject().currentMenuId;
		savePrmt.targetId = lfo_common.gridSelected.mtrlQtyTargetCode;
	} else if(mode == "EDT") {
		$("#pop_inputQualMgt_form_tb").find('tr').each(function(index, item) {
			if(index == 0) {
				return true
			}
			updateInspectList.push({ questionId: $(item).attr('id'), questionValue: $(item).find('input').val(), targetId: lfo_common.gridSelected.mtrlQtyTargetCode});
		});
		svcUrl += "/updateCheckList";
		savePrmt.updateInspectList = updateInspectList;
		savePrmt.currentMenuId = gfn_serializeObject().currentMenuId;
		savePrmt.targetId = lfo_common.gridSelected.mtrlQtyTargetCode;
	}

	$.ajax({
		async:false,
		url : svcUrl,
		type: "POST",
		data: JSON.stringify(savePrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			gfn_closePop(lfo_inspect.popId);
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}

</script>