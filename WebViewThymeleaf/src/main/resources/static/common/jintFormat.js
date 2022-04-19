// easy-ui DateBox 포맷1
$.fn.datebox.defaults.formatter = function(date) {
	var y = date.getFullYear();
	var m = padLeft(date.getMonth() + 1, 2);
	var d = padLeft(date.getDate(), 2);
	return y + '-' + m + '-' + d;
}
// easy-ui DateBox 포맷2
$.fn.datebox.defaults.parser = function(s) {
	var t = Date.parse(s);
	if (!isNaN(t)) {
		return new Date(t);
	} else {
		return new Date();
	}
}

$(document).ready(function() {
	$("input").each(function() {
		// 시간
		if ($(this).attr("jintformat") == "HOUR") {
			$(this).addClass("jint_hour");
	
			var hourList = new Array();
	
			for (i = 0; i <= 23; i++) {
				var objHour = new Object();
				objHour.id = padLeft(i, 2);
				objHour.text = padLeft(i, 2);
				hourList.push(objHour);
			}
			$(this).combobox({
				data : hourList,
				valueField : 'id',
				textField : 'text',
				method : 'get'
			});
		}

		// 분
		if ($(this).attr("jintformat") == "MIN" || $(this).attr("jintformat") == "SEC") {
			$(this).addClass("jint_min");
	
			var minList = new Array();
	
			for (i = 0; i <= 59; i++) {
				var objMin = new Object();
				objMin.id = padLeft(i, 2);
				objMin.text = padLeft(i, 2);
				minList.push(objMin);
			}

			$(this).combobox({
				data : minList,
				valueField : 'id',
				textField : 'text',
				method : 'get'
			});
		}

		// 초
		if ($(this).attr("jintformat") == "SEC") {
			$(this).addClass("jint_sec");
	
			var secList = new Array();
	
			for (i = 0; i <= 59; i++) {
				var objSec = new Object();
				objSec.id = padLeft(i, 2);
				objSec.text = padLeft(i, 2);
				secList.push(objSec);
			}
	
			$(this).combobox({
				data : secList,
				valueField : 'id',
				textField : 'text',
				method : 'get'
			});
		}
	});
});
