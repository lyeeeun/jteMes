//검색영역
var comPopTreeObj;

this.gfn_openCustomPopTree = function(type, callback){
	comPopTreeObj = {};
	//기존창 삭제 및 초기화
	if($("#popArea").length > 0){
		$("#popArea").data("kendoWindow").close();
		$("#popArea").remove();	
	}
	
	$("#libPopBox").append("<div id='popArea'></div>");
	switch(type){
	case "place"://위치정보
		comPopTreeObj.type = type;
		comPopTreeObj.callback = callback;
		comPopTreeObj.width = 350;
		comPopTreeObj.height = 315;
		comPopTreeObj.title = gfn_getMsg("pop_placeInfo")
		comPopTreeObj.url = "/form/basMgt/operMgt/rlehoMgt/getPlaceTree";
		comPopTreeObj.dataTextField = "placeNm",
//		comPopTreeObj.prmtNm = ["use"];
//		comPopTreeObj.prmtVal = [true];
		comPopTreeObj.model = {
			id: "placeId",
			hasChildren: "hasChildren",
			field:{
				placeId : { type: "string" },
				placeNm : { type: "string" },
				placeParent : { type: "string" },
				placeManager : { type: "string" },
				createdAt : { type: "string" },
				updatedAt : { type: "string" },
				creatorId : { type: "string" },
				updatorId : { type: "string" },
				description : { type: "string" },
				isUse : { type: "string" }
			}
		};
		break;
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
			}
		},
		schema: {
			model: comPopTreeObj.model
		}
	});
	
	$("#popArea").kendoTreeView({
		dataSource: dataSource,
		dataTextField: comPopTreeObj.dataTextField,
		//전체 확장 
 		dataBound: function(){
 			this.expand('.k-item');
 		}
	});
}

//이벤트 바인딩
this.gfn_jteComPopTree_EventBind = function(){
	// 더블 클릭 - 콜백 호출
	$("#popArea").on("dblclick",".k-in", function(e){
		var item = comPopTreeObj.tree.dataItem($(e.target).closest("li"));
		comPopTreeObj.callback(item);
		$("#popArea").data("kendoWindow").close();
	});
}

