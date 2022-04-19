<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="mtrlInfoForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrlInfoForm"></div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrlInfoForm">
			<div class="pop_title"><spring:message code = "pop_mtrlInfo"></spring:message></div>		<!-- 자재정보 -->
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:31%;">
				<col style="width:20%;">
				<col style="width:31%;">
			</colgroup>
				<tr>
				<!-- 자재코드 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlCd"></spring:message> : </td>
					<td><input type="text" id="mtrlId" name="mtrlId"  placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly/></td>			<!-- 자동입력 -->
				<!-- 자재유형 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlType"></spring:message> : </td>
					<td><input id="mtrlType" name="mtrlType" format="selBox" msg="mtrl_div"/></td>
				</tr>
				<tr>
				<!-- 자재명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlNm"></spring:message> : </td>
					<td colspan="3"><input type="text" id="mtrlNm" name="mtrlNm" format="text"/></td>
				</tr>
				<tr>
				<!-- 자재규격 -->
					<td><i class="fas fa-caret-right"></i>자재규격 :</td>
					<td colspan="3"><input type="text" id="mtrlStdStr01" name="mtrlStdStr01"/></td>
	 			
				</tr> 
				<tr>
				<!-- 최소 재고 필요 수량 -->
					<td><i class="fas fa-caret-right"></i>최소재고 : </td>
					<td><input type="text" id="mtrlStd04" name="mtrlStd04" format="numeric" /></td>
				<!-- 단가 -->
						<td><i class="fas fa-caret-right"></i>평균 단가 : </td>
					<td><input type="text" id="mtrlCost" name="mtrlCost" format="currency" readonly/></td>
				<tr>
				<tr style="display:none;">
					<!-- 필요한 부분에 꺼내쓰시오 - jkkim -->
					<td><i class="fas fa-caret-right"></i>예비3(String) :</td>
					<td><input type="text" id="mtrlStdStr03" name="mtrlStdStr03"/></td>
					<td><i class="fas fa-caret-right"></i>예비4(String) :</td>
					<td><input type="text" id="mtrlStdStr04" name="mtrlStdStr04"/></td>
					<td><i class="fas fa-caret-right"></i>예비5(String) :</td>
					<td><input type="text" id="mtrlStdStr05" name="mtrlStdStr05"/></td>
				</tr>
				<tr>
				<!-- 무게 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_weight"></spring:message> : </td>
					<td><input type="text" id="mtrlStd03" name="mtrlStd03" format="numeric" /></td>
				<!-- 단위 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_unit"></spring:message> : </td>
					<td><input type="text" id="mtrlUnit" name="mtrlUnit" format="selBox" msg="comn_unit"/></td>
				</tr>
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="mtrlDesc" class="k-textbox" name="mtrlDesc"/></td>
				</tr>
				<tr>
				<!-- 변경이력 -->
					<td><i class="fas fa-caret-right"></i>변경이력 :</td>
					<td colspan="3"><textarea id="mtrlStdStr02" name="mtrlStdStr02" rows="3"></textarea></td> <!-- 입력창이 겹쳐져서 표시되는 오류 수정을 위해 class="k-textbox" 삭제_201211 YUMI -->
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="use" id="use"/>
						<input type="hidden" name="action" id="mtrl_action"/>
					</td>
				</tr>
			</table>
			<!-- 업체관리 -->
			<div class="pop_title"><spring:message code = "pop_compMgt"></spring:message></div>
			<div id="jtePopForm_grid" class="mtrlInfoForm" style="height: 222px; width: 98%; margin: auto; display: flex;"></div>
			
			<div class="final-btn-area mtrlInfoForm-final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<!-- <link href='/resources/mes/css/contents/basMgt/operMgt/mtrlInfo/mtrlInfoForm_lym.css' rel="stylesheet"> -->

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/operMgt/mtrlInfo/mtrlInfoForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

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
	lfo_common.ctrlUrl = "/cform/basMgt/operMgt/mtrlInfo"
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getMtrlInfoList", auth:"", prmt:{}, dynamicPrmt : {itemId : "itemId"}}, 
		create:{url:"/setMtrlInfoSave", auth:"", openFunc:lfn_jtePop_open, callback:lfn_popSave}, 
		update:{url:"/setMtrlInfoSave", auth:"", callback:lfn_popSave},  
		destroy:{url:"/setMtrlInfoDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	//5.
	lfo_common.model = {
		id: "mtrlId",
		fields: {
			mtrlId : { type: "string" },
			mtrlNm: { type: "string" },
			mtrlDesc: { type: "string" },
			mtrlType: { type: "string" },
			mtrlHCD: { type: "string" },
			mtrlStd01: { type: "int" },
			mtrlStd02: { type: "int" },
			mtrlStd03: { type: "int" },
			mtrlStd04: { type: "float" },
			mtrlStd05: { type: "int" },
			mtrlStdStr01 : { type: "string" },
			mtrlStdStr02 : { type: "string" },
			mtrlStdStr03 : { type: "string" },
			mtrlStdStr04 : { type: "string" },
			mtrlStdStr05 : { type: "string" },
			mtrlUseday: { type: "int" },
			mtrlCost: { type: "int" },
			createdAt: { type: "string" },
			updatedAt: { type: "string" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			mtrlDiv: { type: "string" },
			isUse: { type: "bool" },
			mtrlQual: { type: "string" },
			mtrlUnit: { type: "string" },
			compNm : { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "mtrlId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this);" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title:gfn_getMsg("btn_update"), width: 90},	
		{field: "mtrlId", title:gfn_getMsg("col_mtrlCd"), width: "140px"},											//자재코드
		{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "170px"},											//자재명
		{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
			title:gfn_getMsg("col_mtrlType"), width: "95px;"},														//자재유형
		{field: "mtrlCost", format: "{0:n0}",attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_unitPrice"), width: "100px"},					//단가
 		{field: "mtrlStdStr01", title : "자재규격", width: "150px"},
 		{field: "mtrlStd04", title: "최소재고",   attributes: { style: "color: red; font-weight:bold;  text-align:right;" }, width: "105px"},
		{field: "mtrlDesc", title:gfn_getMsg("col_desc"), width: "280px"},											//설명
		{field: "mtrlStdStr02", title:"변경이력", width: "140px",
			template : function(e){return e.mtrlStdStr02.split('\n')[0]}},
		{field: "compNm", title:"발주처", width: "280px"},
		{field: "isUse", editable: lfn_jteSgGrd_isEditable2, title:gfn_getMsg("col_isuse"), width:"95px",			//사용유무
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_jteSgGrd_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px;'/></a>";
				}else{
					return ""+gfn_getMsg("val_basic")+" : Y";														//기본
				}
			}
		}
	];
	
	lfo_common.customTitle = {
		html: '<button class="k-button k-primary" type="button" onclick = "lfn_bomMtrl(\'all\');" style="min-width:60px;">전체 검색</button> &nbsp; <button class="k-button k-primary" type="button" onclick = "lfn_bomMtrl(\'item\');" style="min-width:60px;">품목 검색</button>' +
		'<input class="k-textbox" id="itemNm" readonly/><input type="hidden" id="itemId" /> '
	};
	
	
	//7.
	lfo_common.selectBox = [ 
		{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },				//자재명
		{ text: gfn_getMsg("col_mtrlCd"), value: "mtrlInfo.mtrl_id" },				//자재코드
		{ text: gfn_getMsg("col_compNm"), value: "compNm" }				//자재코드
	];
	
	//8.
	lfo_common.validation ={
		mtrlNm:{
			messages : "자재명을 입력하세요",
			rules : function(input){
				if(input.is("[name=mtrlNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
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
		width: "705px", 
		height: "802px", /* 20.12.22 JJW POP 고려 X 700 -> 802 */
		id:lfo_common.popId, 
		//title:gfn_getMsg("pop_addPop"),
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_mtrlRegist");			//자재 등록
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlSrh");				//자재 조회
	}
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//팝업내용 세팅
this.lfn_jtePop_set = function(mode, selectedItem){
	lfo_common.gridSelected = {};
	
	var childItems = [];
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode,selectedItem);
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {mtrlId : selectedItem};
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/getMtrlPop",
			type: "POST",
			data: {mtrlId : lfo_common.gridSelected.mtrlId},
			success: function(data){
				gfn_popform_set(lfo_common, mode, data.rows);
				
				//업체 정보를 담는다.
				childItems = data.rows.childCompList;
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
	
	//업체 grid 생성 (mtrl-child)
	lfn_jtePopGrd_setGrd(childItems);
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
	
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		//업체 정보를 담아준다.
		savePrmt.childCompList = lfo_popGrd.childItems;
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data == 'CONST'){
					gfn_warnBox({msg : "실패하였습니다. \n 등록된 데이터가 이미 사용중입니다."});
				}else if(data != ""){
					lfn_jtePop_set('EDT',data);
					lfo_common.grid.dataSource.read();
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

//사용유무
this.lfn_jteSgGrd_changeIsUse = function(rows){
	
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {mtrlId : dataItem.mtrlId, action : "USE", use : dataItem.use};
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.update.url,
		type: "POST",
		data: JSON.stringify(prmt),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				lfo_common.grid.dataSource.read();
			}else{
				gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});			//실패
			}
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}



//팝업내부 그리드  (mtrl-child)
this.lfn_jtePopGrd_setGrd = function(childItems){
	$("#jtePopForm_grid").html("");
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
	//lfo_popGrd.popId = "";
	
	//3.
	lfo_popGrd.ctrlUrl = "/cform/basMgt/operMgt/mtrlInfo"
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getMtrlRtlCompList", auth:"", prmt:{mtrlId: lfo_common.gridSelected.mtrlId}}, 
		create:{url:"/setMtrlRtlCompSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
		//update:{url:"", auth:"", openFunc:"", callback:""},
		destroy:{url:"/setMtrlRtlCompDelete", auth:"", callback:lfn_jtePopGrd_delete}
	};
	
	//5.
	lfo_popGrd.model = {
		id: "compId",
		fields: {
			action: { type: "string" },
			compId: { type: "string" },
			mtrlId: { type: "string" },
			mtrlPrice: { type: "int" },
			compNm: { type: "string" },
			compManagr: { type: "string" },
			compNumber: { type: "string" },
			compType: { type: "string" },
			compAddr: { type: "string" },
			createdAt: { type: "date" },
			updatedAt: { type: "date" },
			creatorId: { type: "string" },
			updatorId: { type: "string" },
			description: { type: "string" },
			isUse: { type: "bool" }
		}
	};
	
	//6.
	lfo_popGrd.columns = [
		{selectable : true, width:"50px"},
		{field: "compId", title:gfn_getMsg("col_compCd"), width: "140px"},				//업체코드
		{field: "action", template : "#= action == 'C' ? '신규등록' : action == 'U' ? '수정' :action == 'D' ? '삭제' : action == 'K' ? '기존' : '에러' #",
			title:"액션", width: "95px"},
		{field: "compNm", title:gfn_getMsg("col_compNm"), width: "180px"},				//업체명
		{field: "mtrlPrice", title: "업체 별 자재 단가", format: "{0:n0}", attributes : { style : "text-align : right;"}, width: "180px"},		//업체 별 자재 단가
		{field: "description", title:gfn_getMsg("col_desc"), width: "250px"}			//비고
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: gfn_getMsg("col_compNm"), value: "comp.comp_nm" },			//업체명
		{ text: gfn_getMsg("col_compCd"), value: "comp.comp_id" },			//업체코드
		{ text: gfn_getMsg("col_desc"), value: "comp.description" }			//비고
	];
	
	//mtrl에 포함된 업체 정보 담아주기 (mtrl-child)
	lfo_popGrd.childItems = childItems;
	
	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_objectDatagrid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(selectedItem){

	//여기부터 공통팝업 띄우기
	gfn_openCustomPop('company',lfn_jtePopGrd_save);
}

//Form내용 입력/저장 (mtrl-child)
this.lfn_jtePopGrd_save = function(savePrmt){
	kendo.prompt("해당 자재 가격을 입력하세요", "")
	.done(function(mtrlPrice){
		if(!Number.isInteger(parseInt(mtrlPrice)) ){
			kendo.confirm("문자는 입력 하실 수 없습니다.");
			return false;
		}
		savePrmt.mtrlId = lfo_common.gridSelected.mtrlId;
		savePrmt.mtrlPrice = parseInt(mtrlPrice);
		savePrmt.action = 'C';
		
		var childItems = gfn_objectDataGrid_save({tgObj : lfo_popGrd, prmt : savePrmt, pk : "compId", autokey : false});
		if(!childItems){
			return false;
		}
		lfo_popGrd.childItems = childItems;
		
		//그리드 리로드 후 팝업창 닫기
		lfo_popGrd.grid.dataSource.read();
		lfn_mtrlCostAvg();
	})
	.fail(function(mtrlPrice){return false;});
}

//삭제 콜백 (mtrl-child)
this.lfn_jtePopGrd_delete = function(){
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delPrmt = lfo_popGrd.grid.dataItem($(this).closest('tr'));
			
			//데이터 object에 저장 - 부모요소 저장시 저장(삭제)된다.
			gfn_objectDataGrid_delete({tgObj : lfo_popGrd, prmt : delPrmt, pk : "compId"});
		}
	});
	
	//그리드 리로드
	lfo_popGrd.grid.dataSource.read();
	lfn_mtrlCostAvg();
}

this.lfn_mtrlCostAvg = function(){
	var sum = 0;
	var len = 0;
	$.each(lfo_popGrd.childItems, function(index, item) {
		if(item.action != "D") {
			sum += parseInt(item.mtrlPrice);
			len++;
		}
	});
	
	$("#mtrlCost").data("kendoNumericTextBox").value(sum/len);
	
}

this.lfn_bomMtrl = function(mode){
	
	if(mode == 'item') {
		var callback = function(selectedItem){
			$('#itemNm').val(selectedItem.itemNm);
			$('#itemId').val(selectedItem.itemId);
			
			lfo_common.grid.dataSource.read();
		};
		
		gfn_openCustomPop("item", callback);
	} else {
		$('#itemNm').val(null);
		$('#itemId').val(null);
		
		lfo_common.grid.dataSource.read();
	}
	
}


</script>