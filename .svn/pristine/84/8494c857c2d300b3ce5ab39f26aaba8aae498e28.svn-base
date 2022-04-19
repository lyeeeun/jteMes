<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="mtrlMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrlMgtForm"></div>
<!-- 	<div id="jteSubGrid" style="display:inline-block; width:49%; height:100%;"></div> -->
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrlMgtForm popfr-mtrlMgtForm">			
			<div class="pop_title"><spring:message code = "pop_mtrlInfo"></spring:message></div>	
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
			<colgroup>  <!-- 200512 원래는 13 27 13 27_LYM -->
				<col class="col-left-title">
				<col class="col-left-content-1">
				<col class="col-left-content-2">
				<col class="col-right-title">
				<col class="col-right-content-1">
				<col class="col-right-content-2">
			</colgroup>
<%-- 			<tr>
				<!-- 자재정보 -->
					<td colspan="4" class="pop_title"><spring:message code = "pop_mtrlInfo"></spring:message></td>	
				</tr> --%>
				<tr>
				<!-- 자재코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlCd"></spring:message>
					<i class="fas fa-info-circle" title="<spring:message code = "자재코드를 조회하셔야 자재개별코드가 부여됩니다."></spring:message>"></i> : </td>   <!-- style="background:yellow;" -->
					<td>
						<input type="text" id="mtrlId" class="left-input btn-input" name="mtrlId"  placeholder="<spring:message code = "pop_searchAuto"></spring:message>" readonly />			<!-- 조회시자동입력 -->
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" id="mtrl_search_btn" onclick= "lfn_mtrlInfoPop_Open();" style="display:none;"><spring:message code = "btn_search"/></button>
					</td>
				<!-- 자재유형 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_mtrlType"></spring:message> : </td>
					<td colspan="2"><input id="mtrlType" class="right-input" name="mtrlType" format="selBox" msg="mtrl_div" readonly /></td>
				</tr>
				<tr>
				<!-- 자재명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm"></spring:message> : </td>
					<td colspan="5"><input type="text" id="mtrlNm" class="left-input" name="mtrlNm" format="text" readonly /></td>
				<%-- <!-- 자재구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_mtrlDiv"></spring:message> : </td>
					<td colspan="2">
						<input type="text" id="mtrlDiv" class="right-input" name="mtrlDiv" class="k-textbox" readonly />
					</td> --%>
				</tr>
				<tr class="pop_detail_info">
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlStandard"></spring:message> : </td>
					<td colspan="5"><input id="mtrlStdStr01" class="left-input" name="mtrlStdStr01" readonly /></td>
				</tr>
				<%-- <tr class="pop_detail_info">
				<!-- HCD구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlHCD"></spring:message> : </td>
					<td colspan="2"><input id="mtrlHCD " class="left-input" name="mtrlHCD" format="selBox" msg="mtrl_HCD" readonly /></td>
				<!-- 단가 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_unitPrice"></spring:message> : </td>
					<td colspan="2"><input id="mtrlCost" class="right-input" name="mtrlCost" format = "currency"  readonly /></td>
				</tr>
				<tr class="pop_detail_info">
				<!-- 소재Φ -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_width"></spring:message> : </td>
					<td colspan="2"><input type="text" id="mtrlStd01" class="left-input" name="mtrlStd01" format="numeric" readonly /></td>
				<!-- 본당기장 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_mainHall"></spring:message> : </td>
					<td colspan="2"><input type="text" id="mtrlStd02" class="right-input" name="mtrlStd02" format="numeric" readonly /></td>
				</tr> --%>
				<tr class="pop_detail_info">
				<!-- 무게 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_weight"></spring:message> : </td>
					<td colspan="2"><input type="text" id="mtrlStd03" class="left-input" name="mtrlStd03" format="numeric" readonly /></td>
				<!-- 단위 -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_unit"></spring:message> : </td>
					<td colspan="2"><input id="mtrlStd04" class="right-input" name="mtrlStd04" format="selBox" msg="comn_unit" readonly/></td>
				</tr>
				<tr class="pop_detail_info">
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="5"><input id="mtrlDesc" class="right-input" name="mtrlDesc" format="text"  readonly/></td>
				</tr>
<%-- 				<tr class="pop_detail_info">
					<td>자재규격,소재 예비02 : </td>
					<td><input type="text" id="mtrlStd05" name="mtrlStd05" format="currency" readonly style="width: 95%;" /></td>
				</tr> --%>
				<tr>
					<td colspan="6" class="pop_detail_btn_area" style="padding-top:15px; text-align:center;" >   <!-- style="text-align:center;", 패딩 값 공통css에서 적용되므로 인라인스타일을 이용해 값 설정 -->
						<span class="pop_detail_btn pop_detail_hide" onclick="lfn_popDetail_toggle()">
				<!-- 펼치기/숨기기 -->
						<spring:message code = "pop_expHide"></spring:message></span>
					</td>
				</tr>
			</table>
			<div class="pop_title"><spring:message code = "pop_mtrlSpec"></spring:message></div>		<!-- 자재특성 --><!--200512_편의상 div 및 테이블로 나눔_LYM -->
			<table style="width:100%;" id="jtePopForm_master-2" class="mtrlMgtForm jtePopForm_master">
			<colgroup>
				<col class="col-left-title">
				<col class="col-left-content-1">
				<col class="col-left-content-2">
				<col class="col-right-title">
				<col class="col-right-content-1">
				<col class="col-right-content-2">
			</colgroup>
<%-- 				<tr>
				<!-- 자재특성 -->
					<td colspan="4" class="pop_title"><spring:message code = "pop_mtrlSpec"></spring:message></td>	
				</tr> --%>
				<tr>
				<!-- 자재개별코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlIndivCd"></spring:message> : </td>	
					<td colspan="2"><input type="text" id="mtrlMgtId" class="left-input" name="mtrlMgtId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly /></td>			<!-- 자동입력 -->
					<!-- 자재수량 -->
					<td class="td-right-title">
						<i class="fas fa-caret-right"></i><spring:message code = "col_mtrlQty"></spring:message> : 
					</td>
					<td colspan="2"><input id="mtrlMgtCnt" class="left-input" name="mtrlMgtCnt" format = "currency" readonly /></td>
					
				</tr> 
				
				<tr style="display:none;">
				<!--LOT코드 -->
<!-- 					<td class="td-right-title"> -->
<%-- 						<i class="fas fa-caret-right left-caret"></i><spring:message code="col_lotCd" /> :  --%>
<!-- 					</td> -->
<!-- 					<td colspan="2"><input id="lotId" class="right-input" name="lotId" readonly /></td> -->
				<!-- 잔량 -->
					<%-- <td class="td-right-title">
						<i class="fas fa-caret-right left-caret" ></i><spring:message code = "col_mtrlScrap"></spring:message> : 
					</td>
					<td colspan="2">
						<input id="mtrlMgtScrap" class="right-input" name="mtrlMgtScrap" format="currency" />
					</td> --%>
					
				</tr>
				<tr>
				<!-- 입고일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_receiptDate"></spring:message> : </td>
					<td colspan="2"><input id="mtrlMgtPurchase" class="left-input" name="mtrlMgtPurchase" format="datepicker" /></td>
					<!-- 04.29/ymlee/신명기계 시효기간 미사용으로 주석 -->
 					<td class="td-right-title" style="display:none;"><i class="fas fa-caret-right left-caret" ></i><spring:message code = "col_prescripPeriod"></spring:message> : </td>	<!-- 시효기간 -->
					<td colspan="2" style="display:none;"><input id="mtrlMgtPrescription" name="mtrlMgtPrescription" format="datepicker" style="width:98%"/></td> 
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="5"><input type="text" id="mtrlMgtDesc" class="center-input" name="mtrlMgtDesc" class="k-textbox" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="mtrlMgtUse"/>
						<input type="hidden" name="action" id="mtrlMgtAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		<div id="mtrlQtyArea" style="display:none;">
			<div class="pop_title"><spring:message code = "pop_qtyMgt"></spring:message></div>			<!-- 수량관리 -->
			<div id="jtePopForm_grid"></div>
		</div>
	</div>
</div>

<!-- 팝업(마스터그리드 > 팝업창 내부 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopAddForm">
		<form id = "jtePopAddForm_form" class="mtrlMgtForm popsc-mtrlMgtForm">
			<table style="width:100%;" id="jtePopAddForm_master" class="jtePopAddForm_master">
			<colgroup>  <!-- 200511 원래는 23 27 23 27_LYM -->
				<col class="popsc-col-left-title">
				<col class="popsc-col-left-content-1">
				<col class="popsc-col-left-content-2">
				<col class="popsc-col-right-title">
				<col class="popsc-col-right-content-1">
				<col class="popsc-col-right-content-2">
			</colgroup>
				<tr>
				<!-- 업무구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_targetDiv"></spring:message> : </td>
					<td colspan="2">
						<input id="mtrlQtyTarget " class="left-input" name="mtrlQtyTarget" format="selBox" msg="mtrl_tagt" readonly />
						<input type="hidden" id="mtrlQtyTargetCode" class="left-input" name="mtrlQtyTargetCode" /> 
					</td>
				<!-- 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_quantity"></spring:message> : </td>
					<td colspan="2"><input id="mtrlQtyTotal" class="right-input" name="mtrlQtyTotal" format = "currency" /></td>
				</tr>
				<tr>
				<!-- 등록일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_registDate"></spring:message> : </td>
					<td colspan="2"><input id="mtrlQtyDate" class="left-input" name="mtrlQtyDate" format="datepicker" /></td>
				<!-- 등록자 -->
					<td class="td-right-title"><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_registUser"></spring:message> : </td>
					<td>
						<input type="text" id="mtrlQtyUserNm" class="right-input btn-input" name="mtrlQtyUserNm" class="k-textbox" readonly />
						<input type="hidden" id="mtrlQtyUser" class="right-input btn-input" name="mtrlQtyUser" />
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick= "lfn_addFormUserPop_open()">
				<!-- 조회 -->
						<spring:message code = "btn_search"/></button>
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="5"><input type="text" id="mtrlQtyDesc" class="center-input" name="mtrlQtyDesc" class="k-textbox" /></td>
				</tr>
				<!-- 수동입력에서는 입력하지 않음-->
				<tr style="display:none;">
				<!-- 프로그램코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_progCd"></spring:message> : </td>
					<td colspan="2"><input type="text" id="mtrlQtyPgCd" class="left-input" name="mtrlQtyPgCd" class="k-textbox" /></td>
				<!-- 프로그램명 -->
					<td><i class="fas fa-caret-right popsc-left-caret"></i><spring:message code = "col_progNm"></spring:message> : </td>
					<td colspan="2"><input type="text" id="mtrlQtyPgNm" class="right-input" name="mtrlQtyPgNm" class="k-textbox" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" id="hidMtrlMgtId" name="mtrlMgtId">
						<input type="hidden" name="use" id="mtrlQtyUse"/>
						<input type="hidden" name="action" id="mtrlQtyAction"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/mtrl/mtrlMgt/mtrlMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/mtrl/mtrlMgt/mtrlMgtForm_JJW.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200512 LYM  -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	$("[name='delChk']").change(function(e){
		$("#delStat").val($("[name='delChk']:checked").val());
		lfo_common.grid.dataSource.read();
	});
};

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
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/cform/mtrl/mtrlMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getMtrlMgtList", auth:"", prmt:{}, dynamicPrmt : {del : "delStat"}}, 
		create:{url:"/setMtrlMgtSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setMtrlMgtSave", auth:"", openFunc : "", callback:lfn_popSave}, 
		destroy:{url:"/setMtrlMgtDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html :	'<div style="margin : 5px 0 5px 0;">'+'<i class="grid-radio-title fas fa-caret-right"></i>'+'<span style="font-weight: bold;"> '+ gfn_getMsg("col_checkReturn")+ ' :'+'</span>'+
				'<input type="radio" name="delChk" id="delFalse" class="k-radio" checked="checked" value=false style="margin : 0 5px 0 5px;">' +
			 	'<label class="mtrlMgtForm-label" for="delFalse">'+gfn_getMsg("col_stock")+'</label>'+
				'<input type="radio" name="delChk" id="delTrue" class="k-radio"  value=true style="margin : 0 5px 0 5px;">'+
				'<label class="mtrlMgtForm-label" for="delTrue">'+gfn_getMsg("col_mtrlReturn")+'</label>'+
				'<input type="hidden" id="delStat" value="false"></div>'
	}
	
	//5.
	lfo_common.model = {
		id: "mtrlMgtId",
		fields: {
			mtrlMgtId : { type: "string" },
			mtrlMgtPurchase : { type: "date" },
			mtrlMgtPrescription: { type: "date" },
			mtrlMgtCnt: { type: "int" },
			mtrlMgtScrap: { type: "int" },
			mtrlMgtDesc: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" },
			updatorId: { type: "string" },
			updatedAt: { type: "date" },
			lotId: { type: "string" },
			mtrlId: { type: "string" },
			mtrlNm: { type: "string" },
			mtrlType: { type: "string" },
			mtrlHCD: { type: "string" },
			mtrlStd01 : { type: "int" }, 
			mtrlStd02 : { type: "int" }, 
			mtrlStd03 : { type: "int" }, 
			mtrlStd04 : { type: "string" },
			mtrlStd05 : { type: "int" },
			mtrlStdStr01 : { type: "string" }, 
			mtrlStdStr02 : { type: "string" }, 
			mtrlStdStr03 : { type: "string" }, 
			mtrlStdStr04 : { type: "string" },
			mtrlStdStr05 : { type: "string" },
			mtrlUseday : { type: "int" },
			mtrlCost : { type: "int" },
			mtrlDiv: { type: "string" },
			mtrlDesc: { type: "string" },
			mtrlQual: { type: "string" }, 
			mtrlUnit: { type: "string" },
			isUse: { type: "bool" },
			isDel: { type: "bool" },
			mtrlDesc: { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlMgtId",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + gfn_getMsg("btn_update") + '</button>',
			title : gfn_getMsg("btn_search") , width: "90px"},																	//조회
		//{field : "mtrlDiv", title : gfn_getMsg("col_mtrlDiv"), width: "100px"},													//자재구분
		{field : "mtrlNm", title : gfn_getMsg("col_mtrlNm"), width: "160px"},													//자재명
		{field : "mtrlMgtId", title : gfn_getMsg("col_mtrlIndivCd"), width: "150px"},											//자재개별코드 
		{field : "mtrlMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: "120px"},				//입고일
//		{field : "mtrlMgtPrescription", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_prescripPeriod"), width: "120px"},		//시효일
		{field : "mtrlType",  template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #",
			title : gfn_getMsg("col_mtrlType"), width: "110px"},																//자재유형
/* 		{field : "mtrlHCD",  template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #",
			title:gfn_getMsg("col_mtrlHCD"), width: "100px"},																	//HCD구분	 */
		{field : "mtrlMgtCnt", format: "{0:n0}", title:gfn_getMsg("col_mtrlQty"), width: "110px"},								//자재수량
		//{field : "mtrlMgtScrap", format: "{0:n0}", title : gfn_getMsg("col_mtrlScrap"), width: "110px"},						//잔량
		{field : "lotId", title :gfn_getMsg("col_lotCd"), width: "160px"},														//LoT코드
		{field : "mtrlMgtDesc", title:gfn_getMsg("col_desc"), width: "220px"},													//설명
		{field : "mtrlMgtId",title : gfn_getMsg("col_mtrlReturn"), width: "110px",												//자재반납
			template : function(rows){
				if(rows.del){
					return gfn_getMsg("col_returnComplete");
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_mtrl_return(this); " style="min-width:90px;">' + gfn_getMsg("col_mtrlReturn") + '</button>';
				}
			}
		}
	];
	
	//7.
	lfo_common.selectBox = [
		//{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },				//자재구분
		{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },					//자재명
		{ text: gfn_getMsg("col_mtrlIndivCd"), value: "mtrlMgt.mtrl_mgt_id" },			//자재개별코드
		{ text: gfn_getMsg("col_desc"), value: "mtrlMgt.description" }					//설명
	];
	//8.
	lfo_common.validation ={
		mtrlMgtPurchase:{
			messages : "수령일을 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlMgtPurchase]")){
					return input.val() != "";
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px", 
		height: "515px", 
		id : lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlRegistDetail");			//자재 등록(상세)
	}else if(mode=="EDT"){
		if(!gfn_isEmpty(selectedItem)){
			selectedItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}
		options.title = gfn_getMsg("pop_mtrlDetailSrh");			//자재 상세조회
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "NONE";
	if(mode=='NEW'){
		$("#mtrl_search_btn").show();
		if(!gfn_isEmpty(selectedItem) && selectedItem.mtrlType == "mtrl_div01"){
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
				type: "POST",
				data: {mtrlId:selectedItem.mtrlId},
				success: function(data){
					if(!gfn_isEmpty(data.rows)){
						selectedItem = data.rows[0];
						lfo_common.gridSelected = data.rows[0].mtrlMgtId;
						mode = 'EDT';
					}
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		}
		
		gfn_popform_set(lfo_common, mode, selectedItem);
		
		//04.29|ymlee|시효기간 삭제로 인한 주석
 		var preScriptionDate = $("#mtrlMgtPrescription").data("kendoDatePicker");
		if(!gfn_isEmpty(selectedItem) && selectedItem.mtrlType == "mtrl_div01") {
			preScriptionDate.enable(false);
		} else if(!gfn_isEmpty(selectedItem) && selectedItem.mtrlType == "mtrl_div00"){
			preScriptionDate.enable(false);
		} else if(!gfn_isEmpty(selectedItem) && selectedItem.mtrlType == "mtrl_div02"){
			preScriptionDate.enable(true);
		} 
	}else if(mode == 'EDT'){
		
		$("#mtrl_search_btn").hide();
		var savePrmt = {};
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
			savePrmt = {
				mtrlMgtId : lfo_common.gridSelected.mtrlMgtId,
				del : lfo_common.gridSelected.del
			}
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.mtrlMgtId = selectedItem;
			savePrmt = {
				mtrlMgtId : lfo_common.gridSelected.mtrlMgtId
			}
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: savePrmt,
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
				
				//04.29|ymlee|시효기간 삭제로 인한 주석
 				var preScriptionDate = $("#mtrlMgtPrescription").data("kendoDatePicker");
				if(selectedItem.mtrlType == "mtrl_div01"){
					preScriptionDate.enable(false);
				} else if(selectedItem.mtrlType == "mtrl_div00"){
					preScriptionDate.enable(false);
				}  else if(selectedItem.mtrlType == "mtrl_div02"){
					preScriptionDate.enable(true);
				} 
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		//그리드 세팅
		gfn_resizePop(lfo_common.popId, {width:750,height:580}); /* 20.08.21 JJW 자재관리 수정 버튼 클릭 시 팝업 사이즈 조절 */
		$("#mtrlQtyArea").show();
		$("#jtePopForm_grid").html("");
		lfn_jtePopGrd_setGrd();
	}
}

//자재정보 팝업 -콜백시 자재정보를 매핑해준다.
this.lfn_mtrlInfoPop_Open = function(){
	var callback = function(selectedItem){
		lfn_jtePop_set('NEW',selectedItem);
	}
	gfn_openCustomPop('material',callback);
}

//자재정보 -보이기/숨기기
this.lfn_popDetail_toggle = function(){
	if($(".pop_detail_btn").hasClass("pop_detail_hide")){
		//영역숨기기
		$("#jtePopForm_master").find(".pop_detail_info").each(function(){
			$(this).show();
		});
		//클래스 변경
		$(".pop_detail_btn").removeClass("pop_detail_hide");
		$(".pop_detail_btn").addClass("pop_detail_show");
	}else if($(".pop_detail_btn").hasClass("pop_detail_show")){
		//영역펼치기
		$("#jtePopForm_master").find(".pop_detail_info").each(function(){
			$(this).hide();
		});
		//클래스 변경
		$(".pop_detail_btn").removeClass("pop_detail_show");
		$(".pop_detail_btn").addClass("pop_detail_hide");
	}
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		//저장된 다국어가 있다면 추가
		var msgBox = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId")
		if(!gfn_isNull($("#msg_"+msgBox).val())){
			savePrmt.msgList = JSON.parse($("#msg_"+msgBox).val());
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					lfn_jtePop_set('EDT',data);
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					lfo_common.grid.dataSource.read();
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
	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_common.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//팝업내부 그리드 
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
	
	//2.
	lfo_popGrd.popId = "jtePopAddForm";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/mtrl/mtrlMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlHistoryList", auth:"", prmt:{mtrlMgtId : lfo_common.gridSelected.mtrlMgtId}}, 
		create:{url:"/setMtrlManualSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		update:{url:"/setMtrlManualSave", auth:"", openFunc :"", callback:lfn_jtePopGrd_save},
		destroy:{url:"/setMtrlManualDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "qmParent",//복합키 지원 X
		fields: {
			mtrlMgtId : { type: "string" },
			mtrlQtyTarget : { type: "string" },
			mtrlQtyTargetCode : { type: "string" },
			mtrlQtyTotal : { type: "string" },
			mtrlQtyDesc : { type: "string" },
			mtrlQtyPgCd : { type: "string" },
			mtrlQtyPgNm : { type: "string" },
			mtrlQtyDate : { type: "string" },
			mtrlQtyUser : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlQtyTargetCode",template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePopGrd_popOpen(\'EDT\',this); " style="min-width:60px;">' + gfn_getMsg("btn_update") + '</button>',
			title : gfn_getMsg("col_update"), width: "120px"},															//수정
		{field: "mtrlQtyTarget",  template:"# var item = gfn_isNull(gfn_getCode(mtrlQtyTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlQtyTarget).cdId , gfn_getCode(mtrlQtyTarget).cdNm) # #= item #",
			title:gfn_getMsg("col_targetDiv"), width: "140px"},															//업무구분
		{field: "mtrlQtyTargetCode", title:gfn_getMsg("col_divCd"), width: "180px"},									//구분코드
		{field: "mtrlQtyTotal", format:"{0:n0}", title:gfn_getMsg("col_quantity"), width: "110px"},						//수량
		{field: "mtrlQtyPgCd", title:gfn_getMsg("col_progCd"), width: "180px"}, 										//프로그램 코드
		{field: "mtrlQtyPgNm", title:gfn_getMsg("col_progNm"), width: "200px"}, 										//프로그램 명
		{field: "mtrlQtyDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate"), width: "140px"},			//등록일
		{field: "mtrlQtyUserNm", title:gfn_getMsg("col_registUser"), width: "130px"},									//등록자
		{field: "mtrlQtyDesc", title:gfn_getMsg("col_desc"), width: "250px"}											//설명
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_registUser"), value: "u_table.mtrlQtyUserNm" },			//등록자
		{ text: gfn_getMsg("col_divCd"), value: "u_table.mtrlQtyTargetCode" },			//구분코드
		{ text: gfn_getMsg("col_progCd"), value: "u_table.mtrlQtyPgCd" }				//프로그램 코드
	];
	
	//8.
	lfo_popGrd.validation ={
			mtrlQtyTotal:{
				messages : "수량을 입력하세요",
				rules : function(input){
					if(input.is("[name=mtrlQtyTotal]")){
						return input.val().length != 0;
					}
					return true;
			}
		},
		mtrlQtyDate:{
			messages : "등록일을 등록하세요",
			rules : function(input){
				if(input.is("[name=mtrlQtyDate]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		mtrlQtyUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=mtrlQtyUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 등록자를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "600px",   //200512_마스터그리드 > 팝업창 내부 그리드 > 더블클릭 시 나타나는 팝업 너비_450px -> 600px LYM
		height: "280px",   //200512_마스터그리드 > 팝업창 내부 그리드 > 더블클릭 시 나타나는 팝업 높이_160px -> 245px LYM 200519 JJW 160-> 270 200807 youmi 270->280
		id:lfo_popGrd.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlQtyRegist");			//자재수량 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlQtySrh");				//자재수량 수정
		//
		selectedItem = lfo_popGrd.grid.dataItem($(selectedItem).closest("tr"));
		if(selectedItem["mtrlQtyTarget"] != "mtrl_tagt04"){
			gfn_warnBox({msg:gfn_getMsg("pop_manuInputData")});			//수동입력된 데이터만 변경하실 수 있습니다.
			return false;
		}
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}


//팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	lfo_popGrd.gridSelected = {};
	if(mode=='NEW'){
		selectedItem={ 
				mtrlMgtId : lfo_common.gridSelected.mtrlMgtId,
				mtrlQtyTarget: "mtrl_tagt04"
		};
		gfn_popform_set(lfo_popGrd, mode, selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_popGrd.gridSelected["mtrlQtyTarget"] = selectedItem["mtrlQtyTarget"];
			lfo_popGrd.gridSelected["mtrlQtyTargetCode"] = selectedItem["mtrlQtyTargetCode"];
		}else if(typeof(selectedItem) == "string"){
			lfo_popGrd.gridSelected = selectedItem;
		}
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.read.url,
			type: "POST",
			data: {
				mtrlMgtId : lfo_common.gridSelected.mtrlMgtId, 
				mtrlQtyTarget: lfo_popGrd.gridSelected["mtrlQtyTarget"], 
				mtrlQtyTargetCode:lfo_popGrd.gridSelected["mtrlQtyTargetCode"]
			},
			success: function(data){
				gfn_popform_set(lfo_popGrd, mode,data.rows[0]);
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

//유저정보 팝업 -콜백시 유저정보를 매핑해준다.
this.lfn_addFormUserPop_open = function(){
	var callback = function(selectedItem){
		$("#" + lfo_popGrd.popId + "_form").find("[name=mtrlQtyUser]").val(selectedItem["userId"]);
		$("#" + lfo_popGrd.popId + "_form").find("[name=mtrlQtyUserNm]").val(selectedItem["userNm"]);
	}
	gfn_openCustomPop('userInfo',callback);
}

//Form내용 입력/저장
this.lfn_jtePopGrd_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_popGrd.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_popGrd.popId+"_form").serializeObject();
		
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//팝업종료
					gfn_closePop(lfo_popGrd.popId);
					
					//마스터 그리드 리로드
					lfo_common.grid.dataSource.read();
					//이전 팝업화면 리로드
					lfn_jtePop_set('EDT',lfo_common.gridSelected);
					
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
this.lfn_jtePopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		var delTemp = lfo_popGrd.grid.dataItem($(this).closest('tr'))
		if(delTemp.mtrlQtyTarget != "mtrl_tagt04"){
			alert(gfn_getMsg("pop_inputNoDelete"));					//수동입력 이외에는 삭제가 불가능합니다.
			return false;
		}
		delPrmt.push(delTemp);
	});
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			lfn_jtePop_set('EDT',lfo_common.gridSelected);
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});					//성공적으로 삭제되었습니다.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

//자재 반납처리
this.lfn_mtrl_return = function(target){
	gfn_conBox({msg:"정말로 반납하시겠습니까?", yes : function(){
		var returnTemp = lfo_common.grid.dataItem($(target).closest('tr'))
		returnTemp.del = true;
		returnTemp.action = "D";
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.update.url,
			type: "POST",
			data: JSON.stringify(returnTemp),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				
				gfn_msgBox({msg :  gfn_getMsg("pop_returnSuccess", "반납처리가 완료되었습니다.")});	
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}});
}

</script>