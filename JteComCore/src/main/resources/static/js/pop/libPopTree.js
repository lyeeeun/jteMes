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
	switch(type){
	case "menuInfo":
		comPopTreeObj.type = type;
		comPopTreeObj.callback = callback;
		comPopTreeObj.width = 350;
		comPopTreeObj.height = 315;
		comPopTreeObj.title = "메뉴 구조";
		comPopTreeObj.url = "/form/basMgt/menuMgt/menuInfo/getMenuTree";
		comPopTreeObj.template = "# var menuButton = item.menuCd == 'F' ? '' : '<button class=\"k-button k-primary\" type=\"button\" onclick=\"gfn_jteComPopTree_btnClick(this)\">선택</button>' #"
			+"#= item.menuNm # #= menuButton #";
		comPopTreeObj.prmtNm = [];
		comPopTreeObj.prmtVal = [];
		comPopTreeObj.model = {
			id: "menuId",
			hasChildren: "hasChildren",
		};
	break;
	case "place"://위치정보
		comPopTreeObj.type = type;
		comPopTreeObj.callback = callback;
		comPopTreeObj.width = 350;
		comPopTreeObj.height = 315;
		comPopTreeObj.title = gfn_getMsg("pop_placeInfo")
		comPopTreeObj.url = "/form/basMgt/operMgt/rlehoMgt/getPlaceTree";
		//comPopTreeObj.dataTextField = "placeNm";
		comPopTreeObj.template = "#= item.placeNm #";
		comPopTreeObj.prmtNm = [];
		comPopTreeObj.prmtVal = [];
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
	case "bom"://bom정보
		comPopTreeObj.type = type;
		comPopTreeObj.callback = callback;
		comPopTreeObj.width = 350;
		comPopTreeObj.height = 315;
		comPopTreeObj.title = "BOM TREE";
		comPopTreeObj.url = "/form/basMgt/bom/bomMgt/getBomTree";
		//comPopTreeObj.dataTextField = "bomNm";
		comPopTreeObj.template = "# var bomButton = '<button class=\"k-button k-primary\" type=\"button\" onclick=\"gfn_jteComPopTree_btnClick(this)\">선택</button>'; if(gfn_getCode('produceType').cdReserve01 == 'assemble' && item.bomTarget == 'prcs_bom02') bomButton = ''; #" + "#= item.bomNm #(#= gfn_getMsg('bc_'+ item.bomTarget)#) #= bomButton #",
		comPopTreeObj.prmtNm = [];
		comPopTreeObj.prmtVal = [];
		comPopTreeObj.model = {
			id: "bomId",
			hasChildren: "hasChildren",
			field:{
				bomId : { type: "string" },
				bomNm : { type: "string" },
				bomTarget : { type: "string" },
				bomTargetId : { type: "string" },
				bomTargetNm : { type: "string" },
				bomTargetCnt : { type: "int" },
				description : { type: "string" },
				bomSeq : { type: "int" },
				bomParentId : { type: "string" },
				createdAt : { type: "string" },
				creatorId : { type: "string" },
				updatedAt : { type: "string" },
				updatorId : { type: "string" },
				itemId : { type: "string" },
				mtrlDesc : { type: "string" },
				bomStd01 : { type: "string" },
				bomStd02 : { type: "string" },
				bomStd03 : { type: "string" },
				bomStd04 : { type: "string" },
				bomStd05 : { type: "string" },
				bomStdStr01 : { type: "string" },
				bomStdStr02 : { type: "string" },
				bomStdStr03 : { type: "string" },
				bomStdStr04 : { type: "string" },
				bomStdStr05 : { type: "string" }
			}
		};
		break;
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
