$(document).ready(function(){
	
	//검색 Select 박스 생성
	setSearchCombo();
	
	var orderGrid = $('#orderGridTable');
	orderGrid.datagrid({
		pageSize:20,
		columns:[[
			{field:'pms_cd_01',title:'Code',width:20,formatter: function(value,row,index){
				if (row.pmsCd01){
					return row.pmsCd01 +" "+row.pmsCd02+" "+row.pmsCd03+" "+row.pmsCd04+" "+row.pmsCd05;
				} else {
					return value;
				}
			}},
			{field:'desc_tech',title:'PMS Descript',width:30,sortable:true,
				formatter: function(value,row,index){
					return row.descTech;
				}
			},
			{field:'desc_order',title:'Method',width:30,sortable:true,
				formatter: function(value,row,index){
					return row.descOrder;
				}
			},
			{field:'gap_run_hour',title:'Interval',width:10,sortable:true,
				formatter: function(value,row,index){
					return row.gapRunHour;
				}
			},
			{field:'needPlateInfoJson',title:'Parts',width:10,sortable:true
				,formatter: function(value,row,index){
					var needPlateInfoJson = JSON.parse(row.needPlateInfoJson);
				if (needPlateInfoJson != undefined && Object.keys(needPlateInfoJson).length > 0){
					return "include";
				} else {
					return "none";
				}
			}}
			]]
	});
	orderGrid.datagrid({pagePosition:'bottom'});
	orderGrid.datagrid('getPager').pagination({
		layout:['list','sep','first','prev','sep','links','sep','next','last','sep','refresh','info'],
	});
});

//검색 엔터 이벤트
$('#orderText').textbox({
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
		{"id":"desc_tech","text":"PMS Descript","selected":true},
		{"id":"desc_order","text":"Method"},
	];
	//if($("#hidCombo").val() == "code"){
	//	comboData = [{"id":"name","text":"NAME"},{"id":"code","text":"CODE","selected":true}];
	//}
	$("#orderCombo").combobox({
		data : comboData,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
}
//검색
function doSearch(){
	$('#orderGridTable').datagrid('load',{
		searchGubun: $("#orderCombo").val(),
		searchText:$("#orderText").val()
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
					url: "/setOrderUpload",
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
