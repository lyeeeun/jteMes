//검색영역
var jteComPopGrd_shAr='<label>'+gfn_getMsg("ui_search")+' : </label><input id=\"jteComPopGrd_shSelBox\"/>'																					//검색(UI)
	+'<input type=\"text\" id=\"jteComPopGrd_shSelTxt\" name=\"jteComPopGrd_shSelTxt\" class=\"k-textbox\" placeholder=\"'+gfn_getMsg("input_search")+'\"/>'								//조회(Input)
	+'<a role=\"button\" class=\"k-button k-button-icontext \" onclick=\" gfn_jteComPopGrd_search() \" ><span class=\"k-icon k-i-search\"></span>'+gfn_getMsg("btn_search")+'</a>' 			//조회버튼
	+'<input id=\"jteComPopGrd_hidShSelBox\" type=\"hidden\">'
	+'<input id=\"jteComPopGrd_hidShSelTxt\" type=\"hidden\">'
	+'<input id=\"jteComPopGrd_hidSelected\" type=\"hidden\">';
//새로고침
var jteComPopGrd_refreshBtn = '<a role=\"button\" class=\"k-button k-button-icontext\" onclick=\" gfn_jteComPopGrd_refresh() \"><span class=\"k-icon k-i-refresh\"></span>'+gfn_getMsg("btn_refresh")+'</a>';

var comPopObj;

this.gfn_openCustomPop = function(type, callback, prmtObj){
	
	comPopObj = {};
	
	//기존창 삭제 및 초기화
	if($("#popArea").length > 0){
		$("#popArea").data("kendoWindow").close();
		$("#popArea").remove();	
	}
	
	$("#libPopBox").append("<div id='popArea' style='height:100%;'></div>");
	
	var cachePopInfo = libUtil.popList.filter(function(item){return item.popId == type});
	
	if(gfn_isEmpty(cachePopInfo)){
		console.log("지정된 팝업이 없습니다.");
		return false;
	}
	
	cachePopInfo = cachePopInfo[0];
	
	//popUp - type
	if(cachePopInfo.popType == "popSetGrid" || cachePopInfo.popType == "popSetTree"){
		comPopObj.type = cachePopInfo.popId;
	}else if(cachePopInfo.popType == "popSetJpql"){
		comPopObj.type == "JPQL"
	}
	
	comPopObj.callback = callback;
	
	comPopObj.width = cachePopInfo.popWidth;
	
	comPopObj.height = cachePopInfo.popHeight;
	
	if (!gfn_isNull(cachePopInfo.popNm)){
		//다국어 예외처리
		try{
			comPopObj.title = eval(cachePopInfo.popNm);
		}catch(e){
			comPopObj.title = cachePopInfo.popNm;
		}
	}else{
		comPopObj.title = "공통팝업";
	}
	
	comPopObj.url = cachePopInfo.popUrl;
	
	comPopObj.model = {fields:{}};
	comPopObj.columns = [];
	comPopObj.shBoxItem = [];
	comPopObj.prmtNm = [];
	comPopObj.prmtVal = [];
	
	//필드정렬
	cachePopInfo.popFieldList.sort(function(a, b) {
		return a.popNum - b.popNum;
	});
	
	//검색된 필드정보 loop
	for(var key in cachePopInfo.popFieldList){
		var field = cachePopInfo.popFieldList[key];
		
		//grid - model 세ㅔ팅
		if(field.popType == "popSetString"){
			comPopObj.model.fields[field.fieldId] = {type: 'string'};
		}else if(field.fieldType == "popSetInt"){
			comPopObj.model.fields[field.fieldId] = {type: 'int'};
		}else if(field.fieldType == "popSetDate"){
			comPopObj.model.fields[field.fieldId] = {type: 'date'};
		}else if(field.fieldType == "popSetBool"){
			comPopObj.model.fields[field.fieldId] = {type: 'bool'};
		}
		
		//필드네임 - 다국어가 있을 수 있어 예외처리해준다.
		var fieldName = '';
		if (!gfn_isNull(field.popNm)){
			//다국어 예외처리
			try{
				fieldName = eval(field.popNm);
			}catch(e){
				fieldName = field.popNm;
			}
		}

		//--그리드 컬럼 세팅--
		var columns = {};
		if(field.popUse == 'comnTrue'){
			columns = {field : field.popId, width : field.popWidth, title : fieldName};
			//그리드 커스텀
			if(!gfn_isNull(field.popTemplate)){
				columns.template = field.popTemplate.replace(/lfn\_/gi,'gfn_myTab\(\)\.lfn\_');
			}
			
			//그리드 커스텀(버튼)
			if(field.popId == 'button'){
				columns.template = '<button class="k-button k-primary" type="button" onclick = "' + callback + '">선택</button>';
			}
			
			//그리드 정렬 순서
			if (!gfn_isNull(field.popNum)){
				columns.popNum = field.popNum;
			}else{
				columns.popNum = 9999;
			}
			
			//그리드 포맷
			if (!gfn_isNull(field.popFormat)){
				columns.format = field.popFormat;
			}
			
			comPopObj.columns.push(columns);
		}
		
		//--그리드 컬럼세팅 종료--
		
	
		
		//검색박스
		if(field.popSearchUse == 'comnTrue'){
			
			if(gfn_isEmpty(field.popSearchValue))field.popSearchValue = field.popId;
			
			comPopObj.shBoxItem.push({text : fieldName, value : field.popSearchValue});
		}
		
		//파라미터
		if(field.popDynamicUse == 'comnTrue' && !gfn_isEmpty(field.popDynamicValue)){
			
			if(field.popType == 'popSetBool'){
				try{
					field.popDynamicValue = eval(field.popDynamicValue);
				}catch(e){
					field.popDynamicValue = field.popDynamicValue;
				}
			}
			comPopObj.prmtNm.push(field.popId);
			comPopObj.prmtVal.push(field.popDynamicValue);
		}
	}
	
	//파라미터 동적 검색 처리
	if(!gfn_isEmpty(prmtObj)){
		for(var key in prmtObj){
			comPopObj.prmtNm.push(key);
			comPopObj.prmtVal.push(prmtObj[key]);
		}
	}
	//grid 그려주기
	gfn_jteComPopGrd_setGrd();
	
	//팝업창 띄우기
	gfn_comOpenPop();
	
	//재호출을 위해
	comPopObj.popGrid = $("#popArea").getKendoGrid();
	
	//이벤트 바인딩
	gfn_jteComPopGrd_EventBind();
}

this.gfn_comOpenPop = function(){
	$("#popArea").kendoWindow({
		width: comPopObj.width,
		height: comPopObj.height,
		position: {
			top : ($(window).height()/2) - (comPopObj.height/2),
			left : ($(window).width()/2) - (comPopObj.width/2)
		},
		resizable : true,
		title: comPopObj.title,
		actions: ["Refresh", "Close"],
		visible: false
	}).data("kendoWindow").open();
}

//grid 생성
this.gfn_jteComPopGrd_setGrd = function(){
	var paging = {};
	var pageUse = gfn_isNull(comPopObj.paging) == true ? true : comPopObj.paging == true ? true : false;
	paging.pageable = pageUse == false ? false : {pageSizes: true};
	paging.pageSize = pageUse == false ? 1000 : 10;
	paging.serverPaging = pageUse == false ? false : true;
	
	//data 불러오기
	var dataSource =  new kendo.data.DataSource({
		transport: {
			read: {
				url : comPopObj.url,
				dataType : "json",
				traditional :true
			},
			parameterMap: function(data, type){
				pageSearchObj ={};
				switch(type) {
				case "read" :
					var sort;
					pageSearchObj = {
							page: data.page,
							take: data.take,
							rows : data.pageSize,
							searchGubun:$("#jteComPopGrd_hidShSelBox").val(),
							searchText:$("#jteComPopGrd_hidShSelTxt").val()
					};
					
					
					if(comPopObj.type == "JPQL"){
						if(!gfn_isEmpty(comPopObj.dynamicField)){
							pageSearchObj.dynamicField = comPopObj.dynamicField;
							pageSearchObj.dynamicValue = comPopObj.dynamicValue;
						}
						var sort =[], order =[];
						$.each(data.sort, function(index,item) {
							sort.push(item.field);
							order.push(item.dir);
						});
						pageSearchObj.sort = sort;
						pageSearchObj.order = order;
					}else{
						sort=''
						$.each(data.sort, function(index,item) {
							sort += item.field+' ' +item.dir+',';
						});
						
						if(!gfn_isEmpty(sort)){
							sort = sort.substring(0,sort.length-1);
						}
						pageSearchObj.sort = sort;
					}
					
					if(!gfn_isNull(comPopObj.prmtNm)){
						comPopObj.prmtNm.forEach(function(item,index){
							pageSearchObj[comPopObj.prmtNm[index]] = comPopObj.prmtVal[index];
						});
					}
				return pageSearchObj;
				}	
			}
		},		
		batch: true,
		schema: {
			 model: comPopObj.model,
			data: "rows",
			total: "count"
		},
		pageSize: paging.pageSize,
		serverPaging: paging.serverPaging,
		serverFiltering: false,
		serverSorting: true
	});
		
	//grid 정의
	$("#popArea").kendoGrid({
		dataSource: dataSource,
		columns: comPopObj.columns,
		allowCopy:true,
		resizable: true,
		columnMenu: true,
		sortable: {
			mode: "multiple",
			allowUnsort: true
		},
		 selectable: "multiple, row",
		navigatable: true,
		pageable: paging.pageable,
		editable: {
			mode:"inline"
		},
		toolbar: [
			{template: gfn_isEmpty(comPopObj.shBoxItem) == true ? kendo.template("") : kendo.template(jteComPopGrd_shAr)},//검색구분자가 없으면 바인딩하지 않음
			{template: kendo.template(jteComPopGrd_refreshBtn)}
		],
		dataBinding: function(e) {
			record = (this.dataSource.page() -1) * this.dataSource.pageSize();
		},
		
	});
}

//이벤트 바인딩
this.gfn_jteComPopGrd_EventBind = function(){
	
	if(!gfn_isEmpty(comPopObj.shBoxItem)){//검색 구분이 없으면 바인딩하지 않음
		//검색 Selectbox 바인딩 
		var shBoxItem = comPopObj.shBoxItem;
		$("#jteComPopGrd_shSelBox").kendoDropDownList({
			dataTextField: "text",
			dataValueField: "value",
			dataSource: shBoxItem,
			index: 0
		});
		
		//검색박스 엔터 이벤트
		$("#jteComPopGrd_shSelTxt").keyup(function(e) {
			if (e.keyCode == 13) {
				gfn_jteComPopGrd_search();
			}
		});
	}
	// 더블 클릭 - 콜백 호출
	$("#popArea tbody").on("dblclick", "tr", function(e){
		if(typeof comPopObj.callback === 'function') {
			comPopObj.callback(comPopObj.popGrid.dataItem($(this)));
			$("#popArea").data("kendoWindow").close();
		}
	});
}

//pop - 검색이벤트
this.gfn_jteComPopGrd_search = function(){
	$("#jteComPopGrd_hidShSelBox").val($("#jteComPopGrd_shSelBox").val());
	$("#jteComPopGrd_hidShSelTxt").val($("#jteComPopGrd_shSelTxt").val());
	comPopObj.popGrid.dataSource.read();
}

/*pop -  새로고침이벤트
	1. 검색구분, 검색 새로고침
	2. 페이징 정보 새로고침
*/
this.gfn_jteComPopGrd_refresh = function(){
	$("#jteComPopGrd_shSelTxt").val("");
	$("#jteComPopGrd_shSelBox").data("kendoDropDownList").select(0);
	$("#jteComPopGrd_hidShSelBox").val("");
	$("#jteComPopGrd_hidShSelTxt").val("");
	
	comPopObj.popGrid.dataSource.query({
		page: 1,
		pageSize: 10
	});
	
	comPopObj.popGrid.dataSource.read();
}