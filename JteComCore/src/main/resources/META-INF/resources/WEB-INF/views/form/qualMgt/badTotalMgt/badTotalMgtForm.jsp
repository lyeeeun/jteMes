<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" style="width:100%;">
	<div id="jteSingleGrid"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm" class="badTotalMgtForm">
		<div id="jtePopForm_grid" class="badTotalMgtForm" style="height:300px;"></div>
	</div>
</div>

<link href='/resources/mes/css/contents/qualMgt/badTotalMgt/badTotalMgtForm_JJW.css' rel="stylesheet">


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
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/qualMgt/badTotalMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getBadTotalList", auth:"", prmt:{}, search : false, paging : false, period:{stdt:-15, eddt:0}, dynamicPrmt:{badCode : "hidSelBadCode", searchStartDate : "searchStartDate",
			searchEndDate :  "searchEndDate"}}
	};
	
	//5.
	lfo_common.model = {
		id: "badCode",
		fields: {
			badCode : { type: "string" },
			badQty : { type: "int" },
			totalQty : { type: "int" },
			totalBadRate : { type: "int" }
		}
	};
	
	lfo_common.customTitle = {html:"<input id='selBadCode' name='selBadCode' />"+
			"<input type='hidden' id='hidSelBadCode' name='hidSelBadCode'>"+
			"<span>기간검색 : </span> <input id='searchStartDate' name='searchStartDate'/>"+
			"<span> ~ </span> <input id='searchEndDate' name='searchEndDate'/>"
		, callback : lfn_jteSelBadCode_set};
	
	//6.
	lfo_common.columns = [
		
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #",
			title : gfn_getMsg("col_badCd", "불량정보"), width: 180},
		{field: "totalQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_periodTotalBadQuan", "기간내 총 불량량"), width: 100},
		{field: "badQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan", "불량량"), width: 100},
		{field: "totalBadRate", format:"{0:p}", title : gfn_getMsg("col_badRate", "불량률"), width: 100},
		{field: "badCode",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'NEW\',this); " style="min-width:60px;">' + ""+gfn_getMsg("pop_view")+"" + '</button>',
			title:gfn_getMsg("col_badConfirm", "불량확인"), width: 90}
		
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//불량코드 SelectBox, 기간검색 세팅
this.lfn_jteSelBadCode_set = function(){
	
	//날짜검색 박스 세팅(초기 오늘 날짜-6개월 세팅)
	if($("#searchStartDate").attr("data-role") != "datepicker"){
		let date1 = new Date();
		date1.setMonth(date1.getMonth() - 6);
		$("#searchStartDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_getDate(date1,"yyyy-MM-dd"),
			change : function(){
				lfo_common.grid.dataSource.read();
			}
		});
	}
	//날짜검색 박스 세팅(초기 오늘 날짜 세팅)
	if($("#searchEndDate").attr("data-role") != "datepicker"){
		let date2 = new Date();
		$("#searchEndDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_getDate(date2,"yyyy-MM-dd"),
			change : function(){
				lfo_common.grid.dataSource.read();
			}
		});
	}
	//불량코드 SelectBox 세팅
	var selBoxItem = gfn_getCode("quality");
	selBoxItem.forEach(function(item,index){
		if(item.cdReserve01 != "badTotal"){
			selBoxItem.splice(index,1);
		}	
	});
	
	$("#selBadCode").kendoDropDownList({
		dataSource: selBoxItem,
		dataValueField: "cdId",
		valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
		template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
		index : 0,
		change : function(){
			$("#hidSelBadCode").val($("#selBadCode").val());
			lfo_common.grid.dataSource.read();
		}
	});
	
	//기본설정
	$("#hidSelBadCode").val($("#selBadCode").val());
	
	
}

//불량확인 버튼 팝업
this.lfn_jtePop_open = function(mode, target){
	var options = {
		modal:true, 
		width: "700px",
		height: "300px", /* JJW 20.11.13 400px -> 430px */
		id : lfo_common.popId, 
		title: "불량확인",	
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		lfo_common.gridSelected = lfo_common.grid.dataItem($(target).closest("tr"));
		
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	};
	this.gfn_winOpen(options);
}

//불량정보 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
		
	//3.
	lfo_popGrd.ctrlUrl = "/form/qualMgt/badTotalMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getBadTotalDetailList", auth:"", 
			prmt:{
				badCode : lfo_common.gridSelected.badCode, 
				searchStartDate : $("#searchStartDate").val(),
				searchEndDate :  $("#searchEndDate").val()
			}
		}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "badId",
		fields: {
			badCode : { type: "string" },
			badTarget : { type: "string" },
			badQty : { type: "int" },
			totalQty : { type: "int" },
			totalBadRate : { type: "int" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #",
			title : gfn_getMsg("col_badInfo", "불량정보"), width: 140},
		{field: "totalQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_periodTotalBadQuan", "기간내 총 불량량"), width: 100},
		{field: "badQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title : gfn_getMsg("col_badProdQuan", "불량량"), width: 100},
		{field: "totalBadRate", format:"{0:p}", title : gfn_getMsg("col_badRate", "불량륭"), width: 100}
				];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_badId", "불량아이디"), value: "bad.bad_id" },
		{ text: gfn_getMsg("col_inspector", "검사자"), value: "badUser.user_nm" }
	];
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>