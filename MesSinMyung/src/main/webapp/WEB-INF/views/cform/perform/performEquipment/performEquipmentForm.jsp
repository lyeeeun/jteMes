<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="performEquipmentForm">
	<div class="performEquipmentForm search-btn-area">
		<input type="text" class="k-textbox" id="placeNm" readonly/>
		<input type="hidden" id="placeId">
		<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_placeInfo();"><spring:message code = "btn_search"/></button>
		<em class='playButton' style="margin-left:10px;"></em><em class='stopButton' style="margin-left:10px;"></em>
		<input type="hidden" id="autoFlag" />
	</div>
</div>
<div id="grid-content" class="performEquipmentForm-gird"> <!-- style="width:100%;" -->
	<div id="jteSingleGrid"></div>
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


this.lfn_placeInfo = function() {
	var callback = function(selectedItem){
		$('#jteSingleGrid').empty();
		$('#placeId').val(selectedItem.placeId);
		$('#placeNm').val(selectedItem.placeNm);
		
		lfn_jteSgGrd_setGrd();
	};
	gfn_openCustomPopTree('place', callback);
}


// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_common = {};//Form 내부에서 사용될 Object
	lfo_common.count = 0;
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
	lfo_common.popId = "";
	
	//3.
	lfo_common.ctrlUrl = "/cform/perform/performEquipment";

	//4.
	lfo_common.crud  = {
		read:{url:"/getPerfromEquipInfo", auth:"", prmt:{}, dynamicPrmt:{placeId: "placeId"}, paging:false, search:false}
	};
	
	//5.
	lfo_common.model = {
		fields: {
			eqmtMgtId : { type: "string" },
			eqmtMgtNm : { type: "string" },
			itemNm : { type: "string" },
			totalTarget : { type: "int" },
			totalOutput : { type: "int" },
			totalDefect: { type: "int" },
			eqmtAchieveRate: { type: "number" },
			eqmtDefectRate: { type: "number" },
			eqmtStatus: { type: "string"},
			workUser: { type: "string"}
		},
	};
	
	lfo_common.aggregate = [{ field: "eqmtAchieveRate", aggregate: "average" },
		{ field: "eqmtDefectRate", aggregate: "average" },
		];
	 
	//6.
	lfo_common.columns = [
		{field: "eqmtStatus", attributes:{ 'style':"#=eqmtStatus==\'RUN\'?'background-color: green; color:white;':''#" },
			title:gfn_getMsg("col_operateStatus"), width: "140px"},									//가동상태
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: "160px"},					//설비개별코드
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtNm"), width: "130px"},						//설비명
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "120px"},						//설비명
		{field: "workUser", title:gfn_getMsg("col_worker"), width: "130px"},						//작업자
		{field: "totalTarget", title:gfn_getMsg("col_totalAsmQuan"), width: "130px"},				//총지시량
		{field: "totalOutput",  title: gfn_getMsg("col_totalProdQuan"), width: "130px"},			//총생산량
		{field: "totalDefect", title:gfn_getMsg("col_totalBadQuan"), width: "130px"},				//총불량량
		{field: "eqmtAchieveRate", title:gfn_getMsg("col_archievRate"), format: "{0:0.000'%'}", width: "120px",
			aggregates: ["average"], footerTemplate: 'Average: #=data.eqmtAchieveRate ? data.eqmtAchieveRate.average : 0 #'},			//달성률
		{field: "eqmtDefectRate", title:gfn_getMsg("col_badRate"), format: "{0:0.000'%'}", width: "120px",
			aggregates: ["average"], footerTemplate: 'Average: #=data.eqmtDefectRate ? data.eqmtDefectRate.average : 0 #'}					//불량률
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_eqmtIndivCd"), value: "eqmtMgtID" },			//설비개별코드
		{ text: gfn_getMsg("col_eqmtNm"), value: "eqmtMgtNm" }					//설비명
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}


this.lfn_autoMonitoring = function() {
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/selectPlaceAll",
		type: "POST",
		data: {},
		success: function(data){
			lfo_common.repeat = setInterval(function() {
				if(data.rows.length == lfo_common.count) {
					lfo_common.count = 0;
				}
				$('#placeId').val(data.rows[lfo_common.count].placeId);
				$('#placeNm').val(data.rows[lfo_common.count].placeNm);
				lfo_common.grid.dataSource.read();
				
				lfo_common.count++;
			}, parseInt(gfn_getCode('eqmt_refresh_time').cdVal)*1000);
		}, 
		error: function(ex){
			gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
		}
	});
}
</script>