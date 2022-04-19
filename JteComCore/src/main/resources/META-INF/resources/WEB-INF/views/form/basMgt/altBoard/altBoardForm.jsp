<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container-fluid">
	<div class="row onm-sc">
		<div class="col-sm-12">
			<div class="sr-listtb">
				<!--2019.06 화면 수정  -->
					<table class="ma-b-0 fix">
						<colgroup>
							<col width="6%">
							<col width="7%">
							<col width="15%">
							<col width="9%">
							<col width="15%">
							<col width="9%">
							<col width="15%">
							<col width="24%">
						</colgroup>
						<tr>
							<td class="al-l">검색구분</td>
							<td class="al-l padd-r-5"><div class="al-l" id="searchType" name="searchType"></div></td>
							<td class="al-l"><input type="text" id="searchValue" name="searchValue" maxlength="10" class="form-control"></td>
							<td class="al-r padd-r-20">게시종류&nbsp;</td>
							<td class="al-l"><div class="al-l" id="searchDivCd" name="searchDivCd"></div></td>
							<td class="al-r padd-r-20">작성일</td>
							<td class="al-l">
								<span class="fl-l"><input id="searchStartDate" name="searchStartDateTmp" title="datepicker"  class="wd-date searchStartDateTmp" /></span>
								<span class="bar">~</span>
								<span class="fl-l"><input id="searchEndDate" name="searchEndDateTmp" title="datepicker" class="wd-date searchEndDateTmp" /></span>
							</td>
							<td class="al-r">
								<button class="btn-typ-1" type="button" id="btnBoardSearch"><i class="fas fa-search"></i> 검색</button>
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>

	<div class="row content onm-gridwarp">
		<!-- style="border-bottom: 0 !important">-->
		<!-- 			<div class="col-sm-12">
				 조회후 하단검색결과 달아주세요. 디폴트 리스트일땐는 안나오는걸로...
				<button id="btnAltBoardInsert" class="btn-typ-3" type="button" style="float: right;" class="btn-typ-3 ma-b-5">글쓰기</button>
				<p class="al-l tit-s"><i class="fas fa-search"></i> 검색결과 <span class="onm-sernum"><font class="onm-col" id="search_title"></font>건이 검색되었습니다. </span></p>
				<div class="onm-list">
					<div id="gridAltBoardList"></div>
				</div>
			</div> -->
		<div class="col-sm-12">
			<p class="al-l tit-s">
				<i class="fas fa-search"></i> 검색결과<span class="onm-sernum"><font class="onm-col" id="search_title"></font>건이 검색되었습니다. </span>
			</p>
			 <!-- <div class=“bts-right”> -->
				<button class="bts-right btn-typ-3"  id="btnAltBoardInsert">글쓰기</button>
			<!-- </div>  -->
			<!-- <button id="btnAltBoardInsert" class="btn-typ-3" type="button" style="float: right;" class="btn-typ-3 ma-b-5">글쓰기</button> -->
			<div class="onm-list">
				<div id="gridAltBoardList"></div>
			</div>
		</div>

	</div>


	<div class="row content onm-detailwarp" id="altBoardDetailViewLayer"></div>


	<div class="row content onm-detailwarp" id="boardModify"
		style='overflow: hidden; padding: 0;' hidden>
		<form id="altBoardFrm" enctype="multipart/form-data" method="post"
			action="#" style="width: 100%; height: 100%">
			<input type="hidden" id="firstCretTrtrId" name="firstCretTrtrId">
			<input type="hidden" id="lastChgTrtrId" name="lastChgTrtrId">
			<!-- 수정자ID -->
			<input type="hidden" id="chgDt" name="chgDt">
			<!-- 수정시간 -->
			<input type="hidden" id="bdUrlsCnt" name="bdUrlsCnt">
			<!-- 참조개수 -->
			<input type="hidden" id="listBdUrlAddr" name="listBdUrlAddr">
			<!-- 참조경로들 -->
			<input type="hidden" id="bdFilesCnt" name="bdFilesCnt">
			<!-- 파일개수 -->
			<input type="hidden" id="listBdFilePath" name="listBdFilePath">
			<!-- 첨부파일경로들 -->
			<input type="hidden" id="listBdTgtAuthId" name="listBdTgtAuthId">
			<!-- 게시대상 권한그룹 -->
			<input type="hidden" id="listBdTgtId" name="listBdTgtId">
			<!-- 게시대상자ID들 -->
			<input type="hidden" id="efctStDt" name="efctStDt">
			<!-- 게시 유효시작일 -->
			<input type="hidden" id="efctFnsDt" name="efctFnsDt">
			<!-- 게시 유효 종료일 -->

			<div class="col-sm-12 ma-b-0 ma-t-10">
				<p class="al-l tit-s">
					<i class="fas fa-dot-circle"></i><b id="altBoardTitleView">&nbsp;글쓰기</b>
				</p>

				<div class="onm-list">

					<table class="tb-pro ma-t-5">
						<colgroup>
							<col width="7%">
							<col width="7%">
							<col width="7%">
							<col width="12%">
							<col width="7%">
							<col width="17%">
							<col width="7%">
							<col width="12%">
							<col width="7%">
							<col width="17%">
						</colgroup>
						<tr>
							<th class="tbonm al-c">글번호</th>
							<td class="tbonmtd al-c"><input class="form-control m-b-3"
								id="bdSeq" name="bdSeq" type="text" readonly></td>
							<th class="tbonm al-c">작성자</th>
							<td class="tbonmtd al-c"><input class="form-control m-b-3"
								id="bdOwnerNm" name="bdOwnerNm" type="text" readonly></td>
							<th class="tbonm al-c">생성일</th>
							<td class="tbonmtd al-c"><input class="form-control m-b-3"
								id="cretDt" name="cretDt" type="text" readonly></td>
							<th class="tbonm al-c">수정자</th>
							<td class="tbonmtd al-c"><input class="form-control m-b-3"
								id="bdEditorNm" name="bdEditorNm" type="text" readonly></td>
							<th class="tbonm al-c">수정일</th>
							<td class="tbonmtd al-c"><input class="form-control m-b-3"
								id="chgDt" name="chgDt" type="text" readonly></td>
						</tr>
						<tr>
							<th class="tbonm al-c" colspan="2">게 시 종 류</th>
							<td class="tbonmtd al-c" colspan="2"><input class="al-l"
								id="bdDivCd" name="bdDivCd" type="text"></td>
							<td class="al-r padd-r-20" colspan="2">게 시 유 효 기 간</td>
							<td class="al-l" colspan="4"><span><input
									id="efctStDate" name="efctStDateTmp" title="datepicker"
									class="w110px efctStDateTmp" /></span> <span> - </span> <span><input
									id="efctFnsDate" name="efctFnsDateTmp" title="datepicker"
									class="w110px efctFnsDateTmp" /></span></td>
						</tr>
						<tr>
							<th class="tbonm al-c">제 목</th>
							<td class="tbonmtd al-l" colspan="9"><textarea id="bdTitle"
									name="bdTitle" style="width: 100%" maxlength="1000" required
									validationMessage="제목은 필수입력값 입니다."></textarea></td>
						</tr>
						<tr>
							<th class="tbonm al-c">본 문</th>
							<td class="tbonmtd al-l" colspan="9"><textarea id="bdBody"
									name="bdBody" rows="10" cols="30"
									style="width: 100%; height: 300px" maxlength="32000" required
									validationMessage="제목은 필수입력값 입니다."></textarea></td>
						</tr>
						<!-- 							<tr> -->
						<!-- 								<th class="tbonm al-l">첨 부</th> -->
						<!-- 								<td class="tbonmtd al-l" colspan="7" id="bdFilesView"> -->
						<!-- 									<input type="file" name="listBdFileNm" id="listBdFileNm01" onchange="gfn_myTab().lfn_onChgformAltBoardFile(this)"/> -->
						<!-- 									<br/> -->
						<!-- 									<input type="file" name="listBdFileNm" id="listBdFileNm02" onchange="gfn_myTab().lfn_onChgformAltBoardFile(this)"/> -->
						<!-- 									<br/> -->
						<!-- 									<input type="file" name="listBdFileNm" id="listBdFileNm03" onchange="gfn_myTab().lfn_onChgformAltBoardFile(this)"/> -->
						<!-- 								</td> -->
						<!-- 							</tr> -->
						<tr>
							<th class="tbonm al-c">게 시<br />여 부
							</th>
							<td class="tbonmtd al-c" colspan="1"><input class="al-l"
								id="bdUseYn" name="bdUseYn" type="text"></td>
							<th class="tbonm al-c">첨 부<br />파 일
							</th>
							<td class="tbonmtd al-l" colspan="4" id="bdFilesView"><input
								type="file" name="listBdFile" id="listBdFileNm01"
								onchange="lfn_onChgformAltBoardFile(this)"> <br /> <input
								type="file" name="listBdFile" id="listBdFileNm02"
								onchange="lfn_onChgformAltBoardFile(this)"> <br /> <input
								type="file" name="listBdFile" id="listBdFileNm03"
								onchange="lfn_onChgformAltBoardFile(this)"></td>
							<td colspan="3">
								* 파일은 [허용된 파일 형식]만 저장 가능합니다.<br>
								* 등록할 파일명은 23자 미만으로만 등록 가능합니다.<br>
								* 파일명에 공백 및 특수기호를 사용할 수 없습니다.<br>
								* 첨부파일당 업로드 용량은 10MB 미만이어야 합니다.</td>
						</tr>
					</table>

				</div>
			</div>

		</form>

		<!-- <div class = "btn-right" style="width: 100%; margin: 0 auto;"> -->
		<div class = "btn-right">
			<button type="button" class="btn-typ-4" id="btnBoardPreView"
				style="display: none;" onclick="gfn_myTab().lfn_altBoardPreView();">미리보기</button>
			<button type="button" class="btn-typ-4" id="btnBoardSave">저장</button>
			<button type="button" class="btn-typ-4" id="btnBoardClose">취소</button>
		</div>
	</div>

	<form id="altBoardFileDownloadForm" method="post">
		<input type="hidden" id="bdSeq" name="bdSeq"> <input
			type="hidden" id="fileNm" name="fileNm"> <input type="hidden"
			id="filePath" name="filePath">
	</form>
	<iframe name="iframeAltBoardFileDownloadHidden" style="display: none;"></iframe>

	<div id='boardPopup' style='overflow: hidden; padding: 0;'></div>

</div>



<script type="text/javascript">

/**
 * /altBoard/altBoardForm
*/

this.lfn_init = function(data){
	
	$("#altBoardDetailViewLayer").hide();
	console.log("AltBoard Initialize Starting...");
	$("#btnBoardSearch").on("click", function(){
		lfn_boardDetailClear();
		lfn_fnSearch();
	});
	
	if(this.gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD')) {
		// 게시판 생성/수정/삭제 권한이 있는경우...
		$("#btnAltBoardInsert").on("click", function() {
			lfn_openBoardWriteForm("NEW", '');
		})
//		$("#btnBoardModify").on("click", function() {
//			lfn_openBoardWriteForm("EDT", $("#altBoardDetailView #bdSeq").html());
//		})
//		$("#btnBoardRemove").on("click", function() {
//			lfn_openBoardWriteForm("DEL", $("#altBoardDetailView #bdSeq").html());
//		})
	}else{
		// 조회권한만 있는경우...
		$("#btnAltBoardInsert").hide(); // 글쓰기 버튼삭제.
//		$("#btnBoardModify").hide(); // 글수정 버튼삭제.
//		$("#btnBoardRemove").hide(); // 글삭제 버튼삭제.
	}

	$("#searchType").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: [ {value:"T", text:"제목"}, {value:"O", text:"작성자"}, {value:"B", text:"본문"} ],
		enable:true
	});
	$("#searchType").data("kendoDropDownList").value("T");
	
	$("#searchDivCd").kendoDropDownList({
		dataTextField: "cdVal",
		dataValueField: "cdId",
		dataSource: [ {cdVal:"전체", cdId:null, selected:true} ].concat(gfn_getCode('biz.altBoardCd')),
		enable:true
	});
	$("#searchDivCd").data("kendoDropDownList").value(undefined);
	
	$("#searchValue").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_boardDetailClear();
			lfn_fnSearch();
		}
	});

	$("#searchEndDate").keyup(function(e) {
		if (e.keyCode == 13) {
			lfn_boardDetailClear();
			lfn_fnSearch();
		}
	});

	$("#searchType").keyup(function(e) {
		if (e.keyCode == 13) {
			$("#searchValue").setFocus();
		}
	});
	
	$("#searchStartDate").keyup(function(e) {
		if (e.keyCode == 13) {
			$("#searchEndDate").setFocus();
		}
	});
	
	//검색달력 초기화
	$("#searchStartDate").kendoDatePicker({  
		//value: 초기값지정,      
		format: "yyyy-MM-dd",
		parseFormats: ["yyyyMMdd"],
		animation: {close: {effects: "fadeOut zoom:out", duration: 300}
			, open: {effects: "fadeIn zoom:in", duration: 300}}
	}).data("kendoDatePicker");
	$("#searchEndDate").kendoDatePicker({  
		//value: 초기값지정,      
		format: "yyyy-MM-dd",
		parseFormats: ["yyyyMMdd"],
		animation: {close: {effects: "fadeOut zoom:out", duration: 300}
			, open: {effects: "fadeIn zoom:in", duration: 300}}
	}).data("kendoDatePicker");
	
	/*** 미리보기용 선행처리(동일View를 사용하므로 복사해서 최초 셋팅한다.) ***/
//	$("#boardPopup").html($("#altBoardDetailView").html());
	$("#boardPopup").hide();
	/*********************************************************************************
	 * 미리보기용 선행처리(등록/수정 윈도우내에서 미리보기 버튼 보이게 처리.)
	 * 적용여부 이후에 결정한다. 알림창을 사용할 경우 필요하다.
	 *********************************************************************************/
	$("#boardModify #btnBoardPreView").show()
	
	this.lfn_boardListInitGrid();
	//$("#searchType").attr("disabled", true);
}

this.lfn_boardListInitGrid = function(){
	var authGrpSetTemplate = this.gfn_hasAuth('AUTH_BASMGT_CODEMGT_SETGRPCODE') ? "<input type='button' value='수정' class='k-button' name='btnUpdate' width='100px' onclick=\"lfn_openGroupUpdateForm( '#: cdGroupId #', '#: cdGroupNm #', '#: cdGroupEngNm #', '#: srcSysCd #');\" />" : "";
	var authGrpDelTemplate = this.gfn_hasAuth('AUTH_BASMGT_CODEMGT_DELGRPCODE') ? "<input type='button' value='삭제' class='k-button' name='btnDelete' width='100px' onclick=\"lfn_codeGroupDelete( '#: cdGroupId #');\" />" : "";

	$("#gridAltBoardList").kendoGrid({
		dataSource: {
			transport: {
				read: {
					url : gfn_getUri('/form/operMgt/altBoard/getBoardList'),
					dataType : "json"
				},
				parameterMap: function(data, type){
					return {
						page: data.page,
						take: data.take,
						rows : data.pageSize,
						searchType : $("#searchType").val(), // 검색구분
						searchValue: $("#searchValue").val(), // 검색 값
						searchStartDate : $("#searchStartDate").val(), // 글생성 범위 시작일
						searchEndDate   : $("#searchEndDate").val(),    // 글생성 범위 종료일
						bdDivCd :$("#searchDivCd").val() // 게시판 종류 : ALT, POP
					};
				}
			},
			schema: {
				data: "rows",
				total: "count"
			},
			pageSize: 10,
			serverPaging: true,
			serverFiltering: false,
			serverSorting: false
		},
		change: this.lfn_onClick,
		selectable: true,
		resizable: true,
//		height: 542,
		filterable: false,
		sortable: false,
		pageable: {
			//refresh: true
		},
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		},
		dataBound: function(e) {
			console.log("이후 확인할것 !!! : \n" + e)
			var data = this.dataSource.view();
			if(data.length === 1){
				// 바인딩 후 최초 ROW를 클릭하게 해준다.
//				$("#listSysCd").val(data[0].srcSysCd);
//				$("#listCdGroupId").val(data[0].cdGroupId);
//				$("#codeList").data("kendoGrid").dataSource.read();
				
				var row = e.sender.tbody.find('tr:first');
				this.select(row);
				row.trigger('click');
			}
			var totalCont = $("#gridAltBoardList").data("kendoGrid").dataSource.total();
			$("#search_title").text(totalCont);
			$('#countdown').timeTo(3600);
			lfn_boardDetailClear(); // 상세화면 클리어.
		},
		columns: [
			// {hidden:true, field: "bdSeq", title:"게시글 일련번호"}
			{hidden:true, field: "firstCretTrtrId", title:"생성자ID"}
			,{hidden:true, field: "lastChgTrtrId", title:"수정자ID"}
			,{title:"No",width:35,attributes: { style: "text-align: center;" },headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'},template: "#=++record #"}
			,{title:"글번호",field: "bdSeq", width:50,attributes: { style: "text-align: center;" }, headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}
				, template : function(row) {
					var nowTime = new Date().getTime();
					if(gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD') && row.bdUseYn=='Y' && row.efctStDt < nowTime && nowTime <= row.efctFnsDt){
						return '<span style="color: red;" title="게시 진행중인 글입니다."><b>' + row.bdSeq + '</b></span>';
					}else if(gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD') && row.bdUseYn!='Y'){
						return '<span style="color: gray;" title="게시 중지중인 글입니다."><b>' + row.bdSeq + '</b></span>';
					}else if(gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD') && nowTime <= row.efctStDt){
						return '<span style="color: blue;" title="게시 예정(대기)중인 글입니다."><b>' + row.bdSeq + '</b></span>';
					}else if(gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD') && row.efctFnsDt <= nowTime){
						return '<span style="color: brown;" title="게시 기간이 종료된 글입니다."><b>' + row.bdSeq + '</b></span>';
					}else{
						return row.bdSeq;
					}
				}
			}
			,{hidden:!gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD'), field: "bdUseYnView", title:"게시여부", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, template : function(row) {return row.bdUseYn=='Y' ? '게시중':'중지중'}}
			,{hidden:true, field: "bdUseYn", title:"게시여부"}
				/*** 2019.09.06 SR로 "자료실"이 최상단에 추가되면서 게시종류를 모두에게 보이게 함. ***/
			,{/*hidden:!gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD'),*/ field: "bdDivCdView", title:"게시종류", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, template : function(row) {
				var bdDivCdView = gfn_getCode('biz.altBoardCd').filter(function(data){ return data.code === row.bdDivCd;});
				if(gfn_isEmpty(bdDivCdView) || bdDivCdView.length < 0 || gfn_isEmpty(bdDivCdView[0].name)) return "미구분";
				// if(row.bdDivCd=="WRN") return '<span style="color: red;"<b>' + bdDivCdView[0].name + '</b></span>';
				// if(row.bdDivCd=="POP") return '<span style="color: blue;"<b>' + bdDivCdView[0].name + '</b></span>';
				return bdDivCdView[0].name; }}
			,{hidden:true, field: "bdDivCd", title:"게시글종류"}
			,{hidden:true, field: "bdSttusCd", title:"진행상태", width: "15%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{field: "bdTitleView", title:"제 목", width: "60%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: left;"}, 
				template : function(row){
					var viewTag = "<a href='javascript:void(0);' onclick=\"lfn_viewBoardDetail('" + row.bdSeq + "')\"><pre style=\"font-size:12px;width:100%;margin:0;\">&nbsp;&nbsp;&nbsp;" + row.bdTitle + "</pre></a>";
					var viewTemplate = kendo.template(viewTag);
					// "<input type='button' value='수정' class='k-button' name='btnUpdate' width='100px' onclick=\"lfn_openGroupUpdateForm( '#: cdGroupId #', '#: cdGroupNm #', '#: cdGroupEngNm #', '#: srcSysCd #');\" />";
					return viewTemplate.call(self, row);
			}}
			,{hidden:true, field: "efctStDt", title:"게시시작일"}
			,{hidden:true, field: "efctFnsDt", title:"게시종료일"}
			,{field: "efctStDtView", title:"게시시작일", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, template : function(row) {if(row.efctStDt) return gfn_getDate(new Date(row.efctStDt), 'yyyy-MM-dd');return ""}}
			,{field: "efctFnsDtView", title:"게시종료일", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, template : function(row) {if(row.efctFnsDt) return gfn_getDate(new Date(row.efctFnsDt), 'yyyy-MM-dd');return ""}}
			,{field: "bdOwnerNm", title:"작성자", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{field: "bdEditorNm", title:"수정자", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{hidden:true, field: "bdTitle", title:"제 목"}
			,{hidden:true, field: "bdBody", title:"본 문"}
			,{hidden:true, field: "bdUrlsCnt", title:"참조개수", width: "20%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{hidden:true, field: "listBdUrlNm", title:"참조이름들"}
			,{hidden:true, field: "listBdUrlAddr", title:"참조경로들"}
			,{hidden:true, field: "bdFilesCnt", title:"파일개수", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{hidden:true, field: "listBdFileNm", title:"첨부파일이름들"}
			,{hidden:true, field: "listBdFilePath", title:"첨부파일경로들"}
			,{hidden:true, field: "listBdTgtAuthId", title:"게시대상 권한그룹"}
			,{hidden:true, field: "listBdTgtId", title:"게시대상자ID들"}
//			,{field: "firstCretTrtrId", title:"생성자", width: "20%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
//			,{field: "lastChgTrtrId", title:"수정자", width: "20%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{field: "cretDtView", title:"생성일시", width: "15%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, template : function(row) {return gfn_getDate(new Date(row.cretDt), 'yyyy-MM-dd hh:mm:ss')}}
			,{field: "chgDtView", title:"수정일시", width: "15%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, template : function(row) {if(row.chgDt) return gfn_getDate(new Date(row.chgDt), 'yyyy-MM-dd hh:mm:ss');return ""}}
			,{hidden:true, field: "cretDt", title:"생성일시"}
			,{hidden:true, field: "chgDt", title:"수정일시"}
//			,{field: "chgDt", title:"변경일시", width: "30%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
//			,{ title:"수정", width: "20%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, 
//				template : function(row){
//					var buttonTemplate = kendo.template(authGrpSetTemplate);
//					var data = {cdGroupId : row.cdGroupId, cdGroupNm : row.cdGroupNm, cdGroupEngNm : row.cdGroupEngNm, srcSysCd : row.srcSysCd};
//					return buttonTemplate.call(self, data);
//			}}
//			,{ title:"삭제", width: "20%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, 
//				template : function(row){
//					var buttonTemplate = kendo.template(authGrpDelTemplate);
//					var data = {cdGroupId : row.cdGroupId};
//					return buttonTemplate(data);
//			}}
		]
	});
}

this.lfn_boardDetailClear = function(){
	// document.getElementById("altBoardDetailView").innerHTML = "";
	$("#altBoardDetailViewLayer").hide();
}

this.lfn_fnSearch = function(){
	$("#gridAltBoardList").data("kendoGrid").dataSource.page(1);
}
/**
 * 그리드의 제목을 눌렀을때 반응.
 */
this.lfn_viewBoardDetail = function(bdSeq){
	let grid = $("#gridAltBoardList").data("kendoGrid");
	let selectedRowData = grid.dataItem(grid.select());
}

this.lfn_openBoardWriteForm = function(workCd, bdSeq){
	// workCd : NEW, EDT, DEL, ADD, SET  : 신규창 / 수정창 / 삭제수행 / 신규저장 / 수정저장.
	switch (workCd) {
	case "NEW":case "EDT":
		let title = workCd == "NEW" ? "게시글 등록하기" : "게시글 수정하기";
		var options = {modal:true, width: "900px", height: "650px", id:"boardModify", title:title, workCd:workCd, bdSeq:bdSeq
			, resizable:false, animation:{open :{effects:"expand:vertical fadeIn"},close :{effects:"expand:vertical fadeIn", reverse: true}}, actions:[/*"Minimize", "Maximize", */"Close"], callback:function(cbData){
				lfn_openBoardWritePopInit(cbData);
				// 창 오픈 후 콜백.
				cbData.height = ($("#"+cbData.target)[0].getElementsByClassName("btn-typ-4")[0].offsetTop + 55) + "px"; // 마지막 버튼의 위치로 윈도우의 크기를 계산해온다.
				var myWin = $("#"+cbData.target).kendoWindow().data("kendoWindow");
				myWin.setOptions(cbData);
				// myWin.center();
		}};
		this.gfn_winOpen(options);
		break;
	case "DEL":
		lfn_altBoardDelete(bdSeq);
		break;
	case "ADD":
		// 저장 validation 체크
		if (!lfn_saveValidation(workCd, bdSeq)) {
			return false;
		}
		lfn_saveAltBoard("/operMgt/altBoard/addBoard", workCd, bdSeq);
		break;
	case "SET":
		// 저장 validation 체크
		if (!lfn_saveValidation(workCd, bdSeq)) {
			return false;
		}
		lfn_saveAltBoard("/operMgt/altBoard/setBoard", workCd, bdSeq);
		break;
	case "RESET":
		// 저장 validation 체크
		if (!lfn_saveValidation(workCd, bdSeq)) {
			return false;
		}
		lfn_saveAltBoard("/operMgt/altBoard/resetBoard", workCd, bdSeq);
		break;
	default:
		break;
	}

}

// 그리드의 ROW를 선택할 경우. 또는 직접 그리드를 지정하여 구현할 수도 있다.
// 	var grid = $("#gridAltBoardList").data("kendoGrid");
// var bdSeq = grid.dataItem(grid.select()).bdSeq;
// $("#codeList").data("kendoGrid").dataSource.read({cdGroupId : cdGroupId});
/**
 * 그리드 Row를 클릭했을때 반응.
 */
this.lfn_onClick = function(e){
	var dataItem = this.dataItem(this.select());
	// DETAIL에 표시할것.
//	$("#altBoardDetailView #bdSeq").html(dataItem.bdSeq); // 글번호
//	$("#altBoardDetailView #bdUserId").val(dataItem.firstCretTrtrId); // 작성자ID
//	$("#altBoardDetailView #bdOwnerNm").html(dataItem.bdOwnerNm); // 작성자이름
//	$("#altBoardDetailView #bdEditorNm").html(dataItem.bdOwnerNm); // 수정자이름
//	$("#altBoardDetailView #bdSttusCd").html(dataItem.bdSttusCd); // 진행상태
//	$("#altBoardDetailView #cretDt").html(gfn_getDate(new Date(dataItem.cretDt), 'yyyy-MM-dd hh:mm:ss')); // .html(gfn_getDate(new Date(dataItem.cretDt), 'yyyy-MM-dd hh:mm:ss')); // 생성일
//	$("#altBoardDetailView #chgDt").html(gfn_isEmpty(dataItem.chgDt)?"":gfn_getDate(new Date(dataItem.chgDt), 'yyyy-MM-dd hh:mm:ss')); // .html(gfn_getDate(new Date(dataItem.cretDt), 'yyyy-MM-dd hh:mm:ss')); // 생성일
//	$("#altBoardDetailView #bdTitle").html(dataItem.bdTitle); // 제 목
//	$("#altBoardDetailView #bdBody").html(dataItem.bdBody); // 본 문
//	let altBdFilesView = "";
//	for (var i = 0; i < dataItem.bdFilesCnt; i++) {
//		altBdFilesView+="<br/><a href=\"javascript:void(0);\" onclick=\"lfn_altBoardFileDownload("+i+", '"+dataItem.bdSeq+"', '"+dataItem.listBdFileNm[i]+"', '"+dataItem.listBdFilePath[i]+"')\"><span>"+dataItem.listBdFileNm[i]+"</span></a>";
//	}
//	if(altBdFilesView!=null && altBdFilesView.startsWith("<br/>")){
//		altBdFilesView = altBdFilesView.substring(5);
//	}
//	$("#altBoardDetailView #bdFilesView").html(altBdFilesView); // 파일첨부
//	
//	$("#altBoardDetailView").attr("hidden", false); // 모두 셋팅하고 초후에 보여준다.
//	$("#altBoardDetailView").show(); // 모두 셋팅하고 최후에 보여준다.
////	$("#listCdGroupId").val(dataItem.cdGroupId);
////	$("#codeList").data("kendoGrid").dataSource.page(1);
	
	let option = gfn_objCopy(dataItem);
	option.id = "altBoardDetailViewLayer";
	option.url = "//../../om/static/bizNaru/common/popup/popupAltBoard";
	option.isDetail = true;
	gfn_setLayer(option, function(data){console.log(data);});
	$("#altBoardDetailViewLayer").show();
}

// workCd = NEW/EDT/DEL 에 따른 파업화면의 초기화를 진행한다.
this.lfn_openBoardWritePopInit = function(args){
	
	// 게시유효기간 초기화
	$("#altBoardFrm #efctStDate").attr("readonly", false);
	$("#altBoardFrm #efctFnsDate").attr("readonly", false);
	$("#altBoardFrm #efctStDate").kendoDatePicker({ //value: 초기값지정,
		format: "yyyy-MM-dd",
		parseFormats: ["yyyyMMdd"],
		animation: {close: {effects: "fadeOut zoom:out", duration: 300}
			, open: {effects: "fadeIn zoom:in", duration: 300}}
	}).data("kendoDatePicker");
	$("#altBoardFrm #efctFnsDate").kendoDatePicker({ //value: 초기값지정,      
		format: "yyyy-MM-dd",
		parseFormats: ["yyyyMMdd"],
		animation: {close: {effects: "fadeOut zoom:out", duration: 300}
			, open: {effects: "fadeIn zoom:in", duration: 300}}
	}).data("kendoDatePicker");
	$("#altBoardFrm #efctStDate").attr("readonly", true);
	$("#altBoardFrm #efctFnsDate").attr("readonly", true);
	// $("#altBoardFrm #efctStDate").prop("readonly", true); // 값을 직접수정하지 않게 한다.
	// $("#altBoardFrm #efctFnsDate").prop("readonly", true); // 값을 직접수정하지 않게 한다.

	// 재사용하는 form이므로 binding된것들을 해지한다. 다른것들도 해야하지만, click이벤트는 중복실행되면 안되므로.... 우선 click만...
	$("#btnBoardSave").off("click");

	$("#altBoardFrm #bdDivCd").kendoDropDownList({
		dataTextField: "cdVal",
		dataValueField: "cdId",
		dataSource: gfn_getCode('biz.altBoardCd'),
		select:function(e){
			console.log("select Event : " + e);
			if(e.dataItem.code === e.sender.element.val()) {
				e.preventDefault(); return; // 변경된것이 없으면 이벤트 처리를 멈춘다. 뒤에 따라오는 change이벤트를 실행하지 않는다.
			}
		},
		change:function(e){
			console.error("change Event : " + e);
			if(e.sender.element.val()=="ALT"){
				$("#altBoardFrm #efctFnsDate").data("kendoDatePicker").value(gfn_getDate(365));
			}else if(e.sender.element.val()=="POP"){
				$("#altBoardFrm #efctFnsDate").data("kendoDatePicker").value(gfn_getDate(5));
			}else if(e.sender.element.val()=="WRN"){
				$("#altBoardFrm #efctFnsDate").data("kendoDatePicker").value(gfn_getDate("9999-12-31"));
			}
		},
		enable:true
	});
	
	$("#btnBoardClose").on("click", function() {
		parent.$("#" + args.target).data("kendoWindow").close();
	})
	
	$("#altBoardFrm").kendoValidator({
		validateOnBlur: false
	});

	$("#altBoardFrm #altBoardTitleView").html("&nbsp;" + args.title); // 게시글 등록/수정하기.(input.box가 아니라 html을 사용함.)
	$("#altBoardFrm #firstCretTrtrId").val(gfn_getMyInfo().username);
	
	$("#altBoardFrm #lastChgTrtrId").val(gfn_getMyInfo().username); // 무조건 넣어주지만, 실제 입력과 수정에서 사용하는지는 서비스에서 처리한다.

	$("#altBoardFrm #bdUseYn").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: [ {value:"Y", text:"게시"}, {value:"N", text:"중지"} ],
		enable:true
	});
	$("#altBoardFrm #bdUseYn").data("kendoDropDownList").value("Y"); // 게시여부 

	var MAX_UPLOAD_FILE_CNT = 3;

	if(args.workCd=="NEW"){
		$("#altBoardFrm #bdSeq").val(''); // 글번호
//		$("#altBoardFrm #bdDivCd").val('ALT'); // 게시글종류
		$("#altBoardFrm #bdDivCd").data("kendoDropDownList").value("ALT"); // 게시종류 : 기본값 ALT(공지게시판)
		$("#altBoardFrm #efctStDate").data("kendoDatePicker").value(gfn_getDate());
		$("#altBoardFrm #efctFnsDate").data("kendoDatePicker").value(gfn_getDate(365));
		$("#altBoardFrm #bdUrlsCnt").val(0); // 참조개수
		$("#altBoardFrm #listBdUrlAddr").val(undefined); // 참조경로들
		$("#altBoardFrm #bdFilesCnt").val(0); // 파일개수
		$("#altBoardFrm #listBdFileNm").val(undefined); // 첨부파일이름들
		$("#altBoardFrm #listBdFilePath").val(undefined); // 첨부파일경로들
		$("#altBoardFrm #listBdTgtAuthId").val(undefined); // 게시대상 권한그룹
		$("#altBoardFrm #listBdTgtId").val(undefined); // 게시대상자ID들
		
		$("#altBoardFrm #bdOwnerNm").val(gfn_getMyInfo().name); // 작성자
		$("#altBoardFrm #bdEditorNm").val(undefined); // 수정자. 신규일경우 사용하지 않는다.
		$("#altBoardFrm #bdSttusCd").val('접수'); // 진행상태 : 접수 / 게시 / 완료 / 반려 / 취소 ???
		$("#altBoardFrm #cretDt").val(undefined); // 생성일
		$("#altBoardFrm #chgDt").val(undefined); // 수정일
		$("#altBoardFrm #bdTitle").val(''); // 제목
		$("#altBoardFrm #bdBody").val(''); // 본문

		let altBdFilesView = "";
		for (var i = 0; i < MAX_UPLOAD_FILE_CNT; i++) {
			altBdFilesView+="<br/><input type=\"file\" name=\"listBdFile\" id=\"listBdFileNm0"+(i+1)+"\" onchange=\"lfn_onChgformAltBoardFile(this)\">";
		}
		if(altBdFilesView!=null && altBdFilesView.startsWith("<br/>")){
			altBdFilesView = altBdFilesView.substring(5);
		}
		$("#altBoardFrm #bdFilesView").html(altBdFilesView); // 첨부파일 새롭게 그리기. 이전 신규저장내용이 남아있게된다.(그대로 사용하면...) 2019.09.23 점검시발견.

		$("#altBoardFrm #bdSeq").prop("disabled", true);// 값을 전달하지 않게 한다.

		$("#btnBoardSave").on("click", function() {
			lfn_openBoardWriteForm("ADD");
		});
		
	}else{ // "EDT"
		let grid = $("#gridAltBoardList").data("kendoGrid");
		let selectedRowData = grid.dataItem(grid.select());
		$("#altBoardFrm #bdSeq").val(selectedRowData.bdSeq); // 글번호
//		$("#altBoardFrm #bdDivCd").val(selectedRowData.bdDivCd); // 게시글종류
		$("#altBoardFrm #bdDivCd").data("kendoDropDownList").value(selectedRowData.bdDivCd); // 게시종류 : 기본값 ALT(공지게시판)
		$("#altBoardFrm #efctStDate").data("kendoDatePicker").value(new Date(selectedRowData.efctStDt));
		$("#altBoardFrm #efctFnsDate").data("kendoDatePicker").value(new Date(selectedRowData.efctFnsDt));
		$("#altBoardFrm #bdUrlsCnt").val(selectedRowData.bdUrlsCnt); // 참조개수
		$("#altBoardFrm #listBdUrlAddr").val(selectedRowData.listBdUrlAddr); // 참조경로들
		$("#altBoardFrm #bdFilesCnt").val(selectedRowData.bdFilesCnt); // 파일개수
		$("#altBoardFrm #listBdFileNm").val(selectedRowData.listBdFileNm); // 첨부파일이름들
		$("#altBoardFrm #listBdFilePath").val(selectedRowData.listBdFilePath); // 첨부파일경로들
		$("#altBoardFrm #listBdTgtAuthId").val(selectedRowData.listBdTgtAuthId); // 게시대상 권한그룹
		$("#altBoardFrm #listBdTgtId").val(selectedRowData.listBdTgtId); // 게시대상자ID들
		
		$("#altBoardFrm #bdOwnerNm").val(selectedRowData.bdOwnerNm); // 작성자
		$("#altBoardFrm #bdEditorNm").val(selectedRowData.bdEditorNm); // 수정자. 신규일경우 사용하지 않는다.
		$("#altBoardFrm #bdSttusCd").val(selectedRowData.bdSttusCd); // 진행상태
		$("#altBoardFrm #cretDt").val(gfn_getDate(new Date(selectedRowData.cretDt), 'yyyy-MM-dd hh:mm:ss')); // 생성일
		$("#altBoardFrm #chgDt").val(gfn_isEmpty(selectedRowData.chgDt)?"":gfn_getDate(new Date(selectedRowData.chgDt), 'yyyy-MM-dd hh:mm:ss')); // 수정일
		$("#altBoardFrm #bdTitle").val(selectedRowData.bdTitle); // 제목
		$("#altBoardFrm #bdBody").val(selectedRowData.bdBody); // 본문
		$("#altBoardFrm #bdUseYn").data("kendoDropDownList").value(selectedRowData.bdUseYn); // 게시여부

		let altBdFilesView = "";
		var fileCnt = 0;
		for (; fileCnt < selectedRowData.bdFilesCnt; fileCnt++) {
			let fileNm = selectedRowData.listBdFileNm[fileCnt];
			let fileTag = "<div><a href=\"javascript:void(0);\" onclick=\"lfn_togleFileContants(this,'D', "+fileCnt+", '"+selectedRowData.bdSeq+"', '"+fileNm+"', '"+selectedRowData.listBdFilePath[fileCnt]+"')\"><span class=\"ico_del\"></span>삭제&nbsp;:&nbsp;</a>"
					+ "<a href=\"javascript:void(0);\" onclick=\"lfn_altBoardFileDownload("+fileCnt+", '"+selectedRowData.bdSeq+"', '"+fileNm+"', '"+selectedRowData.listBdFilePath[fileCnt]+"')\"><span id=\"listBdFileNm0"+(fileCnt+1)+"\" title=\""+fileNm+"\" >"+lfn_getFileViewName(fileNm)+"</span></a>" +
					"</div>";
//			altBdFilesView += "<br/><input type=\"file\" name=\"listBdFile\" id=\"listBdFileNm0"+(fileCnt+1)+"\" value=\""+fileNm+"\" onchange=\"lfn_onChgformAltBoardFile(this, "+fileCnt+", '"+selectedRowData.bdSeq+"', '"+selectedRowData.listBdFilePath[fileCnt]+"')\">";
			altBdFilesView += "<br/>"+fileTag;
		}
		for (; fileCnt < MAX_UPLOAD_FILE_CNT; fileCnt++) {
			altBdFilesView += "<br/><input type=\"file\" name=\"listBdFile\" id=\"listBdFileNm0"+(fileCnt+1)+"\" onchange=\"lfn_onChgformAltBoardFile(this)\">";
//			let fileTag = "<div><input type=\"file\" name=\"listBdFile\" id=\"listBdFileNm0"+(fileCnt+1)+"\" onchange=\"lfn_onChgformAltBoardFile(this)\">&nbsp;" +
//			"<a href=\"javascript:void(0);\" onclick=\"lfn_togleFileContants(this,'C')\"><span class=\"ico_del\"></span>취소</span></div>";
//			altBdFilesView += "<br/>" + fileTag;
		}
		if(altBdFilesView!=null && altBdFilesView.startsWith("<br/>")){
			altBdFilesView = altBdFilesView.substring(5);
		}
		
		$("#altBoardFrm #bdFilesView").html(altBdFilesView); // 첨 부

		$("#altBoardFrm #bdSeq").prop("disabled", false);// 값을 전달하게 한다.
		/** 지정한속성의 컴포넌트들을 모두 제거하거나 살릴땐... **/
		// $("#altBoardFrm").find("input[type=text], input[type=checkbox], input[data-role=dropdownlist], select, textarea").prop("disabled", true);

		$("#btnBoardSave").on("click", function() {
			lfn_openBoardWriteForm("SET", args.bdSeq);
		});
		
	}
	
	$("#altBoardFrm #cretDt").prop("disabled", true); // 값을 전달하지 않게 한다. 항상(서버에서 처리됨.)
	$("#altBoardFrm #chgDt").prop("disabled", true); // 값을 전달하지 않게 한다. 항상(서버에서 처리됨.)
	
	$("#boardModify").attr("hidden", false);
}
this.lfn_getFileViewName = function(fileNm){
	if(fileNm.length>25){
		return fileNm.substring(0,12) + "...." + fileNm.substring(fileNm.length-8);
	}
	return fileNm;
}
this.lfn_togleFileContants = function(input, togleCd, fileCnt, bdSeq, fileNm, filePath){
	let addBdFileView = "";
	if(togleCd=='D'){
		addBdFileView = "<a href=\"javascript:void(0);\" onclick=\"lfn_togleFileContants(this,'C', "+fileCnt+", '"+bdSeq+"', '"+fileNm+"', '"+filePath+"')\"><span class=\"ico_del\"></span>취소&nbsp;:&nbsp;</a>"
				+ "<input type=\"file\" name=\"listBdFile\" id=\"listBdFileNm0"+(fileCnt+1)+"\" onchange=\"lfn_onChgformAltBoardFile(this)\">" 
				+ "<input type=\"hidden\" name =\"removeFilesPath\" value=\""+filePath+"\">";
	} else {
		addBdFileView = "<a href=\"javascript:void(0);\" onclick=\"lfn_togleFileContants(this,'D', "+fileCnt+", '"+bdSeq+"', '"+fileNm+"', '"+filePath+"')\"><span class=\"ico_del\"></span>삭제&nbsp;:&nbsp;</a>"
				+ "<a href=\"javascript:void(0);\" onclick=\"lfn_altBoardFileDownload("+fileCnt+", '"+bdSeq+"', '"+fileNm+"', '"+filePath+"')\"><span id=\"listBdFileNm0"+(fileCnt+1)+"\" title=\""+fileNm+"\" >"+lfn_getFileViewName(fileNm)+"</span></a>";
	}
	$(input).closest('div').html(addBdFileView);
}

this.lfn_altBoardDelete = function(bdSeq, userId){
	let conMsg = "게시글을 삭제 하시겠습니까?";
	if(gfn_getMyInfo().username!=$("#altBoardDetailViewLayer #bdUserId").val()){
		conMsg = "게시글을 게시중지 하시겠습니까?\n(생성자만 삭제할 수 있습니다.)";
	}
	gfn_conBox({msg:conMsg, yes:function(){
		gfn_loading(true);
		$.ajax({
			url: gfn_getUri('/form/operMgt/altBoard/removeBoard'),
			type: "POST",
			data: {bdSeq:bdSeq},
			success: function(data){
				gfn_loading(false);
				if(data.result){
					gfn_msgBox({msg:data.result});
					lfn_boardDetailClear(); // 상세화면 클리어.
					let nowPage = $("#gridAltBoardList").data("kendoGrid").pager.page();
					$("#gridAltBoardList").data("kendoGrid").dataSource.page(nowPage);
				}else{
					gfn_msgBox({msg:data.result});
				}
			}
		});
	}});
}

this.lfn_saveValidation = function(workCd, bdSeq){
	// 저장 validation 체크
	var formNm = "altBoardFrm";
	var $frm = $("#" + formNm);
	if (gfn_isEmpty($("#altBoardFrm #bdTitle").val()) || $("#altBoardFrm #bdTitle").val().length < 3){
		gfn_msgBox({msg:"제목을 3자이상 입력해야 합니다."});
		return false;
	}
	if (gfn_isEmpty($("#altBoardFrm #bdBody").val()) || $("#altBoardFrm #bdBody").val().length < 10) {
		gfn_msgBox({msg:"본문을 10자이상 입력해야 합니다."});
		return false;
	}
	if(gfn_chkByteLen($("#altBoardFrm #bdTitle").val(), "UTF-8")>1000) {
		gfn_msgBox({msg:"제목은 1,000자 이내로 입력해주세요. [한글 333자]"}); // UTF-8기준으로 Ascii 1000자 초과 한글기준 333자 초과 시 진행불가.
		return false;
	}
	if(gfn_chkByteLen($("#altBoardFrm #bdBody").val(), "UTF-8")>32000) {
		gfn_msgBox({msg:"본문은 32,000자 이내로 입력해주세요. [한글 10,666자]"}); // UTF-8기준으로 Ascii 32,000자 초과 한글기준 10,666자 초과 시 진행불가.
		return false;
	}
	// $frm.find("[name=billAccId]").val("...");
	return true;
}

this.lfn_saveAltBoard = function(url, workCd, bdSeq){
	// 저장전 전달할 값들을 정리함.
	$("#altBoardFrm #efctStDt").val($("#altBoardFrm #efctStDate").data("kendoDatePicker").value());
	$("#altBoardFrm #efctFnsDt").val($("#altBoardFrm #efctFnsDate").data("kendoDatePicker").value());
	$("#altBoardFrm #efctStDate").prop("disabled", true); // 값을 전달하지 않게 한다.
	$("#altBoardFrm #efctFnsDate").prop("disabled", true); // 값을 전달하지 않게 한다.
	
	let saveFn = function(){
		$("#altBoardFrm").ajaxSubmit({
			url : gfn_getUri(url),
			dataType : "json",
			type : "post",
			success : function(data) {
				let showMsgObj={};
				if (!data || !data.result || data.result < 1) {
					if(workCd=="ADD"){
						showMsgObj.msg = "게시글 등록이 저장되지 않았습니다.";
					}else{
						showMsgObj.msg = "게시글 변경이 저장되지 않았습니다.";
					}
				} else{
					if(workCd=="ADD"){
						showMsgObj.msg = "신규 게시글 등록이 저장되었습니다.";
					}else{
						showMsgObj.msg = "["+data.bdSeq+"]번 게시글 변경이 저장되었습니다.";
					}
					showMsgObj.done = function() {
						// refresh ... 
						lfn_boardDetailClear(); // 상세화면 클리어.
						let nowPage = $("#gridAltBoardList").data("kendoGrid").pager.page();
						$("#gridAltBoardList").data("kendoGrid").dataSource.page(nowPage);
						$("#boardModify #btnBoardClose").trigger("click"); // 저장/수정창을 닫는다.
					}
				}
				gfn_msgBox(showMsgObj);
			}/*, error : function(request) {
				console.error(request);
				gfn_msgBox({msg:"게시글 저장에 실패했습니다."});
			}*/});
	}
	let conMsg = workCd == "ADD" ? "새로운 게시글을 등록하시겠습니까?" : "["+bdSeq+"]번 게시글을 수정 하시겠습니까?";
	gfn_conBox({msg:conMsg, yes:saveFn, done:function(){
		// 호출 후 수정창 원복.
		$("#altBoardFrm #efctStDate").prop("disabled", false); // 값을 수정할 수 있도록 원복.
		$("#altBoardFrm #efctFnsDate").prop("disabled", false); // 값을 수정할 수 있도록 원복.
	}});
}

this.lfn_altBoardFileDownload = function(fileCnt, bdSeq, bdFileNm, bdFilePath){
	console.log(arguments);
	$.ajax({url: gfn_getUri("/operMgt/altBoard/file/download/check")
		, data:{bdSeq:bdSeq, fileNm:bdFileNm, filePath:bdFilePath}
		, success:function(data){
			console.log(JSON.stringify(data));
			if(data.result){
				$("#altBoardFileDownloadForm #bdSeq").val(bdSeq);
				$("#altBoardFileDownloadForm #fileNm").val(bdFileNm);
				$("#altBoardFileDownloadForm #filePath").val(bdFilePath);
				$("#altBoardFileDownloadForm").attr("target", "iframeAltBoardFileDownloadHidden");
				$("#altBoardFileDownloadForm").attr("action", gfn_getUri("/operMgt/altBoard/file/download"));
				$("#altBoardFileDownloadForm").submit();
			} else {
				gfn_msgBox({msg:data.msg});
			}
		}});
}

this.lfn_onChgformAltBoardFile = function(file, fileCnt, bdSeq, bdFilePath){
	console.log("upload file is changed... : " + arguments);
	return lfn_onChgFileChk(file);
}

this.lfn_altBoardPreView = function(){
	let listBdFileNm = [];
	for (var i = 1; i <= 3; i++) {
		let fileNm = $("#altBoardFrm #listBdFileNm0"+i).attr("title");
		if(gfn_isEmpty(fileNm)){
			fileNm = $("#altBoardFrm #listBdFileNm0"+i).val();
			if(gfn_isEmpty(fileNm)){
				fileNm = $("#altBoardFrm #listBdFileNm0"+i).html();
			}
		}
		if(!gfn_isEmpty(fileNm)){
			listBdFileNm.push(fileNm);
		}
	}
	let options = {modal:true, width: "900px", height: "630px", id:"boardPopup" /*"_comn_popup_layer", "_commonPopup"*/
		, url:"//../../om/static/bizNaru/common/popup/popupAltBoard", resizable:false, animation:{open :{effects:"expand:vertical fadeIn"},close :{effects:"expand:vertical fadeIn", reverse: true}}
		, title:"미 리 보 기", actions:[/*"Minimize", "Maximize", */"Close"]
		, callback:function(cbData){
//			// 창 오픈 후 콜백.
//			let bdSeq = $("#altBoardFrm #bdSeq").val();
//			if(gfn_isEmpty(bdSeq))
//				bdSeq = "00";
//			$("#" + cbData.target + " #bdSeq").html(bdSeq); // 글번호
//			$("#" + cbData.target + " #bdOwnerNm").html($("#altBoardFrm #bdOwnerNm").val()); // 작성자
//			$("#" + cbData.target + " #bdEditorNm").html($("#altBoardFrm #bdEditorNm").val()); // 수정자
//			$("#" + cbData.target + " #bdSttusCd").html($("#altBoardFrm #bdSttusCd").val()); // 진행상태
//			let cretDt = $("#altBoardFrm #cretDt").val();
//			if(gfn_isEmpty(cretDt))
//				cretDt = gfn_getDate(new Date(), 'yyyy-MM-dd hh:mm:ss');
//			$("#" + cbData.target + " #cretDt").html(cretDt); // .html(gfn_getDate(new Date(dataItem.cretDt), 'yyyy-MM-dd hh:mm:ss')); // 생성일
//			$("#" + cbData.target + " #chgDt").html($("#altBoardFrm #chgDt").val()); // .html(gfn_getDate(new Date(dataItem.cretDt), 'yyyy-MM-dd hh:mm:ss')); // 수정일
//			$("#" + cbData.target + " #bdTitle").html($("#altBoardFrm #bdTitle").val()); // 제 목
//			$("#" + cbData.target + " #bdBody").html($("#altBoardFrm #bdBody").val()); // 본 문
//			let altBdFilesView = "";
//			for (var i = 1; i < 3; i++) {
//				let fileNm = $("#altBoardFrm #listBdFileNm0"+i).val();
//				if(gfn_isEmpty(fileNm)){
//					fileNm = $("#altBoardFrm #listBdFileNm0"+i).html();
//				}
//				if(!gfn_isEmpty(fileNm)){
//					altBdFilesView+="<br/><a href=\"javascript:void(0);\"><span>"+fileNm.split("\\").pop()+"</span></a>";
//				}
//			}
//			if(altBdFilesView!=null && altBdFilesView.startsWith("<br/>")){
//				altBdFilesView = altBdFilesView.substring(5);
//			}
//			$("#" + cbData.target + " #bdFilesView").html(altBdFilesView); // 파일첨부
//			$("#" + cbData.target + " #altBoardDetailView").attr("hidden", false); // 모두 셋팅하고 최후에 보여준다.
//			$("#" + cbData.target + " #altBoardDetailView").show(); // 모두 셋팅하고 최후에 보여준다.
//			$("#" + cbData.target + " #btnBoardModify").hide();
//			$("#" + cbData.target + " #btnBoardRemove").html("닫 기");
//			$("#" + cbData.target + " #btnBoardRemove").on("click", function() {
//				parent.$("#"+cbData.target).data("kendoWindow").close();
//			});
//			$("#boardPopup").show();
			
			// 창 오픈 후 콜백.
			cbData.height = ($("#"+cbData.target)[0].getElementsByClassName("btn-typ-4")[0].offsetTop + 55) + "px"; // 마지막 버튼의 위치로 윈도우의 크기를 계산해온다.
			var myWin = $("#"+cbData.target).kendoWindow().data("kendoWindow");
			myWin.setOptions(cbData);
			// myWin.center();
			console.log("PreViewWindowsOpened... : " + cbData);
		}, closeCallback:function(cbData){
			// 창 닫은 후 콜백.
			console.log("PreViewWindowsClosed... : " + cbData);
		}
		
		, bdSeq:$("#altBoardFrm #bdSeq").val()
		, bdOwnerNm:$("#altBoardFrm #bdOwnerNm").val() // 작성자
		, bdEditorNm:$("#altBoardFrm #bdEditorNm").val() // 수정자
		, bdSttusCd:$("#altBoardFrm #bdSttusCd").val() // 진행상태
		, cretDt:$("#altBoardFrm #cretDt").val() // .html(gfn_getDate(new Date(dataItem.cretDt), 'yyyy-MM-dd hh:mm:ss')); // 생성일
		, chgDt:$("#altBoardFrm #chgDt").val() // .html(gfn_getDate(new Date(dataItem.cretDt), 'yyyy-MM-dd hh:mm:ss')); // 수정일
		, bdTitle:$("#altBoardFrm #bdTitle").val() // 제 목
		, bdBody:$("#altBoardFrm #bdBody").val() // 본 문
		, listBdFileNm:listBdFileNm // 첨부파일 리스트.
		, isPreView:true // 미리보기 여부.
		
		};
	gfn_winOpen(options);
}

/*** 실제 처리는 서비스에서 해야하나 화면에서 먼저 처리함.(공통에서 수용안되므로 - 현재까지는) 이외 확장자등의 처리는 공통서비스에서 처리됨. ***/
this.lfn_onChgFileChk = function(file){
	if(file){
		if(file.files[0].size / 1024 / 1024 > 10){
			gfn_msgBox({msg : "업로드 최대 사이즈는 10MB입니다. 파일 사이즈 확인해 주세요."});
			$(file).val("");
			return false;
		}
	}
}

</script>

