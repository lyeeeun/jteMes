<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="shipPectMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="shipPectMgtForm"></div>
</div>

<div style="display:none;">
	<div id="pop_shipmentInspect">
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
	//그리드 생성
	lfn_jteSgGrd_setGrd();
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
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/qualMgt/qualCheckList";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/selectCheckListHistory", auth:"", prmt:{category:"shipment_inspect"}, period:{stdt:-15, eddt:0}, search : false}, 
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
		{field: "shipmentInspect", editable: function(){return false;}, title:gfn_getMsg("col_shipInspect"), width:"95px",			//출고검사
			template : function(rows) {
				return '<button class="k-button k-primary" type="button" onclick = "gfn_inspectPop(\'EDT\', \'shipmentInspect\', \'pop_shipmentInspect\', \'' + rows.inspectId + '\') " style="width:60px;">'+ ""+gfn_getMsg("col_shipInspect")+"" + '</button>';	}
		},
		{field: "inspectId", title:gfn_getMsg("col_inspectCd"), width: "170px;"},									//검사코드
		{field: "targetId", title:"출고 코드", width: "220px;"},															//발주코드
		{field: "inspectDate", title:gfn_getMsg("col_inspectDate"), width: "170px;"},								//검사일자
		{field: "inspectorNm", title:gfn_getMsg("col_inspector"), width: "150px;"}									//검사자
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
</script>