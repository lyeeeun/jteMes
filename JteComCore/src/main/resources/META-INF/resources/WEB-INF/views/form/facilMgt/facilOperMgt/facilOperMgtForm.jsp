<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" >
	<div id="jteSingleGrid" ></div>
</div>

<!-- 가동시간 POP -->
<div style="display:none;">
	<div id="jtePopEqmtWork">
		<div class="pop_title"><spring:message code = "pop_totalEqmt" text = "설비종합" /></div>
		<table class="eqmtOverall">
			<tr>
				<td>
					<i class="fas fa-caret-right"></i><spring:message code = "col_totalEqmtUp" text = "설비 총 가동시간" /> : <label name="runTime"></label>
				</td>
				<td>
					<i class="fas fa-caret-right left-caret"></i><spring:message code ="col_totalEqmtEffect" text = "설비종합효율" /> : <label name="eqmtPercent"></label>
				</td>
			</tr>
		</table>
		<div class="pop_title"><spring:message code = "pop_operTime" text = "가동시간" /></div>
		<div id="jtePopEqmtWork_grid" style="height:235px"></div>
	</div>
</div>

<link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_JJW.css' rel="stylesheet">

<script>
var lfo_common = {};

<<<<<<< HEAD
var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_eqmtMtncGrd = {};//가동이력 Object

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//서브 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/operMgt/facilMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getEqmtMgtList", auth:"", prmt:{}}
	};
	
	//5.
	lfo_common.model = {
		id: "eqmtMgtId",
		fields: {
			eqmtMgtId : { type: "string" },
			eqmtMgtGbn : { type: "string" },
			eqmtMgtMtnc : { type: "int" },
			eqmtMgtNm : { type: "string" },
			eqmtMgtPurchase : { type: "date" },
			eqmtMgtVerif : { type: "date" },
			eqmtMgtDesc : { type: "string" },
			eqmtMgtFile : { type: "string" },
			isUse : { type: "bool" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" },
			placeId : { type: "string" },
			placeNm : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		
		{ field: "eqmtMgtId", title: gfn_getMsg("col_history", "이력"), width: "80px",
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_eqmtWorkPop(this) " style="">'+gfn_getMsg("pop_operTime", "가동이력")+'</button>'
		},
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm", "설비명"), width: "130px"},
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd", "설비개별코드"), width: "160px"},
		{field: "eqmtMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(eqmtMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(eqmtMgtGbn).cdId , gfn_getCode(eqmtMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_eqmtDiv", "설비구분"), width: "130px;"},
		{field: "eqmtMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate", "입고일"), width: "110px"},
		{field: "eqmtMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod", "검증기간"), width: "110px"},
		{field: "eqmtMgtMtnc", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_mtnc", "정비주기"), width: "110px"},
		{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc", "설명"), width: "280px"}
	];
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_eqmtDetailNm", "설비명"), value: "eqmtMgt.eqmt_mgt_nm" },
		{ text: gfn_getMsg("col_eqmtIndivCd", "설비개별코드"), value: "eqmtMgt.eqmt_mgt_id" },
		{ text: gfn_getMsg("col_placeNm", "위치명"), value: "place.place_nm" },
		{ text: gfn_getMsg("col_desc", "설명"), value: "eqmtMgt.eqmt_mgt_desc" }
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//가동이력 버튼 클릭(팝업 오픈)
this.lfn_eqmtWorkPop = function(target){
	var options = {
		modal:true, 
		width: "800px", 
		height: "390px",
		id : "jtePopEqmtWork", 
		title:gfn_getMsg("pop_eqmtOperTime", "설비 가동이력"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_common.grid.dataItem($(target).closest("tr"));	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteEqmtWork_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}

//가동이력 그리드 세팅
this.lfn_jteEqmtWork_setGrd = function(dataItem){
	lfo_eqmtWorkGrd = {eqmtMgtId : dataItem.eqmtMgtId};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_eqmtWorkGrd.layoutId = "jtePopEqmtWork_grid";
	
	//2.
	//lfo_eqmtWorkGrd.popId = "jtePopForm";
	
	//3.
	lfo_eqmtWorkGrd.ctrlUrl = "/form/facilMgt/facilCorMgt";
	
	//4.
	lfo_eqmtWorkGrd.crud  = {
		read:{url:"/getEqmtWorkList", auth:"", search:false, paging:false, prmt:{eqmtMgtId : dataItem.eqmtMgtId}, dynamicPrmt:{eqmtWorkStart:"hidEqmtWorkStart"}},
		excel:{url:"" ,auth:"", fileName: "설비사용 이력_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
	};
	
	lfo_eqmtWorkGrd.customTitle = {html:"<input id='eqmtWorkStart' name='eqmtWorkStart' />"+
										"<input type='hidden' id='hidEqmtWorkStart' name='hidEqmtWorkStart'>"
			, callback : lfn_jteWorkDate_set};
	
	//5.
	lfo_eqmtWorkGrd.model = {
		id: "eqmtMgtId",
		fields: {
			eqmtMgtId : { type: "string" },
			eqmtWorkStart: { type: "date" },
			eqmtWorkEnd: { type: "date" }
		}
	};
	
	//6.
	lfo_eqmtWorkGrd.columns = [
		{field: "eqmtWorkStart", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_eqmtWrkStart", "설비가동시작"), width: 120},
		{field: "eqmtWorkEnd", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_eqmtWrkEnd", "설비가동종료"), width: 120}
	];
	//7.

	
	//공통 그리드 세팅 호출 
	lfo_eqmtWorkGrd.grid = gfn_grid_set(lfo_eqmtWorkGrd);
}

//해당날짜의 작업정보를 조회하기 위한 date 세팅
this.lfn_jteWorkDate_set = function(){
	//초기 오늘 데이터를 매핑
	if($("#eqmtWorkStart").attr("data-role") != "datepicker"){
		$("#eqmtWorkStart").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : new Date(),
			change : function(){
				$("#hidEqmtWorkStart").val($("#eqmtWorkStart").val());
				lfo_eqmtWorkGrd.grid.dataSource.read();
				lfn_eqmtWorkPop_set();
			}
		});
	}
	$("#hidEqmtWorkStart").val($("#eqmtWorkStart").val());
	lfn_eqmtWorkPop_set();
}

//가동시간 팝업 세팅
this.lfn_eqmtWorkPop_set = function(){
	
	$.ajax({
		async:false,
		url : "/form/facilMgt/facilCorMgt/getEqmtOverall",
		type: "POST",
		data: {eqmtMgtId : lfo_eqmtWorkGrd.eqmtMgtId, eqmtWorkStart : $("[name=hidEqmtWorkStart]").val()},
		success: function(data){
			$("[name=runTime]").text(gfn_isNull(data.rows.runTime) == true ? 0 : data.rows.runTime);
			$("[name=eqmtPercent]").text(data.rows.eqmtPercent*100+"%");
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}
</script>