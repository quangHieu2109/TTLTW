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

<title><fmt:message>ket_qua_tim_kiem</fmt:message></title>
<link href="${pageContext.request.contextPath}/css/main.css"
	rel="stylesheet">
<link rel="icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
</head>
<body>
	<c:url var="NewsServlet" value="NewsServlet"></c:url>
	<c:url var="UserServlet" value="UserServlet"></c:url>
	<jsp:include page="header.jsp"></jsp:include>
<%-- 	<jsp:useBean id="baos" class="java.util.ArrayList" scope="request"></jsp:useBean> --%>
<%-- 	<jsp:useBean id="key" class="java.lang.String" scope="request"></jsp:useBean> --%>
	<div class="container">
		<div class="col-md-8 mg-a">
			<label class="keyword"><fmt:message>tu_khoa</fmt:message>:
				${key}</label>
			<c:forEach var="bao" items="${baos}" varStatus="status">
				<a
					href="${pageContext.request.contextPath}/${NewsServlet}?type=read&maBaiBao=${bao.getMaBaiBao() }"><div
						class="row space">
						<div class="col-lg-4">
							<img alt="" src="${bao.getFilePath()}" class="card-img">
						</div>
						<div class="col-lg-8">
							<label class="find-title">${bao.getTieuDe()}</label><br> <label
								class="find-descrip">${bao.getMoTa()}</label>
						</div>
					</div></a>
				<hr>
			</c:forEach>


		</div>

	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>