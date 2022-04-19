<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 
	지닉스 커스텀 
	- 생산량 : 제품 수량관리 테이블(업무구분 : 작업, 관리자 입력만 카운트)
	- 불량량 : [중요!]지닉스는 제품불량이 없기 때문에 자재불량만 카운트한다. 또한 자재불량은  자재불량관리 테이블에서 qty-total이 아닌 row 카운트(건수)
-->

<!-- 마스터 그리드 영역 -->
<div id="grid-content" style="width:100%;">
	<div id="jteSingleGrid"></div>
</div>

<script>
var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_chkDate = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	//기간검색을 위한 date 세팅
	lfn_jteAggrDate_dateSave();
};


//날짜 정보 매핑 후 그리드 로드
this.lfn_jteAggrDate_dateSave = function(){
	
	if(gfn_isNull(lfo_chkDate.stdt) || gfn_isNull(lfo_chkDate.eddt)){
		//현재날짜
		var nowDate = new Date();
		
		lfo_chkDate.stdt = gfn_getDate(nowDate,"yyyy-MM-01");
		lfo_chkDate.eddt = gfn_getDate(nowDate,"yyyy-MM-dd");
	}else{
		lfo_chkDate.stdt = $("#searchStartDate").val();
		lfo_chkDate.eddt = $("#searchEndDate").val();
	}
	
	//초기화
	$("#jteSingleGrid").html("");
	lfn_jteSgGrd_setGrd();
}

//기간검색을 위한 date 세팅
this.lfn_jteAggrDate_set = function(){
	
	//현재날짜
	var nowDate = new Date();
	
	//초기 이번달 1일 데이터 세팅(start)
	if($("#searchStartDate").attr("data-role") != "datepicker"){
		$("#searchStartDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_isNull(lfo_chkDate.stdt) == true ? gfn_getDate(nowDate,"yyyy-MM-01") : lfo_chkDate.stdt,
			change : function(){
				lfn_jteAggrDate_dateSave();
			}
		});
	}
	
	//초기 오늘날짜 세팅(end)
	if($("#searchEndDate").attr("data-role") != "datepicker"){
		$("#searchEndDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_isNull(lfo_chkDate.eddt) == true ? gfn_getDate(nowDate,"yyyy-MM-dd") : lfo_chkDate.eddt,
			change : function(){
				lfn_jteAggrDate_dateSave();
			}
		});
	}
}

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "";
	
	//3.
	lfo_common.ctrlUrl = "/cform/perform/itemAggregation";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getItemAggregation", auth:"", search:false,
			prmt : {"searchStartDate" : lfo_chkDate.stdt, "searchEndDate" : lfo_chkDate.eddt}}
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html:'<span class="pop_title">' + "기간검색" + '</span>'+ 
		'<input id="searchStartDate" name="searchStartDate" /> ~ <input id="searchEndDate" name="searchEndDate" />',
		callback : lfn_jteAggrDate_set
	}
	
	//5.
	lfo_common.model = {
		id: "itemId",
		fields: {
			itemId: { type: "string" },
			itemNm: { type: "string" },
			itemStdStr02: { type: "string" },
			itemStdStr06: { type: "string" },
			itemGood: { type: "int" },
			itemBad: { type: "int" },
			itemBadPercent: { type: "int" },
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "itemId", title : "내부 코드", width: "150px"},
		{field: "itemNm", title : "제품 명", width: "200px"},
		{field: "itemStdStr06", title : "제품 코드", width: "150px"},
		{field: "itemStdStr02", title : "제품 구분", width: "150px",
			template:"# var item = gfn_isNull(itemStdStr02)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(itemStdStr02).cdId , gfn_getCode(itemStdStr02).cdNm) # #= item #"},
		{field: "itemGood", format : "{0:n0}", attributes : { style : "text-align : right;"}, title : "생산량", width: "150px"},
		{field: "itemBad", format : "{0:n0}", attributes : { style : "text-align : right;"}, title : "불량량", width: "150px"},
		{field: "itemBadPercent", format : "{0:#,#.##%}", title : "불량률", width: "150px"}
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_user"), value: "userInfo.user_nm" },
		{ text: gfn_getMsg("col_connectDevice"), value: "conn.conn_device" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
</script>