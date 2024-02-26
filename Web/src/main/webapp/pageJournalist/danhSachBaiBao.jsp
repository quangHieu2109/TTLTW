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
<fmt:setBundle basename="lang.lang" />
<title><fmt:message>thong_bao_DS</fmt:message></title>
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
	<jsp:include page="/header.jsp"></jsp:include>
	<c:url var="NewsServlet" value="NewsServlet"></c:url>
	<c:url var="UserServlet" value="UserServlet"></c:url>
	<div class="container">
		<h1 class="fs-25">
			<fmt:message>thong_bao_DS</fmt:message>
		</h1>
		<div class="col-lg-10 ma">
			<c:set var="baoND"
				value="${newsService.getBaiBaoByTenDanhNap(nguoiDung.getTenDangNhap()) }"></c:set>
			<c:forEach items="${baoND }" var="bao">
				<div class="row border">
					<div class="col-lg-10 space flex ">
						<div class="col-lg-4">
							<img alt="" src="${bao.getFilePath()}" class="card-img">
						</div>
						<div class="col-lg-8 br">
							<label class="find-title">${bao.getTieuDe()}</label><br> <label
								class="find-descrip">${bao.getMoTa()}</label>
						</div>
					</div>
					<div class="col-lg-2 button">
						<a
							href="${pageContext.request.contextPath}/${NewsServlet}?type=edit&typeEdit=edit&maBaiBao=${bao.getMaBaiBao() }"
							class="btn"><fmt:message>chinh_sua</fmt:message></a> <a
							href="${pageContext.request.contextPath}/${NewsServlet}?type=edit&typeEdit=remove&maBaiBao=${bao.getMaBaiBao()}"
							class="btn"><fmt:message>xoa</fmt:message></a>
					</div>
				</div>


			</c:forEach>
		</div>
	</div>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>