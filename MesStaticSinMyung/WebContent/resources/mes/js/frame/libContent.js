/* 
	1. gridObject.layoutId = gridId
	2. gridObject.popId = popId
	3. gridObject.ctrlUrl = 조회 url
	4. gridObject.crud= {
		read:{url:"",auth:"", prmt:{}}, 
		create:{url:"",auth:"",openFunc:function, callback:function}, 
		update:{url:"",auth:"",openFunc:function, callback:function}, 
		delete:{url:"",auth:"", callback:function}}
	5. gridObject.model = fieldType
	6. gridObject.columns = foeldColumns
	7. gridObject.selectBox = SelectBox 매핑 값 
*/

/*20200507 LYM&JJW 개별 디자인 적용을 위해 js에 있는 모든 readonly의 css 주석처리 (원본은 background:"#ebeff5",border:"1px solid #b6c2d1")*/
/*20200507 LYM&JJW 오류로 인해 js에 있는 모든 readonly의 css 주석처리 취소*/
/*20200508 LYM 테마에서 드롭다운에 readonly의 css가 적용되지 않는 오류 개선 -
   변경 전 : $(item).closest('.k-dropdown').find('.k-dropdown-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
   변경 후 : 	$(item).closest('.k-dropdown').css({background:"none"}); 
			$(item).closest('.k-dropdown').find('.k-dropdown-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"}); 
			$(item).closest('.k-dropdown').find('.k-dropdown-wrap').find('.k-input').css({background:"#ebeff5",color:"#333333"});
			$(item).closest('.k-dropdown').find('.k-dropdown-wrap').find('.k-select').find('.k-icon').css({color:"#333333"});*/

this.gfn_grid_set = function(gridObject){
	
	var lib_content = {};
	
	var readAuth = gfn_isEmpty(gridObject.crud.read) == true ? false : gfn_isEmpty(gridObject.crud.read.auth) == true ? true : gfn_hasAuth(gridObject.crud.read.auth);
	var createAuth = gfn_isEmpty(gridObject.crud.create) == true ? false : gfn_isEmpty(gridObject.crud.create.auth) == true ? true : gfn_hasAuth(gridObject.crud.create.auth);
	var updateAuth = gfn_isEmpty(gridObject.crud.update) == true ? false : gfn_isEmpty(gridObject.crud.update.auth) == true ? true : gfn_hasAuth(gridObject.crud.update.auth);
	var destroyAuth = gfn_isEmpty(gridObject.crud.destroy) == true ? false : gfn_isEmpty(gridObject.crud.destroy.auth) == true ? true : gfn_hasAuth(gridObject.crud.destroy.auth);
	var excelAuth = gfn_isEmpty(gridObject.crud.excel) == true ? false : gfn_isEmpty(gridObject.crud.excel.auth) == true ? true : gfn_hasAuth(gridObject.crud.excel.auth);
	
	//검색영역
	if(readAuth == false || gfn_isEmpty(gridObject.crud.read.search) == false || gridObject.crud.read.search == false){
		lib_content.searchAria = '';
	}else{
		lib_content.searchAria = '<span class="jte-search-aria"><label>'+gfn_getMsg("ui_search")+' : </label><input id=\"'+gridObject.layoutId+'_shSelBox\" style="width:140px;"/>'			//검색(UI)
		+'<input type=\"text\" id=\"'+gridObject.layoutId+'_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\" style="width:140px;"/>'					//조회(Input)
		+'<a role=\"button\" class=\"k-button k-button-icontext jte-search\"><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'			//조회버튼
		+'<input id=\"'+gridObject.layoutId+'_hidShSelBox\" type=\"hidden\">'
		+'<input id=\"'+gridObject.layoutId+'_hidShSelTxt\" type=\"hidden\">'
		+'<input id=\"'+gridObject.layoutId+'_hidSelected\" type=\"hidden\"></span>';
	}
	//기간검색
	if(readAuth == false || gfn_isEmpty(gridObject.crud.read.period) == true){
		lib_content.periodAria = '';
	}else{
		lib_content.periodAria = '<span class="jte-period_area" style="margin-left:5px;"><label>기간검색 : </label>'+
									'<input id=\"'+gridObject.layoutId+'_stdt\" style="width:120px;"/><input type="hidden" id=\"'+gridObject.layoutId+'_hidStdt\"/>'+
									' ~ <input id=\"'+gridObject.layoutId+'_eddt\" style="width:120px;" /><input type="hidden" id=\"'+gridObject.layoutId+'_hidEddt\"/></span>'
	}
	//추가버튼
	lib_content.addAria = createAuth == false ? '' : gfn_isEmpty(gridObject.crud.create.openFunc) == true ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-add\"><span class=\"k-icon k-i-plus\"></span>'+gfn_getMsg("btn_add")+'</a>';
	
	//삭제버튼
	lib_content.destroyAria = destroyAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-delete\"><span class=\"k-icon k-i-close\"></span>'+gfn_getMsg("btn_delete")+'</a>';

	//새로고침
	if(readAuth == false || gfn_isEmpty(gridObject.crud.read.refresh) == false || gridObject.crud.read.refresh == false){
		lib_content.refreshAria = '';
	}else{
		lib_content.refreshAria = readAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-refresh\"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';
	}
	//엑셀버튼
	lib_content.excelAria = excelAuth ==false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext k-grid-excel\"><span class=\"k-icon k-i-file-excel\"></span>'+gfn_getMsg("btn_excelDownload")+'</a>';
	
	//커스텀 타이틀 
	if(readAuth == false || gfn_isEmpty(gridObject.customTitle) == true || gfn_isEmpty(gridObject.customTitle.html) == true){
		lib_content.customAria = "";
	}else{
		lib_content.customAria = gridObject.customTitle.html;
	}
	
	//페이징
	lib_content.paging = {};
	var pageUse = gfn_isNull(gridObject.crud.read.paging) == true ? true : gridObject.crud.read.paging == true ? true : false;
	lib_content.paging.pageable = pageUse == false ? false : {pageSizes: true};
	lib_content.paging.pageSize = pageUse == false ? 1000 : 10;
	lib_content.paging.serverPaging = pageUse == false ? false : true;
	
	var gridAgg = gfn_isNull(gridObject.aggregate) ? false : gridObject.aggregate;
			
	var dataBound = gfn_isNull(gridObject.dataBound) ? false : gridObject.dataBound;
	
	lib_content.selectable = gridObject.selectable;
	
	//검색 파라미터
	lib_content.requestObject ={}
	
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : gridObject.ctrlUrl + gridObject.crud.read.url,
				dataType : "json",
				traditional :true
			},
			parameterMap: function(data, type){
				switch(type) {
				case "read" :
					var sort='';
					$.each(data.sort, function(index,item) {
						sort += item.field+' ' +item.dir+',';
					});
				
					if(!gfn_isEmpty(sort)){
						sort = sort.substring(0,sort.length-1);
					}
					gridObject.crud.read.prmt.page = data.page;
					gridObject.crud.read.prmt.take = data.take;
					gridObject.crud.read.prmt.rows = data.pageSize;
					gridObject.crud.read.prmt.sort = sort;
					gridObject.crud.read.prmt.searchGubun = $("#"+gridObject.layoutId+"_hidShSelBox").val();
					gridObject.crud.read.prmt.searchText = $("#"+gridObject.layoutId+"_shSelTxt").val();
					gridObject.crud.read.prmt.searchStartDate = $("#"+gridObject.layoutId+"_hidStdt").val();
					gridObject.crud.read.prmt.searchEndDate = $("#"+gridObject.layoutId+"_hidEddt").val();
					if(!lib_content.paging.serverPaging){
						gridObject.crud.read.prmt.pagingYN = 'N';
					}
					
					//메뉴 아이디 추가
					gridObject.crud.read.prmt.currentMenuId = $("#_currentMenuId").val();
					
					//동적 값을 갖는 파라미터는 ID값을 받아서 매핑해준다.
					if(!gfn_isEmpty(gridObject.crud.read.dynamicPrmt)){
						for(key in gridObject.crud.read.dynamicPrmt){
							gridObject.crud.read.prmt[key] = $("#"+ gridObject.crud.read.dynamicPrmt[key]).val();
						}
					}
					
					//배열값을 갖는 동적 파라미터(checkBox)
					if(!gfn_isEmpty(gridObject.crud.read.dynamicMultiPrmt)){
						for(key in gridObject.crud.read.dynamicMultiPrmt){
							var prmt = $("[name="+gridObject.crud.read.dynamicMultiPrmt[key]+"]").serializeObject();
							gridObject.crud.read.prmt[key] = prmt[key];
						}
					}
					
				return gridObject.crud.read.prmt;
				}	
			}
		},		
		batch: true,
		schema: {
			 model: gridObject.model,
//			},
			data: "rows",
			total: "count"
 		},
 		aggregate : gridAgg,
		pageSize : lib_content.paging.pageSize,
		serverPaging: lib_content.paging.serverPaging,
		serverFiltering: false,
		serverSorting: true,
	});
	
	//grid 정의
	if(readAuth){
		$("#"+gridObject.layoutId).kendoGrid({
			dataSource: dataSource,
			columns: gridObject.columns,
			allowCopy:true,
			resizable: true,
	 		columnMenu: true,
	 		sortable: {
				mode: "multiple",
				allowUnsort: true
			},
			selectable: gfn_isNull(lib_content.selectable) == true ? "multiple cell" : lib_content.selectable,
			navigatable: true,
			pageable: lib_content.paging.pageable,
			toolbar: [
				{template: kendo.template(lib_content.customAria)},
				{template: kendo.template(lib_content.periodAria)},
				{template: kendo.template(lib_content.searchAria)},
				{template: kendo.template(lib_content.addAria)},
				{template: kendo.template(lib_content.destroyAria)},
				{template: kendo.template(lib_content.refreshAria)},
				{template: kendo.template(lib_content.excelAria)}
			],
			excel: {
				allPages: true,
				fileName : excelAuth == false ? '' : gfn_isEmpty(gridObject.crud.excel.fileName) == true ? '' :gridObject.crud.excel.fileName,
				proxyURL : excelAuth == false ? '' : gfn_isEmpty(gridObject.crud.excel.url) == true ? '' :gridObject.crud.excel.url
			},
			dataBinding: function(e) {
				record = (this.dataSource.page() -1) * this.dataSource.pageSize();
			},
			dataBound : dataBound
		});
		
		lib_content.grid = $("#"+gridObject.layoutId).getKendoGrid();
		
		if(!gfn_isNull(lib_content.periodAria)){
			//시작날짜 세팅
			var date = new Date();
			date.setDate(date.getDate()+gridObject.crud.read.period.stdt)
			$("#"+gridObject.layoutId+"_stdt").kendoDatePicker({
				culture:"ko-KR",
				format:'yyyy-MM-dd',
				value : date,
				change:function(){
					$("#"+gridObject.layoutId+"_hidStdt").val($("#"+gridObject.layoutId+"_stdt").val());
					lib_content.grid.dataSource.read();
				}
			});
			$("#"+gridObject.layoutId+"_hidStdt").val($("#"+gridObject.layoutId+"_stdt").val());
			
			//종료날짜 세팅
			var date = new Date();
			date.setDate(date.getDate()+gridObject.crud.read.period.eddt)
			$("#"+gridObject.layoutId+"_eddt").kendoDatePicker({
				culture:"ko-KR",
				format:'yyyy-MM-dd',
				value: date,
				change:function(){
					$("#"+gridObject.layoutId+"_hidEddt").val($("#"+gridObject.layoutId+"_eddt").val());
					lib_content.grid.dataSource.read();
				}
			});
			$("#"+gridObject.layoutId+"_hidEddt").val($("#"+gridObject.layoutId+"_eddt").val());
		}
		
		//검색영역 검색 selectBox 값 세팅
		$("#"+gridObject.layoutId+"_shSelBox").kendoDropDownList({
			dataTextField: "text",
			dataValueField: "value",
			dataSource: gridObject.selectBox,
			index: 0
		});
		
		//검색버튼 클릭
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-search", function (e) {
			$("#"+gridObject.layoutId+"_hidShSelBox").val($("#"+gridObject.layoutId+"_shSelBox").val());
			$("#"+gridObject.layoutId+"_hidShSelTxt").val($("#"+gridObject.layoutId+"_shSelTxt").val());
//			lib_content.grid.dataSource.read();
			lib_content.grid.dataSource.query({
				page: 1,
				pageSize: 10
			});
		});
		
			
		//검색박스 엔터 이벤트
		$("#"+gridObject.layoutId+"_shSelTxt").keyup(function(e) {
			if (e.keyCode == 13) {
				$("#"+gridObject.layoutId+"_hidShSelBox").val($("#"+gridObject.layoutId+"_shSelBox").val());
				$("#"+gridObject.layoutId+"_hidShSelTxt").val($("#"+gridObject.layoutId+"_shSelTxt").val());
				/*lib_content.grid.dataSource.read();*/
				lib_content.grid.dataSource.query({
					page: 1,
					pageSize: 10
				});
			}
		});
		
		/* 새로고침이벤트
			1. 검색구분, 검색 새로고침
			2. 페이징 정보 새로고침
		*/
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-refresh", function (e) {
			$("#"+gridObject.layoutId+"_shSelTxt").val("");
			$("#"+gridObject.layoutId+"_hidShSelBox").val("");
			$("#"+gridObject.layoutId+"_hidShSelTxt").val("");
			lib_content.grid.dataSource.query({
				page: 1,
				pageSize: lib_content.paging.pageSize
			});
//			lib_content.grid.dataSource.read();
		});
		
		//커스텀 타이틀 이벤트 콜백
		if(gfn_isEmpty(gridObject.customTitle) == false && gfn_isEmpty(gridObject.customTitle.html) == false && 
				typeof(gridObject.customTitle.callback) == "function"){
			gridObject.customTitle.callback();
		}
	}
	
	//추가 버튼
	if(createAuth){
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-add", function (e) {
			if(!gfn_isEmpty(gridObject.crud.create.openFunc) && typeof gridObject.crud.create.openFunc == "function"){
				gfn_loading(true);
				gridObject.crud.create.openFunc("NEW");
				setTimeout(function(){gfn_loading(false)},200);
			}
		});
	}
	
	//삭제버튼
	if(destroyAuth){
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-delete", function (e) {
			if(!gfn_isEmpty(gridObject.crud.destroy.callback) && typeof gridObject.crud.destroy.callback == "function"){
				kendo.confirm(gfn_getMsg("pop_confirmDelete")).done(function(){			//삭제하시겠습니까?
					gfn_loading(true);
					gridObject.crud.destroy.callback();
					setTimeout(function(){gfn_loading(false)},200);
				});
			}
		});
	}

	//마스터테이블 더블 클릭
	if(updateAuth){
		$("#"+gridObject.layoutId+" tbody").on("dblclick", "tr", function(e){
			if(!gfn_isEmpty(gridObject.crud.update.openFunc) && typeof gridObject.crud.update.openFunc == "function"){
				gfn_loading(true);
				gridObject.crud.update.openFunc("EDT",lib_content.grid.dataItem($(e.target).closest('tr')));
				setTimeout(function(){gfn_loading(false)},200);
			}
		});
	}
	lib_content.grid.dataSource.read();
	
	return lib_content.grid;
}

//objectData grid 세팅 
this.gfn_objectDatagrid_set = function(gridObject){
	
	var lib_content = {};
	
	var createAuth = gfn_isEmpty(gridObject.crud.create) == true ? false : gfn_isEmpty(gridObject.crud.create.auth) == true ? true : gfn_hasAuth(gridObject.crud.create.auth);
	var updateAuth = gfn_isEmpty(gridObject.crud.update) == true ? false : gfn_isEmpty(gridObject.crud.update.auth) == true ? true : gfn_hasAuth(gridObject.crud.update.auth);
	var destroyAuth = gfn_isEmpty(gridObject.crud.destroy) == true ? false : gfn_isEmpty(gridObject.crud.destroy.auth) == true ? true : gfn_hasAuth(gridObject.crud.destroy.auth);
	var excelAuth = gfn_isEmpty(gridObject.crud.excel) == true ? false : gfn_isEmpty(gridObject.crud.excel.auth) == true ? true : gfn_hasAuth(gridObject.crud.excel.auth);
	
	//검색영역
	lib_content.searchAria = '<span class="jte-search-aria"><label>'+gfn_getMsg("ui_search")+' : </label><input id=\"'+gridObject.layoutId+'_shSelBox\" style="width:150px;"/>'			//검색(UI)
		+'<input type=\"text\" id=\"'+gridObject.layoutId+'_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'					//조회(Input)
		+'<a role=\"button\" class=\"k-button k-button-icontext jte-search\"><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'			//조회버튼
		+'<input id=\"'+gridObject.layoutId+'_hidShSelBox\" type=\"hidden\">'
		+'<input id=\"'+gridObject.layoutId+'_hidShSelTxt\" type=\"hidden\">'
		+'<input id=\"'+gridObject.layoutId+'_hidSelected\" type=\"hidden\"></span>';
		
	//추가버튼
	lib_content.addAria = createAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-add\"><span class=\"k-icon k-i-plus\"></span>'+gfn_getMsg("btn_add")+'</a>';

	//삭제버튼
	lib_content.destroyAria = destroyAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-delete\"><span class=\"k-icon k-i-close\"></span>'+gfn_getMsg("btn_delete")+'</a>';

	//새로고침
	lib_content.refreshAria = '<a role=\"button\" class=\"k-button k-button-icontext jte-refresh\"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';

	//엑셀
	lib_content.excelAria = excelAuth ==false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext k-grid-excel\"><span class=\"k-icon k-i-file-excel\"></span>'+gfn_getMsg("btn_excelDownload")+'</a>';
	
	//검색 파라미터
	lib_content.requestObject ={}
	
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		data:gridObject.selectedItems,
		schema: {
			 model: gridObject.model
 		},
		pageSize: 10,
		serverPaging: true,
		serverFiltering: false,
		serverSorting: true
	});
	
	//grid 정의
	$("#"+gridObject.layoutId).kendoGrid({
		dataSource: dataSource,
		columns: gridObject.columns,
		allowCopy:true,
		resizable: true,
 		columnMenu: true,
 		sortable: {
			mode: "multiple",
			allowUnsort: true
		},
		selectable: "multiple",
		navigatable: true,
		pageable: {
			pageSizes: true
		},
		editable: {
			mode:"inline"
		},
		toolbar: [
			{template: kendo.template(lib_content.searchAria)},
			{template: kendo.template(lib_content.addAria)},
			{template: kendo.template(lib_content.destroyAria)},
			{template: kendo.template(lib_content.refreshAria)},
			{template: kendo.template(lib_content.excelAria)}			
		],
		excel: {
			allPages: true,
			fileName : excelAuth == false ? '' : gfn_isEmpty(gridObject.crud.excel.fileName) == true ? '' :gridObject.crud.excel.fileName,
			proxyURL : excelAuth == false ? '' : gfn_isEmpty(gridObject.crud.excel.url) == true ? '' :gridObject.crud.excel.url
		},
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		}
	});
	
	lib_content.grid = $("#"+gridObject.layoutId).getKendoGrid();
	
	//검색영역 검색 selectBox 값 세팅
	$("#"+gridObject.layoutId+"_shSelBox").kendoDropDownList({
		dataTextField: "text",
		dataValueField: "value",
		dataSource: gridObject.selectBox,
		index: 0
	});
	
	//검색버튼 클릭
	$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-search", function (e) {
		$("#"+gridObject.layoutId+"_hidShSelBox").val($("#"+gridObject.layoutId+"_shSelBox").val());
		$("#"+gridObject.layoutId+"_hidShSelTxt").val($("#"+gridObject.layoutId+"_shSelTxt").val());
		lib_content.grid.dataSource.read();
	});
	
		
	//검색박스 엔터 이벤트
	$("#"+gridObject.layoutId+"_shSelTxt").keyup(function(e) {
		if (e.keyCode == 13) {
			$("#"+gridObject.layoutId+"_hidShSelBox").val($("#"+gridObject.layoutId+"_shSelBox").val());
			$("#"+gridObject.layoutId+"_hidShSelTxt").val($("#"+gridObject.layoutId+"_shSelTxt").val());
			lib_content.grid.dataSource.read();
		}
	});
	
	/* 새로고침이벤트
		1. 검색구분, 검색 새로고침
		2. 페이징 정보 새로고침
	*/
	$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-refresh", function (e) {
		$("#"+gridObject.layoutId+"_shSelTxt").val("");
		$("#"+gridObject.layoutId+"_hidShSelBox").val("");
		$("#"+gridObject.layoutId+"_hidShSelTxt").val("");
		lib_content.grid.dataSource.query({
			page: 1,
			pageSize: 20
		});
		lib_content.grid.dataSource.read();
	});
	
	//추가 버튼
	if(createAuth){
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-add", function (e) {
			if(!gfn_isEmpty(gridObject.crud.create.openFunc) && typeof gridObject.crud.create.openFunc == "function"){
				gridObject.crud.create.openFunc("NEW");
			}
		});
	}
	
	//삭제버튼
	if(destroyAuth){
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-delete", function (e) {
			if(!gfn_isEmpty(gridObject.crud.destroy.callback) && typeof gridObject.crud.destroy.callback == "function"){
				kendo.confirm(gfn_getMsg("pop_confirmDelete")).done(function(){			//삭제하시겠습니까?
					gridObject.crud.destroy.callback();
				});
			}
		});
	}

	//마스터테이블 더블 클릭
	if(updateAuth && !gfn_isEmpty(gridObject.crud.create.openFunc)){
		$("#"+gridObject.layoutId+" tbody").on("dblclick", "tr", function(e){
			if(!gfn_isEmpty(gridObject.crud.update.openFunc) && typeof gridObject.crud.update.openFunc == "function"){
				gridObject.crud.update.openFunc("EDT",lib_content.grid.dataItem($(e.target).closest('tr')));
			}
		});
	}
	return lib_content.grid;
}

/*
 * 입력 / 수정 팝업화면 세팅
 * 1. 다국어 버튼 활성화(이벤트 포함)
 * 2. Form 영역 활성화
 * 3. 입력/수정 버튼 활성화(이벤트 포함)
 * */

this.gfn_popform_set = function(gridObject, mode,selectedItem){
	
	//tooltip 추가
	$("#"+gridObject.popId).kendoTooltip({
		autoHide: true,
		filter: "i",
		width: 200,
		height: 50,
		position: "top"
	});
	
	//다국어정보 세팅
	var prefix = "";
	var defId = "";
	var defNm = "";
	if($(".jte-msgBox").length){
		prefix = $(".jte-msgBox").attr("prefix");
		defId = $(".jte-msgBox").attr("defId");
		defNm = $(".jte-msgBox").attr("defNm");
		
		//호출 시 최초 다국어 초기화
		$("#msg_"+defId).val("");
	}
	//다국어버튼 이벤트 세팅
	$(".jte-msgBox").on("click", function (e) {
		prefix = $(this).attr("prefix");
		defId = $(this).attr("defId");
		defNm = $(this).attr("defNm");
		
		// 저장 시 콜백 입력된 결과를 임시저장했다가 서비스단에서 저장
		var option ={
			saveCallback : function(rtnMsg){
				$("#msg_"+defId).val(JSON.stringify(rtnMsg));
			}
		};
		
		//임시저장된 데이터가 있으면 임시데이터 로드를 위함
		if(!gfn_isEmpty($("#msg_"+defId).val())){
			option.saveMsg = JSON.parse($("#msg_"+defId).val());
		}
		
		//기본설정
		if($("#"+gridObject.popId+"_form [name = action]").val() == 'C'){
			option.mode = "PG_NEW";
			option.defNm = $("#"+defNm).val();
		}else if($("#"+gridObject.popId+"_form [name = action]").val() == 'U'){
			option.mode = "PG_EDT";
			option.defId = prefix+"_" + $("#"+defId).val();
			option.defNm = $("#"+defNm).val();
		}
		gfn_msgSetPop(option);
	});
	
	if(mode=='NEW'){
		$("#"+gridObject.popId+"_form").find("input").each(function(index,item){
			
			var formatType = $(item).attr("format");
			var fillTextName = $(item).attr("name");
			var isReadonly = $(item).is('[readonly]');
			
			if(formatType == "currency"){
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "numerictextbox"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val("");
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoNumericTextBox({
						format: "n0",
						value: 0
					});
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoNumericTextBox").value("");
				}
				
				if(!gfn_isEmpty(selectedItem)){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoNumericTextBox").value(selectedItem[fillTextName]);
				}
				if(isReadonly){
					$(item).closest('.k-numeric-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
				}
			}else if(formatType == "numeric"){
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "numerictextbox"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val("");
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoNumericTextBox({
						format: "n",
						value: 0
					});
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoNumericTextBox").value("");
				}
				
				if(!gfn_isEmpty(selectedItem)){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoNumericTextBox").value(selectedItem[fillTextName]);
				}
				if(isReadonly){
					$(item).closest('.k-numeric-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
				}
			}else if(formatType == "datepicker"){
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "datepicker"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val("");
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoDatePicker({
						culture:"ko-KR",
						format:'yyyy-MM-dd',
					});
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDatePicker").value("");
				}
				if(!gfn_isEmpty(selectedItem)){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDatePicker").value(selectedItem[fillTextName]);
				}
				if(isReadonly){
					$(item).closest('.k-picker-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
				}
			}else if(formatType == "datetimepicker"){
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "datetimepicker"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val("");
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoDateTimePicker({
						culture:"ko-KR",
						format:'yyyy-MM-dd HH:mm:ss',
						timeFormat: "HH:mm"
					});
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDateTimePicker").value("");
				}
				if(!gfn_isEmpty(selectedItem)){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDateTimePicker").value(selectedItem[fillTextName]);
				}
				if(isReadonly){
					$(item).closest('.k-datetimepicker-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
				}
			}else if(formatType == "selBox"){
				var selBoxItem = gfn_getCode($(item).attr("msg"));
				var selBoxDef = $(item).attr("def");
				var selBoxKeyGbn = gfn_isEmpty($(item).attr("keyGbn")) == true ? "cdId" : $(item).attr("keyGbn");
				
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "dropdownlist"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val("");
					
					//기초코드를 사용하지 않는 selectbox 예외처리
					if(gfn_isEmpty($(item).attr("custom"))){
						//기본 - 기초코드 사용
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoDropDownList({
							dataSource: selBoxItem,
							dataValueField: selBoxKeyGbn,
							valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
							template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
							index:0
						});
					}else{
						//custom selectbox
						var objFuncCall = eval($(item).attr("func"));
						var selBoxKeyText = $(item).attr("keyText");
						
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoDropDownList({
							dataSource: objFuncCall,
							dataValueField: selBoxKeyGbn,
							dataTextField: selBoxKeyText,
							index:0
						});
					}
				}
				else{
					//디폴트 세팅
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDropDownList").select(0);
				}
				//attr - def 설정
				//1. null인 경우 빈값으로 세팅, 2. cdid를 넣으면 기본으로 해당하는 값의 selectBox를 찾아옴
				if(!gfn_isNull(selBoxDef)){
					if(selBoxDef == 'null'){
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDropDownList").select(-1);
					}else{
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDropDownList").select(function(dataItem) {
							return dataItem[selBoxKeyGbn] === selBoxDef;
						});
					}
				}
				//값이 있을 경우
				if(!gfn_isEmpty(selectedItem) && !gfn_isEmpty(selectedItem[fillTextName])){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDropDownList").select(function(dataItem) {
						return dataItem[selBoxKeyGbn] === selectedItem[fillTextName];
					});
				}
				if(isReadonly){		//200508_200511_드롭다운 readonly 관련 css 변경_LYM
					$(item).closest('.k-dropdown').css({background:"none"}); 
					$(item).closest('.k-dropdown').find('.k-dropdown-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"}); 
					$(item).closest('.k-dropdown').find('.k-dropdown-wrap').find('.k-input').css({background:"#ebeff5",color:"#333333"});
					$(item).closest('.k-dropdown').find('.k-dropdown-wrap').find('.k-select').find('.k-icon').css({color:"#333333"});
				}
			}else if(formatType =="checkbox"){
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").prop("checked",false);
				if(!gfn_isEmpty(selectedItem)){
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").prop("checked",selectedItem[fillTextName]);
				}
			} else if(formatType == "file"){
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "upload"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoUpload({
						template: '<li class="k-file k-file-success" data-uid="#=files[0].uid #">'+
							'<span class="k-progress"></span>'+
							'<span class="k-file-extension-wrapper">'+
								'<span class="k-file-extension">#=files[0].extension#</span>'+
								'<span class="k-file-state"></span>'+
							'</span>'+
							'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
								'<span class="k-file-name" title="#=name#">#=name#</span>'+
								'<span class="k-file-size">#=size# bytes</span>'+
								'<input class="k-file-path" type="hidden" value="#=files[0].path#"/>'+
								'<input class="k-file-attachId" type="hidden" value="#=files[0].attachId#"/>'+
							'</span>'+
							'<strong class="k-upload-status">'+
								'<button type="button" class="k-button k-upload-action" aria-label="Remove">'+
									'<span class="k-icon k-i-close k-i-x" title="Remove"></span>'+
								'</button>'+
							'</strong>'+
						'</li>',
						
						async: {
						saveUrl: "/attach/attachFilesTempSave",
						removeUrl: "/attach/attachFilesTempDelete",
						autoUpload:true
						}
						,success: gfn_attachProc
						,remove : function (e) {
							var attachFiles = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
							attachFiles.forEach(function(item,index){
								if(item.attachOrigin == e.files[0].name){
									e.data = item;
								}
							});
						}
					});
				}
			} else{
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val("");
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").addClass("k-textbox");
				if(!gfn_isEmpty(selectedItem)){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val(selectedItem[fillTextName]);
				}
			}
		});
		
		$("#"+gridObject.popId+"_form").find("textarea").each(function(index,item){
			var fillTextName = $(item).attr("name");
			var isReadonly = $(item).is('[readonly]');
			
			if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "textarea"){
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val("");
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoTextArea({
					rows: $(item).attr("rows")
				});
			}else{
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoTextArea").value("");
			}
			
			if(!gfn_isEmpty(selectedItem)){
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoTextArea").value(selectedItem[fillTextName]);
			}
			if(isReadonly){
				$(item).closest('.k-textarea').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
			}
		});
		
		$("#"+gridObject.popId+"_form [name = action]").val("C");
		//추가버튼 이벤트 바인딩
		$("#"+gridObject.popId+" .jte-update").hide();
		$("#"+gridObject.popId+" .jte-create").show();
		//이벤트중복방지
		if($("#"+gridObject.popId+" .jte-create").length > 0){
			var event = $._data($("#"+gridObject.popId+" .jte-create")[0],"events")
			if(gfn_isEmpty(event) || !event.click){
				$("#"+gridObject.popId+" .jte-create").on("click",function(){
						gridObject.crud.create.callback("create");				
				});
			}
		}
	}else if('EDT'){
		$("#"+gridObject.popId+"_form").find("input").each(function(index,item){
			var formatType = $(item).attr("format");
			var fillTextName = $(item).attr("name");
			var isReadonly = $(item).is('[readonly]');
			
			if(formatType == "currency"){
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "numerictextbox"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoNumericTextBox({
						format: "n0",
						value:selectedItem[fillTextName]
					});
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoNumericTextBox").value(selectedItem[fillTextName]);
				}
				//라벨처리(input대신 label 사용할 경우)
				if($("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").length){
					//lable에 text 입력
					$("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").html(
							$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoNumericTextBox")._text[0].title
					)
					//기존박스 hide
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest(".k-numerictextbox").hide();
				}
				if(isReadonly){
					$(item).closest('.k-numeric-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
				}
			}if(formatType == "numeric"){
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "numerictextbox"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoNumericTextBox({
						format: "n",
						value:selectedItem[fillTextName]
					});
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoNumericTextBox").value(selectedItem[fillTextName]);
				}
				//라벨처리(input대신 label 사용할 경우)
				if($("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").length){
					//lable에 text 입력
					$("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").html(
							$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoNumericTextBox")._text[0].title
					)
					//기존박스 hide
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest(".k-numerictextbox").hide();
				}
				if(isReadonly){
					$(item).closest('.k-numeric-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
				}
			}else if(formatType == "datepicker"){
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "datepicker"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoDatePicker({
						culture:"ko-KR",
						format:'yyyy-MM-dd',
						value:selectedItem[fillTextName]
					});
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDatePicker").value(selectedItem[fillTextName]);
				}
				//라벨처리(input대신 label 사용할 경우)
				if($("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").length){
					$("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").html(
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDatePicker")._oldText
					)
					//기존박스 hide
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest(".k-datepicker").hide();
				}
				
				if(isReadonly){
					$(item).closest('.k-picker-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
				}
			}else if(formatType == "datetimepicker"){
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "datetimepicker"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoDateTimePicker({
						culture:"ko-KR",
						format:'yyyy-MM-dd HH:mm:ss',
						timeFormat: "HH:mm",
						value:selectedItem[fillTextName]
					});
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDateTimePicker").value(selectedItem[fillTextName]);
				}
				//라벨처리(input대신 label 사용할 경우)
				if($("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").length){
					$("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").html(
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDateTimePicker")._oldText
					)
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest(".k-datetimepicker").hide();
				}
				if(isReadonly){
					$(item).closest('.k-picker-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
				}
			}else if(formatType == "selBox"){
				var selBoxItem = gfn_getCode($(item).attr("msg"));
				var selBoxKeyGbn = gfn_isEmpty($(item).attr("keyGbn")) == true ? "cdId" : $(item).attr("keyGbn");
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "dropdownlist"){
					
					//기초코드를 사용하지 않는 selectbox 예외처리
					if(gfn_isEmpty($(item).attr("custom"))){
						//기본 - 기초코드 사용
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoDropDownList({
							dataSource: selBoxItem,
							dataValueField: selBoxKeyGbn,
							valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #"+ "#= item #",
							template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
							index:0
						});
					}else{
						//custom selectbox
						var objFuncCall = eval($(item).attr("func"));
						var selBoxKeyText = $(item).attr("keyText");
						
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoDropDownList({
							dataSource: objFuncCall,
							dataValueField: selBoxKeyGbn,
							dataTextField: selBoxKeyText,
							index:0
						});
					}
					
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDropDownList").select(function(dataItem) {
						return dataItem[selBoxKeyGbn] === selectedItem[fillTextName];
					});
					
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDropDownList").select(function(dataItem) {
						return dataItem[selBoxKeyGbn] === selectedItem[fillTextName];
					});
				}
				//라벨처리(input대신 label 사용할 경우)
				if($("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").length){
					$("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").html(
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoDropDownList").text()
					)
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest(".k-dropdown").hide();
				}
				if(isReadonly){		//200508_200511_드롭다운 readonly 관련 css 변경_LYM
					$(item).closest('.k-dropdown').css({background:"none"}); 
					$(item).closest('.k-dropdown').find('.k-dropdown-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"}); 
					$(item).closest('.k-dropdown').find('.k-dropdown-wrap').find('.k-input').css({background:"#ebeff5",color:"#333333"});
					$(item).closest('.k-dropdown').find('.k-dropdown-wrap').find('.k-select').find('.k-icon').css({color:"#333333"});
				}
			}else if(formatType == "checkbox"){
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").addClass("k-checkbox");
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").prop("checked",selectedItem[fillTextName]);
				//라벨처리(input대신 label 사용할 경우)
				if($("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").length){
					var checkBoxText = "";
					if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").is(":checked")){
						checkBoxText = $("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").attr("t");
					}else{
						checkBoxText = $("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").attr("f");
					}
					$("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").html(checkBoxText);
				}
			}else if(formatType == "file"){
				var attachCode = selectedItem[$(item).attr("code")];
				var fileList = [];
				$.ajax({
					async:false,
					url : "/attach/getAttachFiles",
					type: "POST",
					data: {attachCode : attachCode},
					success: function(data){
						$(data.result).each(function(fileIndex,fileUnit){
							fileList.push({
								name : fileUnit.attachOrigin, 
								size : fileUnit.attachSize, 
								extension : fileUnit.attachExt, 
								path : fileUnit.attachPath,
								attachId : fileUnit.attachId
								});
							var insertFiles = JSON.parse($("#insertAttach").val());
							fileUnit.attachStatus = "OLD";
							insertFiles.push(fileUnit);
							$("#insertAttach").val(JSON.stringify(insertFiles));
						});
						
					},error : function(ex){
						gfn_loading(false);
						gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
					}
				});
				
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "upload"){
					 
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoUpload({
						template: '<li class="k-file k-file-success" data-uid="#=files[0].uid #">'+
							'<span class="k-progress"></span>'+
							'<span class="k-file-extension-wrapper">'+
								'<span class="k-file-extension">#=files[0].extension#</span>'+
								'<span class="k-file-state"></span>'+
							'</span>'+
							'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
								'<span class="k-file-name" title="#=name#">#=name#</span>'+
								'<span class="k-file-size">#=size# bytes</span>'+
								'<input class="k-file-path" type="hidden" value="#=files[0].path#"/>'+
								'<input class="k-file-attachId" type="hidden" value="#=files[0].attachId#"/>'+
							'</span>'+
							'<strong class="k-upload-status">'+
								'<button type="button" class="k-button k-upload-action" aria-label="Remove">'+
									'<span class="k-icon k-i-close k-i-x" title="Remove"></span>'+
								'</button>'+
							'</strong>'+
						'</li>',
						
						async: {
						saveUrl: "/attach/attachFilesTempSave",
						removeUrl: "/attach/attachFilesTempDelete",
						autoUpload:true
						}
						,success: gfn_attachProc
						,remove : function (e) {
							var attachFiles = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
							
							attachFiles.forEach(function(item,index){
								if(item.attachOrigin == e.files[0].name){
									e.data = item;
								}
							});
						},
						files:fileList
					});
				}else{
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoUpload({
						async: {
						saveUrl: "/attach/attachFilesTempSave",
						removeUrl: "/attach/attachFilesTempDelete",
						autoUpload:true
						}
						,success: gfn_attachProc
						,remove : function (e) {
							var removeFiles = {};
							var attachFiles = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
							attachFiles.forEach(function(item,index){
								if(item.attachOrigin == e.files[0].name){
									e.data = item;
								}
							});
						},
						files:files
					});
				}
				
				/*//라벨처리(input대신 label 사용할 경우)
				if($("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").length){
					//lable에 text 입력
					$("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").html(
							$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoNumericTextBox")._text[0].title
					)
					//기존박스 hide
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest(".k-numerictextbox").hide();
				}
				if(isReadonly){
					$(item).closest('.k-numeric-wrap').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
				}*/
			}else{
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").addClass("k-textbox");
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val(selectedItem[fillTextName]);
				//라벨처리(input대신 label 사용할 경우)
				if($("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").length){
					$("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").html($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val());
				}
			}
		});
		
		$("#"+gridObject.popId+"_form").find("textarea").each(function(index,item){
			var fillTextName = $(item).attr("name");
			var isReadonly = $(item).is('[readonly]');
			
			if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "textarea"){
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoTextArea({
					rows: $(item).attr("rows")
				});
				
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").val(selectedItem[fillTextName]);
			}else{
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoTextArea").value(selectedItem[fillTextName]);
			}
			
			//라벨처리(input대신 label 사용할 경우)
			if($("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").length){
				//lable에 text 입력
				$("#"+gridObject.popId+"_form").find("[for="+fillTextName+"]").html(
						$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").data("kendoTextArea")._text[0].title
				);
				//기존박스 hide
				$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest(".k-textarea").hide();
			}
			if(isReadonly){
				$(item).closest('.k-textarea').css({background:"#ebeff5",border:"1px solid #b6c2d1"});
			}
		});
		
		$("#"+gridObject.popId+"_form [name = action]").val("U");
		
		//수정버튼 이벤트 바인딩
		$("#"+gridObject.popId+" .jte-create").hide();
		$("#"+gridObject.popId+" .jte-update").show();
		//이벤트 중복방지
		if($("#"+gridObject.popId+" .jte-update").length > 0){
			var event = $._data($("#"+gridObject.popId+" .jte-update")[0],"events");
			if(gfn_isEmpty(event) || !event.click){
				$("#"+gridObject.popId+" .jte-update").on("click",function(){
						gridObject.crud.update.callback("update");				
				});
			}
		}
	}
	
	//ValidationCheck 함수 추가
	var validation = $("#"+gridObject.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation)){
		
		//required 기본으로 적용
		var rules = {
			required: function(input){
				if(!gfn_isEmpty(input.attr("required"))){
					return $.trim(input.val()) !== "";
				}
				return true;
			}
		};
		
		var messages = {
			required: "필수입력값입니다."
		}
		
		$.each(gridObject.validation,function(key,value){
			rules[key] = value.rules;
			messages[key] = value.messages;
		});
		//validator
		var validator = $("#"+gridObject.popId+"_form").kendoValidator({
			rules: rules,
			messages: messages
		}).data("kendoValidator");
		
		//validator 툴팁
		var tooltip = $("#"+gridObject.popId+"_form").kendoTooltip({
			filter: ".k-invalid",
			content: function(e) {
				var name = e.target.attr("name") || e.target.closest(".k-widget").find(".k-invalid:input").attr("name");
				var errorMessage = $("#"+gridObject.popId+"_form").find("[data-for=" + name + "]");
				return '<span class="k-icon k-warning"> </span>' + errorMessage.text();
			},
			show: function() {
				this.refresh();
			}
		});
	}
}

this.gfn_attachProc = function(e) {
	//파일 업로드
	if (e.operation == "upload") {
		console.log(e);
		var insertFiles = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
		console.log(insertFiles);
		console.log(e);
		e.response.attachFiles.forEach(function(insrtItem,insrtIndex){
			console.log(insrtItem);
			console.log(insrtIndex);
			insrtItem.attachStatus = "NEW";
			
			insertFiles.push(insrtItem);
			$("#insertAttach").val(JSON.stringify(insertFiles));
		});
		
//			$("#insertAttach").val($("#insertAttach").val() + "NEW||" + item.fileName + "||" + item.basePath + "@@");
//		});
	}
	
	//파일 삭제
	if (e.operation == "remove") {
		console.log(e);
		//삭제 파일 정보
		var removeFiles = e.response.attachFiles;
		//등록 대기 파일 정보
		var insertTemp = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
		
		if(removeFiles.attachStatus=="NEW"){
			insertTemp.forEach(function(insertItem, insertIndex){
				if(insertItem.attachOrigin == removeFiles.attachOrigin){
					insertTemp.pop(insertIndex);
					$("#insertAttach").val(JSON.stringify(insertTemp));
				}
			});
		}else if(removeFiles.attachStatus=="OLD"){
			console.log($("#deleteAttach").val());
			var deleteFiles = $("#deleteAttach").val() == "" ? [] : JSON.parse($("#deleteAttach").val());
			console.log(deleteFiles);
			deleteFiles.push(removeFiles);
			$("#deleteAttach").val(JSON.stringify(deleteFiles));
			//$("#deleteAttach").val($("#deleteAttach").val() + "DEL||" + removeFiles.attachId + "||" + removeFiles.attachPath + "@@");
		}
	}
}
this.gfn_attachDownload = function(e) {
	//var file = $(e).closest("li").attr("data-uid");
	var attachId = $(e).closest("li").find(".k-file-attachId").val();
	
	//첨부파일을 다운받기 위해 Form 생성
	var form = document.createElement("form");
	form.setAttribute("charset", "UTF-8");
	form.setAttribute("method", "post");  //Post 방식
	form.setAttribute("action", gfn_getUri("/attach/attachFilesDownload")); //요청 보낼 주소
	form.setAttribute("target", "attachDownloadIframe"); //요청 보낼 주소
	form.setAttribute("id", "asdfdd"); //요청 보낼 주소

	var hiddenField = document.createElement("input");
	hiddenField.setAttribute("type", "hidden");
	hiddenField.setAttribute("name", "attachId");
	hiddenField.setAttribute("value", attachId);
	form.appendChild(hiddenField);
	document.body.appendChild(form);
	form.submit();
	
	//태그제거
	document.body.removeChild(form);
}

//파일로딩 커스텀
this.gfn_fileLoad = function(areaId, targetId){
	$("#"+areaId).html("");
	$("#"+areaId).html('<input name="attachFiles" id="attachFiles" type="file" aria-label="files" format="file" code="' + targetId + '" />'
			+'<input type="hidden" id="insertAttach" value = "[]"/>'
			+'<input type="hidden" id="deleteAttach" value = "[]"/>');
		
	//var attachCode = $("#"+inputId).attr("code");
	var fileList = [];
	$.ajax({
		async:false,
		url : "/attach/getAttachFiles",
		type: "POST",
		data: {attachCode : targetId},
		success: function(data){
			$(data.result).each(function(fileIndex,fileUnit){
				fileList.push({
					name : fileUnit.attachOrigin, 
					size : fileUnit.attachSize, 
					extension : fileUnit.attachExt, 
					path : fileUnit.attachPath,
					attachId : fileUnit.attachId
					});
				var insertFiles = JSON.parse($("#insertAttach").val());
				fileUnit.attachStatus = "OLD";
				insertFiles.push(fileUnit);
				$("#insertAttach").val(JSON.stringify(insertFiles));
			});
			
		},error : function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
		}
	});
	
	if($("#attachFiles").attr("data-role") != "upload"){
		 
		$("#attachFiles").kendoUpload({
			template: '<li class="k-file k-file-success" data-uid="#=files[0].uid #">'+
				'<span class="k-progress"></span>'+
				'<span class="k-file-extension-wrapper">'+
					'<span class="k-file-extension">#=files[0].extension#</span>'+
					'<span class="k-file-state"></span>'+
				'</span>'+
				'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
					'<span class="k-file-name" title="#=name#">#=name#</span>'+
					'<span class="k-file-size">#=size# bytes</span>'+
					'<input class="k-file-path" type="hidden" value="#=files[0].path#"/>'+
					'<input class="k-file-attachId" type="hidden" value="#=files[0].attachId#"/>'+
				'</span>'+
				'<strong class="k-upload-status">'+
					'<button type="button" class="k-button k-upload-action" aria-label="Remove">'+
						'<span class="k-icon k-i-close k-i-x" title="Remove"></span>'+
					'</button>'+
				'</strong>'+
			'</li>',
			
			async: {
			saveUrl: "/attach/attachFilesTempSave",
			removeUrl: "/attach/attachFilesTempDelete",
			autoUpload:true
			}
			,success: gfn_attachProc
			,remove : function (e) {
				var attachFiles = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
				
				attachFiles.forEach(function(item,index){
					if(item.attachOrigin == e.files[0].name){
						e.data = item;
					}
				});
			},
			files:fileList
		});
	}
	$("#" + areaId +" .k-dropzone").hide();
	$("#" + areaId).find(".k-upload-action").each(function(item){
		if($(this).attr("aria-label") == "Remove"){
			$(this).hide();
		}
	})
}