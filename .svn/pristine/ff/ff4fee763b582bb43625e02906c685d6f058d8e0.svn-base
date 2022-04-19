<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" style="width:100%;">
	<div id="jteSingleGrid"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm" class="badTotalMgtForm">
		<div id="jtePopForm_grid" class="badTotalMgtForm" style="height:325px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/qualMgt/badTotalMgt/badTotalMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200807 JJW  -->

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
	lfo_common.ctrlUrl = "/form/qualMgt/badTotalMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getBadTotalList", auth:"", prmt:{}, search : false, paging : false, period:{stdt:-15, eddt:0}, dynamicPrmt:{badCode : "hidSelBadCode"}}
		//create:{url:"/setMtrlOrderSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		//update:{url:"", auth:"", openFunc : "", callback:""}, 
		//destroy:{url:"/setMtrlOrderDelete", auth:"", callback:lfn_jteGrid_delete}
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
			"<input type='hidden' id='hidSelBadCode' name='hidSelBadCode'>"
		, callback : lfn_jteSelBadCode_set};
	
	//6.
	lfo_common.columns = [
		
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #",
			title : gfn_getMsg("col_badInfo"), width: 180},														//불량정보
		{field: "totalQty", format:"{0:n0}", title : gfn_getMsg("col_periodTotalBadQuan"), width: 100},			//기간내 총 불량량
		{field: "badQty", format:"{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: 100},					//불량량
		{field: "totalBadRate", format:"{0:p}", title : gfn_getMsg("col_badRate"), width: 100},					//불량률
		{field: "badCode",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'NEW\',this); " style="min-width:60px;">' + ""+gfn_getMsg("pop_view")+"" + '</button>',
			title:gfn_getMsg("col_badConfirm"), width: 90}														//불량확인
		
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//불량코드 SelectBox 세팅
this.lfn_jteSelBadCode_set = function(){
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

//보기버튼 팝업
this.lfn_jtePop_open = function(mode, target){
	var options = {
		modal:true, 
		width: "900px",
		height: "400px", 
		id : lfo_common.popId, 
		title: gfn_getMsg("pop_badSrh"),			//수입 불량 조회
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		lfo_common.gridSelected = lfo_common.grid.dataItem($(target).closest("tr"));
		
		//자재소요량 조회 
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	};
	this.gfn_winOpen(options);
}

//입고 자재불량 그리드 
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
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
	lfo_popGrd.layoutId = "jtePopForm_grid";
	//여기까지
	
	//2.
	//lfo_popGrd.popId = "jteMtrlBadChkPop";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/qualMgt/badTotalMgt"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getBadTotalDetailList", auth:"", 
			prmt:{
				badCode : lfo_common.gridSelected.badCode, 
				searchStartDate : $("#jteSingleGrid_hidStdt").val(),
				searchEndDate :  $("#jteSingleGrid_hidEddt").val()
			}
		}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "badId",
		fields: {
			badId : { type: "string" },	
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkUserNm : { type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badTargetNm : { type: "string" },
			badDesc : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
			title : gfn_getMsg("col_badCause"), width: "130px;"},													//불량원인
		{field: "badId", title : gfn_getMsg("col_badId"), width: 140},												//불량아이디
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
			title : gfn_getMsg("col_badInfo"), width: "140px;"},													//불량정보
		{field: "badTargetCode", title : gfn_getMsg("col_badCd"), width: 140},										//불량코드
		{field: "badQty",format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: 100},						//불량량
		{field: "chkUserNm", format: "{0:n0}", title : gfn_getMsg("col_inspector"), width: 100},					//검사자
		{field: "chkDate", format: "{0: yyyy-MM-dd}", title : gfn_getMsg("col_inspectDate"), width: 100}			//검사일
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_badId"), value: "bad.bad_id" },								//불량아이디
		{ text: gfn_getMsg("col_inspector"), value: "badUser.user_nm" }						//검사자
	];
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>