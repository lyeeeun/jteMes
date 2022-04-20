<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="barcodeRecordForm" style="width:100%;">
	<div id="jteSingleGrid" class="barcodeRecordForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="toolMgtForm">
			<div class="pop_title"><spring:message code = "pop_toolInfo" text = "공구정보"/></div>
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:32%;">
				<col style="width:18%;">
				<col style="width:32%;">
			</colgroup>			
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolNm" text = "공구명"/> : </td>
					<td colspan="4">
						<input type="text" id="toolNm" name="toolNm" format="text" readonly/>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolType" text = "공구유형"/> : </td>
					<td><input id="toolType" name="toolType" format="selBox" msg="tool_div" readonly/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_useLimit" text = "사용한도"/> : </td>
					<td><input type="text" id="toolLimit" name="toolLimit" format="currency" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "비고"/> : </td>
					<td colspan="3"><input type="text" id="toolDesc" name="toolDesc" readonly/></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use" class="use"/>
						<input type="hidden" name="action" id="tool_action" class="tool_action"/>
					</td>
				</tr>
			</table>
			<div class="pop_title"><spring:message code = "pop_qtyMgt" text = "수량관리"/></div>
			<div id="jtePopForm_grid" class="toolMgtForm" style="height: 310px; width: 98%; margin: auto; display: flex;" ></div>
		</form>
	</div>
</div>

<link href='/resources/mes/css/contents/techMgt/barcodeRecord/barcodeRecordForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200410 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};


this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/techMgt/barcodeRecord"

	lfo_common.crud  = {
		read:{url:"/getBarRecordList", auth:"", prmt:{}}
	};

	lfo_common.model = {
		id: "toolId",
		fields: {
			barcodeNum : { type: "string" },
			createdAt : { type: "date" },
			creatorId : { type: "string" },
			updatedAt : { type: "date" },
			updatorId : { type: "string" },
			itemId : { type: "string" }
		}
	};

	lfo_common.columns = [
		{selectable : true, width:"40px"},
		{field: "barcodeNum", title: gfn_getMsg("col_barcodeNum", "바코드넘버"), width: "180px"},
		{field: "createdAt", title: gfn_getMsg("col_barcodeCreat", "생성일"), width: "160px"},
		{field: "itemId", title: gfn_getMsg("col_itemCd", "제품코드"), width: "160px"}
	];

	lfo_common.selectBox = [
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "705px", 
		height: "700px",
		id:lfo_common.popId,
		title: "바코드 조회",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}


//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			toolId : lfo_common.gridSelected.toolId
		}
		gfn_popform_set(lfo_common, mode, selectedItem);
	}else if(mode == 'EDT'){
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {barcodeNum : selectedItem};
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {barcodeNum :lfo_common.gridSelected.barcodeNum},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		//그리드 세팅
		gfn_resizePop(lfo_common.popId, {width:750,height:650});
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();		
	}
}

</script>