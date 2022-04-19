<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content"  style="width:100%;">
	<div id="jteSingleGrid" style="width:height:100%;"></div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_JJW.css' rel="stylesheet">


<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//서브 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";
	
	//lfo_common.popId = "";
	
	lfo_common.ctrlUrl = "/form/perform/prodStaMgt/unworkStaMgt";
	
	lfo_common.crud  = {
		read:{url:"/getUnWorkList", auth:"", search: false, refresh: false, prmt:{}, dynamicPrmt:{prodAsmDate:"hidProdAsmDate"}}
	};
	
	lfo_common.customTitle = {
		html:"작업지시일  : <input id='prodAsmDate' name='prodAsmDate' />" +
			"<input type='hidden' id='hidProdAsmDate' name='hidProdAsmDate'>" , callback : lfn_jteWorkDate_set};
	
	lfo_common.model = {
		id: "prodWorkId",
		fields: {
			prodWorkId : { type: "string" },
			prodWorkUser : { type: "string" },
			prodWorkUserNm : { type: "string" },
			prodAsmDate : { type: "date" },
			lotQty : { type: "int" },
			prodAsmQty : { type: "int" },
			prodWorkQty : { type: "int" },
			prodWorkGood : { type: "int" },
			prodWorkBad : { type: "int" },
			unWorkQty : { type: "int" },
			prodWorkStatus : { type: "string" },
			prodAsmId : { type: "string" },
			lotId : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" }
		}
	};
	
	lfo_common.columns = [
		{field: "prodWorkUserNm", title:"작업자", width: "150px"},
		{field: "itemNm", title:"제품명", width: "150px"},
		{field: "prodWorkQty", title:"작업 필요량", width: "130px"},
		{field: "prodWorkGood", title:"생산량", width: "120px"},
		{field: "prodWorkBad", title:"불량량", width: "120px"},
		{field: "unWorkQty", title:"미작업 수량", width: "150px"}
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
this.lfn_jteWorkDate_set = function(){
	//초기 오늘 데이터를 매핑
	if($("#prodAsmDate").attr("data-role") != "datepicker"){
		$("#prodAsmDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : new Date(),
			change : function(){
				$("#hidProdAsmDate").val($("#prodAsmDate").val());
				lfo_common.grid.dataSource.read();
			}
		});
	}
	$("#hidProdAsmDate").val($("#prodAsmDate").val());
}

</script>