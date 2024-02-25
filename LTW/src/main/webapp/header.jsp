<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	integrity="sha512-Avb2QiuDEEvB4bZJYdft2mNjVShBftLdPG8FJ0V7irTLQ8Uo0qcPxh4Plq7G5tGm0rU+1SPhVotteLpBERwTkw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
</head>
<style type="text/css">
.rounded-circle {
	border-radius: 50%;
}

.user {
	display: flex;
	cursor: pointer;
}

.user i {
	display: block;
	margin-top: auto;
	margin-bottom: auto;
	margin-left: 5px;
}

.label2 {
	font-size: 15px;
	font-weight: 600;
	position: relative;
	height: max-content;
	margin-top: auto;
	margin-bottom: auto;
	z-index: 4;
}

.label2 label {
	text-wrap: nowrap;
}

.div2 {
	display: none;
	position: absolute;
	margin-top: 5px; /* Điều chỉnh khoảng cách giữa .label2 và .div2 */
	width: max-content;
	top: 100%;
	 	right: -235%; 
	border: 1px solid;
	border-color: #bebaba;
	border-radius: 5px;
	z-index: 2;
	background-color: white;
	padding-right: 20px;
}

.div2::before {
	content: "";
	position: absolute;
	width: 100%;
	height: 15%;
	top: -10%;
	height: 15%;
}

li {
	margin-top: 15px;
	list-style: none;
}

.nav {
	position: sticky;
	top: 0;
	z-index: 2;
	/* 	font-size: 200%; */
}

.nav {
	padding: 5px 15px;
	border-radius: 5px;
	font-size: 20px;
	font-weight: 600;
	background-color: #932048e8;
	border: 1px solid;
	display: flex;
	justify-content: space-between;
	width: 90%;
	margin: auto;
	display: flex;
}

@media ( max-width : 1060px) {
	.nav {
		display: none; /* Ẩn khi màn hình có chiều rộng tối đa là 1060px */
	}
}

.nav a {
	text-decoration: none;
	color: white;
}

.nav-item {
	padding: 5px;
	width: max-content;
	position: relative;
}

.nav-item:hover .nav-itemlist {
	display: block;
}

.nav-itemlist {
	position: absolute;
	display: none;
	width: max-content;
	border: 1px solid;
	border-color: gray;
	background-color: #932048e8;
	border-radius: 5px;
	margin-top: 10px;
	z-index: 1;
}

.nav-itemlist a {
	text-decoration: none;
	color: white;
}

li {
	list-style: none;
	margin-bottom: 10px;
}

ul {
	padding-left: 15px;
	padding-right: 30px;
}

.search {
	display: flex;
	margin: auto;
	margin-right: 5%;
	font-size: 30px;
}

.search input {
	display: block;
	width: 300px;
	height: 30px;
	/* 	margin: auto; */
	margin-right: 10px;
	border-radius: 7px;
}

.search form {
	display: flex;
}

.search i {
	margin-right: 0
}
.w-800{

}
.w-1086{
}
@media ( max-width : 800px) {
	.w-800{
	display: none;
	}
}
@media ( max-width : 1086px) {
	.w-1086{
	display: none;
	}
}
</style>
</head>
<body>
	<c:url var="NewsServlet" value="NewsServlet"></c:url>
	<c:url var="UserServlet" value="UserServlet"></c:url>
	<c:url var="MainServlet" value="MainServlet"></c:url>
	<fmt:setLocale value="vi_VN" />
	<c:if test="${param.lang == 'en'}">
		<fmt:setLocale value="en_US" />
	</c:if>
	<fmt:setBundle basename="lang.lang" />

	<div
		style="display: flex; margin: 0 10% 0 5%; justify-content: space-between;">
		<div>
			<a href="${pageContext.request.contextPath}/${MainServlet}"
				style="display: block; height: max_content;"><img alt="logo"
				src="
				${path}/img/logo3.png" type="image/x-icon"
				style="max-height: 100px; max-width: 100%;"> </a>
		</div>
		<div class="search w-800">
			<a
				href="${pageContext.request.contextPath}/${MainServlet}?lang=change"
				style="padding: 12px; font-size: 20px; border-radius: 7px; color: white; font-weight: 600; background: #932048e8; text-decoration: none; text-align: center; margin-right: 20px;"><fmt:message>lang</fmt:message></a>
		</div>
		<div class="search w-1086">
		<fmt:message key="search" var="search" />
			<form action="${pageContext.request.contextPath}/${NewsServlet}"
				id="searchForm">
				<input type="hidden" name="typeSearch" value="seachByTen"> <input
					type="hidden" name="type" value="search" > <input
					type="text" name="txtSearch" placeholder="${search }"> <i
					class="fa-solid fa-magnifying-glass" id="search" onclick="search()" ></i>
			</form>
		</div>
		<div
			style="margin-top: auto; margin-bottom: auto; display:  ${!nguoiDung.isLogin() ? "flex" : "none"}; width:max-content; justify-content:space-between;">

			<a
				href="${pageContext.request.contextPath}/${UserServlet}?type=dangNhap"
				style="padding: 12px; font-size: 20px; border-radius: 7px; color: white; font-weight: 600; background: #363628ed; text-decoration: none; text-align: center; margin-right: 20px;"><fmt:message>dang_nhap</fmt:message></a>
			<a href="${pageContext.request.contextPath}/${UserServlet}?type=dangKy"
				style="padding: 12px; font-size: 20px; border-radius: 7px; color: white; font-weight: 600; background: #363628ed; text-decoration: none; text-align: center;"><fmt:message>dang_ky</fmt:message></a>
		</div>
		<div class="user label2" onclick="toggleDropdown('div2')"
			style="display:  ${!nguoiDung.isLogin() ? "none" : "flex"}">
			<img src="${nguoiDung.getAvt() }" alt="mdo" width="32" height="32"
				class="rounded-circle"> <i class="fa-solid fa-angle-down"></i>

			<div class="div2" id="div2">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=dangBao"
						style="text-decoration: none; color: black;"><fmt:message>dang_bai</fmt:message></a></li>
					<c:if test="${nguoiDung.isAdmin() }">
						<li><a
							href="${pageContext.request.contextPath}/${UserServlet}?type=dangKyDangBai&typeDK=danhSach"
							style="text-decoration: none; color: black;"><fmt:message>danh_sach_dang_ky</fmt:message></a></li>
					</c:if>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?typeShow=danhSachBaiBao&type=showList"
						style="text-decoration: none; color: black;"><fmt:message>danh_sach_bai_bao</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?typeShow=trangCaNhan&type=showList"
						style="text-decoration: none; color: black;"><fmt:message>thong_tin_tai_khoan</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}${newsService.rewriteURL("/thayDoiThongTin.jsp")}"
						style="text-decoration: none; color: black;"><fmt:message>thay_doi_thong_tin</fmt:message></a></li>
					<li style="height: 1px; margin: 0; list-style: none;"><hr
							class=""></li>
					<li><a
						href="${pageContext.request.contextPath}/${UserServlet}?type=logout"
						style="text-decoration: none; color: black; margin-top: 10px"><fmt:message>dang_xuat</fmt:message></a></li>
				</ul>
				</ul>
			</div>
		</div>
	</div>
	</div>
	<!-- Navbar -->
	<div class="nav">
		<div class="nav-item">
			<a href="${pageContext.request.contextPath}/${MainServlet}"
				style="padding: 15px;"><i class="fa-solid fa-house"></i></a>
		</div>
		<div class="nav-item">
			<a
				href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thoisu"><fmt:message>thoi_su</fmt:message></a>
			<div class="nav-itemlist">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thoisu&theLoaiPhu=chinhtri"><fmt:message>chinh_tri</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thoisu&theLoaiPhu=laodong"><fmt:message>lao_dong</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thoisu&theLoaiPhu=dansinh"><fmt:message>dan_sinh</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thoisu&theLoaiPhu=giaothong"><fmt:message>giao_thong</fmt:message></a></li>
				</ul>
			</div>
		</div>
		<div class="nav-item">
			<a
				href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thegioi"><fmt:message>the_gioi</fmt:message></a>
			<div class="nav-itemlist">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thegioi&theLoaiPhu=tulieu"><fmt:message>tu_lieu</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thegioi&theLoaiPhu=cuocsong"><fmt:message>cuoc_song</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thegioi&theLoaiPhu=quansu"><fmt:message>quan_su</fmt:message></a></li>
				</ul>
			</div>
		</div>
		<div class="nav-item">
			<a
				href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=kinhdoanh"><fmt:message>kinh_doanh</fmt:message></a>
			<div class="nav-itemlist">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=kinhdoanh&theLoaiPhu=quocte"><fmt:message>quoc_te</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=kinhdoanh&theLoaiPhu=doanhnghiep"><fmt:message>doanh_nghiep</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=kinhdoanh&theLoaiPhu=chungkhoan"><fmt:message>chung_khoan</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=kinhdoanh&theLoaiPhu=baohiem"><fmt:message>bao_hiem</fmt:message></a></li>
				</ul>
			</div>
		</div>
		<div class="nav-item">
			<a
				href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=batdongsan"><fmt:message>bat_dong_san</fmt:message></a>
			<div class="nav-itemlist">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=batdongsan&theLoaiPhu=chinhsach"><fmt:message>chinh_sach</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=batdongsan&theLoaiPhu=thitruong"><fmt:message>thi_truong</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=batdongsan&theLoaiPhu=duan"><fmt:message>du_an</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=batdongsan&theLoaiPhu=tuvan"><fmt:message>tu_van</fmt:message></a></li>
				</ul>
			</div>
		</div>
		<div class="nav-item">
			<a
				href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thethao"><fmt:message>the_thao</fmt:message></a>
			<div class="nav-itemlist">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thethao&theLoaiPhu=bongda"><fmt:message>bong_da</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thethao&theLoaiPhu=lichthidau"><fmt:message>lich_thi_dau</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thethao&theLoaiPhu=tennis">Tennis</a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=thethao&theLoaiPhu=marathon">Marathon</a></li>
				</ul>
			</div>
		</div>
		<div class="nav-item">
			<a
				href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=giaoduc"><fmt:message>giao_duc</fmt:message></a>
			<div class="nav-itemlist">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=giaoduc&theLoaiPhu=tintuc"><fmt:message>tin_tuc</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=giaoduc&theLoaiPhu=tuyensinh"><fmt:message>tuyen_sinh</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=giaoduc&theLoaiPhu=tuyensinh"><fmt:message>du_hoc</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=giaoduc&theLoaiPhu=hoctienganh"><fmt:message>hoc_tieng_anh</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=giaoduc&theLoaiPhu=giaoduc40"><fmt:message>giao_duc_4.0</fmt:message></a></li>
				</ul>
			</div>
		</div>
		<div class="nav-item">
			<a
				href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=doisong"><fmt:message>doi_song</fmt:message></a>
			<div class="nav-itemlist">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=doisong&theLoaiPhu=nhipsong"><fmt:message>nhip_song</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=doisong&theLoaiPhu=toam"><fmt:message>to_am</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=doisong&theLoaiPhu=cooking">Cooking</a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=doisong&theLoaiPhu=tieudung"><fmt:message>tieu_dung</fmt:message></a></li>
				</ul>
			</div>
		</div>
		<div class="nav-item">
			<a
				href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=dulich"><fmt:message>du_lich</fmt:message></a>
			<div class="nav-itemlist">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=dulich&theLoaiPhu=diemden"><fmt:message>diem_den</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=dulich&theLoaiPhu=amthuc"><fmt:message>am_thuc</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=dulich&theLoaiPhu=camnang"><fmt:message>cam_nang</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=dulich&theLoaiPhu=tuvan"><fmt:message>tu_van</fmt:message></a></li>
				</ul>
			</div>
		</div>
		<div class="nav-item">
			<a
				href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=xe"><fmt:message>xe</fmt:message></a>
			<div class="nav-itemlist">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=xe&theLoaiPhu=thitruong"><fmt:message>thi_truong</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=xe&theLoaiPhu=diendan"><fmt:message>dien_dan</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=xe&theLoaiPhu=thibanglai"><fmt:message>thi_bang_lai</fmt:message></a></li>
					<li><a
						href="${pageContext.request.contextPath}/${NewsServlet}?type=search&typeSearch=searchByTheLoai&theLoaiChinh=xe&theLoaiPhu=muaban"><fmt:message>mua_ban</fmt:message></a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- end navbar -->
	<script type="text/javascript">
		function search() {
			var form = document.getElementById('searchForm');
			form.submit();
		}
		function toggleDropdown(divId) {
			var dropdown = document.getElementById(divId);
			if (dropdown.style.display === "none"
					|| dropdown.style.display === "") {
				dropdown.style.display = "block";
			} else {
				dropdown.style.display = "none";
			}
		}

		// Ẩn dropdown khi nhấp vào bất kỳ nơi nào trên trang
		document.addEventListener("click", function(event) {
			var dropdowns = document.querySelectorAll('.div2');
			dropdowns.forEach(function(dropdown) {
				if (event.target !== dropdown.previousElementSibling
						&& !dropdown.contains(event.target)) {
					dropdown.style.display = "none";
				}
			});
		});
	</script>
</body>
</html>