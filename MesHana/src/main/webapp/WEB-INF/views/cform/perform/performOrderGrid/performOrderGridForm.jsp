<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="width:100%;">
	<div class="performOrderGridForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
	<input type="text" class="k-textbox" id="orderId" readonly style="margin-left: 10px;"/>
	<!-- <input type="hidden" id="orderId"> -->
	<button class="k-button k-primary page-search-btn" type="button" id="orderSelBtn" onclick= "lfn_orderInfo();"><spring:message code = "btn_search"/></button>
	</div>
	<div id="grid-content" class="performOrderGridForm performOrderGridForm-gird"> <!-- style="width:100%;" -->
		<div id="jteSingleGrid"></div>
	</div>
</div>

<div style="display:none;">
	<div id="lotDetailPop">
		<div id="lotDetail_grid"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/perform/performOrderGrid/performOrderGridForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/perform/performOrderGrid/performOrderGridForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200512 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	lfn_jteSgGrd_setGrd();
};

this.lfn_orderInfo = function() {
	var callback = function(selectedItem){
		$('#orderId').val(selectedItem.orderId);
		$('#orderNm').val(selectedItem.orderNm);
		lfn_jteSgGrd_setGrd();
	};
	gfn_openCustomPop('orderInfo',callback);
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
		6. gridObject.columns = foeldColumns
		7. gridObject.selectBox = SelectBox 매핑 값 
	*/
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "lotDetailPop";
	
	//3.
	lfo_common.ctrlUrl = "/cform/perform/performOrderGrid";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getPerformOrder", auth:"", prmt:{orderId: $('#orderId').val()}, paging:false, search:false},
		excel:{url:"" ,auth:"", fileName: "품질이력_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
	};
	
	//5.
	lfo_common.model = {
		fields: {
			orderId : { type: "string" },
			orderNm : { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" },
			lotId : { type: "string" },
			/* lotNm : { type: "string" }, */
			lotType : { type: "string" },
			lotPm : { type: "string" },
			lotQty : { type: "int" },
			lotAchieve : { type: "int" },
			lotDefect : { type: "int" },
			lotRemain : { type: "int" },
			lotAchieveRate : { type: "float" },
			lotDefectRate : { type: "float" },
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "120px"},											//수주코드
		{field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "140px"},
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "120px"},												//부품코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "160px"},												//부품명
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "120px"},												//LoT코드
		//2020.05.14|ymlee|LoT명 주석(신명기계 사용x)
		/* {field: "lotNm", title:"lot 명", width: "120px"}, */
		{field: "lotQty",  title: gfn_getMsg("col_orderQty"), width: "110px"},											//주문수량
		{field: "lotAchieve", title:gfn_getMsg("col_prodQuan"), width: "110px"},										//양품량
		{field: "lotDefect", title:gfn_getMsg("col_badProdQuan"), width: "110px"},										//불량량
		{field: "lotRemain", template:"# var item = lotRemain < 0 ? 0 : lotRemain # #= item #", 
				title:gfn_getMsg("col_productionRemainQty"), width: "110px"},											//생산잔여량
		{field: "lotAchieveRate", title:gfn_getMsg("col_archievRate"), format: "{0:0.000'%'}", width: "110px"},			//달성률
		{field: "lotDefectRate", title:gfn_getMsg("col_badRate"), format: "{0:0.000'%'}", width: "110px"},				//불량률
		{field: "lotDetailPop", title:gfn_getMsg("col_progressInfo"), width: "120px",									//진행정보
			template : function(rows) {
				return '<button class="k-button k-primary" type="button" onclick="lfn_detailPop_open(this)">진행 정보</button>';
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: "부품 ID", value: "itemId" }
		//2020.05.15|ymlee|개별부품코드가 필드에 없어 주석
		/* { text: "개별 부품 ID", value: "itemMgtId" } */
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

this.lfn_detailPop_open = function(param) {
	var options = {
		modal:true, 
		width: "1250px", 
		height: "470px", 
		id:lfo_common.popId, 
		title:gfn_getMsg("pop_orderProgressInfo"),			//수주진행정보
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	options.callback = function(){
		lfn_historyPop_gridSet(lfo_common.grid.dataItem($(param).closest('tr')).lotId);
		$('#lotDetail_grid').parent().css('height', '100%');
	};
	this.gfn_winOpen(options);
}

this.lfn_historyPop_gridSet = function(selectedItem){
	//1.
	lfo_popGrd.layoutId = "lotDetail_grid";
	
	//2.
	lfo_popGrd.popId = "";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/perform/performOrderGrid";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getLotDetail", auth:"", prmt:{lotId: selectedItem}}
	};
	
	lfo_popGrd.model = {
		fields: {
			routingId : { type: "string" },	
			userNm : { type: "string" },
			prodWorkQty : { type: "int" },
			prodWorkGood : { type: "int" },
			prodWorkBad : { type: "int" },
			prodWorkGoodRate : { type: "float" },
			prodWorkBadRate : { type: "float" },
			workState : { type: "string" }
		}
	};
		
	lfo_popGrd.columns = [
		{field: "routingId", title : gfn_getMsg("col_routCd"), width: "160px"},												//라우팅코드
		{field: "userNm", title : gfn_getMsg("col_worker"), width: "170px"},												//작업자
		{field: "prodWorkQty", title : gfn_getMsg("col_wrkAsmQty"), width: "110px"},										//작업지시량
		{field: "prodWorkGood", title : gfn_getMsg("col_prodQuan"), width: "110px"},										//양품량
		{field: "prodWorkBad", title : gfn_getMsg("col_badProdQuan"), width: "110px"},										//불량량
		{field: "prodWorkGoodRate",format: "{0:0.00'%'}", title : gfn_getMsg("col_archievRate"), width: "110px"},			//달성률
		{field: "prodWorkBadRate", format: "{0:0.00'%'}", title : gfn_getMsg("col_badRate"), width: "110px"},				//불량률
		{field: "workState", title : gfn_getMsg("col_workStatus"), width: "120px"}											//작업상태
	];
	
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_worker"), value: "userInfo.user_nm" }				//작업자
	];
	
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>