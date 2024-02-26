<%@page import="model.DSTheLoai"%>
<%@page import="model.BaiBao"%>
<%@page import="model.TheLoai"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<fmt:setLocale value="vi_VN" />
<c:if test="${param.lang == 'en'}">
	<fmt:setLocale value="en_US" />
</c:if>
<fmt:setBundle basename="lang.lang" />
<title><fmt:message>dang_bai</fmt:message></title>
<link rel="icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/logo_icon3.png"
	type="image/x-icon">
<style type="text/css">
</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/dangBai.css">
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<c:url var="NewsServlet" value="NewsServlet"></c:url>
	<c:url var="UserServlet" value="UserServlet"></c:url>
	<c:set value="${baoDB.getTheLoai()}" var="theLoai"></c:set>
	<div>
		<form method="POST"
			action="${pageContext.request.contextPath}/${NewsServlet}"
			enctype="multipart/form-data" id="myform">
			<input type="hidden" name="type" value="1234" id="type">
			<div class="div TieuDe">
				<label><fmt:message>tieu_de</fmt:message></label>
				<textarea rows="1" cols="" wrap="soft" class="tieude" name="tieuDe"
					value="">${baoDB.getTieuDe()}</textarea>

			</div>
			<div class="div TheLoai">
				<label><fmt:message>the_loai</fmt:message></label>
				<div class="theloaiitem">
					<div class="uls">
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="thoisu"
								${theLoai.checkTLChinh("thoisu") }>
							<fmt:message>thoi_su</fmt:message>
							<div class="li">
								<li><input type="checkbox" name="thoisu" value="chinhtri"
									${theLoai.checkTLPhu("chinhtri") }>
								<fmt:message>chinh_tri</fmt:message></li>
								<li><input type="checkbox" name="thoisu" value="laodong"
									${theLoai.checkTLPhu("laodong") }>
								<fmt:message>lao_dong</fmt:message></li>
								<li><input type="checkbox" name="thoisu" value="giaoduc"
									${theLoai.checkTLPhu("giaoduc") }>
								<fmt:message>giao_duc</fmt:message></li>
								<li><input type="checkbox" name="thoisu" value="giaothong"
									${theLoai.checkTLPhu("giaothong") }>
								<fmt:message>giao_thong</fmt:message></li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="thegioi"
								${theLoai.checkTLChinh("thegioi") }>
							<fmt:message>the_gioi</fmt:message>
							<div class="li">
								<li><input type="checkbox" name="thegioi" value="tulieu"
									${theLoai.checkTLPhu("tulieu") }>
								<fmt:message>tu_lieu</fmt:message></li>
								<li><input type="checkbox" name="thegioi" value="cuocsong"
									${theLoai.checkTLPhu("cuocsong") }>
								<fmt:message>cuoc_song</fmt:message></li>
								<li><input type="checkbox" name="thegioi" value="quansu"
									${theLoai.checkTLPhu("quansu") }>
								<fmt:message>quan_su</fmt:message></li>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="kinhdoanh"
								${theLoai.checkTLChinh("kinhdoanh") }>
							<fmt:message>kinh_doanh</fmt:message>
							<div class="li">
								<li><input type="checkbox" name="kinhdoanh" value="quocte"
									${theLoai.checkTLPhu("quocte") }>
								<fmt:message>quoc_te</fmt:message></li>
								<li><input type="checkbox" name="kinhdoanh"
									value="doanhnghiep" ${theLoai.checkTLPhu("doanhnghiep") }>
								<fmt:message>doanh_nghiep</fmt:message></li>
								<li><input type="checkbox" name="kinhdoanh"
									value="chungkhoang" ${theLoai.checkTLPhu("chungkhoang") }>
								<fmt:message>chung_khoan</fmt:message></li>
								<li><input type="checkbox" name="kinhdoanh" value="baohiem"
									${theLoai.checkTLPhu("baohiem") }>
								<fmt:message>bao_hiem</fmt:message></li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="batdongsan"
								${theLoai.checkTLChinh("batdongsan") }>
							<fmt:message>bat_dong_san</fmt:message>
							<div class="li">
								<li><input type="checkbox" name="batdongsan"
									value="chinhsach" ${theLoai.checkTLPhu("chinhsach") }>
								<fmt:message>chinh_sach</fmt:message></li>
								<li><input type="checkbox" name="batdongsan"
									value="thitruong" ${theLoai.checkTLPhu("thitruong") }>
								<fmt:message>thi_truong</fmt:message></li>
								<li><input type="checkbox" name="batdongsan" value="duan"
									${theLoai.checkTLPhu("duan") }>
								<fmt:message>du_an</fmt:message></li>
								<li><input type="checkbox" name="batdongsan" value="tuvan"
									${theLoai.checkTLPhu("tuvan") }>
								<fmt:message>tu_van</fmt:message></li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="thethao"
								${theLoai.checkTLChinh("thethao") }>
							<fmt:message>the_thao</fmt:message>
							<div class="li">
								<li><input type="checkbox" name="thethao" value="bongda"
									${theLoai.checkTLPhu("bongda") }>
								<fmt:message>bong_da</fmt:message></li>
								<li><input type="checkbox" name="thethao"
									value="lichthidau" ${theLoai.checkTLPhu("thethao") }>
								<fmt:message>lich_thi_dau</fmt:message></li>
								<li><input type="checkbox" name="thethao" value="tennis"
									${theLoai.checkTLPhu("tennis") }>Tennis</li>
								<li><input type="checkbox" name="thethao" value="marathon"
									${theLoai.checkTLPhu("marathon") }>Marathon</li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="giaoduc"
								${theLoai.checkTLChinh("giaoduc") }>
							<fmt:message>giao_duc</fmt:message>
							<div class="li">
								<li><input type="checkbox" name="giaoduc" value="tintuc"
									${theLoai.checkTLPhu("tintuc") }>
								<fmt:message>tin_tuc</fmt:message></li>
								<li><input type="checkbox" name="giaoduc" value="tuyensinh"
									${theLoai.checkTLPhu("tuyensinh") }>
								<fmt:message>tuyen_sinh</fmt:message></li>
								<li><input type="checkbox" name="giaoduc" value="duhoc"
									${theLoai.checkTLPhu("duhoc") }>
								<fmt:message>du_hoc</fmt:message></li>
								<li><input type="checkbox" name="giaoduc"
									value="hoctienganh" ${theLoai.checkTLPhu("hoctienganh") }>
								<fmt:message>hoc_tieng_anh</fmt:message></li>
								<li><input type="checkbox" name="giaoduc" value="giaoduc40"
									${theLoai.checkTLPhu("giaoduc40") }>
								<fmt:message>giao_duc_4.0</fmt:message></li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="doisong"
								${theLoai.checkTLChinh("doisong") }>
							<fmt:message>doi_song</fmt:message>
							<div class="li">
								<li><input type="checkbox" name="doisong" value="nhipsong"
									${theLoai.checkTLPhu("") }>
								<fmt:message>nhip_song</fmt:message></li>
								<li><input type="checkbox" name="doisong" value="toam"
									${theLoai.checkTLPhu("toam") }>
								<fmt:message>to_am</fmt:message></li>
								<li><input type="checkbox" name="doisong" value="cooking"
									${theLoai.checkTLPhu("cooking") }>Cooking</li>
								<li><input type="checkbox" name="doisong" value="tieudung"
									${theLoai.checkTLPhu("tieudung") }>
								<fmt:message>tieu_dung</fmt:message></li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="dulich"
								${theLoai.checkTLChinh("dulich") }>
							<fmt:message>du_lich</fmt:message>
							<div class="li">
								<li><input type="checkbox" name="dulich" value="diemden"
									${theLoai.checkTLPhu("diemden") }>
								<fmt:message>diem_den</fmt:message></li>
								<li><input type="checkbox" name="dulich" value="amthuc"
									${theLoai.checkTLPhu("amthuc") }>
								<fmt:message>am_thuc</fmt:message></li>
								<li><input type="checkbox" name="dulich" value="camnang"
									${theLoai.checkTLPhu("camnang") }>
								<fmt:message>cam_nang</fmt:message></li>
								<li><input type="checkbox" name="dulich" value="tuvan"
									${theLoai.checkTLPhu("tuvan") }>
								<fmt:message>tu_van</fmt:message></li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="xe"
								${theLoai.checkTLChinh("xe") }>
							<fmt:message>xe</fmt:message>
							<div class="li">
								<li><input type="checkbox" name="xe" value="thitruong"
									${theLoai.checkTLPhu("thitruong") }>
								<fmt:message>thi_truong</fmt:message></li>
								<li><input type="checkbox" name="xe" value="diendan"
									${theLoai.checkTLPhu("diendan") }>
								<fmt:message>dien_dan</fmt:message></li>
								<li><input type="checkbox" name="xe" value="thibanglai"
									${theLoai.checkTLPhu("thibanglai") }>
								<fmt:message>thi_bang_lai</fmt:message></li>
								<li><input type="checkbox" name="xe" value="muaban"
									${theLoai.checkTLPhu("muaban") }>
								<fmt:message>mua_ban</fmt:message></li>
							</div>
						</ul>
					</div>
				</div>
			</div>
			<div class="div MoTa">
				<label><fmt:message>mo_ta</fmt:message></label>
				<textarea rows="5" cols="" wrap="soft" name="moTa">${baoDB.getMoTa()}</textarea>
			</div>
			<div class="div TaiAnh">
				<label><fmt:message>tai_anh_len</fmt:message></label>
				<div class="img">
					<input type="file" accept="image/*" value="" name="file" id="file"
						class="hidden-input"> <label class="button" for="file"><fmt:message>tai_anh_len</fmt:message></label>
					<img alt="" src="${baoDB.getFilePath()}">
				</div>
			</div>
			<div class="div NoiDung">
				<label><fmt:message>noi_dung</fmt:message></label>
				<textarea rows="20" cols="" wrap="soft" name="noiDung">${baoDB.getNoiDung()}</textarea>
			</div>
			<div class="divBtn">
				<button type="button" onclick="submitForm()" class="button">
					<fmt:message>dang_bai</fmt:message>
				</button>
			</div>
		</form>

	</div>
	<script type="text/javascript">
		document
				.getElementById('file')
				.addEventListener(
						'change',
						function() {
							var type = document.getElementById('type');
							var fileInput = document.getElementById('file');

							var file = fileInput.files[0];
							var maxSize = 1024000;
							if (file && file.size > maxSize) {
								alert('File ảnh có dung lượng quá lớn, vui lòng chọn file ảnh khác')
								fileInput.value = '';
								return;
							} else {
								type.value = "upAnh";
								document.getElementById('myform').submit();
							}
						});
		function submitFormUpAnh() {
			var form = document.getElementById('myform');
			var fileInput = document.getElementById('file');
			var type = document.getElementById('type');
			if (fileInput.files.length === 0) {
				alert("Bạn chưa chọn file ảnh!");
			} else {
				type.value = "upAnh";
				form.submit();
			}
		}
		function submitForm() {
			var form = document.getElementById('myform');
			var type = document.getElementById('type');
			type.value = "dangBai";
			form.submit();
		}
	</script>

	<jsp:include page="/footer.jsp" flush="false"></jsp:include>
</body>
</html>