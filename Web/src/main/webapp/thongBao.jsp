<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<fmt:setLocale value="vi_VN" />
	<c:if test="${param.lang == 'en'}">
		<fmt:setLocale value="en_US" />
	</c:if>

	<fmt:setBundle basename="lang" />
<title><fmt:message>thong_bao</fmt:message></title>
<link rel="icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/dangKy.css">
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
	margin-top: 5%;
	padding-bottom: 30px;
}

label {
	text-wrap: nowrap;
	font-size: 25px;
	margin: auto;
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

.line {
	flex-direction: column;
}
</style>

</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
<%-- 	<jsp:useBean id="error" class="java.lang.String" scope="request"></jsp:useBean> --%>
	
	<form action="${pageContext.request.contextPath}/UserServlet"
		method="post" class="form">
		<input type="hidden" name="type" value="login">
		<h1>
			<fmt:message>thong_bao</fmt:message>
		</h1>
		<div class="body">
			<div class="content">
				<c:if test="${nguoiDung.isDangKy() }">

					<div class="line">
						<label><fmt:message>ban_da_dang_ky_tai_khoan_truoc_do</fmt:message>.
						</label> <label><fmt:message>hay_doi_cho_den_khi_duoc_admin_phe_duyet_de_co_the_dang_bai</fmt:message>!
						</label>
					</div>
				</c:if>
				<c:if test="${!nguoiDung.isDangKy() }">
					<div class="line">
						<label><fmt:message>chuc_nang_dang_bai_chi_danh_cho_tai_khoan_nha_bao</fmt:message>.
						</label> <label><fmt:message>ban_can_dang_ky_lam_nha_bao_de_co_the_su_dung_chuc_nang_dang_bai</fmt:message>!
						</label>
					</div>

					<div class="button2">
						<a class="btn margin-a"
							href="${pageContext.request.contextPath}/UserServlet?type=dangKyDangBai&typeDK=dangKy"><fmt:message>dang_ky</fmt:message></a>

					</div>
				</c:if>
			</div>
		</div>
	</form>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>