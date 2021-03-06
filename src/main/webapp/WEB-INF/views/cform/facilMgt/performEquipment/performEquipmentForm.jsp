<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="performEquipmentForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<em class='playButton' style="margin-left:10px;"></em><em class='stopButton' style="margin-left:10px;"></em>
		<input type="hidden" id="autoFlag" />
	</div>
	<div id="grid-content" class="performEquipmentForm performEquipmentForm-gird"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
 <!-- <link href='/resources/mes/css/contents/perform/performEquipment/performEquipmentForm_lym.css' rel="stylesheet">  -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/perform/performEquipment/performEquipmentForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200501 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	$(".playButton").kendoButton({
		icon: "play",
		click: function(e) {
			$('#autoFlag').val('Run');
			lfn_autoMonitoring();
		}
	});
	
	$(".stopButton").kendoButton({
		icon: "stop",
		click: function(e) {
			$('#autoFlag').val('Stop');
			clearInterval(lfo_common.repeat);
		}
	});
};

// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_common = {};//Form 내부에서 사용될 Object
	
	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "";

	lfo_common.ctrlUrl = "/cform/facilMgt/performEquipment";

	lfo_common.crud  = {
		read:{url:"/getPerfromEquipInfo", auth:"", prmt:{}, dynamicPrmt:{}, paging:false, search:false}
	};

	lfo_common.model = {
		fields: {
			placeId : { type: "string" },
			eqmtMgtId : { type: "string" },
			eqmtMgtNm : { type: "string" },
			prodAsmNm : { type: "string" },
			prodAsmDate : { type: "date" },
			itemNm : { type: "string" },
			totalTarget : { type: "int" },
			totalOutput : { type: "int" },
			totalDefect: { type: "int" },
			eqmtAchieveRate: { type: "number" },
			eqmtDefectRate: { type: "number" },
			prodWorkStatus: { type: "string"},
			workUser: { type: "string"}
		},
	};

	lfo_common.columns = [
		{field: "prodWorkStatus", template:"# var item = gfn_isNull(prodWorkStatus)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(prodWorkStatus).cdId , gfn_getCode(prodWorkStatus).cdNm) # #= item #",
			attributes:{ 'style':"#=prodWorkStatus==\'work_prs\'?'background-color: green; color:white;':''#" }, title:gfn_getMsg("col_operateStatus"), width: "120px"},
		{field: "eqmtMgtNm", title: gfn_getMsg("col_eqmtMgtNm", "설비명"), width: "150px"},
		{field: "itemNm", title: gfn_getMsg("col_itemNm", "제품명"), width: "150px"},
		{field: "prodAsmNm", title: gfn_getMsg("col_prodAsmNm", "작업지시명"), width:"150px"},
		{field: "prodAsmDate", format: "{0: yyyy-MM-dd}", title: gfn_getMsg("col_prodAsmDate", "작업지시일"), width: "130px"},
		{field: "prodWorkQty", title: gfn_getMsg("col_prodWorkQty", "목표량"), width: "110px"},
		{field: "prodWorkGood",  title: gfn_getMsg("col_prodWorkGood", "양품량"), width: "110px"},
		{field: "prodWorkRate", title: gfn_getMsg("col_prodWorkRate", "달성률"), format: "{0:0.000'%'}", width: "120px"},
		{field: "prodWorkBad", title: gfn_getMsg("col_prodWorkBad", "불량수량"), width: "120px"},
		{field: "prodDefectRate", title: gfn_getMsg("col_prodDefectRate", "불량률"), format: "{0:0.000'%'}", width: "120px"}
	];

	lfo_common.selectBox = [
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}


this.lfn_autoMonitoring = function() {
	lfo_common.repeat = setInterval(function() {
		lfo_common.grid.dataSource.read();
	}, parseInt(gfn_getCode('eqmt_refresh_time').cdVal)*2000);
}
</script>