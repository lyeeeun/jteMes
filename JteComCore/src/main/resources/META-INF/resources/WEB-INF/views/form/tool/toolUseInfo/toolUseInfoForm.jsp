<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 마스터 그리드 영역 -->
<div id="grid-content" class="toolUseInfoForm" style="width:100%;">
	<div id="jteSingleGrid" class="toolUseInfoForm"></div>
</div>

<!-- 사용정보 팝업  -->
<div style="display:none;">
	<div id="jtePopForm" class="toolUseInfoForm jtePopForm">
		<div class="pop_title">공구 사용 정보</div>
		<div id="jtePopForm_grid" style="height:350px;"></div>
	</div>
</div>

<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
	
	lfn_radioBtn_event();
};

//사용가능 여부 라디오 버튼
this.lfn_radioBtn_event = function(){
	$("[name='delTuiChk']").change(function(e){
		$("#delStat").val($("[name='delTuiChk']:checked").val());
		lfo_common.grid.dataSource.read();
	});
}

this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/tool/mtrltoolMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getToolMgtList", auth:"", search:false, prmt:{toolId:""}, dynamicPrmt : {del : "delStat", toolId : "toolId"}}
	};
	
	//커스텀 타이틀
 	lfo_common.customTitle = {
		html :	 '<button class="k-button k-primary" type="button" onclick = "lfn_tool_info(\'tool\');" style="min-width:60px;">공구 검색</button>' +
				'<input class="k-textbox" id="toolNm" readonly/><input type="hidden" id="toolId" />'+
				'<span style="margin : 10px 10px 0 10px ;">사용가능 여부 : '+
				'<input type="radio" name="delTuiChk" id="delFalse" class="k-radio" checked="checked" value=false style="margin : 0 5px 0 5px;">' +
			 	'<label class="mtrltoolMgtForm-label" for="delFalse">가능</label>'+
				'<input type="radio" name="delTuiChk" id="delTrue" class="k-radio"  value=true style="margin : 0 5px 0 5px;">'+
				'<label class="mtrltoolMgtForm-label" for="delTrue">불가</label>'+
				'<input type="hidden" id="delStat" value="false"></span>'
	} 
	
	//5.
	lfo_common.model = {
		id: "toolMgtId",
		fields: {
			toolMgtId : { type: "string" },
			toolMgtPurchase : { type: "date" },
			toolMgtState : { type: "string" },
			toolMgtLimit : { type: "int" },
			toolMgtUse : { type: "int" },
			toolMgtVerif : { type: "date" },
			toolMgtGbn : { type: "string" },
			toolMgtDesc : { type: "string" },
			creatorId : { type: "string" },
			createdAt : { type: "date" },
			updatorId : { type: "string" },
			updatedAt : { type: "date" },
			compId : { type: "string" },
			compNm : { type: "string" },
			isDel : {type:"bool"},
			toolId : { type: "string" },
			toolNm : { type: "string" },
			toolType : { type: "string" },
			toolPrice : { type: "int" },
			toolLimit : { type: "int" },
			toolDesc : { type: "string" },
			isUse : { type: "bool" }
		}
	};
	
	//6.
	lfo_common.columns = [
		{selectable : true, width:"50px"},
		{field: "toolMgtId",template:'<button class="k-button k-primary" type="button" onclick = "lfn_jtePop_open(this); " style="min-width:60px;">' + gfn_getMsg("pop_useInfo") + '</button>',
			title : gfn_getMsg("col_history", "이력") , width: "110px"},
		{field: "toolMgtId", title:gfn_getMsg("col_toolIndivCd", "공구개별코드"), width: "160px"},
		{field: "toolNm", title:gfn_getMsg("col_toolNm", "공구명"), width: "140px"},
		{field: "toolMgtGbn", template:"# var item = gfn_isNull(gfn_getCode(toolMgtGbn))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtGbn).cdId , gfn_getCode(toolMgtGbn).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolStatus", "공구상태"), width: "160px"},
		{field: "toolMgtState", template:"# var item = gfn_isNull(gfn_getCode(toolMgtState))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolMgtState).cdId , gfn_getCode(toolMgtState).cdNm) # #= item #", 
			title:gfn_getMsg("col_toolDiv", "공구구분"), width: "140px"},
		{field: "compNm", title:gfn_getMsg("col_compNm", "업체명"), width: "160px"},
		{field: "toolMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate", "등록일"), width: "120px"},
		{field: "toolMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod", "검증기간"), width: "120px"},
		{field: "toolMgtUse", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_toolUse", "사용량"), width: "120px"},
		{field: "toolMgtLimit", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_useLimit", "사용제한"), width: "120px"},
		{field: "toolMgtDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];
	//7.
	lfo_common.selectBox = [
		{ text: gfn_getMsg("col_toolNm","공구명"), value: "toolInfo.tool_nm" },
		{ text: gfn_getMsg("col_toolIndivCd", "공구개별코드"), value: "toolMgt.tool_mgt_id" },
		{ text: gfn_getMsg("col_compNm","업체명"), value: "compInfo.comp_nm" },
		{ text: gfn_getMsg("col_desc","설명"), value: "toolMgt.tool_mgt_desc" }
	];
	//8.
	lfo_common.validation ={
		toolMgtUse:{
			messages : "사용량을 입력하세요",
			rules : function(input){
				if(input.is("[name=toolMgtUse]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		toolMgtLimit:{
			messages : "사용한도를 입력하세요",
			rules : function(input){
				if(input.is("[name=toolMgtLimit]")){
					return input.val().length != 0;
				}
				return true;
			}
		},
		toolMgtPurchase:{
			messages : "수령일을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMgtPurchase]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		toolMgtVerif:{
			messages : "검증기간을 등록하세요",
			rules : function(input){
				if(input.is("[name=toolMgtVerif]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		compId:{
			messages : "alert",
			rules : function(input){
				if(input.is("[name=compId]")){
					if(input.val().length == 0){
						alert("조회버튼을 눌러 업체를 등록하세요");
						return false;
					}
				}
				return true;
			}
		}
	}
	//공통 그리드 세팅 호출 compId
	lfo_common.grid = gfn_grid_set(lfo_common);
}

//공구 선택 팝업
this.lfn_tool_info = function(mode){
	
	if(mode == 'tool') {
		var callback = function(selectedItem){
			$('#toolNm').val(selectedItem.toolNm);
			$('#toolId').val(selectedItem.toolId);
			
			lfo_common.grid.dataSource.read();
		};
		
		gfn_openCustomPop("tool", callback);
	}
	
}

//공구 사용정보 팝업 오픈
this.lfn_jtePop_open = function(target){

	var options = {
			modal:true, 
			width: "850px",
			height: "388px", 
			id : lfo_common.popId, 
			title: "공구 사용 정보",
			resizable : true,
			animation:{open :{effects:"expand:vertical fadeIn"},
			close :{effects:"expand:vertical fadeIn", reverse: true}},
			actions:[/*"Minimize", "Maximize", */"Close"]
		};
		
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		//선택값 저장
		lfo_common.gridSelected = lfo_common.grid.dataItem($(target).closest("tr"));
		
	
		$("#jtePopForm_grid").html("");
		lfn_jteToolUse_setGrd();
	};
	this.gfn_winOpen(options);
}

//사용정보 그리드 세팅
this.lfn_jteToolUse_setGrd = function(){
	lfo_popGrd = {};//Form 내부에서 사용될 Object
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.
	lfo_popGrd.popId = "jtePopToolUse";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/tool/mtrltoolMgt";
	
	//4.
	lfo_popGrd.crud  = {
		read:{url:"/getToolUseList", auth:"", search:false, prmt:{toolMgtId : lfo_common.gridSelected.toolMgtId}},
		excel:{url:"" ,auth:"", fileName: "공구사용 이력_" + gfn_getDate(new Date(),"yyyy-MM-dd HH:mm:ss")},
		//create:{url:"", auth:""},
		update:{url:"/setEqmtMgtSave", auth:"", callback : lfn_toolUsePop_save}, 
		//destroy:{url:"", auth:""}
	};
	
	//5.
	lfo_popGrd.model = {
			id: "toolMgtId",
			fields: {
				toolUseQty : { type: "int" },
				toolUseStart : { type: "date" },
				toolUseEnd : { type: "date" },
				toolUseDesc : { type: "string" },
				prodWorkId : { type: "string" },
				toolId : { type: "string" },
				toolMgtId : { type: "string" },
				eqmtMgtId : { type: "string" },
				eqipId : { type: "string" },
				lotId : { type: "string" }
			}
	};
	
	//6.
	lfo_popGrd.columns = [
		{field: "toolUseQty", format:"{0:n0}", attributes : { style : "text-align : right;"}, title:gfn_getMsg("col_toolUseQuan", "공구사용량"), width: "120px"},
		{field: "toolUseStart", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_useStart", "사용시작"), width: "160px"},
		{field: "toolUseEnd", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_useEnd", "사용종료"), width: "160px"},
		{field: "prodWorkId", title:gfn_getMsg("col_workInfoCd", "작업정보아이디"), width: "160px"},
		{field: "lotId", title:gfn_getMsg("col_lotCd", "LoT코드"), width: "160px"},
		{field: "toolUseDesc", title:gfn_getMsg("col_desc", "설명"), width: "250px"}
	];

	//공통 그리드 세팅 호출 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
}

</script>