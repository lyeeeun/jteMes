var modeParam;
$(document).ready( function () {
	$("#popSubject").text("PartsManagement")
	//팝업 모드 설정(INS/DEL)
	modeParam = getParameterByName("popMode");
	popUpSetting();
});


//검색 엔터 이벤트
$('#worksText').textbox({
	inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		keyup:function(e){
			if (e.keyCode == 13) {
				searchBtn();
			}
		}
	})
});

//팝업 모드 설정(INS/DEL)
function popUpSetting(){
	
	setPmsUnitCombo();
	if(modeParam =="INS"){
		$("#searchDiv").show();
		$("#partsListDiv").show();
		$("#appendParts").show();
		$("#partsListDiv").show();
		//검색 Select 박스 생성
		setSearchCombo();
	}else if(modeParam =="DEL"){
		$("#deleteParts").show();
		$("#modifyParts").show();
		worksItemSelectOne(getParameterByName("plateNo"));
		if($("#hidAdditionInfo").val() != ""){
			var jsonData = JSON.parse($("#hidAdditionInfo").val());
			if(jsonData[getParameterByName("plateNo")] != undefined){
				$("#cntQty").textbox("setValue",jsonData[getParameterByName("plateNo")].pmsQty);
				$("#comboUnit").combobox("setValue",jsonData[getParameterByName("plateNo")].pmsUnit);
			}
		}
		
	}
	
}

//검색 Select 박스 생성
function setSearchCombo(){
	var comboData = [{"id":"prodStd","text":"Parts_Name","selected":true},{"id":"plateNo","text":"Plate_No"}];
	if($("#hidCombo").val() == "plate_no"){
		comboData = [{"id":"prodStd","text":"Parts_Name"},{"id":"plateNo","text":"Plate_No","selected":true}];
	}
	$("#worksCombo").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
}

function setPmsUnitCombo(){
	var comboData = [{"id":"Cyl","text":"Cyl","selected":true},{"id":"Eng","text":"Eng"},{"id":"Set","text":"Set"}];
	$("#comboUnit").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
}

//AJAX - 검색 실행
function searchBtn(){
	//Create Progressbar
	showProgressBar();

	$('#pms_parts_body').empty();
	$("#partsListDiv").empty();
	
	var data = {"searchGubun":$("#worksCombo").val(), "searchText":$("#worksText").val()};
	
	$.ajax({
		url: "/getPartsList",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			search_callback(result);
		}
	});
}

//Process - 검색 실행
function search_callback(result){
	var jsonData = result;
	var searchResultHtml ="";
	
	for(var i = 0; i< jsonData.length; i++){
		searchResultHtml += "<div style='cursor:pointer;' onclick='worksItemSelectOne(\""+jsonData[i].pmsPartDtlPk.plateNo+"\"),popListSelected(this)'>" 
		+ "<span>"+jsonData[i].pmsPartDtlPk.plateNo + "  " + jsonData[i].prodStd+"</span>"
		+ "</div>"
	}
	$("#partsListDiv").html(searchResultHtml);
	//finish ProgressBar
	closeProgressBar();
}


//AJAX - 검색된 항목 클릭 시 해당 항목 상세 조회(국가, 회사 정보 등등 추후 권한처리 필요)
function worksItemSelectOne(plateNo){
	var data = {"nationId":"Columbia", "companyId":"Axia", "areaId":"Termonorte", "engineModel":"20H35DFV","plateNo":plateNo};
	$.ajax({
		url: "/getPartsItemDetail",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			partsAppend_callback(result);
		}
	});
}

//CallBack - 색된 항목 클릭 시 해당 항목 상세 조회
function partsAppend_callback(result){
	
	var jsonData = result[0];
	
	$('#pms_parts_body').empty();
	
	if(jsonData.length != 0 ) {
		$('#pms_parts_body').append("<tr>" +
			"<th>" + "Plate_No" + "</th>" +
			"<td>" +  jsonData.pmsPartDtlPk.plateNo + "</td>" +
			"<th>" + "SiteCode" + "</th>" +
			"<td>" + jsonData.siteCd + "</td>" +
			"</tr><tr>"+
			"<th>" + "항목" + "</th>" +
			"<td colspan='3'>" + jsonData.platePart + "</td>" +
			"</tr><tr>"+
			"<th>" + "품명 및 규격" + "</th>" +
			"<td colspan='3'>" +  jsonData.prodStd + "</td>" +
			"</tr><tr>"+
			"<th>" + "도면번호" + "</th>" +
			"<td>" +  jsonData.drawNo + "</td>" +
			"<th>" + "표준대응" + "</th>" +
			"<td>" + jsonData.typeCd + "</td>" +
			"</tr><tr>"+
			"<th>" + "자재번호" + "</th>" +
			"<td>" +  jsonData.materialNo + "</td>" +
			"<th>" + "U-Code" + "</th>" +
			"<td>" + jsonData.uCode + "</td>" +
			"</tr><tr>"+
			"<th>" + "Engine 수량" + "</th>" +
			"<td>" +  jsonData.engineAmt + "</td>" +
			"<th>" + "단위" + "</th>" +
			"<td>" + jsonData.amtUnit + "</td>" +
			"</tr><tr>"+
			"<th>" + "Stock in Site" + "</th>" +
			"<td>" +  jsonData.stockYn + "</td>" +
			"<th>" + "L/T" + "</th>" +
			"<td>" + jsonData.limitTime + "</td>" +
			"</tr>"
			);
	}
	
	$("#hidPlateNo").val(jsonData.pmsPartDtlPk.plateNo);
	$("#pms_parts_table").show();
}

//Confirm - 추가 버튼 클릭
function appendBtn(){
	if(saveValidationCheck()){
		$.messager.confirm('Confirm', 'Are you append this?', function(r){
			if (r){
				partsAppend();
			}
		});
	}
}

//Process - 추가 버튼 클릭
function partsAppend(){
	//Create Progressbar
	showProgressBar();
	var targetOrder01 = opener.document.getElementById("hidPmsCd01").value;
	var targetOrder02 = opener.document.getElementById("hidPmsCd02").value;
	var targetOrder03 = opener.document.getElementById("hidPmsCd03").value;
	var targetOrder04 = opener.document.getElementById("hidPmsCd04").value;
	var targetOrder05 = opener.document.getElementById("hidPmsCd05").value;
	var targetPlateNo = $("#hidPlateNo").val();
	var targetPmsQty = $("#cntQty").val();
	var targetPmsUnit = $("#comboUnit").val();
	
	var data = {"pmsQty":targetPmsQty, "pmsUnit":targetPmsUnit,
			"partDtlList":[{"pmsPartDtlPk":{"nationId":"Columbia", "companyId":"Axia", "areaId":"Termonorte", "engineModel":"20H35DFV","plateNo":targetPlateNo}}],
			"pmsTechOrderPk":{"pmsCd01":targetOrder01,"pmsCd02":targetOrder02,"pmsCd03":targetOrder03,"pmsCd04":targetOrder04,"pmsCd05":targetOrder05}};
	$.ajax({
		url: "/setPartsAppend",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result =="EXIST"){
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','이미 등록된 부품입니다.','warning');
			}else if(result =="SUCCESS"){
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','성공적으로 등록되었습니다.','info',function(){
					closeBtn();
				});
			}else{
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','알 수 없는 에러가 발생하였습니다. 관리자에게 문의해주시기 바랍니다.','error');
			}
		}
	});
}

//Confirm - 수정 버튼 클릭
function modifyBtn(){
	if(saveValidationCheck()){
		$.messager.confirm('Confirm', 'Are you modify this?', function(r){
			if (r){
				partsModify();
			}
		});
	}
}

//Process - 수정 버튼 클릭
function partsModify(){
	//Create Progressbar
	showProgressBar();
	var targetOrder01 = opener.document.getElementById("hidPmsCd01").value;
	var targetOrder02 = opener.document.getElementById("hidPmsCd02").value;
	var targetOrder03 = opener.document.getElementById("hidPmsCd03").value;
	var targetOrder04 = opener.document.getElementById("hidPmsCd04").value;
	var targetOrder05 = opener.document.getElementById("hidPmsCd05").value;
	var targetPlateNo = $("#hidPlateNo").val();
	var targetPmsQty = $("#cntQty").val();
	var targetPmsUnit = $("#comboUnit").val();
	
	var data = {"pmsQty":targetPmsQty, "pmsUnit":targetPmsUnit,
			"partDtlList":[{"pmsPartDtlPk":{"nationId":"Columbia", "companyId":"Axia", "areaId":"Termonorte", "engineModel":"20H35DFV","plateNo":targetPlateNo}}],
			"pmsTechOrderPk":{"pmsCd01":targetOrder01,"pmsCd02":targetOrder02,"pmsCd03":targetOrder03,"pmsCd04":targetOrder04,"pmsCd05":targetOrder05}};
	$.ajax({
		url: "/setPartsModify",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result =="EXIST"){
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','이미 등록된 부품입니다.','warning');
			}else if(result =="SUCCESS"){
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','성공적으로 수정되었습니다.','info',function(){
						closeBtn();
				});
			}else{
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','알 수 없는 에러가 발생하였습니다. 관리자에게 문의해주시기 바랍니다.','error');
			}
		}
	});
}


//Confirm - 삭제 버튼 클릭
function deleteBtn(){
	$.messager.confirm('Confirm message!', 'Are you delete this?', function(r){
		if (r){
			partsDelete();
		}
	});
}

//Process - 삭제 버튼 클릭
function partsDelete(){
	//Create Progressbar
	showProgressBar();
	
	var targetOrder01 = opener.document.getElementById("hidPmsCd01").value;
	var targetOrder02 = opener.document.getElementById("hidPmsCd02").value;
	var targetOrder03 = opener.document.getElementById("hidPmsCd03").value;
	var targetOrder04 = opener.document.getElementById("hidPmsCd04").value;
	var targetOrder05 = opener.document.getElementById("hidPmsCd05").value;
	var targetPlateNo = $("#hidPlateNo").val();
	
	var data = {"partDtlList":[{"pmsPartDtlPk":{"nationId":"Columbia", "companyId":"Axia", "areaId":"Termonorte", "engineModel":"20H35DFV","plateNo":targetPlateNo}}],
			"pmsTechOrderPk":{"pmsCd01":targetOrder01,"pmsCd02":targetOrder02,"pmsCd03":targetOrder03,"pmsCd04":targetOrder04,"pmsCd05":targetOrder05}};
	$.ajax({
		url: "/setPartsDelete",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result =="SUCCESS"){
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','성공적으로 삭제되었습니다.','info',function(){
						closeBtn();
				});
			}else{
				//finish ProgressBar
				closeProgressBar();
				
				$.messager.alert('Result message!','알 수 없는 에러가 발생하였습니다. 관리자에게 문의해주시기 바랍니다.','error');
			}
		}
	});
}

//닫기 버튼 클릭
function closeBtn(){
	var targetOrder01 = opener.document.getElementById("hidPmsCd01").value;
	var targetOrder02 = opener.document.getElementById("hidPmsCd02").value;
	var targetOrder03 = opener.document.getElementById("hidPmsCd03").value;
	var targetOrder04 = opener.document.getElementById("hidPmsCd04").value;
	var targetOrder05 = opener.document.getElementById("hidPmsCd05").value;
	opener.parent.worksItemSelectOne(targetOrder01,targetOrder02,targetOrder03,targetOrder04,targetOrder05);
	window.close();
}

//ValidationCheck
function saveValidationCheck(){
	if($("#cntQty").val().trim() == ""){
		$.messager.alert('ValidationCheck message!','Qty를 입력해주세요.','warning');
		return false;
	}else if(!($("#comboUnit").val() =="Cyl" || $("#comboUnit").val() =="Eng" || $("#comboUnit").val() =="Set")){
		$.messager.alert('ValidationCheck message!','Unit을 선택해주세요.','warning');
		return false;
	}
	return true;
}

//css관련 이벤트

//orderList 클릭 이벤트
function popListSelected(objSpan){
	$(objSpan).parent("div").find(".popListSelected").each(function(){
			$(this).removeClass("popListSelected")
	});
	$(objSpan).addClass("popListSelected");
}