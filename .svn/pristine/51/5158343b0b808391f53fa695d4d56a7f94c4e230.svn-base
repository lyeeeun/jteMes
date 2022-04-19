<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

	<div id="grid-content" class="ncProgramMgtForm-grid">
		<div id="jteSingleGrid"></div>
	</div>

<div style="display:none;">
	<div id="searchRoutingInfo">
		<div id="searchRoutingInfo_grid"></div>
	</div>
</div>

<!-- 팝업(마스터 그리드 > 더블클릭) -->
<div style="display:none;">
	<div id="jtePopForm" class="ncProgramMgtForm">
		<form id="jtePopForm_form" class="ncProgramMgtForm popfr-ncProgramMgtForm">	<!-- 원래 클래스 : mtrlMgtForm popfr-mtrlMgtForm -->
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master">
			<colgroup> 
				<col class="col-left-title">
				<col class="col-left-content">
				<col class="col-right-title">
				<col class="col-right-content">
			</colgroup>
			<tr><td colspan="4"></td></tr>			
				<tr>
					<td><i class="fas fa-caret-right"></i>NC Program No.</td>	
					<td>
						<input type="text" id="ncpgmNo" class="left-input" name="ncpgmNo" />
						<input type="hidden" id="ncpgmId" name="ncpgmId"/>
						<input type="hidden" name="action" id="ncpgmAction"/>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>Rev No.</td>
					<td><input type="text" id="ncpgmRevNo" class="right-input" name="ncpgmRevNo" /></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>설비 코드</td>
					<td colspan="2">
						<input type="text" id="eqmtMgtNm" class="center-input btn-input" name="eqmtMgtNm" readonly/>
						<input type="hidden" id="eqmtMgtId" class="center-input btn-input" name="eqmtMgtId" />
					</td>
					<td><button class="k-button k-primary connectBom search-btn" type="button" id="connectBom" name="connectBom" onclick="lfn_customPopOpen('eqmtMgt')">설비 선택</button></td>
				</tr>
				<tr>
					<td><i class="fas fa-caret-right"></i>담당자</td>
					<td colspan="2">
						<input type="text" id="managerNm" class="center-input btn-input" name="managerNm" readonly>
						<input type="hidden" id="manager" class="center-input btn-input" name="manager"/>
					</td>
					<td><button class="k-button k-primary connectBom search-btn" type="button" id="connectBom" name="connectBom" onclick="lfn_customPopOpen('userInfo')">담당자 선택</button></td>
				</tr>
				<tr>
					<!-- 첨부파일 -->
					<td class="addFile"><i class="fas fa-caret-right"></i><spring:message code = "col_attachment"></spring:message> : </td>
					<td colspan="3">
						<input name="attachFiles" id="attachFiles" type="file" aria-label="files" format="file" code="ncpgmId" />
						<input type="hidden" id="insertAttach" value = "[]"/>
						<input type="hidden" id="deleteAttach" value = "[]"/>
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>					<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- CSS -->
<link href='/resources/mes/css/contents/techMgt/ncProgramMgtForm/ncProgramMgtForm.css' rel="stylesheet">

<!-- 내부 스타일 외부로 이동_200806 youmi -->

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

var lfo_popGrd = {};//팝업 그리드에서 사용

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	

};

this.lfn_gridSearch = function(){
	lfo_common.grid.dataSource.query({
		page: 1,
		pageSize: 10
	});
}

// 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	
	lfo_common = {};//Form 내부에서 사용될 Object
	lfo_common.count = 0;
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
		6. gridObject.columns = fieldColumns
		7. gridObject.selectBox = SelectBox 매핑 값 
	*/
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/techMgt/ncProgramMgt";

	//4.
	lfo_common.crud  = {
		create:{url:"/saveNcPgmInfo", auth:"", openFunc: lfn_ncPgmRegPop_open, callback: lfn_ncPgmRegPop_save},	
		read:{url:"/selectNcPgmInfo", auth:"", prmt:{}, dynamicPrmt:{routingId: "routingId"}, search: false},
		update:{url:"/saveNcPgmInfo", auth:"", callback: lfn_ncPgmRegPop_save}
	};
	
	//5.
	lfo_common.model = {
		fields: {
			ncpgmId : { type: "string" },
			ncpgmNo : { type: "string" },
			ncpgmRevNo : { type: "string" },
			eqmtMgtId : { type: "string" },
			eqmtMgtNm : { type: "string" },
			reqUser : { type: "string" },
			reqUserNm : { type: "string" },
			manager : { type: "string" },
			managerNm : { type: "string" },
			approveStat : { type: "string" },
			rejectRemark : { type: "string" },
			isUse : { type: "bool"},
			created_at : { type: "string" },
			updated_at : { type: "string" }
		},
	};
	
	//6.
	lfo_common.columns = [
		{field: "ncpgmNo", title: "NC Program No.", width: "140px"},
		{field: "ncpgmRevNo", title: "Rev No.", width: "100px"},
		{field: "eqmtMgtId", title: "설비 코드", width: "130px"},
		{field: "eqmtMgtNm", title: "설비 명", width: "130px"},
		{field: "reqUserNm", title: "신청자", width: "110px"},
		{field: "managerNm", title: "관리자", width: "110px"},
		{field: "approveStat", title: "승인 상태", template:"# var item = gfn_getMsg('bc_approve_'+ approveStat) # #= item #",
			width: "100px"},
		{field: "rejectRemark",  title: "반려 의견(반려 시)", width: "130px"},
		{field: "editOption", title: "정보 수정", width:"130px",		 
			template : function(rows) {
				if( gfn_hasAuth('auth.techMgt.manager') ) {
					return "<button class='k-button k-primary' type='button' onclick='lfn_ncPgmRegPop_open(\"EDT\", this)'>정보 수정</button>";	
				} else if( !gfn_hasAuth('auth.techMgt.manager') && rows.approveStat == "pending") {
					return "<button class='k-button k-primary' type='button' onclick='lfn_ncPgmRegPop_open(\"EDT\", this)'>정보 수정</button>";
				} else {
					return "<span></span>"
				}
			}
		},
		{field: "approve", title: "승인/반려", width:"200px",
			template : function(rows) {
				if( rows.approveStat == "pending" && gfn_hasAuth('auth.techMgt.manager') ) {
					return "<button class='k-button k-primary' type='button' onclick='lfn_approve(\"approve\", this)'>승인</button>&nbsp;&nbsp;<button class='k-button k-primary' type='button' onclick='lfn_approve(\"reject\", this)'>반려</button>";	
				} else {
					return "<span></span>";
				}
			}
		},
		{field: "fileDownload", title: "파일 저장", width:"130px",		 
			template : function(rows) {
				return "<button class='k-button k-primary' type='button' onclick='lfn_ncPgmRegPop_open(\"download\", this)'>파일 저장</button>";
			}
		},
		{field: "createdAt",  title: "최초 등록일", width: "130px"},
		{field: "updatedAt",  title: "최근 수정일", width: "130px"},
		{field: "rejectRemark",  title: "반려 의견(반려 시)", width: "130px"},
		{field: "isUse", title:gfn_getMsg("col_isuse"), width:"110px",											//사용유무
			template : function(rows) {
				if(rows.use == true){
					return "<a onclick='lfn_changeIsUse(this)'><img src='/resources/mes/img/useY.png' style='width:25px; cursor:pointer;'/></a>";
				}else if (rows.use == false){
					return "<a onclick='lfn_changeIsUse(this)'><img src='/resources/mes/img/useN.png' style='width:25px; cursor:pointer;'/></a>";
				}else{
					return " ";
				}
			}
		}
	];
	

	lfo_common.customTitle = {
			html : '<span class="jte-search-aria"><label>'+"프로젝트"+' : </label>'
			+ '<input class="k-textbox" id="orderNm" style="width:200px;" readonly/>'			//검색(UI)
			+ '<input id="orderId" type="hidden">'
			+ '<button class="k-button k-primary" type="button" onclick="lfn_searchPopOpen(\'orderInfo\')">프로젝트 조회</button>'
			+ '<label class="nc-pro-title">'+"제품/공정"+' : </label>'
			+ '<input class="k-textbox" id="routingNm" style="width:200px;" readonly/>'
			+ '<input id="routingId" type="hidden"></span>'
			+ '<button class="k-button k-primary" type="button" onclick="lfn_searchPopOpen(\'routing\')">Routing 조회</button>'
			+ '<a role="button" class="k-button k-button-icontext jte-search" onclick="lfn_ncPgmSearch()"><span class="k-icon k-i-search"></span>조회</a>',
			callback : lfn_customTltle_set
		};
	
	//7.
	lfo_common.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}


this.lfn_searchPopOpen = function(target) {
	if(target == "orderInfo") {
		var callback = function(selectedItem){
			$('#orderId').val(selectedItem.orderId);
			$('#orderNm').val(selectedItem.orderNm);
		};
		gfn_openCustomPop(target, callback, {});
	} else if(target == "routing") {
		var options = {
				modal:true, 
				width: "800px", 
				height: "470px", //200520 JJW 470->
				id: "searchRoutingInfo", 
				title: "Routing 정보",
				resizable: true,
				animation: {open :{effects:"expand:vertical fadeIn"},
				close : {effects:"expand:vertical fadeIn", reverse: true}},
				actions: [/*"Minimize", "Maximize", */"Close"]
			};
		
		options.callback = function(){
			lfn_searchRoutingGrid($('#orderId').val());
			$('#searchRoutingInfo_grid').parent().css('height', '100%');
		};
		
		this.gfn_winOpen(options);
	}
}

this.lfn_ncPgmSearch = function(){
	if( $('#routingId').val() == "" ) {
		kendo.confirm("제품/공정(Routing) 조회가 되지 않았습니다.")
		return false;
	}
	
	lfo_common.grid.dataSource.read();
}

//그리드 세팅
this.lfn_searchRoutingGrid = function(prmtOrderId){
	
	lfo_routingInfo = {};//Form 내부에서 사용될 Object

	//1.
	lfo_routingInfo.layoutId = "searchRoutingInfo_grid";
	
	//2.
	lfo_routingInfo.popId = "";
	
	//3.
	lfo_routingInfo.ctrlUrl = "/form/techMgt/ncProgramMgt";

	//4.
	lfo_routingInfo.crud  = {
		read:{url:"/selectRoutingInfo", auth:"", prmt:{orderId: prmtOrderId}, search: false}
	};
	
	//5.
	lfo_routingInfo.model = {
		fields: {
			itemId : { type: "string" },
			itemNm : { type: "string" },
			routingId : { type: "string" },
			routingType : { type: "string" },
			routingSeq : { type: "string" }
		},
	};
	
	//6.
	lfo_routingInfo.columns = [
		{field: "itemId", title: "부품 코드", width: "140px"},
		{field: "itemNm", title: "부품 명", width: "160px"},
		{field: "routingType", title: "공정 코드", 
			template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #", width: "130px"},
		{field: "routingSeq", title: "공정 차수", width: "120px"}
	];
	
	//7.
	lfo_routingInfo.selectBox = [];
	
	//공통 그리드 세팅 호출 
	lfo_routingInfo.grid = gfn_grid_set(lfo_routingInfo);
	

	lfn_eventBind();

}

this.lfn_eventBind = function(){
	// 더블 클릭 - 콜백 호출
	$("#searchRoutingInfo_grid tbody").on("dblclick", "tr", function(e){

		var popGrid = $("#searchRoutingInfo_grid").getKendoGrid();
		var dataItem = popGrid.dataItem($(this));
		$('#routingNm').val(dataItem.itemNm + " / " + dataItem.routingType);
		$('#routingId').val(dataItem.routingId);
		this.gfn_closePop('searchRoutingInfo');
	});
	
}

this.lfn_ncPgmRegPop_open = function(mode, rows){
	if( $('#routingId').val() == "" ) {
		kendo.confirm("제품/공정(Routing) 조회가 되지 않았습니다.")
		return false;
	}
	//초기화
 	var options = {
		modal: true, 
		width: "800px",
		height: "358px",  //200806 메인 그리드의 추가 버튼 클릭 시의 팝업창 height 변경_430->358px youmi
		id : lfo_common.popId, 
		title: "NC Program File 등록",
		resizable: true,
		animation: {open :{effects:"expand:vertical fadeIn"},
		close : {effects:"expand:vertical fadeIn", reverse: true}},
		actions: [/*"Minimize", "Maximize", */"Close"]
	};

	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		gfn_popform_set(lfo_common, mode, $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest('tr')));
		
		if(mode == "download") {
			$("#"+lfo_common.popId+"_form").find("input").each(function(index,item){
				$(item).attr('readonly', true);
			});
			
			$("#"+lfo_common.popId+"_form").find("button").each(function(index,item){
				$(item).hide();
			});
			
			$("#" + lfo_common.popId +" .k-dropzone").hide();
			$("#" + lfo_common.popId).find(".k-upload-action").each(function(item){
				if($(this).attr("aria-label") == "Remove"){
					$(this).hide();
				}
			})
		} else if(mode == "EDT") {
			$('#ncpgmNo').attr('readonly', true);
			$('#ncpgmRevNo').attr('readonly', true);
		}
	};
	
	this.gfn_winOpen(options);
}

this.lfn_ncPgmRegPop_save = function(mode){
	var formId = lfo_common.popId+"_form";
	var savePrmt = gfn_serializeObject(formId);
	
	savePrmt.routingId = $('#routingId').val();
	if(mode == "create") {
		savePrmt.approveStat = "pending";
		
		var validationYn = lfn_validationCheck(savePrmt);
		
		if(validationYn) return false;
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
			lfo_common.grid.dataSource.read();
			
			gfn_closePop(lfo_common.popId);
			
			gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

this.lfn_customPopOpen = function(target) {
	if(target == "userInfo") {
		var callback = function(selectedItem){
			$('#manager').val(selectedItem.userId);
			$('#managerNm').val(selectedItem.userNm);
		};
		gfn_openCustomPop(target, callback, {});
	} else if(target == "eqmtMgt") {
		var callback = function(selectedItem){
			$('#eqmtMgtId').val(selectedItem.eqmtMgtId);
			$('#eqmtMgtNm').val(selectedItem.eqmtMgtNm);
		};
		gfn_openCustomPop(target, callback, {});
	}
}

this.lfn_approve = function(target, rows) {
	
	var savePrmt = {};
	
	var selectedItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest('tr'))
	
	savePrmt.ncpgmId = selectedItem.ncpgmId;
	savePrmt.approveStat = target;
	savePrmt.action = "U";
	
	if(target == "reject") {
		kendo.prompt("반려 의견을 작성 하세요.", "")
		.done(function(rejectRemark){
			savePrmt.rejectRemark = rejectRemark;
			
			$.ajax({
				async:false,
				url : lfo_common.ctrlUrl + lfo_common.crud["update"].url,
				type: "POST",
				data: JSON.stringify(savePrmt),
				traditional :true,
				contentType : 'application/json',
				dataType : 'json',
				success: function(data){
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
				},error: function(ex){
					gfn_loading(false);
					gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
				}
			});
		})
		.fail(function(rejcetRemark){return false;});
		
	} else {
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud["update"].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				lfo_common.grid.dataSource.read();
				gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
	}
}

this.lfn_changeIsUse = function(rows) {
	var dataItem = $("#jteSingleGrid").data("kendoGrid").dataItem($(rows).closest("tr"));
	
	if(dataItem.use) {
		dataItem.use = false;
	} else {
		dataItem.use = true;
	}
	
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + "/updateIsUse",
		type: "POST",
		data: JSON.stringify(dataItem),
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
}

this.lfn_validationCheck = function(pSavePrmt) {
	var key = {routingId: pSavePrmt.routingId, ncpgmNo: pSavePrmt.ncpgmNo, ncpgmRevNo: pSavePrmt.ncpgmRevNo};
	
	var flag;
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + '/selectDupleKeyCheck',
		type: "POST",
		data: JSON.stringify(key),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			flag = data;
		},error: function(ex){
			gfn_loading(false);
		}
	});
	
	if(flag) {
		kendo.confirm("NCPGM NO와 REV NO의 동일한 값이 이미 존재합니다.");
		return flag;
	}
	
	return flag;
}

</script>