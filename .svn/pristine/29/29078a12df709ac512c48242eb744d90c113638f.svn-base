<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="mqsToolMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<input id="itemSelBox">
		<input type="hidden" id="itemNm">
	</div>
	<div id="grid-content" class="mqsToolMgtForm-grid" style="width:100%;"> <!-- style="width: 100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<!-- CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/toolQualMgt/toolQualMgtForm.css' rel="stylesheet">

<!-- CSS 경로 수정_201014 youmi -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용d

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	lfn_selBoxBind();
};

this.lfn_selBoxBind = function(){
	var selBoxItem = new Array();
	
	$.ajax({
		async:false,
		url : "/cform/qualMgt/qualPec/autoQualMgt/selectInspItemList",
		type: "POST",
		data: { itemId: $('#itemId').val()},
		success: function(data){
			$.each(data.rows, function(index, item){
				selBoxItem[index] = {"itemNm": item.itemNm};
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	$("#itemSelBox").kendoDropDownList({
		dataTextField: "itemNm",
		dataValueField: "itemNm",
		dataSource: selBoxItem,
		index: 0,
		change: function(e) {
			$("#itemNm").val(this.value());
			lfo_common.grid.dataSource.read();
		}
	});
	
	$("#itemNm").val(selBoxItem[0].itemNm);
	lfo_common.grid.dataSource.read();
}

// 그리드 세팅
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
		6. gridObject.columns = fieldColumns
		7. gridObject.selectBox = SelectBox 매핑 값 
	*/
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "";
	
	//3.
	lfo_common.ctrlUrl = "/cform/qualMgt/qualPec/autoQualMgt";

	//4.
	lfo_common.crud  = {
		read:{url:"/selectAutoInspInfo", auth:"", prmt:{}, dynamicPrmt:{itemNm: "itemNm"}, period:{stdt:-15, eddt:0}, search : false},
	};
	
	//5.
	lfo_common.model = {
		fields: {
			itemNm : { type: "string" },
			innerDia : { type: "float" },
			outerDia : { type: "float" },
			externalDia : { type: "float" },
			electricPart : { type: "float" },
			distance : { type: "float" },
			passYn : { type: "bool" },
			inspDate : { type: "string" }
		},
	};
	
	//6.
	lfo_common.columns = [
		{field: "itemNm", title: gfn_getMsg("col_itemNm"), width: "140px"},
		{field: "inspDate", title: gfn_getMsg("col_inspDate"), width: "130px"},
		{field: "innerDia", title: gfn_getMsg("col_innerDia"), width: "130px"},		
		{field: "outerDia", title: gfn_getMsg("col_outerDia"), width: "130px"},	
		{field: "externalDia", title: gfn_getMsg("col_externalDia"), width: "130px"},		
		{field: "electricPart", title: gfn_getMsg("col_electricPart"), width: "130px"},	
		{field: "distance", title: gfn_getMsg("col_distance"), width: "130px"},	
		{field : "passYn",title : gfn_getMsg("col_passYn"), width: "120px",
			template : function(rows){
				if(rows.passYn){
					return gfn_getMsg("bc_pass")
				}else{
					return gfn_getMsg("bc_noPass")
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}

</script>