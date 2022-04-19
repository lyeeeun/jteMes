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
	
	$("#libPopBox").append("<div id='popArea'></div>");
	switch(type){
	case "userInfo" : //사용자
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 445; /** 200428 위치 정보의 사용자 조회 팝업변경_LYM_원래는 315 **/
		comPopObj.title = gfn_getMsg("pop_userSrh"); 			//사용자조회
		comPopObj.url = "/cform/basMgt/userMgt/userInfo/getUserList";
		comPopObj.model = {
			id: "userId",
			fields: {
				userId: { type: "string" },
				userNm: { type: "string" },
				positionId: { type: "string" },
				positionNm: { type: "string" },
				deptId: { type: "string" },
				deptNm: { tpye: "string" },
				langCd: { type: "string" },
				failCnt: { type: "string" },
				isLock: { type: "string" },
				isDel: { type: "string" },
				createdAt: { type: "date" },
				updatedAt: { type: "date" },
				creatorId: { type: "string" },
				updatorId: { type: "string" },
				description: { type: "string" }
			}
		};
		comPopObj.columns = [
			{title:"No.", width:50, template: "#=++record #"},
			{field: "userId", title:gfn_getMsg("col_userId"), width: 120},					//아이디
			{field: "userNm", title:gfn_getMsg("col_userNm"), width: 150},					//이름
			{field: "positionNm", title:gfn_getMsg("col_positionNm"), width: 100},			//직급명
			{field: "deptNm", title:gfn_getMsg("col_deptNm"), width: 150}					//부서명
		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_userId"), value: "ur.user_id" },					//아이디
			{ text: gfn_getMsg("col_userNm"), value: "ur.user_nm" },					//이름
			{ text: gfn_getMsg("col_positionNm"), value: "pos.position_nm" },			//직급명
			{ text: gfn_getMsg("col_deptNm"), value: "dept.dept_nm" }					//부서명
		];
		comPopObj.prmtNm = ["lock","del"];
		comPopObj.prmtVal = [false,false];
		break;
		
	case "deptInfo" : //부서
		comPopObj.type = "JPQL";
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_deptSrh");			//부서조회
		comPopObj.url = "/form/basMgt/belngMgt/divInfo/getDeptList";
		comPopObj.model = {
			id: "deptId",
			fields: {
				deptId: { type: "string" },
				deptNm: { type: "string" },
				deptSeq: { type: "string" },
				isUse: { type: "bool" }
			}
		};
		comPopObj.columns = [
			{title:"No.", width:"50px", template: "#=++record #"},
			{field: "deptId", title:gfn_getMsg("col_deptCd"), width: "150px"},				//부서코드
			{field: "deptNm", template:"# var item = gfn_getMsg('dept_'+ deptId, deptNm) # #= item #",
				title:gfn_getMsg("col_deptNm"), width: "200px"},							//부서명
			{field: "deptSeq" , title:gfn_getMsg("col_priority"), width: "120px"}			//우선순위
		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_deptCd"), value: "deptId" },			//부서코드
			{ text: gfn_getMsg("col_deptNm"), value: "deptNm" }				//부서명
		];
		comPopObj.dynamicField = ["isUse"];
		comPopObj.dynamicValue = [true];
		break;
		
	case "positionInfo" : //직급
		comPopObj.type = "JPQL";
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_positionSrh");			//직급조회
		comPopObj.url = "/form/basMgt/belngMgt/posInfo/getPositionList";
		comPopObj.model = {
			id: "positionId",
			fields: {
				positionId: { type: "string" },
				positionNm: { type: "string" },
				positionSeq: { type: "string" },
				isUse: { type: "bool" }
			}
		};
		comPopObj.columns = [
			{title:"No.", width:"50px", template: "#=++record #"},
			{field: "positionId", title:gfn_getMsg("col_positionCd"), width: "150px"},			//직급코드
			{field: "positionNm", template:"# var item = gfn_getMsg('pos_'+ positionId, positionNm) # #= item #",
				title:gfn_getMsg("col_positionNm"), width: "200px"},							//직급명
			{field: "positionSeq" , title:gfn_getMsg("col_priority"), width: "120px"}			//우선순위
		];

		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_positionCd"), value: "positionId" },			//직급코드
			{ text: gfn_getMsg("col_positionNm"), value: "positionNm" },			//직급명
	
		];
		comPopObj.dynamicField = ["isUse"];
		comPopObj.dynamicValue = [true];
		break;
	case "positionInfo" : //직급
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = "위치정보조회"			//직급조회
		comPopObj.url = "/form/basMgt/belngMgt/posInfo/getPositionList";
		comPopObj.model = {
			id: "positionId",
			fields: {
				positionId: { type: "string" },
				positionNm: { type: "string" },
				positionSeq: { type: "string" },
				isUse: { type: "bool" }
			}
		};
		comPopObj.columns = [
			{title:"No.", width:"50px", template: "#=++record #"},
			{field: "positionId", title:gfn_getMsg("col_positionCd"), width: "150px"},			//직급코드
			{field: "positionNm", template:"# var item = gfn_getMsg('pos_'+ positionId, positionNm) # #= item #",
				title:gfn_getMsg("col_positionNm"), width: "200px"},							//직급명
			{field: "positionSeq" , title:gfn_getMsg("col_priority"), width: "120px"}			//우선순위
		];

		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_positionCd"), value: "positionId" },			//직급코드
			{ text: gfn_getMsg("col_positionNm"), value: "positionNm" },			//직급명
	
		];
		comPopObj.dynamicField = ["isUse"];
		comPopObj.dynamicValue = [false];
		break;
	case "processInfo": //공정 정보
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_processInfo")			//공정 정보
		comPopObj.url = "/cform/basMgt/operMgt/processInfo/getProcessInfo";
		comPopObj.prmtNm = ["use"];
		comPopObj.prmtVal = [true];
		comPopObj.model = {
				id: "processId",
				fields: {
					processId : { type: "string" },
					processNm : { type: "string" },
					processGbn : { type: "string" },
					description : { type: "string" },
					isUse : { type: "bool" },
					creatorId : { type: "string" },
					createdAt : { type: "string" },
					updatorId : { type: "string" },
					updatedAt : { type: "string" },
				}
			};
		comPopObj.columns =[		
			{field: "processId", title: gfn_getMsg("col_processCd"), width: 120},				//공정코드
			{field: "processNm", title: gfn_getMsg("col_processNm"), width: 150},				//공정명
			{field: "processGbn", title: gfn_getMsg("col_processType"), width: 100},			//공정구분
			{field: "description", title: gfn_getMsg("col_desc"), width: 100},					//설명
			
		];
		
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_processCd"), value: "processId" },			//공정코드
			{ text: gfn_getMsg("col_processNm"), value: "processNm" },			//공정명
			/*{ text: gfn_getMsg("col_processType"), value: "processGbn" },
*/		];
		
		comPopObj.dynamicField = ["isUse"];
		comPopObj.dynamicValue = [true];
	break;	
	case "eqmtMgt"://설비 마스터 정보
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_eqmtInfo")			//설비정보
		comPopObj.url = "/cform/basMgt/operMgt/facilMgt/getEqmtMgtList";
		comPopObj.prmtNm = ["use"];
		comPopObj.prmtVal = [true];
		comPopObj.model = {
				id: "eqmtMgtId",
				fields: {
					eqmtMgtId : { type: "string" },
					eqmtMgtNm : { type: "string" },
					eqmtMgtPurchase : { type: "date" },
					eqmtMgtVerif : { type: "date" },
					eqmtMgtDesc : { type: "string" },
					isUse : { type: "bool" },
					creatorId : { type: "string" },
					createdAt : { type: "string" },
					updatorId : { type: "string" },
					updatedAt : { type: "string" },
					placeId : { type: "string" },
					placeNm : { type: "string" },
					
					eqmtId : { type: "string" },
					eqmtNm : { type: "string" },
					eqmtGbn : { type: "string" },
					eqmtMaintenance : { type: "int" },
					eqmtFile : { type: "string" },
					compId : { type: "string" }
				}
			};
		comPopObj.columns =[
			{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: 170},											//설비개별코드
			{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: 150},											//설비명(상세)
			{field: "eqmtMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: 110},			//입고일
			{field: "eqmtMgtVerif", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: 110},			//검증기간
			{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: 150},												//위치명
			{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc"), width: 250}												//설명
			
		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_eqmtIndivCd"), value: "eqmtMgt.eqmt_mgt_id" },			//설비개별코드
			{ text: gfn_getMsg("col_eqmtDetailNm"), value: "eqmtMgt.eqmt_mgt_nm" },			//설비명(상세)
			{ text: gfn_getMsg("col_placeNm"), value: "eqmtMgt.place_nm" },					//위치명
			{ text: gfn_getMsg("col_desc"), value: "eqmtMgt.eqmt_mgt_desc" }				//설명
		];
		break;
	case "tool"://공구 마스터 정보
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_toolInfo")			//공구정보
		comPopObj.url = "/cform/basMgt/operMgt/toolMgt/getToolInfoList";
		comPopObj.prmtNm = ["use"];
		comPopObj.prmtVal = [true];
		comPopObj.model = {
				id: "toolId",
				fields: {
					toolId : { type: "string" },
					toolNm : { type: "string" },
					toolType : { type: "string" },
					toolPrice : { type: "int" },
					toolLimit : { type: "int" },
					toolDesc : { type: "string" },
					isUse : { type: "bool" },
					creatorId : { type: "string" },
					createdAt : { type: "string" },
					updatorId : { type: "string" },
					updatedAt : { type: "string" },
				}
			};
		comPopObj.columns =[
			{field: "toolId", title:gfn_getMsg("col_toolCd"), width: 150},									//공구코드
			{field: "toolType", template:"# var item = gfn_isNull(gfn_getCode(toolType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(toolType).cdId , gfn_getCode(toolType).cdNm) # #= item #", 
				title:gfn_getMsg("col_toolType"), width: "110px;"},											//공구유형
			{field: "toolNm", title:gfn_getMsg("col_toolNm"), width: 150},									//공구명
			//{field: "toolPrice",format: "{0:n0}", title:"공구 단가", width: 100},
			{field: "toolLimit", format: "{0:n0}", title:gfn_getMsg("col_useLimit"), width: 110},			//사용한도
			{field: "toolDesc", title:gfn_getMsg("col_desc"), width: 250},									//설명
		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_toolCd"), value: "toolInfo.tool_id" },			//공구코드
			{ text: gfn_getMsg("col_toolNm"), value: "toolInfo.tool_nm" },			//공구명
			/*{ text: gfn_getMsg("col_toolType"), value: "toolInfo.tool_type" },
*/			{ text: gfn_getMsg("col_desc"), value: "toolInfo.tool_desc" }			//설명
		];
		break;	
	case "item"://부품정보
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 460;  //200508 수주 관리 그리드 더블클릭>수주 조회 팝업 그리드 더블클릭>Lot 등록 팝업의 부품명 조회>부품 정보 팝업창 height 변경_315->460px LYM
		comPopObj.title = gfn_getMsg("pop_itemInfo");			//부품정보
		comPopObj.url = "/cform/basMgt/operMgt/itemMgt/getItemList";
		comPopObj.prmtNm = ["use","itemType"];
		comPopObj.prmtVal = [true,'item_goods'];
		comPopObj.model = {
				id: "itemId",
				fields: {
					itemId: { type: "string" },
					itemNm: { type: "string" },
					itemPrice: { type: "int" },
					itemPersonCost: { type: "int" },
					itemType: { type: "int" },
					itemStd01: { type: "int" },
					itemStd02: { type: "int" },
					itemStd03: { type: "int" },
					itemStd04: { type: "int" },
					itemStd05: { type: "int" },
					itemUnit: { type: "string" },
					itemMtrl: { type: "string" },
					itemTotalStock: { type: "int" },
					itemDayTarget: { type: "int" },
					itemDeduction: { type: "int" },
					isUse: { type: "bool" }
				}
			};
		comPopObj.columns =[
			/* {title:"No.", width:50, template: "#=++record #"}, */
			{field: "itemId", title:gfn_getMsg("col_itemCd"), width: "160px"},								//부품코드
			{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "190px"},								//부품명
			{field: "description", title:gfn_getMsg("col_desc"), width: "200px"},							//설명
			{field: "itemType", template:"# var item = gfn_isNull(gfn_getCode(itemType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemType).cdVal , gfn_getCode(itemType).cdNm) # #= item #",
				title:gfn_getMsg("col_itemType"), width: "110px"},											//부품유형
			{field: "itemStd01", format: "{0:n}", title:gfn_getMsg("col_length"), width: "110px"},			//길이
			{field: "itemStd02", format: "{0:n}", title:gfn_getMsg("col_width"), width: "110px"},			//폭
			{field: "itemStd03", format: "{0:n}", title:gfn_getMsg("col_thick"), width: "110px"},			//두께
			{field: "itemStd04", format: "{0:n}", title:gfn_getMsg("col_weight"), width: "110px"},			//무게
			{field: "itemUnit",template:"# var item = gfn_isNull(gfn_getCode(itemUnit))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemUnit).cdId , gfn_getCode(itemUnit).cdNm) # #= item #",
				title:gfn_getMsg("col_unit"), width: "90px"},												//단위
			{field: "itemMtrl",  template:"# var item = gfn_isNull(gfn_getCode(itemMtrl))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(itemMtrl).cdVal , gfn_getCode(itemMtrl).cdNm) # #= item #",
				title:gfn_getMsg("col_qomtrl"), width: "110px"},											//재질
			{field: "itemDayTarget", title:gfn_getMsg("col_dayTarget"), width: "120px"},					//일일목표량
			{field: "itemDeduction", title:gfn_getMsg("col_deduction"), width: "110px"}						//공제량

		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_itemNm"), value: "itemNm" },				//부품명
			{ text: gfn_getMsg("col_itemCd"), value: "itemId" }					//부품코드
		];
		break;
	case "material"://자재정보
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 460; 	//200511 BOM 관리→BOM 신규 생성 팝업→자재정보 팝업 height 변경_LYM 315->460px
		comPopObj.title = gfn_getMsg("pop_mtrlInfo");			//자재정보
		comPopObj.url = "/cform/basMgt/operMgt/mtrlInfo/getMtrlInfoList";
		comPopObj.prmtNm = ["use"];
		comPopObj.prmtVal = [true];
		comPopObj.model = {
			id: "mtrlId",
			fields: {
				mtrlId : { type: "string" },
				mtrlNm: { type: "string" },
				mtrlType: { type: "string" },
				mtrlHCD: { type: "string" },
				mtrlStd01: { type: "int" },
				mtrlStd02: { type: "int" },
				mtrlStd03: { type: "int" },
				mtrlStd04: { type: "string" },
				mtrlStd05: { type: "int" },
				mtrlUseday: { type: "int" },
				mtrlCost: { type: "int" },
				createdAt: { type: "string" },
				updatedAt: { type: "string" },
				creatorId: { type: "string" },
				updatorId: { type: "string" },
				mtrlDiv: { type: "string" },
				isUse: { type: "bool" },
				mtrlQual: { type: "string" },
				mtrlUnit: { type: "string" }
			}
		};
		comPopObj.columns =[
			{field: "mtrlId", title:gfn_getMsg("col_mtrlCd"), width: "160px"},									//자재코드
			{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: "130px"},								//자재구분
			{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: "130px"},									//자재명
			{field: "mtrlType", template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #", 
				title:gfn_getMsg("col_mtrlType"), width: "110px;"},												//자재유형
			{field: "mtrlHCD", template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #", 
				title:gfn_getMsg("col_mtrlHCD"), width: "110px;"},												//HCD구분
			{field: "mtrlStd01",format: "{0:n}", title:gfn_getMsg("col_width"), width: "110px"},				//소재Φ
			{field: "mtrlStd02", format: "{0:n}", title:gfn_getMsg("col_mainHall"), width: "110px"},			//본당기장
			{field: "mtrlStd03", format: "{0:n}", title:gfn_getMsg("col_weight"), width: "110px"},				//무게
			{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
				title:gfn_getMsg("col_unit"), width: "110px"},													//단위
			//{field: "mtrlUseday", format: "{0:n0}", title:시효기간, width: 110},			
			//{field: "mtrlCost", format: "{0:n0}", title:"단가", width: 100},
			{field: "mtrlDesc", title:gfn_getMsg("col_desc"), width: 250}										//설명

		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },			//자재구분
			{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },				//자재명
			{ text: gfn_getMsg("col_mtrlCd"), value: "mtrlInfo.mtrl_id" }				//자재코드
			/*{ text: gfn_getMsg("col_mtrlType"), value: "mtrlInfo.mtrl_type" },*/
		];
		break;
	case "materialMgt"://자재상세
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_detailMtrl");			//자재상세
		comPopObj.url = "/cform/mtrl/mtrlMgt/getMtrlMgtList";
		comPopObj.prmtNm = ["use"];
		comPopObj.prmtVal = [true];
		comPopObj.model = {
			id: "mtrlMgtId",
			fields: {
				mtrlMgtId : { type: "string" },
				mtrlMgtPurchase : { type: "date" },
				mtrlMgtPrescription: { type: "date" },
				mtrlMgtCnt: { type: "int" },
				mtrlMgtDesc: { type: "string" },
				creatorId: { type: "string" },
				createdAt: { type: "date" },
				updatorId: { type: "string" },
				updatedAt: { type: "date" },
				mtrlId: { type: "string" },
				mtrlNm: { type: "string" },
				mtrlType: { type: "string" },
				mtrlHCD: { type: "string" },
				mtrlStd01 : { type: "int" }, 
				mtrlStd02 : { type: "int" }, 
				mtrlStd03 : { type: "int" }, 
				mtrlStd04 : { type: "string" },
				mtrlStd05 : { type: "int" },
				mtrlUseday : { type: "int" },
				mtrlCost : { type: "int" },
				mtrlDiv: { type: "string" }, 
				mtrlQual: { type: "string" }, 
				mtrlUnit: { type: "string" },
				isUse: { type: "bool" }
			}
		};
		comPopObj.columns =[
			{selectable : true, width:"50px"},
			{field: "mtrlId", title:gfn_getMsg("col_mtrlCd"), width: 150},													//자재코드
			{field: "mtrlDiv", title:gfn_getMsg("col_mtrlDiv"), width: 150},												//자재구분
			{field: "mtrlNm", title:gfn_getMsg("col_mtrlNm"), width: 150},													//자재명
			{field: "mtrlType",  template:"# var item = gfn_isNull(gfn_getCode(mtrlType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlType).cdId , gfn_getCode(mtrlType).cdNm) # #= item #",
				title:gfn_getMsg("col_mtrlType"), width: 110},																//자재유형
			{field: "mtrlHCD",  template:"# var item = gfn_isNull(gfn_getCode(mtrlHCD))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlHCD).cdId , gfn_getCode(mtrlHCD).cdNm) # #= item #",
				title:gfn_getMsg("col_mtrlHCD"), width: 110},																//HCD구분	
			{field: "mtrlMgtId", title:gfn_getMsg("col_mtrlIndivCd"), width: 170},											//자재개별코드
			{field: "mtrlStd01", format: "{0:n}", title:gfn_getMsg("col_width"), width: 90},								//소재Φ
			{field: "mtrlStd02", format: "{0:n}", title:gfn_getMsg("col_mainHall"), width: 90},								//본당기장
			{field: "mtrlStd03", format: "{0:n}", title:gfn_getMsg("col_weight"), width: 90},								//무게
			{field: "mtrlStd04", template:"# var item = gfn_isNull(gfn_getCode(mtrlStd04))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(mtrlStd04).cdId , gfn_getCode(mtrlStd04).cdNm) # #= item #",
				title:gfn_getMsg("col_unit"), width: 90},																	//단위
			{field: "mtrlMgtCnt", format: "{0:n0}", title:gfn_getMsg("col_mtrlQty"), width: 110},							//자재수량
			{field: "mtrlMgtPurchase", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_receiptDate"), width: 110},			//입고일
			//{field: "mtrlMgtPrescription", format:"{0: yyyy-MM-dd}", title:시효기간, width: 110},
			{field: "mtrlMgtDesc", title:gfn_getMsg("col_desc"), width: 250}												//설명
		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_mtrlDiv"), value: "mtrlInfo.description" },				//자재구분
			{ text: gfn_getMsg("col_mtrlNm"), value: "mtrlInfo.mtrl_nm" },					//자재명
			/*{ text: gfn_getMsg("col_mtrlType"), value: "mtrlInfo.mtrl_type" },
*/			{ text: gfn_getMsg("col_mtrlIndivCd"), value: "mtrlMgt.mtrl_mgt_id" },			//자재개별코드
			{ text: gfn_getMsg("col_desc"), value: "mtrlMgt.description" }					//설명
		];
		
		comPopObj.prmtNm = ["del"];
		comPopObj.prmtVal = [false];
		break;
		//
	case "supplier"://공급처 검색
	case "customer"://고객사 검색
	case "company"://공급+고객 검색
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 462;  //200429 설비정보>업체명 조회>공급처 조회 팝업 height변경_LYM_322->462
		comPopObj.url = "/cform/basMgt/operMgt/compMgt/getCompList";
		if(type == "supplier"){
			comPopObj.title = gfn_getMsg("pop_supCompSrh");				//매입처조회
		}else if (type == "customer"){
			comPopObj.title = gfn_getMsg("pop_cusCompSrh");				//매출처조회
		}else if (type == "company"){
			comPopObj.title = gfn_getMsg("pop_openCompSrh");			//업체조회
		}
		if(type == "supplier"){ //매입처만
			comPopObj.prmtNm = ["compType","use"];
			comPopObj.prmtVal = ["corp_div02",true];
		}else if (type == "customer"){ //매출처만
			comPopObj.prmtNm = ["compType","use"];
			comPopObj.prmtVal = ["corp_div01",true];
		}else if (type == "company"){ //모든업체
			comPopObj.prmtNm = ["use"];
			comPopObj.prmtVal = [true];
		}
		comPopObj.model = {
			id: "compId",
			fields: {
				compId: { type: "string" },
				compNm: { type: "string" },
				compInitials: { type: "string" },
				compManagr: { type: "string" },
				compNumber: { type: "string" },
				compType: { type: "string" },
				compAddr: { type: "string" },
				createdAt: { type: "date" },
				updatedAt: { type: "date" },
				creatorId: { type: "string" },
				updatorId: { type: "string" },
				description: { type: "string" },
				isUse: { type: "string" },
				mtrlId: { type: "string" },
				toolId: { type: "string" },
			}
		};
		comPopObj.columns = [
			{title:"No.", width:50, template: "#=++record #"},
			{field: "compId", title:gfn_getMsg("col_compCd"), width: 150},				//업체코드
			{field: "compNm", template:"# var item = gfn_getMsg('comp_'+ compId, compNm) # #= item #",
				title:gfn_getMsg("col_compNm"), width: 150},							//업체명
			{field: "compInitials", title:gfn_getMsg("col_compInitials"), width: 150},	//업체약어
			{field: "compManagr", title:gfn_getMsg("col_manager"), width: 110},			//관리자
			{field: "compNumber", title:gfn_getMsg("col_compNum"), width: 130},			//업체번호
			{field: "compAddr", title:gfn_getMsg("col_compAddr"), width: 250},			//업체주소
			{field: "description", title:gfn_getMsg("col_desc"), width: 250}			//설명
		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_compCd"), value: "compInfo.comp_id" },				//업체코드
			{ text: gfn_getMsg("col_compNm"), value: "compInfo.comp_nm" },				//업체명
			{ text: gfn_getMsg("col_manager"), value: "compInfo.comp_managr" }			//관리자
		];
	break;
	case "routing"://라우팅
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_routInfo");			//라우팅 정보
		comPopObj.url = "/cform/basMgt/routing/routingMgt/getRoutingInfo";
		comPopObj.prmtNm = [];
		comPopObj.prmtVal = [];
		comPopObj.model = {
			id: "routingId",
			fields: {
				routingId : { type: "string" },
				routingType: { type: "string" },
				routingSeq: { type: "int" },
				manHour: { type: "int" },
				description: { type: "string" },
				itemId: { type: "string" }
			}
		};
		comPopObj.columns =[
			{field: "routingId", title:gfn_getMsg("col_routCd"), width: 150},									//라우팅코드
			{field: "routingType",template:"# var item = gfn_isNull(gfn_getCode(routingType))== true ? '기초코드 없음' : gfn_getMsg('bc_'+ gfn_getCode(routingType).cdId , gfn_getCode(routingType).cdNm) # #= item #"
				, title:gfn_getMsg("col_routType"), width: 150},												//라우팅유형
			{field: "routingSeq", format: "{0:n0}", title:gfn_getMsg("col_routSeq"), width: 90},				//차수
			{field: "manHour", format: "{0:n0}", title:gfn_getMsg("col_processPeriod"), width: 120},			//공정시간
			{field: "description", title:gfn_getMsg("col_desc"), width: 300}									//설명
		];
		//comPopObj.shBoxItem = [];
		comPopObj.paging = false;
		break;
	case "routingEquip"://라우팅 - 설비
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_eqmtSrh");
		comPopObj.url = "/cform/basMgt/routing/routingMgt/getRtlEqmtList";
		comPopObj.prmtNm = [];
		comPopObj.prmtVal = [];
		comPopObj.model = {
			id: "eqmtMgtId",
			fields: {
				eqmtMgtId : { type: "string" },
				eqmtMgtNm: { type: "string" },
				eqmtMgtPurchase: { type: "date" },
				eqmtMgtVerif: { type: "date" },
				eqmtMgtDesc: { type: "string" },
				placeId: { type: "string" },
				placeNm: { type: "string" },
				compId: { type: "string" },
				compNm: { type: "string" }
			}
		};
		comPopObj.columns =[
			{field: "eqmtMgtId", title:gfn_getMsg("col_eqmtIndivCd"), width: 150},											//설비개별코드
			{field: "eqmtMgtNm", title:gfn_getMsg("col_eqmtDetailNm"), width: 150},											//설비명(상세)
			{field: "eqmtMgtPurchase", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_purchaseDate"), width: 90},			//입고일
			{field: "eqmtMgtVerif", format: "{0: yyyy-MM-dd}", title:gfn_getMsg("col_verifyPeriod"), width: 120},			//검증기간
			{field: "placeId", title:gfn_getMsg("col_placeCd"), width: 150},												//위치코드
			{field: "placeNm", title:gfn_getMsg("col_placeNm"), width: 150},												//위치명
			{field: "eqmtMgtDesc", title:gfn_getMsg("col_desc"), width: 300}												//비고
			//{field: "placeId", title:"업체코드", width: 300},
			//{field: "placeId", title:"업체명", width: 300}
		];
		//comPopObj.shBoxItem = [];
		comPopObj.paging = false;
		break;
	case "lotInfo"://Lot 정보
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_lotSrh");			//LoT조회
		comPopObj.prmtNm = [];
		comPopObj.prmtVal = [];
		comPopObj.url = "/cform/orderMgt/orderDetailMgt/getLotList";
		comPopObj.model = {
			id: "lotSeq",
			fields: {
				lotSeq : { type: "int" },
				lotId : { type: "string" },
				lotNm : { type: "string" },
				lotCode : { type: "string" },
				lotType : { type: "string" },
				lotQty : { type: "int" },
				lotMtrlCost : { type: "int" },
				lotMtrlCostAfter : { type: "int" },
				lotPersonCost : { type: "int" },
				lotPersonCostAfter : { type: "int" },
				lotPm : { type: "string" },
				lotPmNm : { type: "string" },
				lotState : { type: "string" },
				lotDesc : { type: "string" },
				createdAt : { type: "date" },
				creatorId : { type: "string" },
				updatedAt : { type: "date" },
				updatorId : { type: "string" },
				itemId : { type: "string" },
				cliamId : { type: "string" },
				orderId : { type: "string" },
				itemNm: { type: "string" },
				itemDeduction: { type: "int" }
			}
		};
		comPopObj.columns = [
			{selectable : true, width:"50px"},
			{field: "lotId", title:gfn_getMsg("col_lotCd"), width: "170px;"},				//Lot코드
			//2020.05.14|ymlee|LoT명 주석(신명기계 사용x)
			/*{field: "lotNm", title:gfn_getMsg("col_lotWrkNm"), width: "220px;"},			//Lot명
*/			{field: "itemNm", title:gfn_getMsg("col_itemNm"), width: "220px;"},				//부품명
			{field: "lotQty", title:gfn_getMsg("col_lotQty"), width: "80px;"},				//Lot수량
			{field: "lotType",  template:"# var item = gfn_isNull(lotType)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotType).cdId , gfn_getCode(lotType).cdNm) # #= item #", 
				title:gfn_getMsg("col_orderType"), width: "80px;"},							//수주유형
			{field: "lotState", template:"# var item = gfn_isNull(lotState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(lotState).cdId , gfn_getCode(lotState).cdNm) # #= item #",
					title:gfn_getMsg("col_orderStatus"), width: "120px;"}					//수주상태
		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_lotCd"), value: "lot.lot_id" },				//Lot코드
			{ text: gfn_getMsg("col_lotWrkNm"), value: "lot.lot_nm" },			//Lot명
			{ text: gfn_getMsg("col_itemNm"), value: "item.item_nm" }			//부품명
		];
	break;
	case "orderInfo": //수주 정보
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 820;
		comPopObj.height = 380;
		comPopObj.title = gfn_getMsg("pop_orderSrh");			//수주조회
		comPopObj.prmtNm = [];
		comPopObj.prmtVal = [];
		comPopObj.url = "/cform/orderMgt/orderDetailMgt/getOrderList";
		comPopObj.model = {
				id: "orderId",
				fields: {
					orderId: { type: "string" },
					orderNm: { type: "string" },
					orderManager: { type: "string" },
					orderStdt: { type: "date" },
					orderEddt: { type: "date" },
					orderCost: { type: "int" },
					createdAt: { type: "date" },
					updatedAt: { type: "date" },
					creatorId: { type: "string" },
					updatorId: { type: "string" },
					description: { type: "string" },
					orderState: { type: "string" },
					compId: { type: "string" },
					orderManagerNm: { type: "string" },
					compNm: { type: "string" }
				}
		};
		comPopObj.columns = [
			{title:"No.", width:"50px", template: "#=++record #"},
			{field: "orderId", title:gfn_getMsg("col_orderCd"), width: "140px"},											//수주코드
			//2020.05.14|ymlee|수주명 주석(신명기계 사용x)
			/*{template:"#:data.orderNm#",field: "orderNm", title:gfn_getMsg("col_orderNm"), width: "220px"},					//수주명
*/			{field: "orderManagerNm", title:gfn_getMsg("col_manager"), width: "100px;"},									//관리자
			{field: "orderStdt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_orderDate"), width: "120px"},				//수주일
			{field: "orderEddt", format:"{0: yyyy-MM-dd}", title:gfn_getMsg("col_deliveryDate"), width: "120px"},			//납기일
			{field: "orderCost", format: "{0:n0}", title:gfn_getMsg("col_cost"), width: "110px"},							//비용
			{field: "orderState",template:"# var item = gfn_isNull(orderState)== true ? '' : gfn_getMsg('bc_'+ gfn_getCode(orderState).cdId , gfn_getCode(orderState).cdNm) # #= item #",
				title:gfn_getMsg("col_proceedStatus"), width: "130px"},														//수주진행상태
			{field: "compNm", title:gfn_getMsg("col_compNm"), width: "130px"},												//업체명
			{field: "description", title:gfn_getMsg("col_desc"), width: "280px"}											//설명
		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_orderCd"), value: "orInfo.order_id" },			//수주코드
			/*{ text: gfn_getMsg("col_orderNm"), value: "orInfo.order_nm" },			//수주명
*/			{ text: gfn_getMsg("col_manager"), value: "urInfo.user_nm" }			//관리자
		];
	break;
	case "shipComp": //출하 업체(배송지) 정보
		comPopObj.type = type;
		comPopObj.callback = callback;
		comPopObj.width = 670;
		comPopObj.height = 315;
		comPopObj.title = gfn_getMsg("pop_shipCompInfo");			//출하업체 정보
		comPopObj.prmtNm = [];
		comPopObj.prmtVal = [];
		comPopObj.url = "/cform/ship/shipPlanMgt/getShipCompList";
		comPopObj.model = {
				fields: {
					compId: { type: "string" },
					compNm: { type: "string" },
					compNumber: { type: "string" },
					compAddrId: { type: "string" },
					compAddrDetail: { type: "string" },
				}
		};
		comPopObj.columns = [
			{field: "compNm", title:gfn_getMsg("col_compNm"), width: "130px"},											//수주코드
			{field: "compNumber", title:gfn_getMsg("col_compNum"), width: "130px"},											//수주코드
			{field: "compAddrDetail", title:gfn_getMsg("col_compAddr"), width: "130px"}										//수주코드
		];
		comPopObj.shBoxItem = [
			{ text: gfn_getMsg("col_compAddr"), value: "compAddr.comp_addr_detail" },
		];
	break;
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

