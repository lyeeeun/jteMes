$(document).ready(function(){
	if($("#loginMsg").val() != "" && $("#loginMsg").val() != undefined) {
		kendo.alert($("#loginMsg").val());
	}
});

function login() {
	var id = $("#id_text");
	var pw = $("#pw_text");

	if (id.val() == "") {
		alert("Please Type your login id");
		id.focus();
		return false;
	}

	if (pw.val() == "") {
		alert("Please Type your password");
		pw.focus();
		return false;
	}

	if("Y"=="[[${_RSAUseYn}]]"){
		// rsa 암호화 적용
		var rsa = new RSAKey();
		rsa.setPublic($('#RSAModulus').val(), $('#RSAExponent').val());

		$("#id").val(rsa.encrypt(id.val()));
		$("#password").val(rsa.encrypt(pw.val()));
	}else{
		// rsa 암호화 미적용
		$("#id").val(id.val());
		$("#pw").val(pw.val());
	}
	return true;
}