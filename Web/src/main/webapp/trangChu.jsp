<%@page import="model.NewsService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITNews</title>
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
<fmt:setLocale value="vi_VN" />
<c:if test="${param.lang == 'en'}">
	<fmt:setLocale value="en_US" />
</c:if>

<fmt:setBundle basename="lang" /><fmt:setLocale value="vi_VN" />
<c:if test="${param.lang == 'en'}">
	<fmt:setLocale value="en_US" />
</c:if>

<fmt:setBundle basename="lang" />
	<jsp:include page="header.jsp"></jsp:include>
	<c:set value="${baos}" var="news"></c:set>
<!-- 	EncodeRUL -->
	<c:url var="NewsServlet" value="NewsServlet"></c:url>
	<c:url var="UserServlet" value="UserServlet"></c:url>
	<div class="container">
		<div class="row">

			<!-- Menu left -->
			<div class="col-lg-2">
				<div class="list-group border w-800">

					<span style="font-size: 20px; font-weight: bold; color: #9F224E"><fmt:message>xu_huong</fmt:message></span>
					<c:forEach items="${xuHuong }" var="baoXH">
						<a
							href="${pageContext.request.contextPath}/${NewsServlet}?type=read&maBaiBao=${baoXH.getMaBaiBao() }"
							class="list-group-item"> <span class="main-color"
							style="font-size: 18px; line-height: 20px">${baoXH.getTieuDe() }</span>
						</a>
					</c:forEach>
				</div>

			</div>
			<!-- 				End menu left -->
			<!--product-->

			<div class="col-lg-7 w-90">
				<div class="row">
					<!-- 				ô lớn ở giữa -->
					<div class="col-lg-12 col-md-6 mb-4">
						<div class="card h-200" style="width: 100%;">

							<a
								href="${pageContext.request.contextPath}/${NewsServlet}?type=read&maBaiBao=${news[0].getMaBaiBao() }"><div
									class="row no-gutters">
									<div class="col-md-8">
										<img src="${news[0].getFilePath()}" class="card-img"
											alt="Hình ảnh">
									</div>
									<div class="col-md-4">
										<div class="card-body">
											<h5 class="card-title">${news[0].getTieuDe()}</h5>
											<p class="card-text">${news[0].getMoTa()}</p>
										</div>
									</div>
								</div></a>
						</div>
					</div>
					<!-- 						end ô lớn ở giữa -->
					<!-- 						3 ô nhỏ ở dưới -->
					<div class="row  mt-15">
						<div class="card h-200 " style="width: 31%;">
							<a
								href="${pageContext.request.contextPath}/${NewsServlet}?type=read&maBaiBao=${news[1].getMaBaiBao() }"><div
									class="row no-gutters">
									<div class="col-md-12">
										<img src="${news.get(1).getFilePath()}" class=" card-img-3"
											alt="Hình ảnh">
									</div>
									<div class="row">
										<div class="card-body">
											<h5 class="card-title">${news.get(1).getTieuDe()}</h5>
											<p class="card-text">${news.get(1).getMoTa()}</p>
										</div>
									</div>
								</div></a>
						</div>
						<div class="card h-200 ml-3"
							style="width: 31%; margin-left: 3.5%; margin-right: 3.5%">
							<a
								href="${pageContext.request.contextPath}/${NewsServlet}?type=read&maBaiBao=${news[2].getMaBaiBao() }"><div
									class="row no-gutters">
									<div class="col-md-12">
										<img src="${news.get(2).getFilePath()}" class="card-img-3"
											alt="Hình ảnh">
									</div>
									<div class="row">
										<div class="card-body">
											<h5 class="card-title">${news.get(2).getTieuDe()}</h5>
											<p class="card-text">${news.get(2).getMoTa()}</p>
										</div>
									</div>

								</div></a>
						</div>
						<div class="card h-200 " style="width: 31%;">
							<a
								href="${pageContext.request.contextPath}/${NewsServlet}?type=read&maBaiBao=${news[3].getMaBaiBao() }"><div
									class="row no-gutters">
									<div class="col-md-12">
										<img src="${news.get(3).getFilePath()}" class="card-img-3"
											alt="Hình ảnh">
									</div>
									<div class="row">
										<div class="card-body">
											<h5 class="card-title">${news.get(3).getTieuDe()}</h5>
											<p class="card-text">${news.get(3).getMoTa()}</p>
										</div>
									</div>

								</div> </a>
						</div>
						<div class="row space">
							<c:forEach var="bao" items="${baos}" begin="4">
								<div class=" border col-lg-4 mt-30">
									<a
										href="${pageContext.request.contextPath}/${NewsServlet}?type=read&maBaiBao=${bao.getMaBaiBao() }">
										<div class="col-md-12">
											<img src="${bao.getFilePath()}" class="card-img-3"
												alt="Hình ảnh">
										</div>
										<div class="col-md-12">
											<div class="card-body">
												<h5 class="card-title">${bao.getTieuDe()}</h5>
												<p class="card-text">${bao.getMoTa()}</p>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
						</div>

					</div>
					<!-- end 3 ô nhỏ -->




				</div>

				<!--end product-->

			</div>
			<!-- 			top view right -->
			<div class="col-lg-3">
				<div class="list-group border w-800">
					<span
						style="font-size: 20px; font-weight: bold; line-height: 22px; color: #9F224E"><fmt:message>top_view</fmt:message></span>
					<c:forEach items="${topView }" var="baoTV">
						<a
							href="${pageContext.request.contextPath}/${NewsServlet}?type=read&maBaiBao=${baoTV.getMaBaiBao() }"
							class="list-group-item"> <span class="main-color"
							style="font-size: 18px; line-height: 20px">${baoTV.getTieuDe() }</span>
						</a>
					</c:forEach>
				</div>
				<!-- end top view right -->
			</div>

			<div class="container mt-4 w-80"></div>

			<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>