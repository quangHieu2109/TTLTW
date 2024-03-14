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
<title><fmt:message>thay_doi_thong_tin</fmt:message></title>
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
<%-- 	<jsp:useBean id="nguoiDung" type="model.NguoiDung" scope="session"></jsp:useBean> --%>
	<form action="${pageContext.request.contextPath}/${UserServlet}"
		method="post" id="myform">
		<input type="hidden" name="type" value="editIn4">
		<jsp:useBean id="thongBao" class="java.lang.String" scope="request"></jsp:useBean>
		<div class="thongBao">
			<c:if test="${thongBao.length() >0 }">
				<label>${thongBao }</label>
			</c:if>
		</div>
		<h1>
			<fmt:message>thay_doi_thong_tin_tai_khoan</fmt:message>
		</h1>
		<div class="body">
			<div class="content">
				<table>
					<tr>
						<th><fmt:message>ten_dang_nhap</fmt:message></th>
						<td><input type="text" name="tenDangNhap" id="tenDangNhap"
							value="${nguoiDung.getTenDangNhap()}" disabled="disabled"></td>
					</tr>
					<tr>
						<th><fmt:message>mat_khau</fmt:message></th>
						<td><input type="password" name="matKhau" id="matKhau"
							required="required" value="${nguoiDung.getMatKhau()}"></td>
					</tr>
					<tr>
						<th><fmt:message>nhap_lai_mat_khau</fmt:message></th>
						<td><input type="password" name="nhapLaiMatKhau"
							id="nhapLaiMatKhau" value="${nguoiDung.getMatKhau()}"></td>
					</tr>
				</table>
			</div>
			<div class="content">
				<table>
					<tr>
						<th><fmt:message>ho_ten</fmt:message></th>
						<td><input type="text" name="hoTen" id="hoTen"
							value="${nguoiDung.getHoVaTen()}"></td>
					</tr>
					<tr>
						<th>Email</th>
						<td><input type="email" name="email" id="email"
							required="required" value="${nguoiDung.getEmail()}"></td>
					</tr>
					<tr>
						<th><fmt:message>ngay_sinh</fmt:message></th>
						<td><input type="date" name="ngaySinh" id="ngaySinh"
							required="required"></td>
					</tr>
				</table>
			</div>

		</div>
		<div class="button">
			<button type="button" class="btn margin-a" onclick="submitForm()">
				<fmt:message>luu_thay_doi</fmt:message>
			</button>
		</div>
	</form>
	<jsp:include page="footer.jsp"></jsp:include>
	<script type="text/javascript">
		var ngaySinhInput = document.getElementById('ngaySinh');
		var ngaySinhValue = "${nguoiDung.getNgaySinh()}";
		ngaySinhInput.value = ngaySinhValue;
		function submitForm() {
			var email = document.getElementById('email').value;
			var gmailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,}$/;
			var myform = document.getElementById('myform');
			var date = new Date(document.getElementById('ngaySinh').value);
			var ngaySinh = document.getElementById('ngaySinh').value;
			var matKhau = document.getElementById('matKhau').value;
			var tenDangNhap = document.getElementById('matKhau').value;
			var hoTen = document.getElementById('matKhau').value;
			var nhapLaiMatKhau = document.getElementById('nhapLaiMatKhau').value;

			if (tenDangNhap === "" || matKhau === "" || nhapLaiMatKhau === ""
					|| hoTen === "" || email === "" || ngaySinh === "") {
				alert('Vui lòng nhập đầy đủ thông tin');
			} else {
				if (matKhau !== nhapLaiMatKhau) {
					alert('Mật khẩu nhập lại không chính xác');
				} else if (!gmailRegex.test(email)) {
					alert('Email không hợp lệ');

				} else if (date > new Date()) {
					alert('Ngày sinh không hợp lệ');

				} else {
					myform.submit();

				}
			}
		}
	</script>
</body>
</html>