<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div style="width:100%;">
	<div class="mqsToolMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<input id="workLineSelBox">
		<input type="hidden" id="workLineSelected" value="self_inspect_ann">
	</div>
	<div id="grid-content" class="shipPectMgtForm" style="width:100%;">
		<div id="jteSingleGrid" class="shipPectMgtForm"></div>
	</div>
</div>




<div style="display:none;">
	<div id="pop_selfInspectAnn">
	</div>
</div>

<div style="display:none;">
	<div id="pop_selfInspectDct">
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!--  <link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_lym.css' rel="stylesheet">  -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/shipPectMgt/shipPectMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_jteSgGrd_setGrd("selfInspectAnn");
	lfn_selBoxSet();
};

this.lfn_selBoxSet = function(){
	
	var selBoxItem = new Array();
	var tCategory = "";
	$.each(gfn_ajaxCallByList("place",{placeStrStd01 : "ParentWorkLine"}), function(index, item) {
		tCategory = "self_inspect_" + item.placeNm.toLowerCase();
		selBoxItem.push({ placeNm: item.placeNm, category: tCategory })
	});

	$("#workLineSelBox").kendoDropDownList({
		dataTextField: "placeNm",
		dataValueField: "category",
		dataSource: selBoxItem,
		index: 1,
		change: function(e) {
			$("#workLineSelected").val(this.value())
			
			if(this.value() == "self_inspect_dct") {
				lfn_jteSgGrd_setGrd("selfInspectDct");
			} else if(this.value() == "self_inspect_ann") {
				lfn_jteSgGrd_setGrd("selfInspectAnn");	
			}
		}
	});
}



this.lfn_jteSgGrd_setGrd = function(target){
	$("#jteSingleGrid").empty();
	
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
	lfo_common.ctrlUrl = "/cform/qualMgt/qualCheckList";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/selectCheckListHistory", auth:"", prmt:{}, dynamicPrmt:{category: "workLineSelected"}, period:{stdt:-15, eddt:0}, search : false}
		//read:{url:"/selectCheckListHistory", auth:"", prmt:{category:"incomming_inspect"}, period:{stdt:-15, eddt:0}, search : false}
	};
	
	//5.
	lfo_common.model = {
		id: "inspectId",
		fields: {
			inspectId : { type: "string" },
			targetId : { type: "string" },
			inspectDate : { type: "string" },
			inspectorId : { type: "string" },
			inspectorNm : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "incomingInspection", editable: function(){return false;}, title: "공정 검사", width:"95px",			//수령
			template : function(rows) {
				return '<button class="k-button k-primary" type="button" onclick = "gfn_inspectPop(\'EDT\', \'' + target + '\', \'pop_' + target + '\', \'' + rows.inspectId + '\') " style="width:60px;">'+ "공정 검사" +'</button>';					//내역보기
			}
		},
		{field: "inspectId", title:gfn_getMsg("col_inspectCd"), width: "170px;"},													//포장작업코드
		{field: "targetId", title:"LOT Code", width: "220px;"},															//부품명
		{field: "inspectDate", title:gfn_getMsg("col_inspectDate"), width: "170px;"},															//LoT코드
		{field: "inspectorNm", title:gfn_getMsg("col_inspector"), width: "150px;"}													//업체명
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
</script>