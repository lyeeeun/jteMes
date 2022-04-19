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
	if(readAuth == false || (!gfn_isEmpty(gridObject.crud.read.search) && gridObject.crud.read.search == false)){
		lib_content.searchArea = '';
	}else{
		lib_content.searchArea = '<span class="jte-search-aria"><label>'+gfn_getMsg("ui_search")+' : </label><input id=\"'+gridObject.layoutId+'_shSelBox\" style="width:140px;"/>'			//검색(UI)
		+'<input type=\"text\" id=\"'+gridObject.layoutId+'_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\" style="width:140px;"/>'					//조회(Input)
		+'<a role=\"button\" class=\"k-button k-button-icontext jte-search\"><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'			//조회버튼
		+'<input id=\"'+gridObject.layoutId+'_hidShSelBox\" type=\"hidden\">'
		+'<input id=\"'+gridObject.layoutId+'_hidShSelTxt\" type=\"hidden\">'
		+'<input id=\"'+gridObject.layoutId+'_hidSelected\" type=\"hidden\"></span>';
	}
	//기간검색 - 조회가 2번씩 되는 현상으로 필요시 검색창을 하나 더 만들어서 사용할것 
//	if(readAuth == false || gfn_isEmpty(gridObject.crud.read.period) == true){
//		lib_content.periodArea = '';
//	}else{
//		lib_content.periodArea = '<span class="jte-period_area" style="margin-left:5px;"><label>기간검색 : </label>'+
//									'<input id=\"'+gridObject.layoutId+'_stdt\" style="width:120px;"/><input type="hidden" id=\"'+gridObject.layoutId+'_hidStdt\"/>'+
//									' ~ <input id=\"'+gridObject.layoutId+'_eddt\" style="width:120px;" /><input type="hidden" id=\"'+gridObject.layoutId+'_hidEddt\"/></span>'
//	}
	//추가버튼
	lib_content.addArea = createAuth == false ? '' : gfn_isEmpty(gridObject.crud.create.openFunc) == true ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-add\"><span class=\"k-icon k-i-plus\"></span>'+gfn_getMsg("btn_add")+'</a>';
	
	//삭제버튼
	lib_content.destroyArea ='';
	if(destroyAuth && gridObject.crud.destroy.type != 'pop'){
		lib_content.destroyArea = '<a role=\"button\" class=\"k-button k-button-icontext jte-delete\"><span class=\"k-icon k-i-close\"></span>'+gfn_getMsg("btn_delete")+'</a>';
	}
		
	//새로고침
	if(readAuth == false || gfn_isEmpty(gridObject.crud.read.refresh) == false || gridObject.crud.read.refresh == false){
		lib_content.refreshArea = '';
	}else{
		lib_content.refreshArea = readAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-refresh\"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';
	}
	//엑셀버튼
	
	//엑셀 title이 없는 경우 기본 이름
	var excelTitle = gfn_getMsg("btn_excelDownload");
	
	if(excelAuth && !gfn_isEmpty(gridObject.crud.excel.title)){
		excelTitle = gridObject.crud.excel.title;
	}
	
	lib_content.excelArea = excelAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext k-grid-excel\"><span class=\"k-icon k-i-file-excel\"></span>'+ excelTitle+'</a>';
	
		
	//커스텀 타이틀 
	if(readAuth == false || gfn_isEmpty(gridObject.customTitle) == true || gfn_isEmpty(gridObject.customTitle.html) == true){
		lib_content.customArea = "";
	}else{
		lib_content.customArea = $(gridObject.customTitle.html).css("float","left").clone().wrapAll("*").parent().html();
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
					if(gfn_isEmpty(gridObject.crud.read.prmt)) gridObject.crud.read.prmt = {};
					
					gridObject.crud.read.prmt.page = data.page;
					gridObject.crud.read.prmt.take = data.take;
					gridObject.crud.read.prmt.rows = data.pageSize;
					gridObject.crud.read.prmt.sort = sort;
					gridObject.crud.read.prmt.searchGubun = $("#"+gridObject.layoutId+"_hidShSelBox").val();
					gridObject.crud.read.prmt.searchText = $("#"+gridObject.layoutId+"_shSelTxt").val();
//					gridObject.crud.read.prmt.searchStartDate = $("#"+gridObject.layoutId+"_hidStdt").val();
//					gridObject.crud.read.prmt.searchEndDate = $("#"+gridObject.layoutId+"_hidEddt").val();
					if(!lib_content.paging.serverPaging){
						gridObject.crud.read.prmt.pagingYN = 'N';
					}else{
						gridObject.crud.read.prmt.pagingYN = 'Y';
					}
					
					//메뉴 아이디 추가
					gridObject.crud.read.prmt.currentMenuId = $("#_currentMenuId").val();
					
					//커스텀 타이틀 이벤트 콜백
					if(gfn_isEmpty(gridObject.customTitle) == false && gfn_isEmpty(gridObject.customTitle.html) == false && 
							typeof(gridObject.customTitle.callback) == "function" && gfn_isEmpty(lib_content.grid)){
						gridObject.customTitle.callback();
					}
					
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
	
	
	//툴바
	lib_content.toolbar = [
		//{template: kendo.template(lib_content.periodArea)},
		{template: kendo.template(lib_content.searchArea)},
		{template: kendo.template(lib_content.addArea)},
		{template: kendo.template(lib_content.destroyArea)},
		{template: kendo.template(lib_content.refreshArea)},
		{template: kendo.template(lib_content.excelArea)}
	];
	
	//커스텀 타이틀 위치 start/end (default : start)
	if(gfn_isEmpty(gridObject.customTitle) == false && gfn_isEmpty(gridObject.customTitle.html) == false && 
			gfn_isEmpty(gridObject.customTitle.position) == false && gfn_isEmpty(lib_content.grid)){
		if(gridObject.customTitle.position == 'start'){
			lib_content.toolbar.unshift({template: kendo.template(lib_content.customArea)});
		}else if(gridObject.customTitle.position == 'end'){
			lib_content.toolbar.push({template: kendo.template(lib_content.customArea)});
		}else{
			lib_content.toolbar.unshift({template: kendo.template(lib_content.customArea)});
		}
	}else{
		lib_content.toolbar.unshift({template: kendo.template(lib_content.customArea)});
	}
	
	lib_content.editable = false;
	
	if(gfn_isEmpty(gridObject.toolbar) == false){
		lib_content.toolbar =  gridObject.toolbar
		for(var barItem in gridObject.toolbar){
			if(gridObject.toolbar[barItem] == "create"){
				lib_content.editable = {mode : "inline", confirmation: "삭제하시겠습니까?"};
			}
		}
	};
	
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
			toolbar: lib_content.toolbar,
			messages: {
				commands: {
				cancel: "취소",
				canceledit: "취소",
				create: "행추가+",
				destroy: "삭제",
				edit: "수정",
				save: "입력",
				select: "조회",
				update: "저장"
				}
			},
			editable : lib_content.editable,
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
		
//		if(!gfn_isNull(lib_content.periodArea)){
//			//시작날짜 세팅
//			var date = new Date();
//			date.setDate(date.getDate()+gridObject.crud.read.period.stdt)
//			$("#"+gridObject.layoutId+"_stdt").kendoDatePicker({
//				culture:"ko-KR",
//				format:'yyyy-MM-dd',
//				value : date,
//				change:function(){
//					$("#"+gridObject.layoutId+"_hidStdt").val($("#"+gridObject.layoutId+"_stdt").val());
//					lib_content.grid.dataSource.read();
//				}
//			});
//			$("#"+gridObject.layoutId+"_hidStdt").val($("#"+gridObject.layoutId+"_stdt").val());
//			
//			//종료날짜 세팅
//			var date = new Date();
//			date.setDate(date.getDate()+gridObject.crud.read.period.eddt)
//			$("#"+gridObject.layoutId+"_eddt").kendoDatePicker({
//				culture:"ko-KR",
//				format:'yyyy-MM-dd',
//				value: date,
//				change:function(){
//					$("#"+gridObject.layoutId+"_hidEddt").val($("#"+gridObject.layoutId+"_eddt").val());
//					lib_content.grid.dataSource.read();
//				}
//			});
//			$("#"+gridObject.layoutId+"_hidEddt").val($("#"+gridObject.layoutId+"_eddt").val());
//		}
		
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
		

	}
	
	//추가 버튼
	if(createAuth){
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-add", function (e) {
			if(!gfn_isEmpty(gridObject.crud.create.openFunc)){
				gfn_loading(true);
				if(typeof gridObject.crud.create.openFunc == "function"){
					gridObject.crud.create.openFunc("NEW");
				}else{
					eval(gridObject.crud.create.openFunc)("NEW");
				}
				setTimeout(function(){gfn_loading(false)},200);
			}
		});
	}
	
	//삭제버튼
	if(destroyAuth){
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-delete", function (e) {
			if(!gfn_isEmpty(gridObject.crud.destroy.callback)){
				kendo.confirm(gfn_getMsg("pop_confirmDelete")).done(function(){			//삭제하시겠습니까?
					gfn_loading(true);
					if(typeof gridObject.crud.destroy.callback == "function"){
						gridObject.crud.destroy.callback();
					}else{
						eval(gridObject.crud.destroy.callback)();
					}
					setTimeout(function(){gfn_loading(false)},200);
				});
			}
		});
	}

	//마스터테이블 더블 클릭
	if(updateAuth){
		$("#"+gridObject.layoutId+" tbody").on("dblclick", "tr", function(e){
			if(!gfn_isEmpty(gridObject.crud.update.openFunc)){
				gfn_loading(true);
				if(typeof gridObject.crud.update.openFunc == "function"){
					gridObject.crud.update.openFunc("EDT",lib_content.grid.dataItem($(e.target).closest('tr')));
				}else{
					eval(gridObject.crud.update.openFunc)("EDT",lib_content.grid.dataItem($(e.target).closest('tr')));
				}
				
				setTimeout(function(){gfn_loading(false)},200);
			}
		});
	}
	
	//kendo ui 체크박스 전체선택 해제 문제 해결(그리드 선택 단위 단일셀로 할 경우 전체해제 먹통)(콘솔창에 나오는 에러는 무엇인가..)- jkkim 0401
	if(gridObject.columns.filter(function(e){return e.selectable == true}).length){
		$("#"+ gridObject.layoutId +" .k-header .k-checkbox").change(function(){
			if($(this).is(":checked") == false){
				$("#"+ gridObject.layoutId +" .k-grid-content").find(".k-checkbox").each(function(item, index){
					$(index).click();
				})
			}
		})
	}
	
	return lib_content.grid;
}

//object형  grid 세팅(주로 1:n 데이터 동시저장 구조에서 사용)
this.gfn_objectDatagrid_set = function(gridObject){
	
	var lib_content = {};
	
	var readAuth = gfn_isEmpty(gridObject.crud.read) == true ? false : gfn_isEmpty(gridObject.crud.read.auth) == true ? true : gfn_hasAuth(gridObject.crud.read.auth);
	var createAuth = gfn_isEmpty(gridObject.crud.create) == true ? false : gfn_isEmpty(gridObject.crud.create.auth) == true ? true : gfn_hasAuth(gridObject.crud.create.auth);
	var updateAuth = gfn_isEmpty(gridObject.crud.update) == true ? false : gfn_isEmpty(gridObject.crud.update.auth) == true ? true : gfn_hasAuth(gridObject.crud.update.auth);
	var destroyAuth = gfn_isEmpty(gridObject.crud.destroy) == true ? false : gfn_isEmpty(gridObject.crud.destroy.auth) == true ? true : gfn_hasAuth(gridObject.crud.destroy.auth);
	var excelAuth = gfn_isEmpty(gridObject.crud.excel) == true ? false : gfn_isEmpty(gridObject.crud.excel.auth) == true ? true : gfn_hasAuth(gridObject.crud.excel.auth);
	var uploadAuth = gfn_isEmpty(gridObject.crud.upload) == true ? false : gfn_isEmpty(gridObject.crud.upload.auth) == true ? true : gfn_hasAuth(gridObject.crud.upload.auth);
	
	//검색영역
	if(readAuth == false || (!gfn_isEmpty(gridObject.crud.read.search) && gridObject.crud.read.search == false)){
		lib_content.searchArea = '';
	}else{
		lib_content.searchArea = '<span class="jte-search-aria"><label>'+gfn_getMsg("ui_search")+' : </label><input id=\"'+gridObject.layoutId+'_shSelBox\" style="width:140px;"/>'			//검색(UI)
		+'<input type=\"text\" id=\"'+gridObject.layoutId+'_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\" style="width:140px;"/>'					//조회(Input)
		+'<a role=\"button\" class=\"k-button k-button-icontext jte-search\"><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>'			//조회버튼
		+'<input id=\"'+gridObject.layoutId+'_hidShSelBox\" type=\"hidden\">'
		+'<input id=\"'+gridObject.layoutId+'_hidShSelTxt\" type=\"hidden\">'
		+'<input id=\"'+gridObject.layoutId+'_hidSelected\" type=\"hidden\"></span>';
	}
		
	//추가버튼
	lib_content.addArea = createAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-add\"><span class=\"k-icon k-i-plus\"></span>'+gfn_getMsg("btn_add")+'</a>';

	//삭제버튼
	lib_content.destroyArea ='';
	if(destroyAuth && gridObject.crud.destroy.type != 'pop'){
		lib_content.destroyArea = '<a role=\"button\" class=\"k-button k-button-icontext jte-delete\"><span class=\"k-icon k-i-close\"></span>'+gfn_getMsg("btn_delete")+'</a>';
	}
	//새로고침
//	if(readAuth == false || gfn_isEmpty(gridObject.crud.read.refresh) == false || gridObject.crud.read.refresh == false){
//		lib_content.refreshArea = '';
//	}else{
//		lib_content.refreshArea = readAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-refresh\"><span class=\"k-icon k-i-refresh\"></span>'+"초기화"+'</a>';
//	}
	//엑셀
	//엑셀 title이 없는 경우 기본 이름
	var excelTitle = gfn_getMsg("btn_excelDownload");
	
	if(excelAuth && !gfn_isEmpty(gridObject.crud.excel.title)){
		excelTitle = gridObject.crud.excel.title;
	}
	
	lib_content.excelArea = excelAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext k-grid-excel\"><span class=\"k-icon k-i-file-excel\"></span>'+ excelTitle+'</a>';

	var uploadTitle = gfn_getMsg("btn_excelUpload","엑셀 업로드");
	
	if(uploadAuth && !gfn_isEmpty(gridObject.crud.upload.title)){
		uploadTitle = gridObject.crud.upload.title;
	}
	
	lib_content.uploadArea = uploadAuth == false ? '' : '<a role=\"button\" class=\"k-button k-button-icontext jte-upload-btn\"><span class=\"k-icon k-i-file-excel\"></span>'+ uploadTitle+'</a>';
	
	
	//커스텀 타이틀 
	if(readAuth == false || gfn_isEmpty(gridObject.customTitle) == true || gfn_isEmpty(gridObject.customTitle.html) == true){
		lib_content.customArea = "";
	}else{
		lib_content.customArea = $(gridObject.customTitle.html).css("float","left").clone().wrapAll("*").parent().html();
	}
	//검색 파라미터
	lib_content.requestObject ={}
	
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		data : gridObject.childItems,
		schema: {
			 model : gridObject.model
 		},
		pageSize: 1000,
		serverPaging: false,
		serverFiltering: false,
		serverSorting: false,
	});
	
	//툴바
	lib_content.toolbar = [];
	
	lib_content.editable = false;
	
	if(gfn_isEmpty(gridObject.toolbar) == false){
		lib_content.toolbar =  gridObject.toolbar
		for(var barItem in gridObject.toolbar){
			if(gridObject.toolbar[barItem] == "create"){
				lib_content.editable = {mode : "inline", destroy : false,  confirmation: false};
				
			}
			
			if(gridObject.toolbar[barItem] == "modify"){
				lib_content.editable = {mode : "inline", destroy : false,  confirmation: false};
				gridObject.toolbar.pop(gridObject.toolbar[barItem]);
			}
		}
	}else{
		lib_content.toolbar = [
			 	"search",
				//{template: kendo.template(lib_content.searchArea)},
				{template: kendo.template(lib_content.addArea)},
				{template: kendo.template(lib_content.destroyArea)},
				//{template: kendo.template(lib_content.refreshArea)},
				{template: kendo.template(lib_content.uploadArea)},
				{template: kendo.template(lib_content.excelArea)}
		];
	}
	
	//커스텀 타이틀 위치 start/end (default : start)
	if(gfn_isEmpty(gridObject.customTitle) == false && gfn_isEmpty(gridObject.customTitle.html) == false && 
			gfn_isEmpty(gridObject.customTitle.position) == false && gfn_isEmpty(lib_content.grid)){
		if(gridObject.customTitle.position == 'start'){
			lib_content.toolbar.unshift({template: kendo.template(lib_content.customArea)});
		}else if(gridObject.customTitle.position == 'end'){
			lib_content.toolbar.push({template: kendo.template(lib_content.customArea)});
		}else{
			lib_content.toolbar.unshift({template: kendo.template(lib_content.customArea)});
		}
	}else{
		lib_content.toolbar.unshift({template: kendo.template(lib_content.customArea)});
	}
	
	//grid 정의
	$("#"+gridObject.layoutId).kendoGrid({
		dataSource: dataSource,
		columns: gridObject.columns,
		allowCopy:true,
		resizable: true,
 		columnMenu: true,
 		sortable: {
			mode: "multiple",
			allowUnsort: false
		},
		selectable: gfn_isNull(lib_content.selectable) == true ? "multiple cell" : lib_content.selectable,
		navigatable: true,
		pageable:false,
		toolbar: lib_content.toolbar,
		messages: {
			commands: {
			cancel: "취소",
			canceledit: "취소",
			create: "행추가+",
			destroy: "삭제",
			edit: "수정",
			save: "입력",
			select: "조회",
			update: "저장"
			}
		},
		editable : lib_content.editable,
		excel: {
			allPages: true,
			fileName : excelAuth == false ? '' : gfn_isEmpty(gridObject.crud.excel.fileName) == true ? '' :gridObject.crud.excel.fileName,
			proxyURL : excelAuth == false ? '' : gfn_isEmpty(gridObject.crud.excel.url) == true ? '' :gridObject.crud.excel.url
		},
		excelExport: function(e) {
			e.workbook.fileName = "Grid.xlsx";
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
	
	/* 초기화 이벤트*/
	$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-refresh", function (e) {
		gridObject.selectedItems = gridObject.origin;
		
		lib_content.grid.dataSource.read();
	});
	
	//추가 버튼
	if(createAuth){
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-add", function (e) {
			if(!gfn_isEmpty(gridObject.crud.create.openFunc)){
				gfn_loading(true);
				if(typeof gridObject.crud.create.openFunc == "function"){
					gridObject.crud.create.openFunc("NEW");
				}else{
					eval(gridObject.crud.create.openFunc)("NEW");
				}
				setTimeout(function(){gfn_loading(false)},200);
			}
		});
	}
	
	//삭제버튼
	if(destroyAuth){
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-delete", function (e) {
			if(!gfn_isEmpty(gridObject.crud.destroy.callback)){
				kendo.confirm(gfn_getMsg("pop_confirmDelete")).done(function(){			//삭제하시겠습니까?
					gfn_loading(true);
					if(typeof gridObject.crud.destroy.callback == "function"){
						gridObject.crud.destroy.callback();
					}else{
						eval(gridObject.crud.destroy.callback)();
					}
					setTimeout(function(){gfn_loading(false)},200);
				});
			}
		});
	}

	//마스터테이블 더블 클릭
	if(updateAuth){
		$("#"+gridObject.layoutId+" tbody").on("dblclick", "tr", function(e){
			if(!gfn_isEmpty(gridObject.crud.update.openFunc)){
				gfn_loading(true);
				if(typeof gridObject.crud.update.openFunc == "function"){
					gridObject.crud.update.openFunc("EDT",lib_content.grid.dataItem($(e.target).closest('tr')));
				}else{
					eval(gridObject.crud.update.openFunc)("EDT",lib_content.grid.dataItem($(e.target).closest('tr')));
				}
				
				setTimeout(function(){gfn_loading(false)},200);
			}
		});
	}
	
	//업로드 버튼
	if(uploadAuth){
		$("#"+gridObject.layoutId).find(".k-grid-toolbar").on("click", ".jte-upload-btn", function (e) {
			if(!gfn_isEmpty(gridObject.crud.upload.callback)){
				gfn_upload_open(gridObject.crud.upload.callback);
			}
		});
	}
	
	//kendo ui 체크박스 전체선택 해제 문제 해결(그리드 선택 단위 단일셀로 할 경우 전체해제 먹통)(콘솔창에 나오는 에러는 무엇인가..)- jkkim 0401
	if(gridObject.columns.filter(function(e){return e.selectable == true}).length){
		$("#"+ gridObject.layoutId +" .k-header .k-checkbox").change(function(){
			if($(this).is(":checked") == false){
				$("#"+ gridObject.layoutId +" .k-grid-content").find(".k-checkbox").each(function(item, index){
					$(index).click();
				})
			}
		})
	}	
	
	return lib_content.grid;
}

//object형  grid 저장(주로 ?:n 데이터 동시저장 구조에서 사용)
this.gfn_objectDataGrid_save = function(saveObject){
	var svgj = saveObject;
	/*	saveObject 정보
	 	- tgObj : lfo_Grd, //대상 그리드 오브젝트 
		- prmt : savePrmt,	//저장하고자 하는 데이터
		- pk : pk,			//저장하고자 하는 데이터의 PK
		- autokey : true	//Create의 경우 prmt에 키가 있는 경우 false, 없는경우 true
	*/
	
	var failFalg = true;
	
	var saveAction = "";
	
	//action값  체크
	if($("#" + svgj.tgObj.popId + "_form [name=action]").length != 0){
		saveAction  = $("#" + svgj.tgObj.popId + "_form [name=action]").val();
	}else if(!gfn_isEmpty(saveObject.prmt.action)){
		saveAction = saveObject.prmt.action;
	}else{
		saveAction = "C";
	}
	
	//신규저장되는 값인지 확인을 위함
	var newFlag = true;
	
	//DB에 저장된 값인 경우 수정상태로 변경 
	if(saveAction == 'K'){
		svgj.prmt.action = 'U';
	}

	if(typeof(svgj.pk) == "string"){//pk가 하나인경우
		svgj.tgObj.childItems.forEach(function(item, index){
			if(item[svgj.pk] == svgj.prmt[svgj.pk]){
				if(saveAction == 'CU'){
					svgj.tgObj.childItems[index] = svgj.prmt;
					svgj.tgObj.childItems[index].action = 'C';
				}else if(saveAction != 'C'){
					svgj.tgObj.childItems[index] = svgj.prmt;
				}else{
					gfn_warnBox({msg : "중복된 키입니다."});
					failFalg = false;
				}
				newFlag = false;
			}
		});
	}else if (typeof(svgj.pk) == "object"){//pk가 복수인경우
		svgj.tgObj.childItems.forEach(function(item, index){
			var multiPkFlag = false;
			for(var i = 0; i< svgj.pk.length; i++){
				if(item[svgj.pk[i]] != svgj.prmt[svgj.pk[i]]){
					multiPkFlag = true;
				}
			}
			if(!multiPkFlag && saveAction != 'C'){
				svgj.tgObj.childItems[index] = svgj.prmt;
				newFlag = false;
				return false;
			}else if(!multiPkFlag && saveAction == 'C'){
				gfn_warnBox({msg : "중복된 키입니다."});
				newFlag = false;
				failFalg = false;
				return false;
			}
		});
	}
	
	//중복키로 인해 실패시 리턴값 false
	if(!failFalg){
		return false;
	}
	
	//기존 object에서 동일한 PK가 신규등록
	if(newFlag && saveAction == 'C'){
		//키가 없다면 임시키 생성
		if(svgj.autokey) {
			svgj.prmt[svgj.pk] = 'TEMP_' + svgj.tgObj.childItems.length;
		}
		svgj.tgObj.childItems.push(svgj.prmt);
	}
	
	//저장된 값 리턴
	return svgj.tgObj.childItems;
}

//object형  grid 삭제(주로 ?:n 데이터 동시저장 구조에서 사용)
this.gfn_objectDataGrid_delete = function(deleteObject){
	/*	deleteObject 정보
	 	- tgObj : lfo_Grd, //대상 그리드 오브젝트 
		- prmt : savePrmt,	//저장하고자 하는 데이터
		- pk : pk,			//저장하고자 하는 데이터의 PK
		- autokey : true	//Create의 경우 prmt에 키가 있는 경우 false, 없는경우 true
	*/
	
	var delObj = deleteObject;
	if(typeof(delObj.pk) == "string"){//pk가 하나인경우
		//기존 object에서 저장되는 pk값을 비교하여 해당 PK의 값이 있으면 삭제 상태값으로 변경 해준다.
		delObj.tgObj.childItems.forEach(function(item,index){
			var delAction = item.action;
			if(item[delObj.pk] == delObj.prmt[delObj.pk]){
				if(delAction == 'U' || delAction == 'K' ){
					delObj.tgObj.childItems[index].action = 'D';
				}else if(delAction == 'C'){
					delObj.tgObj.childItems.splice(index,1);
				}
			}
		});
	}else if (typeof(delObj.pk) == "object"){//pk가 복수인경우
		delObj.tgObj.childItems.forEach(function(item,index){
			var delAction = item.action;
			var multiPkFlag = true;
			for(var i = 0; i< delObj.pk.length; i++){
				if(item[delObj.pk[i]] != delObj.prmt[delObj.pk[i]]){
					multiPkFlag = false;
				}
			}
			
			if(multiPkFlag && (delAction == 'U' || delAction == 'K')){
				delObj.tgObj.childItems[index].action = 'D';
			}else if(multiPkFlag && delAction == 'C'){
				delObj.tgObj.childItems.splice(index,1);
			}
		});
	}
	return delObj.tgObj.childItems;
}

/*
 * 입력 / 수정 팝업화면 세팅
 * 1. 다국어 버튼 활성화(이벤트 포함)
 * 2. Form 영역 활성화
 * 3. 입력/수정 버튼 활성화(이벤트 포함)
 * */

this.gfn_popform_set = function(gridObject, mode, selectedItem, saveAction){
	//tooltip 추가
	$("#"+gridObject.popId).kendoTooltip({
		autoHide: true,
		filter: ".jte-tooltip",
		width: 200,
		height: 50,
		position: "top"
	});
	
	//다국어정보 세팅
	var prefix = "";
	var defId = "";
	var defNm = "";
	//???
//	if($(".jte-msgBox").length){
//		prefix = $(".jte-msgBox").attr("prefix");
//		defId = $(".jte-msgBox").attr("defId");
//		defNm = $(".jte-msgBox").attr("defNm");
//		
//		//호출 시 최초 다국어 초기화
//		$("#msg_"+defId).val("");
//	}
	
	//다국어버튼 이벤트 세팅
	$(".jte-msgBox").on("click", function (e) {
		prefix = $(this).attr("prefix");
		defId = $(this).attr("defId");
		defNm = $(this).attr("defNm");
		// 저장 시 콜백 입력된 결과를 임시저장했다가 서비스단에서 저장
		var option ={
			saveCallback : function(rtnMsg){
				$("#"+gridObject.popId + "_form #msg_"+defId).val(JSON.stringify(rtnMsg));
			}
		};
		
		//임시저장된 데이터가 있으면 임시데이터 로드를 위함
		if(!gfn_isEmpty($(this).closest('table').find("#msg_"+defId).val())){
			option.saveMsg = JSON.parse($(this).closest('table').find("#msg_"+defId).val());
		}
		
		//기본설정
		if($("#"+gridObject.popId + "_form [name = action]").val() == 'C'){
			option.mode = "PG_NEW";
			option.defNm = $("#" + gridObject.popId + " [name=" + defNm +"]").val();
		}else if($("#"+gridObject.popId+"_form [name = action]").val() == 'U'){
			option.mode = "PG_EDT";
			option.defId = prefix + "_" + $("#" + gridObject.popId + " [name=" + defId +"]").val();
			option.defNm = $("#" + gridObject.popId + " [name=" + defNm +"]").val();
		}
		gfn_msgSetPop(option);
	});
	
	if(mode=='NEW'){
		$("#"+gridObject.popId+"_form").find("input").each(function(index,item){
			
			var formatType = $(item).attr("format");
			var fillTextName = $(item).attr("name");
			
			//화면설정 리드온니 처리
			if(!gfn_isEmpty($(item).attr("notmod")) &&$(item).attr("notmod") == 'readOnly'){
				$(item).attr("readonly",true)
			}
			
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
				var fileExtention = false;
				if(!gfn_isEmpty($(item).attr("extention"))){
					fileExtention = $(item).attr("extention").split(",");						
				}
				//파일명이 너무 길 경우 길이 계산하여 길이값 최대치 조정
				var textMaxWidth = $("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest("td").width() - 160;
				
				if($("#"+gridObject.popId+"_form [name = "+fillTextName+"]").attr("data-role") != "upload"){
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoUpload({
						template: '<li class="k-file #if(files[0].error){#k-file-error#}#" data-uid="#=files[0].uid #">'+
						'<span class="k-progress"></span>'+
						'<span class="k-file-extension-wrapper">'+
							'<span class="k-file-extension">#=files[0].extension#</span>'+
							'<span class="k-file-state"></span>'+
						'</span>'+
						'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
							'<span class="k-file-name" style="width:'+textMaxWidth+'px;" title="#=name#">#=name#</span>'+
							'<span class="k-file-size">#=size# bytes</span>'+
							'#if(files[0].error){#<span class="k-file-validation-message k-text-error">#=  files[0].error #</span>#}#' +
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
						},select: function(e) {
							var files = e.files;
							for (var i = 0; i < files.length; i+= 1) {
								var file = files[i];
								if (file.validationErrors && file.validationErrors.length > 0) {
									file.error = file.validationErrors[0];
								}
							}
						}
						,success: gfn_attachProc
						,remove : function (e) {
							var attachFiles = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
							attachFiles.forEach(function(item,index){
								if(item.attachOrigin == e.files[0].name){
									e.data = item;
								}
							});
						},validation:{allowedExtensions : fileExtention}
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
			//화면설정 리드온니 처리
			if(!gfn_isEmpty($(item).attr("notmod")) && $(item).attr("notmod") == 'readOnly'){
				$(item).attr("readonly",true)
			}
			
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
		
		if(gfn_isNull(saveAction)){
			$("#"+gridObject.popId+"_form [name = action]").val("C");
		}
		
		//추가버튼 이벤트 바인딩
		$("#"+gridObject.popId+" .jte-update").hide();
		$("#"+gridObject.popId+" .jte-destroy").hide();
		$("#"+gridObject.popId+" .jte-create").show();
		//이벤트중복방지
		if($("#"+gridObject.popId+" .jte-create").length > 0){
			var event = $._data($("#"+gridObject.popId+" .jte-create")[0],"events")
			if(gfn_isEmpty(event) || !event.click){
				$("#"+gridObject.popId+" .jte-create").on("click",function(){
					if(typeof(gridObject.crud.create.callback) == 'function'){
						gridObject.crud.create.callback("create");
					}else{
						eval(gridObject.crud.create.callback)("create");
					}
				});
			}
		}
	}else if('EDT'){
		$("#"+gridObject.popId+"_form").find("input").each(function(index,item){
			//화면설정 리드온니 처리
			if(!gfn_isEmpty($(item).attr("notmod")) && ($(item).attr("notmod") == 'readOnly' || $(item).attr("notmod") == 'updateRead')){
				$(item).attr("readonly",true)
			}
			
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
				var fileExtention = false;
				if(!gfn_isEmpty($(item).attr("extention"))){
					fileExtention = $(item).attr("extention").split(",");						
				}
				
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
					
					//파일명이 너무 길 경우 길이 계산하여 길이값 최대치 조정
					var textMaxWidth = $("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest("td").width() - 160;
					
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoUpload({
						template: '<li class="k-file #if(files[0].error){#k-file-error#}#" data-uid="#=files[0].uid #">'+
						'<span class="k-progress"></span>'+
						'<span class="k-file-extension-wrapper">'+
							'<span class="k-file-extension">#=files[0].extension#</span>'+
							'<span class="k-file-state"></span>'+
						'</span>'+
						'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
						'<span class="k-file-name" style="width:'+textMaxWidth+'px;" title="#=name#">#=name#</span>'+
							'<span class="k-file-size">#=size# bytes</span>'+
							'#if(files[0].error){#<span class="k-file-validation-message k-text-error">#=  files[0].error #</span>#}#' +
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
						},select: function(e) {
							var files = e.files;
							for (var i = 0; i < files.length; i+= 1) {
								var file = files[i];
								if (file.validationErrors && file.validationErrors.length > 0) {
									file.error = file.validationErrors[0];
								}
							}
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
						,validation:{allowedExtensions : fileExtention}
						,files:fileList
					});
				}else{
					//파일명이 너무 길 경우 길이 계산하여 길이값 최대치 조정
					var textMaxWidth = $("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest("td").width() - 160;
					
					$("#"+gridObject.popId+"_form [name = "+fillTextName+"]").kendoUpload({
						template: '<li class="k-file #if(files[0].error){#k-file-error#}#" data-uid="#=files[0].uid #">'+
						'<span class="k-progress"></span>'+
						'<span class="k-file-extension-wrapper">'+
							'<span class="k-file-extension">#=files[0].extension#</span>'+
							'<span class="k-file-state"></span>'+
						'</span>'+
						'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
							'<span class="k-file-name" style="width:'+textMaxWidth+'px;" title="#=name#">#=name#</span>'+
							'<span class="k-file-size">#=size# bytes</span>'+
							'#if(files[0].error){#<span class="k-file-validation-message k-text-error">#=  files[0].error #</span>#}#' +
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
						},select: function(e) {
							var files = e.files;
							for (var i = 0; i < files.length; i+= 1) {
								var file = files[i];
								if (file.validationErrors && file.validationErrors.length > 0) {
									file.error = file.validationErrors[0];
								}
							}
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
						}
						,validation:{allowedExtensions : fileExtention}
						,files:files
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
			//화면설정 리드온니 처리
			if(!gfn_isEmpty($(item).attr("notmod")) &&$(item).attr("notmod") == 'readOnly'){
				$(item).attr("readonly",true)
			}
			
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
		
		if(gfn_isNull(saveAction)){
			$("#"+gridObject.popId+"_form [name = action]").val("U");
		}
		//수정버튼 이벤트 바인딩
		$("#"+gridObject.popId+" .jte-create").hide();
		$("#"+gridObject.popId+" .jte-update").show();
		$("#"+gridObject.popId+" .jte-destroy").hide();
		
		//이벤트 중복방지
		if($("#"+gridObject.popId+" .jte-update").length > 0){
			var event = $._data($("#"+gridObject.popId+" .jte-update")[0],"events");
			if(gfn_isEmpty(event) || !event.click){
				$("#"+gridObject.popId+" .jte-update").on("click",function(){
					if(typeof(gridObject.crud.update.callback) == 'function'){
						gridObject.crud.update.callback("update");
					}else{
						eval(gridObject.crud.update.callback)("update");
					}
				});
			}
		}
		//삭제이벤트 - 팝업인경우
		if(!gfn_isEmpty(gridObject.crud.destroy) && !gfn_isEmpty(gridObject.crud.destroy.type) && gridObject.crud.destroy.type == 'pop'){
			$("#"+gridObject.popId+" .jte-destroy").show();
			//이벤트 중복방지
			if($("#"+gridObject.popId+" .jte-destroy").length > 0){
				var event = $._data($("#"+gridObject.popId+" .jte-destroy")[0],"events");
				if(gfn_isEmpty(event) || !event.click){
					$("#"+gridObject.popId+" .jte-destroy").on("click",function(){
						if(typeof(gridObject.crud.destroy.callback) == 'function'){
							gridObject.crud.destroy.callback("destroy");
						}else{
							eval(gridObject.crud.destroy.callback)("destroy");
						}
					});
				}
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
			if(!gfn_isEmpty(value.rules)){
				rules[key] = value.rules;
			//화면설정 추가로인한 분기처리
			}else if(!gfn_isEmpty(value.fieldId)){
				rules[key] = function(input){
					if (input.is("[name="+value.fieldId+"]")){
						return eval(value.check);
					}
					return true;
				}
			}
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
		
		var insertFiles = $("#insertAttach").val() == "" ? [] : JSON.parse($("#insertAttach").val());
		e.response.attachFiles.forEach(function(insrtItem,insrtIndex){
			insrtItem.attachStatus = "NEW";
			
			insertFiles.push(insrtItem);
			$("#insertAttach").val(JSON.stringify(insertFiles));
		});
		
//			$("#insertAttach").val($("#insertAttach").val() + "NEW||" + item.fileName + "||" + item.basePath + "@@");
//		});
	}
	
	//파일 삭제
	if (e.operation == "remove") {
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
			var deleteFiles = $("#deleteAttach").val() == "" ? [] : JSON.parse($("#deleteAttach").val());
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
		
		//파일명이 너무 길 경우 길이 계산하여 길이값 최대치 조정
		var textMaxWidth = $("#"+gridObject.popId+"_form [name = "+fillTextName+"]").closest("td").width() - 160;
		
		$("#attachFiles").kendoUpload({
			template: '<li class="k-file #if(files[0].error){#k-file-error#}#" data-uid="#=files[0].uid #">'+
			'<span class="k-progress"></span>'+
			'<span class="k-file-extension-wrapper">'+
				'<span class="k-file-extension">#=files[0].extension#</span>'+
				'<span class="k-file-state"></span>'+
			'</span>'+
			'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
				'<span class="k-file-name" style="width:'+textMaxWidth+'px;" title="#=name#">#=name#</span>'+
				'<span class="k-file-size">#=size# bytes</span>'+
				'#if(files[0].error){#<span class="k-file-validation-message k-text-error">#=  files[0].error #</span>#}#' +
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
			},select: function(e) {
				var files = e.files;
				for (var i = 0; i < files.length; i+= 1) {
					var file = files[i];
					if (file.validationErrors && file.validationErrors.length > 0) {
						file.error = file.validationErrors[0];
					}
				}
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
			,files:fileList
		});
	}
	$("#" + areaId +" .k-dropzone").hide();
	$("#" + areaId).find(".k-upload-action").each(function(item){
		if($(this).attr("aria-label") == "Remove"){
			$(this).hide();
		}
	})
}

this.gfn_scrollView_set = function(fileObject){
	
	var lib_imgView = {};
	
	//페이징
	lib_imgView.paging = {};
	var pageUse = gfn_isNull(fileObject.paging) == true ? true : fileObject.paging == true ? true : false;
	lib_imgView.paging.pageable = pageUse == false ? false : {pageSizes: true};
	lib_imgView.paging.pageSize = pageUse == false ? 1 : 3;
	lib_imgView.paging.serverPaging = pageUse == false ? false : true;
	
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : '/attach/getAttachFilesPage',
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
					fileObject.prmt.page = data.page;
					fileObject.prmt.take = data.take;
					fileObject.prmt.rows = data.pageSize;
					fileObject.prmt.sort = sort;

				return fileObject.prmt;
				}	
			}
		},
		batch: true,
		schema: {
			model: fileObject.model,
			data: "rows",
			total: "count"
 		},
 		
		pageSize : lib_imgView.paging.pageSize,
		serverPaging: lib_imgView.paging.serverPaging
	});
	
	$("#" + fileObject.viewId).kendoScrollView({
		dataSource: dataSource,
		template: gfn_scrollView_unit,
		contentHeight: "100%",
		enablePager: false
	});
}

this.gfn_scrollView_unit = function(e){
	var html = '<div id="imagePopDiv" style="overflow:auto;"><img id="imagePopImg" /></div><div class="img-wrapper">';
		
	for(i=0; i < e.length; i++){
		var imageUrl = e[i]["attachLocation"] + e[i]["attachFilename"];
		
		html += '<div onclick = "lfn_imgDetail_Open(\''+imageUrl+'\');">' + 
		'<div style="width: 100px; height: 100px; background-image: url(' + imageUrl + '); background-repeat:no-repeat; background-size: cover;"></div>' + 
		'<p>'+ e[i]["attachOrigin"] +'</p>' + 
		'</div>'
	}
	html += '</div>';
 return html;
}

//이미지 팝업
this.lfn_imgDetail_Open = function(imageUrl){
	var options = {
		modal:true, 
		width: "830px", 
		height: "380px", 
		id : "imagePopDiv", 
		title: "이미지 원본",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	
	//팝업이 생성되기 전에 이미지가 등록되기 때문에 처음엔 매핑후 팝업 오픈
	if($("#imagePopDiv").length > 0){
		$("#imagePopImg").attr('src',imageUrl);
		//너무 큰 이미지 사이즈 조정(팝업사이즈 조정시 조정 필요)
		if($("#imagePopImg").css('width').replace('px','') > 800){
			$("#imagePopImg").css('width',"100%");
		}
	}
	
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		$("#imagePopImg").attr('src',imageUrl);
		//너무 큰 이미지 사이즈 조정(팝업사이즈 조정시 조정 필요)
		if($("#imagePopImg").css('width').replace('px','') > 800){
			$("#imagePopImg").css('width',"100%");
		}
	}
	this.gfn_winOpen(options);	
}

//업로드 팝업 오픈
this.gfn_upload_open = function(callback){
	//업로드 팝업 html
	var html = '<div id="jteUploadPop">'+
			'<form id="jteUploadPop_form">'+
				'<table style="width:100%;"class="BasicTable">'+
					'<tr><td><i class="fas fa-caret-right"></i> 파일 업로드 : </td></tr>'+
					'<tr>'+
						'<td>'+
							'<input name="uploadFile" type="file" format="file" aria-label="files"/>'+
						'</td>'+
					'</tr>'+
				'</table>'+
			'</form>'+
			'<div class="final-btn-area" style="text-align:center;">'+
				'<button class="k-button k-primary final-btn jte-upload-btn" name="uploadSaveBtn" type="button">'+ gfn_getMsg("pop_save", "저장") +'</button>'+
				'<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop(\'jteUploadPop\');">'+ gfn_getMsg("pop_cancel", "취소") +'</button>'+
			'</div>'+
		'</div>';
	
	$("#_hiddenPopUpLayout").html(html);
	
	var options = {
		modal:true, 
		width: "520px",
		height: "270px",
		id : "jteUploadPop",
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	//팝업이 생성된 뒤 동작해야할 함수 입력
	options.callback = function(){
		$("#jteUploadPop_form [name = uploadFile]").kendoUpload({
			template: '<li class="k-file #if(files[0].error){#k-file-error#}#" data-uid="#=files[0].uid #">'+
			'<span class="k-progress"></span>'+
			'<span class="k-file-extension-wrapper">'+
				'<span class="k-file-extension">#=files[0].extension#</span>'+
				'<span class="k-file-state"></span>'+
			'</span>'+
			'<span class="k-file-name-size-wrapper" onclick = "gfn_attachDownload(this)">'+
				'<span class="k-file-name" style="width:300px;" title="#=name#">#=name#</span>'+
				'<span class="k-file-size">#=size# bytes</span>'+
				'#if(files[0].error){#<span class="k-file-validation-message k-text-error">#=  files[0].error #</span>#}#' +
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
//				saveUrl: "/excelUtil/excelUpload",
//				removeUrl: "/attach/attachFilesTempDelete",
				autoUpload:false
			},select: function(e) {
				var files = e.files;
				for (var i = 0; i < files.length; i+= 1) {
					var file = files[i];
					if (file.validationErrors && file.validationErrors.length > 0) {
						file.error = file.validationErrors[0];
					}else{
						var form = $('#jteUploadPop_form')[0];
						var data = new FormData(form);
						$.ajax({
							async:false,
							url : "/excelUtil/excelUpload",
							type: "POST",
							enctype: 'multipart/form-data',
							processData: false,
							contentType: false,
							data: data,
							success: function(data){
								savePrmt = data.mapList;
								if(savePrmt.length > 0){
									$("#jteUploadPop [name=uploadSaveBtn]").on('click', function(){
										if(typeof callback == "function"){
											callback(savePrmt);
											gfn_closePop('jteUploadPop');
										}else{
											eval(callback)(savePrmt);
											gfn_closePop('jteUploadPop');
										}
									});
								}else{
									gfn_warnBox({msg : "excel 파일에 데이터가 없습니다."});
								}
							},error: function(ex){
								gfn_loading(false);
								gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
							}
						});
					}
				}
			},validation:{allowedExtensions : [".xls",".xlsx"]}
			,multiple:false
			//success:  function(e) {console.log("xx");}
			,remove : function (e) {
				
			}
		});
	};
	
	this.gfn_winOpen(options);
}
