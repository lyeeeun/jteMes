<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hello WebView for JSP</title>
</head>
<body>
	<c:out value="<xmp>" escapeXml="true"></c:out>
	<h2>Hello! ${name}</h2>
	<div>JSP version!</div>
	
	<br>
	<p>테스트 이미지입니다.</p>
	<br>
	<img src="/image/storyhubblespirograph.jpg">
	<br>
	<div>
		<p>사용자자가 입력한 파라메터 전체</p>
		${param}<br>=================================
		<p>사용자자가 입력한 파라메터</p>
		<c:forEach var="map" items="${param}">
			Key is "${map.key}" : Value is "${map.value}"<br>
		</c:forEach>
	</div>
</body>
</html>