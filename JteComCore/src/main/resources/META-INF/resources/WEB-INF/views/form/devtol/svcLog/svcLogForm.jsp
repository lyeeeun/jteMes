<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 마스터 그리드 영역 -->
<div id="customBar" style="width: 100%; background: #f0f5ff; padding: 15px 0 15px 15px; margin: 10px 0 5px 0; font-size: 20px;"></div> <!-- 201111 YUMI_padding: 15px 0 15px 0에서 변경 -->
<div id="grid-content" style="width: 100%;">
	<div id="jteSingleGrid"></div>
</div>

<div style="display: none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="svcLogForm">
			<table style="width: 100%;" id="jtePopForm_master" class="BasicTable">
				<colgroup>  
					<col style="width: 17%;"> 
					<col style="width: 32%;">
					<col style="width: 19%;">
					<col style="width: 32%;">
				</colgroup>
				<tr>
					<td colspan="4"></td>
				</tr>				
				<tr>
					<td>
						<i class="fas fa-caret-right"></i>
						<spring:message code="col_resolver"></spring:message> :
					</td>
					<td>
						<input name="svcErrUserNm" format="text" readonly /> <input type="hidden" name="svcErrUserId" />
					</td>
					<td>
						<i class="fas fa-caret-right"></i>
						<spring:message code="col_measureTime"></spring:message> :
					</td>
					<td>
						<input name="svcErrAt" format="text" readonly />
					</td>
				</tr>
				<tr>
					<td>
						<i class="fas fa-caret-right"></i>
						<spring:message code="col_measureContent"></spring:message> :
					</td>
					<td colspan="3">
						<textarea name="svcErrResult" style="width: 100%;" rows="10"></textarea>
					</td>
				</tr>
				<tr style="display: none;">
					<td colspan="4">
						<input type="hidden" name="svcLogId"> <input type="hidden" name="action">
					</td>
				</tr>
			</table>
			<div class="final-btn-area">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display: none;">
					<spring:message code="pop_save"></spring:message>
				</button>
				<!-- 저장 -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display: none;">
					<spring:message code="pop_save"></spring:message>
				</button>
				<!-- 저장 -->
				<button class="k-button k-primary final-btn" type="button" onclick="gfn_closePop('jtePopForm');">
					<spring:message code="pop_cancel"></spring:message>
				</button>
				<!-- 취소 -->
			</div>
		</form>
	</div>
</div>

<!-- 이윤민 주임 작업 CSS -->
<link href='/resources/mes/css/contents/basMgt/devtol/svcLog/svcLogForm.css' rel="stylesheet">

<script>
	var lfo_common = {};//Form 내부에서 사용될 Object 

	//진입 이벤트(공통코드에서 실행)
	this.lfn_init = function() {
		//커스텀 검색조건 세팅
		lfn_customSearchBar_set();

		//그리드 생성
		lfn_jteSgGrd_setGrd();
	};

	//커스텀 검색조건 세팅
	this.lfn_customSearchBar_set = function() {

		//초기화
		$("#customBar").html("");
		var customBarHTML = "";

		customBarHTML += '<span style=" font-weight:600;">' + gfn_getMsg("lbl_businessManagement") + ' : </span>';

		//메뉴 상위 디렉토리만 불러오기
		var menuList = gfn_ajaxCallByList("svcMenu", {
			menuId : "root",
			menuCd : "F"
		});

		var menuGbnSelBox = [ {
			text : gfn_getMsg("bc_svcLogAll"),
			value : ""
		} ];
		//위치정보 선택 박스 만들기

		for ( var i in menuList) {
			menuGbnSelBox.push({
				text : menuList[i].menuNm,
				value : menuList[i].menuId
			})
		}

		customBarHTML += '<input name="menuGbn" id="menuGbn" style="margin : 0 5px 0 5px;">';

		customBarHTML += '<span style=" font-weight:600; margin-left: 10px;">' + gfn_getMsg("col_state") + ': </span>'; <!-- 201111 YUMI_margin-left 추가 -->

		//성공여부
		var isErrSelBox = gfn_getCode("svcLog");

		customBarHTML += '<input name="svcLogResult" id="svcLogResult" style="margin : 0 5px 0 5px;">';

		$("#customBar").html(customBarHTML);

		//검색영역 검색 selectBox 값 세팅
		$("#menuGbn").kendoDropDownList({
			dataValueField : "value",
			valueTemplate : "# var item = gfn_getMsg('mn_' + value, text)  #" + "#= item #",
			template : "# var item = gfn_getMsg('mn_' + value, text)  #" + "#= item #",
			dataSource : menuGbnSelBox,
			index : 0,
			change : lfn_GridReload
		});

		$("#svcLogResult").kendoDropDownList({
			dataValueField : "cdVal",
			valueTemplate : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
			template : "# var item = gfn_getMsg('bc_' + cdId, cdNm)  #" + "#= item #",
			dataSource : isErrSelBox,
			index : 0,
			change : lfn_GridReload
		});
	}

	//리로드
	this.lfn_GridReload = function() {
		lfo_common.grid.dataSource.read();
	}

	this.lfn_jteSgGrd_setGrd = function() {
		lfo_common = {};//Form 내부에서 사용될 Object 

		//1.
		lfo_common.layoutId = "jteSingleGrid";

		//2.
		lfo_common.popId = "jtePopForm";

		//3.
		lfo_common.ctrlUrl = "/form/devtol/svcLog"

		//4.
		lfo_common.crud = {
			read : {
				url : "/getSvcLogList",
				auth : "",
				prmt : {},
				dynamicMultiPrmt : {
					menuGbn : "menuGbn",
					svcLogResult : "svcLogResult"
				}
			},
			update : {
				url : "/setSvcLog",
				auth : "",
				callback : lfn_popSave
			},
		};

		//5.
		lfo_common.model = {
			id : "pageLogId",
			fields : {
				svcLogId : {
					type : "int"
				},
				svcLogAt : {
					type : "date"
				},
				svcLogTime : {
					type : "int"
				},
				svcLogPart : {
					type : "string"
				},
				svcLogMethod : {
					type : "string"
				},
				svcLogPath : {
					type : "string"
				},
				svcLogPrmt : {
					type : "string"
				},
				svcLogSuccess : {
					type : "bool"
				},
				svcLogMsg : {
					type : "string"
				},
				svcLogUser : {
					type : "string"
				},
				svcLogUserNm : {
					type : "string"
				},
				svcLogResult : {
					type : "string"
				},
				svcErrUser : {
					type : "string"
				},
				svcErrUserNm : {
					type : "string"
				},
				svcErrAt : {
					type : "string"
				},
				svcErrResult : {
					type : "string"
				},
				svcLogIp : {
					type : "string"
				},
				svcLogDevice : {
					type : "string"
				},
				svcLogResult : {
					type : "bool"
				},
			}
		};

		//6.
		lfo_common.columns = [
		//{field: "svcLogId", title : "기록코드", width: "170px"},
		{
			field : "svcLogResult",
			title : gfn_getMsg("col_measure"),
			width : "180px",
			template : function(rows) {
				if (rows.svcLogResult == "normal") {
					return "<div style='text-align:center;'> - </div>";
				} else if (rows.svcLogResult == "error") {
					return gfn_getMsg("lbl_notMeasure") + " <button class='k-button k-primary pop-off' type='button' onclick = 'lfn_jtePop_open(\"EDT\",this);' style='min-width:60px;'>조치</button>"
				} else if (rows.svcLogResult == "measure") {
					return gfn_getMsg("lbl_complateMeasure") + "<button class='k-button k-primary pop-off' type='button' onclick = 'lfn_jtePop_open(\"EDT\",this);' style='min-width:60px;'>조치내역</button>";
				}
			}
		}, {
			field : "svcLogSuccess",
			title : gfn_getMsg("col_successOrFailure"),
			width : "100px",
			template : function(rows) {
				if (rows.svcLogSuccess == true) {
					return "<span style='color:green'>" + gfn_getMsg("bc_svcLogNor") + "</span>";
				} else if (rows.svcLogSuccess == false) {
					return "<span style='color:red'>" + gfn_getMsg("bc_svcLogErr") + "</span>";
				}
			}
		}, {
			field : "svcLogPart",
			title : gfn_getMsg("col_acctionMenu"),
			template : "#= gfn_getMsg('mn_'+ svcLogPart) #",
			width : "100px"
		}, {
			field : "svcLogPath",
			title : gfn_getMsg("col_path"),
			width : "200px"
		}, {
			field : "svcLogMethod",
			title : gfn_getMsg("col_actionMethod"),
			width : "120px"
		}, {
			field : "svcLogPrmt",
			title : gfn_getMsg("col_parameter"),
			width : "150px"
		}, {
			field : "svcLogMsg",
			title : gfn_getMsg("col_errorMessage"),
			width : "150px"
		}, {
			field : "svcLogAt",
			format : "{0: yyyy-MM-dd HH:mm:ss}",
			title : gfn_getMsg("col_accessTime"),
			width : "180px"
		}, {
			field : "svcLogUserNm",
			title : gfn_getMsg("mn_userConnMgt"),
			width : "100px"
		}, {
			field : "svcLogTime",
			title : gfn_getMsg("col_leadTime"),
			width : "150px"
		}, {
			field : "svcLogIp",
			title : gfn_getMsg("col_connectIp"),
			width : "250px"
		}, {
			field : "svcLogDevice",
			title : gfn_getMsg("col_connectDevice"),
			width : "100px"
		} ];

		//7.
		lfo_common.selectBox = [ {
			text : gfn_getMsg("mn_userConnMgt"),
			value : "userInfo.user_nm"
		}, {
			text : gfn_getMsg("col_connectDevice"),
			value : "svc.svc_log_device"
		} ];

		//8.
		// 	lfo_common.validation ={
		// 		compNm:{
		// 			messages : "업체명을 입력하세요",
		// 			rules : function(input){
		// 				if(input.is("[name=compNm]")){
		// 					return input.val().length != 0 && input.val().trim().length != "";
		// 				}
		// 				return true;
		// 			}
		// 		}
		// 	}
		//공통 그리드 세팅 호출 
		lfo_common.grid = gfn_grid_set(lfo_common);

		//custombar 로인한 화면 재조정
		$("#grid-content " + "#" + lfo_common.layoutId).resize();
	}

	this.lfn_jtePop_open = function(mode, selectedItem) {
		var options = {
			modal : true,
			width : "750px",
			height : "401px",  <!-- 201111 YUMI 375->412px -->
			id : lfo_common.popId,
			title : gfn_getMsg("title_svcErrorMeasurePop"),
			resizable : true,
			animation : {
				open : {
					effects : "expand:vertical fadeIn"
				},
				close : {
					effects : "expand:vertical fadeIn",
					reverse : true
				}
			},
			actions : [/*"Minimize", "Maximize", */"Close" ]
		};
		//팝업이 생성된 뒤 동작해야할 함수 입력
		options.callback = function() {
			lfn_jtePop_set(mode, selectedItem);
		};
		this.gfn_winOpen(options);
	}

	//팝업내용 세팅
	this.lfn_jtePop_set = function(mode, selectedItem) {
		lfo_common.gridSelected = "";
		if (mode == 'NEW') {
			gfn_popform_set(lfo_common, mode, selectedItem);
		} else if (mode == 'EDT') {
			if (typeof (selectedItem) == "object") {
				lfo_common.gridSelected = lfo_common.grid.dataItem($(selectedItem).closest("tr"));
			} else if (typeof (selectedItem) == "string") {
				lfo_common.gridSelected = {
					svcLogId : selectedItem
				};
			}

			$.ajax({
				async : false,
				url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
				type : "POST",
				data : {
					svcLogId : lfo_common.gridSelected.svcLogId
				},
				success : function(data) {
					gfn_popform_set(lfo_common, mode, data.rows[0]);
				},
				error : function(ex) {
					gfn_loading(false);
					gfn_errBox({
						msg : gfn_getMsg("pop_errorFailed", gfn_getMsg("pop_errorFailed"))
					});
				}
			});
		}
	}

	//Form내용 입력/저장
	this.lfn_popSave = function(mode) {
		//저장 하기전에 validationCheck
		var validation = $("#" + lfo_common.popId + "_form").getKendoValidator();
		if (gfn_isEmpty(validation) || validation.validate()) {
			//입력폼 serialize 
			var savePrmt = gfn_serializeObject(lfo_common.popId + "_form");
			savePrmt.action = "U";
			savePrmt.svcLogResult = "measure"

			$.ajax({
				async : false,
				url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
				type : "POST",
				data : JSON.stringify(savePrmt),
				traditional : true,
				contentType : 'application/json',
				dataType : 'json',
				success : function(data) {
					if (data != "") {
						lfn_jtePop_set('EDT', data);

						gfn_msgBox({
							msg : gfn_getMsg("pop_successConfirm", gfn_getMsg("pop_successSave"))
						});

						lfo_common.grid.dataSource.read();
					} else {
						gfn_errBox(gfn_getMsg("pop_failedConfirm", gfn_getMsg("pop_failedCheck")));
					}
				},
				error : function(ex) {
					gfn_loading(false);
					gfn_errBox({
						msg : gfn_getMsg("pop_errorFailed", gfn_getMsg("pop_errorFailed"))
					});
				}
			});
		}
	}
</script>