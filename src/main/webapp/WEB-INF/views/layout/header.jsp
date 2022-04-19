<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>JIN-MES</title>
</head>
<!-- 	정의 css -->
	<link href="<c:url value='/resources/mes/css/fragments/header.css'/>" rel="stylesheet">
	
<script>
$(document).ready(function(){
	//로그아웃 이벤트
	$("#btnLogout").click(function(){
		gfn_logout();
	});
	
	//정보수정 이벤트
	$("#btnMyInfo").click(function(){
		gfn_mod();
	});
});

</script>
<body>

</body>
</html>