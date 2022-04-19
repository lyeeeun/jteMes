var altag = new Array();//검색 조건 태그(WHERE)
var altag_source = new Array();//조회할 데이터(SELECT)
var altag_name = {};//태그이름
	
$(document).ready(function(){
	//index콤보박스 데이터생성
	var indexArray = ["engine01", "engine02", "engine03","engine04", "engine05", "engine06", "engine07","engine08", "engine09", "engine10"];
	var indexComboBox = [{"text":"TOTAL","id":indexArray.join(","),"selected":true}];
	for(var index in indexArray){
		indexComboBox.push({"id":indexArray[index],"text":indexArray[index].toUpperCase()});
	}
	$("#indexBox").combobox({
		data : indexComboBox,
		valueField : 'id',
		textField : 'text',
		method : 'get'
	});
	
	//수정 -jkkim
	$.ajax({
		url: "/config/xml/DB4_conf.xml",		// ajax로 ajax_xml.xml파일을 불러온다
		cache: true,		// 사용자캐시를 사용할 것인가.
		dataType: "xml",		// 서버로부터 받을 것으로 예상되는 데이터 타입.
		success: function(data){		// ajax요청을 통해 반환되는 데이터 data.
			var json_data = "[";
			var pGroup = "";
			var nGroup = "";
			var trend_selbox = new Array('');
			var g_count = 0;
			$(data).find("TAG").each(function(index){
				json_data += '{ "id": "' + $(this).find('id').text() + '","name": "' + $(this).find('name').text() + '","GROUP": "' + $(this).find('GROUP').text() + '","unit": "' + $(this).find('unit').text() + '"},';
			});
			
			json_data = json_data.substring(0,json_data.length-1) + "]";
			var Conf_json = JSON.parse(json_data); //Engine, Common Conf 설정 담고 있는 전역변수
			
			var alarm_count = 0;
			$.each(Conf_json, function(key,value) {
				if(value.GROUP == "SD" || value.GROUP == "TR" || value.GROUP == "AL") {
					altag[alarm_count] = value.id;
					altag_source[alarm_count] = value.id;
					altag_name[value.id] = value.name;
					alarm_count++;
				}
			});
			altag_source.push("DATE");
			//실행
			startSearch();
		}
	});
});
//ElasticSearch Data 호출
function elasticDataSearch(timearea){
	try{
		//progressbar 시작
		showProgressBar();
		
		var indexArray = new Array();
		
		var data = {"startTime":timearea
				,"size":parseInt($('#sizeBox').val())
				,"field1":altag_source
				,"field2":altag};
		$('#indexBox').combobox('getValue').split(',').forEach(function(element){
			indexArray.push(element+"_sd");
			indexArray.push(element+"_tr");
			indexArray.push(element+"_al");
		});
		
		data["index"] = indexArray;
		
		$.ajax({
			url: "/web-alarmList",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(result){
				if(result == "noData"){
					alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");
					closeProgressBar();
				}else if(result == "error"){
					alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");
					closeProgressBar();
				}else{
					$("#hidWebData").val(result);
					fn_AlarmList(result);	
				}
			}
		});
	}catch(err){
		if (err.status === 404) {
			alert("error 404" );
		} else {
			alert("error : " + err );
		}
		//progressbar 종료
		closeProgressBar();
	}
}
//ElasticSearch Data 호출 콜백
var datas;
function fn_AlarmList(result){
	datas  = new Array();
	var eng_data = JSON.parse(result)
	var subdatas = new Array();
	var aJsonArray = new Array();
	var i=0;
	var cc=0;
	
	//시간정보 표시
	displayDate(eng_data[0].DATE);
	while(i < eng_data.length)
	{
		$.each(eng_data[i], function(key,value) {
			if(value == true && key != "DATE" && key != "_index") {
				datas[cc] = {"hid_id":cc, "id":key, "index": eng_data[i]._index.split('_')[0], "name":altag_name[key], "DATE":eng_data[i].DATE};
				subdatas[cc] = {"id":key, "index":eng_data[i]._index, "name":altag_name[key], "DATE":eng_data[i].DATE};
				cc++;
			}
		});
		i++;
	}
	
	var datagrid = $('#alarm_list').datagrid({
		data:datas,
		columns:[[
			{field:'index',title:'INDEX',width:'10%',sortable:"true"},
			{field:'id',title:'TAG_ID',width:'10%',sortable:"true"},
			{field:'name',title:'name',width:'50%',sortable:"true"},
			{field:'DATE',title:'DATE',width:'30%',sortable:"true"}
		]],
		remoteFilter:false,
		remoteSort:false,
		pagination:true,
		nowrap:false,
		fit:false,
		fitColumns:false,
		autoRowHeight:false,
		singleSelect:true,
		collapsible:true,
		onEndEdit: function(){}, 
		onAfterEdit: function(){}, 
		onBeforeEdit:function(){},
		pageSize: 20,
		pageList: [10,20,50,100]
	});
	datagrid.datagrid('enableFilter');
	datagrid.datagrid('loadData',datas);
	
	//Save 버튼 활성화 
	$("#saveBtn").show();
	//progressbar 종료
	closeProgressBar();
}

//다운 버튼 - csv 파일 저장 콜백
function fn_excelDown(){
	try{
		var csv_row = new Array();
		//csv파일 헤더 매핑
		csv_row[0] = ["index","id","name","DATE"];
		
		
		for(var i = 0; i<=datas.length-1; i++)
		{
			//csv파일 바디 매핑
			var csv_body_field = new Array();
				for(var field_name in csv_row[0]){
					csv_body_field[field_name] = datas[i][csv_row[0][field_name]];
				}
			csv_row[i+1] = csv_body_field.join(',');
		}
		
		//데이터가 없는 경우 예외 처리
		if(!csv_row) {
			console.error('Console.save: No data')
			return;
		}
		//파일 저장
		var filename = "AlarmList.csv";
		var blob = new Blob([csv_row.join("\n")], {type: 'text/plain'}),
		e = document.createEvent('MouseEvents'),
		a = document.createElement('a')
		// FOR IE:
		if (window.navigator && window.navigator.msSaveOrOpenBlob) {
			window.navigator.msSaveOrOpenBlob(blob, filename);
		}else{
			var e = document.createEvent('MouseEvents'),
			a = document.createElement('a');				
			a.download = filename;
			a.href = window.URL.createObjectURL(blob);
			a.dataset.downloadurl = ['text/plain', a.download, a.href].join(':');
			e.initEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
			a.dispatchEvent(e);
		}
	}catch(err) {
		if (err.status === 404) {
			alert("error 404" );
		} else {
			alert("error : " + err );
		}
	}
}

//행클릭 시 EngineValue로 이동
function onClickRow(index,field){
	//페이지 이동(date, menuId,text, url)
	page_move(field["DATE"],"esrv_"+field["index"],"RealValue","/engine_value");
}