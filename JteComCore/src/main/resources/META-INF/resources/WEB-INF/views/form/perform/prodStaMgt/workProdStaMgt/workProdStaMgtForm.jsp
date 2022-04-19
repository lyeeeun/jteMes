<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div style="width:100%;">
	<div class="workProdStaMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
	<input type="text" class="k-textbox" id="userId" readonly style="margin-left: 10px;"/>
	<button class="k-button k-primary page-search-btn" type="button" id="userInfoSelBtn" onclick= "lfn_userInfo();"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="workProdStaMgtForm workProdStaMgtForm-gird"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/perform/performItem/performItemForm_JJW.css' rel="stylesheet">

<script>
var lfo_common = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

this.lfn_userInfo = function() {
	var callback = function(selectedItem){
		$('#userId').val(selectedItem.userId);
		$('#userNm').val(selectedItem.userNm);
		lfn_jteSgGrd_setGrd();
	};
	gfn_openCustomPop('userInfo',callback);
}

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};

	lfo_common.layoutId = "jteSingleGrid";
	
	lfo_common.popId = "jtePopForm";
	
	lfo_common.ctrlUrl = "/form/perform/prodStaMgt/workProdStaMgt"
	
	lfo_common.crud  = {
		read:{url:"/getWorkProd", auth:"", prmt:{itemQtyUser: $('#userId').val()}, search : false}
	};
	
	lfo_common.model = {
		id: "itemQtyUser",
		fields: {
			itemQtyUser : { type: "string" },
			itemQtyUserNm : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			itemOrderQty : { type: "int" },
			itemDefectQty : { type: "int" },
			itemDefectRate : { type: "float" },
			itemAchieveQty : { type: "int" },
			itemAchieveRate : { type: "float" }
		}
	};
	
	lfo_common.columns = [
		{ field: "itemId", title: gfn_getMsg("col_itemCd"), width: "130px" },													//부품코드
		{ field: "itemNm", title: gfn_getMsg("col_itemNm"), width: "160px" },													//부품명
		{ field: "itemOrderQty", title: gfn_getMsg("col_totalOrderQty"), width: "120px" },										//총주문수량
		{ field: "itemAchieveQty", title: gfn_getMsg("col_prodQuan"), width: "120px" },											//양품량
		{ field: "itemDefectQty", title: gfn_getMsg("col_badProdQuan"), width: "120px" },										//불량량
		{ field: "itemAchieveRate", title: gfn_getMsg("col_workAchieveRate"), format: "{0: 0.000'%'}", width: "120px" },		//달성률
		{ field: "itemDefectRate", title: gfn_getMsg("col_badRate"), format: "{0:0.000'%'}", width: "120px" },					//불량률
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
</script>