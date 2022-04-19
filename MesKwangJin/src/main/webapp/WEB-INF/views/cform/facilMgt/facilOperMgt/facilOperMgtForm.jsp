<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content" >
<!-- 	<div class="mqsToolMgtForm search-btn-area" style="width:100%; background:#f0f5ff; padding:15px 0 15px 10px; margin:10px 0 5px 0;">
		<input id="eqmtMgtSelBox">
		<input type="hidden" id="eqmtMgtNm">
	</div> -->
	<div id="jteSingleGrid" ></div>
</div>
<link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_JJW.css' rel="stylesheet">

<script>

var lfo_common = {};

var lfo_eqmtWorkDate = {};

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteAggrDate_dateSave();
	
	lfn_selBoxBind();
};

this.lfn_selBoxBind = function(){
	var selBoxItem = new Array();
	
	$.ajax({
		async:false,
		url : "/cform/facilMgt/facilOperMgt/selectEqmtWorkList",
		type: "POST",
		data: { eqmtMgtId: $('#eqmtMgtId').val()},
		success: function(data){
			$.each(data.rows, function(index, item){
				selBoxItem[index] = {"eqmtMgtId": item.eqmtMgtId, "eqmtMgtNm": item.eqmtMgtNm};
			});
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	$("#eqmtMgtSelBox").kendoDropDownList({
		dataTextField: "eqmtMgtNm",
		dataValueField: "eqmtMgtId",
		dataSource: selBoxItem,
		index: 0,
		change: function(e) {
			$("#eqmtMgtNm").val(this.value());
			lfo_common.grid.dataSource.read();
		}
	});
	
	$("#eqmtMgtNm").val(selBoxItem[0].eqmtMgtNm);
	lfo_common.grid.dataSource.read();
}

//날짜 정보 매핑 후 그리드 로드
this.lfn_jteAggrDate_dateSave = function(){
	
	if(gfn_isNull(lfo_eqmtWorkDate.stdt) || gfn_isNull(lfo_eqmtWorkDate.eddt)){
		//현재날짜
		var nowDate = new Date();
		
		lfo_eqmtWorkDate.stdt = gfn_getDate(nowDate, -14, "yyyy-MM-dd");
		lfo_eqmtWorkDate.eddt = gfn_getDate(nowDate,"yyyy-MM-dd");
	}else{
		lfo_eqmtWorkDate.stdt = $("#searchStartDate").val();
		lfo_eqmtWorkDate.eddt = $("#searchEndDate").val();
	}
	
	//초기화
	$("#jteSingleGrid").html("");
	lfn_jteSgGrd_setGrd();
}

//기간검색을 위한 date 세팅
this.lfn_jteAggrDate_set = function(){
	
	//현재날짜
	var nowDate = new Date();
	
	//초기 이번달 1일 데이터 세팅(start)
	if($("#searchStartDate").attr("data-role") != "datepicker"){
		$("#searchStartDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_isNull(lfo_eqmtWorkDate.stdt) == true ? gfn_getDate(nowDate,"yyyy-MM-01") : lfo_eqmtWorkDate.stdt,
			change : function(){
				lfn_jteAggrDate_dateSave();
			}
		});
	}
	
	//초기 오늘날짜 세팅(end)
	if($("#searchEndDate").attr("data-role") != "datepicker"){
		$("#searchEndDate").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : gfn_isNull(lfo_eqmtWorkDate.eddt) == true ? gfn_getDate(nowDate,"yyyy-MM-dd") : lfo_eqmtWorkDate.eddt,
			change : function(){
				lfn_jteAggrDate_dateSave();
			}
		});
	}
}


//서브 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";

	//lfo_common.popId = "jtePopForm";

	lfo_common.ctrlUrl = "/cform/facilMgt/facilOperMgt";

	lfo_common.crud  = {
		read:{url:"/getEqmtOperList", auth:"", prmt:{"searchStartDate" : lfo_eqmtWorkDate.stdt, "searchEndDate" : lfo_eqmtWorkDate.eddt}, dynamicPrmt:{eqmtMgtId: "eqmtMgtId"}, search:false}
	};

	lfo_common.model = {
		id: "eqmtMgtId",
		fields: {
			eqmtMgtId : { type: "string" },
			eqmtMgtGbn : { type: "string" },
			eqmtMgtMtnc : { type: "int" },
			eqmtMgtNm : { type: "string" },
			eqmtMgtPurchase : { type: "date" },
			eqmtMgtVerif : { type: "date" },
			eqmtMgtDesc : { type: "string" },
			eqmtMgtFile : { type: "string" },
			isUse : { type: "bool" },
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" },
			eqmtWorkStart : { type: "date" },
			eqmtWorkEnd : { type: "date" }
		}
	};

	//커스텀 타이틀
	lfo_common.customTitle = {
		html:	'<span class="pop_title">' + "설비 : " + '</span>'+ 
		'<input id="eqmtMgtSelBox"><input type="hidden" id="eqmtMgtNm">'+
		'<span class="pop_title">' + "기간검색 : " + '</span>'+ 
		'<input id="searchStartDate" name="searchStartDate" /><span class="pop_title">' + "~" + '</span><input id="searchEndDate" name="searchEndDate" />',
		callback : lfn_jteAggrDate_set
	}
	
	lfo_common.columns = [
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm", "설비명"), width: "160px"},
		{field: "eqmtWorkStart", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_eqmtWorkStart", "설비가동 시작"), width: "150px"},
		{field: "eqmtWorkEnd", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_eqmtWorkEnd", "설비가동 종료"), width: "150px"}
	];
	
	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}

</script>