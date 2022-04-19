<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="grid-content"  style="width:100%;">
	<div id="jteSingleGrid" style="width:height:100%;"></div>
</div>

<!-- 전주원 주임 작업 CSS -->
<link href='/resources/mes/css/contents/facilMgt/facilCorMgt/facilCorMgtForm_JJW.css' rel="stylesheet">


<script>

var lfo_common = {};//Form 내부에서 사용될 Object 

//진입 이벤트(공통코드에서 실행)
this.lfn_init = function(){
	//그리드 생성
	lfn_jteSgGrd_setGrd();
};

//서브 그리드 세팅
this.lfn_jteSgGrd_setGrd = function(){
	lfo_common = {};//Form 내부에서 사용될 Object 

	lfo_common.layoutId = "jteSingleGrid";
	
	//lfo_common.popId = "";
	
	lfo_common.ctrlUrl = "/form/perform/facilStaMgt/facilTotalEff";
	
	lfo_common.crud  = {
		read:{url:"/getEqmtMgtList", auth:"", search: false, refresh: false, prmt:{}, dynamicPrmt:{eqmtWorkStart:"hidEqmtWorkStart"}}
	};
	
	lfo_common.customTitle = {html:"<input id='eqmtWorkStart' name='eqmtWorkStart' />"+
			"<input type='hidden' id='hidEqmtWorkStart' name='hidEqmtWorkStart'>"
			, callback : lfn_jteWorkDate_set};
	
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
			creatorId : { type: "string" },
			createdAt : { type: "string" },
			updatorId : { type: "string" },
			updatedAt : { type: "string" },
			placeId : { type: "string" },
			placeNm : { type: "string" },
			compId : { type: "string" },
			compNm : { type: "string" },
			eqmtWorkStart: { type: "date" },
			eqmtWorkEnd: { type: "date" },
			runTime : { type: "string"},
			eqmtPercent : { type: "float"}
		}
	};
	
	lfo_common.columns = [
		{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: "160px"},												//설비개별코드
		{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: "160px"},												//설비명
		{field: "eqmtWorkStart", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_eqmtWrkStart"), width: "170px"},		//설비가동시작
		{field: "eqmtWorkEnd", format:"{0: yyyy-MM-dd HH:mm:ss}", title:gfn_getMsg("col_eqmtWrkEnd"), width: "170px"},			//설비가동종료
		{field: "runTime", title:"설비가동시간", width:"160px"},
		{field: "eqmtPercent", title:"설비종합효율", format: "{0:0.0'%'}", width:"140px"},
	];

	//공통 그리드 세팅 호출 
	lfo_common.grid = gfn_grid_set(lfo_common);
}
this.lfn_jteWorkDate_set = function(){
	//초기 오늘 데이터를 매핑
	if($("#eqmtWorkStart").attr("data-role") != "datepicker"){
		$("#eqmtWorkStart").kendoDatePicker({
			culture:"ko-KR",
			format : 'yyyy-MM-dd',
			value : new Date(),
			change : function(){
				$("#hidEqmtWorkStart").val($("#eqmtWorkStart").val());
				lfo_common.grid.dataSource.read();
			}
		});
	}
	$("#hidEqmtWorkStart").val($("#eqmtWorkStart").val());
}

</script>