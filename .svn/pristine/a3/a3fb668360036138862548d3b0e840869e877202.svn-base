var Conf_json;
//검색된 시간
var Search_Date;
$(document).ready(function(){
	//progressbar 시작
	showProgressBar();
	
	$.ajax({
		url: "/config/xml/DB4_conf.xml",              // ajax로 ajax_xml.xml파일을 불러온다.
		cache: true,                     // 사용자캐시를 사용
		dataType: "xml",                  // 서버로부터 받을 것으로 예상되는 데이터 타입
		success: function(data){          // ajax요청을 통해 반환되는 데이터 data
			var json_data = "[";	//var json_data = '{ "TAG" : [';
			var pGroup = "";
			var nGroup = "";
			var trend_selbox = new Array('');
			var g_count = 0;
			$(data).find("TAG").each(function(index){
				json_data += '{ "id": "' + $(this).find('id').text() + '","name": "' + $(this).find('name').text() + '","GROUP": "' + $(this).find('GROUP').text() + '","unit": "' + $(this).find('unit').text() + '","al_map": "' + $(this).find('al_map').text() + '"},';
				//trend viewer select box init
				if( index == 0 ) {
					pGroup = $(this).find('GROUP').text();
				}
				nGroup = $(this).find('GROUP').text();
				if (pGroup != nGroup && $(this).find('id').text().indexOf("EA") != -1 && nGroup != "COMMON" && nGroup != "불필요" ) {
					$('#tag_id').append('<option value="'+ trend_selbox[g_count].substring(0, trend_selbox[g_count].length-1) +'">'+ pGroup +'</option>');
					pGroup = nGroup;
					g_count++;
					trend_selbox[g_count] = $(this).find('id').text() + ",";
				} else if (pGroup == nGroup && $(this).find('id').text().indexOf("EA") != -1 && nGroup != "COMMON" && nGroup != "불필요" ) {
					trend_selbox[g_count] += $(this).find('id').text() + ",";
				}
			});
			json_data = json_data.substring(0,json_data.length-1) + "]";
			Conf_json = JSON.parse(json_data);
		}
	});
	//한국시간 표시, 반복실행 실행시키기
	play_repeat();
}); 

//ElasticSearch Data 조회
function elasticDataSearch(timeArea){
	var index = $("#hidCurrentMenu").val().split('_')[1];
	var data = {"startTime":timeArea
			,"index":[index]};	
	$.ajax({
		url: "/web-engineStatus",
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
				elasticDataSearch_EngineAlarm(result);	
			}
		}
	})
}

function elasticDataSearch_EngineAlarm(eng_data) {
	var index_al = $("#hidCurrentMenu").val().split('_')[1] + "_al";
	var index_sd = $("#hidCurrentMenu").val().split('_')[1] + "_sd";
	var index_tr = $("#hidCurrentMenu").val().split('_')[1] + "_tr";
	var json_date = JSON.parse(eng_data);
	var data = {"startTime":json_date.source.DATE
			,"index":[index_sd, index_tr, index_al]};
	$.ajax({
		url: "/web-engineStatusAlarm",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(result){
			if(result == "noData"){
				/*alert("데이터가 없습니다. 시간을 다시 설정해 주세요.");*/
				fn_EngineValue(eng_data,"no_data");
				closeProgressBar();
			}else if(result == "error"){
				/*alert("알 수 없는 에러가 발생했습니다. 관리자에게 문의해 주세요.");*/
				fn_EngineValue(eng_data,"no_data");
				closeProgressBar();
			}else{
				$("#hidWebData").val($("#hidWebData").val()+result);
				fn_EngineValue(eng_data,result);	
			}
		}
	});
}

//ElasticSearch Data 조회 콜백
function fn_EngineValue(searchData, eng_data_alarm){
	try{
		var eng_data = JSON.parse(searchData);
		var eng_data_al = JSON.parse(eng_data_alarm);
		var eng_data_sd = eng_data_al[0];
		var eng_data_tr = eng_data_al[1];
		eng_data_al = eng_data_al[2];
		
		Search_Date = eng_data.source.DATE;
		//시간정보 SearchBox영역에 뿌려주기
		displayDate(Search_Date);
		
		$('#GENERATOR_DATA').empty();
		$('#ENGINE_CONTROL_FACTOR').empty();
		$('#ENGINE_SPEED_DATA').empty();
		$('#FUEL_GAS_SYSTEM').empty();
		$('#LUBE_OIL_SYSTEM').empty();
		$('#COMPRESSED_AIR_SYSTEM').empty();
		$('#GENERATOR_SYSTEM').empty();
		$('#FUEL_OIL_SYSTEM').empty();
		$('#COOLING_WATER_SYSTEM').empty();
		$('#CHARGE_AIR_SYSTEM').empty();
		$('#CMB_PMAX').empty();
		$('#CMB_IMEP').empty();
		$('#EXH_GAS_CYLINDER_TEMP').empty();
		$('#MAIN_BEARING_TEMP').empty();
		$('#ENGINE_RUN_HOUR').empty();
		
		$.each(Conf_json, function(key,value) {
			if(value.GROUP == "GENERATOR DATA") {
				$('#GENERATOR_DATA').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
					'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "ENGINE CONTROL FACTOR") {
				$('#ENGINE_CONTROL_FACTOR').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "ENGINE SPEED DATA") {
				$('#ENGINE_SPEED_DATA').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "FUEL GAS SYSTEM") {
				$('#FUEL_GAS_SYSTEM').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "LUBE OIL SYSTEM") {
				$('#LUBE_OIL_SYSTEM').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "COMPRESSED AIR SYSTEM") {
				$('#COMPRESSED_AIR_SYSTEM').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "GENERATOR SYSTEM") {
				$('#GENERATOR_SYSTEM').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "FUEL OIL SYSTEM") {
				$('#FUEL_OIL_SYSTEM').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "COOLING WATER SYSTEM") {
				$('#COOLING_WATER_SYSTEM').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "CHARGE AIR SYSTEM") {
				$('#CHARGE_AIR_SYSTEM').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "CYLINDER MONITORING & BALANCING") {
				if(value.name.indexOf('Pmax') != -1) {
					$('#CMB_PMAX').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
							'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
				} else if( value.name.indexOf('IMEP') != -1 ) {
					$('#CMB_IMEP').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
							'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
				} 
			} else if (value.GROUP == "EXH. GAS CYLINDER TEMP") {
				$('#EXH_GAS_CYLINDER_TEMP').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "MAIN BEARING TEMP") {
				$('#MAIN_BEARING_TEMP').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			} else if (value.GROUP == "ENGINE RUN HOUR") {
				$('#ENGINE_RUN_HOUR').append('<tr><td  class="ev_textarea">' + value.name + '</td>' + 
						'<td class="ev_numberarea"><table class="ev_number" id="' + value.id + '"><tr><td class="number_left">'+ eng_data.source[value.id] +'</td><td class="number_right">&nbsp;'+ value.unit +'</td></tr></td><tr>');
			}
				
				//현재 발생한 alarm과 mapping 되는 analog tag 구하여 배경색 변경
				var al_map_tag = new Array();
				var count = 0;
				
				if((eng_data_sd[value.id] == true && value.al_map != "") || (eng_data_tr[value.id] == true && value.al_map != "") ||
						(eng_data_al[value.id] == true && value.al_map != "")) {
					if(value.al_map.indexOf(',') != -1) {
						al_map_tag = value.al_map.split(',');
						while (count < al_map_tag.length) {
							$('#' + al_map_tag[count]).css('background-color','#f68a8a');
							$('#' + al_map_tag[count]).css('color','red');
							$('#' + al_map_tag[count]).css('font-weight','bold');
							$('#' + al_map_tag[count]).css('cursor','pointer');
							$('#' + al_map_tag[count]).attr('alarm','1');
							count++;
						}
					} else {
						$('#' + value.al_map).css('background-color','#f68a8a');
						$('#' + value.al_map).css('color','red');
						$('#' + value.al_map).css('font-weight','bold');
						$('#' + value.al_map).css('cursor','pointer');
						$('#' + value.al_map).attr('alarm','1');
					}
				}
				//progressbar 종료
				closeProgressBar();
		});
	}catch(err) {
		if (err.status === 404) {
			alert("error 404" );
		} else {
			alert("error : " + err );
		}
		//progressbar 종료
		closeProgressBar();
	}
}

//alarm 발생한 데이터 click 시 alarm list로 이동 - alarm list 개발 후 click한 데이터 관련 alarm list만 보이도록 구현 예정. 
$(".EM_GROUP > table").on('click', function(event){
	if($(event.target).parent().parent().parent().attr('alarm')) {
		
		//페이지 이동(date, menuId,text, url)
		page_move(Search_Date,"alarm_list","AlarmList","/alarm_list");
	}
});
