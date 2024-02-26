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
<title><fmt:message>chinh_sua_bai_bao</fmt:message></title>
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
	<c:set var="baiBao"
		value="${newsService.getBaiBaoByMaBB(param.maBaiBao) }"></c:set>
	<c:set value="${baiBao.getTheLoai()}" var="theLoai"></c:set>
	<div>
		<form method="POST"
			action="${pageContext.request.contextPath}/${NewsServlet}"
			enctype="multipart/form-data" id="myform">
			<input type="hidden" name="type" value="edit"> <input
				type="hidden" name="typeEdit" value="1234" id="type"> <input
				type="hidden" name="maBaiBao" value="${baiBao.getMaBaiBao()}">
			<div class="div TieuDe">
				<label>Tiêu đề</label>
				<textarea rows="1" cols="" wrap="soft" class="tieude" name="tieuDe"
					value="">${baiBao.getTieuDe()}</textarea>

			</div>
			<div class="div TheLoai">
				<label>Thể loại</label>
				<div class="theloaiitem">
					<div class="uls">
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="thoisu"
								${theLoai.checkTLChinh("thoisu") }> Thời sự
							<div class="li">
								<li><input type="checkbox" name="thoisu" value="chinhtri"
									${theLoai.checkTLPhu("chinhtri") }>Chính trị</li>
								<li><input type="checkbox" name="thoisu" value="laodong"
									${theLoai.checkTLPhu("laodong") }>Lao động</li>
								<li><input type="checkbox" name="thoisu" value="giaoduc"
									${theLoai.checkTLPhu("giaoduc") }>Giáo dục</li>
								<li><input type="checkbox" name="thoisu" value="giaothong"
									${theLoai.checkTLPhu("giaothong") }>Giao Thông</li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="thegioi"
								${theLoai.checkTLChinh("thegioi") }> Thế giới
							<div class="li">
								<li><input type="checkbox" name="thegioi" value="tulieu"
									${theLoai.checkTLPhu("tulieu") }>Tư liệu</li>
								<li><input type="checkbox" name="thegioi" value="cuocsong"
									${theLoai.checkTLPhu("cuocsong") }>Cuộc sống</li>
								<li><input type="checkbox" name="thegioi" value="quansu"
									${theLoai.checkTLPhu("quansu") }>Quân sự</li>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="kinhdoanh"
								${theLoai.checkTLChinh("kinhdoanh") }> Kinh doanh
							<div class="li">
								<li><input type="checkbox" name="kinhdoanh" value="quocte"
									${theLoai.checkTLPhu("quocte") }>Quốc tế</li>
								<li><input type="checkbox" name="kinhdoanh"
									value="doanhnghiep" ${theLoai.checkTLPhu("doanhnghiep") }>Doanh
									nghiệp</li>
								<li><input type="checkbox" name="kinhdoanh"
									value="chungkhoang" ${theLoai.checkTLPhu("chungkhoang") }>Chứng
									khoáng</li>
								<li><input type="checkbox" name="kinhdoanh" value="baohiem"
									${theLoai.checkTLPhu("baohiem") }>Bảo hiểm</li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="batdongsan"
								${theLoai.checkTLChinh("batdongsan") }> Bất động sản
							<div class="li">
								<li><input type="checkbox" name="batdongsan"
									value="chinhsach" ${theLoai.checkTLPhu("chinhsach") }>Chính
									sách</li>
								<li><input type="checkbox" name="batdongsan"
									value="thitruong" ${theLoai.checkTLPhu("thitruong") }>Thị
									trường</li>
								<li><input type="checkbox" name="batdongsan" value="duan"
									${theLoai.checkTLPhu("duan") }>Dự án</li>
								<li><input type="checkbox" name="batdongsan" value="tuvan"
									${theLoai.checkTLPhu("tuvan") }>Tư vấn</li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="thethao"
								${theLoai.checkTLChinh("thethao") }>Thể thao
							<div class="li">
								<li><input type="checkbox" name="thethao" value="bongda"
									${theLoai.checkTLPhu("bongda") }>Bóng đá</li>
								<li><input type="checkbox" name="thethao"
									value="lichthidau" ${theLoai.checkTLPhu("thethao") }>Lịch
									thi đâu</li>
								<li><input type="checkbox" name="thethao" value="tennis"
									${theLoai.checkTLPhu("tennis") }>Tennis</li>
								<li><input type="checkbox" name="thethao" value="marathon"
									${theLoai.checkTLPhu("marathon") }>Marathon</li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="giaoduc"
								${theLoai.checkTLChinh("giaoduc") }> Giáo dục
							<div class="li">
								<li><input type="checkbox" name="giaoduc" value="tintuc"
									${theLoai.checkTLPhu("tintuc") }>Tin tức</li>
								<li><input type="checkbox" name="giaoduc" value="tuyensinh"
									${theLoai.checkTLPhu("tuyensinh") }>Tuyển sinh</li>
								<li><input type="checkbox" name="giaoduc" value="duhoc"
									${theLoai.checkTLPhu("duhoc") }>Du học</li>
								<li><input type="checkbox" name="giaoduc"
									value="hoctienganh" ${theLoai.checkTLPhu("hoctienganh") }>Học
									tiếng Anh</li>
								<li><input type="checkbox" name="giaoduc" value="giaoduc40"
									${theLoai.checkTLPhu("giaoduc40") }>Giáo dục 4.0</li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="doisong"
								${theLoai.checkTLChinh("doisong") }> Đời sống
							<div class="li">
								<li><input type="checkbox" name="doisong" value="nhipsong"
									${theLoai.checkTLPhu("") }>Nhịp sống</li>
								<li><input type="checkbox" name="doisong" value="toam"
									${theLoai.checkTLPhu("toam") }>Tổ ấm</li>
								<li><input type="checkbox" name="doisong" value="cooking"
									${theLoai.checkTLPhu("cooking") }>Cooking</li>
								<li><input type="checkbox" name="doisong" value="tieudung"
									${theLoai.checkTLPhu("tieudung") }>Tiêu dùng</li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="dulich"
								${theLoai.checkTLChinh("dulich") }>Du lịch
							<div class="li">
								<li><input type="checkbox" name="dulich" value="diemden"
									${theLoai.checkTLPhu("diemden") }>Điểm đến</li>
								<li><input type="checkbox" name="dulich" value="amthuc"
									${theLoai.checkTLPhu("amthuc") }>Ẩm thực</li>
								<li><input type="checkbox" name="dulich" value="camnang"
									${theLoai.checkTLPhu("camnang") }>Cẩm nang</li>
								<li><input type="checkbox" name="dulich" value="tuvan"
									${theLoai.checkTLPhu("tuvan") }>Tư vấn</li>
							</div>
						</ul>
						<ul class="ul">
							<input type="radio" name="theLoai" id="" value="xe"
								${theLoai.checkTLChinh("xe") }> Xe
							<div class="li">
								<li><input type="checkbox" name="xe" value="thitruong"
									${theLoai.checkTLPhu("thitruong") }>Thị trường</li>
								<li><input type="checkbox" name="xe" value="diendan"
									${theLoai.checkTLPhu("diendan") }>Diễn đàn</li>
								<li><input type="checkbox" name="xe" value="thibanglai"
									${theLoai.checkTLPhu("thibanglai") }>Thi bằng lái</li>
								<li><input type="checkbox" name="xe" value="muaban"
									${theLoai.checkTLPhu("muaban") }>Mua bán</li>
							</div>
						</ul>
					</div>
				</div>
			</div>
			<div class="div MoTa">
				<label>Mô tả</label>
				<textarea rows="5" cols="" wrap="soft" name="moTa">${baiBao.getMoTa()}</textarea>
			</div>
			<div class="div TaiAnh">
				<label>Tải ảnh lên</label>
				<div class="img">
					<input type="file" accept="image/*" value="" name="file" id="file">
					<img alt="" src="${baiBao.getFilePath()}">
				</div>
			</div>
			<div class="div NoiDung">
				<label>Nội dung</label>
				<textarea rows="20" cols="" wrap="soft" name="noiDung">${baiBao.getNoiDung()}</textarea>
			</div>
			<div class="divBtn">
				<button type="button" onclick="submitForm()" class="button">Cập
					nhật</button>
			</div>
		</form>

	</div>
	<script type="text/javascript">
		document.getElementById('file').addEventListener('change', function() {
			var type = document.getElementById('type');
			type.value = "upAnh";
			document.getElementById('myform').submit();
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