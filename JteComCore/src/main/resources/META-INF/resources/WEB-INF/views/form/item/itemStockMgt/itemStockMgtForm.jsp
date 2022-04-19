<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="grid-content" style="width:100%;"></div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div id ="pop-content" style="display:none;"></div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/item/itemStockMgt/itemStockMgtForm_JJW.css' rel="stylesheet">

<script>
var pageCache = {};

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	//현재 메뉴 정보의 화면캐시 정보 불러옴.
	pageCache = gfn_getCurrentPage();
	
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_common = {layoutId : "jteSingleGrid"};
	
	lfo_common = gfn_currentGrid_set(lfo_common, pageCache);

	lfo_common.grid = gfn_grid_set(lfo_common);
}


//더블클릭 콜백(팝업)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: lfo_common.popWidth, //20.05.07 첫번째 팝업 너비 JJW LYM 기본 값 750px
		height: lfo_common.popHeight, //20.05.07 첫번째 팝업 높이 JJW LYM 기본 값 600px -> 580
		id:lfo_common.popId, 
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_itemRegistDetail");			//부품 등록(상세)
	}else if(mode=="EDT"){
		selectedItem = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
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
						lfo_common.gridSelected.itemId = selectedItem.itemId;
						lfo_common.gridSelected.itemMgtId = selectedItem.itemMgtId;
						lfo_common.gridSelected.itemMgtType = selectedItem.itemMgtType;
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
			lfo_common.gridSelected = selectedItem;
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
	
	lfn_popDetail_toggle();
	
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

//펼치기/숨기기 버튼 클릭
this.lfn_popDetail_toggle = function(){
	//숨기기
	if($(".pop_detail_btn").hasClass("pop_detail_hide")){
		//영역숨기기$("#jtePopForm_master").find(".pop_detail_info").each(function(){$(this).show();});
		
		$("#" + lfo_common.popId + "_form [name = itemStandard]").closest("tr").show();
		$("#" + lfo_common.popId + "_form [name = itemUnit]").closest("tr").show();
		$("#" + lfo_common.popId + "_form [name = itemMtrl]").closest("tr").show();
		$("#" + lfo_common.popId + "_form [name = itemDesc]").closest("tr").show();
		
		//클래스 변경
		$(".pop_detail_btn").removeClass("pop_detail_hide");
		$(".pop_detail_btn").addClass("pop_detail_show");
	//펼치기
	}else if($(".pop_detail_btn").hasClass("pop_detail_show")){

		$("#" + lfo_common.popId + "_form [name = itemStandard]").closest("tr").hide();
		$("#" + lfo_common.popId + "_form [name = itemUnit]").closest("tr").hide();
		$("#" + lfo_common.popId + "_form [name = itemMtrl]").closest("tr").hide();
		$("#" + lfo_common.popId + "_form [name = itemDesc]").closest("tr").hide();
		
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

//팝업내부 그리드(수량관리 그리드) 
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {layoutId : "jtePopForm_grid", layoutPosition : "pop"};
	
	lfo_popGrd = gfn_currentGrid_set(lfo_popGrd, pageCache);
	
	lfo_popGrd.crud.read.prmt = {itemMgtId : lfo_common.gridSelected.itemMgtId, itemId : lfo_common.gridSelected.itemId}
	
 	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}


//더블클릭 콜백(팝업)
this.lfn_jtePopGrd_popOpen = function(mode,selectedItem){
	var options = {
		modal:true, 
		width: "700px", /* 20.12.18 JJW 550 -> 700 */
		height: "285px", /* 20.12.18 JJW 305 -> 285 */
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
			itemQtyTarget : "ADMIN",
			itemQtyDate : new Date(),
			itemQtyUserNm : $("#_loginUserName").val(),
			itemQtyUser : $("#_loginUserId").val()
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
					lfo_common.grid.dataSource.read();
					
					//이전 팝업화면 리로드
					lfn_jtePop_set('EDT',lfo_common.gridSelected);
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