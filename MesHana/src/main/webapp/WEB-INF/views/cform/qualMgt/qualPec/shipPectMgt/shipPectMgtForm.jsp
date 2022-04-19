<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="shipPectMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="shipPectMgtForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<div id="jtePopForm_grid" style="height:325px;"></div>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>


<!-- 이윤민 주임 작업 CSS -->
<!--  <link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_lym.css' rel="stylesheet">  -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/qualMgt/qualPec/shipPectMgt/shipPectMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200512 JJW  -->

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
	lfo_common.ctrlUrl = "/cform/qualMgt/qualPec/shipPectMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getPackageBadList", auth:"", prmt:{}}, 
		//create:{url:"/setMtrlOrderSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		//update:{url:"", auth:"", openFunc : lfn_jtePop_open, callback:""}, 
		//destroy:{url:"/setMtrlOrderDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "pkgWorkId",
		fields: {
			pkgWorkId : { type: "string" },
			pkgWorkUser : { type: "string" },
			pkgWorkStart : { type: "date" },
			pkgWorkEnd : { type: "date" },
			prsPackageQty : { type: "int" },
			lotId : { type: "string" },
			badQty: { type: "int" },
			lotQty: { type: "int" },
			compId: { type: "string" },
			compNm: { type: "string" },
			itemId : { type: "string" },
			itemNm : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "pkgWorkId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'NEW\',this); " style="min-width:60px;">' + ""+gfn_getMsg("pop_view")+"" + '</button>',
			title:gfn_getMsg("col_badConfirm"), width: "120px"},																	//불량확인
		{field: "pkgWorkId", title:gfn_getMsg("col_packWorkCd"), width: "170px;"},													//포장작업코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px;"},															//부품명
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},															//LoT코드
		{field: "compNm", title:gfn_getMsg("col_orderCompNm"), width: "150px;"},													//업체명
		{field: "pkgWorkUserNm", title:gfn_getMsg("col_worker"), width: "90px;"},													//작업자
		{field: "pkgWorkStart", format:"{0: yyyy-hh-dd HH:mm:ss}", title:gfn_getMsg("col_wrkStartTime"), width: "150px;"},			//작업시작시간
		{field: "pkgWorkEnd", format:"{0: yyyy-hh-dd HH:mm:ss}", title:gfn_getMsg("col_wrkEndTime"), width: "150px;"},				//작업종료시간
		{field: "lotQty", format:"{0:n0}" ,title : gfn_getMsg("col_orderQty"), width: "95px;"},										//수주량
		{field: "prsPackageQty", title:gfn_getMsg("col_packQuan"), width: "110px;"},												//포장수량
		{field: "badQty", format:"{0:n0}" ,title : gfn_getMsg("col_badProdQuan"), width: "95px;"},									//불량량
		{field: "pkgWorkEnd", template:"# var item = gfn_isNull(pkgWorkEnd) == true ? '점검대기' : '점검완료' # #= item #",
			title:gfn_getMsg("col_checkWhe"), width: "120px"}																		//점검여부
	];
	
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "itemInfo.item_nm" },			//부품명
		{ text: gfn_getMsg("col_worker"), value: "urInfo.user_nm"},				//작업자
		{ text: gfn_getMsg("col_lotCd"), value: "packageWork.lot_id" }			//Lot코드

	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//보기버튼 팝업
this.lfn_jtePop_open = function(mode, target){
	var options = {
		modal:true, 
		width: "900px",
		height: "400px", 
		id : lfo_common.popId, 
		title: gfn_getMsg("pop_checkBadSrh"),			//출하 불량 조회
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
	lfo_popGrd.ctrlUrl = "/cform/qualMgt/infergodsMgt"
	
	//4.
	//4.
		lfo_popGrd.crud  = {
			read:{url:"/getItemBadList",
				auth:"",
				prmt:{
					badTarget : 'qual_spec04',
					badTargetCode : lfo_common.gridSelected.pkgWorkId,
				},
				search : false,
				paging:false
			},
		};
		
		//커스텀 타이틀
		lfo_popGrd.customTitle = {
			html : '<span class="pop_title">'+''+gfn_getMsg("pop_itemBad")+'' + '</span>'			//부품불량
		}
		
		//5.
		lfo_popGrd.model = {
			id: "badId",
			fields: {
				badId : { type: "string" },
				lotId : { type: "string" },	
				badCode : { type: "string" },
				badQty : { type: "string" },
				chkUser : { type: "string" },
				chkUserNm : { type: "string" },
				chkDate : { type: "string" },
				badTarget : { type: "string" },
				badTargetCode : { type: "string" },
				badTargetNm : { type: "string" },
				badDesc : { type: "string" },
				itemId : { type: "string" },
				itemNm : { type: "string" },
				badPgUser : { type: "string" },
				badPgUserNm : { type: "string" },
				badPgDate : { type: "string" }
			}
		};
		//6.
		lfo_popGrd.columns = [
			{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdId , gfn_getCode(badTarget).cdNm) # #= item #", 
				title : gfn_getMsg("col_badCause"), width: "130px;"},										//불량원인
			{field: "badId", title:gfn_getMsg("col_badId"), width: 160},									//불량아이디
			{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdId , gfn_getCode(badCode).cdNm) # #= item #", 
				title : gfn_getMsg("col_badCause"), width: 170},											//불량원인
			{field: "badQty", format: "{0:n0}", title : gfn_getMsg("col_badProdQuan"), width: 90},			//불량량
			{field: "badDesc", title : gfn_getMsg("col_desc"), width: 250}									//설명
		];
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}
</script>