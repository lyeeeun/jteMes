<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 
	당일날짜의 바코드를 출력한다.
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
	
	//해당날짜의 작업정보를 조회하기 위한 date 세팅
	lfn_jteBarcodeDate_dateSave();
};


//날짜 정보 매핑 후 그리드 로드
this.lfn_jteBarcodeDate_dateSave = function(){
	
	if(gfn_isNull(lfo_chkDate.date)){
		lfo_chkDate.date = gfn_getDate(new Date(),"yyyy-MM-dd");
	}else{
		lfo_chkDate.date = $("#barcodeDate").val();
	}

	
	//초기화
	$("#jteSingleGrid").html("");
	lfn_jteSgGrd_setGrd();
}


//해당날짜의 작업정보를 조회하기 위한 date 세팅
this.lfn_jteBarcodeDate_set = function(){
	
	//초기 오늘 데이터를 매핑
	if($("#barcodeDate").attr("data-role") != "datepicker"){
		$("#barcodeDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_isNull(lfo_chkDate.date) == true ? new Date() : lfo_chkDate.date,
			change : function(){
				lfn_jteBarcodeDate_dateSave();
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
	lfo_common.ctrlUrl = "/form/barcode/barcodePrint";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getBarcodeList", auth:"", search:false, paging:false,
			prmt : {"createdAt" : lfo_chkDate.date}},
		excel:{url:"getBarcodeList" ,auth:"", title : "바코드 출력" ,fileName: "바코드 출력_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html:'<span class="pop_title">' + "바코드 목록" + '</span> <input id="barcodeDate" name="barcodeDate" />',
		callback : lfn_jteBarcodeDate_set
	}
	
	//5.
	lfo_common.model = {
		id: "itemId",
		fields: {
			barcodeUd : { type: "string" },
			createdAt : { type: "string" },
			itemId : { type: "string" },
			lotNm : { type: "string" },
			orderNm : { type: "string" },
			itemNm : { type: "string" },
			itemStdStr01 : { type: "string" },
			itemStdStr02 : { type: "string" },
			itemStdStr03 : { type: "string" },
			itemStdStr04 : { type: "string" },
			itemStdStr05 : { type: "string" },
			itemStdStr06 : { type: "string" },
			itemUnit : { type: "string" },
			itemMtrl : { type: "string" },
			packageId : { type: "string" },
			shipId : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "barcodeId", title : "바코드", width: "200px"},
		{field: "createdAt", format: "{0: yyyy-MM-dd HH:mm}", title : "바코드 생성시간", width: "200px"},
		{field: "packageId", title : "출고여부", width: "70px",
			template : "# var packagPass =  gfn_isNull(packageId) == true ? '대기' : '출고완료'# #= packagPass# "},
		{field: "shipId", title : "출하여부", width: "70px",
			template : "# var shipPass =  gfn_isNull(shipId) == true ? '대기' : '출하완료'# #= shipPass# "},
		{field: "itemNm", title : "제품명", width: "150px"},
		{field: "orderNm", title : "프로젝트 명", width: "150px"},
		{field: "lotNm", title : "LoT 명", width: "150px"},
		{field: "itemStdStr01", title : "모델명", width: "120px"},
		{field: "itemStdStr02", title : "제품타입", width: "120px",
			template:"# var item = gfn_isNull(itemStdStr02)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(itemStdStr02).cdId , gfn_getCode(itemStdStr02).cdNm) # #= item #"},
		{field: "itemStdStr03", title : "전압", width: "120px"},
		{field: "itemStdStr04", title : "소비전력", width: "90px"},
		{field: "itemStdStr05", title : "허가번호", width: "150px"},
		{field: "itemStdStr06", title : "제품코드", width: "100px"},
		{field: "itemUnit", title : "포장단위", width: "90px"},
		{field: "itemMtrl", title : "보호형식", width: "90px"}
		
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
</script>