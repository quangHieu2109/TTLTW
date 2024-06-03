<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">

<head>
  <fmt:setLocale value="vi_VN" />
  <c:if test="${sessionScope.lang!=null&&sessionScope.lang=='en'}">
    <fmt:setLocale value="en_US" />
  </c:if>
  <fmt:setBundle basename="lang" />
  <jsp:include page="_meta.jsp"/>
  <title><fmt:message key="them_san_pham"/></title>
  <style>
    .w-maxcontent{
      width: max-content;
    }
    .ml-0{
      width: 20%;
      margin-left: 0;
    }
  .ml-20px{
    margin-left: 20px;
  }
  </style>
</head>

<body>
<jsp:include page="_headerAdmin.jsp"/>

<section class="section-content">
  <div class="container">
    <header class="section-heading py-4">
      <h3 class="section-title"><fmt:message key="them_san_pham"/></h3>
    </header> <!-- section-heading.// -->

    <main class="row mb-5">
      <form class="col-lg-9 m-auto" method="POST" action="${pageContext.request.contextPath}/createVoucherSevlet"
            enctype="multipart/form-data" id="my_form">
        <c:if test="${not empty requestScope.successMessage}">
          <div class="alert alert-success mb-3" role="alert">
              ${requestScope.successMessage}
          </div>
        </c:if>
        <c:if test="${not empty requestScope.errorMessage}">
          <div class="alert alert-danger mb-3" role="alert">
              ${requestScope.errorMessage}
          </div>
        </c:if>
        <div class="mb-3">
          <label for="voucher-name" class="form-label">Tên voucher <span class="text-danger">*</span></label>
            <label class="form-label" id="voucher-name_error"></label>
            <input type="text"
                 class="form-control "
                 id="voucher-name"
                 name="voucherName"
                 required>
        </div>
        <div class="mb-3">
          <label for="voucher-code" class="form-label">Mã voucher <span class="text-danger">*</span></label>
          <label class="form-label text-danger" id="voucher-code_error"></label>
          <div class="input-group">
                <input type="text"
                   class="form-control "
                   id="voucher-code"
                   name="voucherCode"
                   required>
            <button type="button" class="btn btn-primary" onclick="randomVoucherCode()">Random</button>
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label">Thể loại hàng hóa áp dụng</label>
          <div class="ml-20px">
            <div class="row ">
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="1" id="ctg1">
                <label for="ctg1" class=" w-maxcontent">Sách giáo khoa</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="2" id="ctg2">
                <label for="ctg2" class=" w-maxcontent">Sách khoa học</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="3" id="ctg3">
                <label for="ctg3" class=" w-maxcontent">Truyện tranh</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="4" id="ctg4">
                <label for="ctg4" class=" w-maxcontent">Tiểu thuyết</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="5" id="ctg5">
                <label for="ctg5" class=" w-maxcontent">Truyện ngắn</label>
              </div>
            </div>
            <div class="row ">
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="6" id="ctg6">
                <label for="ctg6" class=" w-maxcontent">Truyện dài</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="7" id="ctg7">
                <label for="ctg7" class=" w-maxcontent">Sách giáo trình</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="8" id="ctg8">
                <label for="ctg8" class=" w-maxcontent">Báo in</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="9" id="ctg9">
                <label for="ctg9" class=" w-maxcontent">Tạp chí</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="10" id="ctg10">
                <label for="ctg10" class=" w-maxcontent">Tập san</label>
              </div>
            </div>
            <div class="row ">
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="11" id="ctg11">
                <label for="ctg11" class=" w-maxcontent">Sách nấu ăn</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="12" id="ctg12">
                <label for="ctg12" class=" w-maxcontent">Sách kỹ thuật</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="13" id="ctg13">
                <label for="ctg13" class=" w-maxcontent">Sách nông nghiệp</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="14" id="ctg14">
                <label for="ctg14" class=" w-maxcontent">Sách thiếu nhi</label>
              </div>
              <div class="row w-maxcontent col-lg-2 ml-0">
                <input type="checkbox" name="categorys" class="form-check w-maxcontent" value="15" id="ctg15">
                <label for="ctg15" class=" w-maxcontent">Sách kỹ năng sống</label>
              </div>
            </div>
          </div>
          </div>

        <div class="mb-3">
          <label class="form-label d-block">Loại Voucher <span class="text-danger">*</span></label>
          <div class="form-check d-inline-block me-4">
            <input class="form-check-input "
                   type="radio"
                   name="typeVoucher"
                   id="ship"
                   value="0" checked
                   required>
            <label class="form-check-label" for="ship">Voucher freeship</label>
          </div>
          <div class="form-check d-inline-block">
            <input class="form-check-input "
                   type="radio"
                   name="typeVoucher"
                   id="shop"
                   value="1"
                   required>
            <label class="form-check-label" for="shop">Voucher shop</label>
          </div>
        </div>
        <div class="mb-3">
          <label for="voucher-description" class="form-label">Mô tả voucher</label>
            <label id="voucher-description_error" class="form-label text-danger"></label>
            <textarea class="form-control "
                    id="voucher-description"
                    rows="10"
                    name="description"></textarea>
        </div>
        <div class="mb-3">
          <label class="form-label text-danger" id="quantity_erro"></label>
          <label for="quantity" class="form-label">Số lượng<span class="text-danger">*</span></label>

            <input type="number"
                   class="form-control "
                   id="quantity"
                   name="quantity"
                   value=""
                   min="0"
                   step="1"
                   required>

        </div>
        <div class="mb-3">
          <label class="form-label text-danger" id="percent-decrease_erro"></label>
          <label for="percent-decrease" class="form-label">Phần trăm giảm <span class="text-danger">*</span></label>
          <div class="input-group ">
            <input type="number"
                   class="form-control "
                   id="percent-decrease"
                   name="percentDecrease"
                   value=""
                   min="0"
                   step="1"
                   required>
            <span class="input-group-text">%</span>
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label text-danger" id="max-decrease_erro"></label>
          <label for="max-decrease" class="form-label">Giảm tối đa <span class="text-danger">*</span></label>
          <div class="input-group ">
            <input type="number"
                   class="form-control "
                   id="max-decrease"
                   name="maxDecrease"
                   value=""
                   min="0"
                   step="1"
                   required>
            <span class="input-group-text">đ</span>
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label text-danger" id="min-price_erro"></label>
          <label for="min-price" class="form-label">Đơn giá tối thiểu<span class="text-danger">*</span></label>
          <div class="input-group ">
            <input type="number"
                   class="form-control "
                   id="min-price"
                   name="minPrice"
                   value=""
                   min="0"
                   step="1"
                   required>
            <span class="input-group-text">đ</span>
          </div>
        </div>

        <div class="mb-3">
          <label for="voucher-imageName" class="form-label">Ảnh voucher</label>
            <label id="voucher-imageName_error" class="form-label text-danger"></label>
            <input type="file"
                 class="form-control"
                 id="voucher-imageName"
                 name="image"
                 accept="image/*">
        </div>


        <div class="mb-3">
          <label for="voucher-startsAt" class="form-label">Ngày bắt đầu</label>
            <label id="voucher-startsAt_error" class="form-label text-danger"></label>
            <input type="datetime-local"
                 class="form-control "
                 id="voucher-startsAt"
                 name="voucherStartsAt"
                 value="">
        </div>
        <div class="mb-3">
          <label for="voucher-endAt" class="form-label">Ngày kết thúc</label>
            <label id="voucher-endAt_error" class="form-label text-danger"></label>
            <input type="datetime-local"
                 class="form-control "
                 id="voucher-endAt"
                 name="voucherEndAt"
            value="">
        </div>
        <button type="submit" class="btn btn-primary me-2 mb-3" id="submit_form">
          <fmt:message key="them"/>
        </button>
        <button type="reset"
                class="btn btn-warning me-2 mb-3"
                onclick="return confirm('Bạn có muốn để giá trị mặc định?')">
          <fmt:message key="mac_dinh"/>
        </button>
        <a class="btn btn-danger mb-3"
           href="${pageContext.request.contextPath}/admin/productManager"
           role="button"
           onclick="return confirm('Bạn có muốn hủy?')">
          <fmt:message key="huy"/>
        </a>
      </form>
    </main>
  </div> <!-- container.// -->
</section> <!-- section-content.// -->
<script src="${pageContext.request.contextPath}/js/voucher.js" type="text/javascript"></script>
<jsp:include page="_footerAdmin.jsp"/>
</body>

</html>
