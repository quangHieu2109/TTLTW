<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<fmt:setLocale value="vi_VN" />
<c:if test="${param.lang == 'en'}">
	<fmt:setLocale value="en_US" />
</c:if>

<fmt:setBundle basename="lang" />
<title><fmt:message>dang_ky</fmt:message></title>
<link rel="icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/dangKy.css">

</head>
<body>
	<c:url var="NewsServlet" value="NewsServlet"></c:url>
	<c:url var="UserServlet" value="UserServlet"></c:url>
	<jsp:include page="header.jsp"></jsp:include>
<%-- 	<jsp:useBean id="nguoidung" class="model.NguoiDung" scope="request"></jsp:useBean> --%>
	<form action="${pageContext.request.contextPath}/${UserServlet}"
		method="post" id="myform">
		<input type="hidden" name="type" value="register">
		<jsp:useBean id="error" class="java.lang.String" scope="request"></jsp:useBean>
		<div class="error">
			<c:if test="${error.length() >0 }">
				<label><fmt:message>${error}</fmt:message></label>
			</c:if>
		</div>
		<h1>
			<fmt:message>dang_ky_tai_khoan</fmt:message>
		</h1>
		<div class="body">
			<div class="content">
				<table>
					<tr>
						<th><fmt:message>ten_dang_nhap</fmt:message>(<span
							class="thongBao">*</span>)</th>
						<td><input type="text" name="tenDangNhap" id="tenDangNhap" value="${nguoidung.getTenDangNhap() }"></td>
					</tr>
					<tr>
						<th><fmt:message>mat_khau</fmt:message>(<span
							class="thongBao">*</span>)</th>
						<td><input type="password" name="matKhau" id="matKhau"
							required="required" value="${nguoidung.getMatKhau() }"></td>
					</tr>
					<tr>
						<th><fmt:message>nhap_lai_mat_khau</fmt:message>(<span
							class="thongBao">*</span>)</th>
						<td><input type="password" name="nhapLaiMatKhau"
							id="nhapLaiMatKhau" value="${nguoidung.getMatKhau() }"></td>
					</tr>
				</table>
			</div>
			<div class="content">
				<table>
					<tr>
						<th><fmt:message>ho_ten</fmt:message>(<span class="thongBao">*</span>)</th>
						<td><input type="text" name="hoTen" id="hoTen" value="${nguoidung.getHoVaTen() }"></td>
					</tr>
					<tr>
						<th>Email(<span class="thongBao">*</span>)
						</th>
						<td><input type="email" name="email" id="email"
							required="required" value="${nguoidung.getEmail() }"></td>
					</tr>
					<tr>
						<th><fmt:message>ngay_sinh</fmt:message>(<span
							class="thongBao">*</span>)</th>
						<td><input type="date" name="ngaySinh" id="ngaySinh"
							required="required" value="${nguoidung.getNgaySinh() }"></td>
					</tr>
				</table>
			</div>

		</div>
		<div class="button">
			<a
				href="${pageContext.request.contextPath}/${UserServlet}?type=dangNhap"
				class="btn"><fmt:message>dang_nhap</fmt:message></a>
			<button type="button" class="btn" onclick="submitForm()">
			<fmt:message key="dang_ky"/>
			</button>
		</div>
	</form>
	<fmt:message key="error_thieu_thong_tin" var="error_thieu_thong_tin" />
	<fmt:message key="error_ngay_sinh" var="error_ngay_sinh" />
	<fmt:message key="error_email" var="error_email" />
	<fmt:message key="error_sai_mat_khau" var="error_sai_mat_khau" />
	<fmt:message key="error_ten_dang_nhap" var="error_ten_dang_nhap" />
	<jsp:include page="footer.jsp"></jsp:include>
	<script type="text/javascript">
		function submitForm() {
			var email = document.getElementById('email').value;
			var gmailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,}$/;
			var myform = document.getElementById('myform');
			var date = new Date(document.getElementById('ngaySinh').value);
			var ngaySinh = document.getElementById('ngaySinh').value;
			var matKhau = document.getElementById('matKhau').value;
			var tenDangNhap = document.getElementById('tenDangNhap').value;
			var hoTen = document.getElementById('hoTen').value;
			var nhapLaiMatKhau = document.getElementById('nhapLaiMatKhau').value;

			if (tenDangNhap === "" || matKhau === "" || nhapLaiMatKhau === ""
					|| hoTen === "" || email === "" || ngaySinh === "") {
				alert("<c:out value='${error_thieu_thong_tin}' />");
			} else {
				if(tenDangNhap.trim() ===""){
					alert("<c:out value='${error_ten_dang_nhap}' />");
				}else if (matKhau !== nhapLaiMatKhau) {
					alert("<c:out value='${error_sai_mat_khau}' />");
				} else if (!gmailRegex.test(email)) {
					alert("<c:out value='${error_email}' />");

				} else if (date > new Date()) {
					alert("<c:out value='${error_ngay_sinh}' />");

				} else {
					myform.submit();

				}
			}
		}
	</script>
</body>
</html>