<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="baseCodeMgtForm" style="width: 100%;"></div>

<div id="pop-content" style="display: none;"></div>

<link href='/resources/mes/css/contents/basMgt/codMgt/baseCodeMgt/baseCodeMgtForm_JJW.css' rel="stylesheet">

<script>
	var pageCache = {};
	
	var lfo_common = {};//Form 내부에서 사용될 Object
	
	var lfo_subGrd = {};//팝업 그리드에서 사용
	
	//진입 이벤트(공통코드에서 실행)
	this.lfn_init = function() {
		
		//현재 메뉴 정보의 화면캐시 정보 불러옴.
		pageCache = gfn_getCurrentPage();
		
		this.lfn_jteSgGrd_setGrd();
	};

	this.lfn_jteSgGrd_setGrd = function() {
		lfo_common = {layoutId : "jteSingleGrid"};
		
		lfo_common = gfn_currentGrid_set(lfo_common, pageCache);
		
 		lfo_common.customTitle = {html : '<input id ="codeMaster">', callback : lfn_codeMaster_set};

 		console.log(lfo_common);
		lfo_common.grid = gfn_grid_set(lfo_common);
	}
	
	//코드 구분 selectbox 세팅
	this.lfn_codeMaster_set = function(){
		var dropDownData = [];
		
		//기초코드 biz 하위단 불러옴
		$.each(gfn_getCode('biz'), function(index, item) {
			dropDownData.push({text : gfn_getMsg('bc_' + item.cdId, item.cdNm), value : item.cdId});
		});
		
		//select box 세팅
		$("#codeMaster").kendoDropDownList({
			dataTextField: "text",
			dataValueField: "value",
			dataSource: dropDownData,
			index: 0,
			change: lfn_codeMaster_change
		});
	}
	
	//코드구분 selectbox 변경 이벤트
	this.lfn_codeMaster_change = function(){
		//페이징 초기화
		lfo_common.grid.dataSource.query({ page: 1 });
		
		lfn_subGrid_call('clear');
	}
	
	//수정 버튼  콜백(팝업)
	this.lfn_jtePop_open = function(mode, selectedItem) {
		var options = {
			modal : true,
			width : lfo_common.popWidth,
			height : lfo_common.popHeight,
			id : lfo_common.popId,
			resizable : true,
			animation : {open : {effects : "expand:vertical fadeIn"},close : {effects : "expand:vertical fadeIn", reverse : true}},
			actions : [/*"Minimize", "Maximize", */"Close" ]
		};
		
		if (mode == "NEW") {
			options.title = gfn_getMsg("pop_basicCodeRegist"); //기초코드 등록
		} else if (mode == "EDT") {
			options.title = gfn_getMsg("pop_basicCodeUpdate"); //기초코드 조회
		}
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function() {
			lfn_jtePop_set(mode, selectedItem);
		};
		this.gfn_winOpen(options);
	}
	
	//팝업내용 세팅
	this.lfn_jtePop_set = function(mode, selectedItem) {
		var gridSelected = {};
		if (mode == 'NEW') {
			
			lfo_common.gridSelected = {};
			
			gfn_popform_set(lfo_common, mode);
			
			//상위 코드값 기입
			$("#"+lfo_common.popId+" [name=upCdId]").val($("#codeMaster").val());
			
			//서브그리드 초기화
			lfn_subGrid_call('clear');
			
		} else if (mode == 'EDT') {
			$("#cdId").attr("readonly", true);
			
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
			
			gfn_popform_set(lfo_common, mode, lfo_common.gridSelected);
			
			//서브그리드 활성화
			lfn_subGrid_call('set',lfo_common.gridSelected.cdId);
		}
	}
	
	//Form내용 입력/저장
	this.lfn_jtePop_save = function(mode) {

		//저장 하기전에 validationCheck
		var validation = $("#" + lfo_common.popId + "_form").getKendoValidator();
		if (gfn_isEmpty(validation) || validation.validate()) {

			var savePrmt = gfn_serializeObject(lfo_common.popId + "_form");
			savePrmt.updatorId = _loginUserUsername.value;

			var msgId = $("#" + lfo_common.popId + "_form").find(".jte-msgBox").attr("defId");
			var msgList = $("#" + lfo_common.popId + "_form #msg_" + msgId).val();
			if (!gfn_isNull(msgList)) {
				savePrmt.msgList = JSON.parse(msgList);
			}
			$.ajax({
				async : false,
				url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
				type : "POST",
				data : JSON.stringify(savePrmt),
				traditional : true,
				contentType : 'application/json',
				dataType : 'json',
				success : function(data) {
					if (data != "") {
					
						lfo_common.grid.dataSource.read();
						
						//서브그리드 활성화
						lfn_subGrid_call('set',data.result);
						
						gfn_closePop(lfo_common.popId);
						
						gfn_msgBox({msg : gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")}); //성공
					} else {
						gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")}); //실패
					}
				},
				error : function(ex) {
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed", "오류가 발생했습니다. \n 관리자에게 문의해주세요.")}); //오류가 발생했습니다.
				}
			});
		}
	}
	
	//삭제 콜백
	this.lfn_jteGrid_delete = function() {
		
		//서브그리드 숨김
		lfn_subGrid_call('clear');
		
		var delPrmt = [];
		$("#" + lfo_common.layoutId + " .k-checkbox").each(function(index, item) {
			if ($(this).attr("aria-checked") == "true") {
				delPrmt.push(lfo_common.grid.dataItem($(this).closest('tr')));
			}
		});
		
		$.ajax({
			async : false,
			url : lfo_common.ctrlUrl + lfo_common.crud.destroy.url,
			type : "POST",
			data : JSON.stringify(delPrmt),
			traditional : true,
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				lfo_common.grid.dataSource.read();
				gfn_msgBox({msg : gfn_getMsg("pop_deleteSuccess")}); //성공적으로 삭제되었습니다.
			},
			error : function(ex) {
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed", "오류가 발생했습니다. \n 관리자에게 문의해주세요.")}); //오류가 발생했습니다.
			}
		});
	}
	
	//서브그리드 세팅
	this.lfn_subGrid_call = function(mode, selectedItem) {
		//서브그리드 초기화
		lfo_common.gridSelected = {}
		$("#jteSubGrid").html("");
		
		//서브그리드가 초기화가 아닐 경우 세팅
		if(mode != 'clear'){
			if(typeof(selectedItem) == "string"){
				
				lfo_common.gridSelected.cdId = selectedItem;
				
			}else if(typeof(selectedItem) == "object"){
				lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));	
			}
			lfn_subGrid_set();
		}
	}
	
	//서브그리드 세팅
	this.lfn_subGrid_set = function() {
		lfo_subGrd = {};
		
		lfo_subGrd = {layoutId : "jteSubGrid"};
		
		lfo_subGrd = gfn_currentGrid_set(lfo_subGrd, pageCache);
		
		lfo_subGrd.crud.read.prmt = {upCdId : lfo_common.gridSelected.cdId};
		
		lfo_subGrd.customTitle = {html:"<div style='padding : 5px 0; font-weight: bold; font-size: 20px;'>선택된 코드 : " + lfo_common.gridSelected.cdId + "</div>"};
		
		lfo_subGrd.grid = gfn_grid_set(lfo_subGrd);
	}
	
	//수정 버튼  콜백(팝업)
	this.lfn_subPop_open = function(mode, selectedItem) {
		var options = {
			modal : true,
			width : lfo_subGrd.popWidth,
			height : lfo_subGrd.popHeight,
			id : lfo_subGrd.popId,
			resizable : true,
			animation : {open : {effects : "expand:vertical fadeIn"},close : {effects : "expand:vertical fadeIn", reverse : true}},
			actions : [/*"Minimize", "Maximize", */"Close" ]
		};
		
		if (mode == "NEW") {
			options.title = gfn_getMsg("pop_basicCodeRegist"); //기초코드 등록
		} else if (mode == "BASE_EDT" || mode == "SUB_EDT") {
			options.title = gfn_getMsg("pop_basicCodeUpdate"); //기초코드 조회
		}
		
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function() {
			lfn_subPop_set(mode, selectedItem);
		};
		this.gfn_winOpen(options);
	}
	
	//팝업내용 세팅
	this.lfn_subPop_set = function(mode, selectedItem) {
		var gridSelected = {};
		if (mode == 'NEW') {
			lfo_subGrd.gridSelected = "";
			gfn_popform_set(lfo_subGrd, mode);
			
			//상위 코드값 기입
			$("#"+lfo_subGrd.popId+" [name=upCdId]").val(lfo_common.gridSelected.cdId);
		}else if (mode == 'EDT') {
			$("#cdId").attr("readonly", true);
			lfo_subGrd.gridSelected = lfo_subGrd.grid.dataItem($(selectedItem).closest("tr"));
			gfn_popform_set(lfo_subGrd, mode, lfo_subGrd.gridSelected);
		}
	}
	
	//Form내용 입력/저장
	this.lfn_subPop_save = function(mode) {
		//저장 하기전에 validationCheck
		var validation = $("#" + lfo_subGrd.popId + "_form").getKendoValidator();
		if (gfn_isEmpty(validation) || validation.validate()) {

			var savePrmt = gfn_serializeObject(lfo_subGrd.popId + "_form");
			savePrmt.updatorId = _loginUserUsername.value;

			var msgId = $("#" + lfo_subGrd.popId + "_form").find(".jte-msgBox").attr("defId");
			
			var msgList = $("#msg_" + msgId).val();
			if (!gfn_isNull(msgList)) {
				savePrmt.msgList = JSON.parse(msgList);
			}
			
			$.ajax({
				async : false,
				url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud[mode].url,
				type : "POST",
				data : JSON.stringify(savePrmt),
				traditional : true,
				contentType : 'application/json',
				dataType : 'json',
				success : function(data) {
					if (data != "") {
						lfo_common.grid.dataSource.read();
						lfo_subGrd.grid.dataSource.read();
						gfn_closePop(lfo_subGrd.popId);
						gfn_msgBox({msg : gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")}); //성공
					} else {
						gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")}); //실패
					}
				},
				error : function(ex) {
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed", "오류가 발생했습니다. \n 관리자에게 문의해주세요.")}); //오류가 발생했습니다.
				}
			});
		}
	}
	
	//삭제 콜백
	this.lfn_subGrid_delete = function() {
		var delPrmt = [];
		$("#" + lfo_subGrd.layoutId + " .k-checkbox").each(function(index, item) {
			if ($(this).attr("aria-checked") == "true") {
				delPrmt.push(lfo_subGrd.grid.dataItem($(this).closest('tr')));
			}
		});
		$.ajax({
			async : false,
			url : lfo_subGrd.ctrlUrl + lfo_subGrd.crud.destroy.url,
			type : "POST",
			data : JSON.stringify(delPrmt),
			traditional : true,
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				lfo_subGrd.grid.dataSource.read();
				gfn_msgBox({msg : gfn_getMsg("pop_deleteSuccess")}); //성공적으로 삭제되었습니다.
			},
			error : function(ex) {
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed", "오류가 발생했습니다. \n 관리자에게 문의해주세요.")}); //오류가 발생했습니다.
			}
		});
	}
</script>