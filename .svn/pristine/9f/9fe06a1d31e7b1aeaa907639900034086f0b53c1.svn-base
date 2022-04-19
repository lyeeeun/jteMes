<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" class="itemStockMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="itemStockMgtForm"></div>
<!-- 	<div id="jteSubGrid" style="display:inline-block; width:49%; height:100%;"></div> -->
</div>
<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="itemStockMgtForm">			
			<div class="pop_title"><spring:message code = "pop_itemInfo"></spring:message></div>		<!-- 부품정보 -->
			<table style="width:100%;" id="jtePopForm_master">
			<colgroup>
				<col class="col-left-title"> <!-- style="width:15%;" -->
				<col class="col-left-content-1"> <!-- style="width:27%;" -->
				<col class="col-left-content-2"> <!-- style="width:15%;" -->
				<col class="col-right-title"> <!-- style="width:27%;" -->
				<col class="col-right-content"> <!-- 20.05.07 JJW 부품코드부분 버튼 정렬을 위해 한개 더 추가 -->
			</colgroup>
<%-- 			<tr>
				<!-- 부품정보 -->
					<td colspan="5" class="pop_title"><spring:message code = "pop_itemInfo"></spring:message></td>
				</tr> --%>
				<tr>
				<!-- 부품코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemCd"></spring:message> : </td>
					<td>
						<input type="text" id="itemId" class="left-input btn-input" name="itemId" placeholder="<spring:message code = "pop_searchAuto"></spring:message>" readonly />			<!-- 조회시 자동입력 -->
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" id="item_search_btn" onclick= "lfn_itemInfoPop_Open();" style="display:none;"><spring:message code = "btn_search"/></button>			<!-- 조회 -->
					</td>
				<!-- 부품유형 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_itemType"></spring:message> : </td>
					<td><input type="text" id="itemType" class="right-input" name="itemType" format="selBox" msg="item_type" readonly /></td>
				</tr>
				<tr>
				<!-- 부품명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemNm"></spring:message> : </td>
					<td colspan="4"><input type="text" id="itemNm" class="center-input" name="itemNm" format="text" readonly/></td>
<%--				<td> 부품 총 재고량: </td>
					<td>
						<input type="text" id="itemTotalStock" name="itemTotalStock" format="numeric" readonly />
					</td>			--%>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>부품규격 : </td>
					<td colspan="4"><input type="text" id="itemStdStr01" class=center-input name="itemStdStr01" readonly/></td>
				</tr>
<%-- 				<tr class="pop_detail_info">
				<!-- 금액 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_cost"></spring:message> : </td>
					<td colspan="2">
						<input type="text" id="itemPrice" class="left-input" name="itemPrice" format="currency" readonly />
					</td>
				<!-- 인건비 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_laborCost"></spring:message> : </td>
					<td>
						<input type="text" id="itemPersonCost" class="right-input" name="itemPersonCost" format="currency" readonly />
					</td>	
				</tr>
				<tr class="pop_detail_info">
				<!-- 방진구Φ -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_length"></spring:message> : </td>
					<td colspan="2">
						<input type="text" id="itemStd01" class="left-input" name="itemStd01" format="numeric" readonly />
					</td>
				<!-- 소재Φ -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_width"></spring:message> : </td>
					<td>
						<input type="text" id="itemStd02" class="right-input" name="itemStd02" format="numeric" readonly />
					</td>
				</tr>
				<!-- SUBΦ -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_thick"></spring:message> : </td>
					<td colspan="2">
						<input type="text" id="itemStd03" class="left-input" name="itemStd03" format="numeric" readonly />	
					</td> 
									<!-- 재질 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_qomtrl"></spring:message> : </td>
					<td><input type="text" id="itemMtrl" class="left-input" name="itemMtrl" format="selBox" msg="comn_qomtrl" readonly /></td> --%>
				<tr class="pop_detail_info">
				<!-- 무게 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_weight"></spring:message> : </td>
					<td colspan="2"><input type="text" id="itemStd04" class="left-input" name="itemStd04" format="numeric" readonly /></td>
				<!-- 단위 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_unit"></spring:message> :</td>
					<td><input type="text" id="itemUnit" class="right-input" name="itemUnit" format="selBox" msg="comn_unit" readonly /></td>
				</tr>
				<tr class="pop_detail_info">
					<td><i class="fas fa-caret-right"></i>비고 : </td>
					<td colspan="4"><input type="text" id="itemDesc" class=center-input name="itemDesc" readonly/></td>
				</tr>
				<tr style="display:none;">
					<!-- 필요한 부분에 꺼내쓰시오 - jkkim -->
					<td><i class="fas fa-caret-right"></i>예비2(String) :</td>
					<td><input type="text" id="itemStdStr02" class=left-input name="itemStdStr02"/></td>
					<td><i class="fas fa-caret-right"></i>예비3(String) :</td>
					<td><input type="text" id="itemStdStr03" class=left-input name="itemStdStr03"/></td>
					<td><i class="fas fa-caret-right"></i>예비4(String) :</td>
					<td><input type="text" id="itemStdStr04" class=left-input name="itemStdStr04"/></td>
					<td><i class="fas fa-caret-right"></i>예비5(String) :</td>
					<td><input type="text" id="itemStdStr05" class=left-input name="itemStdStr05"/></td>
				</tr>
				<tr> <!--20305.07 JJW 펼치기 숨기기 버튼  -->
					<td colspan="5" class="pop_detail_btn_area" style="padding-top:15px;"> <!-- style="text-align:center;", 패딩 값 공통css에서 적용되므로 인라인스타일을 이용해 값 설정 -->
						<span class="pop_detail_btn pop_detail_hide" onclick="lfn_popDetail_toggle()">
				<!-- 펼치기/숨기기 -->
						<spring:message code = "pop_expHide"></spring:message></span>
					</td>
				</tr>
			</table>
			<div class="pop_title"><spring:message code = "pop_itemSpec"></spring:message></div>		<!-- 부품특성 -->
			<table style="width:100%;" id="jtePopForm_master">
			<colgroup>
				<col class="col-left-title"> <!-- style="width:15%;" -->
				<col class="col-left-content-1"> <!-- style="width:27%;" -->
				<col class="col-left-content-2"> <!-- style="width:15%;" -->
				<col class="col-right-title"> <!-- style="width:27%;" -->
				<col class="col-right-content"> <!-- 20.05.07 JJW 부품코드부분 버튼 정렬을 위해 한개 더 추가 -->
			</colgroup>
<%-- 				<tr>
				<!-- 부품특성 -->
					<td colspan="5" class="pop_title"><spring:message code = "pop_itemSpec"></spring:message></td>
				</tr> --%>
				<tr>
				<!-- 부품개별코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_itemIndivCd"></spring:message> : </td>
					<td colspan="2">
						<input type="text" id="itemMgtId" class="left-input" name="itemMgtId" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly />			<!-- 자동입력 -->
					</td>
				<!-- 부품개별구분 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_itemIndivDiv"></spring:message> : </td>
					<td>
						<input type="text" id="itemMgtType" class="right-input" name="itemMgtType" format="text" readonly />
					</td>
				</tr>
				<tr>
				<!-- 개별 재고량 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_indivStockQty"></spring:message> : </td>
					<td colspan="2">
						<input type="text" id="itemStock" class="left-input" name="itemStock" format="numeric" readonly >
					</td>
				<!-- 제조일자 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_manufactDate"></spring:message> : </td>
					<td>
						<input id="itemMfgDate" class="right-input" name="itemMfgDate" format="datepicker" />
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="4">
						<input type="text" id="description" class="center-input" name="description" format="text"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button"><spring:message code = "pop_save"></spring:message></button>										<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button"><spring:message code = "pop_save"></spring:message></button>										<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
		<!-- 수량관리 -->
		<div class="pop_title"><spring:message code = "pop_qtyMgt"></spring:message></div>
		<div id="jtePopForm_grid" class="itemStockMgtForm"></div>
	</div>
</div>

<!-- 팝업(마스터그리드 > 팝업창 내부 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopAddForm">
		<form id = "jtePopAddForm_form" class="itemStockMgtForm-popsc">
			<table style="width:100%;" id="jtePopAddForm_master">
			<colgroup>
				<col class="popsc-col-left-title"> <!-- style="width:23%;" -->
				<col class="popsc-col-left-content"> <!-- style="width:27%;" -->
				<col class="popsc-col-right-title"> <!-- style="width:23%;" -->
				<col class="popsc-col-right-content-1"> <!-- style="width:27%;" -->
				<col class="popsc-col-right-content-2"> <!-- 20.05.07 JJW 등록자 버튼 정렬을 위해 한개 더 추가 -->
			</colgroup>
				<tr>
				<!-- 업무구분 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_targetDiv"></spring:message> : </td>
					<td>
						<input type="text" id="itemQtyTarget" class="left-input" name="itemQtyTarget" format="text" readonly />
					</td>
				<!-- 수량 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_quantity"></spring:message> : </td>
					<td colspan="2"><input type="text" id="itemQtyTotal" class="right-input" name="itemQtyTotal" format = "currency" /></td>
				</tr>
				<tr>
				<!-- 등록일 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_registDate"></spring:message> : </td>
					<td><input type="text" id="itemQtyDate" class="left-input" name="itemQtyDate" format="datepicker" /></td>
				<!-- 등록자 -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i><spring:message code = "col_registUser"></spring:message> : </td>
					<td>
						<input type="text" id="itemQtyUserNm" class="right-input btn-input" name="itemQtyUserNm" class="k-textbox" readonly/>
						<input type="hidden" id="itemQtyUser" class="right-input btn-input" name="itemQtyUser">
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button"  onclick= "lfn_addFormUserPop_open()"><spring:message code = "btn_search"/></button>			<!-- 조회 -->
					</td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="4"><input type="text" id="itemQtyDesc" class="center-input" name="itemQtyDesc" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" id="hiditemMgtId" name="itemMgtId">
						<input type="hidden" id="hiditemId" name="itemId">
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>						<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopAddForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/item/itemStockMgt/itemStockMgtForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/item/itemStockMgt/itemStockMgtForm_JJW.css' rel="stylesheet">

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
	lfo_common.ctrlUrl = "/form/item/itemStockMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getItemStockList", auth:"", prmt:{}, dynamicPrmt : {del : "delStat"}},
		update:{url:"/insertItemStock", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave},
		create:{url:"/insertItemStock", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}
	};
	
	//5.
	lfo_common.model = {
		fields: {
			itemId : { type: "string" },
			itemNm : { type: "string" },
			itemType : {type: "string"},
			itemMtrl : {type: "string"},
			itemMgtId : { type: "string" },
			itemMfgDate : { type: "date" },
			itemMgtType: { type: "string" },
			itemStock: { type: "int" },
			itemPackageStock: { type: "int" },
			description: { type: "string" },
			isDel: { type: "bool" }
		}
	};
	
	//커스텀 타이틀
	lfo_common.customTitle = {
		html :	'<div style="margin : 5px 0 10px 0;">반납여부 : '+
				'<input type="radio" name="delChk" id="delFalse" class="k-radio" checked="checked" value=false style="margin : 0 5px 0 5px;">' +
			 	'<label class="itemStockMgtForm-label" for="delFalse">사용 가능</label>'+
				'<input type="radio" name="delChk" id="delTrue" class="k-radio"  value=true style="margin : 0 5px 0 5px;">'+
				'<label class="itemStockMgtForm-label" for="delTrue">사용 완료</label>'+
				'<input type="hidden" id="delStat" value="false"></div>'
	}
	
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "130px"},															//부품코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px"},															//부품명
		{field: "itemMgtId", title:gfn_getMsg("col_itemIndivCd"), width: "130px"},													//부품개별코드
		{field: "itemMgtType",  title: gfn_getMsg("col_itemIndivDiv"), width: "130px"},												//부품개별구분
		{field: "itemMfgDate", format:"{0: yyyy-MM-dd hh:mm:ss}", title:gfn_getMsg("col_manufactDate"), width: "150px"},			//제조일자
		{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
			title:gfn_getMsg("col_itemType"), width: "100px"},																		//부품유형
		/* {field: "itemMtrl", template:"# var item = gfn_isNull(gfn_getCode(itemMtrl))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemMtrl).cdVal , gfn_getCode(itemMtrl).cdNm) # #= item #",
			title:gfn_getMsg("col_qomtrl"), width: "140px"},																		//재질 */
		{field: "itemStock", format: "{0:n0}", title:gfn_getMsg("col_indivStockQty"), width: "110px"},								//개별부품재고량
		//{field: "itemPackageStock", format: "{0:n0}", title:gfn_getMsg("col_packQuan"), width: "110px"},								//개별부품포장수량
		{field: "description", title:gfn_getMsg("col_desc"), width: "240px"},
		{field : "isDel",title : gfn_getMsg("col_useComplete"), width: "120px",
			template : function(rows){
				if(rows.del){
					return '사용 완료';
				}else{
					return '<button class="k-button k-primary" type="button" onclick = "lfn_item_completeUse(this); " style="min-width:90px;">' + "사용 완료" + '</button>';
				}
			}
		} // 사용 완료
	];
	
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_itemNm"), value: "itemInfo.item_nm" },
		{ text: gfn_getMsg("col_itemCd"), value: "itemMgt.item_id" },
		{ text: gfn_getMsg("col_itemIndivCd"), value: "itemMgt.item_mgt_id" }
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px", //20.05.07 첫번째 팝업 너비 JJW LYM 기본 값 750px
		height: "580px", //20.05.07 첫번째 팝업 높이 JJW LYM 기본 값 600px -> 580
		id:lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_itemRegistDetail");			//부품 등록(상세)
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_itemDetailSrh");			//부품 상세수정
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력`
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode,selectedItem){
	
	lfo_common.gridSelected = {};
	if(mode=='NEW'){
		$("#item_search_btn").show();
		
		if(!gfn_isEmpty(selectedItem)) {
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
				type: "POST",
				data: {itemId: selectedItem.itemId, itemMgtId: "ADMIN"},
				success: function(data){
					if(!gfn_isEmpty(data.rows)){
						selectedItem = data.rows[0];
						lfo_common.gridSelected.itemId = data.rows[0].itemId;
						lfo_common.gridSelected.itemMgtId = data.rows[0].itemMgtId;
						lfo_common.gridSelected.itemMgtType = data.rows[0].itemMgtType;
						mode = 'EDT';
					} else {
						kendo.confirm("관리자용 개별 부품 코드가 부여되지 않았습니다. 저장을 클릭하시면 관리자용 개별 부품 코드가 부여됩니다.");
						
						lfo_common.gridSelected.itemId = selectedItem.itemId;
						lfo_common.gridSelected.itemMgtId = "ADMIN";
						lfo_common.gridSelected.itemMgtType = "ADMIN";
						
						selectedItem.itemMgtId = "ADMIN";
						selectedItem.itemMgtType = "ADMIN";
						selectedItem.itemStock = 0;
						selectedItem.itemMfgDate = new Date();
						
						mode = 'EDT';
					}
				},
				error : function(ex){
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
				}
			});
		}
		gfn_popform_set(lfo_common, mode, selectedItem);
	}else if(mode == 'EDT'){
		
		$("#item_search_btn").hide();
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected.itemMgtId = selectedItem["itemMgtId"];
			lfo_common.gridSelected.itemId = selectedItem["itemId"];
			lfo_common.gridSelected.itemMgtType = selectedItem["itemMgtType"];
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {itemMgtId: lfo_common.gridSelected.itemMgtId, itemId: lfo_common.gridSelected.itemId, del : selectedItem["del"]},
			success: function(data){
				gfn_popform_set(lfo_common, mode, data.rows[0]);
			},
			error : function(ex){
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		});
	}
	
	$("#jtePopForm_grid").html("");
	lfn_jtePopGrd_setGrd();
}

//자재정보 팝업 -콜백시 자재정보를 매핑해준다.
this.lfn_itemInfoPop_Open = function(){
	var callback = function(selectedItem){
		lfn_jtePop_set('NEW', selectedItem);
	}
	gfn_openCustomPop('item',callback);
}

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
	//입력폼 serialize 
	var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
	
	//저장된 다국어가 있다면 추가
	var msgBox = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
	
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
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				lfo_common.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
			}
		}
	});
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
		}
	});
}

//팝업내부 그리드 
this.lfn_jtePopGrd_setGrd = function(mode){
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
	lfo_popGrd.ctrlUrl = "/form/item/itemStockMgt";
	
	//4.
	lfo_popGrd.crud  = {
			read:{url:"/getItemStockHistory", auth:"", prmt:{itemMgtId:lfo_common.gridSelected.itemMgtId, itemId: lfo_common.gridSelected.itemId}}, 
			create:{url:"/updateItemStock", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save}
	};
	
	
	//5.
	lfo_popGrd.model = {
		id: "qmParent",
		fields: {
			itemMgtId : { type: "string" },
			itemQtyTarget : { type: "string" },
			itemQtyTargetCode : { type: "string" },
			itemQtyTotal : { type: "string" },
			itemQtyDesc : { type: "string" },
			itemQtyPgCd : { type: "string" },
			itemQtyPgNm : { type: "string" },
			itemQtyDate : { type: "string" },
			itemQtyUser : { type: "string" },
			itemQtyUserNm : { type: "string" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "itemQtyTarget",  template:"# var item = gfn_isNull(gfn_getCode(itemQtyTarget))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemQtyTarget).cdId , gfn_getCode(itemQtyTarget).cdNm) # #= item #",
			title:gfn_getMsg("col_targetDiv"), width: "110px"},															//업무구분
		{field: "itemQtyTargetCode", title:gfn_getMsg("col_divCd"), width: "170px"},									//구분코드
		{field: "itemQtyTotal", format:"{0:n0}", title:gfn_getMsg("col_quantity"), width: "100px"},						//수량
		{field: "itemQtyPgCd", title:gfn_getMsg("col_progCd"), width: "170px"}, 										//프로그램 코드
		{field: "itemQtyPgNm", title:gfn_getMsg("col_progNm"), width: "220px"}, 										//프로그램 명
		{field: "itemQtyDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate"), width: "170px"},			//등록일
		{field: "itemQtyUserNm", title:gfn_getMsg("col_registUser"), width: "100px"},									//등록자
		{field: "itemQtyDesc", title:gfn_getMsg("col_desc"), width: "250px"}											//설명
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_registUser"), value: "u_table.itemQtyUserNm" },			//등록자
		{ text: gfn_getMsg("col_divCd"), value: "u_table.itemQtyTargetCode" },			//구분코드
		{ text: gfn_getMsg("col_progCd"), value: "u_table.itemQtyPgCd" },				//프로그램 코드
		{ text: gfn_getMsg("col_progNm"), value: "u_table.itemQtyPgNm" }				//프로그램 명
	];
	
	//8.
	lfo_popGrd.validation ={
			itemQtyTotal:{
			messages : "수량을 입력하세요",
			rules : function(input){
				if(input.is("[name=itemQtyTotal]")){
					return input.val() != 0;
				}
				return true;
			}
		},
		itemQtyDate:{
			messages : "등록일을 등록하세요",
			rules : function(input){
				if(input.is("[name=itemQtyDate]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		itemQtyUser:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=itemQtyUser]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 등록자를 등록해주세요");
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
		width: "550px", //20.05.07 JJW 첫번째 팝업-> 아래그리드 추가버튼 클릭시 나타나는 두번째 팝업 너비 기본 값 450px -> 550px / LYM 450px -> 550px 
		height: "270px", //20.05.07 JJW 첫번째 팝업-> 아래그리드 추가버튼 클릭시 나타나는 두번째 팝업 높이 기본 값 160px -> 270px / LYM 160px -> 245px
		id:lfo_popGrd.popId,
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_itemQtyRegist");			//부품수량 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_itemQtySrh");				//부품수량 수정
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePopGrd_popSet(mode, selectedItem);};
	this.gfn_winOpen(options);
}


//팝업내용 세팅
this.lfn_jtePopGrd_popSet = function(mode,selectedItem){
	lfo_popGrd.gridSelected = {};
	if(mode=='NEW'){
		selectedItem = {
				itemMgtId : lfo_common.gridSelected.itemMgtId,
				itemId : lfo_common.gridSelected.itemId,
				itemQtyTarget : "ADMIN"
		};
		gfn_popform_set(lfo_popGrd, mode, selectedItem);
	}
}

//유저정보 팝업 -콜백시 유저정보를 매핑해준다.
this.lfn_addFormUserPop_open = function(){
	var callback = function(selectedItem){
		$("#" + lfo_popGrd.popId + "_form").find("[name=itemQtyUser]").val(selectedItem["userId"]);
		$("#" + lfo_popGrd.popId + "_form").find("[name=itemQtyUserNm]").val(selectedItem["userNm"]);
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
					
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
					
					//마스터 그리드 리로드
					lfo_popGrd.grid.dataSource.read();
					lfo_common.grid.dataSource.read();
					
					//이전 팝업화면 리로드
					/* lfn_jtePop_set('EDT',lfo_popGrd.gridSelected); */
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			}
		});
	}
}



//삭제 콜백
this.lfn_jtePopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delTemp = lfo_popGrd.grid.dataItem($(this).closest('tr'))
			if(delTemp.itemQtyTarget != "ADMIN"){
				alert(gfn_getMsg("pop_inputNoDelete"));					//수동입력 이외에는 삭제가 불가능합니다.
				return false;
			}
			delPrmt.push(delTemp);
		}
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
			lfn_jtePop_set('EDT', lfo_common.gridSelected);
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});					//성공적으로 삭제되었습니다.
		}
	});
}

//자재 반납처리
this.lfn_item_completeUse = function(target){

	gfn_conBox({msg:"정말로 반납하시겠습니까?", yes : function(){
		var returnTemp = lfo_common.grid.dataItem($(target).closest('tr'))
		returnTemp.del = true;
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + '/itemCompleteUse',
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