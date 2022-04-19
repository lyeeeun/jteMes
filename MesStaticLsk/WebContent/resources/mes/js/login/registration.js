$(document).ready(function() {
	$("#userForm #userId, #userForm #userNm, #userForm #password, #userForm #passwordCheck").focusout(checkPasswordMatch);
	// checkPasswordMatch.call(this);
});

this.checkPasswordMatch = function() {
	var password = $("#userForm #password").val();
	var confirmPassword = $("#userForm #passwordCheck").val();
	var idPtn  = "^[-_.@a-zA-Z0-9]{4,15}$";
	var pwdPtn = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}/;
	

	if (!$("#userForm #userId").val().match(idPtn)){
		$("#userForm #reqNewUser").html("\[\[ \"login id\" is required! and input limit(4-15) without special character(except - _ . @) \]\]");
		$("#userForm #userId").focus();
		$("#userForm #reqNewUser").attr("style", "color:#92B3B7");
	}else if(!pwdPtn.test(password)){
		$("#userForm #reqNewUser").html("\[\[ \"password\" is required! and input limit(8-16) with special character and number \]\]");
		$("#userForm #password").focus();
		$("#userForm #reqNewUser").attr("style", "color:#92B3B7");
	}else if(password != confirmPassword){
		$("#userForm #reqNewUser").html("\[\[ Passwords do not match! \]\]");
		$("#userForm #reqNewUser").attr("style", "color:#92B3B7");
	}else if($("#userForm #userNm").val().trim().length<2 || $("#userForm #userNm").val().trim().length>25){
		$("#userForm #reqNewUser").html("\[\[ \"user name\" is required! and input limit(2-15) \]\]");
		$("#userForm #userNm").focus();
		$("#userForm #reqNewUser").attr("style", "color:#92B3B7");
	}else{
		$("#userForm #reqNewUser").html("<input type=\"submit\" value=\"사용자생성하기\" />");
		$("#userForm #reqNewUser").attr("style", "color:black");
	}
}