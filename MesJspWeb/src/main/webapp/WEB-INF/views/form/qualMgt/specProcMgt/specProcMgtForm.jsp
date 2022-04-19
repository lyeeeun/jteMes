<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- ������ �׸��� ���� -->
<div id="grid-content" style="width:100%;">
	<div id="jteSingleGrid"></div>
</div>
<!-- �˾�(������ �׸���> ����Ŭ��)  -->
<div style="display:none;">
	<div id="jtePopForm">
		<form id="jtePopForm_form" class="specProcMgtForm">
			<div class="pop_title">SPC ����</div>
			<table style="width:100%;" id="jtePopForm_master" class="jtePopForm_master specProcMgtForm">
			<colgroup>
				<col class="pop-col-left-title">
				<col class="pop-col-left-content-1">
				<col class="pop-col-left-content-2">
				<col class="pop-col-right-title">
				<col class="pop-col-right-content-1">
				<col class="pop-col-right-content-2">
			</colgroup>
				<tr>
					<!-- �ڵ�  -->
					<td><i class="fas fa-caret-right"></i>�ڵ� : </td>
					<td colspan="2"><input type="text" id="spcId" class="left-input" name="spcId" format="text" placeholder="<spring:message code = "pop_autoInput"></spring:message>" readonly /></td>
					<!-- ������Ʈ��  -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i>������Ʈ �� : </td>
					<td colspan="2"><input type="text" id="spcNm" class="right-input" name="spcNm" format="text" /></td>
				</tr>
				<tr>
					<!-- ǰ��  -->
					<td><i class="fas fa-caret-right"></i>ǰ�� ���̵� : </td>
					<td>
						<input type="text" id="spcItem" class="left-input btn-input" name="spcItem" format="text" readonly/> 
						<input type="hidden" id="itemId" class="left-input btn-input" name="itemId"/>
					</td>
					<td>
						<button class="k-button k-primary search-btn" type="button" onclick="lfn_itemPop_Open(lfn_itemPop_callback)">
				<!-- ��ȸ -->
						<spring:message code="btn_search" /></button>
					</td>
					<td class="td-right-title"><i class="fas fa-caret-right"></i>ǰ��� : </td>
					<td colspan="2"><input type="text" id="itemNm" class="right-input" name="itemNm" format="text" readonly/></td>
				</tr>
				<tr>
				<!-- ������ -->
					<td><i class="fas fa-caret-right"></i>������ : </td>
					<td colspan="2"><input id="spcStartDt" class="left-input" name="spcStartDt" format="datepicker"/></td> 
				<!-- ������ -->
					<td class="td-right-title"><i class="fas fa-caret-right left-caret"></i>������ : </td>
					<td colspan="2"><input id="spcFinishDt" class="right-input" name="spcFinishDt" format="datepicker"/></td> 
				</tr>
				<tr>
					<!-- ����  -->
					<td><i class="fas fa-caret-right"></i>����: </td>
					<td colspan="2"><input id="spcStatus" class="left-input" name="spcStatus" format="selBox" msg="spc_status" /></td>
					<!-- ����  -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i>���� : </td>
					<td colspan="2"><input type="text" id="spcPnmn" class="right-input" name="spcPnmn" format="text" /></td>
				</tr>

				<tr>
					<!-- ����  -->
					<td><i class="fas fa-caret-right"></i>���� : </td>
					<td colspan="2"><input type="text" id="spcCause" class="left-input" name="spcCause" format="text" /></td>
					<!-- ��ǥ  -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i>��ǥ : </td>
					<td colspan="2"><input type="text" id="spcGoal" class="right-input" name="spcGoal" format="text" /></td>
				</tr>

				<tr>
					<!-- ��å��  -->
					<td><i class="fas fa-caret-right"></i>��å�� : </td>
					<td colspan="5"><input type="text" id="spcMeasure" class="center-input" name="spcMeasure" format="text" /></td>
				</tr>
				<tr>
					<!-- ������  -->
					<td><i class="fas fa-caret-right"></i>������ : </td>
					<td colspan="5"><input type="text" id="spcResult" class="center-input" name="spcResult" format="text" /></td>
				</tr>
				<tr>
					<!-- ȿ���ľ�  -->
					<td><i class="fas fa-caret-right"></i>ȿ�� �ľ� : </td>
					<td colspan="5"><input type="text" id="spcEffect" class="center-input" name="spcEffect" format="text" /></td>
				</tr>
				<tr>
					<!-- ǥ��ȭ  -->
					<td><i class="fas fa-caret-right"></i>ǥ��ȭ : </td>
					<td colspan="5"><input type="text" id="spcStandard" class="center-input" name="spcStandard" format="text" /></td>
				</tr>
				<tr>
					<!-- �����  -->
					<td><i class="fas fa-caret-right"></i>����� : </td>
					<td colspan="2"><input type="text" id="spcManager" class="left-input" name="spcManager" format="text" /></td>
					<!-- �˶�  -->
					<td class="td-right-title"><i class="fas fa-caret-right"></i>�˶� : </td>
					<td><input type="text" id="spcAlarm" class="right-input btn-input" name="spcAlarm" format="text" /></td>
					<td><button class="k-button k-primary search-btn" type="button" >����</button></td>
				</tr>
				<tr>
					<!-- �����ڷ�  -->
					<td><i class="fas fa-caret-right"></i>���� �ڷ� : </td>
					<td colspan="3">
						<input name="attachFile" id="attachFiles" type="file" aria-label="files" format="file" code="spcId" />
						<input type="hidden" id="insertAttach" value = "[]"/>
						<input type="hidden" id="deleteAttach" value = "[]"/>
					</td>
				</tr>

				<tr style="display:hidden;">
					<td>
						
						<input type="hidden" name="action" id="spc_action"/>
					</td>
				</tr>
			</table>
			
			<!-- ���� ��� -->
			<div id="jtePopForm_gridArea" style="display: none;">
				<div class="pop_title">���� ���</div>
				<div id="jtePopForm_grid"></div>
			</div>

			<div class="final-btn-area" style="text-align:center;">
				<button class="k-button k-primary jte-create final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>			<!-- ���� -->
				<button class="k-button k-primary jte-update final-btn" type="button" style="display:none;"><spring:message code = "pop_save"></spring:message></button>			<!-- ���� -->
				<button class="k-button k-primary final-btn" type="button" onclick = "gfn_closePop('jtePopForm');"><spring:message code = "pop_cancel"></spring:message></button>			<!-- ��� -->
			</div>
		</form>
		
	</div>
</div>

<link href='/resources/mes/css/contents/qualMgt/specProcMgt/specProcMgtForm.css' rel="stylesheet">
<!-- ���� ��Ÿ�� �ܺη� �̵�_200824 JJW -->

<script>
var lfo_common = {};  //form ���ο��� ���� Object

var lfo_popGrd = {}; //�˾� �׸��忡�� ���

//���� �̺�Ʈ 
this.lfn_init = function() {
	//�׸��� ����
	lfn_jteSgGrd_setGrd();
};

this.lfn_jteSgGrd_setGrd = function(){   
	lfo_commom = {};	
	
	//1.
	lfo_common.layoutId = "jteSingleGrid";
	
	//2.
	lfo_common.popId = "jtePopForm";
	
	//3.
	lfo_common.ctrlUrl = "/form/qualMgt/specProcMgt";
	
	//4.
	lfo_common.crud  = {
		read:{url:"/getSpcList", auth:"", prmt:{}}, 
		create:{url:"/setSpcSave", auth:"", openFunc: lfn_jtePop_open, callback: lfn_popSave}, 
		update:{url:"/setSpcSave", auth:"", openFunc: lfn_jtePop_open, callback: lfn_popSave}, 
		destroy:{url:"/setSpcDelete", auth:"", callback:lfn_jteGrid_delete}
	};
	
	lfo_common.model = {
			id: "spcId",
			fields: {
				spcId 		: { type: "string" },
				spcNm		: { type: "string" },
				spcPnmn		: { type: "string" },
				spcCause	: { type: "string" },
				spcGoal		: { type: "string" },
				spcMeasure	: { type: "string" },
				spcResult	: { type: "string" },
				spcEffect	: { type: "string" },
				spcStandard	: { type: "string" },
				spcManager	: { type: "string" },
				spcFile		: { type: "string" },
				spcUsers	: { type: "string" },
				spcStatus	: { type: "string" },
				updatedAt	: { type: "date" },
				updatorId	: { type: "string" },
				createdAt	: { type: "date" },
				creatorId	: { type: "string" },
				spcStartDt	: { type: "date" },
				spcFinishDt	: { type: "date" },
				itemNm		: { type: "string" }
			}
	};
	
	lfo_common.columns = [
		{selectable : true, width:"40px"},
		{field: "spcId", title:"�ڵ�", width: "120px"},
		{field: "spcNm", title:"������Ʈ��", width: "120px"},
		{field: "spcStartDt", format:"{0: yyyy-MM-dd}", title:"������", width: "120px"},
		{field: "spcFinishDt", format:"{0: yyyy-MM-dd}", title:"������", width: "120px"},
		{field: "spcManager", title:"�����", width: "120px"},
		{field: "spcStatus",template:"# var item = gfn_isNull(gfn_getCode(spcStatus))== true ? '�����ڵ� ����' : gfn_getMsg('bc_'+ gfn_getCode(spcStatus).cdId , gfn_getCode(spcStatus).cdNm) # #= item #", title:"����", width: "120px"}
		
	];
	
	lfo_common.selectBox = [
		{ text: "�ڵ�", value: "spcInfo.spc_id" },
		{ text: "������Ʈ��", value: "spcInfo.spc_nm" },
		{ text: "�����", value: "spcInfo.spc_manager" }
	];
	
	lfo_common.validation = {
		spcId:{
			messages : "�ڵ带 �Է��ϼ���",
			rules : function(input){
				if(input.is("[name=spcId]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		spcManager:{
			messages : "����ڸ� �Է��ϼ���",
			rules : function(input){
				if(input.is("[name=spcManager]")){
					return input.val().length != 0 && input.val().trim().length != "";
				}
				return true;
			}
		},
		spcStartDt:{
			messages : "�������� ����ϼ���",
			rules : function(input){
				if(input.is("[name=spcStartDt]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		},
		spcFinishDt:{
			messages : "�������� ����ϼ���",
			rules : function(input){
				if(input.is("[name=spcFinishDt]")){
					return kendo.parseDate(input.val());
				}
				return true;
			}
		}
	}
	//���� �׸��� ���� ȣ�� 
	lfo_common.grid = gfn_grid_set(lfo_common);
	
}
//����Ŭ�� �ݹ�(�˾�)
this.lfn_jtePop_open = function(mode, selectedItem){
	var options = {
		modal:true, 
		width: "705px", 
		height: "620px",  /** 200428 ù��° �˾� ���� ���� 565px->600px_LYM **/ /* 200921 JJW 600px -> 620px */
		id:lfo_common.popId, 
		resizable : true,
		animation:{open :{effects:"expand:vertical fadeIn"},
		close :{effects:"expand:vertical fadeIn", reverse: true}},
		actions:[/*"Minimize", "Maximize", */"Close"]
	};
	if(mode =="NEW"){
		options.title = gfn_getMsg("pop_spcRegist");			//spc ���
	}else if(mode=="EDT"){
		options.title = gfn_getMsg("pop_spcUpdate");			//spc ����
	}
	//�˾��� ������ �� �����ؾ��� �Լ� �Է�
	options.callback = function(){lfn_jtePop_set(mode, selectedItem);};
	this.gfn_winOpen(options);
}

//�˾����� ����
this.lfn_jtePop_set = function(mode,selectedItem){
	lfo_common.gridSelected = "";
	if(mode=='NEW'){
		gfn_popform_set(lfo_common, mode);
	}else if(mode == 'EDT'){
		gfn_resizePop(lfo_common.popId,{width:750,height:580}); //200831JJW�˾����̼���
		$("#"+lfo_common.popId+"_gridArea").show();
		
		if(typeof(selectedItem) == "object"){
			lfo_common.gridSelected = selectedItem["spcId"];
		}else if(typeof(selectedItem) == "string"){
			lfo_common.gridSelected = selectedItem;
		}

		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud.read.url,
			type: "POST",
			data: {spcId:lfo_common.gridSelected},
			success: function(data){
				gfn_popform_set(lfo_common, mode,data.rows[0]);
				//lfo_common.gridSelected = {spcId : data.rows[0].spcId};
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","������ �߻��߽��ϴ�. \n �����ڿ��� �������ּ���.")});			//������ �߻��߽��ϴ�.
			}
		});
	}
	
	//�׸��� ����
	if ( $("#jtePopForm_grid").html("") ) {
		lfn_jtePopGrd_setGrd();	
	}else {
		lfo_popGrd.grid.dataSource.read();
	}
	
	
}
//Form���� �Է�/����
this.lfn_popSave = function(mode){
	var validation = $("#"+lfo_common.popId+"_form").getKendoValidator();
	if(gfn_isEmpty(validation) || validation.validate()){
		//�Է��� serialize
		//var savePrmt = gfn_serializeObject(lfo_common.popId+"_form");
		var savePrmt = $("#"+lfo_common.popId+"_form").serializeObject();
		
		//����� �ٱ�� �ִٸ� �߰�
		var msgId = $("#"+lfo_common.popId+"_form").find(".jte-msgBox").attr("defId");
		var msgList = $("#msg_"+ msgId).val();
		if(!gfn_isNull(msgList)){
			savePrmt.msgList = JSON.parse(msgList);
		}
		
		$.ajax({
			async:false,
			url : lfo_common.ctrlUrl + lfo_common.crud[mode].url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					gfn_closePop(lfo_common.popId);
					lfo_common.grid.dataSource.read();
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "���������� ����Ǿ����ϴ�.")});			//����
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "�����Ͽ����ϴ�. \n ���� ����� �ԷµǾ����� Ȯ�� �� �ٽ� �õ����ּ���.")});				//����
				}
			},error: function(ex){
				gfn_loading(false);
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","������ �߻��߽��ϴ�. \n �����ڿ��� �������ּ���.")});			//������ �߻��߽��ϴ�.
			}
		});
	}
}



//���� �ݹ�
this.lfn_jteGrid_delete = function(){
	var delPrmt = [];

	$("#"+ lfo_common.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_common.grid.dataItem($(this).closest('tr')));
		}
	});
	$.ajax({
		async:false,
		url : lfo_common.ctrlUrl + lfo_common.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_common.grid.dataSource.read();
			gfn_msgBox({msg:gfn_getMsg("pop_deleteSuccess")});			//���������� �����Ǿ����ϴ�.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","������ �߻��߽��ϴ�. \n �����ڿ��� �������ּ���.")});			//������ �߻��߽��ϴ�.
		}
	});
}

//�˾� ���� �׸���
this.lfn_jtePopGrd_setGrd = function(){
	lfo_popGrd = {};
	
	//1.
	lfo_popGrd.layoutId = "jtePopForm_grid";
	
	//2.     
	//lfo_popGrd.popId = "";
	
	//3.
	lfo_popGrd.ctrlUrl = "/form/qualMgt/specProcMgt";
	
	//4.
	lfo_popGrd.crud = {
			read:{url:"/getSpcUserList", auth:"", prmt:{spcId : lfo_common.gridSelected}}, 
			create:{url:"/setSpcUserSave", auth:"", openFunc:lfn_jtePopGrd_popOpen, callback:lfn_jtePopGrd_save},
			update:{url:"", auth:"", openFunc:"", callback:""},
			destroy:{url:"/setSpcUserDelete", auth:"", callback:lfn_jtePopGrd_delete}	
	};
	
	//5
	lfo_popGrd.model ={
			id: "userId",
			fields:{
				updatedAt	: { type: "date" },
				createdAt	: { type: "date" },
				spcId		: { type: "string" },
				userNm: {type: "string" },
				userId: {type: "string" }				
			}
	};
	
	//6
	lfo_popGrd.columns = [
		{selectable : true, width:"40px"},
		{field: "userId", title:" ���� ���̵� ", width:"120px"},
		{field: "userNm", title:" �̸�" }
	];
	
	//7.
	lfo_popGrd.selectBox = [
		{ text: "���̵�", value: "spcUser.user_id" }, //���̵�
		{ text: "�̸�", value: "userInfo.user_nm" }
		];
	//8.
	lfo_popGrd.validation ={
		userId:{
			messages : "���� ���̵� �Է��ϼ���",
			rules : function(input){
				if(input.is("[name=userId]")){
					return input.val().length != 0 ;
				}
				return true;
			}
		}
	}
	
	//���� �׸��� ���� ȣ�� 
	lfo_popGrd.grid = gfn_grid_set(lfo_popGrd);
	
}


//����Ŭ�� �ݹ�(�˾�)
this.lfn_jtePopGrd_popOpen = function(selectedItem){
	//������� �����˾� ����
	gfn_openCustomPop('userInfo',lfn_jtePopGrd_save);
}



//���� �߰� Form���� �Է�/����
this.lfn_jtePopGrd_save = function(savePrmt){
	savePrmt.spcId = lfo_common.gridSelected;
		
		$.ajax({
			async:false,
			url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.create.url,
			type: "POST",
			data: JSON.stringify(savePrmt),
			traditional :true,
			contentType : 'application/json',
			dataType : 'json',
			success: function(data){
				if(data != ""){
					
					
					//�˾� �׸��� ���ε�
					lfo_popGrd.grid.dataSource.read();
				
					gfn_msgBox({msg :  gfn_getMsg("pop_successConfirm", "���������� ����Ǿ����ϴ�.")});			//����
				}else{
					gfn_warnBox({msg : gfn_getMsg("pop_failedConfirm", "�����Ͽ����ϴ�. \n ���� ����� �ԷµǾ����� Ȯ�� �� �ٽ� �õ����ּ���.")});				//����
				}
			},error: function(ex){

				gfn_loading(false); 
				gfn_errBox({msg : gfn_getMsg("pop_errorFailed","������ �߻��߽��ϴ�. \n �����ڿ��� �������ּ���.")});			//������ �߻��߽��ϴ�.
			}
		});
	}



//���� �ݹ�
this.lfn_jtePopGrd_delete = function(){
	var delPrmt = [];
	$("#"+ lfo_popGrd.layoutId +" .k-checkbox").each(function(index,item){
		if($(this).attr("aria-checked") == "true"){
			delPrmt.push(lfo_popGrd.grid.dataItem($(this).closest('tr')));
		}
	});
	
	$.ajax({
		async:false,
		url : lfo_popGrd.ctrlUrl + lfo_popGrd.crud.destroy.url,
		type: "POST",
		data: JSON.stringify(delPrmt),
		traditional :true,
		contentType : 'application/json',
		dataType : 'json',
		success: function(data){
			lfo_popGrd.grid.dataSource.read();
			gfn_msgBox({msg :  gfn_getMsg("pop_deleteSuccess", "���������� �����Ǿ����ϴ�.")});			//���������� �����Ǿ����ϴ�.
		},error: function(ex){
			gfn_loading(false);
			gfn_errBox({msg : gfn_getMsg("pop_errorFailed","������ �߻��߽��ϴ�. \n �����ڿ��� �������ּ���.")});			//������ �߻��߽��ϴ�.
		}
	});
}

//pop - ǰ�� �˾� ����
this.lfn_itemPop_Open = function(call){
	gfn_openCustomPop('item',call);
}

//pop - ǰ�� �˾� �ݹ�
this.lfn_itemPop_callback = function(rtnObj){
	$("#spcItem").val(rtnObj["itemId"]);
	$("#itemNm").val(rtnObj["itemNm"]);

}





</script>