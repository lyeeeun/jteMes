<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="mqsToolMgtForm-grid" style="width:100%;"> <!-- style="width: 100%;" -->
	<div id="jteSingleGrid"></div>
</div>

<!-- CSS -->
<!-- <link href='/resources/mes/css/contents/techMgt/mqsToolMgt/mqsToolMgtForm.css' rel="stylesheet"> -->

<!-- 내부 스타일 외부로 이동_200805 youmi -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
};

this.lfn_gridSearch = function(){
	lfo_common.grid.dataSource.query({
		page: 1,
		pageSize: 10
	});
}

// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_common = {};

	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "";
	
	//3.
	lfo_common.ctrlUrl = "/form/techMgt/offsetMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/selectOffsetData", auth:"", prmt:{}}
	};
	
	//5.
	lfo_common.model = {
		fields: {
			transferDt : { type: "string" },
			itemCd : { type: "string" },
			opNo : { type: "string" },
			dimNo : { type: "string" },
			axiesNo : { type: "string" },
			halfValue : { type: "float" },
			maxValue : { type: "float" },
			minValue : { type: "float" },
			gaValue : { type: "float" },
			distanceValue : { type: "float" },
			offsetNo : { type: "string" },
			guOffset : { type: "string" },
			offsetBefore : { type: "float" },
			offsetAdjust : { type: "float" },
			offsetAfter : { type: "float" },
			machineNo : { type: "string" }
		},
	};
	
	//6.
	lfo_common.columns = [
		{field: "transferDt", title: "전송일자", width: "140px"},
		{field: "itemCd", title: "제품 코드", width: "140px"},
		{field: "opNo", title: "공정 코드", width: "140px"},
		{field: "dimNo", title: "측정 코드", width: "160px"},
		{field: "axiesNo", title: "axiesNo", width: "130px"},
		{field: "halfValue", title: "중간 규격", width: "130px"},		
		{field: "maxValue",  title: "상한 값", width: "130px"},			
		{field: "minValue", title: "하한 값", width: "130px"},
		{field: "gaValue", title: "ga Value", width: "130px"},
		{field: "distanceValue", title: "distance Value", width: "130px"},
		{field: "offsetNo", title: "오프셋 코드", width: "130px"},
		{field: "guOffset", title: "오프셋 구분", width: "130px"},
		{field: "offsetBefore", title: "적용 전", width: "130px"},
		{field: "offsetAdjust", title: "적용", width: "130px"},
		{field: "offsetAfter", title: "적용 후", width: "130px"},
		{field: "machineNo", title: "설비 코드", width: "130px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "제품 코드", value: "ITEM_CD" },
		{ text: "설비 코드", value: "Machine_No" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}

</script>