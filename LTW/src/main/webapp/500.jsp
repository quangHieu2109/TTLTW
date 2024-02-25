<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
img {
	display: block;
	width: 60%;
	margin: auto;
}
</style>
<title>500</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<img alt="" src="${pageContext.request.contextPath}/img/500.jpg">
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>