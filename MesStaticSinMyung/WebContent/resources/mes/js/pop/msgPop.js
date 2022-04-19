//agmtObj.action = AUTO : 코드 자동생성, SELF : 수동생성
//agmtObj.msgType = 업무구분 (C인 경우에만 사용?) 
//agmtObj.msgCode = "메세지 코드"

msgPopObj = {};
this.gfn_msgSetPop = function(option){
	msgPopObj = option;
	
	//기존창 삭제 및 초기화
	if($("#msgPop").length > 0){
		$("#msgPop").data("kendoWindow").close();
		$("#msgPop").remove();	
	}
	
	$("#msgPopBox").append("<div id ='msgPop'></div>");
	$("#msgPop").html($("#jteMsgForm").clone());
	$("#msgPop").find("*").each(function(){
		if(!gfn_isNull($(this).attr("id"))){
			var useId = $(this).attr("id").replace("_disable_","");
			$(this).attr("id",useId)
		}
	})
	//언어 종류
	msgPopObj.langType = gfn_getCode("msgLangCode");
	
	
	var popInnerHtml = "";
	msgPopObj.msgPrmt = [];
	msgPopObj.langType.forEach(function(item,index){
		popInnerHtml += '<tr>'
			+'<td><i class="fas fa-caret-right"></i>'+ gfn_getMsg('bc_'+item.cdId,item.cdNm) +' :</td>'
			+'<td><input type="text" id="msg_lang_' + item.cdVal + '" name="msgView" langCd="'+item.cdVal+'" msg="'+item.cdVal+'MsgView" class="k-textbox" style="width: 100%;" /></td>'
		+'</tr>'; // 20.04.28 JJW 다국어관리 인풋 스타일 변경 width: 95%에서 100%
		
		msgPopObj.msgPrmt.push(item.cdVal);
	});

	$("#jteMsgForm_body").html(popInnerHtml);
	
	if(msgPopObj.mode=='NEW'){
		msgPopObj.title = gfn_getMsg("pop_msgRegist");			//다국어 등록
		msgPopObj.width = 460; // 20.04.28 JJW 다국어관리 팝업 창 크기 수정 400 -> 460  LYM 400->460
		msgPopObj.height = 260; // 20.04.28 JJW 다국어관리 팝업 창 크기 수정 220 -> 260  LYM 220->285
	}else if (msgPopObj.mode=='EDT'){
		msgPopObj.title = gfn_getMsg("pop_msgUpdate");			//다국어 수정
		msgPopObj.width = 460; // 20.04.28 JJW 다국어관리 팝업 창 크기 수정 400 -> 460  LYM 400->460
		msgPopObj.height = 260; // 20.04.28 JJW 다국어관리 팝업 창 크기 수정 220 -> 260  LYM 220->285
		msgPopObj.callback = function(){
			$("#msg_msgId").prop("readonly",true);
			$("#msg_msgId").val(msgPopObj.selectedItem["msgId"])
			$("#jteMsgForm_body").find("input").each(function(index,item){
				var langType = $(this).attr("msg");
				$(this).val(msgPopObj.selectedItem[langType]);
			});
		};
	}else if (msgPopObj.mode =='PG_NEW'){
		$("#msg_msgId").prop("placeholder",""+gfn_getMsg("pop_autoInput")+"");			//자동입력
		msgPopObj.title = gfn_getMsg("pop_msgRegist");									//다국어 등록
		msgPopObj.width = 460;  // 20.04.29 JJW 다국어등록 팝업 창 크기 수정 400 -> 460  LYM 400->460 
		msgPopObj.height = 260;  // 20.04.29 JJW 다국어등록 팝업 창 크기 수정 220 -> 260  LYM 220->235
		msgPopObj.callback = function(){
			if(gfn_isEmpty(msgPopObj.saveMsg)){
				$("#jteMsgForm_body").find("input").each(function(index,item){
					if($(this).attr("langCd") == libUtil._myInfo.locale){
						$(this).val(msgPopObj.defNm);
					}
				});
			}else{
				gfn_msgTempLoad(msgPopObj.saveMsg);
			}
		}
	}else if (msgPopObj.mode =='PG_EDT'){
		$("#msg_msgId").prop("readonly",true);
		msgPopObj.title = gfn_getMsg("pop_msgUpdate");			//다국어 수정
		msgPopObj.width = 460; // 20.04.28 JJW 다국어수정 팝업 창 크기 수정 400 -> 460  LYM 400->460
		msgPopObj.height = 260; // 20.04.28 JJW 다국어수정 팝업 창 크기 수정 220 -> 260  LYM 220->240
		msgPopObj.callback = function(){
			if(gfn_isEmpty(msgPopObj.saveMsg)){
				$.ajax({
					async:false,
					url : "/cform/basMgt/codMgt/msgMgt/getMsgMergeOne",
					type: "POST",
					traditional :true,
					data: {msgId : msgPopObj.defId, msgPrmt : msgPopObj.msgPrmt},
					success: function(data){
						if(!gfn_isNull(data)){
							$("#msg_msgId").val(data[0].msgId);
							$("#jteMsgForm_body").find("input").each(function(index,item){
								var langType = $(this).attr("msg");
								$(this).val(data[0][langType]);
							});
						}else{
							$("#msg_msgId").prop("placeholder",""+gfn_getMsg("pop_autoInput")+"");			//자동입력
							$("#jteMsgForm_body").find("input").each(function(index,item){
								if($(this).attr("langCd")== libUtil._myInfo.locale){
									$(this).val(msgPopObj.defNm);
								}
							});
						}
						
					},error : function(ex){
						gfn_loading(false);
						gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
					}
				});
				
			}else{
				gfn_msgTempLoad(msgPopObj.saveMsg);
			}
		}
	}
	gfn_msgOpenPop();
}

this.gfn_msgTempLoad = function(tempMsg){
	if(!gfn_isEmpty(tempMsg[0].msgViewPk.msgId)){
		$("#msg_msgId").val(tempMsg[0].msgViewPk.msgId);		
	}else{
		$("#msg_msgId").prop("placeholder",""+gfn_getMsg("pop_autoInput")+"");			//자동입력
	}
	tempMsg.forEach(function(item,index){
		$("#jteMsgForm_form").find("input").each(function(idx,e){
			if($(e).attr("langCd") == item.msgViewPk.langCd){
				$(e).val(item.msgView);
			}
		});
	});
	
}

this.gfn_msgOpenPop = function(){
	$("#msgPop").kendoWindow({
		width: msgPopObj.width,
		height: msgPopObj.height,
		position: {
			top : ($(window).height()/2) - (msgPopObj.height/2),
			left : ($(window).width()/2) - (msgPopObj.width/2)
		},
		resizable : true,
		title: msgPopObj.title,
		actions: ["Refresh", "Close"],
		visible: false
	}).data("kendoWindow").open();
	if(!gfn_isEmpty(msgPopObj.callback)){
		msgPopObj.callback();
	}
	
}

this.gfn_setMsgSave = function(formID){
	
	var prmtData = [];
	$("#jteMsgForm_body").find("input").each(function(index,item){
		var tempObj = {};
		tempObj.msgViewPk = {};
		tempObj.msgViewPk.msgId =  $("#msg_msgId").val();
		tempObj.msgViewPk.langCd = $(this).attr("langCd");
		tempObj.msgView = $(this).val();
		prmtData.push(tempObj);
	});
	switch(msgPopObj.mode){
		case "NEW":	
		case "EDT" : 
		$.ajax({
			async:false,
			url : "/cform/basMgt/codMgt/msgMgt/updateMsg",
			type: "POST",
			data: JSON.stringify(prmtData),
			contentType : 'application/json',
			dataType : 'json',
	
			success: function(data){
				if(data > -1 && data != null){
					gfn_closePop(formID);
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "성공적으로 저장되었습니다.")});			//성공적으로 저장되었습니다.
					msgPopObj.saveCallback();
				}else{
					gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "성공적으로 삭제되었습니다.")});			//성공적으로 삭제되었습니다.
				}
			},error : function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","오류가 발생했습니다. \n 관리자에게 문의해주세요.")});			//오류가 발생했습니다.
			}
		});
		break;
		case "PG_NEW":
		case "PG_EDT" : 
			msgPopObj.saveCallback(prmtData);
			gfn_closePop(formID);
		break;
	}
}
