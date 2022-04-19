<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container-fluid">
	<div class="row onm-sc">
		<div class="col-sm-12">
			<div class="sr-listtb">
				<!--2019.06 화면 수정  -->
					<table class="ma-b-0 fix">
						<colgroup>
							<col width="6%">
							<col width="30%">
							<col width="6%">
							<col width="7%">
							<col width="6%">
							<col width="9%">
							<col width="6%">
							<col width="22%">
							<col width="8%">
						</colgroup>
						<tr>
							<td class="al-l">검색위치</td>
							<td class="al-l"><input type="text" id="searchValue" name="searchValue" class="form-control" title="전체경로 또는 WEB_APP 실행기준 상대경로을 입력하세요."></td>
							<td class="al-r padd-r-20">대상서버&nbsp;</td>
							<td class="al-l"><div class="al-l" id="searchSvrAddr" name="searchSvrAddr" value="" title="검색대상 서버IP 또는 주소를 입력합니다."></div></td>
							<td class="al-r padd-r-20">문자셋&nbsp;</td>
							<td class="al-l"><div class="al-l" id="searchType" name="searchType" value="UTF-8" title="검색대상 DIR 또는 파일내부를 볼때 지정된 문자셋을 사용합니다.">UTF-8</div></td>
							<td class="al-r padd-r-20">속성&nbsp;</td>
							<td class="al-l"><input type="text" id="resultType" readonly class="form-control" value="" title="검색대상 DIR의 속성이 표시됩니다.[DHWRX]"></td>
							<td class="al-r padd-r-20">소유권&nbsp;</td>
							<td class="al-l"><input type="text" id="resultOwner" readonly class="form-control" value="" title="검색대상 DIR의 소유권정보가 표시됩니다."></td>
							<td class="al-r">
								<button class="btn-typ-1" type="button" id="btnBoardSearch"><i class="fas fa-search"></i> 검색</button>
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>



	<div class="row content onm-detailwarp" id="sysCtrlDetailViewLayer">
			<!-- <div class="col-sm-12 ma-b-15 ma-t-10"> -->
			<div class="col-sm-12 ma-t-10">
				<p class="al-l tit-s">
					<i class="fas fa-dot-circle"></i> 파일상세보기<span class="onm-sernum">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<i class="fas fa-search"></i> 파일이름 :<span class="onm-sernum"><font class="onm-col" id="sysCtrlDetailViewFileNm"></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<i class="fas fa-search"></i> 파일경로 :<span class="onm-sernum"><font class="onm-col" id="sysCtrlDetailViewPath"></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<i class="fas fa-search"></i> 파일크기 :<span class="onm-sernum"><font class="onm-col" id="sysCtrlDetailViewSize"></font>&nbsp;Bytes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				</p>

				<div class="onm-list">

					<table class="tb-pro ma-t-5">
						<colgroup>
							<col width="7%">
							<col width="13%">
							<col width="7%">
							<col width="13%">
							<col width="7%">
							<col width="13%">
							<col width="7%">
							<col width="13%">
							<col width="7%">
							<col width="13%">
						</colgroup>
						<tr>
							<th class="tbonm al-c">파일속성</th>
							<td class="tbonmtd al-c" id="sysCtrlDetailType"></td>
							<th class="tbonm al-c">소유권정보</th>
							<td class="tbonmtd al-c" id="sysCtrlDetailOwner"></td>
							<th class="tbonm al-c">생성일</th>
							<td class="tbonmtd al-c" id="sysCtrlDetailCretDt"></td>
							<th class="tbonm al-c">수정일</th>
							<td class="tbonmtd al-c" id="sysCtrlDetailChgDt"></td>
							<th class="tbonm al-c">접근일</th>
							<td class="tbonmtd al-c" id="sysCtrlDetailAccDt"></td>
							
						</tr>
						<tr>
							<th class="tbonm al-c">읽기시작</th>
							<td class="tbonmtd al-c" id="sysCtrlDetailStart"></td>
							<th class="tbonm al-c">읽기종료</th>
							<td class="tbonmtd al-c" id="sysCtrlDetailEnd"></td>
							<th class="tbonm al-c">읽은길이</th>
							<td class="tbonmtd al-c" id="sysCtrlDetailLengh"></td>
							<th class="tbonm al-c">위치이동</th>
							<td class="tbonmtd al-c"><input type="text" id="sysCtrlDetailIndex" name="sysCtrlDetailIndex" class="form-control al-c"></td>
							<td class="tbonmtd al-c" colspan="2">
								<button class="btn-typ-3" id="btnSysCtrlDetailIndexForward">이전</button>&nbsp;
								<button class="btn-typ-3" id="btnSysCtrlDetailIndexReload">다음</button>&nbsp;
								<button class="btn-typ-3" id="btnSysCtrlDetailIndexTail">마지막</button>
							</td>
						</tr>
						<tr>
							<th class="tbonm al-c">내 용</th>
<!-- 							<td class="tbonmtd al-l" colspan="9"><pre id="sysCtrlDetailContents" name="sysCtrlDetailViewContents" rows="10" cols="30" style="font-size:12px;margin:0;width:100%;height:300px" tempmaxlength="10000" readonly></pre></td> -->
							<td class="tbonmtd al-l" colspan="9"><textarea id="sysCtrlDetailContents" name="sysCtrlDetailViewContents" rows="5" cols="30" style="font-size:12px;margin:0;width:100%;height:300px" tempmaxlength="10000" readonly></textarea></td>
						</tr>
						<tr>
							<th class="tbonm al-c">다 운 로 드</th>
							<td class="tbonmtd al-l" colspan="9" id="sysCtrlDetailDownload">
								<a href="javascript:void(0);" onclick="lfn_sysCtrlFileDownload('글번호', '파일이름')"><span>파일이름 01</span></a>
							</td>
						</tr>
						<tr>
							<th class="tbonm al-c"> 업 로 드</th>
							<td class="tbonmtd al-l" colspan="9" id="bdFilesView">
								<form id="sysCtrlFileUploadFrm" enctype="multipart/form-data" method="post" action="#" style="width: 100%; height: 100%">
									<input type="hidden" id="targetPath" name ="targetPath">
									<input type="file" name="fileUpload" id="fileUpload">
									<a href="javascript:void(0);" id="fileUploadAction"><span>파일업로드</span></a>
								</form>
							</td>
						</tr>
						<tr>
							<th class="tbonm al-c">파 일 삭 제</th>
							<td class="tbonmtd al-l" colspan="9" id="sysCtrlDetailDelete">
								<a href="javascript:void(0);" onclick="lfn_sysCtrlFileDownload('글번호', '파일이름')"><span>파일이름 01</span></a>
							</td>
						</tr>
					</table>
				</div>
			</div>
	</div>



	<div class="row content onm-gridwarp">
		<div class="col-sm-12">
			<p class="al-l tit-s">
				<i class="fas fa-search"></i> 검색결과<span class="onm-sernum"><font class="onm-col" id="search_title">0</font>건이 검색되었습니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<i class="fas fa-search"></i> 현재경로 :<span class="onm-sernum"><font class="onm-col" id="searchPath">.</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<i class="fas fa-search"></i> 상위경로 :<span class="onm-sernum"><font class="onm-col" id="searchUpPath">..</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<i class="fas fa-search"></i> 대상서버 :<span class="onm-sernum"><font class="onm-col" id="searchSvrInfo">..</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</p>
			<button class="bts-right btn-typ-3" id="btnSearchParent">상위폴더</button>
			<div class="onm-list">
				<div id="gridSysCtrlList"></div>
			</div>
		</div>

	</div>


	<form id="sysCtrlFileDownloadForm" method="post">
		<input type="hidden" id="fileNm" name="fileNm"> <input type="hidden" id="filePath" name="filePath">
	</form>
	<iframe name="iframeSysCtrlFileDownloadHidden" style="display: none;"></iframe>

	<div id='boardPopup' style='overflow: hidden; padding: 0;'></div>

</div>



<script type="text/javascript">
/**
 * /sysCtrl/sysCtrlForm
*/

this.lfn_init = function(data){
	
	$("#sysCtrlDetailViewLayer").hide();
	console.log("SysCtrlForm Initialize Starting...");
	$("#btnBoardSearch").on("click", function(){
		lfn_boardDetailClear();
		lfn_fnSearch();
	});
	
	$("#searchSvrAddr").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: [ {value:"UTF-8", text:"UTF-8"}, {value:"EUC-KR", text:"EUC-KR"}, {value:"MS949", text:"MS949"} ],
		enable:true
		/***********************************
			optionLabel : {text : "전체", value : ""},
			dataSource : { data : gfn_getCode("70044"), filter : {field : "expnsnStrVal1", operator : "eq", value : "01"}},
		 */
	});
	$("#searchType").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: [ {value:"UTF-8", text:"UTF-8"}, {value:"EUC-KR", text:"EUC-KR"}, {value:"MS949", text:"MS949"} ],
		enable:true
	});
	$("#searchType").data("kendoDropDownList").value("UTF-8");
	
	$("#searchValue").keyup(function(e) {
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
	
	$("#btnSearchParent").on("click", function() {
//		var parentDir = $("#searchValue").val();// file://
//		if(!gfn_isEmpty(parentDir) && parentDir.length>3 && parentDir.lastIndexOf("/", parentDir.length-3)>1){
//			parentDir = parentDir.substring(0,parentDir.lastIndexOf("/", parentDir.length-3));
//		}
//		if(parentDir.endsWith(":")){
//			parentDir += "/";
//		}
		$("#searchValue").val($("#searchUpPath").html());
		lfn_boardDetailClear();
		lfn_fnSearch();
	});
	
	$("#btnSysCtrlDetailIndexForward").on("click", function() {
		lfn_getFileBody($("#sysCtrlDetailViewPath").html(), $("#sysCtrlDetailType").html(), ($("#sysCtrlDetailIndex").val()*1) - ($("#sysCtrlDetailLengh").html() * 2), $("#sysCtrlDetailViewFileNm").html());
	});
	$("#btnSysCtrlDetailIndexReload").on("click", function() {
		lfn_getFileBody($("#sysCtrlDetailViewPath").html(), $("#sysCtrlDetailType").html(), $("#sysCtrlDetailIndex").val(), $("#sysCtrlDetailViewFileNm").html());
	});
	$("#btnSysCtrlDetailIndexTail").on("click", function() {
		lfn_getFileBody($("#sysCtrlDetailViewPath").html(), $("#sysCtrlDetailType").html(), -1, $("#sysCtrlDetailViewFileNm").html());
	});
	
	$("#sysCtrlDetailViewLayer #fileUpload").on("onchange", function(e){
		lfn_onChgformFileUpload(e);
	});
	
	$("#sysCtrlDetailViewLayer #fileUploadAction").on("click", function(e){
		lfn_sysCtrlFileUpload(e);
	});
	
	
	lfn_boardListInitGrid();
	//$("#searchType").attr("disabled", true);
}

this.lfn_boardListInitGrid = function(){

	$("#gridSysCtrlList").kendoGrid({
		dataSource: {
			transport: {
				read: {
					url : gfn_getUri('/cform/sysLog/sysCtrl/getDir'),
					dataType : "json"
				},
				parameterMap: function(data, type){
					return {
						page: data.page,
						take: data.take,
						rows : data.pageSize,
						searchType : $("#searchType").val(), // 검색구분
						searchValue: $("#searchValue").val() // 검색 값
					};
				}
			},
			schema: {
				data: function(e){
					if(!gfn_isEmpty(e.info.path)) {
						// 지정된 DIR로 이동한 후 검색칸에 현재 조회된 Dir를 입력해준다..
						$("#searchValue").val(e.info.path);
						$("#searchPath").html(e.info.path);
					}
					if(!gfn_isEmpty(e.info.type)) {
						$("#resultType").val(e.info.type);
					}
					if(!gfn_isEmpty(e.info.owner)) {
						$("#resultOwner").val(e.info.owner);
					}
					if(!gfn_isEmpty(e.info.upPath)){
						$("#searchUpPath").html(e.info.upPath);
					}else{
						$("#searchUpPath").html("");
					}
					if(!gfn_isEmpty(e.svrInfo)){
						$("#searchSvrInfo").html(e.svrInfo); // JSON.stringify(e.svrInfo));
					}else{
						$("#searchSvrInfo").html("Unknown target server info.");
					}
					$("#btnBoardSearch").attr("disabled", false);
					$("#btnSearchParent").attr("disabled", false);
					if(e.result=='D'){
						return e.rows;
					}else{
						return null;
					}
				}
				// ,data: "rows"
				, total: "count"
			}
			, pageSize: 25
			, serverPaging: true
			, serverFiltering: false
			, serverSorting: false
		},
//		change: this.lfn_onClick,
//		selectable: true,
//		resizable: true,
////		height: 542,
//		filterable: false,
//		sortable: false,
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
			var totalCont = $("#gridSysCtrlList").data("kendoGrid").dataSource.total();
			$("#search_title").text(totalCont);
			$('#countdown').timeTo(3600);
			lfn_boardDetailClear(); // 상세화면 클리어.
		},
		columns: [
			{field: "num", title:"No",width:35,attributes: { style: "text-align: center;" },headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}/*,template: "#=++record #"*/}
//			,{title:"글번호",field: "bdSeq", width:50,attributes: { style: "text-align: center;" }, headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}
//				, template : function(row) {
//					var nowTime = new Date().getTime();
//					if(gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD') && row.bdUseYn=='Y' && row.efctStDt < nowTime && nowTime <= row.efctFnsDt){
//						return '<span style="color: red;" title="게시 진행중인 글입니다."><b>' + row.bdSeq + '</b></span>';
//					}else if(gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD') && row.bdUseYn!='Y'){
//						return '<span style="color: gray;" title="게시 중지중인 글입니다."><b>' + row.bdSeq + '</b></span>';
//					}else if(gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD') && nowTime <= row.efctStDt){
//						return '<span style="color: blue;" title="게시 예정(대기)중인 글입니다."><b>' + row.bdSeq + '</b></span>';
//					}else if(gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD') && row.efctFnsDt <= nowTime){
//						return '<span style="color: brown;" title="게시 기간이 종료된 글입니다."><b>' + row.bdSeq + '</b></span>';
//					}else{
//						return row.bdSeq;
//					}
//				}
//			}
//			,{hidden:!gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD'), field: "bdUseYnView", title:"게시여부", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, template : function(row) {return row.bdUseYn=='Y' ? '게시중':'중지중'}}
//			,{hidden:true, field: "bdUseYn", title:"게시여부"}
//			,{hidden:!gfn_hasAuth('AUTH_OPERMGT_ALTBOARD_ABLECUD'), field: "bdDivCdView", title:"게시종류", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}, template : function(row) {
//				var bdDivCdView = gfn_getCode('N002000163').filter(function(data){ return data.code === row.bdDivCd;});
//				if(gfn_isEmpty(bdDivCdView) || bdDivCdView.length < 0 || gfn_isEmpty(bdDivCdView[0].name)) return "미구분"; return bdDivCdView[0].name; }}
//			,{hidden:true, field: "bdDivCd", title:"게시글종류"}
//			,{hidden:true, field: "bdSttusCd", title:"진행상태", width: "15%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{hidden:true, field: "path", title:"경 로"}
			,{field: "name", title:"대 상 이 름", width: "40%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: left;"}, 
				template : function(row){
					var viewTag = row.name;
					if(row.type.indexOf("D")==6){
//						viewTag = "<a href='javascript:void(0);' onclick=\"lfn_fnSearch( '#: path #', '#: type #', 0);\"><pre style=\"font-size:12px;width:100%;margin:0;color: brown;\" title='클릭하면 해당Dir로 이동합니다.'>&nbsp;&nbsp;&nbsp;" + row.name + "</pre></a>";
						viewTag = "<a href='javascript:void(0);' onclick=\"lfn_fnSearch( '"+row.path+"', '"+row.type+"', 0, '"+row.name+"');\"><pre style=\"font-size:12px;width:100%;margin:0;color: brown;\" title='클릭하면 ["+row.path+"] 로 이동합니다.'>&nbsp;&nbsp;" + row.name + "</pre></a>";
					}else if(row.type.indexOf("S")==6){
//						viewTag = "<a href='javascript:void(0);' onclick=\"lfn_fnSearch( '#: path #', '#: type #', 0);\"><pre style=\"font-size:12px;width:100%;margin:0;color: blue;\" title='심볼릭링크는 현재 지원하지 않습니다.'>&nbsp;&nbsp;&nbsp;" + row.name + "</pre></a>";
						viewTag = "<a href='javascript:void(0);' onclick=\"lfn_fnSearch( '"+row.path+"', '"+row.type+"', 0, '"+row.name+"');\"><pre style=\"font-size:12px;width:100%;margin:0;color: blue;\" title='심볼릭링크는 현재 DIR로만 지원합니다.'>&nbsp;&nbsp;" + row.name + "</pre></a>";
					}else{
//						viewTag = "<a href='javascript:void(0);' onclick=\"lfn_fnSearch( '#: path #', '#: type #', 0);\"><pre style=\"font-size:12px;width:100%;margin:0;color: gray;\" title='클릭하면 파일내용 일부를 봅니다.'>&nbsp;&nbsp;&nbsp;" + row.name + "</pre></a>";
						viewTag = "<a href='javascript:void(0);' onclick=\"lfn_fnSearch( '"+row.path+"', '"+row.type+"', 0, '"+row.name+"');\"><pre style=\"font-size:12px;width:100%;margin:0;color: gray;\" title='클릭하면 ["+row.path+"] 파일의 일부내용을 조회합니다.'>&nbsp;&nbsp;" + row.name + "</pre></a>";
					}
//					var viewTemplate = kendo.template(viewTag);
//					return viewTemplate({path:row.path, type:row.type});
					return viewTag;
					
			}}
			,{hidden:true, field: "path", title:"전 체 경 로", width: "30%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: left;"}
					, template : function(row){ return "<pre style=\"font-size:12px;width:100%;margin:0;\" title='" + row.path + "'>" + row.path + "</pre>";
			}}
			,{field: "type", title:"속성", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{hidden:true, field: "size", title:"크기", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{field: "sizeView", title:"크기", width: "10%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}}
			,{field: "owner", title:"소유정보", width: "30%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}
					, template : function(row){ return "<pre style=\"font-size:12px;width:100%;margin:0;\" title='" + row.owner + "'>" + row.owner + "</pre>";
			}}
			,{field: "creationTimeView", title:"생성일시", width: "15%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}
					, template : function(row) {return gfn_getDate(new Date(row.creationTime), 'yyyy-MM-dd hh:mm:ss')}}
			,{field: "lastModifiedTimeView", title:"수정일시", width: "15%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}
					, template : function(row) {if(row.lastModifiedTime) return gfn_getDate(new Date(row.lastModifiedTime), 'yyyy-MM-dd hh:mm:ss');return ""}}
			,{field: "lastAccessTimeView", title:"접근일시", width: "15%", headerAttributes: {'class':'tableHead tableHeadStyle biznaru-grid-th'}, attributes: {style: "text-align: center;"}
					, template : function(row) {if(row.lastAccessTime) return gfn_getDate(new Date(row.lastAccessTime), 'yyyy-MM-dd hh:mm:ss');return ""}}
//			,{hidden:true, field: "creationTime", title:"생성일시"}
//			,{hidden:true, field: "lastModifiedTime", title:"생성일시"}
//			,{hidden:true, field: "lastAccessTime", title:"수정일시"}
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
	// document.getElementById("sysCtrlDetailView").innerHTML = "";
	$("#sysCtrlDetailViewLayer").hide();
}

this.lfn_fnSearch = function(targetPath, type, index, fileNm){
	if(type=="Forbidden" || type=="UNKNOWN"){
		gfn_msgBox({msg:"대상 [" + targetPath + "] 은 이동할 수 없거나, 권한이 없습니다."});
		return;
	}
	if(!gfn_isEmpty(targetPath) && !gfn_isEmpty(type) && type.indexOf("F")>0){
		// 파일 일부보기.
		// alert("파일 일부를 보는 상세화면으로 간다. - 미구현");
		lfn_getFileBody(targetPath, type, index, fileNm);
		return;
	} else if(!gfn_isEmpty(targetPath)) {
		// 지정된 DIR로 이동.
		$("#searchValue").val(targetPath);
	}
	$("#btnBoardSearch").attr("disabled", true);
	$("#btnSearchParent").attr("disabled", true);
	// $("#gridSysCtrlList").data("kendoGrid").dataSource.read(); // 페이징이 없을때 가져오는 방법.
	$("#gridSysCtrlList").data("kendoGrid").dataSource.page(1);
}

this.lfn_getFileBody = function(targetPath, type, index, fileNm){
	
	if(!gfn_isEmpty(targetPath) && !gfn_isEmpty(type) && type.indexOf("F")>0){
		// $("#sysCtrlDetailViewLayer").hide();
		$("#sysCtrlDetailViewFileNm").html(fileNm);
		$("#sysCtrlDetailViewPath").html(targetPath);
		
		$.ajax({url: gfn_getUri('/cform/sysLog/sysCtrl/getDir')
			, data:{searchType:$("#searchType").val(), searchValue:targetPath, index:index}
			, dataType : "json"
			, success:function(data){
				console.log(JSON.stringify(data));
				if(!gfn_isEmpty(data.result) && data.result == "F"){
					console.log("파일을 표시한다.");
					$("#sysCtrlDetailViewFileNm").html(data.info.name);
					$("#sysCtrlDetailViewPath").html(data.info.path);
					// $("#sysCtrlDetailSize").val(data.size);
					$("#sysCtrlDetailViewSize").html(data.sizeView);
					// $("#sysCtrlDetailContents").html(data.contents);
					$("#sysCtrlDetailContents").val(data.contents);
					$("#sysCtrlDetailType").html(data.info.type);
					$("#sysCtrlDetailOwner").html(data.info.owner);
					$("#sysCtrlDetailCretDt").html(data.info.creationTime);
					$("#sysCtrlDetailChgDt").html(data.info.lastModifiedTime);
					$("#sysCtrlDetailAccDt").html(data.info.lastAccessTime);
					$("#sysCtrlDetailStart").html(data.index);
					$("#sysCtrlDetailEnd").html(data.index + data.readed);
					$("#sysCtrlDetailLengh").html(data.readed);
					$("#sysCtrlDetailIndex").val(data.index + data.readed);
					$("#sysCtrlDetailDownload").html("<a href=\"javascript:void(0);\" onclick=\"lfn_sysCtrlFileDownload('"+data.info.path+"', '"+data.info.type+"', 0, '"+data.info.name+"')\"><span>"+data.info.path+"</span></a>");
					$("#sysCtrlDetailDelete").html(data.info.path + " : <a href=\"javascript:void(0);\" onclick=\"lfn_sysCtrlFileDelete('"+data.info.path+"', '"+data.info.type+"', 0, '"+data.info.name+"')\"><span>삭제하기</span></a>");
					$("#sysCtrlDetailViewLayer #targetPath").val(data.info.upPath);
					$("#sysCtrlDetailViewLayer").show();
				} else {
					gfn_msgBox({msg:data.error});
					// $("#sysCtrlDetailContents").html("파일정보 호출이 정상적이지 않습니다.\n수신된 정보를 아래 나열합니다.\n\n----------------------------------------------------\n"+JSON.stringify(data));
					$("#sysCtrlDetailContents").val("파일정보 호출이 정상적이지 않습니다.\n수신된 정보를 아래 나열합니다.\n\n----------------------------------------------------\n"+JSON.stringify(data));
				}
				$("html, body").scrollTop(0); // 화면 가장 위로 이동하기.
			}});
	}

}

this.lfn_sysCtrlFileDownload = function(targetPath, type, index, fileNm){
	console.log(arguments);
	if(!gfn_isEmpty(targetPath) && !gfn_isEmpty(type) && type.indexOf("F")>0){
		$.ajax({url: gfn_getUri("/sysLog/sysCtrl/download/check")
			, data:{fileNm:fileNm, filePath:targetPath}
			, success:function(data){
				console.log(JSON.stringify(data));
				if(data.result){
					$("#sysCtrlFileDownloadForm #fileNm").val(fileNm);
					$("#sysCtrlFileDownloadForm #filePath").val(targetPath);
					$("#sysCtrlFileDownloadForm").attr("target", "iframeSysCtrlFileDownloadHidden");
					$("#sysCtrlFileDownloadForm").attr("action", gfn_getUri("/sysLog/sysCtrl/download"));
					$("#sysCtrlFileDownloadForm").submit();
				} else {
					gfn_msgBox({msg:data.msg});
				}
			}});
	}
}

this.lfn_sysCtrlFileDelete = function(targetPath, type, index, fileNm){
	if(!gfn_isEmpty(targetPath) && !gfn_isEmpty(type) && type.indexOf("F")>0){
		let conMsg = "[" + targetPath + "] 대상파일을 삭제 하시겠습니까?";
		gfn_conBox({msg:conMsg, yes:function(){
//			gfn_loading(true);
//			$.ajax({
//				url: gfn_getUri('/form/sysLog/sysCtrl/removeFile'),
//				type: "POST",
//				data: {path:targetPath},
//				success: function(data){
//					gfn_loading(false);
//					if(data.result){
//						gfn_msgBox({msg:data.result});
//						lfn_boardDetailClear(); // 상세화면 클리어.
//						$("#gridSysCtrlList").data("kendoGrid").dataSource.read(); // Reload
//					}else{
//						gfn_msgBox({msg:data.result});
//					}
//				}
//			});
			gfn_msgBox({msg:"삭제는 아직 지원하지 않습니다."});
		}});
	}
}

/*** 실제 처리는 서비스에서 해야하나 화면에서 먼저 처리함.(공통에서 수용안되므로 - 현재까지는) 이외 확장자등의 처리는 공통서비스에서 처리됨. ***/
this.lfn_onChgformFileUpload = function(file){
	console.log("lfn_onChgformFileUpload : " + arguments);
	if(file){
		if(file.files[0].size / 1024 / 1024 > 10){
			gfn_msgBox({msg : "업로드 최대 사이즈는 10MB입니다. 파일 사이즈 확인해 주세요."});
			$(file).val("");
			return false;
		}
	}
}

this.lfn_sysCtrlFileUpload = function(e){
	console.log("lfn_sysCtrlFileUpload : " + arguments);
	gfn_conBox({msg:"파일 업로드를 수행하시겠습니까?\n(Overwrite불가)"
		, yes:function(data){
			gfn_msgBox({msg:"파일 업로드는 아직 지원하지 않습니다."});
			return;
			$("#sysCtrlFileUploadFrm").ajaxSubmit({
				url : gfn_getUri('/cform/sysLog/sysCtrl/uploadFile'),
				dataType : "json",
				type : "post",
				success : function(data) {
				}/*, error : function(request) {
					console.error(request);
					gfn_msgBox({msg:"게시글 저장에 실패했습니다."});
				}*/});
		}
		, done:function(){
			// 호출 후 항상 처리할 항목.
	}});
}



</script>

