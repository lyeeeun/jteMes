$(document).ready(function(){
	//검색 Select 박스 생성
	setSearchCombo();
	
	var orderGrid = $('#spareGridTable');
	orderGrid.datagrid({
		pageSize:20,
		columns:[[
			{field:'engineModel',title:'Type',width:10,sortable:true,
				formatter: function(value,row,index){
					return row.pmsPartDtlPk.engineModel;
				}
			},
			{field:'platePart',title:'Part Section',width:25,sortable:true},
			{field:'prodStd',title:'Part Name',width:25,sortable:true},
			{field:'pmsPartDtlPk.plateNo',title:'Part Number',width:10,sortable:true,
				formatter: function(value,row,index){
					return row.pmsPartDtlPk.plateNo;
				}
			},
			{field:'uCode',title:'UCode',width:10,sortable:true,
				formatter: function(value,row,index){
					return row.ucode;
				}
			},
			{field:'amtCount',title:'On-Hand(재고)',width:10,sortable:true},
			{field:'stockYn',title:'Serialized Parts(stockYn)',width:10,sortable:true}
			
		]]
	});
	orderGrid.datagrid({pagePosition:'bottom'});
	orderGrid.datagrid('getPager').pagination({
		layout:['list','sep','first','prev','sep','links','sep','next','last','sep','refresh','info'],
	});
});

//검색 엔터 이벤트
$('#spareText').textbox({
	inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		keyup:function(e){
			if (e.keyCode == 13) {
				doSearch();
			}
		}
	})
});

//검색 Combo 박스 생성
function setSearchCombo(){
	var comboData = [
		{"id":"engineModel","Type":"NAME"},
		{"id":"platePart","text":"Part Section","selected":true},
		{"id":"prodStd","text":"Part Name"},
		{"id":"pmsPartDtlPk.plateNo","text":"Part Number"},
		{"id":"uCode","text":"UCode"},
		{"id":"amtCount","text":"On-Hand"},
		{"id":"stockYn","text":"Serialized Parts"}
	];
	//if($("#hidCombo").val() == "code"){
	//	comboData = [{"id":"name","text":"NAME"},{"id":"code","text":"CODE","selected":true}];
	//}
	$("#spareCombo").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
}
//검색
function doSearch(){
	$('#spareGridTable').datagrid('load',{
		searchGubun: $("#spareCombo").val(),
		searchText:$("#spareText").val()
	});
}

//엑셀파일 유효성검사
function checkFileType() {
	var file = $("#file").val();
	
	var fileFormat = file.split(".");
	
	if (file == "" || file == null) {
		$.messager.alert('Result message!','파일을 선택해주세요.','warning');
		return false;
	}else if(fileFormat.indexOf("xlsx") == -1){
		$.messager.alert('Result message!','엑셀파일만 import 가능합니다.','warning');
		return false;
	}
		return true;
}
//엑셀파일 import
function excelImport() {	
	if(checkFileType()){
		$.messager.confirm('Confirm message!', '데이터가 많은 경우 처리가 늦어 질 수 있습니다. 그래도 import 하시겠습니까?', function(r){
			if (r){
				//Create Progressbar
				showProgressBar();
				
				// Get form
				var form = $('#excelUploadForm')[0];
				
				// Create an FormData object 
				var data = new FormData(form);
				
				$.ajax({
					type: "POST",
					enctype: 'multipart/form-data',
					url: "/setPartsUpload",
					data: data,
					processData: false,
					contentType: false,
					cache: false,
					//timeout: 600000,
					success: function (data) {
						//finish ProgressBar
						closeProgressBar();
						
						if(data =="SUCCESS"){
							$.messager.alert('Result message!','성공적으로 등록되었습니다.','info',function(){
								location.reload();
							});
						}else if(data =="ERROR"){
							$.messager.alert('Result message!','알 수 없는 에러가 발생하였습니다. 관리자에게 문의해주시기 바랍니다.','error');
						}else{
							
							$.messager.alert('Result message!',data,'error');
						}
					},
					error: function (e) {
						//finish ProgressBar
						closeProgressBar();
						
						$.messager.alert('Result message!',e,'error');
					}
				});
			}
		});
	}
}

