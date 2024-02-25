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
<title><fmt:message>danh_sach_dang_ky</fmt:message></title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
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
			<fmt:message>thong_bao_DK</fmt:message>
		</h1>
		<div class="col-lg-10 ma">
			<c:set var="danhSachDK" value="${newsService.getDangKyDangBai() }"></c:set>
			<c:forEach items="${danhSachDK}" var="ds">
				<div class="row border">
					<div class="col-lg-2 avt-cmt mtb-10">
						<img alt="" src="${ds.getNguoiDung().getAvt() }">
					</div>
					<div class="col-lg-7 mtb-10">
						<div class="head-cmt">
							<label class="title-cmt">${ds.getNguoiDung().getHoVaTen() }</label>
							<label class="date-cmt">${ds.getNgayDK() }</label>
						</div>
						<div class="div-in4">
							<label><fmt:message>ngay_sinh</fmt:message>:
								${ds.getNguoiDung().getNgaySinh() }</label> <label>Email:
								${ds.getNguoiDung().getEmail() }</label>
						</div>

					</div>
					<div class="col-lg-3 button">
						<a
							href="${pageContext.request.contextPath}/${UserServlet}?type=dangKyDangBai&typeDK=chapNhan&maDK=${ds.getMaDK() }"
							class="btn"><fmt:message>chap_nhan</fmt:message></a> <a
							href="${pageContext.request.contextPath}/${UserServlet}?type=dangKyDangBai&typeDK=xoa&maDK=${ds.getMaDK() }"
							class="btn"><fmt:message>xoa</fmt:message></a>
					</div>
				</div>




			</c:forEach>
		</div>
	</div>
	</div>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>