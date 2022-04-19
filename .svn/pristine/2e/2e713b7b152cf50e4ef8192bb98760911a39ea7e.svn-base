<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="costMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="costMgtForm"></div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/orderMgt/costMgt/costMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/orderMgt/costMgt/costMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200430 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//서브그리드에서 사용될 Object

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
	lfo_common.ctrlUrl = "/cform/orderMgt/costMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/selectLotCostList", auth:"", prmt:{}},
	};
	
	//5.
	lfo_common.model = {
		id: "lotId",
		fields: {
			lotId: { type: "string" },
			lotNm: { type: "string" },
			lotQty: { type: "long" },
			itemNm: { type: "string" },
			itemMtrlCost: { type: "long" },
			predMtrlCost: { type: "long" },
			presMtrlCost: { type: "long" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "150px"},
		{field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "150px"},
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "150px"},
		{field: "lotQty", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_lotQty"), width: "120px"},
		{field: "itemMtrlCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:"부품 제조원가", width: "120px"},
		{field: "predMtrlCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:"예상 제조원가", width: "120px"},
		{field: "presMtrlCost", format: "{0:n0}", attributes : { style : "text-align : right;"}, title:"실 제조원가", width: "120px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_lotCd"), value: "lotInfo.lot_id" },	
		{ text: gfn_getMsg("col_itemNm"), value: "itemInfo.item_nm" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

</script>