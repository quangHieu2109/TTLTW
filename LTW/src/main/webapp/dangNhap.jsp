<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<fmt:setLocale value="vi_VN" />
	<c:if test="${param.lang == 'en'}">
		<fmt:setLocale value="en_US" />
	</c:if>
	<fmt:setBundle basename="lang.lang" />
<meta charset="UTF-8">
<title><fmt:message>dang_nhap</fmt:message></title>
<link rel="icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dangKy.css">
<style type="text/css">
.content {
	display: block;
	margin: auto;
}

button {
	display: flex;
	/* 	justify-content: space-between; */
	font-size: 20px;
	margin: auto;
}

a {
	text-decoration: none;
}

.button2 {
	width: 60%;
	display: flex;
	justify-content: space-between;
	font-size: 20px;
	margin: auto;
	display: flex;
}

h1 {
	font-size: 40px;
	margin-bottom: 50px;
}

.form {
	border: 1px solid;
	min-width: 60%;
	max-width: max-content;
	margin: auto;
	padding-bottom: 30px;
}

label {
	text-wrap: nowrap;
	font-size: 25px;
}

.body {
	width: 100%;
}

.line input {
	width: 60%;
}

.content {
	width: 90%;
}

.error {
	width: max-content;
	color: red;
	font-weight: 600;
	margin: auto;
	margin-top: 10%;
	color: red;
}

.error label {
	font-size: 40px;
}
</style>

</head>
<body>
		<c:url var="NewsServlet" value="NewsServlet"></c:url>
	<c:url var="UserServlet" value="UserServlet"></c:url>
	<jsp:include page="header.jsp"></jsp:include>
<%-- 	<jsp:useBean id="error" class="java.lang.String" scope="request"></jsp:useBean> --%>
	<div class="error">
		<c:if test="${error.length() >0 }">
			<label><fmt:message>${error }</fmt:message></label>
		</c:if>
	</div>

	<form action="${pageContext.request.contextPath}/${UserServlet}" method="post" class="form">
	<input type="hidden" name="type" value="login">
		<h1><fmt:message>dang_nhap_tai_khoan</fmt:message></h1>
		<div class="body">
			<div class="content">
				<div class="line">
					<label><fmt:message>ten_dang_nhap</fmt:message></label> <input type="text" name="tenDangNhap" required="required">
				</div>
				<div class="line">
					<label><fmt:message>mat_khau</fmt:message></label> <input type="password" name="matKhau" required="required">
				</div>



				<div class="button2">

					<a href="${pageContext.request.contextPath}/${UserServlet}?type=dangKy" class="btn"><fmt:message>dang_ky</fmt:message></a>
					<button type="submit" class="btn"><fmt:message>dang_nhap</fmt:message></button>

				</div>
			</div>
		</div>
	</form>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>