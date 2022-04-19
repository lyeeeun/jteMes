<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="mtrlInfoForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 0; margin:10px 0 5px 0;">
		<input class="radio-btn" type="radio" name="mtrlRemainRadio" value= "usable" checked><span class="radio-span" style = "font-weight: bold;">사용가능</span>
		<input class="radio-btn" type="radio" name="mtrlRemainRadio" value= "disuse"><span class="radio-span" style = "font-weight: bold;">처리완료</span>
		<div style = "padding:15px 0 0 15px;">
			<span style = "font-weight: bold;"><spring:message code = "col_registDate" text = "등록일"/> : </span> <input id="startDate" name="startDate"/> <span> ~ </span> <input id="endDate" name="endDate"/>
		</div>
</div>

<div id="grid-content" class="mtrlMgtForm" style="width:100%;">
	<div id="jteSingleGrid" class="mtrlMgtForm"></div>
</div>


<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="mtrlRemainForm">
			<div class="pop_title"><spring:message code = "pop_mtrlRemain" text = "자재 잔량 정보"/></div>	
			<table style="width:100%;" id="jtePopForm_master" class="BasicTable">
			<colgroup>
				<col style="width:22%;">
				<col style="width:30%;">
				<col style="width:18%;">
				<col style="width:30%;">
			</colgroup>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlRemainId" text = "자재잔량코드"/> : </td>	
					<td><input type="text" id="remainId" name="remainId" format = "text" readonly /></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlRemainGbn" text = "잔량 상태"/> : </td>
					<td><input id="remainDisuse" name="remainDisuse" format="selBox" msg="mtrlRemain" readonly/></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlRemainNm" text = "잔량 자재명"/> : </td>
					<td colspan="3"><input type="text" id="remainNm" name="remainNm" format="text" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_registDate" text = "등록일"/> : </td>
					<td><input id="remainDate" name="remainDate" format="datepicker" /></td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i><spring:message code = "col_registUser" text = "등록자"/> : </td>
					<td>
						<input type="text" id="remainUserNm" class="btn-input" name="remainUserNm" class="k-textbox" readonly />
						<input type="hidden" id="remainUser" name="remainUser" />
						<button class="k-button k-primary" type="button"  onclick= "lfn_UserPop_open()" id="remain_search_btn">
						<spring:message code = "btn_search" text = "조회"/></button>
					</td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_remainWeight" text = "무게"/> : </td>
					<td><input type="text" id="remainWeight" name="remainWeight" format="numeric" /></td>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_mtrlDisuseDate" text = "처리완료날짜"/> : </td>
					<td><input type="text" id="disuseDate" name="disuseDate" format = "text" readonly /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i><spring:message code = "col_desc" text = "설명"/> : </td>
					<td colspan="3"><input type="text" id="remainDesc" name="remainDesc" /></td>
				</tr>
				<tr style="display:hidden;">
					<td>
						<input type="hidden" name="action" id="remainAction"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save" text = "저장"/></button>
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel" text = "취소"/></button>
			</div>
		</form>
	</div>
</div>

<link href='/resources/mes/css/contents/mtrl/mtrlMgt/mtrlMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {}; 

var lfo_popGrd = {};

var lfo_remainGrd = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	
	//날짜검색 박스 세팅
	//startDate = 오늘 날짜의 해당 월 1일로 세팅
	if($("#startDate").attr("data-role") != "datepicker"){
		$("#startDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_getDate(new Date(),"yyyy-MM")+"-01",
			change : function(){
				var disuseVal = $('input[name="mtrlRemainRadio"]:checked').val();
				$('#jteSingleGrid').empty();
				lfn_jteSgGrd_setGrd(disuseVal);
			}
		});
	}
	//endDate = 오늘 날짜로 세팅
	if($("#endDate").attr("data-role") != "datepicker"){
		$("#endDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_getDate(new Date(),"yyyy-MM-dd"),
			change : function(){
				var disuseVal = $('input[name="mtrlRemainRadio"]:checked').val();
				$('#jteSingleGrid').empty();
				lfn_jteSgGrd_setGrd(disuseVal);
			}
		});
	}
	
	//그리드 생성
	lfn_jteSgGrd_setGrd($('input[name="mtrlRemainRadio"]:checked').val());
	//사용여부 라디오 선택 이벤트
	lfn_radioBtn_event();
};

//사용여부 라디오 선택 이벤트
this.lfn_radioBtn_event = function(){
	$("input:radio[name=mtrlRemainRadio]").click(function(e){
		$('#jteSingleGrid').empty();
		lfn_jteSgGrd_setGrd($(this).val());
	}); 
}


// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(sta){
	
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/mtrl/mtrlRemainMgt";

	lfo_common.crud  = {
		read:{url:"/getMtrlRemainList", auth:"", prmt:{remainDisuse : sta, startDate : $('#startDate').val(),endDate : $('#endDate').val()}, dynamicPrmt :"" },
		create:{url:"/setMtrlRemainSave", auth:"", openFunc : lfn_jtePop_open, callback : lfn_popSave}, 
		update:{url:"/setMtrlRemainSave", auth:"", openFunc : "", callback : lfn_popSave},
		destroy:{url:"/setMtrlRemainDelete", auth:"", callback: lfn_jteGrid_delete}
	};

	lfo_common.model = {
		id: "remainId",
		fields: {
			remainId : { type: "string" },
			remainNm : { type: "string" },
			remainWeight: { type: "float" },
			remainDate: { type: "date" },
			remainDesc: { type: "string" },
			remainUser : { type: "string" },
			remainUserNm : { type: "string" },
			disuseDate: { type: "date" },
			remainDisuse: { type: "string" },
			creatorId: { type: "string" },
			createdAt: { type: "date" },
			updatorId: { type: "string" },
			updatedAt: { type: "date" }
		}
	};
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_mtrlRemainNm", "잔량 자재명"), value: "mtrlRemain.remain_nm" }
	];
	
	if(sta == "usable") {
		lfo_common.columns = [
			{selectable : true, width:"35px"},
			{field : "remainId", template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
				title : gfn_getMsg("btn_search", "조회") , width: "90px"},
			{field : "remainId", title : gfn_getMsg("col_mtrlRemainId", "자재잔량코드"), width: "160px"},
			{field : "remainNm", title : gfn_getMsg("col_mtrlRemainNm", "잔량 자재명"), width: "150px"}, 
			{field : "remainWeight", title:gfn_getMsg("col_remainWeight", "잔량 무게"), width: "110px"},
			{field : "remainDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate", "등록일"), width: "175px"},
			{field : "remainUser", title:gfn_getMsg("col_registUser", "등록자"), width: "175px"},
			{field : "remainDesc", title:gfn_getMsg("col_desc", "설명"), width: "220px"},
			{field : "isdel", title: "처리", width: "105px", template: '<button class="k-button k-primary pop-off" type="button" onclick = "lfn_mtrlDisuse(this); " style="min-width:60px;">' + "비움 처리" + '</button>'}
		];
	} else if(sta == "disuse"){
		lfo_common.columns = [
			{selectable : true, width:"30px"},
			{field : "remainId", template:'<button class="k-button k-primary pop-off" type="button" onclick = "lfn_jtePop_open(\'EDT\',this); " style="min-width:60px;">' + "<spring:message code = "pop_view"/>" + '</button>',
				title : gfn_getMsg("btn_search", "조회") , width: "90px"},
			{field : "remainId", title : gfn_getMsg("col_mtrlRemainId", "자재잔량코드"), width: "160px"},
			{field : "remainNm", title : gfn_getMsg("col_mtrlRemainNm", "잔량 자재명"), width: "180px"}, 
			{field : "remainWeight", title:gfn_getMsg("col_remainWeight", "잔량 무게"), width: "110px"},
			{field : "remainDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_registDate", "등록일"), width: "175px"},
			{field : "disuseDate", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_disuseDate", "처리완료일"), width: "175px"},
			{field : "remainUser", title:gfn_getMsg("col_registUser", "등록자"), width: "150px"},
			{field : "remainDesc", title:gfn_getMsg("col_desc", "설명"), width: "220px"}
		];
	}

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//자재 잔량 정보 팝업 오픈
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "750px", 
		id:lfo_common.popId, 
		resizable:true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	if(mode =="NEW"){
		options.height= "400px";
		options.title = gfn_getMsg("pop_mtrlRemainRegist", "자재 잔량 등록");			
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_mtrlRemainUpdate", "자재 잔량 수정");
		
		if(lfo_common.grid.dataItem($(selectedItem).closest('tr')).remainDisuse == "disuse"){
			options.height= "325px";
		} else {
			options.height= "400px";
		}
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		lfn_jtePop_set(mode, selectedItem);
	};
	this.gfn_winOpen(options);
}


//자재 잔량 정보 팝업 셋팅
this.lfn_jtePop_set = function(mode, selectedItem){

	lfo_common.gridSelected = {};
	
	if(mode=='NEW'){
		$("#remain_search_btn").show();
		gfn_popform_set(lfo_common, mode);
		$('#remainDate').val(gfn_getDate(new Date(),"yyyy-MM-dd"));
	}else if(mode == 'EDT'){
		$("#remain_search_btn").hide();
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest('tr'));
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = {remainId : selectedItem};
			
		}
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {remainId :lfo_common.gridSelected.remainId},
			success: function(data){
				if(data.rows[0].remainDisuse == "disuse"){
					$('#remainNm').attr('readonly', true);
					$('#remainDate').attr('readonly', true);
					$('#remainDesc').attr('readonly', true);
					$('#remainWeight').attr('readonly', true);
					$('div').remove('.final-btn-area');					
				}
				gfn_popform_set(lfo_common, mode,data.rows[0]);
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//Form내용 입력/저장
this.lfn_popSave = function(mode){
	//저장 하기전에 validationCheck
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//입력폼 serialize
		var formId = lfo_common.popId+"_form";
		var savePrmt = gfn_serializeObject(formId);
		
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
					gfn_closePop(lfo_common.popId);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
			}
		});
	}
}

//삭제 콜백
this.lfn_jteGrid_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			var delTemp = lfo_common.grid.dataItem($(this).closest('tr'))
			delPrmt.push(delTemp);
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
			lfn_jtePop_set('EDT',lfo_common.gridSelected);
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});	
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});
		}
	});
}


//잔량 처리
this.lfn_mtrlDisuse = function(rows){
	var dataItem = lfo_common.grid.dataItem($(rows).closest("tr"));
	var prmt = {remainId : dataItem.remainId, remainDisuse : "disuse", action: "D"};
	
	//confirm Box
	gfn_conBox({msg:"잔량 사용 처리하겠습니까?", yes : function(){
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + "/setMtrlRemainSave",
			type: "POST",
			data: JSON.stringify(prmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					//이전화면 리로드
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "실패하였습니다. \n 값이 제대로 입력되었는지 확인 후 다시 시도해주세요.")});				//실패
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}});
}

//유저정보 팝업 -콜백시 유저정보를 매핑해준다.
this.lfn_UserPop_open = function(){
	var callback = function(selectedItem){
		$("#remainUser").val(selectedItem["userId"]);
		$("#remainUserNm").val(selectedItem["userNm"]);
	}
	gfn_openCustomPop('userInfo',callback);
}

</script>