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
<title><fmt:message>doc_bao</fmt:message></title>
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
	
	<jsp:include page="header.jsp"></jsp:include>
		<c:url var="NewsServlet" value="NewsServlet"></c:url>
	<c:url var="UserServlet" value="UserServlet"></c:url>
	<div class="container">
		<div class="row space  w-80">
			<div class="col-lg-8">
				<div class="dateTime">
					<label>${bao.getNgayDang()}</label>
				</div>
				<div class="title">
					<label>${bao.getTieuDe()}</label>
				</div>
				<div class="descrip">
					<label>${bao.getMoTa()}</label>
				</div>
				<div>
					<img alt="" src="${bao.getFilePath()}" class="card-img">
				</div>
				<div class="content">
					<label>${bao.getNoiDung()}</label>
				</div>
			</div>

			<div class="col-lg-4 ml-5">
				<div class="list-group border sticky">
					<span
						style="font-size: 20px; font-weight: bold; color: #9F224E; padding: 10px"><fmt:message>xem_nhieu</fmt:message></span>
					<c:forEach items="${topView }" var="baoTV">
						<a
							href="${pageContext.request.contextPath}/${NewsServlet}?type=read&maBaiBao=${baoTV.getMaBaiBao() }"
							class="list-group-item">
							<div class="row">
								<div class="col-md-4">
									<img alt="" src="${baoTV.getFilePath() }" class="card-img">
								</div>
								<div class="col-md-8">
									<label class="center">${baoTV.getTieuDe() }</label>
								</div>
							</div>
						</a>
					</c:forEach>

				</div>
			</div>
		</div>
		<div class="row space w-80">
			<div class="col-lg-8">
				<div class="comment">
					<h3><fmt:message>binh_luan</fmt:message></h3>
					<div class="mb-30 ">
						<c:forEach var="cmt" items="${cmts }" begin="0">
							<div class="row  m-5 border">
								<div class="col-lg-2 avt-cmt mtb-10">
									<img alt="" src="${cmt.getNguoiDung().getAvt() }">
								</div>
								<div class="col-lg-10 mtb-10">
									<div class="head-cmt">
										<label class="title-cmt">${cmt.getNguoiDung().getHoVaTen() }</label>
										<label class="date-cmt">${cmt.getNgayBinhLuan() }</label>
									</div>
									<br>
									<p class="content-cmt">${cmt.getNoiDung() }</p>
								</div>
							</div>

						</c:forEach>


					</div>
					<c:if test="${nguoiDung.getTenDangNhap()!=null }">
						<form action="${pageContext.request.contextPath}/${NewsServlet}"
							method="get" id="myform">
							<input type="hidden" name="type" value="cmt"> <input
								type="hidden" name="maBaiBao" value="${bao.getMaBaiBao() }">
							<textarea rows="7" cols="" wrap="soft" name="noiDung"
								id="noiDung"></textarea>
							<button type="button" onclick="submitForm()"><fmt:message>binh_luan</fmt:message></button>
						</form>
					</c:if>
				</div>

			</div>

		</div>

	</div>

	<jsp:include page="footer.jsp"></jsp:include>
	<script type="text/javascript">
		function submitForm() {
			var form = document.getElementById('myform');
			var noiDung = document.getElementById('noiDung').value;

			if (noiDung === "") {
				alert('Bạn chưa nhập nội dung bình luận');
			} else {
				form.submit();
			}

		}
	</script>
</body>
</html>