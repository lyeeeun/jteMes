<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="mtrltoolMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrltoolMgtForm mtrltoolMgtForm-jteSingleGrid"></div>   <!-- style="display:inline-block; width:39%; height:100%;" -->
	<div id="jteSubGrid" class="mtrltoolMgtForm mtrltoolMgtForm-jteSubGrid"></div>   <!-- style="display:inline-block; width:59%; height:100%;" -->
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrltoolMgtForm">
			<div class="pop_title"><spring:message code = "pop_toolInfo"></spring:message></div>
			<table style="width:100%;" id="jtePopForm_master">
			<colgroup>
				<col class="col-left-title"> <!-- 20 30 20 30 -->
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
				<tr>
				<!-- 공구개별코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolIndivCd"></spring:message> : </td>
					<td><input type="text" id="toolMgtId" class="left-input" name="toolMgtId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 공구명 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_toolNm"></spring:message> : </td>
					<td>
						<input type="text"  id="toolNm" class="right-input" name="toolNm" readonly/> 
					</td>
				</tr>
				<tr>
				<!-- 공구상태 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolStatus"></spring:message> : </td>
					<td><input id="toolMgtGbn" class="left-input" name="toolMgtGbn" format="selBox" msg="tool_use"/></td> 
				<!-- 공구구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_toolDiv"></spring:message> : </td>
					<td><input id="toolMgtState" class="right-input" name="toolMgtState" format="selBox" msg="tool_sta"/></td> 
				</tr>
				<tr>
				<!-- 등록일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate"></spring:message> : </td>
					<td><input type="text" id="toolMgtPurchase" class="left-input" name="toolMgtPurchase" format="datepicker"/></td> 
				<!-- 검증기간 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_verifyPeriod"></spring:message> : </td>
					<td><input id="toolMgtVerif" class="right-input" name="toolMgtVerif" format="datepicker"/></td> 
				</tr>
				<tr>
				<!-- 사용량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolUse"></spring:message> : </td>
					<td><input id="toolMgtUse" class="left-input" name="toolMgtUse" format="currency"/></td> <!-- style="width: 95%;" -->
				<!-- 사용한도 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_useLimit"></spring:message> :
					</td>
					<td><input id="toolMgtLimit" class="right-input" name="toolMgtLimit" format="currency"/></td> 
				</tr>
				<tr>
				<!-- 업체명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_compNm"></spring:message> : </td>
					<td colspan="2">
						<input type="text" id="compNm" class="left-input btn-input" name="compNm" readonly/> 
						<input type="hidden" id="compId" name="compId" />
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="gfn_openCustomPop('supplier',lfn_supplierPop_callback);" >
				<!-- 조회 -->
						<spring:message code = "btn_search"></spring:message></button>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="toolMgtDesc" class="center-input" name="toolMgtDesc" class="k-textbox"/></td> 
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="toolLimit" id="toolLimit"/>
						<input type="hidden" name="toolId" id="toolId"/>
						<input type="hidden" name="use" id="toolMgtUse"/>
						<input type="hidden" name="action" id="toolMgtAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 정비이력 POP -->
<div style="display:none;">
	<div id="jtePopToolMtnc">   <!-- style="height:100%" -->
	<!-- 정비이력 -->
		<div class="pop_title"><spring:message code = "pop_mtncHis"></spring:message></div>
		<div id="jtePopToolMtnc_grid" style="height:350px;"></div>
	</div>
</div>

<!-- 정비이력 등록/수정 팝업(서브 그리드 > 정비이력 버튼 클릭) -->
<div style="display:none;">
	<div id="jtePopToolAdd">
		<form id="jtePopToolAdd_form" class="mtrltoolMgtForm">
		<!-- 정비내역 -->
			<div class="pop_title"><spring:message code = "pop_mtncList"></spring:message></div>
			<table style="width:100%;" id="jtePopToolAdd_master" class="jtePopToolAdd_master">
			<colgroup>
				<col class="popsc-col-left-title"> <!-- 15 25 15 25 --> <!-- 200511 JJW 조회버튼을 위해 col 하나 더 추가 -->
				<col class="popsc-col-left-content-1">
				<col class="popsc-col-left-content-2">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content">
			</colgroup>
				<tr>
				<!-- 공구정비코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_toolMtnc"></spring:message> : </td>
					<td colspan="4"><input type="text" id="toolMtncId" class="center-input" name="toolMtncId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td> 
				</tr>
				<tr>
				<!-- 정비시작일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtncStartDate"></spring:message> : </td>
					<td colspan="2"><input id="toolMtncStart" class="left-input" name="toolMtncStart" format="datepicker"/></td> 
				<!-- 정비종료일 -->
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_mtncEndDate"></spring:message>
				<!-- 최초 등록시 검증기간이 자동 변경됩니다. (종료일 + 정비주기) -->
					<i class="fas fa-info-circle" title="<spring:message code = "pop_periodAutoChange"></spring:message>"></i>  : </td>   <!-- style="background:yellow;" -->
					<td><input id="toolMtncEnd" class="right-input" name="toolMtncEnd" format="datepicker"/></td> 
				</tr>
				<tr>
				<!-- 관리자 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_manager"></spring:message> : </td>
					<td>
						<input type="text" id="toolMtncUserNm" class="left-input btn-input" name="toolMtncUserNm" readonly/> 
						<input type="hidden" id="toolMtncUser" name="toolMtncUser" />
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="gfn_openCustomPop('userInfo',lfn_userPop_callback);" >
				<!-- 조회 -->
						<spring:message code = "btn_search"></spring:message></button>
					</td>
				<!-- 금액 -->
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_cost"></spring:message> : </td>
					<td>
						<input id="toolMtncCost" class="right-input" name="toolMtncCost" format="currency"/> 
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="4"><input type="text" id="toolMtncDesc" name="toolMtncDesc" class="k-textbox center-input"/></td> 
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="toolId" id="parentToolId"/>
						<input type="hidden" name="toolMgtId" id="parentToolMgtId"/>
						<input type="hidden" name="toolLimit" id="parentToolMaintenance"/>
						<input type="hidden" name="use" id="toolMtncUse"/>
						<input type="hidden" name="action" id="toolMtncAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopToolAdd');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 사용정보 POP -->
<div style="display:none;">
	<div id="jtePopToolUse">   <!-- style="height:100%;" -->
	<!-- 사용정보 -->
		<div class="pop_title"><spring:message code = "pop_useInfo"></spring:message></div>
		<div id="jtePopToolUse_grid" style="height:450px"></div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/mtrl/mtrltoolMgt/mtrltoolMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
 <link href='/resources/mes/css/contents/mtrl/mtrltoolMgt/mtrltoolMgtForm_JJW.css' rel="stylesheet"> 

<!-- 내부 스타일 외부로 이동_200511 JJW  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_subGrd = {};//서브그리드에서 사용될 Object

var lfo_toolMtncGrd = {};//정비이력 Object

var lfo_toolUseGrd = {};//사용정보 Object

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
	//lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/operMgt/toolMgt"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getToolInfoList", auth:"", prmt:{use:false}}, 
		//create:{url:"", auth:"", openFunc:"", callback:""}, 
		update:{url:"", auth:"", openFunc : "", callback:""}
		//destroy:{url:"", auth:"", callback:""}
	};
	
	//5.
	lfo_common.model = {
		id: "toolId",
		fields: {
			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolType : { type: "string" },
			toolPrice : { type: "int" },
			toolLimit : { type: "int" },
			toolDesc : { type: "string" },
			isUse : { type: "bool" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" },
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "toolId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jteSgGrid_dblclick(\'EDT\',this); " style="min-width:60px;">' + "상세" + '</button>',
			title : gfn_getMsg("btn_search") , width: "110px"},												//조회
		{field: "toolId", title:gfn_getMsg("col_toolCd"), width: "160px"},									//공구코드
		{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolType"), width: "140px;"},												//공구유형
		{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: "180px"},									//공구명
		{field: "toolPrice",format: "{0:n0}", title:gfn_getMsg("col_cost"), width: "90px"},					//비용
		{field: "toolLimit", format: "{0:n0}", title:gfn_getMsg("col_useLimit"), width: "120px"},			//사용한도
		{field: "toolDesc", title:gfn_getMsg("col_desc"), width: "250px"},									//설명
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_toolNm"), value: "toolInfo.tool_nm" },				//공구명
		{ text: gfn_getMsg("col_toolCd"), value: "toolInfo.tool_id" },				//공구코드
		/* { text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" },			//공구유형 */
		{ text: gfn_getMsg("col_desc"), value: "toolInfo.tool_desc" }				//설명
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jteSgGrid_dblclick = function(mode, selectedItem){
	lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
	//그리드 세팅
	if($("#jteSubGrid").html() !=""){
		$("#jteSubGrid").html("");
	}
	lfn_jteSubGrd_setGrd();
	
	$("[name='delChk']").change(function(e){
		$("#delStat").val($("[name='delChk']:checked").val());
		lfo_subGrd.grid.dataSource.read();
	});
}


//서브 그리드 세팅
this.lfn_jteSubGrd_setGrd = function(){
	lfo_subGrd = {};//Form 내부에서 사용될 Object 
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
	lfo_subGrd.layoutId = "jteSubGrid";
	
	//2.
	lfo_subGrd.popId = "jtePopForm";
	
	//3.
	lfo_subGrd.ctrlUrl = "/form/mtrl/mtrltoolMgt";
	
	//4.
	lfo_subGrd.crud  = {
		read:{url:"/getToolMgtList", auth:"", prmt:{toolId : lfo_common.gridSelected.toolId}, dynamicPrmt : {del : "delStat"}}, 
		create:{url:"/setToolMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setToolMgtSave", auth:"", openFunc :"" , callback:lfn_popSave}, 
		destroy:{url:"/setToolMgtDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//커스텀 타이틀
	lfo_subGrd.customTitle = {
		html :	'<div style="margin : 5px 0 10px 0;">사용가능 여부 : '+
				'<input type="radio" name="delChk" id="delFalse" class="k-radio" checked="checked" value=false style="margin : 0 5px 0 5px;">' +
			 	'<label class="mtrltoolMgtForm-label" for="delFalse">가능</label>'+
				'<input type="radio" name="delChk" id="delTrue" class="k-radio"  value=true style="margin : 0 5px 0 5px;">'+
				'<label class="mtrltoolMgtForm-label" for="delTrue">불가</label>'+
				'<input type="hidden" id="delStat" value="false"></div>'
	}
	
	//5.
	lfo_subGrd.model = {
		id: "toolMgtId",
		fields: {
			toolMgtId : { type: "string" },
			toolMgtPurchase : { type: "date" },
			toolMgtState : { type: "string" },
			toolMgtLimit : { type: "int" },
			toolMgtUse : { type: "int" },
			toolMgtVerif : { type: "date" },
			toolMgtGbn : { type: "string" },
			toolMgtDesc : { type: "string" },
			creatorId : { type: "string" },
			createdAt : { type: "date" },
			updatorId : { type: "string" },
			updatedAt : { type: "date" },
			compId : { type: "string" },
			compNm : { type: "string" },
			isDel : {type:"bool"},

			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolType : { type: "string" },
			toolPrice : { type: "int" },
			toolLimit : { type: "int" },
			toolDesc : { type: "string" },
			isUse : { type: "bool" }
		}
	};
	
	//6.
	lfo_subGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMgtId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "수정" + '</button>',
			title : gfn_getMsg("btn_search") , width: "110px"},																//조회
		{field: "toolMgtId", title:gfn_getMsg("col_toolIndivCd"), width: "160px"},											//공구개별코드
		{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: "140px"},													//공구명
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolStatus"), width: "160px"},															//공구상태
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolDiv"), width: "140px"},																//공구구분
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "160px"},													//업체명
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "120px"},			//등록일
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: "120px"},			//검증기간
		{field: "toolMgtUse", format:"{0:n0}", title:gfn_getMsg("col_toolUse"), width: "120px"},							//사용량
		{field: "toolMgtLimit", format:"{0:n0}", title:gfn_getMsg("col_useLimit"), width: "120px"},							//사용제한
		{field: "toolMgtDesc", title:gfn_getMsg("col_desc"), width: "250px"},												//설명
		{ field: "toolMgtId", title: gfn_getMsg("col_history"), width: "200px",												//이력
			template:'<button class="k-button k-primary" type="button" onclick = "lfn_toolMtncPop(this) " style="width:60px;">'+gfn_getMsg("pop_mtncHis")+'</button>'			//정비이력
				+'<button class="k-button k-primary" type="button" onclick = "lfn_toolUsePop(this) " style="width:60px;">'+gfn_getMsg("pop_useInfo")+'</button>'				//사용정보
		},
		{field : "toolMgtId",title : gfn_getMsg("col_mtrlReturn"), width: "120px",											//반납
			template : function(rows){
				if(rows.del){
					return '폐기완료';
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_tool_return(this); " style="min-width:90px;">' + "공구폐기" + '</button>';
				}
			}
		}
	];
	//7.
	lfo_subGrd.selectBox = [
		{ text: gfn_getMsg("col_toolNm"), value: "toolInfo.tool_nm" },					//공구명
		{ text: gfn_getMsg("col_toolIndivCd"), value: "toolMgt.tool_mgt_id" },			//공구개별코드
		//{ text: "공구구분", value: "toolInfo.tool_mgt_gbn"},
		//{ text: "공구상태", value: "toolInfo.tool_mgt_state"},
		{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },					//업체명
		{ text: gfn_getMsg("col_desc"), value: "toolMgt.tool_mgt_desc" }				//설명
	];
	//8.
	lfo_subGrd.validation ={
		toolMgtUse:{
			messages : "사용량을 입력하세요",
			rules : function(input){
				if(input.is("[name=toolMgtUse]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		toolMgtLimit:{
			messages : "사용한도를 입력하세요",
			rules : function(input){
				if(input.is("[name=toolMgtLimit]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		toolMgtPurchase:{
			messages : "수령일을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMgtPurchase]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		toolMgtVerif:{
			messages : "검증기간을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMgtVerif]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		compId:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=compId]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 업체를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 compId
	lfo_subGrd.grid = gfn_grid_set(lfo_subGrd);
}

//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "600px", 
		height: "425px", // 200511 JJW 오른쪽 그리드 - 추가버튼 팝업 높이 기본값 330px -> 420px _ LYM 330 -> 415 200810 youmi 420->425px
		id:lfo_subGrd.popId, 
		//title:"추가팝업",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_toolRegistDetail");			//공구상세 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_toolDetailSrh");			//공구상세 수정
		if(!gfn_isEmpty(selectedItem)){
			selectedItem = lfo_subGrd.grid.dataItem($(selectedItem).closest("tr"));
		}
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_subGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = {
			toolId : lfo_common.gridSelected.toolId,
			toolLimit: lfo_common.gridSelected.toolLimit,
			toolMgtLimit: lfo_common.gridSelected.toolLimit,
			toolNm: lfo_common.gridSelected.toolNm
		}
		gfn_popform_set(lfo_subGrd, mode,selectedItem);
	}else if(mode == 'EDT'){
		var searchPrmt = {};
		if(typeof(selectedItem) == "object"){
			lfo_subGrd.gridSelected = searchPrmt;
			
			searchPrmt = {
				toolId : lfo_common.gridSelected.toolId, 
				toolMgtId : selectedItem.toolMgtId,
				del : selectedItem.del
			}
		}else if(typeof(selectedItem) == "string"){
			searchPrmt = {
				toolId : lfo_common.gridSelected.toolId, 
				toolMgtId : selectedItem
			}
		}
		
		$.ajax({
			async:false,
			url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud.read.url,
			type: "POST",
			data: searchPrmt,
			success: function(data){
				gfn_popform_set(lfo_subGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//업체코드 정보 팝업 콜백
this.lfn_supplierPop_callback = function(callbackObj){
	$("[name='compId']").val(callbackObj.compId);
	$("[name='compNm']").val(callbackObj.compNm);
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_subGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_subGrd.popId+"_form").serializeObject();
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_subGrd.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		$.ajax({
			async:false,
			url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//lfn_jtePop_set('EDT',data);
					gfn_closePop(lfo_subGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					lfo_subGrd.grid.dataSource.read();
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//삭제 콜백
this.lfn_jteGrid_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_subGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_subGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_subGrd.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}
//공구 반납처리
this.lfn_tool_return = function(target){
	gfn_conBox({msg:"정말로 폐기 처리하시겠습니까?", yes : function(){
		var returnTemp = lfo_subGrd.grid.dataItem($(target).closest('tr'))
		returnTemp.del = true;
		returnTemp.action = "D";
		$.ajax({
			async:false,
			url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud.update.url,
			type: "POST",
			data: JSON.stringify(returnTemp),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_subGrd.grid.dataSource.read();
				gfn_msgBox({msg :  gfn_getMsg("pop_toolReturnSuccess", "폐기처리가 완료되었습니다.")});	
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}});
}

//정비이력 버튼 클릭(팝업 오픈)
this.lfn_toolMtncPop = function(target){
	var options = {
		modal:true, 
		width: "800px", 
		height: "395px", //200519 JJW 400-> 395
		id : "jtePopToolMtnc", 
		title:gfn_getMsg("pop_toolMtncHis"),			//공구 정비이력
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_subGrd.grid.dataItem($(target).closest("tr"));
	
	//선택한 항목의 ID 가져옴
	lfo_subGrd.gridSelected = { 
			toolId : dataItem.toolId, 
			toolMgtId : dataItem.toolMgtId,
			toolNm : dataItem.toolNm,
			toolLimit : dataItem.toolLimit,
			use : dataItem.use
	};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteToolMtnc_setGrd(dataItem);
	};
	this.gfn_winOpen(options);
}

//정비이력 그리드 세팅
this.lfn_jteToolMtnc_setGrd = function(dataItem){
	lfo_toolMtncGrd = {};//Form 내부에서 사용될 Object
	
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
	lfo_toolMtncGrd.layoutId = "jtePopToolMtnc_grid";
	
	//2.
	lfo_toolMtncGrd.popId = "jtePopToolAdd";
	
	//3.
	lfo_toolMtncGrd.ctrlUrl = "/form/mtrl/mtrltoolMgt";
	
	//4.
	lfo_toolMtncGrd.crud  = {
		read:{url:"/getToolMtncList", auth:"", prmt:{toolMgtId : dataItem.toolMgtId}}, 
		create:{url:"/setToolMtncSave", auth:"", openFunc : lfn_eqmtMtncPop_open, callback : lfn_toolMtncPop_save}, 
		update:{url:"/setToolMtncSave", auth:"", openFunc : lfn_eqmtMtncPop_open, callback : lfn_toolMtncPop_save}, 
		destroy:{url:"/setToolMtncDelete", auth:"", callback : lfn_toolMtncPop_delete}
	};
	
	//5.
	lfo_toolMtncGrd.model = {
		id: "eqmtMtncId",
		fields: {
			toolMtncId : { type: "string" },
			toolMtncStart : { type: "date" },
			toolMtncEnd : { type: "date" },
			toolMtncUser : { type: "string" },
			toolMtncCost : { type: "int" },
			toolMtncDesc : { type: "string" },
			creatorId : { type: "string" },
			createdAt : { type: "date" },
			updatorId : { type: "string" },
			updatedAt : { type: "date" },
			toolMgtId : { type: "string" }
		}
	};
	
	//6.
	lfo_toolMtncGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMtncId", title:gfn_getMsg("col_toolMtnc"), width: "160px"},											//공구정비코드
		{field: "toolMtncStart", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncStartDate"), width: "120px"},			//정비시작일
		{field: "toolMtncEnd", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_mtncEndDate"), width: "120px"},				//정비종료일
		{field: "toolMtncCost", format:"{0:n0}", title:gfn_getMsg("col_cost"), width: "100px"},								//금액
		{field: "toolMtncUserNm", title:gfn_getMsg("col_manager"), width: "130px"},											//관리자
		{field: "toolMtncDesc", title:gfn_getMsg("col_desc"), width: "250px"}												//설명
	];
	//7.
	lfo_toolMtncGrd.selectBox = [
		{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" },					//관리자
		{ text: gfn_getMsg("col_toolMtnc"), value: "toolMtnc.tool_mtnc_id" },			//공구정비코드
		{ text: gfn_getMsg("col_desc"), value: "toolMtnc.tool_mtnc_desc" }				//설명
	];
	//8.
	lfo_toolMtncGrd.validation ={
		toolMtncStart:{
			messages : "정비시작일을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMtncStart]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		toolMtncEnd:{
			messages : "정비종료일을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMtncEnd]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		toolMtncUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=toolMtncUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 담당자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_toolMtncGrd.grid = gfn_grid_set(lfo_toolMtncGrd);
}
//정비이력 등록/수정 팝업 호출
this.lfn_eqmtMtncPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "650px", // 200511 JJW 오른쪽 그리드 정비이력 버튼 클릭 - 그리드 추가버튼 클릭 시 나타나는 팝업 너비 600px -> 650px
		height: "320px", // 200511 JJW 오른쪽 그리드 정비이력 버튼 클릭 - 그리드 추가버튼 클릭 시 나타나는 팝업 높이 230px -> 320px _LYM 230px -> 328px 
		//title : gfn_getMsg("pop_mtncRegist"),
		id:lfo_toolMtncGrd.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtncRegist");			//정비내역 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtncSrh");				//정비내역 수정
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_toolMtncPop_set(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//정비이력 등록/수정 팝업 내용 세팅
this.lfn_toolMtncPop_set = function(mode,selectedItem){
	lfo_toolMtncGrd.gridSelected = "";
	if(mode=='NEW'){
		selectedItem = lfo_subGrd.gridSelected;
		gfn_popform_set(lfo_toolMtncGrd, mode,selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_toolMtncGrd.gridSelected = selectedItem["toolMgtId"];
		}else if(typeof(selectedItem) == "string"){
			lfo_toolMtncGrd.gridSelected = selectedItem;
		}
		
		$.ajax({
			async:false,
			url : lfo_toolMtncGrd.ctrlUrl + lfo_toolMtncGrd.crud.read.url,
			type: "POST",
			data: {toolMgtId : lfo_toolMtncGrd.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_toolMtncGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//유저정보 팝업 콜백
this.lfn_userPop_callback = function(callbackObj){
	$("[name='toolMtncUser']").val(callbackObj.userId);
	$("[name='toolMtncUserNm']").val(callbackObj.userNm);
}

//Form내용 입력/저장
this.lfn_toolMtncPop_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_toolMtncGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_toolMtncGrd.popId+"_form").serializeObject();
		
		$.ajax({
			async:false,
			url : lfo_toolMtncGrd.ctrlUrl + lfo_toolMtncGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//lfn_jtePop_set('EDT',data);
					//설비 정비이력 그리드 리로드
					lfo_toolMtncGrd.grid.dataSource.read();
					//설비상세 그리드 리로드
					lfo_subGrd.grid.dataSource.read();
					//팝업종료
					gfn_closePop(lfo_toolMtncGrd.popId);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}
//삭제 콜백
this.lfn_toolMtncPop_delete = function(){
	var delPrmt = [];
	
	$("#"+ lfo_toolMtncGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_toolMtncGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_toolMtncGrd.ctrlUrl + lfo_toolMtncGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			//공구정비코드 삭제 후 리로드
			lfo_toolMtncGrd.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}


//사용정보 버튼 클릭(팝업오픈)
this.lfn_toolUsePop = function(target){
	var options = {
		modal:true, 
		width: "700px", 
		height: "500px",
		id : "jtePopToolUse", 
		title:gfn_getMsg("pop_toolUseInfo"), 			//공구 사용정보
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	var dataItem = lfo_subGrd.grid.dataItem($(target).closest("tr"));
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jteToolUse_setGrd(dataItem);
		//검색할게 업어서 하이드 처리
		$("#jtePopToolUse").find(".jte-search-aria").hide();
	};
	
	this.gfn_winOpen(options);
}

//사용정보 그리드 세팅
//jtePopToolUse
//jtePopToolUse_grid
this.lfn_jteToolUse_setGrd = function(dataItem){
	lfo_toolUseGrd = {};//Form 내부에서 사용될 Object 
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
	lfo_toolUseGrd.layoutId = "jtePopToolUse_grid";
	
	//2.
	//lfo_toolUseGrd.popId = "jtePopForm";
	
	//3.
	lfo_toolUseGrd.ctrlUrl = "/form/mtrl/mtrltoolMgt";
	
	//4.
	lfo_toolUseGrd.crud  = {
		read:{url:"/getToolUseList", auth:"", prmt:{toolMgtId : dataItem.toolMgtId}},
		excel:{url:"" ,auth:"", fileName: "공구사용 이력_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")}
// 		create:{url:"/setEqmtMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
// 		update:{url:"/setEqmtMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
// 		destroy:{url:"/setEqmtMgtDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_toolUseGrd.model = {
		id: "toolMgtId",
		fields: {
			toolUseQty : { type: "int" },
			toolUseStart : { type: "date" },
			toolUseEnd : { type: "date" },
			toolUseDesc : { type: "string" },
			prodWorkId : { type: "string" },
			toolId : { type: "string" },
			toolMgtId : { type: "string" },
			eqmtMgtId : { type: "string" },
			eqipId : { type: "string" },
			lotId : { type: "string" }
		}
	};
	
	//6.
	lfo_toolUseGrd.columns = [
		{field: "toolUseQty", format:"{0:n0}", title:gfn_getMsg("col_toolUseQuan"), width: "120px"},							//공구사용량
		{field: "toolUseStart", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_useStart"), width: "160px"},			//사용시작
		{field: "toolUseEnd", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_useEnd"), width: "160px"},				//사용종료
		{field: "prodWorkId", title:gfn_getMsg("col_workInfoCd"), width: "160px"},												//작업정보아이디
		{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "160px"},														//LoT코드
		{field: "toolUseDesc", title:gfn_getMsg("col_desc"), width: "250px"}													//설명
	];
	//7.
// 	lfo_toolUseGrd.selectBox = [
// 		{ text: "설비개별코드", value: "eqmtMgt.eqmtMgtId" },
// 		{ text: "설비명", value: "eqmtMgt.eqmtMgtNm" },
// 		{ text: "위치코드", value: "eqmtMgt.placeId" },
// 		{ text: "비고", value: "eqmtMgt.eqmtMgtDesc" }
// 	];
	
	//공통 그리드 세팅 호출 
	lfo_toolUseGrd.grid = gfn_grid_set(lfo_toolUseGrd);
}

</script>