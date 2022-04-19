<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" class="bomMgtForm" style="width:100%;">
	<!-- 좌측 그리드 영역 -->
	<div id="jteSingleGrid" class="bomMgtForm-jteSingleGrid" style="width:44.5%;"></div>
	<!-- 우측 트리영역 -->
	<div id="jteTreeArea" style="width : 54.5%; overflow:auto; float:right; border : 2px solid #8aafff; height : 100%; display:none;">
		<button id="bomAddBtn" class="k-button k-primary" onclick="lfn_jtePop_open('NEW', '')" style="margin: 10px 0 0 10px;">추가하기</button>
		<div id="bomTreeArea" style="margin:0 0 0 10px"></div>
	</div>
</div>

<!-- bom 추가/수정/조회 팝업 -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="bomMgtForm">
			<table id="jtePopForm_master" class="BasicTable">
				<colgroup>
					<col style="width:19%;">
					<col style="width:30%;">
					<col style="width:21%;">
					<col style="width:30%;">
				</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_bomCd" text="BOM 코드" /> : </td>
					<td><input type="text" id="bomId" name="bomId" placeholder="<spring:message code = "pop_autoInput" text="자동입력"/>" readonly/></td>
					<td><i class="fas fa-caret-right"></i>bom 명 : </td>
					<td><input type="text" id="bomNm" name="bomNm" placeholder="자재를 선택하면 자동입력" /></td>
				</tr>
				<tr id="bomParentArea"> 
					<td>
						<i class="fas fa-caret-right"></i>상위 BOM : 
					</td>
					<td colspan="3">
						<input id="bomParentId" name="bomParentId" format = "selBox" custom="true" keyGbn="bomId" keyText="bomNm" func="lfn_bomParent_get()" />
					</td>
				</tr>
				<tr id="bomTargetArea">
					<td><i class="fas fa-caret-right"></i>BOM구분 : </td>
					<td colspan="3">
						<input id="bomTarget" name="bomTarget" format = "selBox" custom="true" keyGbn="cdId" keyText="cdNm" func="lfn_bomTarget_get()" />
					</td>
				</tr>
				<tr id="bomMtrlArea">
				<!-- 사용 자재 -->
					<td><i class="fas fa-caret-right"></i><span id="lbl_Target"></span> : </td>
					<td colspan="3">
						<input type="text" id="bomTargetNm" name="bomTargetNm" class="btn-input" readonly>
						<input type="hidden" id="bomTargetId" name="bomTargetId" readonly/>
						<button class="k-button k-primary bomTargetInfo" type="button" id="bomTargetInfo" name="bomTargetInfo" onclick="lfn_bomTargetInfo()">
							<spring:message code = "btn_search" text="조회"/>
						</button>
					</td>
				</tr>
				<tr>
				<!-- 수량 -->
					<td><i class="fas fa-caret-right"></i>필요 수량 : </td>
					<td colspan="3"><input type="text" id="bomTargetCnt" name="bomTargetCnt" format='currency'/></td>
				</tr>
				<tr style="display:none;">				
					<td><i class="fas fa-caret-right"></i>예비1 :</td><!-- 예비1 -->
					<td><input type="text" id="bomStd01" name="bomStd01" format="numeric"/></td>
					<td><i class="fas fa-caret-right"></i>예비1(str) :</td><!-- 예비1(str) -->
					<td><input type="text" id="bomStdStr01" name="bomStdStr01"  /></td>
				</tr>	
				<tr>
				<!-- 설명 -->
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc"></spring:message> : </td>
					<td colspan="3"><input type="text" id="description" name="description"/></td>
				</tr>
			</table>
			<div class="final-btn-area bomMgtForm-final-btn-area">
				<button class="k-button k-primary final-btn jte-create" type="button"><spring:message code = "pop_save"/></button>
				<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"/></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>
				<button id="routingDelBtn" class="k-button k-primary final-btn" type="button" onclick = "lfn_popDelete('jtePopForm_form');" style="display:none"><spring:message code = "btn_delete"/></button>
			</div>
		</form>
	</div>
</div>

<link href='/resources/mes/css/contents/basMgt/bom/bomMgt/bomMgtForm_JJW.css' rel="stylesheet">

<script>
var lfo_common = {};//Form 내부에서 사용될 Object

var lfo_bom = {};

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
	lfo_common.popId = "";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/operMgt/itemMgt"

	//4.
	lfo_common.crud  = {
		read:{url:"/getItemList", auth:"", prmt:{}}, 
		create:{url:"", auth:"", openFunc : "", callback : "lfn_popSave"}, 
		update:{url:"", auth:"", openFunc : "", callback : "lfn_popSave"}, 
		destroy:{url:"", auth:"", callback : ""}
	};
	
	//5.
	lfo_common.model = {
		id: "itemId",
		fields: {
			itemId: { type: "string" },
			itemNm: { type: "string" },
			itemPrice: { type: "int" },
			itemPersonCost: { type: "int" },
			itemType: { type: "int" },
			itemLen: { type: "int" },
			itemWidth: { type: "int" },
			itemThick: { type: "int" },
			itemWeight: { type: "int" },
			itemUnit: { type: "string" },
			itemMtrl: { type: "string" },
			isUse: { type: "bool" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "itemId",template:'<button class="k-button k-primary" onclick = "lfn_setBomTree(\'NEW\',this);" style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
			title : gfn_getMsg("btn_update"), width: 85},
		{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "130px"},				//부품코드
		{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "170px"},				//부품명
/* 			{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
			title:gfn_getMsg("col_itemType"), width: "110px"},							//부품유형 */
		{field: "description", title:gfn_getMsg("col_desc"), width: "150px"}			//설명
	];
	
	//7.
	lfo_common.selectBox = [ 
		{ text: gfn_getMsg("col_itemNm"), value: "itemNm" },			//부품명
		{ text: gfn_getMsg("col_itemCd"), value: "itemId" }	
	];
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//bom 트리 그려주기
this.lfn_setBomTree = function(mode, selectedItem) {
	
	//선택값 초기화
	lfo_common.gridSelected = {};
	
	//우측 영역 활성화
	$("#jteTreeArea").show();
	
	//트리 div 초기화(tree 생성시 kendo에서 어트리뷰트를 입력하기 때문에 html자체를 초기화 해줘야 함)
	$("#bomTreeArea").html("<div id='jteBomTree' style='font-size : 16px;'></div");
	
	//선택값 전역변수 매핑
	if(mode=='NEW'){
		lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
	}else if(mode == 'EDT'){
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.itemId = selectedItem;
		}
	}
	
	lfo_bom = {};//Form 내부에서 사용될 Object
	
	lfo_bom.treeData = [];
	lfo_bom.treeConnData = [];
	lfo_bom.popId = "jtePopForm";
	lfo_bom.ctrlUrl = "/form/basMgt/bom/bomMgt";
	lfo_bom.crud  = {
		read:{url:"/getBomTree", auth:"", prmt:{}}, 
		create:{url:"/setBom", auth:"", openFunc : "", callback : lfn_bomPop_save}, 
		update:{url:"/updateBom", auth:"", openFunc : "", callback : lfn_bomPop_save}, 
		destroy:{url:"/deleteBom", auth:"", callback : ""}
	};
	
	lfo_bom.validation ={
		bomNm:{
			messages : "bom 명을 입력하세요",
			rules : function(input){
				if(input.is("[name=bomNm]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		}
	};
	//tree datasource 정보
	var dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: lfo_bom.ctrlUrl + lfo_bom.crud.read.url,
				dataType: "json"
			},parameterMap: function(data, type){
				pageSearchObj ={};
				switch(type) {
				case "read" :
					pageSearchObj["itemId"] = lfo_common.gridSelected.itemId
				return Object.assign(data, pageSearchObj);
				}	
			}
		},schema: {
			model: {
				id: "bomId",
				hasChildren: "hasChildren"
			}
		}
	});
	
	//tree view 
	$("#jteBomTree").kendoTreeView({
		dataSource: dataSource,
		//view 부분 커스텀
		template : function(e){
			var html = '<span>';
			html += '[' + gfn_getMsg('bc_'+ e.item.bomTarget) +'] ';
			html += '<b>'+ e.item.bomNm + '</b> [수량 : ' + e.item.bomTargetCnt + ']';
			html += ' <button  class="k-button k-primary" onclick="lfn_jtePop_open(\'EDT\', this)">상세</button>';
			html += '</span>';
			return html;
		},
		dataTextField: "bomNm",
		collapse : lfn_jteMtTree_expandPop,
		//전체 확장 
		dataBound: function(e){
			this.expand('.k-item');
		}
	});
	
	//tree 전역변수
	lfo_bom.tree = $("#jteBomTree").data("kendoTreeView");
	
	//상위 bom 조회 - selectbox 값 조회(팝업용)
	$.ajax({
		async:false,
		url : lfo_bom.ctrlUrl + "/getBomList",
		type: "POST",
		data: { itemId: lfo_common.gridSelected.itemId },
		success: function(data){
			lfo_bom.selBoxData = data.result;
		},error: function(ex){
			lfo_bom.selBoxData = {};
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	//생성버튼활성화
	$('#bomAddBtn').show();
}

//bom팝업 오픈
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "700px",
		height: "405px",
		id:"jtePopForm",
		title:gfn_getMsg("pop_bomCreat"),					//BOM 신규 생성
		workCd:mode, 
		bdSeq:"",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:["Close"]
	};
	
	if(mode=='EDT'){
		options.title = gfn_getMsg("pop_bomUpdate");			//BOM 수정
		options.workCd = "EDT";
 	}
	
	options.callback = function(){
		//bom팝업 세팅
		lfn_jtePopGrd_setForm(mode, selectedItem);
	};
	
	this.gfn_winOpen(options);
}

//bom팝업 세팅
this.lfn_jtePopGrd_setForm = function(mode, selectedItem){
	lfo_bom.treeSelected = {};
	
	if(mode=='NEW'){
		gfn_popform_set(lfo_bom, mode);
	} else if(mode=='EDT'){
		
		lfo_bom.treeSelected = lfo_bom.tree.dataItem($(selectedItem).closest("li"));
		
		//수정시 상위코드, 선택자재는 변경 불가능 
		$("#bomParentId").attr("readonly",true);
		$("#bomTarget").attr("readonly",true);
		
		//BOM품목은 삭제 안된다.
		if(selectedItem.bomTarget != "prcs_bom01"){
			$('#bomDelBtn').show();
		}
		
		//원 데이터 수정시 targetNm은 변경되지 않아 예외처리 - 2020-12-16/jkkim
		if(lfo_bom.treeSelected.bomTarget == 'prcs_bom01'){//품목
			lfo_bom.treeSelected.bomTargetNm = lfo_bom.treeSelected.itemNm;
		}else if(lfo_bom.treeSelected.bomTarget == 'prcs_bom02'){//자재
			lfo_bom.treeSelected.bomTargetNm = lfo_bom.treeSelected.mtrlNm;
		}else{
			lfo_bom.treeSelected.bomTargetNm = "";
		}
		
		//수정시 사용자재 변경 불가능
		$('#bomTargetInfo').hide();
		
		gfn_popform_set(lfo_bom, mode, lfo_bom.treeSelected);
	}
	
	//bom구분 변경 이벤트 
	lfn_bomPop_display();
	$("#bomTarget").data("kendoDropDownList").bind("change", lfn_bomPop_display);
	
}

//bom저장
this.lfn_bomPop_save = function(mode){
	var flag = true;
	
	var validation = $("#"+lfo_bom.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){	
		//입력폼 serialize 
		var savePrmt = $("#" + lfo_bom.popId + "_form").serializeObject();
		
		savePrmt.itemId = lfo_common.gridSelected.itemId;

		if(mode == "update"){
			$.ajax({
				async:false,
				url : lfo_bom.ctrlUrl + lfo_bom.crud.read.url,
				type: "POST",
				data: { itemId: savePrmt.bomId },
				success: function(data){
					$.each(data.result, function(index, item) {
						if(savePrmt.bomParentId == item.bomId) {
							kendo.alert("해당 Bom 요소의 하위 요소를 상위 요소로 선택 할 수 없습니다.");
							flag = false;
						}
					});
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		}
		
		if(flag) {
			$.ajax({
				async:false,
				url : lfo_bom.ctrlUrl + lfo_bom.crud[mode].url,
				type: "POST",
				data: JSON.stringify(savePrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					gfn_closePop(lfo_bom.popId);
					lfn_setBomTree("EDT", lfo_common.gridSelected);
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		}
	}
}

//bom 삭제 
this.lfn_popDelete = function(formID){
	var deletePrmt = $("#"+formID).serializeObject();
	
	kendo.confirm("해당 Bom을 삭제하시겠습니까?<br/> 상위 노드를 삭제 할 경우 하위 노드 전부가 삭제 됩니다.")
		.done(function(){
			$.ajax({
				async:false,
				url : lfo_bom.ctrlUrl + lfo_bom.crud.destroy.url,
				type: "POST",
				data: JSON.stringify(deletePrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					gfn_closePop(formID);
					lfn_setBomTree("EDT", lfo_common.gridSelected);
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		})
		.fail(function(){
		});
}

//자재정보 불러옴
this.lfn_bomTargetInfo = function(){
	var callback = function(e) {
		$('#bomTargetId').val(e.mtrlId);
		$('#bomTargetNm').val(e.mtrlNm);
		$('#bomNm').val(e.mtrlNm);
	};
	gfn_openCustomPop("material", callback);;
}

//상위 BOM List 불러오기(완제품, 중간품만)
this.lfn_bomParent_get = function(){
	var bomParentData = [];
	
	//생산타입(가공/조립)
	var produceType = gfn_getCode("produceType").cdReserve01;
	
	lfo_bom.selBoxData.forEach(function(item, index){
		//가공/조립에 따른 분기처리
		if(!gfn_isNull(produceType)){
			if(produceType == "assemble"){//조립
				//조립인 경우 자재는 제외
				if(item.bomTarget != "prcs_bom02"){
					bomParentData.push(item);
				}
			}else{//가공
				//가공인 경우 반제품 제외
				if(item.bomTarget != "prcs_bom03"){
					bomParentData.push(item);
				}
			}
		}
	})
	return bomParentData;
}

//bom 구분 selectbox 데이터(완제품 제외)
this.lfn_bomTarget_get = function(){
	var bomTargetData = gfn_getCode("prcs_bom");
	
	//생산타입(가공/조립)
	var produceType = gfn_getCode("produceType").cdReserve01;
	
	var returnData = [];
	bomTargetData.forEach(function(item, index){
		bomTargetData.cdNm = gfn_getMsg("bc_"+bomTargetData.cdId);
		
		//가공/조립에 따른 분기처리
		if(!gfn_isNull(produceType)){
			if(produceType == "assemble"){//조립
				//조립인 경우 완제품 제외
				if(item.cdId != "prcs_bom01"){
					returnData.push(item)
				}
			}else{//가공
				//가공인 경우 완제품, 반제품
				if(item.cdId != "prcs_bom01" && item.cdId != "prcs_bom03"){
					returnData.push(item);
				}
			}
		}
	});
	
	return returnData;
}

//bom구분 변경 이벤트
this.lfn_bomPop_display = function(){
	
	var  target = $("#bomTarget").val();
	
	//초기화
	$("#bomParentArea").show();
	$("#bomTargetArea").show();
	$("#bomMtrlArea").show();
		
	if(target == "prcs_bom02"){//자재
		$("#lbl_Target").text("사용 자재");
		
		//팝업리사이즈
		gfn_resizePop("jtePopForm",{width:700, height:457});
		
	}else if(target == "prcs_bom03"){//중간품
		//사용자재
		$("#bomMtrlArea").hide();
		
		//팝업리사이즈
		gfn_resizePop("jtePopForm",{width:700, height:410});
	}else{//완제품
		//상위 bom
		$("#bomParentArea").hide();
		
		//bom 구분
		$("#bomTargetArea").hide();
		
		//사용자재 
		$("#lbl_Target").text("품명 ");
		
		//팝업리사이즈
		gfn_resizePop("jtePopForm",{width:700, height:360});
		
	}
}
</script>