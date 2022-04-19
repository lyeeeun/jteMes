//검색영역
var comPopTreeObj;

this.gfn_openCustomPopTree = function(type, callback, prmtObj){
	comPopTreeObj = {};
	//기존창 삭제 및 초기화
	if($("#popArea").length > 0){
		$("#popArea").data("kendoWindow").close();
		$("#popArea").remove();	
	}
	
	$("#libPopBox").append("<div id='popArea'></div>");
	
	var cachePopInfo = libUtil.popList.filter(function(item){return item.popId == type});
	
	if(gfn_isEmpty(cachePopInfo)){
		console.log("지정된 팝업이 없습니다.");
		return false;
	}
	
	cachePopInfo = cachePopInfo[0];
	
	comPopTreeObj.type = cachePopInfo.popId;
	
	comPopTreeObj.callback = callback;
	
	comPopTreeObj.width = cachePopInfo.popWidth;
	
	comPopTreeObj.height = cachePopInfo.popHeight;
	
	if (!gfn_isNull(cachePopInfo.popNm)){
		//다국어 예외처리
		try{
			comPopTreeObj.title = eval(cachePopInfo.popNm);
		}catch(e){
			comPopTreeObj.title = cachePopInfo.popNm;
		}
	}else{
		comPopTreeObj.title = "공통팝업";
	}
	
	comPopTreeObj.url = cachePopInfo.popUrl;
	
	comPopTreeObj.model = {fields:{}, hasChildren : "hasChildren"};

	
	comPopTreeObj.template = cachePopInfo.popTemplate;
	comPopTreeObj.prmtNm = [];
	comPopTreeObj.prmtVal = [];
	
	//필드정렬
	cachePopInfo.popFieldList.sort(function(a, b) {
		return a.popNum - b.popNum;
	});
	
	//검색된 필드정보 loop
	for(var key in cachePopInfo.popFieldList){
		var field = cachePopInfo.popFieldList[key];
		
		//grid - model 세팅
		if(field.popType == "popSetString"){
			comPopTreeObj.model.fields[field.fieldId] = {type: 'string'};
		}else if(field.fieldType == "popSetInt"){
			comPopTreeObj.model.fields[field.fieldId] = {type: 'int'};
		}else if(field.fieldType == "popSetDate"){
			comPopTreeObj.model.fields[field.fieldId] = {type: 'date'};
		}else if(field.fieldType == "popSetBool"){
			comPopTreeObj.model.fields[field.fieldId] = {type: 'bool'};
		}
		
		if(field.popFormat == 'pk'){
			comPopTreeObj.model.id = field.popId;
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
			comPopTreeObj.prmtNm.push(field.popId);
			comPopTreeObj.prmtVal.push(field.popDynamicValue);
		}
	}
	
	//파라미터 동적 검색 처리
	if(!gfn_isEmpty(prmtObj)){
		for(var key in prmtObj){
			comPopTreeObj.prmtNm.push(key);
			comPopTreeObj.prmtVal.push(prmtObj[key]);
		}
	}
	
	//tree 그려주기
	gfn_jteComPopTree_Set();
	
	//팝업창 띄우기
	gfn_comOpenPopTree();
	
	comPopTreeObj.tree = $("#popArea").data("kendoTreeView");
	
	//이벤트 바인딩
	gfn_jteComPopTree_EventBind();
}

this.gfn_comOpenPopTree = function(){
	$("#popArea").kendoWindow({
		width: comPopTreeObj.width,
		height: comPopTreeObj.height,
		position: {
			top : ($(window).height()/2) - (comPopTreeObj.height/2),
			left : ($(window).width()/2) - (comPopTreeObj.width/2)
		},
		resizable : true,
		title: comPopTreeObj.title,
		actions: ["Refresh", "Close"],
		visible: false
	}).data("kendoWindow").open();
}

//tree 생성
this.gfn_jteComPopTree_Set = function(){
	
	var dataSource = new kendo.data.HierarchicalDataSource({
		transport: {
			read: {
				url: comPopTreeObj.url,
				dataType: "json"
			},parameterMap: function(data, type){
				pageSearchObj ={};
				
				switch(type) {
				case "read" :
					if(!gfn_isNull(comPopTreeObj.prmtNm)){
						comPopTreeObj.prmtNm.forEach(function(item,index){
							pageSearchObj[comPopTreeObj.prmtNm[index]] = comPopTreeObj.prmtVal[index];
						});
					}
				return Object.assign(data, pageSearchObj);
				}	
			}
		},schema: {
			model: comPopTreeObj.model
		}
		
	});
	
	var treeTemplate;
	if(gfn_isEmpty(comPopTreeObj.template)){
		treeTemplate = comPopTreeObj.dataTextField;
	}else{
		treeTemplate = comPopTreeObj.template;
	}
	
	$("#popArea").kendoTreeView({
		dataSource: dataSource,
		
		template : treeTemplate,
		//전체 확장 
 		dataBound: function(){
 			this.expand('.k-item');
 		}
	});
}

//이벤트 바인딩
this.gfn_jteComPopTree_EventBind = function(){
	// 더블 클릭 - 콜백 호출
	if(gfn_isEmpty(comPopTreeObj.template)){
		$("#popArea").on("dblclick",".k-in", function(e){
			var item = comPopTreeObj.tree.dataItem($(e.target).closest("li"));
			comPopTreeObj.callback(item);
			$("#popArea").data("kendoWindow").close();
		});
	}
}

//버튼 클릭이벤트
this.gfn_jteComPopTree_btnClick = function(selectedItem){
	var item = comPopTreeObj.tree.dataItem($(selectedItem).closest("li"));
	comPopTreeObj.callback(item);
	$("#popArea").data("kendoWindow").close();
}
