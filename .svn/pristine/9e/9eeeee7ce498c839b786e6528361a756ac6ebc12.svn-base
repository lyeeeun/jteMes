myApp.controller('QueryController', function($scope, es, esFactory) {    
	$scope.data = ["engine01","engine02","engine03","engine04","engine05","engine06","engine07","engine08","engine09","engine10"];
	var Conf_json = {};
	
	$scope.load = function(){
		$.ajax({
			url: "/config/xml/DB4_Station.xml",              // ajax로 ajax_xml.xml파일을 불러온다.
			cache: true,					// 사용자캐시를 사용
			dataType: "xml",				// 서버로부터 받을 것으로 예상되는 데이터 타입
			success: function(data){		// ajax요청을 통해 반환되는 데이터 data
				var json_data = "[";		// var json_data = '{ "TAG" : [';
				var pGroup = "";
				var nGroup = "";
				var trend_selbox = new Array('');
				var g_count = 0;
				$(data).find("TAG").each(function(index){
					if($(this).find('GROUP') != "" && $(this).find('GROUP') != "1") {
						json_data += '{ "id": "' + $(this).find('id').text() + '","name": "' + $(this).find('name').text() + '","GROUP": "' + $(this).find('GROUP').text() + '","unit": "' + $(this).find('unit').text() + '","mode": "' + $(this).find('mode').text() + '","mode2": "' + $(this).find('mode2').text() + '"},';
					}
				});
				json_data = json_data.substring(0,json_data.length-1) + "]";
				Conf_json = JSON.parse(json_data);
				//한국시간 표시, 반복실행 실행시키기
				play_repeat();
			}
		});			
	}
	
	var jsonData = {"bool":{"should":{"match" : {"DATE" : getWorldTime(-6)}}}};
	// Engine Data 1
	$scope.submit = function(timeArea) {
		/*var id = $("#hidCurrentMenu").val().split('_')[1];*/
		var id = 'common';
		jsonData = {"bool":{"should":{"match" : {"DATE" : timeArea}}}};
		es.search({
			index: id,
			body: {
				"query" : jsonData,
				"sort": {"DATE" : {"order":"desc"}},
				size : 1
			}
		}).then(function (response) {
			$scope.hitsTab4 = response.hits.hits;
			var i=0;
			var aJsonAr = new Array();
			$('.EM_GROUP_T').empty();

			aJsonAr[0] = $scope.hitsTab4[0];
			var canvas, context;
			$.each(Conf_json, function(key,value) {
				if(value.id.indexOf('CA') != -1) {
					if(value.GROUP == "HFO 시스템") {
						$('#HFO_SYSTEM').append('<tr><td style="width:65%; color: #005580;">' + value.name + '</td>' + 
							'<td style="width:35%; height:40px;"><table style="color:white; background-color: #005580; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:right;">'+ aJsonAr[0]._source[value.id] +'</td><td style="width:50%;">&nbsp;'+ value.unit +'</td></tr></td><tr>');
					} else if (value.GROUP == "LO 시스템") {
						$('#LO_SYSTEM').append('<tr><td style="width:65%; color: #005580;">' + value.name + '</td>' + 
								'<td style="width:35%; height:40px;"><table style="color:white; background-color: #005580; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:right;">'+ aJsonAr[0]._source[value.id] +'</td><td style="width:50%;">&nbsp;'+ value.unit +'</td></tr></td><tr>');
					} else if (value.GROUP == "DO 시스템") {
						$('#DO_SYSTEM').append('<tr><td style="width:65%; color: #005580;">' + value.name + '</td>' + 
								'<td style="width:35%; height:40px;"><table style="color:white; background-color: #005580; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:right;">'+ aJsonAr[0]._source[value.id] +'</td><td style="width:50%;">&nbsp;'+ value.unit +'</td></tr></td><tr>');
					}
				} else if(value.id.indexOf('CD') != -1) {
					if(value.GROUP == "HFO 시스템") {
						switch(value.mode2) {
							case "FAULT":
							case "RUN" : 
								if(aJsonAr[0]._source[value.id] == "1" && value.mode2 == "RUN") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">RUN</td></tr></table></td></tr>');
								}
								else if(aJsonAr[0]._source[value.id] == "1" && value.mode2 == "FAULT"){
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">FAULT</td></tr></table></td></tr>');
								} else if((aJsonAr[0]._source[value.id] != "1" && value.mode2 == "RUN") && value.mode != "FAULT") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">STOP</td></tr></table></td></tr>');
								}
								break;
							case "AUTO":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">AUTO</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">MANUAL</td></tr></table></td></tr>');
								}
								break;
							case "REMOTE":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">REMOTE</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">LOCAL</td></tr></table></td></tr>');
								}
								break;
							case "DUTY":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">DUTY</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">STANBY</td></tr></table></td></tr>');
								}
								break;
							case "ON":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">ON</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">OFF</td></tr></table></td></tr>');
								}
								break;
							case "OPEN":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">OPEN</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">CLOSE</td></tr></table></td></tr>');
								}
								break;
						}
					} else if (value.GROUP = "LO 시스템") {
							switch(value.mode2) {
							case "FAULT":
							case "RUN" : 
								if(aJsonAr[0]._source[value.id] == "1" && value.mode2 == "RUN") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">RUN</td></tr></table></td></tr>');
								}
								else if(aJsonAr[0]._source[value.id] == "1" && value.mode2 == "FAULT"){
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">FAULT</td></tr></table></td></tr>');
								} else if((aJsonAr[0]._source[value.id] != "1" && value.mode2 == "RUN") && value.mode != "FAULT") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">STOP</td></tr></table></td></tr>');
								}
								break;
							case "AUTO":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">AUTO</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">MANUAL</td></tr></table></td></tr>');
								}
								break;
							case "REMOTE":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">REMOTE</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">LOCAL</td></tr></table></td></tr>');
								}
								break;
							case "DUTY":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">DUTY</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">STANBY</td></tr></table></td></tr>');
								}
								break;
							case "ON":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">ON</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">OFF</td></tr></table></td></tr>');
								}
								break;
							case "OPEN":
								if(aJsonAr[0]._source[value.id] == "1") {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">OPEN</td></tr></table></td></tr>');
								} else {
									$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">CLOSE</td></tr></table></td></tr>');
								}
								break;
						}
					} else if (value.GROUP = "DO 시스템") {
						switch(value.mode2) {
						case "FAULT":
						case "RUN" : 
							if(aJsonAr[0]._source[value.id] == "1" && value.mode2 == "RUN") {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">RUN</td></tr></table></td></tr>');
							}
							else if(aJsonAr[0]._source[value.id] == "1" && value.mode2 == "FAULT"){
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">FAULT</td></tr></table></td></tr>');
							} else if((aJsonAr[0]._source[value.id] != "1" && value.mode2 == "RUN") && value.mode != "FAULT") {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">STOP</td></tr></table></td></tr>');
							}
							break;
						case "AUTO":
							if(aJsonAr[0]._source[value.id] == "1") {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">AUTO</td></tr></table></td></tr>');
							} else {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">MANUAL</td></tr></table></td></tr>');
							}
							break;
						case "REMOTE":
							if(aJsonAr[0]._source[value.id] == "1") {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">REMOTE</td></tr></table></td></tr>');
							} else {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">LOCAL</td></tr></table></td></tr>');
							}
							break;
						case "DUTY":
							if(aJsonAr[0]._source[value.id] == "1") {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">DUTY</td></tr></table></td></tr>');
							} else {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">STANBY</td></tr></table></td></tr>');
							}
							break;
						case "ON":
							if(aJsonAr[0]._source[value.id] == "1") {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">ON</td></tr></table></td></tr>');
							} else {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">OFF</td></tr></table></td></tr>');
							}
							break;
						case "OPEN":
							if(aJsonAr[0]._source[value.id] == "1") {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #00EE00; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">OPEN</td></tr></table></td></tr>');
							} else {
								$('#' + value.mode).append('<tr><td colspan="2" style="width:35%; height:40px;"><table style="color:white; background-color: #EE0000; width:100%; height:30px;"><tr style="border:1px solid #bdbdbd;"><td style="width:50%; text-align:center;">CLOSE</td></tr></table></td></tr>');
							}
							break;
					}
				}
				}
				//progressbar 종료
			  	closeProgressBar();
			});
			
		}).catch(function (err) {
			if (err.status === 404) {
				alert("error 404" );
			} else {
				alert("error : " + err );
			}
			//progressbar 종료
		  	closeProgressBar();
		});
	}
	//progressbar 시작
	showProgressBar();
	$scope.load();
});