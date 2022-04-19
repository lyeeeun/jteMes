<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 검색영역 -->
<div style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
	<span style="margin-left : 15px;"> 메뉴선택 : </span>
	<span style="margin-left : 15px;">
		<input id='menuNm' type='text' class='k-textbox' readonly/>
		<input id='menuId' type='hidden'/>
		<button onclick='gfn_openCustomPopTree("menuInfo", lfn_menuSearch_callback)' class='k-button'>조회</button>
	</span>
</div>

<!-- 마스터 그리드 영역 -->
<div id="grid-content">
	<div id="jteSingleGrid"></div>
</div>

<!-- 화면설정 - 그리드 설정 -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form">
			<table id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:18%;">
				<col style="width:31%;">
				<col style="width:20%;">
				<col style="width:31%;">
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="테이블명"/> : </td>
					<td><input type="text" name="gridDb"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="grid ID"/> : </td>
					<td><input type="text" name="gridId"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="grid Class"/> : </td>
					<td>
						<input type="text" name="gridClass" class="btn-input" readonly/>
						<button class="k-button k-primary" type="button" onclick="lfn_dynamicInput_open('gridClass','class')">
							클래스 작성
						</button>
					</td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="grid Style"/> : </td>
					<td>
						<input type="text" name="gridStyle" class="btn-input" readonly/>
						<button class="k-button k-primary" type="button" onclick="lfn_dynamicInput_open('gridStyle','style')">
							스타일 작성
						</button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="grid Title"/> : </td>
					<td>
						<input type="text" name="gridTitle"/>
					</td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="ctrlUrl"/> : </td>
					<td><input type="text" name="gridUrlBase"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="read"/> : </td>
					<td>
						<input type="text" name="gridUrlRead" class="btn-input" readonly/>
						<button class="k-button k-primary" type="button" onclick="lfn_jsonMerge_open('gridUrlRead','pageSetRead')">
							json버튼
						</button>
					</td>
					
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="create"/> : </td>
					<td>
						<input type="text" name="gridUrlCreate" class="btn-input" readonly/>
						<button class="k-button k-primary" type="button" onclick="lfn_jsonMerge_open('gridUrlCreate','pageSetCreate')">
							json버튼
						</button>
					</td>
				</tr>
			
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="update"/> : </td>
					<td>
						<input type="text" name="gridUrlUpdate" class="btn-input" readonly/>
						<button class="k-button k-primary" type="button" onclick="lfn_jsonMerge_open('gridUrlUpdate','pageSetUpdate')">
							json버튼
						</button>
					</td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="destroy"/> : </td>
					<td>
						<input type="text" name="gridUrlDestroy" class="btn-input" readonly/>
						<button class="k-button k-primary" type="button" onclick="lfn_jsonMerge_open('gridUrlDestroy','pageSetDestroy')">
							json버튼
						</button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 아이디"/> : </td>
					<td><input type="text" name="gridPopId"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 클래스"/> : </td>
						<td>
							<input type="text" name="gridPopClass" class="btn-input" readonly/>
							<button class="k-button k-primary" type="button" onclick="lfn_dynamicInput_open('gridPopClass','class')">
								클래스 작성
							</button>
						</td>
					</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 타이틀"/> : </td>
					<td><input type="text" name="gridPopTitle"/></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 비율"/> : </td>
					<td><input type="text" name="gridPopCol"/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 가로"/> : </td>
					<td><input type="text" name="gridPopWidth" format="currency" /></td>
					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 세로"/> : </td>
					<td><input type="text" name="gridPopHeight" format="currency" /></td>
				</tr>
<!-- 				<tr> -->
<%-- 					<td><i class="fas fa-caret-right"></i><spring:message code="" text="팝업 함수"/> : </td> --%>
<!-- 					<td colspan="3"><textarea rows="5" name="gridFunction"></textarea></td> -->
<!-- 				</tr> -->
				<tr style="display:hidden;">
					<td colspan="4">
						<input type="hidden" name="gridNo"/>
						<input type="hidden" name="action"/>
						<input type="hidden" name="upGridId"/>
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area menuInfoForm-final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn jte-create" type="button"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn jte-destroy" type="button"><spring:message code = "pop_delete" text="삭제"/></button>
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- JSON 입력폼 -->
<div style="display:none;">
	<div id="jteJsonInput">
		<form id="jteJsonInput_form">
			<table id="jteJsonInput_master" class="BasicTable">
				<colgroup>
					<col style="width:18%;">
					<col style="width:31%;">
					<col style="width:20%;">
					<col style="width:31%;">
				</colgroup>
				<tbody id = "jteJsonInput_body"></tbody>
				<tr style="display:none">
					<td colspan=4>
						<input type = "hidden" name = "selectKey" />
						<input type = "hidden" name = "baseCode" />
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteJsonInput');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
</div>


<!-- class, style, dynamicJson 입력폼 -->
<div style="display:none;">
	<div id="jteDynamicInput">
		<div style="margin:5px 0 5px 0; text-align:right;">
			<button class="k-button k-primary" type="button" name="plus" onclick="lfn_plusBtn_click()" style="font-size:15px; width:60px; height:40px; margin-right:10px;">행추가+</button>
			<button class="k-button k-primary" type="button" name="minus" onclick="lfn_minusBtn_click()"style="font-size:15px;  width:60px; height:40px; margin-right:10px;">행삭제-</button>
		</div>
		<form id="jteDynamicInput_form">
			<div style="max-height:300px; overflow:auto; border : 1px solid #e7e7e7; border-radius:3px; padding:5px; margin:4px;">
				<table id="jteDynamicInput_master" class="BasicTable">
					<colgroup>
						<col style="width:10%;">
						<col style="width:40%;">
						<col style="width:50%;">
					</colgroup>
					<tbody id = "jteDynamicInput_body"></tbody>
					
					<tr style="display:none">
						<td colspan=3>
							<input type = "hidden" name = "selectKey" />
							<input type = "hidden" name = "option" />
						</td>
					</tr>
				</table>
			</div>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteDynamicInput');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
</div>

<!-- 화면설정 - 필드 입력 -->
<div style="display:none;">
	<div id="jteFieldPop" style="">
		<div style="width:100%; background:#f0f5ff; padding : 10px 0px; margin:10px 0 5px 0;">
			<!-- 월/일 체크박스 -->
			<input type="radio" name="fieldType" id="baseChk" class="k-radio" checked="checked" value="base" style="margin : 0 5px 0 20px;">
			<label  for="baseChk" style="vertical-align:middle;">기본</label>
			<input type="radio" name="fieldType" id="popChk" class="k-radio"  value="pop" style="margin : 0 5px 0 5px;">
			<label  for="popChk" style="vertical-align:middle;">팝업영역</label>
			<input type="radio" name="fieldType" id="gridChk" class="k-radio"  value="grid" style="margin : 0 5px 0 5px;">
			<label  for="gridChk" style="vertical-align:middle;">그리드영역</label>
			<input type="radio" name="fieldType" id="searchChk" class="k-radio"  value="search" style="margin : 0 5px 0 5px;">
			<label  for="searchChk" style="vertical-align:middle;">검색영역</label>
			<input type="radio" name="fieldType" id="validationChk" class="k-radio"  value="validation" style="margin : 0 5px 0 5px;">
			<label  for="validationChk" style="vertical-align:middle;">유효성검사 영역</label>
			<input type="radio" name="fieldType" id="excelChk" class="k-radio"  value="excel" style="margin : 0 5px 0 5px;">
			<label  for="excelChk" style="vertical-align:middle;">엑셀 영역</label>
		</div>
		<form id="jteFieldPop_form">
			<div id="jteFieldPop_grid" style="display:block; height:420px;"></div>
		</form>
	</div>
</div>

<!-- 필드 오브젝트 입력폼 -->
<div style="display:none;">
	<div id="jteFieldObjectInput">
		<form id="jteFieldObjectInput_form">
			<table id="jtefieldObjectInput_master" class="BasicTable">
				<colgroup>
					<col style="width:23%;">
					<col style="width:27%;">
					<col style="width:23%;">
					<col style="width:27%;">
				</colgroup>
				<tbody id = "jteFieldObjectInput_body"></tbody>
				<tr style="display:none">
					<td colspan=3>
						<input type = "hidden" name = "selectKey" />
						<input type = "hidden" name = "option" />
					</td>
				</tr>
			</table>
		</form>
		<div class="final-btn-area" style="text-align:center;">
			<button class="k-button k-primary final-btn jte-update" type="button"><spring:message code = "pop_save"/></button>			<!-- 저장 -->
			<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jteFieldObjectInput');"><spring:message code = "pop_cancel"/></button>			<!-- 취소 -->
		</div>
	</div>
</div>
<script>

var lfo_common = {};//Form 내부에서 사용될 Object

var lfo_gridField = {};

//json 작성팝업
var jsonPopObj = {};

//dynamic json 작성팝업
var dynamicPopObj = {};

//field Object 작성팝업
var fieldPopObj = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//메뉴 조회 선택 콜백
this.lfn_menuSearch_callback = function(rtnObj){
	//메뉴 선택
	$("#menuId").val(rtnObj.menuId);
	$("#menuNm").val(rtnObj.menuNm);
	
	lfo_common.grid.dataSource.read();
}

//메인 그리드 생성
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/basMgt/codMgt/pageSet"
	
	//4.
	lfo_common.crud  = {
		read : {url:"/getPageSetList", auth:"", prmt:{}, dynamicPrmt:{menuId : "menuId"}, search : false, paging : false},
		create : {url : "/setPageSetSave", auth : "", openFunc : lfn_jtePop_open, callback : lfn_jtePop_save},
		update : {url : "/setPageSetSave", auth : "", callback : lfn_jtePop_save},
		destroy : {type : "pop", url : "/setPageSetDelete", auth:"", callback : lfn_jtePop_delete}
	};
	lfo_common.customTitle = {html:'<a role="button" class="k-button k-button-icontext" onclick = "gfn_openCustomPopTree(\'menuInfo\', lfn_jtePop_copy)">복사하기</a>', position : "end"}
																										
	//5.
	lfo_common.model = {
		id: "gridNo",
		fields: {
			gridNo: { type: "int" },
			gridDb: { type: "string" },
			gridId: { type: "string" },
			gridClass: { type: "string" },
			gridStyle: { type: "string" },
			gridTitle: { type: "string" },
			gridUrlBase: { type: "string" },
			gridUrlRead: { type: "string" },
			gridUrlCreate: { type: "string" },
			gridUrlUpdate: { type: "string" },
			gridUrlDestroy: { type: "string" },
			gridPopId: { type: "string" },
			gridPopWidth: { type: "string" },
			gridPopHeight: { type: "string" },
			gridPopClass: { type: "string" },
			gridPopCol: { type: "string" },
			gridPopTitle: { type: "string" },
			gridFunction: { type: "string" },
			gridDiv: { type: "string" },
			upGridId: { type: "string" },
			menuId: { type: "string" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{field: "menuId", title : gfn_getMsg("btn_search") , width: "200px"
			,template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); "><spring:message code = "btn_update"/></button>'+
					  '<button class="k-button k-primary" type="button" onclick = "lfn_fieldPop_open(\'NEW\',this); ">필드 입력</button>'
			},
		{field: "gridDb", title : "Table 명", width: "150px"},
		{field: "gridId", title : "html ID", width: "150px"},
		{field: "gridClass", title : "", width: "150px"},
		{field: "gridStyle", title : "", width: "150px"},
		{field: "gridTitle", title : "", width: "150px"},
		{field: "gridUrlBase", title : "", width: "150px"},
		{field: "gridUrlRead", title : "", width: "150px"},
		{field: "gridUrlCreate", title : "", width: "150px"},
		{field: "gridUrlUpdate", title : "", width: "150px"},
		{field: "gridUrlDestroy", title : "", width: "150px"},
		{field: "gridPopId", title : "", width: "150px"},
		{field: "gridPopWidth", title : "", width: "150px"},
		{field: "gridPopHeight", title : "", width: "150px"},
		{field: "gridPopClass", title : "", width: "150px"},
		{field: "gridPopCol", title : "", width: "150px"},
		{field: "gridPopTitle", title : "", width: "150px"},
		{field: "gridFunction", title : "", width: "150px"},
		{field: "gridDiv", title : "", width: "150px"}
	];
	
	//7.
	lfo_common.selectBox = [];
	
	//8.
// 	lfo_common.validation ={
// 		compNm:{
// 			messages : "업체명을 입력하세요",
// 			rules : function(input){
// 				if(input.is("[name=compNm]")){
// 					return input.val().length != 0 && input.val().trim().length != "";
// 				}
// 				return true;
// 			}
// 		}
// 	}
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//화면설정 - 그리드 설정 팝업 오픈
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
			modal:true, 
			width: "900px",
			height: "550px",
			id:"jtePopForm", 
			title : "그리드 설정",
			resizable:true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		
		if(!gfn_isEmpty(selectedItem)){
			selectedItem = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		}
		
		lfn_jtePop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);		
}

//화면설정 - 그리드 설정 팝업 세팅
this.lfn_jtePop_set = function(mode, selectedItem){
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		//수정시 특정값 변경불가
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem;
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected.gridNo = selectedItem;
		}
		
		gfn_popform_set(lfo_common, mode, lfo_common.gridSelected);
	}
}


//json 팝업 오픈
this.lfn_jsonMerge_open = function(selectKey, baseCode){
	
	jsonPopObj = {	
		popId : "jteJsonInput",
		crud : {
			create:{callback : lfn_jsonMerge_save},
			update:{callback : lfn_jsonMerge_save}
		}
	};
	
	var selectedItem = {};
	
	try{
		selectedItem = JSON.parse($("[name=" + selectKey + "]").val());
	}catch(ex){
		selectedItem = {};
	}
	
	selectedItem.selectKey = selectKey;
	
	var html = "";
	
	var jsonList = gfn_getCode(baseCode);
	
	for(key in jsonList){
		
		if(key % 2 == 0) html += "<tr>\n";
		
		html += "<td><i class='fas fa-caret-right'></i> " + jsonList[key].cdVal + " : </td>\n";
		
		if(jsonList[key].cdReserve01 == "text"){
			html += "<td><input type='text' name = '" +  jsonList[key].cdVal + "' parse = '"+ jsonList[key].cdReserve01 +"'></td>\n";
		}else if(jsonList[key].cdReserve01 == "json"){
			html += '<td><input type="text" name = "' +  jsonList[key].cdVal + '" parse = "'+ jsonList[key].cdReserve01 +'" class="btn-input">';
			html += '<button type="button" onclick="lfn_dynamicInput_open(\''+jsonList[key].cdVal+'\',\'json\')" class="k-button k-primary">json 버튼</button></td>\n';
		}else if(jsonList[key].cdReserve01 == "bool"){
			html += "<td><input format='selBox' msg='comnBool' name = '" +  jsonList[key].cdVal + "' keyGbn='cdVal' value ='true' parse = '"+ jsonList[key].cdReserve01 +"'></td>\n";
		}else if(jsonList[key].cdReserve01 == "selBox"){
			html += "<td><input format='selBox' msg='"+jsonList[key].cdReserve02+"' name = '" +  jsonList[key].cdVal + "' keyGbn='cdVal' value ='true' parse = '"+ jsonList[key].cdReserve01 +"'></td>\n";
		}
		
		if(key % 2 == 1) html += "</tr>\n";
	}
	
	// td 홀수로 끝날 경우 마감처리
	if(jsonList.length % 2 == 1) html += "</tr>\n";
	
	//팝업 오픈
	var options = {
		modal:true, 
		width: "720px",
		height: "0px",
		id : jsonPopObj.popId, 
		title : "JSON 등록",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	this.gfn_winOpen(options);
	
	$("#"+ jsonPopObj.popId +"_body").html(html);
	
	var popHeight = $("#"+jsonPopObj.popId+"_body").height() + 145;
	
	gfn_resizePop(jsonPopObj.popId,{width : 720, height : popHeight});
	
	for(var key in selectedItem){
		if(typeof(selectedItem[key]) == "object"){
			selectedItem[key] = JSON.stringify(selectedItem[key]);
		}else if(typeof(selectedItem[key]) == "boolean"){
			selectedItem[key] = selectedItem[key] + "";
		}
	}
	gfn_popform_set(jsonPopObj, "EDT", selectedItem);
}

//json 팝업 저장
this.lfn_jsonMerge_save = function(mode){
	var validation = $("#"+ jsonPopObj.popId +"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = lfn_jsonMerge_serializeObject(jsonPopObj.popId + "_form");
		
		var rtnBox = savePrmt.selectKey;
		
		delete savePrmt.selectKey;
		
		$("[name="+ rtnBox +"]").val(JSON.stringify(savePrmt));
		
		gfn_closePop(jsonPopObj.popId);
	}
}

//class style dynamicJson 입력 팝업 오픈
this.lfn_dynamicInput_open = function(selectKey, option){
	
	dynamicPopObj = {
		popId : "jteDynamicInput",
		crud : {
			create:{callback : lfn_dynamicInput_save},
			update:{callback : lfn_dynamicInput_save}
		}
	}	
	
	//팝업 body html 
	var html = "";
	//팝업 textbox 값 저장소
	var formData = {};
	//기존입력 값
	var selectedItem = $("[name=" + selectKey + "]").val();
	
	//저장시 리턴될 input 값
	formData.selectKey = selectKey;
	
	//class, style, json 구분
	formData.option = option
	
	//option에 따라 분기처리하여 팝업 body html 생성
	if(option == "class"){//class
		if(selectedItem.trim() != ""){// 기존내용이 있는 경우
			//클래스는 띄어쓰기로 구분
			selectedItem = selectedItem.split(" ");
			
			for(key in selectedItem){
				//체크박스
				html += "<tr>\n<td><input type='checkbox' class='k-checkbox'></td>/n";
				//value
				html += "<td colspan=2><input type='text' name='"+ selectedItem[key] +"'></td>\n</tr>\n";
				
				//팝업 오픈시 값 세팅을 위해 기존 값 저장
				formData[selectedItem[key]] = selectedItem[key];
			}
		}else{//최초 작성시
			html += "<tr>\n<td><input type='checkbox' class='k-checkbox'></td>/n";
			html += "<td colspan=2><input type='text' name='cls' class='k-textbox'></td>\n</tr>\n";
		}
	}else if(option == "style"){//style
		
		if(selectedItem.trim() != ""){// 기존내용이 있는 경우
		
			//기존 저장값이 있을 경우 마지막 세미콜른은 제거(split할 경우 빈 값 생성을 막기위함)
			if(selectedItem.charAt(selectedItem.length -1) == ";"){
				selectedItem = selectedItem.substr(0, selectedItem.length -1);
			}
		
			//스타일은 세미콜론으로 구분
			selectedItem = selectedItem.split(";");
		
			for(key in selectedItem){
				//style key value 구분
				var splitStyle = selectedItem[key].split(":");
				
				//체크박스
				html += "<tr>\n<td><input type='checkbox' class='k-checkbox'></td>\n";
				//key
				html += "<td><input type='text' name = 'style_" + key  + "'></td>\n";
				//value
				html += "<td><input type='text' name = 'style_" +  key + "_2'></td>\n<tr>\n";
				
				//팝업 오픈시 값 세팅을 위해 기존 값 저장
				formData["style_"+key] = splitStyle[0].trim();
				formData["style_"+key+"_2"] = splitStyle[1].trim();
			}
		}else{//최초 작성시
			//체크박스
			html += "<tr>\n<td><input type='checkbox' class='k-checkbox'></td>\n";
			//key
			html += "<td><input type='text' name='stl' class='k-textbox'></td>\n";
			//value
			html += "<td><input type='text' name='stl_2' class='k-textbox'></td>\n<tr>\n";
		}
		
	}else if(option == "json"){//json(key - value 모두 입력 받음.)
		//json파싱
		try{
			selectedItem = JSON.parse(selectedItem);
		}catch(ex){
			selectedItem = {};
		}
		
		
		if(Object.keys(selectedItem).length != 0){// 기존내용이 있는 경우
			for(key in selectedItem){
				//체크박스
				html += "<tr>\n<td><input type='checkbox' class='k-checkbox'></td>\n";
				//key
				html += "<td><input type='text' name = 'json_" + key  + "'></td>\n";
				//value
				html += "<td><input type='text' name = 'json_" +  key + "_2'></td>\n<tr>\n";
				
				//팝업 오픈시 값 세팅을 위해 기존 값 저장
				formData["json_"+key] = key;
				formData["json_"+key+"_2"] = selectedItem[key];
			}
		}else{// 데이터가 없는 경우
			//체크박스
			html += "<tr>\n<td><input type='checkbox' class='k-checkbox'></td>\n";
			//key
			html += "<td><input type='text' name='jsn' class='k-textbox'></td>\n";
			//value
			html += "<td><input type='text' name='jsn_2' class='k-textbox'></td>\n<tr>\n";
		}
	}
	
	//팝업 오픈 값 세팅
	var options = {
		modal:true, 
		width: "720px",
		height: "0px",
		id : dynamicPopObj.popId, 
		title : "JSON 등록",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업오픈
	this.gfn_winOpen(options);
	
	//팝업 바디 html 입력
	$("#"+ dynamicPopObj.popId +"_body").html(html);
	
	//팝업 inputBox 값 세팅
	gfn_popform_set(dynamicPopObj, "EDT", formData);
	
	//동적 팝업이기 때문에 팝업 사이즈 측정
	var popHeight = $("#"+dynamicPopObj.popId).height() + 80;
	
	//팝업 리사이즈
	gfn_resizePop(dynamicPopObj.popId,{width : 720, height : popHeight});
}

//class style dynamicJson 저장s
this.lfn_dynamicInput_save = function(mode){
	var validation = $("#"+ dynamicPopObj.popId +"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		
		var bodyHtml = "";
		
		var option = $("#"+ dynamicPopObj.popId + "_form [name=option]").val();
		var selectKey = $("#"+ dynamicPopObj.popId + "_form [name=selectKey]").val();
		
		if(option == "class"){
			$("#"+ dynamicPopObj.popId + "_body").find(":text").each(function(){
				if($(this).val().trim() == ""){
					gfn_warnBox({title:"경고", msg:"입력되지 않은 칸이 있습니다."});
				}
				bodyHtml += $(this).val() + " ";
			});
			
			$("[name="+ selectKey +"]").val(bodyHtml.trim());
			
		}else if(option == "style"){
			$("#"+ dynamicPopObj.popId + "_body").find("tr").each(function(){
				var tempHtml = "";
				$(this).find(":text").each(function(no, item){
					
					if(no % 2 == 0){
						tempHtml += $(this).val() + ":"
					}else{
						tempHtml += $(this).val()+"; ";
					}
					
				});
				bodyHtml += tempHtml;
			});
			
			$("[name="+ selectKey +"]").val(bodyHtml.trim());
		}else if(option == "json"){
			$("#"+ dynamicPopObj.popId + "_body").find("tr").each(function(){
				var tempHtml = "";
				$(this).find(":text").each(function(no, item){
					
					if(no % 2 == 0){
						tempHtml += '\"' + $(this).val() + "\":"
					}else{
						tempHtml += '\"' + $(this).val() + "\", ";
					}
					
				});
				bodyHtml += tempHtml;
			});
			
			bodyHtml = bodyHtml.trim();
			
			if(bodyHtml.charAt(bodyHtml.length -1) == ","){
				bodyHtml = bodyHtml.substr(0, bodyHtml.length -1);
			}
			
			$("[name="+ selectKey +"]").val("{"+bodyHtml+"}");
		}
		
		gfn_closePop(dynamicPopObj.popId);
	}
}

//class style dynamicJson 행 추가 이벤트
this.lfn_plusBtn_click = function(){
	var option = $("#"+ dynamicPopObj.popId + "_form [name=option]").val();
	var bodyHtml = "";
	
	if(option == "class"){
		
		bodyHtml += "<tr>\n<td><input type='checkbox' class='k-checkbox'></td>/n";
		bodyHtml += "<td  colspan=2><input type='text' name='cls' class='k-textbox'></td>\n</tr>\n";
		
		$("#"+ dynamicPopObj.popId +"_body").append(bodyHtml);
		
	}else if(option == "style"){
		//체크박스
		bodyHtml += "<tr>\n<td><input type='checkbox' class='k-checkbox'></td>\n";
		//key
		bodyHtml += "<td><input type='text' name='stl' class='k-textbox'></td>\n";
		//value
		bodyHtml += "<td><input type='text' name='stl_2' class='k-textbox'></td>\n<tr>\n";
		
		$("#"+ dynamicPopObj.popId +"_body").append(bodyHtml);
	}else if(option == "json"){
		//체크박스
		bodyHtml += "<tr>\n<td><input type='checkbox' class='k-checkbox'></td>\n";
		//key
		bodyHtml += "<td><input type='text' name='jsn' class='k-textbox'></td>\n";
		//value
		bodyHtml += "<td><input type='text' name='jsn_2' class='k-textbox'></td>\n<tr>\n";
		
		$("#"+ dynamicPopObj.popId +"_body").append(bodyHtml);
	}
	
	var popHeight = $("#"+dynamicPopObj.popId).height() + 80;
	
	gfn_resizePop(dynamicPopObj.popId,{width : 720, height : popHeight});
}

//class style dynamicJson 행 삭제 이벤트
this.lfn_minusBtn_click = function(){
	var option = $("#"+ dynamicPopObj.popId + "_form [name=option]").val();
	
	if(option == "class"){
		$("#"+ dynamicPopObj.popId +"_body").find(':checkbox:checked').each(function(){
			$(this).closest('tr').remove();
		});
	}else if(option == "style"){
		$("#"+ dynamicPopObj.popId +"_body").find(':checkbox:checked').each(function(){
			$(this).closest('tr').remove();
		});
	}else if(option == "json"){
		$("#"+ dynamicPopObj.popId +"_body").find(':checkbox:checked').each(function(){
			$(this).closest('tr').remove();
		});
	}
	
	var popHeight = $("#"+dynamicPopObj.popId).height() + 80;
	
	gfn_resizePop(dynamicPopObj.popId,{width : 720, height : popHeight});
}


//form > json 변환(값이 없으면 키삭제)
this.lfn_jsonMerge_serializeObject = function(param){
	
	var rtnObj = $("#"+param).serializeObject();
	
	for(key in rtnObj){
		if(gfn_isNull(rtnObj[key].trim())){
			delete rtnObj[key];
		}else{
			var type = $("[name = " + key + "]").attr("parse");
			if(type == "json"){
				rtnObj[key] = JSON.parse(rtnObj[key]);
			}else if(type == "bool"){
				rtnObj[key] = rtnObj[key] === 'true'; 
			}
		}
	}
	return rtnObj;
}

//복사하기  콜백
this.lfn_jtePop_copy = function(selectedMenu){
	var copyPrmt = {
		copyMenuId : selectedMenu.menuId,
		menuId : $("#menuId").val()
	};
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/setPageCopyMenu",
		type: "POST",
		data: JSON.stringify(copyPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			if(data != ""){
				lfo_common.grid.dataSource.read();
				//gfn_closePop('jtePopForm');
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

//Form내용 입력/저장
this.lfn_jtePop_save = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#" + lfo_common.popId + "_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize 
		var savePrmt = gfn_serializeObject(lfo_common.popId + "_form");
		
		//저장된 다국어가 있다면 추가
		var msgId = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		savePrmt.menuId = $("#menuId").val();
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != null){

					lfn_jtePop_set("EDT",data);
					
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


//화면설정 - 그리드 설정 팝업 삭제
this.lfn_jtePop_delete = function(mode){
	gfn_conBox({
		title : "삭제 팝업", 
		msg:"삭제하시겠습니까?",
		yes : function(){
			//입력폼 serialize 
			var delPrmt = gfn_serializeObject(lfo_common.popId + "_form");

			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
				type: "POST",
				data: JSON.stringify(delPrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					if(data == 'success'){
						lfo_common.grid.dataSource.read();
						
						gfn_closePop(lfo_common.popId)
						
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
	});
}

//화면설정 - 그리드 설정 팝업 오픈
this.lfn_fieldPop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "1200px",
		height: "500px",
		id:"jteFieldPop", 
		title : "필드 설정",
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
		
		lfn_fieldPop_set(mode);
		
		$("[name=fieldType]").change(function(){
			lfn_fieldPop_set("EDT");
		})
	};
	this.gfn_winOpen(options);
}

//화면설정 - 그리드 설정 팝업 세팅
this.lfn_fieldPop_set = function(mode){
	
	var radioChecked  = $("[name=fieldType]:checked").val();
	
	$("#jteFieldPop_grid").html("");
	
	lfo_gridField = {};//Form 내부에서 사용될 Object 
	
	//1.
	lfo_gridField.layoutId = "jteFieldPop_grid";
	
	//2.
	lfo_gridField.popId = "";
	
	//3.
	lfo_gridField.ctrlUrl = "/form/basMgt/codMgt/pageSet"
	
	//4.
	lfo_gridField.crud  = {
		read : {url:"/getPageFieldList", auth:"", prmt : {gridNo : lfo_common.gridSelected.gridNo}},
		create : {url : "/setPageFieldSave", auth : ""},
		update : {url : "/setPageFieldSave", auth : ""}
	};
	
	//5.
	lfo_gridField.model = {
		id: "fieldNo",
		fields: {
			fieldNo : { type: "int" },
			fieldDb : { type: "string" },
			fieldName : { type: "string" },
			fieldType : { type: "string", defaultValue: 'fieldTypeText'},
			gridNo: { type: "int" }
		}
	};
	var fieldList = []; 
	
	$.ajax({
		async:false,
		url : lfo_gridField.ctrlUrl + lfo_gridField.crud.read.url,
		type: "POST",
		data: JSON.stringify(lfo_gridField.crud.read.prmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			fieldList = data.rows;
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});	
	
	var fieldInfoList = [];
	
	switch(radioChecked){
		case 'base' :
			lfo_gridField.columns = [
				{field: "fieldNo", title : "-", command: ["edit","destroy"], width: "200px"},
				//{field: "fieldNo", title : "", width: "150px", locked: true},
				{field: "fieldDb", title : "db필드명", width: "140px"},
				{field: "fieldName", title : "표시명", width: "150px"},
		 		{field: "fieldType", title : "타입", width: "150px",
					template : function(e){
						if(gfn_isNull(e.fieldType)){
							return '';
						}else{
							var typeObj = gfn_getCode('pageSetFieldType').find(function(element){if(element.cdId == e.fieldType) return true});
							return gfn_getMsg('bc_'+typeObj.cdId, typeObj.cdNm);
						}
						return '';
					},
					editor: function(container, options){
						$("<input name='"+ options.field +"'/>").appendTo(container)
						.kendoDropDownList({
							dataTextField: "cdNm",
							dataValueField: "cdId",
							template : "#= gfn_getMsg('bc_' + cdId, cdNm)#",
							dataSource : gfn_getCode("pageSetFieldType")
						})
					}
				}
			];
			lfo_gridField.toolbar = ["search","create"];
			
			fieldList.sort(function(a, b) {return gfn_nvl(JSON.parse(a.fieldGrid).fieldGridNum,999999) - gfn_nvl(JSON.parse(b.fieldGrid).fieldGridNum,999999)});
			lfo_gridField.childItems = fieldList;
		break;
		case 'pop' :
			fieldInfoList = gfn_getCode('pageSetPopUp');
			lfo_gridField = lfn_popGridColumns_set(lfo_gridField, fieldInfoList);
			
			fieldList = fieldList.filter(item => gfn_getCode(item.fieldType).cdReserve01 != 'grid' )
			
			fieldList.sort(function(a, b) {return gfn_nvl(JSON.parse(a.fieldPop).fieldPopNum,999999) - gfn_nvl(JSON.parse(b.fieldPop).fieldPopNum,999999)});
			
			for(var key in fieldList){
				fieldList[key] = Object.assign(fieldList[key], JSON.parse(fieldList[key].fieldPop))
			}
			
			lfo_gridField.childItems = fieldList;
		break;
		case 'grid' :
			fieldInfoList = gfn_getCode('pageSetGrid');
			lfo_gridField = lfn_popGridColumns_set(lfo_gridField, fieldInfoList);
			
			fieldList = fieldList.filter(item => gfn_getCode(item.fieldType).cdReserve01 != 'pop')
			
			fieldList.sort(function(a, b) {return gfn_nvl(JSON.parse(a.fieldGrid).fieldGridNum,999999) - gfn_nvl(JSON.parse(b.fieldGrid).fieldGridNum,999999)});
			for(var key in fieldList){
				fieldList[key] = Object.assign(fieldList[key], JSON.parse(fieldList[key].fieldGrid))
			}
			lfo_gridField.childItems = fieldList;
		break;
		case 'search' :
			fieldInfoList = gfn_getCode('pageSetSearch');
			lfo_gridField = lfn_popGridColumns_set(lfo_gridField, fieldInfoList)
			
			fieldList = fieldList.filter(item => gfn_getCode(item.fieldType).cdReserve01 != 'grid' || gfn_getCode(item.fieldType).cdReserve01 != 'pop');
			
			fieldList.sort(function(a, b) {return gfn_nvl(JSON.parse(a.fieldSearch).fieldSearchNum,999999) - gfn_nvl(JSON.parse(b.fieldSearch).fieldSearchNum,999999)});
			
			for(var key in fieldList){
				fieldList[key] = Object.assign(fieldList[key], JSON.parse(fieldList[key].fieldSearch))
			}
			lfo_gridField.childItems = fieldList;
		break;
		case 'validation' :
			fieldInfoList = gfn_getCode('pageSetValidation');
			lfo_gridField = lfn_popGridColumns_set(lfo_gridField, fieldInfoList)
			
			fieldList = fieldList.filter(item => gfn_getCode(item.fieldType).cdReserve01 != 'grid' || gfn_getCode(item.fieldType).cdReserve01 != 'pop');
			
			fieldList.sort(function(a, b) {return gfn_nvl(JSON.parse(a.fieldPop).fieldPopNum,999999) - gfn_nvl(JSON.parse(b.fieldPop).fieldPopNum,999999)});
			for(var key in fieldList){
				fieldList[key] = Object.assign(fieldList[key], JSON.parse(fieldList[key].fieldValidation))
			}
			lfo_gridField.childItems = fieldList;
		break;
		case 'excel' :
			fieldInfoList = gfn_getCode('pageSetExcel');
			lfo_gridField = lfn_popGridColumns_set(lfo_gridField, fieldInfoList)
			
			fieldList = fieldList.filter(item => gfn_getCode(item.fieldType).cdReserve01 != 'grid' || gfn_getCode(item.fieldType).cdReserve01 != 'pop');
			
			fieldList.sort(function(a, b) {return gfn_nvl(JSON.parse(a.fieldGrid).fieldGridNum,999999) - gfn_nvl(JSON.parse(b.fieldGrid).fieldGridNum,999999)});
			
			for(var key in fieldList){
				fieldList[key] = Object.assign(fieldList[key], JSON.parse(fieldList[key].fieldExcel))
			}
			lfo_gridField.childItems = fieldList;
		break;
	}
	
	//7.
 	lfo_gridField.selectBox = [/* { text: gfn_getMsg("col_user"), value: "userInfo.user_nm" } */];
	

	
	//객체 그리드 세팅 호출 
	lfo_gridField.grid = gfn_objectDatagrid_set(lfo_gridField);
	
	//행추가시 기존 수정중이던 행 삭제되는 문제 해결
	$(".k-grid-add").click(function(){lfo_gridField.grid.cancelChanges()})
	
	//저장 이벤트 바인드
	lfo_gridField.grid.bind("save", lfn_update);
	
	//캔슬이벤트 바인등
	lfo_gridField.grid.bind("cancel", lfn_cancel);
	
	//삭제 이벤트 바인딩(삭제버튼 누를때 기존 이벤트가 바인딩 되어 있어 커스텀 작업)
	$(".k-grid-delete").click(function(event){event.preventDefault() ;lfn_remove(this)});
	
}
// 필드설정 - 그리듯 컬럼 세팅
this.lfn_popGridColumns_set = function(gridObject ,fieldList){
	lfo_gridField.toolbar = ["search","modify"];
	lfo_gridField.columns = [
		{field: "fieldNo", title : "-", command: ["edit"], width: "200px",locked:true, editable : function(e){return false;}},
		{field: "fieldDb", title : "db필드명", width: "120px",locked:true, editable : function(e){return false;}},
		{field: "fieldName", title : "표시명", width: "120px",locked:true, editable : function(e){return false;}},
		{field: "fieldType", title : "타입", width: "130px",locked:true, editable : function(e){return false;},
			template : function(e){
				if(gfn_isNull(e.fieldType)){
					return '';
				}else{
					var typeObj = gfn_getCode('pageSetFieldType').find(function(element){if(element.cdId == e.fieldType) return true})
					return gfn_getMsg('bc_'+typeObj.cdId,typeObj.cdNm);
				}
			}
		}
	];
	
	for(var key in fieldList){
		var columns = {field : fieldList[key].cdVal, title : fieldList[key].cdNm,  width:120}
		
		if(fieldList[key].cdReserve01 == 'text'){
			gridObject.model.fields[fieldList[key].cdVal] = { type: "string" };
		}else if(fieldList[key].cdReserve01 == 'currency'){
			columns.editor = function(container, options){
				$("<input name='"+ options.field +"'/>").appendTo(container)
				.kendoNumericTextBox({
					format: "n0",
					value: 0
				});
			}
			gridObject.model.fields[fieldList[key].cdVal] = { type: "int" };
			if(!gfn_isNull(fieldList[key].cdReserve03)) gridObject.model.fields[fieldList[key].cdVal].defaultValue = fieldList[key].cdReserve03
		}else if(fieldList[key].cdReserve01 == 'numeric'){
			columns.editor = function(container, options){
				$("<input name='"+ options.field +"'/>").appendTo(container)
				.kendoNumericTextBox({
					format: "n0",
					value: 0
				});
			}
			gridObject.model.fields[fieldList[key].cdVal] = { type: "int" };
			if(!gfn_isNull(fieldList[key].cdReserve03)) gridObject.model.fields[fieldList[key].cdVal].defaultValue = fieldList[key].cdReserve03
			
		}else if(fieldList[key].cdReserve01 == 'bool'){
			columns.template = "#= gfn_isNull("+fieldList[key].cdVal+") == true ? '' : gfn_getCode("+fieldList[key].cdVal+").cdNm #";
			
			columns.editor = function(container, options){
				$("<input name='"+ options.field +"'/>").appendTo(container)
 				.kendoDropDownList({
 					dataTextField: "cdNm",
 					dataValueField: "cdId",
 					template : "#= gfn_getMsg('bc_' + cdId, cdNm)#",
 					dataSource: gfn_getCode("comnBool")
 				});
 			}
			gridObject.model.fields[fieldList[key].cdVal] = { type: "string" };
			
			if(!gfn_isNull(fieldList[key].cdReserve03)) gridObject.model.fields[fieldList[key].cdVal].defaultValue = fieldList[key].cdReserve03
			
		}else if(fieldList[key].cdReserve01 == 'selBox'){
			
			columns.template = "#= gfn_isNull("+fieldList[key].cdVal+") == true ? '' : gfn_getCode("+fieldList[key].cdVal+").cdNm #";
			
			columns.editor = function(container, options){
				$("<input name='"+ options.field +"'/>").appendTo(container)
 				.kendoDropDownList({
 					dataTextField: "cdNm",
 					dataValueField: "cdId",
 					template : "#= gfn_getMsg('bc_' + cdId, cdNm)#",
 					dataSource : gfn_getCode(gfn_getCode(options.field).cdReserve02)
 				});
	 		}
			
			gridObject.model.fields[fieldList[key].cdVal] = { type: "string" };
			
			if(!gfn_isNull(fieldList[key].cdReserve03)) gridObject.model.fields[fieldList[key].cdVal].defaultValue = fieldList[key].cdReserve03
			
		}
		gridObject.columns.push(columns);
	}
	
	return gridObject;
}

//필드정보 - 등록/수정
this.lfn_update = function(e){
	//기본이벤트 중지
	e.preventDefault();
	
	var rules = {};
	var messages = {};
	
	$.each(lfo_gridField.validation,function(key,value){
		rules[key] = value.rules;
		messages[key] = value.messages;
	});
	
	//validator
	var validator = $("#jteFieldPop_form").kendoValidator({
		rules: rules,
		messages: messages
	}).data("kendoValidator");
	
	//validation - tooltip
	$("#jteFieldPop_form").kendoTooltip({
		filter: ".k-invalid",
		content: function(e) {
			var name = e.target.attr("name") || e.target.closest(".k-widget").find(".k-invalid:input").attr("name");
			var errorMessage = $("#jteFieldPop_form").find("[data-for=" + name + "]");
			return '<span class="k-icon k-warning"> </span>' + errorMessage.text();
		},
		show: function() {
			this.refresh();
		}
	});
	
	if(gfn_isEmpty(validator) || validator.validate()){
		
		var rows = e.model;
		
		
		$(".k-grid-edit-row").find("input[name]").each(function(){
			rows[$(this).attr("name")] = $(this).val();
		})
		
		var savePrmt = {};
		
		//기본 현재 그리드 정보 담기
		savePrmt.gridNo =  lfo_common.gridSelected.gridNo;
		
		//등록/수정 판단
		if(gfn_isNull(rows.fieldNo)){
			var mode = 'create';
			savePrmt.action = 'C';
			savePrmt.fieldDb = rows.fieldDb;
			savePrmt.fieldId = rows.fieldId;
			savePrmt.fieldName = rows.fieldName;
			savePrmt.fieldType = rows.fieldType;
			savePrmt.fieldPop = "{}";
			savePrmt.fieldGrid = "{}";
			savePrmt.fieldSearch = "{}";
			savePrmt.fieldValidation = "{}";
			savePrmt.fieldExcel = "{}";
		}else{
			mode = 'update';
			savePrmt.action = 'U';
			savePrmt.fieldNo =  rows.fieldNo;
			
			var radioChecked  = $("[name=fieldType]:checked").val();
			var fieldInfoList = [];
			
			switch(radioChecked){
				case 'base' :
					savePrmt.fieldDb = rows.fieldDb;
					savePrmt.fieldId = rows.fieldId;
					savePrmt.fieldName = rows.fieldName;
					savePrmt.fieldType = rows.fieldType;
					break;
				case 'pop' :
					fieldInfoList = gfn_getCode('pageSetPopUp');
					savePrmt.fieldPop = lfn_popGridColumns_srialObj(rows, fieldInfoList)
					break;
				case 'grid' :
					fieldInfoList = gfn_getCode('pageSetGrid');
					savePrmt.fieldGrid = lfn_popGridColumns_srialObj(rows, fieldInfoList)
					break;
				case 'search' :
					fieldInfoList = gfn_getCode('pageSetSearch');
					savePrmt.fieldSearch = lfn_popGridColumns_srialObj(rows, fieldInfoList)
					break;
				case 'validation' :
					fieldInfoList = gfn_getCode('pageSetValidation');
					savePrmt.fieldValidation = lfn_popGridColumns_srialObj(rows, fieldInfoList)
					break;
				case 'excel' :
					fieldInfoList = gfn_getCode('pageSetExcel');
					savePrmt.fieldExcel = lfn_popGridColumns_srialObj(rows, fieldInfoList)
					break;
			}
		}
		
		//db명 변환 (ab_cd > abCd)
		var convertDb = rows.fieldDb.split('_');
		for(var i = 1; i < convertDb.length; i++){
			convertDb[i] = convertDb[i].replace(/^./, convertDb[i][0].toUpperCase());
		}
		savePrmt.fieldId = convertDb.join('');
		
		// 등록/수정 수행
		$.ajax({
			async:false,
			url : lfo_gridField.ctrlUrl + lfo_gridField.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					lfn_fieldPop_set("EDT")
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

//필드정보 - 등록,수정 저장데이터 변환
this.lfn_popGridColumns_srialObj = function(rows ,fieldList){
	var temp = {};
	for(var key in fieldList){
		if(fieldList[key].cdReserve01 == 'text'){
			temp[fieldList[key].cdVal] = rows[fieldList[key].cdVal];
		}else if(fieldList[key].cdReserve01 == 'currency'){
			temp[fieldList[key].cdVal] = eval(rows[fieldList[key].cdVal]);
		}else if(fieldList[key].cdReserve01 == 'numeric'){
			temp[fieldList[key].cdVal] = eval(rows[fieldList[key].cdVal]);
		}else if(fieldList[key].cdReserve01 == 'bool'){
			temp[fieldList[key].cdVal] = rows[fieldList[key].cdVal];
		}else if(fieldList[key].cdReserve01 == 'selBox'){
			temp[fieldList[key].cdVal] = rows[fieldList[key].cdVal];
		}
	}
	return JSON.stringify(temp);
}

//필드정보 - 로우삭제
this.lfn_remove = function(rows){
	
	var delPrmt = lfo_gridField.grid.dataItem($(rows).closest("tr"));
	
	gfn_conBox({msg:"삭제하시겠습니까?",yes:function(){
		
		$.ajax({
			async:false,
			url : lfo_gridField.ctrlUrl + "/setPageFieldDelete",
			type: "POST",
			data: JSON.stringify(delPrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					lfn_fieldPop_set("EDT")
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}})
}

//필드정보 - 수정 취소
this.lfn_cancel = function(e){
	e.preventDefault();
	lfo_gridField.grid.cancelChanges();
}

</script>