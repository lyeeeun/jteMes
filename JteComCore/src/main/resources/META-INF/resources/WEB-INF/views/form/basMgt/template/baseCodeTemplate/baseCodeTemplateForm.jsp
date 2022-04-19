<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="baseCodeMgtForm" style="width: 100%;"></div>

<div id="pop-content" style="display: none;"></div>

<link href='/resources/mes/css/contents/basMgt/codMgt/baseCodeMgt/baseCodeMgtForm_JJW.css' rel="stylesheet">

<script>
	var pageCache = {};
	
	var lfo_common = {};//Form 내부에서 사용될 Object
	
	var menuInfo = {};
	
	//진입 이벤트(공통코드에서 실행)
	this.lfn_init = function() {
		var currentPage = $("#_currentMenuId").val();
		
		//메뉴정보 담아오기
		menuInfo = libUtil.menuList.filter(function(item){return item.menuId == currentPage});

		//현재 메뉴 정보의 화면캐시 정보 불러옴.
		pageCache = gfn_getCurrentPage(); 
		
		this.lfn_jteSgGrd_setGrd();
	};
	
	//그리드 세팅
	this.lfn_jteSgGrd_setGrd = function() {
		lfo_common = {};
		
		lfo_common = {layoutId : "jteSingleGrid"};
		
		lfo_common = gfn_currentGrid_set(lfo_common, pageCache);
		
		lfo_common.crud.read.prmt = {upCdId : menuInfo[0].menuStdStr01};
		
		//lfo_common.customTitle = {html:"<div style='padding : 5px 0; font-weight: bold; font-size: 20px;'>선택된 코드 : " + lfo_common.gridSelected.cdId + "</div>"};
		
		lfo_common.grid = gfn_grid_set(lfo_common);
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
		} else if (mode == "BASE_EDT" || mode == "SUB_EDT") {
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
			gfn_popform_set(lfo_common, mode);
			
			console.log(menuInfo[0].menuStdStr01);
			//상위 코드값 기입
			$("#"+lfo_common.popId+" [name=upCdId]").val(menuInfo[0].menuStdStr01);
		}else if (mode == 'EDT') {
			$("#cdId").attr("readonly", true);
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
			gfn_popform_set(lfo_common, mode, lfo_common.gridSelected);
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
			
			var msgList = $("#msg_" + msgId).val();
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
						lfo_common.grid.dataSource.read();
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
	this.lfn_jtePop_delete = function() {
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
</script>