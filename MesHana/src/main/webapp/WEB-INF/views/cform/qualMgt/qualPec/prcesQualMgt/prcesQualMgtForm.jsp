<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="prcesQualMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="prcesQualMgtForm prcesQualMgtForm-jteSingleGrid"></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
</div>

<!-- 라우팅 전체조회 POP(같은 작업지시에 포함된 라우팅만 조회한다.) -->
<div style="display:none;">
	<div id="routingRelatedPop" class="routingRelatedPop">
	<!-- 라우팅 조회 -->
		<div class="pop_title">공정정보 조회</div>
		<div id="routingRelatedPop_grid" class="routingRelatedPop_grid" style="height:430px;"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/mtrl/mtrltoolMgt/prcesQualMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
 <link href='/resources/mes/css/contents/qualMgt/qualPec/prcesQualMgt/prcesQualMgtForm_JJW.css' rel="stylesheet"> 

<!-- 내부 스타일 외부로 이동_200511 JJW  -->

<script>

var lfo_dateBox = {};

var lfo_prcesQual = {};//Form 내부에서 사용될 Object 


//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	lfo_prcesQual.grid.dataSource.read();
};

this.lfn_jteSgGrd_setGrd = function(){
	lfo_prcesQual = {};//Form 내부에서 사용될 Object 
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
	lfo_prcesQual.layoutId = "jteSingleGrid";
	
	//2.
	//lfo_prcesQual.popId = "jtePopForm";
	
	//3.
	lfo_prcesQual.ctrlUrl = "/cform/qualMgt/qualPec/prcesQualMgt"
	
	//4.
	lfo_prcesQual.crud  = {
		read:{url:"/getPrcesQualList", auth:"", prmt:{}}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		//update:{url:"/setPrcesQualSave", auth:"", openFunc : "", callback:""}
		//destroy:{url:"", auth:"", callback:""}
	};
	

	//5.
	lfo_prcesQual.model = {
		id: "badId",
		fields: {
			badId : { type: "string" },
			badCode : { type: "string" },
			badQty : { type: "int" },
			chkUser : { type: "string" },
			chkUserNm : {type: "string" },
			chkDate : { type: "date" },
			badTarget : { type: "string" },
			badTargetCode : { type: "string" },
			badDesc : { type: "string" },
		}
	};
	
	//6.
	lfo_prcesQual.columns = [
		{field: "badId", title:"불량아이디", width: "140px"},
		{field: "badCode", template:"# var item = gfn_isNull(gfn_getCode(badCode))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badCode).cdVal , gfn_getCode(badCode).cdNm) # #= item #",
				title:"불량원인", width: "140px"},
		{field: "badQty", title:"불량수량", width: "140px"},
		{field: "chkUserNm", title:"검사자", width: "140px"},
		{field: "chkDate", format:"{0: yyyy-MM-dd}", title:"검사일", width: "140px"},
		//{field: "badTarget", template:"# var item = gfn_isNull(gfn_getCode(badTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(badTarget).cdVal , gfn_getCode(badTarget).cdNm) # #= item #", title:"불량타겟", width: "140px"},
		{field: "badTargetCode", title:"불량타겟아이디", width: "140px"},
		{field: "badDesc", title:"설명", width: "140px"},
		
	];
	
	//7.
	lfo_prcesQual.selectBox = [
		{ text: "검사자", value: "userInfo.user_nm" },
		{ text: "불량아이디", value: "bad.bad_id" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_prcesQual.grid = gfn_grid_set(lfo_prcesQual);
	
}
</script>